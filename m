Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9D19A09B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 22:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbfHVUAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 16:00:41 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:49664 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389548AbfHVUAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:00:40 -0400
Received: by mail-pl1-f201.google.com with SMTP id b30so4246498pla.16
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hVGwk6YhjI455Ut1v3y6cxlNJxNjb6ZkPTuggdcePUs=;
        b=JYYseZMPlM5r1PVnnewPA9qXVNjOEjiBT5JavOaz5iOKpvPti+BzosvwyA1hobwO/O
         w9LDFjs+b4zvgKL4URYTM7g3/yJqpdb75LKM1xpEfXjoY1Xg8Rbv0yP8clb5B5Lf0drd
         Q7xnT5p4+v2P3wBOVqhkeWqS3qbhRCPQUEbXfqrIhwIm83mlGIiC1AyHxS8145DgeGuZ
         ppn9gM21p4S2MX0ZE8ifWvgbLsB6JmPrpr3WYQeX4MZA1zvfw0Jvpmrmz2BDxRqUfyYb
         vY0RPenIjucOwQJMh8uqYtuSGszsLyBFcBMtTvlJRK82LomjEjV+0bJV7pg0YfSbyKIC
         Yaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hVGwk6YhjI455Ut1v3y6cxlNJxNjb6ZkPTuggdcePUs=;
        b=VdCXMty+TaETbf5QHBjpvSHqum1YHWIE9Q8vO5Ox8v69ioifXLVoVD/c/n/76bBG+b
         anXgLubKq9oai3lRyGRLfqem+FHCNESROhL3g7azin3IVtZEvpB0jhQVXKkPeO2aLBii
         Fz2S52ycGuvZ2ZLdErIk5dcBLsoQHKWNhkR7sFQJTntQNKvzeBM/f0+wQ05d0a97rMuI
         mb/ECEM26Wun5lCfDJAh5EaC1cr0zUd743TyU5cE94Os8hlEGG+mTvcQ4IM2jyzA8yxd
         gqPMm1cFa7xeUCmRZMHG8wOT/Cl+snkzmUPuSOSysx+/TI2lEbBHMWIWeTYkSQhm2AnZ
         8fpQ==
X-Gm-Message-State: APjAAAU3Va/eUiuHWVGPrB1Qco0coDwc4e7xoob74bxULN/s2OsHFKhk
        HwyiXxyKxlugOF9Xys6WYKTkn4ioG1c=
X-Google-Smtp-Source: APXvYqyt7na1QkfBgKdb+30wpsC1mwNBkmXqnLJjgl7dGFiw5WlLWG1hwqPw3fp+52MZwqCdr5Tf1gUluwY=
X-Received: by 2002:a63:f13:: with SMTP id e19mr837076pgl.132.1566504039792;
 Thu, 22 Aug 2019 13:00:39 -0700 (PDT)
Date:   Thu, 22 Aug 2019 13:00:30 -0700
In-Reply-To: <20190822200030.141272-1-khazhy@google.com>
Message-Id: <20190822200030.141272-3-khazhy@google.com>
Mime-Version: 1.0
References: <20190822200030.141272-1-khazhy@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 3/3] fuse: kmemcg account fs data
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

accounts the per-file reserved request, adding new
fuse_request_alloc_account()

blockdev/superblock and temporary per-request data was left alone, as
this usually isn't accounted

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/fuse/dir.c   | 3 ++-
 fs/fuse/file.c  | 4 ++--
 fs/fuse/inode.c | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f9c59a296568..2013e1222de7 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -258,7 +258,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 #if BITS_PER_LONG < 64
 static int fuse_dentry_init(struct dentry *dentry)
 {
-	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry), GFP_KERNEL);
+	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry),
+				   GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
 
 	return dentry->d_fsdata ? 0 : -ENOMEM;
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 572d8347ebcb..ae8c8016bb8e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -45,12 +45,12 @@ struct fuse_file *fuse_file_alloc(struct fuse_conn *fc)
 {
 	struct fuse_file *ff;
 
-	ff = kzalloc(sizeof(struct fuse_file), GFP_KERNEL);
+	ff = kzalloc(sizeof(struct fuse_file), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!ff))
 		return NULL;
 
 	ff->fc = fc;
-	ff->reserved_req = fuse_request_alloc(0, GFP_KERNEL);
+	ff->reserved_req = fuse_request_alloc(0, GFP_KERNEL_ACCOUNT);
 	if (unlikely(!ff->reserved_req)) {
 		kfree(ff);
 		return NULL;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 5afd1872b8b1..ad92e93eaddd 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -76,7 +76,8 @@ struct fuse_mount_data {
 
 struct fuse_forget_link *fuse_alloc_forget(void)
 {
-	return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL);
+	return kzalloc(sizeof(struct fuse_forget_link),
+		       GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
 }
 
 static struct inode *fuse_alloc_inode(struct super_block *sb)
-- 
2.23.0.187.g17f5b7556c-goog

