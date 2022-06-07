Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148F853FCEF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 13:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242426AbiFGLJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 07:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242605AbiFGLIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:08:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738EC24943
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 04:04:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 15so15251953pfy.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jun 2022 04:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nT1/DTZkyURwfBrQJ6B7R3WRjy+TwzDokAXleailV6M=;
        b=enRJGW35xS14Q6pZW/h7uSv9fQxoUBF8AoCg4wCXMoXsYOK3q4eV36V6xJbUA0luxm
         aF3u8odz2KU8thZT9o0FIXrlDcSY1JuG2BoP9GBwnrSFraHcLuSgTJRk9MbTovsomNY4
         QnHXAdIcbuzGvmMQ64tckCx8Caij7mWn7ekyBKsKKSKye0xZUln12SSQJYMoZhCqPsyj
         xHgG/lSgf0VdnvVpM+k3xLMnMTto57I5TIx/FhIcDvvgtUyeB8AL8nrbAKfEqUh8LHNr
         tqW14rarXUz7IJ74UDVs8uuReedXq1uIpkHZHessE2aONRCqVZ99faUqW+wH7GakTHBH
         rzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nT1/DTZkyURwfBrQJ6B7R3WRjy+TwzDokAXleailV6M=;
        b=BJQbZvzIGgqs5KKe8QmJ3w+I4GOQSb4Y0xs17kwYXaoK5EOFwBoeAsk/Go1jAUXutZ
         rrXpman65Mz/TT4YkoCf0NGvwAMJnBN3GFnIEb8Z7KxklmF0qZ0RZ+tDSrHpbe57NMzs
         4CGij79ZpnJT4LpCzMwEA3TqPiDdVxBbAOWSkUENtHEz1ZtWmtwOtl8ICmyHoInKyOtJ
         KfhEReNxkfBSl7tdUphWBX56aQ8RUQLBaVZFUYUw5Hx2jyp9X7Wrkn76Hc+Ry5b/v5R2
         4n0zV/FYIFlhyvhew4iOQRzPX+hUK37KI+tOMV46hoO2mdIGY7x68axBZVACPX6wLHy/
         BVkw==
X-Gm-Message-State: AOAM533KcvhB0xeCJWBKjqqY4JuWSiloAQR7Pxnh6lI0rzf76H0Qmk8s
        jHfpCBOnF5uVQZNe9Ph1dePDqtlPCJc+LFA=
X-Google-Smtp-Source: ABdhPJyWyPb4WdDwUPnAHAp/KUOL7m1/wf9HkCXlBBLo8xVowIOwvAjf2DCbOPhtXjNGcyTrvR+ZyQ==
X-Received: by 2002:a63:54f:0:b0:3fd:9bbe:a2c3 with SMTP id 76-20020a63054f000000b003fd9bbea2c3mr11023318pgf.5.1654599880923;
        Tue, 07 Jun 2022 04:04:40 -0700 (PDT)
Received: from localhost ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090a178500b001e3937f21absm11889282pja.19.2022.06.07.04.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 04:04:39 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com, stefanha@redhat.com
Cc:     zhangjiachen.jaycee@bytedance.com, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] fuse: allow skipping abort interface for virtiofs
Date:   Tue,  7 Jun 2022 19:05:04 +0800
Message-Id: <20220607110504.198-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
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

The commit 15c8e72e88e0 ("fuse: allow skipping control
interface and forced unmount") tries to remove the control
interface for virtio-fs since it does not support aborting
requests which are being processed. But it doesn't work now.

This commit fixes the bug, but only remove the abort interface
instead since other interfaces should be useful.

Fixes: 15c8e72e88e0 ("fuse: allow skipping control interface and forced unmount")
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/fuse/control.c   | 4 ++--
 fs/fuse/fuse_i.h    | 6 +++---
 fs/fuse/inode.c     | 2 +-
 fs/fuse/virtio_fs.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

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
index 488b460e046f..e29a4e2f2b35 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -507,7 +507,7 @@ struct fuse_fs_context {
 	bool default_permissions:1;
 	bool allow_other:1;
 	bool destroy:1;
-	bool no_control:1;
+	bool no_abort_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
 	enum fuse_dax_mode dax_mode;
@@ -766,8 +766,8 @@ struct fuse_conn {
 	/* Delete dentries that have gone stale */
 	unsigned int delete_stale:1;
 
-	/** Do not create entry in fusectl fs */
-	unsigned int no_control:1;
+	/** Do not create abort entry in fusectl fs */
+	unsigned int no_abort_control:1;
 
 	/** Do not allow MNT_FORCE umount */
 	unsigned int no_force_umount:1;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8c0665c5dff8..02a16cd35f42 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1564,7 +1564,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->legacy_opts_show = ctx->legacy_opts_show;
 	fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
 	fc->destroy = ctx->destroy;
-	fc->no_control = ctx->no_control;
+	fc->no_abort_control = ctx->no_abort_control;
 	fc->no_force_umount = ctx->no_force_umount;
 
 	err = -ENOMEM;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 8db53fa67359..af369bea6dbb 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1287,7 +1287,7 @@ static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *ctx)
 	ctx->max_read = UINT_MAX;
 	ctx->blksize = 512;
 	ctx->destroy = true;
-	ctx->no_control = true;
+	ctx->no_abort_control = true;
 	ctx->no_force_umount = true;
 }
 
-- 
2.20.1

