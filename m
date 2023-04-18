Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC9E6E56F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjDRBoa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjDRBn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:43:29 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D656A41
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-552e3fa8f2fso32401867b3.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782108; x=1684374108;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+tC+6XFyVz5iTVVtehlShhqqyPSU3xUJhrgatVmT44=;
        b=rIbd7s/2ek5G8EhMwiYEWTKGjSzZ7qOMthCTcIGG3nURoO/goLZ/THknkdr/Day049
         NOH2ThvnPaKS985+9T2Fj65xFkSb8mN7EIMqZpgOoWSQGsC7+K9Lo5IZgHyPfy0r15ie
         76fB2pTkT8+QMtmwqL4sijLUqof+ZN+hn8E6tAbc46UFjpy1TcWRQsd5ACEpzyMLSmW0
         74VzZ/vHRFvKlgEgwp6sWLYGEao1V0rHzw1TwBzEvw3oDwOtehIqQJ89/IY1OKVdN93F
         kJFpSyE1Czbvvz7vfD2Xz00Ts/BoJbP3VVBKgAUxrEePjcGseWyzi6UVxppwiAp8z3XC
         uLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782108; x=1684374108;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+tC+6XFyVz5iTVVtehlShhqqyPSU3xUJhrgatVmT44=;
        b=G4ZXHbreSv09yKM+vOk7gwFzyxpZRRMloBioZfduT0ohsFqWBMX80BxYcX9zn5wf8H
         NL9RpeWbbyQPSJPgxxhOuVQ1MrToQsOirjUtp13ZPLMpHm4DnWsd1MUYUR1JK917EOos
         TK5f8sFoNqkx2IAtqd64FbYF4o+LGVRsTtfN1riMej5YLbdJpcFpGrqfKHBJLrXc4Qvn
         L3RyyoNFBRojL8QkPPV+MMAcnG4yKwiGMWaG4ZpFQk47jONwb+8CEy4ic98JQbNYY83k
         3fqGN94KIBHXTbNiiNcyo9CCbtYP9RPPVahYhWcb5gJGxdDustIUishVclUk8ibmpbJW
         3+iA==
X-Gm-Message-State: AAQBX9fhjApAkUav48a1JkcrFtGs4wD6p9PkKrXK5W70cipWIOjx1lTS
        QYIW0cqtdZyTLL+mmt98QwxLviHm5/E=
X-Google-Smtp-Source: AKy350az5srFMYJyfvvtfh6sqad66/N+PonFGFWZFCufX/5Wu37wcKRBKPvzh2skEJqf7c2CQLiJDByUTVw=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a81:ad0e:0:b0:545:6106:5334 with SMTP id
 l14-20020a81ad0e000000b0054561065334mr10694952ywh.8.1681782108243; Mon, 17
 Apr 2023 18:41:48 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:25 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-26-drosen@google.com>
Subject: [RFC PATCH v3 25/37] fuse-bpf: allow mounting with no userspace daemon
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 121d31a04e79..2bd45c8658e8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -566,6 +566,7 @@ struct fuse_fs_context {
 	bool no_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
+	bool no_daemon:1;
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
@@ -847,6 +848,9 @@ struct fuse_conn {
 	/* Is tmpfile not implemented by fs? */
 	unsigned int no_tmpfile:1;
 
+	/** BPF Only, no Daemon running */
+	unsigned int no_daemon:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3dfb9cfb6e73..31f34962bc9b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -756,6 +756,7 @@ enum {
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
 	OPT_ROOT_DIR,
+	OPT_NO_DAEMON,
 	OPT_ERR
 };
 
@@ -771,6 +772,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
 	fsparam_u32	("root_dir",		OPT_ROOT_DIR),
+	fsparam_flag	("no_daemon",		OPT_NO_DAEMON),
 	{}
 };
 
@@ -860,6 +862,11 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
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
@@ -1419,7 +1426,7 @@ void fuse_send_init(struct fuse_mount *fm)
 	ia->args.nocreds = true;
 	ia->args.end = process_init_reply;
 
-	if (fuse_simple_background(fm, &ia->args, GFP_KERNEL) != 0)
+	if (unlikely(fm->fc->no_daemon) || fuse_simple_background(fm, &ia->args, GFP_KERNEL) != 0)
 		process_init_reply(fm, &ia->args, -ENOTCONN);
 }
 EXPORT_SYMBOL_GPL(fuse_send_init);
@@ -1694,6 +1701,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
+	fc->no_daemon = ctx->no_daemon;
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode, ctx->root_dir);
@@ -1740,7 +1748,7 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	struct fuse_fs_context *ctx = fsc->fs_private;
 	int err;
 
-	if (!ctx->file || !ctx->rootmode_present ||
+	if (!!ctx->file == ctx->no_daemon || !ctx->rootmode_present ||
 	    !ctx->user_id_present || !ctx->group_id_present)
 		return -EINVAL;
 
@@ -1748,10 +1756,12 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
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
@@ -1801,6 +1811,9 @@ static int fuse_get_tree(struct fs_context *fsc)
 
 	fsc->s_fs_info = fm;
 
+	if (ctx->no_daemon)
+		return get_tree_nodev(fsc, fuse_fill_super);;
+
 	if (ctx->fd_present)
 		ctx->file = fget(ctx->fd);
 
-- 
2.40.0.634.g4ca3ef3211-goog

