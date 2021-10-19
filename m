Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D53C432AE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 02:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhJSAGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhJSAF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:05:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE15C06161C;
        Mon, 18 Oct 2021 17:03:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DFB4B1F43440;
        Tue, 19 Oct 2021 01:03:45 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 25/32] fanotify: Report fid entry even for zero-length file_handle
Date:   Mon, 18 Oct 2021 21:00:08 -0300
Message-Id: <20211019000015.1666608-26-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Non-inode errors will reported with an empty file_handle.  In
preparation for that, allow some events to print the FID record even if
there isn't any file_handle encoded

Even though FILEID_ROOT is used internally, make zero-length file
handles be reported as FILEID_INVALID.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify_user.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index ae848306a017..cd962deefeb7 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -339,9 +339,6 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 	pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
 		 __func__, fh_len, name_len, info_len, count);
 
-	if (!fh_len)
-		return 0;
-
 	if (WARN_ON_ONCE(len < sizeof(info) || len > count))
 		return -EFAULT;
 
@@ -376,6 +373,11 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 
 	handle.handle_type = fh->type;
 	handle.handle_bytes = fh_len;
+
+	/* Mangle handle_type for bad file_handle */
+	if (!fh_len)
+		handle.handle_type = FILEID_INVALID;
+
 	if (copy_to_user(buf, &handle, sizeof(handle)))
 		return -EFAULT;
 
-- 
2.33.0

