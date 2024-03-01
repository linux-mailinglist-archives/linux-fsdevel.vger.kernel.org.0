Return-Path: <linux-fsdevel+bounces-13339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9523086EC0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 23:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F9F1F23660
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 22:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC38D5EE68;
	Fri,  1 Mar 2024 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avmx8iuM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEA259B47
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 22:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709333810; cv=none; b=ap0mtc/KLq+pGAY8BM3BbkP/AXw0LhlTlYIZIOgwl6l9fk3qVxF5TEDAF6zkhwK6uISaftslFtMuImpaKwCWsDoz/vE4iN+7SHYPu6QM4M+EuA5ZHjO1ODacZOgiXhoDVxx600NQGGB0Dya/+n4mD328BKJvIzBwjFS1TgC17O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709333810; c=relaxed/simple;
	bh=Dk9KbYJVxBbtKvbjOp4WWKldaK2t7TS8BJdJD+vd9Zk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=o6HEq52GRquow17m+OQKrLYUPsORhylZhwwe9/CyvcJt/Sg9aG6TwAhSP8yE6y1mZQqT2amB+DAEhjd0ZPvgG+vmDfiSIrflRoJx0jJBJCVQ7catrjwlfmgoYfI1DrqrNqguK5GAqkzeEI5mQ2YCRaUGI4N+Mlp+5fC+TLDmgS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avmx8iuM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709333806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EDSvSA4y7NIQn5uvvGognAeMi40D6jz9ecoAkub4Cjk=;
	b=avmx8iuMN8MaEDbmi5qvmJ5/G3b2Jk7+4lveded2nvlz/OG5jyhVtY06h/UX2R17cHm51o
	aKkCZu//7eKHFlqshKow/BOYdXNGulaZfnwluJ2sGT++RIePrQZpm3UpxFlobZDK0ZPaOO
	eW4oBoJlwGVfYv9jrrdoiJ5MwotPjsw=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-wcyrwffONMOOtOnKSb0Lbg-1; Fri, 01 Mar 2024 17:56:44 -0500
X-MC-Unique: wcyrwffONMOOtOnKSb0Lbg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7943de7b2so229912539f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Mar 2024 14:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709333803; x=1709938603;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EDSvSA4y7NIQn5uvvGognAeMi40D6jz9ecoAkub4Cjk=;
        b=UisrQOtjxMpYFl9N15nmlbMES86QcWmAKHTwDULa02U44zWsGQGkYdORFEcuP416Gf
         thxQFX9uwNZYDMy34Y3RTKBa9t4NFbHLK9+Dh69pdU3cAF74+GygGXXSzAuE8WSgTJ+W
         4lSW4nX7aUrTrx79k8w/aJbw1IksOKhzCtZM6VSwyq6e2hzYDGRaEpGwcIs8PK89bFBn
         U/nyGAjaRGyrNoZMyrTELFfK5cciMy6NiIwuD2YybHfFPOEMEov8l+SP/VditC0DY6l6
         NMyt6hk64s1qUsVbEK3yvLG8yAv8bJ3h0R4ufSfPH2AuCOWrkUsi7cVeUplsuVa9r9PC
         UjoQ==
X-Gm-Message-State: AOJu0Yx3D8UICciI5SssvJTk6yS6xl66QchZrj//gMS86hfZjRJc4lqi
	xODd32NNhrD/umaiPLk7OBKcSLohOm2O+1HQokFwHLb7ZDkgvtGKe0jKL9Gd2fe/mbdEdMX4sex
	TXRRwweLWuMLeXWOpecxDEu6D51ASLpj0caga1LdUemHw1XuEiib9asKyBvOkym0+Di5z+k3+mo
	Zq8Ndo3AkCqsVvSdT4ftC7G4QH/+JdwPPT0+3Cal6aZYzBAb6o
X-Received: by 2002:a05:6602:809:b0:7c7:fc3e:6f29 with SMTP id z9-20020a056602080900b007c7fc3e6f29mr3205477iow.10.1709333802818;
        Fri, 01 Mar 2024 14:56:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPJJBZDJ1z94+SFGxnl7J7aiiQOnycs5PxRKyIU5U8pnWJ2iky4Uo8bDb5UVGzMNeywxTHcA==
X-Received: by 2002:a05:6602:809:b0:7c7:fc3e:6f29 with SMTP id z9-20020a056602080900b007c7fc3e6f29mr3205457iow.10.1709333802314;
        Fri, 01 Mar 2024 14:56:42 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id t33-20020a05663834a100b00474d35172b5sm349194jal.136.2024.03.01.14.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 14:56:41 -0800 (PST)
Message-ID: <f15910da-b39e-44ff-8a2f-df7ce8c52057@redhat.com>
Date: Fri, 1 Mar 2024 16:56:41 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Bill O'Donnell <billodo@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] isofs: convert isofs to use the new mount API
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
cc: Jan Kara <jack@suse.cz>
---

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 3e4d53e26f94..c0f4f9a1bcf6 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -21,11 +21,12 @@
 #include <linux/ctype.h>
 #include <linux/statfs.h>
 #include <linux/cdrom.h>
-#include <linux/parser.h>
 #include <linux/mpage.h>
 #include <linux/user_namespace.h>
 #include <linux/seq_file.h>
 #include <linux/blkdev.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 
 #include "isofs.h"
 #include "zisofs.h"
@@ -110,10 +111,10 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(isofs_inode_cachep);
 }
 
-static int isofs_remount(struct super_block *sb, int *flags, char *data)
+static int iso9660_reconfigure(struct fs_context *fc)
 {
-	sync_filesystem(sb);
-	if (!(*flags & SB_RDONLY))
+	sync_filesystem(fc->root->d_sb);
+	if (!(fc->sb_flags & SB_RDONLY) & SB_RDONLY)
 		return -EROFS;
 	return 0;
 }
@@ -123,7 +124,6 @@ static const struct super_operations isofs_sops = {
 	.free_inode	= isofs_free_inode,
 	.put_super	= isofs_put_super,
 	.statfs		= isofs_statfs,
-	.remount_fs	= isofs_remount,
 	.show_options	= isofs_show_options,
 };
 
@@ -289,197 +289,162 @@ isofs_dentry_cmpi_ms(const struct dentry *dentry,
 #endif
 
 enum {
-	Opt_block, Opt_check_r, Opt_check_s, Opt_cruft, Opt_gid, Opt_ignore,
-	Opt_iocharset, Opt_map_a, Opt_map_n, Opt_map_o, Opt_mode, Opt_nojoliet,
-	Opt_norock, Opt_sb, Opt_session, Opt_uid, Opt_unhide, Opt_utf8, Opt_err,
-	Opt_nocompress, Opt_hide, Opt_showassoc, Opt_dmode, Opt_overriderockperm,
+	Opt_block, Opt_check, Opt_cruft, Opt_gid, Opt_ignore, Opt_iocharset,
+	Opt_map, Opt_mode, Opt_nojoliet, Opt_norock, Opt_sb, Opt_session,
+	Opt_uid, Opt_unhide, Opt_utf8, Opt_err, Opt_nocompress, Opt_hide,
+	Opt_showassoc, Opt_dmode, Opt_overriderockperm,
 };
 
-static const match_table_t tokens = {
-	{Opt_norock, "norock"},
-	{Opt_nojoliet, "nojoliet"},
-	{Opt_unhide, "unhide"},
-	{Opt_hide, "hide"},
-	{Opt_showassoc, "showassoc"},
-	{Opt_cruft, "cruft"},
-	{Opt_utf8, "utf8"},
-	{Opt_iocharset, "iocharset=%s"},
-	{Opt_map_a, "map=acorn"},
-	{Opt_map_a, "map=a"},
-	{Opt_map_n, "map=normal"},
-	{Opt_map_n, "map=n"},
-	{Opt_map_o, "map=off"},
-	{Opt_map_o, "map=o"},
-	{Opt_session, "session=%u"},
-	{Opt_sb, "sbsector=%u"},
-	{Opt_check_r, "check=relaxed"},
-	{Opt_check_r, "check=r"},
-	{Opt_check_s, "check=strict"},
-	{Opt_check_s, "check=s"},
-	{Opt_uid, "uid=%u"},
-	{Opt_gid, "gid=%u"},
-	{Opt_mode, "mode=%u"},
-	{Opt_dmode, "dmode=%u"},
-	{Opt_overriderockperm, "overriderockperm"},
-	{Opt_block, "block=%u"},
-	{Opt_ignore, "conv=binary"},
-	{Opt_ignore, "conv=b"},
-	{Opt_ignore, "conv=text"},
-	{Opt_ignore, "conv=t"},
-	{Opt_ignore, "conv=mtext"},
-	{Opt_ignore, "conv=m"},
-	{Opt_ignore, "conv=auto"},
-	{Opt_ignore, "conv=a"},
-	{Opt_nocompress, "nocompress"},
-	{Opt_err, NULL}
+/* Minor abuse of constant_table w/ chars here */
+static const struct constant_table iso9660_param_map[] = {
+	{"acorn",	'a'},
+	{"a",		'a'},
+	{"normal",	'n'},
+	{"n",		'n'},
+	{"off",		'o'},
+	{"o",		'o'},
+	{}
 };
 
-static int parse_options(char *options, struct iso9660_options *popt)
-{
-	char *p;
-	int option;
-	unsigned int uv;
-
-	popt->map = 'n';
-	popt->rock = 1;
-	popt->joliet = 1;
-	popt->cruft = 0;
-	popt->hide = 0;
-	popt->showassoc = 0;
-	popt->check = 'u';		/* unset */
-	popt->nocompress = 0;
-	popt->blocksize = 1024;
-	popt->fmode = popt->dmode = ISOFS_INVALID_MODE;
-	popt->uid_set = 0;
-	popt->gid_set = 0;
-	popt->gid = GLOBAL_ROOT_GID;
-	popt->uid = GLOBAL_ROOT_UID;
-	popt->iocharset = NULL;
-	popt->overriderockperm = 0;
-	popt->session=-1;
-	popt->sbsector=-1;
-	if (!options)
-		return 1;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
-		substring_t args[MAX_OPT_ARGS];
-		unsigned n;
-
-		if (!*p)
-			continue;
+static const struct constant_table iso9660_param_check[] = {
+	{"relaxed",	'r'},
+	{"r",		'r'},
+	{"strict",	's'},
+	{"s",		's'},
+	{}
+};
 
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_norock:
-			popt->rock = 0;
-			break;
-		case Opt_nojoliet:
-			popt->joliet = 0;
-			break;
-		case Opt_hide:
-			popt->hide = 1;
-			break;
-		case Opt_unhide:
-		case Opt_showassoc:
-			popt->showassoc = 1;
-			break;
-		case Opt_cruft:
-			popt->cruft = 1;
-			break;
+static const struct fs_parameter_spec iso9660_param_spec[] = {
+	fsparam_flag	("norock",		Opt_norock),
+	fsparam_flag	("nojoliet",		Opt_nojoliet),
+	fsparam_flag	("unhide",		Opt_unhide),
+	fsparam_flag	("hide",		Opt_hide),
+	fsparam_flag	("showassoc",		Opt_showassoc),
+	fsparam_flag	("cruft",		Opt_cruft),
+	fsparam_flag	("utf8",		Opt_utf8),
+	fsparam_string	("iocharset",		Opt_iocharset),
+	fsparam_enum	("map",			Opt_map, iso9660_param_map),
+	fsparam_u32	("session",		Opt_session),
+	fsparam_u32	("sbsector",		Opt_sb),
+	fsparam_enum	("check",		Opt_check, iso9660_param_check),
+	fsparam_u32	("uid",			Opt_uid),
+	fsparam_u32	("gid",			Opt_gid),
+	/* Note: mode/dmode historically accepted %u not strictly %o */
+	fsparam_u32	("mode",		Opt_mode),
+	fsparam_u32	("dmode",		Opt_dmode),
+	fsparam_flag	("overriderockperm",	Opt_overriderockperm),
+	fsparam_u32	("block",		Opt_block),
+	fsparam_string	("conv",		Opt_ignore),
+	fsparam_flag	("nocompress",		Opt_nocompress),
+	{}
+};
+
+static int iso9660_parse_param(struct fs_context *fc,
+			       struct fs_parameter *param)
+{
+	struct iso9660_options *popt = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
+	kuid_t uid;
+	kgid_t gid;
+	unsigned int n;
+
+	/* There are no remountable options */
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
+		return 0;
+
+	opt = fs_parse(fc, iso9660_param_spec, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_norock:
+		popt->rock = 0;
+		break;
+	case Opt_nojoliet:
+		popt->joliet = 0;
+		break;
+	case Opt_hide:
+		popt->hide = 1;
+		break;
+	case Opt_unhide:
+	case Opt_showassoc:
+		popt->showassoc = 1;
+		break;
+	case Opt_cruft:
+		popt->cruft = 1;
+		break;
 #ifdef CONFIG_JOLIET
-		case Opt_utf8:
-			kfree(popt->iocharset);
-			popt->iocharset = kstrdup("utf8", GFP_KERNEL);
-			if (!popt->iocharset)
-				return 0;
-			break;
-		case Opt_iocharset:
-			kfree(popt->iocharset);
-			popt->iocharset = match_strdup(&args[0]);
-			if (!popt->iocharset)
-				return 0;
-			break;
+	case Opt_utf8:
+		kfree(popt->iocharset);
+		popt->iocharset = kstrdup("utf8", GFP_KERNEL);
+		if (!popt->iocharset)
+			return -ENOMEM;
+		break;
+	case Opt_iocharset:
+		kfree(popt->iocharset);
+		popt->iocharset = kstrdup(param->string, GFP_KERNEL);
+		if (!popt->iocharset)
+			return -ENOMEM;
+		break;
 #endif
-		case Opt_map_a:
-			popt->map = 'a';
-			break;
-		case Opt_map_o:
-			popt->map = 'o';
-			break;
-		case Opt_map_n:
-			popt->map = 'n';
-			break;
-		case Opt_session:
-			if (match_int(&args[0], &option))
-				return 0;
-			n = option;
-			/*
-			 * Track numbers are supposed to be in range 1-99, the
-			 * mount option starts indexing at 0.
-			 */
-			if (n >= 99)
-				return 0;
-			popt->session = n + 1;
-			break;
-		case Opt_sb:
-			if (match_int(&args[0], &option))
-				return 0;
-			popt->sbsector = option;
-			break;
-		case Opt_check_r:
-			popt->check = 'r';
-			break;
-		case Opt_check_s:
-			popt->check = 's';
-			break;
-		case Opt_ignore:
-			break;
-		case Opt_uid:
-			if (match_uint(&args[0], &uv))
-				return 0;
-			popt->uid = make_kuid(current_user_ns(), uv);
-			if (!uid_valid(popt->uid))
-				return 0;
-			popt->uid_set = 1;
-			break;
-		case Opt_gid:
-			if (match_uint(&args[0], &uv))
-				return 0;
-			popt->gid = make_kgid(current_user_ns(), uv);
-			if (!gid_valid(popt->gid))
-				return 0;
-			popt->gid_set = 1;
-			break;
-		case Opt_mode:
-			if (match_int(&args[0], &option))
-				return 0;
-			popt->fmode = option;
-			break;
-		case Opt_dmode:
-			if (match_int(&args[0], &option))
-				return 0;
-			popt->dmode = option;
-			break;
-		case Opt_overriderockperm:
-			popt->overriderockperm = 1;
-			break;
-		case Opt_block:
-			if (match_int(&args[0], &option))
-				return 0;
-			n = option;
-			if (n != 512 && n != 1024 && n != 2048)
-				return 0;
-			popt->blocksize = n;
-			break;
-		case Opt_nocompress:
-			popt->nocompress = 1;
-			break;
-		default:
-			return 0;
-		}
+	case Opt_map:
+		popt->map = result.uint_32;
+		break;
+	case Opt_session:
+		n = result.uint_32;
+		/*
+		 * Track numbers are supposed to be in range 1-99, the
+		 * mount option starts indexing at 0.
+		 */
+		if (n >= 99)
+			return -EINVAL;
+		popt->session = n + 1;
+		break;
+	case Opt_sb:
+		popt->sbsector = result.uint_32;
+		break;
+	case Opt_check:
+		popt->check = result.uint_32;
+		break;
+	case Opt_ignore:
+		break;
+	case Opt_uid:
+		uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(uid))
+			return -EINVAL;
+		popt->uid = uid;
+		popt->uid_set = 1;
+		break;
+	case Opt_gid:
+		gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(gid))
+			return -EINVAL;
+		popt->gid = gid;
+		popt->gid_set = 1;
+		break;
+	case Opt_mode:
+		popt->fmode = result.uint_32;
+		break;
+	case Opt_dmode:
+		popt->dmode = result.uint_32;
+		break;
+	case Opt_overriderockperm:
+		popt->overriderockperm = 1;
+		break;
+	case Opt_block:
+		n = result.uint_32;
+		if (n != 512 && n != 1024 && n != 2048)
+			return -EINVAL;
+		popt->blocksize = n;
+		break;
+	case Opt_nocompress:
+		popt->nocompress = 1;
+		break;
+	default:
+		return -EINVAL;
 	}
-	return 1;
+	return 0;
 }
 
 /*
@@ -615,7 +580,7 @@ static bool rootdir_empty(struct super_block *sb, unsigned long block)
 /*
  * Initialize the superblock and read the root inode.
  */
-static int isofs_fill_super(struct super_block *s, void *data, int silent)
+static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
 {
 	struct buffer_head *bh = NULL, *pri_bh = NULL;
 	struct hs_primary_descriptor *h_pri = NULL;
@@ -623,7 +588,7 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 	struct iso_supplementary_descriptor *sec = NULL;
 	struct iso_directory_record *rootp;
 	struct inode *inode;
-	struct iso9660_options opt;
+	struct iso9660_options *opt = fc->fs_private;
 	struct isofs_sb_info *sbi;
 	unsigned long first_data_zone;
 	int joliet_level = 0;
@@ -631,15 +596,13 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 	int orig_zonesize;
 	int table, error = -EINVAL;
 	unsigned int vol_desc_start;
+	int silent = fc->sb_flags & SB_SILENT;
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
 	s->s_fs_info = sbi;
 
-	if (!parse_options((char *)data, &opt))
-		goto out_freesbi;
-
 	/*
 	 * First of all, get the hardware blocksize for this device.
 	 * If we don't know what it is, or the hardware blocksize is
@@ -655,14 +618,14 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 			bdev_logical_block_size(s->s_bdev));
 		goto out_freesbi;
 	}
-	opt.blocksize = sb_min_blocksize(s, opt.blocksize);
+	opt->blocksize = sb_min_blocksize(s, opt->blocksize);
 
 	sbi->s_high_sierra = 0; /* default is iso9660 */
-	sbi->s_session = opt.session;
-	sbi->s_sbsector = opt.sbsector;
+	sbi->s_session = opt->session;
+	sbi->s_sbsector = opt->sbsector;
 
-	vol_desc_start = (opt.sbsector != -1) ?
-		opt.sbsector : isofs_get_last_session(s,opt.session);
+	vol_desc_start = (opt->sbsector != -1) ?
+		opt->sbsector : isofs_get_last_session(s, opt->session);
 
 	for (iso_blknum = vol_desc_start+16;
 		iso_blknum < vol_desc_start+100; iso_blknum++) {
@@ -696,7 +659,7 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 			else if (isonum_711(vdp->type) == ISO_VD_SUPPLEMENTARY) {
 				sec = (struct iso_supplementary_descriptor *)vdp;
 				if (sec->escape[0] == 0x25 && sec->escape[1] == 0x2f) {
-					if (opt.joliet) {
+					if (opt->joliet) {
 						if (sec->escape[2] == 0x40)
 							joliet_level = 1;
 						else if (sec->escape[2] == 0x43)
@@ -721,7 +684,7 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 					goto out_freebh;
 
 				sbi->s_high_sierra = 1;
-				opt.rock = 0;
+				opt->rock = 0;
 				h_pri = (struct hs_primary_descriptor *)vdp;
 				goto root_found;
 			}
@@ -749,7 +712,7 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 		goto out_freebh;
 	}
 
-	if (joliet_level && (!pri || !opt.rock)) {
+	if (joliet_level && (!pri || !opt->rock)) {
 		/* This is the case of Joliet with the norock mount flag.
 		 * A disc with both Joliet and Rock Ridge is handled later
 		 */
@@ -780,7 +743,7 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 	 * blocks that were 512 bytes (which should only very rarely
 	 * happen.)
 	 */
-	if (orig_zonesize < opt.blocksize)
+	if (orig_zonesize < opt->blocksize)
 		goto out_bad_size;
 
 	/* RDE: convert log zone size to bit shift */
@@ -865,10 +828,10 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 
 #ifdef CONFIG_JOLIET
 	if (joliet_level) {
-		char *p = opt.iocharset ? opt.iocharset : CONFIG_NLS_DEFAULT;
+		char *p = opt->iocharset ? opt->iocharset : CONFIG_NLS_DEFAULT;
 		if (strcmp(p, "utf8") != 0) {
-			sbi->s_nls_iocharset = opt.iocharset ?
-				load_nls(opt.iocharset) : load_nls_default();
+			sbi->s_nls_iocharset = opt->iocharset ?
+				load_nls(opt->iocharset) : load_nls_default();
 			if (!sbi->s_nls_iocharset)
 				goto out_freesbi;
 		}
@@ -876,29 +839,29 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 #endif
 	s->s_op = &isofs_sops;
 	s->s_export_op = &isofs_export_ops;
-	sbi->s_mapping = opt.map;
-	sbi->s_rock = (opt.rock ? 2 : 0);
+	sbi->s_mapping = opt->map;
+	sbi->s_rock = (opt->rock ? 2 : 0);
 	sbi->s_rock_offset = -1; /* initial offset, will guess until SP is found*/
-	sbi->s_cruft = opt.cruft;
-	sbi->s_hide = opt.hide;
-	sbi->s_showassoc = opt.showassoc;
-	sbi->s_uid = opt.uid;
-	sbi->s_gid = opt.gid;
-	sbi->s_uid_set = opt.uid_set;
-	sbi->s_gid_set = opt.gid_set;
-	sbi->s_nocompress = opt.nocompress;
-	sbi->s_overriderockperm = opt.overriderockperm;
+	sbi->s_cruft = opt->cruft;
+	sbi->s_hide = opt->hide;
+	sbi->s_showassoc = opt->showassoc;
+	sbi->s_uid = opt->uid;
+	sbi->s_gid = opt->gid;
+	sbi->s_uid_set = opt->uid_set;
+	sbi->s_gid_set = opt->gid_set;
+	sbi->s_nocompress = opt->nocompress;
+	sbi->s_overriderockperm = opt->overriderockperm;
 	/*
 	 * It would be incredibly stupid to allow people to mark every file
 	 * on the disk as suid, so we merely allow them to set the default
 	 * permissions.
 	 */
-	if (opt.fmode != ISOFS_INVALID_MODE)
-		sbi->s_fmode = opt.fmode & 0777;
+	if (opt->fmode != ISOFS_INVALID_MODE)
+		sbi->s_fmode = opt->fmode & 0777;
 	else
 		sbi->s_fmode = ISOFS_INVALID_MODE;
-	if (opt.dmode != ISOFS_INVALID_MODE)
-		sbi->s_dmode = opt.dmode & 0777;
+	if (opt->dmode != ISOFS_INVALID_MODE)
+		sbi->s_dmode = opt->dmode & 0777;
 	else
 		sbi->s_dmode = ISOFS_INVALID_MODE;
 
@@ -946,12 +909,12 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 		}
 	}
 
-	if (opt.check == 'u') {
+	if (opt->check == 'u') {
 		/* Only Joliet is case insensitive by default */
 		if (joliet_level)
-			opt.check = 'r';
+			opt->check = 'r';
 		else
-			opt.check = 's';
+			opt->check = 's';
 	}
 	sbi->s_joliet_level = joliet_level;
 
@@ -966,9 +929,9 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 	table = 0;
 	if (joliet_level)
 		table += 2;
-	if (opt.check == 'r')
+	if (opt->check == 'r')
 		table++;
-	sbi->s_check = opt.check;
+	sbi->s_check = opt->check;
 
 	if (table)
 		s->s_d_op = &isofs_dentry_ops[table - 1];
@@ -980,7 +943,7 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 		goto out_no_inode;
 	}
 
-	kfree(opt.iocharset);
+	kfree(opt->iocharset);
 
 	return 0;
 
@@ -1009,7 +972,7 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 	goto out_freebh;
 out_bad_size:
 	printk(KERN_WARNING "ISOFS: Logical zone size(%d) < hardware blocksize(%u)\n",
-		orig_zonesize, opt.blocksize);
+		orig_zonesize, opt->blocksize);
 	goto out_freebh;
 out_unknown_format:
 	if (!silent)
@@ -1019,7 +982,7 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 	brelse(bh);
 	brelse(pri_bh);
 out_freesbi:
-	kfree(opt.iocharset);
+	kfree(opt->iocharset);
 	kfree(sbi);
 	s->s_fs_info = NULL;
 	return error;
@@ -1553,18 +1516,63 @@ struct inode *__isofs_iget(struct super_block *sb,
 	return inode;
 }
 
-static struct dentry *isofs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int iso9660_get_tree(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, isofs_fill_super);
+	return get_tree_bdev(fc, isofs_fill_super);
+}
+
+static void iso9660_free_fc(struct fs_context *fc)
+{
+	kfree(fc->fs_private);
+}
+
+static const struct fs_context_operations iso9660_context_ops = {
+	.parse_param	= iso9660_parse_param,
+	.get_tree	= iso9660_get_tree,
+	.reconfigure	= iso9660_reconfigure,
+	.free		= iso9660_free_fc,
+};
+
+static int iso9660_init_fs_context(struct fs_context *fc)
+{
+	struct iso9660_options *opt;
+
+	opt = kzalloc(sizeof(*opt), GFP_KERNEL);
+	if (!opt)
+		return -ENOMEM;
+
+	opt->map = 'n';
+	opt->rock = 1;
+	opt->joliet = 1;
+	opt->cruft = 0;
+	opt->hide = 0;
+	opt->showassoc = 0;
+	opt->check = 'u';		/* unset */
+	opt->nocompress = 0;
+	opt->blocksize = 1024;
+	opt->fmode = opt->dmode = ISOFS_INVALID_MODE;
+	opt->uid_set = 0;
+	opt->gid_set = 0;
+	opt->gid = GLOBAL_ROOT_GID;
+	opt->uid = GLOBAL_ROOT_UID;
+	opt->iocharset = NULL;
+	opt->overriderockperm = 0;
+	opt->session = -1;
+	opt->sbsector = -1;
+
+	fc->fs_private = opt;
+	fc->ops = &iso9660_context_ops;
+
+	return 0;
 }
 
 static struct file_system_type iso9660_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "iso9660",
-	.mount		= isofs_mount,
 	.kill_sb	= kill_block_super,
 	.fs_flags	= FS_REQUIRES_DEV,
+	.init_fs_context = iso9660_init_fs_context,
+	.parameters	= iso9660_param_spec,
 };
 MODULE_ALIAS_FS("iso9660");
 MODULE_ALIAS("iso9660");


