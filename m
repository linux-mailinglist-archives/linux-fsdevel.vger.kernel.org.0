Return-Path: <linux-fsdevel+bounces-29589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEDD97B1A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 16:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D571C2184A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E82177982;
	Tue, 17 Sep 2024 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="OP3OP8fJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hHXOSfA/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B4535DC
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726584795; cv=none; b=gQBxK2x5wNJ2Dh8WRfx0WE4uQtZwdi+5a/Y3Gm7DC6aAfIVoBjuxuxGJqW911eaQxM/pgGi9HJqct2gd6x4r/bjXNp6o9Dpy8vXfcZAtwRgN7t7gtL8E4+mNPC9BIco/YyMxOOXe7WG+3lyyrCulxSf+jK7RjgpDpG0FqEphq4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726584795; c=relaxed/simple;
	bh=YCnWMHJ6KfW7jYnyTYHj6uL4zur1AaMine1yobP3Un8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rv5FrcGh+K9EsxPcaCUDDBbDDokAgVkCfFoEbVKROBh2ZxqBrnVbHVwbWfH7xqKwAytptnmNcU2TgBsdPXk5OKC8KEGaii26x7uZdHqB13/ysNtio/FFQJPmpMrWp7I9wgMGO3YWIOURWcgdaEAuAoB+2Y0fVV5rZrxa9clZ5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=OP3OP8fJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hHXOSfA/; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 97FCD11400BC;
	Tue, 17 Sep 2024 10:53:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 17 Sep 2024 10:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726584791;
	 x=1726671191; bh=K2FR8FrqejQyCqrrRHQQH9ynr2ysT9YBfnIWk3F+0tY=; b=
	OP3OP8fJ8IV7vAxf01SjiAiM4ekfJ0WtrrvXN2FRo7I8EPdpzZZq83VptxOHcZVo
	nkmFvQHYwLn8YRC4R8EFNPzCMYD89PzhVCaqzGGRoDSHBhxXZJt8etyNJvVYhx0v
	lOKpgmQYniWBXQc2d6nSHg7F4KsfG+Abx97Ty0M4jujDc5gmX5CI+leGiN30uIUJ
	alFr6FIm86dhi7CStT2ZZbG4b5y7ZIGYD3ABAFmB8HPV6UWVJVnRuw7LnRFjX+Fm
	5cOAVwu84pU4io07D+ZeRTOoZS0zSQ2ns5SVdSJ1A+bwV7ZHUG1bWqT4XH2rnw/C
	ueYUYaMX/gj4pN4oJ1D+og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726584791; x=
	1726671191; bh=K2FR8FrqejQyCqrrRHQQH9ynr2ysT9YBfnIWk3F+0tY=; b=h
	HXOSfA/blWak+wq++uZ9Va/rKncoK5ujhWMqfgutbIHbxSQRs4lyf/cCIOU9+HBz
	dKDoE3XvS8OMWVzpbByRYnYxnS/o8M/afBAnmT6QGGYoZWD6ouVhbEqbGGaJO5Z7
	ZKSfFY79xvg2HM3YSem0fM+bphF2q7pzeSU+FRYWNB5Fp3rtVzGUuovhwnwpWGba
	Fe2nUBCvNNvzEx6HmRYHpPXWIA/aMeJTvMmsXHsOCbFEhFHlmyeHu5FGtzM687Z/
	MDHSSDQT9agD5wtLXF0J08XdSSiZGP7JJ9GV083pLT1LnCfQF7N1x6RDTh23SF6f
	0m4PN/TVrDVJEUxapYTyw==
X-ME-Sender: <xms:15fpZj_a7ZBUIUxJYcUttOlguSSuntLYrR_PGUMvCpZOGGpCYMaOSw>
    <xme:15fpZvuiZIOXquD33A40lHprA6kiIcHiKt0j_nNPrzOuvU1MymHnIyuFCMGq8-1sj
    Ylt3vzIaAKlTh8XvC0>
X-ME-Received: <xmr:15fpZhA_Cz1bNOLZWqgEeHUZVmITPGbWVlC0AIclKJcG4I5rw__JLAFx4aCAxo-xpPhPg2jKWreW2v3s0KTCoDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnuggvvg
    hnrdhnvghtqeenucggtffrrghtthgvrhhnpeevieekueetfeeujedtheeffedvgeffiedv
    jeejleffhfeggeejuedtjeeulefhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggvvg
    hnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthht
    ohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:15fpZvelFWD5-nPFiBlDtR31pd5NB5y0dP2OSyGECei9FHIMZm0kYQ>
    <xmx:15fpZoNYS8qkfpvWOS4NZokR0bw9bLRZSVU75JI7xJoqZDwIEmsF2A>
    <xmx:15fpZhn-RIeE_xJXKGjvOqGRM-oglPe6Mw97MnjDGMfZmZGgVO6cIQ>
    <xmx:15fpZis4VPQ6bM5QQhcPWCXYTQ4UnQa6y9VzW3aaZtYBqYF0B34dmQ>
    <xmx:15fpZn3lnEp6AZfJMtAr2-4pXzR36YjqTt16PMEJeCaIb6K_Yx6l_BvD>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 10:53:10 -0400 (EDT)
Message-ID: <a1c72d1a-8389-45cb-9aa6-638bfa1ebc23@sandeen.net>
Date: Tue, 17 Sep 2024 09:53:09 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/5 V2] affs: convert affs to use the new mount api
To: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>
References: <20240916172735.866916-1-sandeen@redhat.com>
 <20240916172735.866916-3-sandeen@redhat.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240916172735.866916-3-sandeen@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert the affs filesystem to use the new mount API.
Tested by comparing random mount & remount options before and after
the change.

Cc: David Sterba <dsterba@suse.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---

V2: Remove extra braces and stray whitespace (oops)

diff --git a/fs/affs/super.c b/fs/affs/super.c
index 3c5821339609..2fa40337776d 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -14,7 +14,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/statfs.h>
-#include <linux/parser.h>
+#include <linux/fs_parser.h>
+#include <linux/fs_context.h>
 #include <linux/magic.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
@@ -27,7 +28,6 @@
 
 static int affs_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int affs_show_options(struct seq_file *m, struct dentry *root);
-static int affs_remount (struct super_block *sb, int *flags, char *data);
 
 static void
 affs_commit_super(struct super_block *sb, int wait)
@@ -155,140 +155,114 @@ static const struct super_operations affs_sops = {
 	.put_super	= affs_put_super,
 	.sync_fs	= affs_sync_fs,
 	.statfs		= affs_statfs,
-	.remount_fs	= affs_remount,
 	.show_options	= affs_show_options,
 };
 
 enum {
 	Opt_bs, Opt_mode, Opt_mufs, Opt_notruncate, Opt_prefix, Opt_protect,
 	Opt_reserved, Opt_root, Opt_setgid, Opt_setuid,
-	Opt_verbose, Opt_volume, Opt_ignore, Opt_err,
+	Opt_verbose, Opt_volume, Opt_ignore,
 };
 
-static const match_table_t tokens = {
-	{Opt_bs, "bs=%u"},
-	{Opt_mode, "mode=%o"},
-	{Opt_mufs, "mufs"},
-	{Opt_notruncate, "nofilenametruncate"},
-	{Opt_prefix, "prefix=%s"},
-	{Opt_protect, "protect"},
-	{Opt_reserved, "reserved=%u"},
-	{Opt_root, "root=%u"},
-	{Opt_setgid, "setgid=%u"},
-	{Opt_setuid, "setuid=%u"},
-	{Opt_verbose, "verbose"},
-	{Opt_volume, "volume=%s"},
-	{Opt_ignore, "grpquota"},
-	{Opt_ignore, "noquota"},
-	{Opt_ignore, "quota"},
-	{Opt_ignore, "usrquota"},
-	{Opt_err, NULL},
+struct affs_context {
+	kuid_t		uid;		/* uid to override */
+	kgid_t		gid;		/* gid to override */
+	unsigned int	mode;		/* mode to override */
+	unsigned int	reserved;	/* Number of reserved blocks */
+	int		root_block;	/* FFS root block number */
+	int		blocksize;	/* Initial device blksize */
+	char		*prefix;	/* Prefix for volumes and assigns */
+	char		volume[32];	/* Vol. prefix for absolute symlinks */
+	unsigned long	mount_flags;	/* Options */
 };
 
-static int
-parse_options(char *options, kuid_t *uid, kgid_t *gid, int *mode, int *reserved, s32 *root,
-		int *blocksize, char **prefix, char *volume, unsigned long *mount_opts)
+static const struct fs_parameter_spec affs_param_spec[] = {
+	fsparam_u32	("bs",		Opt_bs),
+	fsparam_u32oct	("mode",	Opt_mode),
+	fsparam_flag	("mufs",	Opt_mufs),
+	fsparam_flag	("nofilenametruncate",	Opt_notruncate),
+	fsparam_string	("prefix",	Opt_prefix),
+	fsparam_flag	("protect",	Opt_protect),
+	fsparam_u32	("reserved",	Opt_reserved),
+	fsparam_u32	("root",	Opt_root),
+	fsparam_gid	("setgid",	Opt_setgid),
+	fsparam_uid	("setuid",	Opt_setuid),
+	fsparam_flag	("verbose",	Opt_verbose),
+	fsparam_string	("volume",	Opt_volume),
+	fsparam_flag	("grpquota",	Opt_ignore),
+	fsparam_flag	("noquota",	Opt_ignore),
+	fsparam_flag	("quota",	Opt_ignore),
+	fsparam_flag	("usrquota",	Opt_ignore),
+	{},
+};
+
+static int affs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-
-	/* Fill in defaults */
-
-	*uid        = current_uid();
-	*gid        = current_gid();
-	*reserved   = 2;
-	*root       = -1;
-	*blocksize  = -1;
-	volume[0]   = ':';
-	volume[1]   = 0;
-	*mount_opts = 0;
-	if (!options)
-		return 1;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token, n, option;
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_bs:
-			if (match_int(&args[0], &n))
-				return 0;
-			if (n != 512 && n != 1024 && n != 2048
-			    && n != 4096) {
-				pr_warn("Invalid blocksize (512, 1024, 2048, 4096 allowed)\n");
-				return 0;
-			}
-			*blocksize = n;
-			break;
-		case Opt_mode:
-			if (match_octal(&args[0], &option))
-				return 0;
-			*mode = option & 0777;
-			affs_set_opt(*mount_opts, SF_SETMODE);
-			break;
-		case Opt_mufs:
-			affs_set_opt(*mount_opts, SF_MUFS);
-			break;
-		case Opt_notruncate:
-			affs_set_opt(*mount_opts, SF_NO_TRUNCATE);
-			break;
-		case Opt_prefix:
-			kfree(*prefix);
-			*prefix = match_strdup(&args[0]);
-			if (!*prefix)
-				return 0;
-			affs_set_opt(*mount_opts, SF_PREFIX);
-			break;
-		case Opt_protect:
-			affs_set_opt(*mount_opts, SF_IMMUTABLE);
-			break;
-		case Opt_reserved:
-			if (match_int(&args[0], reserved))
-				return 0;
-			break;
-		case Opt_root:
-			if (match_int(&args[0], root))
-				return 0;
-			break;
-		case Opt_setgid:
-			if (match_int(&args[0], &option))
-				return 0;
-			*gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(*gid))
-				return 0;
-			affs_set_opt(*mount_opts, SF_SETGID);
-			break;
-		case Opt_setuid:
-			if (match_int(&args[0], &option))
-				return 0;
-			*uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(*uid))
-				return 0;
-			affs_set_opt(*mount_opts, SF_SETUID);
-			break;
-		case Opt_verbose:
-			affs_set_opt(*mount_opts, SF_VERBOSE);
-			break;
-		case Opt_volume: {
-			char *vol = match_strdup(&args[0]);
-			if (!vol)
-				return 0;
-			strscpy(volume, vol, 32);
-			kfree(vol);
-			break;
-		}
-		case Opt_ignore:
-		 	/* Silently ignore the quota options */
-			break;
-		default:
-			pr_warn("Unrecognized mount option \"%s\" or missing value\n",
-				p);
-			return 0;
+	struct affs_context *ctx = fc->fs_private;
+	struct fs_parse_result result;
+	int n;
+	int opt;
+
+	opt = fs_parse(fc, affs_param_spec, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_bs:
+		n = result.uint_32;
+		if (n != 512 && n != 1024 && n != 2048
+		    && n != 4096) {
+			pr_warn("Invalid blocksize (512, 1024, 2048, 4096 allowed)\n");
+			return -EINVAL;
 		}
+		ctx->blocksize = n;
+		break;
+	case Opt_mode:
+		ctx->mode = result.uint_32 & 0777;
+		affs_set_opt(ctx->mount_flags, SF_SETMODE);
+		break;
+	case Opt_mufs:
+		affs_set_opt(ctx->mount_flags, SF_MUFS);
+		break;
+	case Opt_notruncate:
+		affs_set_opt(ctx->mount_flags, SF_NO_TRUNCATE);
+		break;
+	case Opt_prefix:
+		kfree(ctx->prefix);
+		ctx->prefix = param->string;
+		param->string = NULL;
+		affs_set_opt(ctx->mount_flags, SF_PREFIX);
+		break;
+	case Opt_protect:
+		affs_set_opt(ctx->mount_flags, SF_IMMUTABLE);
+		break;
+	case Opt_reserved:
+		ctx->reserved = result.uint_32;
+		break;
+	case Opt_root:
+		ctx->root_block = result.uint_32;
+		break;
+	case Opt_setgid:
+		ctx->gid = result.gid;
+		affs_set_opt(ctx->mount_flags, SF_SETGID);
+		break;
+	case Opt_setuid:
+		ctx->uid = result.uid;
+		affs_set_opt(ctx->mount_flags, SF_SETUID);
+		break;
+	case Opt_verbose:
+		affs_set_opt(ctx->mount_flags, SF_VERBOSE);
+		break;
+	case Opt_volume:
+		strscpy(ctx->volume, param->string, 32);
+		break;
+	case Opt_ignore:
+		/* Silently ignore the quota options */
+		break;
+	default:
+		return -EINVAL;
 	}
-	return 1;
+	return 0;
 }
 
 static int affs_show_options(struct seq_file *m, struct dentry *root)
@@ -329,27 +303,22 @@ static int affs_show_options(struct seq_file *m, struct dentry *root)
  * hopefully have the guts to do so. Until then: sorry for the mess.
  */
 
-static int affs_fill_super(struct super_block *sb, void *data, int silent)
+static int affs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct affs_sb_info	*sbi;
+	struct affs_context	*ctx = fc->fs_private;
 	struct buffer_head	*root_bh = NULL;
 	struct buffer_head	*boot_bh;
 	struct inode		*root_inode = NULL;
-	s32			 root_block;
+	int			 silent = fc->sb_flags & SB_SILENT;
 	int			 size, blocksize;
 	u32			 chksum;
 	int			 num_bm;
 	int			 i, j;
-	kuid_t			 uid;
-	kgid_t			 gid;
-	int			 reserved;
-	unsigned long		 mount_flags;
 	int			 tmp_flags;	/* fix remount prototype... */
 	u8			 sig[4];
 	int			 ret;
 
-	pr_debug("read_super(%s)\n", data ? (const char *)data : "no options");
-
 	sb->s_magic             = AFFS_SUPER_MAGIC;
 	sb->s_op                = &affs_sops;
 	sb->s_flags |= SB_NODIRATIME;
@@ -369,19 +338,16 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 	spin_lock_init(&sbi->work_lock);
 	INIT_DELAYED_WORK(&sbi->sb_work, flush_superblock);
 
-	if (!parse_options(data,&uid,&gid,&i,&reserved,&root_block,
-				&blocksize,&sbi->s_prefix,
-				sbi->s_volume, &mount_flags)) {
-		pr_err("Error parsing options\n");
-		return -EINVAL;
-	}
-	/* N.B. after this point s_prefix must be released */
+	sbi->s_flags	= ctx->mount_flags;
+	sbi->s_mode	= ctx->mode;
+	sbi->s_uid	= ctx->uid;
+	sbi->s_gid	= ctx->gid;
+	sbi->s_reserved	= ctx->reserved;
+	sbi->s_prefix	= ctx->prefix;
+	ctx->prefix	= NULL;
+	memcpy(sbi->s_volume, ctx->volume, 32);
 
-	sbi->s_flags   = mount_flags;
-	sbi->s_mode    = i;
-	sbi->s_uid     = uid;
-	sbi->s_gid     = gid;
-	sbi->s_reserved= reserved;
+	/* N.B. after this point s_prefix must be released */
 
 	/* Get the size of the device in 512-byte blocks.
 	 * If we later see that the partition uses bigger
@@ -396,15 +362,16 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 
 	i = bdev_logical_block_size(sb->s_bdev);
 	j = PAGE_SIZE;
+	blocksize = ctx->blocksize;
 	if (blocksize > 0) {
 		i = j = blocksize;
 		size = size / (blocksize / 512);
 	}
 
 	for (blocksize = i; blocksize <= j; blocksize <<= 1, size >>= 1) {
-		sbi->s_root_block = root_block;
-		if (root_block < 0)
-			sbi->s_root_block = (reserved + size - 1) / 2;
+		sbi->s_root_block = ctx->root_block;
+		if (ctx->root_block < 0)
+			sbi->s_root_block = (ctx->reserved + size - 1) / 2;
 		pr_debug("setting blocksize to %d\n", blocksize);
 		affs_set_blocksize(sb, blocksize);
 		sbi->s_partition_size = size;
@@ -424,7 +391,7 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 				"size=%d, reserved=%d\n",
 				sb->s_id,
 				sbi->s_root_block + num_bm,
-				blocksize, size, reserved);
+				ctx->blocksize, size, ctx->reserved);
 			root_bh = affs_bread(sb, sbi->s_root_block + num_bm);
 			if (!root_bh)
 				continue;
@@ -447,7 +414,7 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 got_root:
 	/* Keep super block in cache */
 	sbi->s_root_bh = root_bh;
-	root_block = sbi->s_root_block;
+	ctx->root_block = sbi->s_root_block;
 
 	/* Find out which kind of FS we have */
 	boot_bh = sb_bread(sb, 0);
@@ -506,7 +473,7 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 		return -EINVAL;
 	}
 
-	if (affs_test_opt(mount_flags, SF_VERBOSE)) {
+	if (affs_test_opt(ctx->mount_flags, SF_VERBOSE)) {
 		u8 len = AFFS_ROOT_TAIL(sb, root_bh)->disk_name[0];
 		pr_notice("Mounting volume \"%.*s\": Type=%.3s\\%c, Blocksize=%d\n",
 			len > 31 ? 31 : len,
@@ -528,7 +495,7 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 
 	/* set up enough so that it can read an inode */
 
-	root_inode = affs_iget(sb, root_block);
+	root_inode = affs_iget(sb, ctx->root_block);
 	if (IS_ERR(root_inode))
 		return PTR_ERR(root_inode);
 
@@ -548,56 +515,43 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 }
 
-static int
-affs_remount(struct super_block *sb, int *flags, char *data)
+static int affs_reconfigure(struct fs_context *fc)
 {
+	struct super_block	*sb = fc->root->d_sb;
+	struct affs_context	*ctx = fc->fs_private;
 	struct affs_sb_info	*sbi = AFFS_SB(sb);
-	int			 blocksize;
-	kuid_t			 uid;
-	kgid_t			 gid;
-	int			 mode;
-	int			 reserved;
-	int			 root_block;
-	unsigned long		 mount_flags;
 	int			 res = 0;
-	char			 volume[32];
-	char			*prefix = NULL;
-
-	pr_debug("%s(flags=0x%x,opts=\"%s\")\n", __func__, *flags, data);
 
 	sync_filesystem(sb);
-	*flags |= SB_NODIRATIME;
-
-	memcpy(volume, sbi->s_volume, 32);
-	if (!parse_options(data, &uid, &gid, &mode, &reserved, &root_block,
-			   &blocksize, &prefix, volume,
-			   &mount_flags)) {
-		kfree(prefix);
-		return -EINVAL;
-	}
+	fc->sb_flags |= SB_NODIRATIME;
 
 	flush_delayed_work(&sbi->sb_work);
 
-	sbi->s_flags = mount_flags;
-	sbi->s_mode  = mode;
-	sbi->s_uid   = uid;
-	sbi->s_gid   = gid;
+	/*
+	 * NB: Historically, only mount_flags, mode, uid, gic, prefix,
+	 * and volume are accepted during remount.
+	 */
+	sbi->s_flags = ctx->mount_flags;
+	sbi->s_mode  = ctx->mode;
+	sbi->s_uid   = ctx->uid;
+	sbi->s_gid   = ctx->gid;
 	/* protect against readers */
 	spin_lock(&sbi->symlink_lock);
-	if (prefix) {
+	if (ctx->prefix) {
 		kfree(sbi->s_prefix);
-		sbi->s_prefix = prefix;
+		sbi->s_prefix = ctx->prefix;
+		ctx->prefix = NULL;
 	}
-	memcpy(sbi->s_volume, volume, 32);
+	memcpy(sbi->s_volume, ctx->volume, 32);
 	spin_unlock(&sbi->symlink_lock);
 
-	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
+	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
 		return 0;
 
-	if (*flags & SB_RDONLY)
+	if (fc->sb_flags & SB_RDONLY)
 		affs_free_bitmap(sb);
 	else
-		res = affs_init_bitmap(sb, flags);
+		res = affs_init_bitmap(sb, &fc->sb_flags);
 
 	return res;
 }
@@ -624,10 +578,9 @@ affs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-static struct dentry *affs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int affs_get_tree(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, affs_fill_super);
+	return get_tree_bdev(fc, affs_fill_super);
 }
 
 static void affs_kill_sb(struct super_block *sb)
@@ -643,12 +596,61 @@ static void affs_kill_sb(struct super_block *sb)
 	}
 }
 
+static void affs_free_fc(struct fs_context *fc)
+{
+	struct affs_context *ctx = fc->fs_private;
+
+	kfree(ctx->prefix);
+	kfree(ctx);
+}
+
+static const struct fs_context_operations affs_context_ops = {
+	.parse_param	= affs_parse_param,
+	.get_tree	= affs_get_tree,
+	.reconfigure	= affs_reconfigure,
+	.free		= affs_free_fc,
+};
+
+static int affs_init_fs_context(struct fs_context *fc)
+{
+	struct affs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct affs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		struct super_block *sb = fc->root->d_sb;
+		struct affs_sb_info *sbi = AFFS_SB(sb);
+
+		/*
+		 * NB: historically, no options other than volume were
+		 * preserved across a remount unless they were explicitly
+		 * passed in.
+		 */
+		memcpy(ctx->volume, sbi->s_volume, 32);
+	} else {
+		ctx->uid	= current_uid();
+		ctx->gid	= current_gid();
+		ctx->reserved	= 2;
+		ctx->root_block	= -1;
+		ctx->blocksize	= -1;
+		ctx->volume[0]	= ':';
+	}
+
+	fc->ops = &affs_context_ops;
+	fc->fs_private = ctx;
+
+	return 0;
+}
+
 static struct file_system_type affs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "affs",
-	.mount		= affs_mount,
 	.kill_sb	= affs_kill_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
+	.init_fs_context = affs_init_fs_context,
+	.parameters	= affs_param_spec,
 };
 MODULE_ALIAS_FS("affs");
 


