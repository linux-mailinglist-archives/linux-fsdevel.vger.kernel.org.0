Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6D854C181
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 08:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242728AbiFOF6m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 01:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346078AbiFOF6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:58:32 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56552B263
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 22:58:31 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f8so9523486plo.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 22:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uelhOXddmXEoQef3N3LdCZsevEiHGPA07zUe7LomnLQ=;
        b=U4m1i9387estugei4vWuX2PBcFtpRyK+LjJWrTJzdu1B0Sp8VuUVe/E64M+mhKC5RT
         Erq1iOYDMCd856YgX28eXotPrwPkDRadCD9CQ0s59AARh2kiqgp2hdFxjagn3AvomgHO
         NDJWvI6nddbuJb8/jkALKWO3zuC8xoZU3F1XZic3FU19SQI05kwjUhMZXcpAxwG3AnzW
         vAGLBmJcOb/T0mplivhbofBX2DkY4oAO6UNhvdJ9XkHGCpzEyc0+bM7h2oMU01hL8P6i
         o2ZBvqWVPhOA2MXIweI9SPaUjjUMIahk+ecHqeDaQ1ofRTnwWOno2KFnzrgmksyEwW/3
         xS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uelhOXddmXEoQef3N3LdCZsevEiHGPA07zUe7LomnLQ=;
        b=4rGWBYwe59O8Byqxor/mhVmn7TPNHWbzxA5X50yq2nwFeiVGIE/D7VkyHbx6jCGsJV
         WBLNQ+WL19xrTHM8Qtu31syuBCaqvWbucTHC/LnHU42K4qg5sUxz7tgsapXtudcOvZ+v
         yri50fBN6lbrJLUvcthZfuGUGVbT3HNw78QoKVF1KcUlNthATuPfyS4uyLOrmPxxcj2E
         22YeeRkDBR1DpUH365qZP+tyuuSUNL6gq+1Cedmcnfj34cOkTIVxXZ8LfkLvH55ZsDKM
         C0sa8+dfQRpXiIXeHR4YMvSM0iBsLH/67AVjQjJcOEa3bYDn2NW6aGMCOT8szlOWtg2a
         E/aw==
X-Gm-Message-State: AJIora+RHQo6i+RSPmMtW5epSIlxBNK1mv4S3KL7jcgxB1flTDCYKkFf
        h4hHbdEXoYkVEoHq7E4+0PfBX5id06AFTQ4=
X-Google-Smtp-Source: AGRyM1tNCjyKes5T2voeCo5KH7cHA/tPu++PjleuBKUyPTRE264Y4JSrLeSUSyo+H1wOpWTu48JjHQ==
X-Received: by 2002:a17:90a:450c:b0:1ea:a6b8:7601 with SMTP id u12-20020a17090a450c00b001eaa6b87601mr8387357pjg.205.1655272711455;
        Tue, 14 Jun 2022 22:58:31 -0700 (PDT)
Received: from localhost ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id d10-20020a170903208a00b0015e8d4eb242sm8270371plc.140.2022.06.14.22.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 22:58:29 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com, stefanha@redhat.com
Cc:     zhangjiachen.jaycee@bytedance.com, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 2/2] virtiofs: allow skipping abort interface
Date:   Wed, 15 Jun 2022 13:57:55 +0800
Message-Id: <20220615055755.197-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615055755.197-1-xieyongji@bytedance.com>
References: <20220615055755.197-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Virtio-fs does not support aborting requests which are being
processed. Otherwise, it might trigger UAF since
virtio_fs_request_complete() doesn't know the requests are
aborted. So let's remove the abort interface.

Fixes: 15c8e72e88e0 ("fuse: allow skipping control interface and forced unmount")
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/fuse/control.c   | 4 ++--
 fs/fuse/fuse_i.h    | 4 ++++
 fs/fuse/inode.c     | 1 +
 fs/fuse/virtio_fs.c | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 7cede9a3bc96..d93d8ea3a090 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -272,8 +272,8 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 
 	if (!fuse_ctl_add_dentry(parent, fc, "waiting", S_IFREG | 0400, 1,
 				 NULL, &fuse_ctl_waiting_ops) ||
-	    !fuse_ctl_add_dentry(parent, fc, "abort", S_IFREG | 0200, 1,
-				 NULL, &fuse_ctl_abort_ops) ||
+	    (!fc->no_abort_control && !fuse_ctl_add_dentry(parent, fc, "abort",
+			S_IFREG | 0200, 1, NULL, &fuse_ctl_abort_ops)) ||
 	    !fuse_ctl_add_dentry(parent, fc, "max_background", S_IFREG | 0600,
 				 1, NULL, &fuse_conn_max_background_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index a47f14d0ee3f..e29a4e2f2b35 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -507,6 +507,7 @@ struct fuse_fs_context {
 	bool default_permissions:1;
 	bool allow_other:1;
 	bool destroy:1;
+	bool no_abort_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
 	enum fuse_dax_mode dax_mode;
@@ -765,6 +766,9 @@ struct fuse_conn {
 	/* Delete dentries that have gone stale */
 	unsigned int delete_stale:1;
 
+	/** Do not create abort entry in fusectl fs */
+	unsigned int no_abort_control:1;
+
 	/** Do not allow MNT_FORCE umount */
 	unsigned int no_force_umount:1;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 4059c6898e08..02a16cd35f42 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1564,6 +1564,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->legacy_opts_show = ctx->legacy_opts_show;
 	fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
 	fc->destroy = ctx->destroy;
+	fc->no_abort_control = ctx->no_abort_control;
 	fc->no_force_umount = ctx->no_force_umount;
 
 	err = -ENOMEM;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 24bcf4dbca2a..af369bea6dbb 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1287,6 +1287,7 @@ static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *ctx)
 	ctx->max_read = UINT_MAX;
 	ctx->blksize = 512;
 	ctx->destroy = true;
+	ctx->no_abort_control = true;
 	ctx->no_force_umount = true;
 }
 
-- 
2.20.1

