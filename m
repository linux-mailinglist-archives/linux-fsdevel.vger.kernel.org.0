Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C399B44BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 01:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfIPX44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 19:56:56 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:51303 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbfIPX44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:56:56 -0400
Received: by mail-qt1-f202.google.com with SMTP id e13so1450911qto.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2019 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bJmZANwzCFV2Iqz4LhMyBOSdTmADhZHqEPwCse8wah0=;
        b=sUGJYOj1o9xCwXnv4wc+rHf8HlX3D1AlYIvZvyfihO9GHGvXi79ynXEVh/2RhqczAz
         W+684pXzoiyFxTsRk9OmIKGhzVP04cxmhPod4hK6vh/4Y6ekcZzsm0U+/20KsWPN+XE7
         /fXzxWAz8FiAfivCllUrUfspG4b1EtSjjNZ+pYwcsJLvU4Vip/1+kehaDdo13Zyjiqut
         aaK9e8E8fR3smRXhz9TtmNYk9W9VrGnNqpOjZPlcM2GH1ylMQYyzoxrB0lGaWQ8fwGSu
         UiEMQZh272qaXObuaGLMxfyS3y1staHLcfHBXQYkTatdxKpnVEdSJijAeHe8G9DZw6bN
         JK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bJmZANwzCFV2Iqz4LhMyBOSdTmADhZHqEPwCse8wah0=;
        b=SSaJfWLwJkpK6kvMS4XV91P6Hxa9FuclyF1QSZnZKn7DNXcine3HhTy52jZVLw35eo
         mFcxDHxMyGpKVqz/N3G3biow/h0JD69+qkPohPqzd0w0MyDRxwW1Z5ZoJ9CjA6hqL8Aq
         9YeLu2VY7CatC5DCLHRbjGV9jE0SnhExadQSE2hA26+AMOgXlwjTXKDdYRAYW+BvcAJc
         hdkJPViVem4+vamyFjULWzczB+G3FOxh7m2W1UWsMVhNZroltg75o7qhb6uncsHubdKG
         Q6o+T32UIgKgaacuSKCTZYQGw1tsjcmidm+vpGnbtJHhT2aZ3NZmyk+9ZcoMwPvd0772
         wRJg==
X-Gm-Message-State: APjAAAWbRE0yRFd7yCgbu6OXPnfhihN/LfR1o7vlfdmBKR2sFIqYmcYl
        2Ucvh30KH6LzO2BClET8iD80bCzfNrU=
X-Google-Smtp-Source: APXvYqwcRpAFsOLDZFs5gKrwwLxNf7Ug2TgXqFTU+omF07IxxIzz4SMFzPqGErLVhC+LGxmgdbZpsHquImU=
X-Received: by 2002:aed:3c52:: with SMTP id u18mr1080316qte.194.1568678215490;
 Mon, 16 Sep 2019 16:56:55 -0700 (PDT)
Date:   Mon, 16 Sep 2019 16:56:42 -0700
In-Reply-To: <20190916235642.167583-1-khazhy@google.com>
Message-Id: <20190916235642.167583-2-khazhy@google.com>
Mime-Version: 1.0
References: <20190916235642.167583-1-khazhy@google.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH v3 2/2] fuse: kmemcg account fs data
From:   Khazhismel Kumykov <khazhy@google.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shakeelb@google.com, Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

account per-file, dentry, and inode data

blockdev/superblock and temporary per-request data was left alone, as
this usually isn't accounted

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 fs/fuse/dir.c   | 3 ++-
 fs/fuse/file.c  | 5 +++--
 fs/fuse/inode.c | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 58557d4817e9..d572c900bb0f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -279,7 +279,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 #if BITS_PER_LONG < 64
 static int fuse_dentry_init(struct dentry *dentry)
 {
-	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry), GFP_KERNEL);
+	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry),
+				   GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
 
 	return dentry->d_fsdata ? 0 : -ENOMEM;
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a2ea347c4d2c..862aff3665b5 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -63,12 +63,13 @@ struct fuse_file *fuse_file_alloc(struct fuse_conn *fc)
 {
 	struct fuse_file *ff;
 
-	ff = kzalloc(sizeof(struct fuse_file), GFP_KERNEL);
+	ff = kzalloc(sizeof(struct fuse_file), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!ff))
 		return NULL;
 
 	ff->fc = fc;
-	ff->release_args = kzalloc(sizeof(*ff->release_args), GFP_KERNEL);
+	ff->release_args = kzalloc(sizeof(*ff->release_args),
+				   GFP_KERNEL_ACCOUNT);
 	if (!ff->release_args) {
 		kfree(ff);
 		return NULL;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3d598a5bb5b5..6cb445bed89d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -66,7 +66,8 @@ static struct file_system_type fuseblk_fs_type;
 
 struct fuse_forget_link *fuse_alloc_forget(void)
 {
-	return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL);
+	return kzalloc(sizeof(struct fuse_forget_link),
+		       GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
 }
 
 static struct inode *fuse_alloc_inode(struct super_block *sb)
-- 
2.23.0.237.gc6a4ce50a0-goog

