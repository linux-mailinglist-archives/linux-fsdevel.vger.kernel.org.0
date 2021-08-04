Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A744D3E0568
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 18:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhHDQHl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 12:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhHDQHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:07:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13196C0613D5;
        Wed,  4 Aug 2021 09:07:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id AB48E1F4366A
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v5 14/23] fanotify: Encode invalid file handler when no inode is provided
Date:   Wed,  4 Aug 2021 12:06:03 -0400
Message-Id: <20210804160612.3575505-15-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804160612.3575505-1-krisman@collabora.com>
References: <20210804160612.3575505-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of failing, encode an invalid file handler in fanotify_encode_fh
if no inode is provided.  This bogus file handler will be reported by
FAN_FS_ERROR for non-inode errors.

Also adjust the single caller that might rely on failure after passing
an empty inode.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c | 39 ++++++++++++++++++++---------------
 fs/notify/fanotify/fanotify.h |  6 ++++--
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 0d6ba218bc01..456c60107d88 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -349,12 +349,6 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	void *buf = fh->buf;
 	int err;
 
-	fh->type = FILEID_ROOT;
-	fh->len = 0;
-	fh->flags = 0;
-	if (!inode)
-		return 0;
-
 	/*
 	 * !gpf means preallocated variable size fh, but fh_len could
 	 * be zero in that case if encoding fh len failed.
@@ -363,8 +357,9 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	if (fh_len < 4 || WARN_ON_ONCE(fh_len % 4))
 		goto out_err;
 
-	/* No external buffer in a variable size allocated fh */
-	if (gfp && fh_len > FANOTIFY_INLINE_FH_LEN) {
+	fh->flags = 0;
+	/* No external buffer in a variable size allocated fh or null fh */
+	if (inode && gfp && fh_len > FANOTIFY_INLINE_FH_LEN) {
 		/* Treat failure to allocate fh as failure to encode fh */
 		err = -ENOMEM;
 		ext_buf = kmalloc(fh_len, gfp);
@@ -376,14 +371,24 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 		fh->flags |= FANOTIFY_FH_FLAG_EXT_BUF;
 	}
 
-	dwords = fh_len >> 2;
-	type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
-	err = -EINVAL;
-	if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
-		goto out_err;
-
-	fh->type = type;
-	fh->len = fh_len;
+	if (inode) {
+		dwords = fh_len >> 2;
+		type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
+		err = -EINVAL;
+		if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
+			goto out_err;
+		fh->type = type;
+		fh->len = fh_len;
+	} else {
+		/*
+		 * Invalid FHs are used on FAN_FS_ERROR for errors not
+		 * linked to any inode. Caller needs to guarantee the fh
+		 * has at least FANOTIFY_NULL_FH_LEN bytes of space.
+		 */
+		fh->type = FILEID_INVALID;
+		fh->len = FANOTIFY_NULL_FH_LEN;
+		memset(buf, 0, FANOTIFY_NULL_FH_LEN);
+	}
 
 	/*
 	 * Mix fh into event merge key.  Hash might be NULL in case of
@@ -511,7 +516,7 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 	struct fanotify_info *info;
 	struct fanotify_fh *dfh, *ffh;
 	unsigned int dir_fh_len = fanotify_encode_fh_len(id);
-	unsigned int child_fh_len = fanotify_encode_fh_len(child);
+	unsigned int child_fh_len = child ? fanotify_encode_fh_len(child) : 0;
 	unsigned int size;
 
 	size = sizeof(*fne) + FANOTIFY_FH_HDR_LEN + dir_fh_len;
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 8061040f0348..aa555975c0f8 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -349,18 +349,20 @@ static inline unsigned int fanotify_event_hash_bucket(
 	return event->hash & FANOTIFY_HTABLE_MASK;
 }
 
+#define FANOTIFY_NULL_FH_LEN	8
+
 /*
  * Check size needed to encode fanotify_fh.
  *
  * Return size of encoded fh without fanotify_fh header.
- * Return 0 on failure to encode.
+ * For a NULL inode, return the size of a NULL FH.
  */
 static inline int fanotify_encode_fh_len(struct inode *inode)
 {
 	int dwords = 0;
 
 	if (!inode)
-		return 0;
+		return FANOTIFY_NULL_FH_LEN;
 
 	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
 
-- 
2.32.0

