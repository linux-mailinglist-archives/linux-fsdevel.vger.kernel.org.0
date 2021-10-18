Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FD6432AC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 02:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhJSAEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:04:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40832 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbhJSAEf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:04:35 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CB0671F411B7;
        Tue, 19 Oct 2021 01:02:21 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v8 15/32] fanotify: Encode empty file handle when no inode is provided
Date:   Mon, 18 Oct 2021 20:59:58 -0300
Message-Id: <20211019000015.1666608-16-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of failing, encode an invalid file handle in fanotify_encode_fh
if no inode is provided.  This bogus file handle will be reported by
FAN_FS_ERROR for non-inode errors.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v6:
  - Use FILEID_ROOT as the internal value (jan)
  - Create an empty FH (jan)

Changes since v5:
  - Preserve flags initialization (jan)
  - Add BUILD_BUG_ON (amir)
  - Require minimum of FANOTIFY_NULL_FH_LEN for fh_len(amir)
  - Improve comment to explain the null FH length (jan)
  - Simplify logic
---
 fs/notify/fanotify/fanotify.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index ec84fee7ad01..c64d61b673ca 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -370,8 +370,14 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	fh->type = FILEID_ROOT;
 	fh->len = 0;
 	fh->flags = 0;
+
+	/*
+	 * Invalid FHs are used by FAN_FS_ERROR for errors not
+	 * linked to any inode. The f_handle won't be reported
+	 * back to userspace.
+	 */
 	if (!inode)
-		return 0;
+		goto out;
 
 	/*
 	 * !gpf means preallocated variable size fh, but fh_len could
@@ -403,6 +409,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	fh->type = type;
 	fh->len = fh_len;
 
+out:
 	/*
 	 * Mix fh into event merge key.  Hash might be NULL in case of
 	 * unhashed FID events (i.e. FAN_FS_ERROR).
-- 
2.33.0

