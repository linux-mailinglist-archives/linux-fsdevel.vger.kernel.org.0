Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B0C3EAC9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbhHLVln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 17:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhHLVll (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:41:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1F8C061756;
        Thu, 12 Aug 2021 14:41:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 24ACE1F41890
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, khazhy@google.com,
        dhowells@redhat.com, david@fromorbit.com, tytso@mit.edu,
        djwong@kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 12/21] fanotify: Encode invalid file handle when no inode is provided
Date:   Thu, 12 Aug 2021 17:40:01 -0400
Message-Id: <20210812214010.3197279-13-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812214010.3197279-1-krisman@collabora.com>
References: <20210812214010.3197279-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of failing, encode an invalid file handle in fanotify_encode_fh
if no inode is provided.  This bogus file handle will be reported by
FAN_FS_ERROR for non-inode errors.

When being reported to userspace, the length information is actually
reset and the handle cleaned up, such that userspace don't have the
visibility of the internal kernel representation of this null handle.

Also adjust the single caller that might rely on failure after passing
an empty inode.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v5:
  - Preserve flags initialization (jan)
  - Add BUILD_BUG_ON (amir)
  - Require minimum of FANOTIFY_NULL_FH_LEN for fh_len(amir)
  - Improve comment to explain the null FH length (jan)
  - Simplify logic
---
 fs/notify/fanotify/fanotify.c      | 27 ++++++++++++++++++-----
 fs/notify/fanotify/fanotify_user.c | 35 +++++++++++++++++-------------
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 50fce4fec0d6..2b1ab031fbe5 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -334,6 +334,8 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	return test_mask & user_mask;
 }
 
+#define FANOTIFY_NULL_FH_LEN	4
+
 /*
  * Check size needed to encode fanotify_fh.
  *
@@ -345,7 +347,7 @@ static int fanotify_encode_fh_len(struct inode *inode)
 	int dwords = 0;
 
 	if (!inode)
-		return 0;
+		return FANOTIFY_NULL_FH_LEN;
 
 	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
 
@@ -367,11 +369,23 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	void *buf = fh->buf;
 	int err;
 
-	fh->type = FILEID_ROOT;
-	fh->len = 0;
+	BUILD_BUG_ON(FANOTIFY_NULL_FH_LEN < 4 ||
+		     FANOTIFY_NULL_FH_LEN > FANOTIFY_INLINE_FH_LEN);
+
 	fh->flags = 0;
-	if (!inode)
-		return 0;
+
+	if (!inode) {
+		/*
+		 * Invalid FHs are used on FAN_FS_ERROR for errors not
+		 * linked to any inode. The f_handle won't be reported
+		 * back to userspace.  The extra bytes are cleared prior
+		 * to reporting.
+		 */
+		type = FILEID_INVALID;
+		fh_len = FANOTIFY_NULL_FH_LEN;
+
+		goto success;
+	}
 
 	/*
 	 * !gpf means preallocated variable size fh, but fh_len could
@@ -400,6 +414,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
 		goto out_err;
 
+success:
 	fh->type = type;
 	fh->len = fh_len;
 
@@ -529,7 +544,7 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 	struct fanotify_info *info;
 	struct fanotify_fh *dfh, *ffh;
 	unsigned int dir_fh_len = fanotify_encode_fh_len(id);
-	unsigned int child_fh_len = fanotify_encode_fh_len(child);
+	unsigned int child_fh_len = child ? fanotify_encode_fh_len(child) : 0;
 	unsigned int size;
 
 	size = sizeof(*fne) + FANOTIFY_FH_HDR_LEN + dir_fh_len;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index c47a5a45c0d3..4cacea5fcaca 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -360,7 +360,10 @@ static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 		return -EFAULT;
 
 	handle.handle_type = fh->type;
-	handle.handle_bytes = fh_len;
+
+	/* FILEID_INVALID handle type is reported without its f_handle. */
+	if (fh->type != FILEID_INVALID)
+		handle.handle_bytes = fh_len;
 	if (copy_to_user(buf, &handle, sizeof(handle)))
 		return -EFAULT;
 
@@ -369,20 +372,22 @@ static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 	if (WARN_ON_ONCE(len < fh_len))
 		return -EFAULT;
 
-	/*
-	 * For an inline fh and inline file name, copy through stack to exclude
-	 * the copy from usercopy hardening protections.
-	 */
-	fh_buf = fanotify_fh_buf(fh);
-	if (fh_len <= FANOTIFY_INLINE_FH_LEN) {
-		memcpy(bounce, fh_buf, fh_len);
-		fh_buf = bounce;
+	if (fh->type != FILEID_INVALID) {
+		/*
+		 * For an inline fh and inline file name, copy through
+		 * stack to exclude the copy from usercopy hardening
+		 * protections.
+		 */
+		fh_buf = fanotify_fh_buf(fh);
+		if (fh_len <= FANOTIFY_INLINE_FH_LEN) {
+			memcpy(bounce, fh_buf, fh_len);
+			fh_buf = bounce;
+		}
+		if (copy_to_user(buf, fh_buf, fh_len))
+			return -EFAULT;
+		buf += fh_len;
+		len -= fh_len;
 	}
-	if (copy_to_user(buf, fh_buf, fh_len))
-		return -EFAULT;
-
-	buf += fh_len;
-	len -= fh_len;
 
 	if (name_len) {
 		/* Copy the filename with terminating null */
@@ -398,7 +403,7 @@ static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 	}
 
 	/* Pad with 0's */
-	WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);
+	WARN_ON_ONCE(len < 0);
 	if (len > 0 && clear_user(buf, len))
 		return -EFAULT;
 
-- 
2.32.0

