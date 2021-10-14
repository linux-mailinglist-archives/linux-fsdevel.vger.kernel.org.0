Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988F542E383
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 23:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbhJNVkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 17:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhJNVks (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:40:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85917C061570;
        Thu, 14 Oct 2021 14:38:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AF0801F44F83;
        Thu, 14 Oct 2021 22:38:35 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        repnop@google.com, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v7 14/28] fanotify: Encode empty file handle when no inode is provided
Date:   Thu, 14 Oct 2021 18:36:32 -0300
Message-Id: <20211014213646.1139469-15-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014213646.1139469-1-krisman@collabora.com>
References: <20211014213646.1139469-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of failing, encode an invalid file handle in fanotify_encode_fh
if no inode is provided.  This bogus file handle will be reported by
FAN_FS_ERROR for non-inode errors.

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

