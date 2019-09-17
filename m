Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3BEB5641
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 21:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfIQTgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 15:36:13 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:36294 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfIQTgK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 15:36:10 -0400
Received: by mail-pf1-f202.google.com with SMTP id 194so3169762pfu.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2019 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2NRtuvKbt7hoCUKdcO2DQz0SKjqBn1iBiRT69g1zRIM=;
        b=lz74ltziFu7N9FdWM2Wk+leFwy2lbrUMLopHSlydWLgsiEG7PXi/086swTVSMcdu5F
         r1nmdQsBiezhx7jBZb+kdnZp8YDjEAGrkuT+/hvcAp4MSxy7SWFBXkGGTQT9O0Ii7+Sc
         4ThlfTDBVQQ0JJvS/kiOG3AJzgeQw78nnQaYieDZ7ReIyQ8+SkCI4VzHcDWJu7jTLK/5
         wkAmi2Qexp0DuMjJROd05a/tqULAtaLuOelQmiYHx/vbYFg6DszOY4lrSNW2G/T3JLri
         Z8izXlv+5yWGFc0/9APv/DPwvXPXZbBv9IczXa6UGUhkApS6XEY+2LrYBPoFyFcexGvJ
         kmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2NRtuvKbt7hoCUKdcO2DQz0SKjqBn1iBiRT69g1zRIM=;
        b=r93CmCSZXRU9sxV2fw8D5p2bzjq1BvetNoi3GSJJNV8xSLJjG0d8T5/AXzHP/C2Pf1
         oHqFbSHUV96/reAqQoHMNWVVngPO/eAN6HqbJoIRGgcQ5lezBB7EZOmKlQ+6FDj8B8ea
         3BrMZTUM29x3lZaZTywDaZid2jyiY1qAu8MHRVoxwI4LTfO1k2wcXLs6Hga4rMzkGfEj
         iAcOTiEgujbKUkwD9L9BLUkrqjWVv5LTFInQIF9J8PIFz6bcGteKm7lsIESPP5q9Jhx1
         BJFd2cUZL0LJkBIbIjuqVWyZdE0qhFVhDoMMss15994OYwDWOMGlAMAW40t9e58CKC1j
         wuSw==
X-Gm-Message-State: APjAAAUMFqu37YAKhnynDspg2FZuJwhOtLTwmSClwc2fjWZAyWKVSvOB
        FbtcR91MgKLMsiP431MBfxaqilvUHQA=
X-Google-Smtp-Source: APXvYqwiWxhxuJwyT4PvGNQH+mApcPQsn3EAU6pp2NpiIIv9fUdf+EdNR0rdJjGoFbPDAc3b1T/Z8kMSwOk=
X-Received: by 2002:a65:6901:: with SMTP id s1mr472083pgq.338.1568748967798;
 Tue, 17 Sep 2019 12:36:07 -0700 (PDT)
Date:   Tue, 17 Sep 2019 12:35:33 -0700
In-Reply-To: <CACGdZY+iviCmTc1fQriWSBbxhywGiFj1+f6RJ1AXpE6i=O_i-w@mail.gmail.com>
Message-Id: <20190917193533.34984-1-khazhy@google.com>
Mime-Version: 1.0
References: <CACGdZY+iviCmTc1fQriWSBbxhywGiFj1+f6RJ1AXpE6i=O_i-w@mail.gmail.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH v4] fuse: kmemcg account fs data
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

Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/fuse/dir.c   | 3 ++-
 fs/fuse/file.c  | 5 +++--
 fs/fuse/inode.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

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
index 8c7578b95d2c..0f0225686aee 100644
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
index 3d598a5bb5b5..e040e2a2b621 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -66,7 +66,7 @@ static struct file_system_type fuseblk_fs_type;
 
 struct fuse_forget_link *fuse_alloc_forget(void)
 {
-	return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL);
+	return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL_ACCOUNT);
 }
 
 static struct inode *fuse_alloc_inode(struct super_block *sb)
-- 
2.23.0.237.gc6a4ce50a0-goog

