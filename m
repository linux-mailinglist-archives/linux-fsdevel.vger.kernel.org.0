Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F75F5EB5A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiIZXVa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiIZXUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:20:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A77A25FC
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-34d188806a8so75197037b3.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=EkmgsFrmuKNilhEIdub2GeeoDl0GoBdC6ajbaQkUtjI=;
        b=KEktYbeycGKh7r40wdBbT6d8dRJY0CQb+zaU+Mdg1YqyM8M81gjkb7C5bVE6n/wLws
         TO61VZzp9TXqkZfYafpLI43U8VU5v5VnR+Jz6t23ReVKb3YV9qsN/Dbvo26+2WbcPOMa
         l36L8WP05w21nXhKCorY5KNvdoUugSTr97QCWTjWOQpU0njc6wJ+/6XeCdhQClqIw6S2
         QA/8q4Di9zhc2sVc+9AJOe2U+A+07c1jlJANGyrde09AUv8UZU83MUqQj5/qbpD/63WC
         FwUeFhiQ7LXPO74Ik/bUTN48fua6G5PnCvRYK8t7qX+opmRu0bZO+pqxxu1R48eguoR9
         cWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=EkmgsFrmuKNilhEIdub2GeeoDl0GoBdC6ajbaQkUtjI=;
        b=IbNoBZD6Ju0GPqEPUhbuoFk3inJz/7glARIPuDOcJYjOKtz/9zdydx6bbNxOAd55ep
         RHqQ62uMXB8pso/KTUl/H+LEPJLHRCJswx1O5F9t0iMxEV5fUDZo4/bltivN0wp8aUwB
         HoqaV5anZcqQJbVziy0bPYCZ3rZ1mpbB5OMvtI67AQghYKDGzyj7C/JSBk+ldvC5Zkgj
         6yu3oZyhkibtC4+U8nUHgsOT7soWDCbplvscPCukPjA/n9zGrmFkh1s+1v9ENAM4/6CB
         VNomyo1mwcCSgxmg1O92JrMOUC+VjQfH8umE/ZtLlgLwCBETiergEtdBfaHFy/CAyPan
         6QvA==
X-Gm-Message-State: ACrzQf2xoMgVkkvclqsjEFLZf8Th3mNTBjGO+jN7eP4x7kE5HUmarLxy
        deJPFQH3e7xh41GC0NZ+57uFwHAdhjs=
X-Google-Smtp-Source: AMsMyM5xvnnLOZhey5safL3PVrn4bXvFhvEuSniyDikLvG47uC8f6aLwGB+qcSK6mNL0MBcAUauEH7rj9/Y=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a25:5f42:0:b0:6af:662c:f48f with SMTP id
 h2-20020a255f42000000b006af662cf48fmr21846903ybm.566.1664234371297; Mon, 26
 Sep 2022 16:19:31 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:19 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-24-drosen@google.com>
Subject: [PATCH 23/26] fuse-bpf: allow mounting with no userspace daemon
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
index cbfd56d669c7..6fb5c7a1ff11 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -571,6 +571,7 @@ struct fuse_fs_context {
 	bool no_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
+	bool no_daemon:1;
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
@@ -847,6 +848,9 @@ struct fuse_conn {
 	/* Does the filesystem support per inode DAX? */
 	unsigned int inode_dax:1;
 
+	/** BPF Only, no Daemon running */
+	unsigned int no_daemon:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d178c3eb445f..bc349102ce3b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -759,6 +759,7 @@ enum {
 	OPT_BLKSIZE,
 	OPT_ROOT_BPF,
 	OPT_ROOT_DIR,
+	OPT_NO_DAEMON,
 	OPT_ERR
 };
 
@@ -775,6 +776,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_string	("subtype",		OPT_SUBTYPE),
 	fsparam_u32	("root_bpf",		OPT_ROOT_BPF),
 	fsparam_u32	("root_dir",		OPT_ROOT_DIR),
+	fsparam_flag	("no_daemon",		OPT_NO_DAEMON),
 	{}
 };
 
@@ -873,6 +875,11 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
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
@@ -1438,7 +1445,7 @@ void fuse_send_init(struct fuse_mount *fm)
 	ia->args.nocreds = true;
 	ia->args.end = process_init_reply;
 
-	if (fuse_simple_background(fm, &ia->args, GFP_KERNEL) != 0)
+	if (unlikely(fm->fc->no_daemon) || fuse_simple_background(fm, &ia->args, GFP_KERNEL) != 0)
 		process_init_reply(fm, &ia->args, -ENOTCONN);
 }
 EXPORT_SYMBOL_GPL(fuse_send_init);
@@ -1720,6 +1727,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
+	fc->no_daemon = ctx->no_daemon;
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode, ctx->root_bpf,
@@ -1767,7 +1775,7 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	struct fuse_fs_context *ctx = fsc->fs_private;
 	int err;
 
-	if (!ctx->file || !ctx->rootmode_present ||
+	if (!!ctx->file == ctx->no_daemon || !ctx->rootmode_present ||
 	    !ctx->user_id_present || !ctx->group_id_present)
 		return -EINVAL;
 
@@ -1775,10 +1783,12 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
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
@@ -1828,6 +1838,9 @@ static int fuse_get_tree(struct fs_context *fsc)
 
 	fsc->s_fs_info = fm;
 
+	if (ctx->no_daemon)
+		return get_tree_nodev(fsc, fuse_fill_super);;
+
 	if (ctx->fd_present)
 		ctx->file = fget(ctx->fd);
 
-- 
2.37.3.998.g577e59143f-goog

