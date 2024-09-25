Return-Path: <linux-fsdevel+bounces-30087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0F99860A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E28E1C262DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BF63CF73;
	Wed, 25 Sep 2024 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duSdZL9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C81DFCF
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270238; cv=none; b=OIGDfKTwuIkB7s3lI7TD8f9svSFyTjt6L5728K2CCX4mfG8GlLN8c+25ILOS3CQv4AFDIHjypxFKVUIyjdIJkA4HWF7NuAxi9M2/rhmcS9OuVDZiHgjm7S4MCdSWv4L03+K/QWOanOn7sMsIc0cjuQWPpv2pwrt22v2v7ZQP7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270238; c=relaxed/simple;
	bh=rztP5rJqQ4+2gFVZF9I7MKa86DzjdD/CU+Of/bk9DwE=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=THz95CclQXj1U1CJ/9sHYCys2IW+Tqa7wSKXBp7oBZYhjN7RfBYnDaTy4GjwvsRrXubQCYMDm33//iRTTd2wabISgexy0IwYaKqpxJtHkxh3EodbYO5q4Gmf4PeoYzb7mfgipr3KkM//fWGVlyvEIUgrVJwzRHskDpk7VvhS//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duSdZL9r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727270234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ZrFeOGaFmL0EaKDQm+ATH4090/XpdtGyjeJ2Zz6JCNg=;
	b=duSdZL9rqYQesj15uagnL4KX29OLBhIKjlQHKatPFEBmOxfhR8zN8TiYF8PYr3aByRM0Tm
	IaSKlyh7IClvS75Ppea+blMc3hAu0Rlc6dSJBYmxtG8+yOY/fiOyk+EAqKD6YuJX4bzxlH
	ffYGGv9jWneColMU98dLzu38LO/1314=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-A-VzffpENZqcgjtJ8-Ek2g-1; Wed,
 25 Sep 2024 09:17:13 -0400
X-MC-Unique: A-VzffpENZqcgjtJ8-Ek2g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 931D2196E093;
	Wed, 25 Sep 2024 13:17:12 +0000 (UTC)
Received: from [10.45.226.79] (unknown [10.45.226.79])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 231A91956053;
	Wed, 25 Sep 2024 13:17:10 +0000 (UTC)
Date: Wed, 25 Sep 2024 15:17:06 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] hpfs: convert hpfs to use the new mount api
Message-ID: <0a066bbb-59ad-17b0-e413-190569f2fea9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi

Here I'm sending Eric's patch that converts hpfs to use the new mount API.

Mikulas



From: Eric Sandeen <sandeen@redhat.com>

Convert the hpfs filesystem to use the new mount API.
Tested by comparing random mount & remount options before and after
the change.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
---
 fs/hpfs/super.c | 414 ++++++++++++++++++++++++------------------------
 1 file changed, 204 insertions(+), 210 deletions(-)

diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index e73717daa5f9..27567920abe4 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -9,7 +9,8 @@
 
 #include "hpfs_fn.h"
 #include <linux/module.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/init.h>
 #include <linux/statfs.h>
 #include <linux/magic.h>
@@ -90,7 +91,7 @@ void hpfs_error(struct super_block *s, const char *fmt, ...)
 	hpfs_sb(s)->sb_was_error = 1;
 }
 
-/* 
+/*
  * A little trick to detect cycles in many hpfs structures and don't let the
  * kernel crash on corrupted filesystem. When first called, set c2 to 0.
  *
@@ -272,146 +273,70 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(hpfs_inode_cachep);
 }
 
-/*
- * A tiny parser for option strings, stolen from dosfs.
- * Stolen again from read-only hpfs.
- * And updated for table-driven option parsing.
- */
-
 enum {
-	Opt_help, Opt_uid, Opt_gid, Opt_umask, Opt_case_lower, Opt_case_asis,
-	Opt_check_none, Opt_check_normal, Opt_check_strict,
-	Opt_err_cont, Opt_err_ro, Opt_err_panic,
-	Opt_eas_no, Opt_eas_ro, Opt_eas_rw,
-	Opt_chkdsk_no, Opt_chkdsk_errors, Opt_chkdsk_always,
-	Opt_timeshift, Opt_err,
+	Opt_help, Opt_uid, Opt_gid, Opt_umask, Opt_case,
+	Opt_check, Opt_err, Opt_eas, Opt_chkdsk, Opt_timeshift,
 };
 
-static const match_table_t tokens = {
-	{Opt_help, "help"},
-	{Opt_uid, "uid=%u"},
-	{Opt_gid, "gid=%u"},
-	{Opt_umask, "umask=%o"},
-	{Opt_case_lower, "case=lower"},
-	{Opt_case_asis, "case=asis"},
-	{Opt_check_none, "check=none"},
-	{Opt_check_normal, "check=normal"},
-	{Opt_check_strict, "check=strict"},
-	{Opt_err_cont, "errors=continue"},
-	{Opt_err_ro, "errors=remount-ro"},
-	{Opt_err_panic, "errors=panic"},
-	{Opt_eas_no, "eas=no"},
-	{Opt_eas_ro, "eas=ro"},
-	{Opt_eas_rw, "eas=rw"},
-	{Opt_chkdsk_no, "chkdsk=no"},
-	{Opt_chkdsk_errors, "chkdsk=errors"},
-	{Opt_chkdsk_always, "chkdsk=always"},
-	{Opt_timeshift, "timeshift=%d"},
-	{Opt_err, NULL},
+static const struct constant_table hpfs_param_case[] = {
+	{"asis",	0},
+	{"lower",	1},
+	{}
 };
 
-static int parse_opts(char *opts, kuid_t *uid, kgid_t *gid, umode_t *umask,
-		      int *lowercase, int *eas, int *chk, int *errs,
-		      int *chkdsk, int *timeshift)
-{
-	char *p;
-	int option;
+static const struct constant_table hpfs_param_check[] = {
+	{"none",	0},
+	{"normal",	1},
+	{"strict",	2},
+	{}
+};
 
-	if (!opts)
-		return 1;
+static const struct constant_table hpfs_param_err[] = {
+	{"continue",	0},
+	{"remount-ro",	1},
+	{"panic",	2},
+	{}
+};
 
-	/*pr_info("Parsing opts: '%s'\n",opts);*/
-
-	while ((p = strsep(&opts, ",")) != NULL) {
-		substring_t args[MAX_OPT_ARGS];
-		int token;
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_help:
-			return 2;
-		case Opt_uid:
-			if (match_int(args, &option))
-				return 0;
-			*uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(*uid))
-				return 0;
-			break;
-		case Opt_gid:
-			if (match_int(args, &option))
-				return 0;
-			*gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(*gid))
-				return 0;
-			break;
-		case Opt_umask:
-			if (match_octal(args, &option))
-				return 0;
-			*umask = option;
-			break;
-		case Opt_case_lower:
-			*lowercase = 1;
-			break;
-		case Opt_case_asis:
-			*lowercase = 0;
-			break;
-		case Opt_check_none:
-			*chk = 0;
-			break;
-		case Opt_check_normal:
-			*chk = 1;
-			break;
-		case Opt_check_strict:
-			*chk = 2;
-			break;
-		case Opt_err_cont:
-			*errs = 0;
-			break;
-		case Opt_err_ro:
-			*errs = 1;
-			break;
-		case Opt_err_panic:
-			*errs = 2;
-			break;
-		case Opt_eas_no:
-			*eas = 0;
-			break;
-		case Opt_eas_ro:
-			*eas = 1;
-			break;
-		case Opt_eas_rw:
-			*eas = 2;
-			break;
-		case Opt_chkdsk_no:
-			*chkdsk = 0;
-			break;
-		case Opt_chkdsk_errors:
-			*chkdsk = 1;
-			break;
-		case Opt_chkdsk_always:
-			*chkdsk = 2;
-			break;
-		case Opt_timeshift:
-		{
-			int m = 1;
-			char *rhs = args[0].from;
-			if (!rhs || !*rhs)
-				return 0;
-			if (*rhs == '-') m = -1;
-			if (*rhs == '+' || *rhs == '-') rhs++;
-			*timeshift = simple_strtoul(rhs, &rhs, 0) * m;
-			if (*rhs)
-				return 0;
-			break;
-		}
-		default:
-			return 0;
-		}
-	}
-	return 1;
-}
+static const struct constant_table hpfs_param_eas[] = {
+	{"no",		0},
+	{"ro",		1},
+	{"rw",		2},
+	{}
+};
+
+static const struct constant_table hpfs_param_chkdsk[] = {
+	{"no",		0},
+	{"errors",	1},
+	{"always",	2},
+	{}
+};
+
+static const struct fs_parameter_spec hpfs_param_spec[] = {
+	fsparam_flag	("help",	Opt_help),
+	fsparam_uid	("uid",		Opt_uid),
+	fsparam_gid	("gid",		Opt_gid),
+	fsparam_u32oct	("umask",	Opt_umask),
+	fsparam_enum	("case",	Opt_case,	hpfs_param_case),
+	fsparam_enum	("check",	Opt_check,	hpfs_param_check),
+	fsparam_enum	("errors",	Opt_err,	hpfs_param_err),
+	fsparam_enum	("eas",		Opt_eas,	hpfs_param_eas),
+	fsparam_enum	("chkdsk",	Opt_chkdsk,	hpfs_param_chkdsk),
+	fsparam_s32	("timeshift",	Opt_timeshift),
+	{}
+};
+
+struct hpfs_fc_context {
+	kuid_t uid;
+	kgid_t gid;
+	umode_t umask;
+	int lowercase;
+	int eas;
+	int chk;
+	int errs;
+	int chkdsk;
+	int timeshift;
+};
 
 static inline void hpfs_help(void)
 {
@@ -439,49 +364,92 @@ HPFS filesystem options:\n\
 \n");
 }
 
-static int hpfs_remount_fs(struct super_block *s, int *flags, char *data)
+static int hpfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	kuid_t uid;
-	kgid_t gid;
-	umode_t umask;
-	int lowercase, eas, chk, errs, chkdsk, timeshift;
-	int o;
+	struct hpfs_fc_context *ctx = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, hpfs_param_spec, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_help:
+		hpfs_help();
+		return -EINVAL;
+	case Opt_uid:
+		ctx->uid = result.uid;
+		break;
+	case Opt_gid:
+		ctx->gid = result.gid;
+		break;
+	case Opt_umask:
+		ctx->umask = result.uint_32;
+		break;
+	case Opt_case:
+		ctx->lowercase = result.uint_32;
+		break;
+	case Opt_check:
+		ctx->chk = result.uint_32;
+		break;
+	case Opt_err:
+		ctx->errs = result.uint_32;
+		break;
+	case Opt_eas:
+		ctx->eas = result.uint_32;
+		break;
+	case Opt_chkdsk:
+		ctx->chkdsk = result.uint_32;
+		break;
+	case Opt_timeshift:
+		{
+			int m = 1;
+			char *rhs = param->string;
+			int timeshift;
+
+			if (*rhs == '-') m = -1;
+			if (*rhs == '+' || *rhs == '-') rhs++;
+			timeshift = simple_strtoul(rhs, &rhs, 0) * m;
+			if (*rhs)
+					return -EINVAL;
+			ctx->timeshift = timeshift;
+			break;
+		}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hpfs_reconfigure(struct fs_context *fc)
+{
+	struct hpfs_fc_context *ctx = fc->fs_private;
+	struct super_block *s = fc->root->d_sb;
 	struct hpfs_sb_info *sbi = hpfs_sb(s);
 
 	sync_filesystem(s);
 
-	*flags |= SB_NOATIME;
+	fc->sb_flags |= SB_NOATIME;
 
 	hpfs_lock(s);
-	uid = sbi->sb_uid; gid = sbi->sb_gid;
-	umask = 0777 & ~sbi->sb_mode;
-	lowercase = sbi->sb_lowercase;
-	eas = sbi->sb_eas; chk = sbi->sb_chk; chkdsk = sbi->sb_chkdsk;
-	errs = sbi->sb_err; timeshift = sbi->sb_timeshift;
-
-	if (!(o = parse_opts(data, &uid, &gid, &umask, &lowercase,
-	    &eas, &chk, &errs, &chkdsk, &timeshift))) {
-		pr_err("bad mount options.\n");
-		goto out_err;
-	}
-	if (o == 2) {
-		hpfs_help();
-		goto out_err;
-	}
-	if (timeshift != sbi->sb_timeshift) {
+
+	if (ctx->timeshift != sbi->sb_timeshift) {
 		pr_err("timeshift can't be changed using remount.\n");
 		goto out_err;
 	}
 
 	unmark_dirty(s);
 
-	sbi->sb_uid = uid; sbi->sb_gid = gid;
-	sbi->sb_mode = 0777 & ~umask;
-	sbi->sb_lowercase = lowercase;
-	sbi->sb_eas = eas; sbi->sb_chk = chk; sbi->sb_chkdsk = chkdsk;
-	sbi->sb_err = errs; sbi->sb_timeshift = timeshift;
+	sbi->sb_uid = ctx->uid; sbi->sb_gid = ctx->gid;
+	sbi->sb_mode = 0777 & ~ctx->umask;
+	sbi->sb_lowercase = ctx->lowercase;
+	sbi->sb_eas = ctx->eas; sbi->sb_chk = ctx->chk;
+	sbi->sb_chkdsk = ctx->chkdsk;
+	sbi->sb_err = ctx->errs; sbi->sb_timeshift = ctx->timeshift;
 
-	if (!(*flags & SB_RDONLY)) mark_dirty(s, 1);
+	if (!(fc->sb_flags & SB_RDONLY)) mark_dirty(s, 1);
 
 	hpfs_unlock(s);
 	return 0;
@@ -530,30 +498,24 @@ static const struct super_operations hpfs_sops =
 	.evict_inode	= hpfs_evict_inode,
 	.put_super	= hpfs_put_super,
 	.statfs		= hpfs_statfs,
-	.remount_fs	= hpfs_remount_fs,
 	.show_options	= hpfs_show_options,
 };
 
-static int hpfs_fill_super(struct super_block *s, void *options, int silent)
+static int hpfs_fill_super(struct super_block *s, struct fs_context *fc)
 {
+	struct hpfs_fc_context *ctx = fc->fs_private;
 	struct buffer_head *bh0, *bh1, *bh2;
 	struct hpfs_boot_block *bootblock;
 	struct hpfs_super_block *superblock;
 	struct hpfs_spare_block *spareblock;
 	struct hpfs_sb_info *sbi;
 	struct inode *root;
-
-	kuid_t uid;
-	kgid_t gid;
-	umode_t umask;
-	int lowercase, eas, chk, errs, chkdsk, timeshift;
+	int silent = fc->sb_flags & SB_SILENT;
 
 	dnode_secno root_dno;
 	struct hpfs_dirent *de = NULL;
 	struct quad_buffer_head qbh;
 
-	int o;
-
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi) {
 		return -ENOMEM;
@@ -563,26 +525,6 @@ static int hpfs_fill_super(struct super_block *s, void *options, int silent)
 	mutex_init(&sbi->hpfs_mutex);
 	hpfs_lock(s);
 
-	uid = current_uid();
-	gid = current_gid();
-	umask = current_umask();
-	lowercase = 0;
-	eas = 2;
-	chk = 1;
-	errs = 1;
-	chkdsk = 1;
-	timeshift = 0;
-
-	if (!(o = parse_opts(options, &uid, &gid, &umask, &lowercase,
-	    &eas, &chk, &errs, &chkdsk, &timeshift))) {
-		pr_err("bad mount options.\n");
-		goto bail0;
-	}
-	if (o==2) {
-		hpfs_help();
-		goto bail0;
-	}
-
 	/*sbi->sb_mounting = 1;*/
 	sb_set_blocksize(s, 512);
 	sbi->sb_fs_size = -1;
@@ -622,17 +564,17 @@ static int hpfs_fill_super(struct super_block *s, void *options, int silent)
 	sbi->sb_dirband_start = le32_to_cpu(superblock->dir_band_start);
 	sbi->sb_dirband_size = le32_to_cpu(superblock->n_dir_band);
 	sbi->sb_dmap = le32_to_cpu(superblock->dir_band_bitmap);
-	sbi->sb_uid = uid;
-	sbi->sb_gid = gid;
-	sbi->sb_mode = 0777 & ~umask;
+	sbi->sb_uid = ctx->uid;
+	sbi->sb_gid = ctx->gid;
+	sbi->sb_mode = 0777 & ~ctx->umask;
 	sbi->sb_n_free = -1;
 	sbi->sb_n_free_dnodes = -1;
-	sbi->sb_lowercase = lowercase;
-	sbi->sb_eas = eas;
-	sbi->sb_chk = chk;
-	sbi->sb_chkdsk = chkdsk;
-	sbi->sb_err = errs;
-	sbi->sb_timeshift = timeshift;
+	sbi->sb_lowercase = ctx->lowercase;
+	sbi->sb_eas = ctx->eas;
+	sbi->sb_chk = ctx->chk;
+	sbi->sb_chkdsk = ctx->chkdsk;
+	sbi->sb_err = ctx->errs;
+	sbi->sb_timeshift = ctx->timeshift;
 	sbi->sb_was_error = 0;
 	sbi->sb_cp_table = NULL;
 	sbi->sb_c_bitmap = -1;
@@ -653,7 +595,7 @@ static int hpfs_fill_super(struct super_block *s, void *options, int silent)
 	
 	/* Check for general fs errors*/
 	if (spareblock->dirty && !spareblock->old_wrote) {
-		if (errs == 2) {
+		if (sbi->sb_err == 2) {
 			pr_err("Improperly stopped, not mounted\n");
 			goto bail4;
 		}
@@ -667,16 +609,16 @@ static int hpfs_fill_super(struct super_block *s, void *options, int silent)
 	}
 
 	if (le32_to_cpu(spareblock->n_dnode_spares) != le32_to_cpu(spareblock->n_dnode_spares_free)) {
-		if (errs >= 2) {
+		if (sbi->sb_err >= 2) {
 			pr_err("Spare dnodes used, try chkdsk\n");
 			mark_dirty(s, 0);
 			goto bail4;
 		}
 		hpfs_error(s, "warning: spare dnodes used, try chkdsk");
-		if (errs == 0)
+		if (sbi->sb_err == 0)
 			pr_err("Proceeding, but your filesystem could be corrupted if you delete files or directories\n");
 	}
-	if (chk) {
+	if (sbi->sb_chk) {
 		unsigned a;
 		if (le32_to_cpu(superblock->dir_band_end) - le32_to_cpu(superblock->dir_band_start) + 1 != le32_to_cpu(superblock->n_dir_band) ||
 		    le32_to_cpu(superblock->dir_band_end) < le32_to_cpu(superblock->dir_band_start) || le32_to_cpu(superblock->n_dir_band) > 0x4000) {
@@ -755,18 +697,70 @@ bail2:	brelse(bh0);
 	return -EINVAL;
 }
 
-static struct dentry *hpfs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int hpfs_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, hpfs_fill_super);
+}
+
+static void hpfs_free_fc(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, hpfs_fill_super);
+	kfree(fc->fs_private);
 }
 
+static const struct fs_context_operations hpfs_fc_context_ops = {
+	.parse_param	= hpfs_parse_param,
+	.get_tree	= hpfs_get_tree,
+	.reconfigure	= hpfs_reconfigure,
+	.free		= hpfs_free_fc,
+};
+
+static int hpfs_init_fs_context(struct fs_context *fc)
+{
+	struct hpfs_fc_context *ctx;
+
+	ctx = kzalloc(sizeof(struct hpfs_fc_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		struct super_block *sb = fc->root->d_sb;
+		struct hpfs_sb_info *sbi = hpfs_sb(sb);
+
+		ctx->uid = sbi->sb_uid;
+		ctx->gid = sbi->sb_gid;
+		ctx->umask = 0777 & ~sbi->sb_mode;
+		ctx->lowercase = sbi->sb_lowercase;
+		ctx->eas = sbi->sb_eas;
+		ctx->chk = sbi->sb_chk;
+		ctx->chkdsk = sbi->sb_chkdsk;
+		ctx->errs = sbi->sb_err;
+		ctx->timeshift = sbi->sb_timeshift;
+
+	} else {
+		ctx->uid = current_uid();
+		ctx->gid = current_gid();
+		ctx->umask = current_umask();
+		ctx->lowercase = 0;
+		ctx->eas = 2;
+		ctx->chk = 1;
+		ctx->errs = 1;
+		ctx->chkdsk = 1;
+		ctx->timeshift = 0;
+	}
+
+	fc->fs_private = ctx;
+	fc->ops = &hpfs_fc_context_ops;
+
+	return 0;
+};
+
 static struct file_system_type hpfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hpfs",
-	.mount		= hpfs_mount,
 	.kill_sb	= kill_block_super,
 	.fs_flags	= FS_REQUIRES_DEV,
+	.init_fs_context = hpfs_init_fs_context,
+	.parameters	= hpfs_param_spec,
 };
 MODULE_ALIAS_FS("hpfs");
 
-- 
2.46.0


