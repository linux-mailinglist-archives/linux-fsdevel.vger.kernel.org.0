Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C79DAA67B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfICLmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:42:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbfICLmR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:42:17 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04A95811DC
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 11:42:17 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id n3so1100050wmf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 04:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SeZXCfnYvmL3y3gF4qCUZLrYhq10GC1ogANcUKKc3zk=;
        b=J8GDADkBDUswPBrv5ymcInfTBRnz9VmrtaDfuuxauTtCJKCa7xzSLPaCE66wEx+JHF
         u2zG3SlsZ+lypwIFSqMBovdG0KBELWMPaTT8BpOuqzztFxnK4D/ViMtRrH72C4jGgtQe
         EX5BxmwI13Ixaj42aeiYhadBCq5aM7AyYgqEgHWOCO4CWPeBI571OI0s/uYb3g0v/xP9
         NGZZq4yN80gbjwzUxaQHQcOCM52+LiqhiFhxhQTS6MduEmrW7YpJw83hXoYEFQX1c/OF
         mLb5E+WkeiE9HwwOFyiViX1JFyWBrE/FI3CroaIFBVWL9IkwAEbCOKnpcxgTbLoflYki
         Iu6g==
X-Gm-Message-State: APjAAAUHBhkCQ19FwyR+ln5STd7OK8TmPnsz7C0IdRXfbWXrXQgD0EJs
        nYsWcRyjaAwoagIY0kqHAC/A1zmE0YbtZa/siN8PZE/8ba6Y/dFCudtLdsrSKsSPFTvkD5+FwVO
        bMeJhYNVLLLDDDWFbuFf20yJPiA==
X-Received: by 2002:a05:600c:2291:: with SMTP id 17mr20015966wmf.70.1567510935724;
        Tue, 03 Sep 2019 04:42:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwpjkys4EiML6E3To64LiM+3315c/lCCOaiy0eibK4IHfM1xEUpIcGX6kcye/99fsIBFRb8ow==
X-Received: by 2002:a05:600c:2291:: with SMTP id 17mr20015943wmf.70.1567510935555;
        Tue, 03 Sep 2019 04:42:15 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x6sm2087551wmf.38.2019.09.03.04.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:42:15 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 13/16] fuse: dissociate DESTROY from fuseblk
Date:   Tue,  3 Sep 2019 13:42:00 +0200
Message-Id: <20190903114203.8278-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow virtio-fs to also send DESTROY request.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_i.h |  9 +++++++++
 fs/fuse/inode.c  | 12 ++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 700df42520ec..48a3db6870ae 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -555,6 +555,7 @@ struct fuse_fs_context {
 	bool group_id_present:1;
 	bool default_permissions:1;
 	bool allow_other:1;
+	bool destroy:1;
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
@@ -1072,6 +1073,13 @@ void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req);
  */
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx);
 
+/**
+ * Disassociate fuse connection from superblock and kill the superblock
+ *
+ * Calls kill_anon_super(), do not use with bdev mounts.
+ */
+void fuse_kill_sb_anon(struct super_block *sb);
+
 /**
  * Add connection to control filesystem
  */
@@ -1184,5 +1192,6 @@ unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
  * Get the next unique ID for a request
  */
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
+void fuse_free_conn(struct fuse_conn *fc);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index a9e5b106e315..10b777ece3b8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -982,11 +982,12 @@ void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req)
 }
 EXPORT_SYMBOL_GPL(fuse_send_init);
 
-static void fuse_free_conn(struct fuse_conn *fc)
+void fuse_free_conn(struct fuse_conn *fc)
 {
 	WARN_ON(!list_empty(&fc->devices));
 	kfree_rcu(fc, rcu);
 }
+EXPORT_SYMBOL_GPL(fuse_free_conn);
 
 static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 {
@@ -1162,7 +1163,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	/* Root dentry doesn't have .d_revalidate */
 	sb->s_d_op = &fuse_dentry_operations;
 
-	if (ctx->is_bdev) {
+	if (ctx->destroy) {
 		fc->destroy_req = fuse_request_alloc(0);
 		if (!fc->destroy_req)
 			goto err_put_root;
@@ -1291,8 +1292,10 @@ static int fuse_init_fs_context(struct fs_context *fc)
 	ctx->blksize = FUSE_DEFAULT_BLKSIZE;
 
 #ifdef CONFIG_BLOCK
-	if (fc->fs_type == &fuseblk_fs_type)
+	if (fc->fs_type == &fuseblk_fs_type) {
 		ctx->is_bdev = true;
+		ctx->destroy = true;
+	}
 #endif
 
 	fc->fs_private = ctx;
@@ -1316,11 +1319,12 @@ static void fuse_sb_destroy(struct super_block *sb)
 	}
 }
 
-static void fuse_kill_sb_anon(struct super_block *sb)
+void fuse_kill_sb_anon(struct super_block *sb)
 {
 	fuse_sb_destroy(sb);
 	kill_anon_super(sb);
 }
+EXPORT_SYMBOL_GPL(fuse_kill_sb_anon);
 
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
-- 
2.21.0

