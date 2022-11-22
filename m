Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81347633330
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 03:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiKVCUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 21:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiKVCTm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:19:42 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367DBE9151
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:44 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h16-20020a255f50000000b006e880b47e6fso9683255ybm.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJXvhRhAgfuVfe2WyHPR4tz1JKdoKAJyNeGFfWGwJfA=;
        b=qGkvx8TFpzkUW6hJpxPR4PKq3xLOu9Os7QX2lTMWCilalOFz9Xa1h5bFbtSpucKkWm
         TltFT8llXWJ7GhU2/JCvGPxUKKyf+M5vl3oAklLsvD1oxP8MTw156iiPERz5BlwYWBaw
         /Aotf3Al2u6liOXujyYy4ynyF1St9jqgbgFkLtP2NvI1Bj6udJvaG0Xmp52Kx7gzMg1Z
         adtT/ZnVZK6ZkF1A3IJqIRE5Nn89VCvBJgCK2auE41NBM56Tw2QLxlXT3TEm6s4rCvbA
         y+aBIj+GuWxJUkSGWY++ynL0CiCHeRY6X5vmgLh4cigCoA8tF6uoSbhGFr6AmKQfLhY7
         hKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJXvhRhAgfuVfe2WyHPR4tz1JKdoKAJyNeGFfWGwJfA=;
        b=OK9OaIfI+PmQCM/jnC6G+kQw5+LLx4aApWHpDv/uxrvEDlDXOsbdsccqDWVAJvunzc
         E3qAwW4Z0xiqEH/IyyzM3uSHqiufzpulIzm1Zp9lIdbi6Ao6uqC/Sfp9BTFf2bOTIX1E
         x4gwlYIuvs8B4iq8bI1Zyzf6m+9NFPWEJ+U8EzGoUUB+9EbSQtZR9B2DLnGMWmbZFeE9
         8TF1M+wE3nZPmbFII16m8XrWHDzPe9ZI7rkNiTHAe+230uu4dcHFCb6IVrPrtnOK6k1S
         4G+5zFASdEC2hBqiymp59XDwYHGfRMOjY1SZr4h7QaivA+wjvCNE61pU9/AgwXUpLFSE
         sBWw==
X-Gm-Message-State: ANoB5pnpIPbbSt7AlhuFeZL65IFJlsgM5kS2fnHErDQXRYFfqzdmCeO/
        wu3DqjpxUwhID+dkHon9lEfoXn/15gs=
X-Google-Smtp-Source: AA0mqf4ig5LKUxIEPBtpsrsS6x8pF+5RIGhWCLARqw1OqEfhOKW0oTQ5XDVHBGd5PrVtKUOP4DD+H6Fg8PM=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a25:bd03:0:b0:6e6:9336:f565 with SMTP id
 f3-20020a25bd03000000b006e69336f565mr0ybk.598.1669083402808; Mon, 21 Nov 2022
 18:16:42 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:36 -0800
In-Reply-To: <20221122021536.1629178-1-drosen@google.com>
Mime-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-22-drosen@google.com>
Subject: [RFC PATCH v2 21/21] fuse-bpf: allow mounting with no userspace daemon
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When using fuse-bpf in pure passthrough mode, we don't explicitly need a
userspace daemon. This allows simple testing of the backing operations.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/fuse_i.h |  4 ++++
 fs/fuse/inode.c  | 25 +++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 99c9231ec98b..402d80d35958 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -564,6 +564,7 @@ struct fuse_fs_context {
 	bool no_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
+	bool no_daemon:1;
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
@@ -842,6 +843,9 @@ struct fuse_conn {
 	/* Is tmpfile not implemented by fs? */
 	unsigned int no_tmpfile:1;
 
+	/** BPF Only, no Daemon running */
+	unsigned int no_daemon:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1e7d45977144..4820edcc242a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -749,6 +749,7 @@ enum {
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
 	OPT_ROOT_DIR,
+	OPT_NO_DAEMON,
 	OPT_ERR
 };
 
@@ -764,6 +765,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
 	fsparam_u32	("root_dir",		OPT_ROOT_DIR),
+	fsparam_flag	("no_daemon",		OPT_NO_DAEMON),
 	{}
 };
 
@@ -853,6 +855,11 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 			return invalfc(fsc, "Unable to open root directory");
 		break;
 
+	case OPT_NO_DAEMON:
+		ctx->no_daemon = true;
+		ctx->fd_present = true;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -1411,7 +1418,7 @@ void fuse_send_init(struct fuse_mount *fm)
 	ia->args.nocreds = true;
 	ia->args.end = process_init_reply;
 
-	if (fuse_simple_background(fm, &ia->args, GFP_KERNEL) != 0)
+	if (unlikely(fm->fc->no_daemon) || fuse_simple_background(fm, &ia->args, GFP_KERNEL) != 0)
 		process_init_reply(fm, &ia->args, -ENOTCONN);
 }
 EXPORT_SYMBOL_GPL(fuse_send_init);
@@ -1693,6 +1700,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
+	fc->no_daemon = ctx->no_daemon;
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode, ctx->root_dir);
@@ -1739,7 +1747,7 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	struct fuse_fs_context *ctx = fsc->fs_private;
 	int err;
 
-	if (!ctx->file || !ctx->rootmode_present ||
+	if (!!ctx->file == ctx->no_daemon || !ctx->rootmode_present ||
 	    !ctx->user_id_present || !ctx->group_id_present)
 		return -EINVAL;
 
@@ -1747,10 +1755,12 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	 * Require mount to happen from the same user namespace which
 	 * opened /dev/fuse to prevent potential attacks.
 	 */
-	if ((ctx->file->f_op != &fuse_dev_operations) ||
-	    (ctx->file->f_cred->user_ns != sb->s_user_ns))
-		return -EINVAL;
-	ctx->fudptr = &ctx->file->private_data;
+	if (ctx->file) {
+		if ((ctx->file->f_op != &fuse_dev_operations) ||
+		    (ctx->file->f_cred->user_ns != sb->s_user_ns))
+			return -EINVAL;
+		ctx->fudptr = &ctx->file->private_data;
+	}
 
 	err = fuse_fill_super_common(sb, ctx);
 	if (err)
@@ -1800,6 +1810,9 @@ static int fuse_get_tree(struct fs_context *fsc)
 
 	fsc->s_fs_info = fm;
 
+	if (ctx->no_daemon)
+		return get_tree_nodev(fsc, fuse_fill_super);
+
 	if (ctx->fd_present)
 		ctx->file = fget(ctx->fd);
 
-- 
2.38.1.584.g0f3c55d4c2-goog

