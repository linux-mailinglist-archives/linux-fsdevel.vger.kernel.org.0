Return-Path: <linux-fsdevel+bounces-15645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A9B891101
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 03:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CEE1F23D6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738E66A8D2;
	Fri, 29 Mar 2024 01:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x4mYQJZa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A256A8A3
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677295; cv=none; b=lxbtM1IL6gvM8E2ivroPAsClTra0oeoFs23RLgnkshFhMyMwVJXS+e1AYMTxqNBGJrdwERzn/ki9xtg3YngCUWRx5oYE3+dYMyggz2yLBYXH0oHQiFtM/nrVp/8VCbzlZWUCB246V9W5VBxU2isA+vVC1ogIxfoxwVDzaft+6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677295; c=relaxed/simple;
	bh=lg0g6uOF3iAO/ssiLRAcrWry2HIbZpoqzls2TxKy5ms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kb+x73CoEtoGQTOnetK5ErspRiqAWJEVI2Rz5MtAJPsbwWbdek38w//vu7ebXrRBvpkwLwPqrABzdliJJmZQLi5TyAOuIFTirN2i0FaeXNxfvf5QHoREMQ/+YCKkWeNOOwl403m1cLTGBcxmmZ7HNJQQ4r9Al1AmG84H4qblV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x4mYQJZa; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so2789701276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677292; x=1712282092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=od0eLderVP8wkPdPrI4ENNCsb2rG+V1Fgj/sF5+lSuM=;
        b=x4mYQJZa5N8yMZBMXbwKAQkbqX4tgVORq6SXljK1YvZG2YQaow9FUihPpsUQy/7sxB
         87U18Ceo/QJ08muJc84lHbltw6/mtmtbxT5hOsBKyulrS8wbBCX32tj4sdiXPR9Ud9t7
         +Fr03dmcXrLT2FL2gsKS5bfDPbarhDJeH4fgs0JMx3ws3tYlQaeYbFmfXcxcLerRaIzk
         Y8VCX13ytsiUWeIGEunk3HaMpjQyIkm1Fo/yqOvUhcGcDd5g2TCe0c5n/nFY/OAxNNTi
         6gI0gbIdeP+wZVVjwvv4b+vmTpz/MtanosebtA27LStRbdTzra+LyHE4U70meWDng0BN
         7iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677292; x=1712282092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=od0eLderVP8wkPdPrI4ENNCsb2rG+V1Fgj/sF5+lSuM=;
        b=N/xZgP2SBqaUXsHjar0Iae4CVb0A4PyT9WXHwjhrrdPEB7mcfFXFgW/aHKyruIiOGk
         9SfIxx5t8OwFE+1ZZxJheGc3G76oRgG9eUfsSsnbr8kS3lvZ7N14PSVf+I9MVO7I+rlP
         UV8yJFSV7CIxIjaWUxETPRebqJW11Sq9YyUu9xZmnb6qWCAQaAN/zNSdRZSVXra+By4F
         FgTEP69kUXwv4OXBOiUs8a6bkge2In0Mwx1n4qTzjyrvYkhRVzKFV0JYiDCHxy72jIDk
         mGZBbNjdmIq9kEeWv2OO4VAuUfflucd8jHzLchtKiPWEg7BPK9LM9yoRDt1537/oHurQ
         ADQA==
X-Forwarded-Encrypted: i=1; AJvYcCUQXZE79k38z9eQO8rYfZpx+ZYlxxZYLlB3elElMRIPzTPOvdkJtd6iGK/T9O6H/Be7hY7XE08xZXNwJ9ap7o/fGhL3NZWHf+3fQXfPCw==
X-Gm-Message-State: AOJu0YyPUM1x/YEZy9acPugL6xos7wcXoYtEOQiT4TnbVeT0i14JjxS/
	p1Jb9wosG73lVl+985vSH5MYnoYufJJP82YSR1saN9nwJrPQ9K/yaQFthST7LuUwMQ7C8yzKfL8
	ULQ==
X-Google-Smtp-Source: AGHT+IFNeB7P0RtQ53mC8zg19/JpPgaA07h8+WRkHIS3dG7DeGgWdytZdjnC5CdjHQubEzDWWlIhriwU/f0=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:2841:b0:dcb:bc80:8333 with SMTP id
 ee1-20020a056902284100b00dcbbc808333mr293843ybb.13.1711677292440; Thu, 28 Mar
 2024 18:54:52 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:38 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-24-drosen@google.com>
Subject: [RFC PATCH v4 23/36] fuse-bpf: allow mounting with no userspace daemon
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"

When using fuse-bpf in pure passthrough mode, we don't explicitly need a
userspace daemon. This allows simple testing of the backing operations.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/fuse_i.h |  4 ++++
 fs/fuse/inode.c  | 25 +++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 81639c006ac5..f1a8f8a97f1f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -586,6 +586,7 @@ struct fuse_fs_context {
 	bool no_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
+	bool no_daemon:1;
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
@@ -873,6 +874,9 @@ struct fuse_conn {
 	/* Is statx not implemented by fs? */
 	unsigned int no_statx:1;
 
+	/** BPF Only, no Daemon running */
+	unsigned int no_daemon:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bc504e0d0e80..b4332416e23a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -829,6 +829,7 @@ enum {
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
 	OPT_ROOT_DIR,
+	OPT_NO_DAEMON,
 	OPT_ERR
 };
 
@@ -844,6 +845,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
 	fsparam_u32	("root_dir",		OPT_ROOT_DIR),
+	fsparam_flag	("no_daemon",		OPT_NO_DAEMON),
 	{}
 };
 
@@ -933,6 +935,11 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
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
@@ -1506,7 +1513,7 @@ void fuse_send_init(struct fuse_mount *fm)
 	ia->args.nocreds = true;
 	ia->args.end = process_init_reply;
 
-	if (fuse_simple_background(fm, &ia->args, GFP_KERNEL) != 0)
+	if (unlikely(fm->fc->no_daemon) || fuse_simple_background(fm, &ia->args, GFP_KERNEL) != 0)
 		process_init_reply(fm, &ia->args, -ENOTCONN);
 }
 EXPORT_SYMBOL_GPL(fuse_send_init);
@@ -1798,6 +1805,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
+	fc->no_daemon = ctx->no_daemon;
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode, ctx->root_dir);
@@ -1844,7 +1852,7 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	struct fuse_fs_context *ctx = fsc->fs_private;
 	int err;
 
-	if (!ctx->file || !ctx->rootmode_present ||
+	if (!!ctx->file == ctx->no_daemon || !ctx->rootmode_present ||
 	    !ctx->user_id_present || !ctx->group_id_present)
 		return -EINVAL;
 
@@ -1852,10 +1860,12 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
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
@@ -1905,6 +1915,9 @@ static int fuse_get_tree(struct fs_context *fsc)
 
 	fsc->s_fs_info = fm;
 
+	if (ctx->no_daemon)
+		return get_tree_nodev(fsc, fuse_fill_super);;
+
 	if (ctx->fd_present)
 		ctx->file = fget(ctx->fd);
 
-- 
2.44.0.478.gd926399ef9-goog


