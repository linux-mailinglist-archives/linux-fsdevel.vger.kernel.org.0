Return-Path: <linux-fsdevel+bounces-11015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383B084FD15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 20:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CA45B24314
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 19:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FAB84A37;
	Fri,  9 Feb 2024 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzXNVxNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD94174A
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507799; cv=none; b=udN49C1DPv/71SgdMs+iiKZBlXooifSJUqNDxbPJ2W4C9zIThUNNzw/027HeDoT6eToQo8qf/XvTIIvt452GbbBntic1KTyDOFKkltTIZx7o6HvHLy5KaHUtB9VN2NooZwQappBmiutHWY7Kd502LdYgjDjGshRJvLM9cpfUi7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507799; c=relaxed/simple;
	bh=Z9V8nh1YtExOg0m/ZBGEapTEGIpyMhTpDQOrrMiLFE4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GjIE04n0rYlKrGqnn9n961wIoY4198bLRIs6xL6lAjcdwC6w+WwhuK2RsAcOTAyBab6YzZzZF1G2sfxHnebsKnAe59/ziBVTrkkL7f7cARtrT8WYUFAyX6el3HbI3hY6rhbxEeKf41Q0fH/c+cOfq7Nw1c2AUBISNZ5vSURcBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TzXNVxNX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707507796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=meJ+xOy50Wwj52aqPCr9Up+Mw8UfCkTcPFiHDt5KzUM=;
	b=TzXNVxNXvpuEdSRrl6InvncRlzcZKFR1Ldk50AbleTnHD7FxdCTNXwom1m75Wy21wlqLJh
	fQVgGfYwMEMZe8I8Rw/N9rTUCqHPp8j/ab9R4gAybxbgQ5cD/N8873QWwAxZNeq4BROqeo
	FbDLPMuW6D7rPlEQXMyEHNCpDAZ9rw4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-mXpsCmrOMIqDGzi9mCMLlg-1; Fri, 09 Feb 2024 14:43:13 -0500
X-MC-Unique: mXpsCmrOMIqDGzi9mCMLlg-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363abe44869so11232225ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 11:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707507792; x=1708112592;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=meJ+xOy50Wwj52aqPCr9Up+Mw8UfCkTcPFiHDt5KzUM=;
        b=dZRX7Gp8N+EHF5EnudzTMx4xiIaTW/setwJEmVQGOo1uvSp4Cc2WrFCx7m1rBYaiVV
         x8PODU1+cSlzK9bBvHH6ujiktLWORGiUHz8FQWXHzT8tbU/NBWGvM/LXt+DTHUT/rZpO
         sUL/k8x/QhW7cO8kS3sJdgpEDoCAmjoB/1Y4FPwQj5WOD7KEHaCmpq4IslRWQW+EZbkr
         6QrNU2wfrH5AIig0rMO0BdxmQ52Fj5KG9idZcBs7JBO+eh0llMQxM2Q/rqJsoj/F0JOQ
         K/g82nMgamSO7/QtgsuYkvMwqc0ULFKJfefyjznGNPql0mRWlzGx8RJh/sMzRV7G7Gcx
         cVGA==
X-Gm-Message-State: AOJu0YxyqF85VoeIX3BBXZE8G3EAUl1VeoCRfseqadEdm9vxMaerZqJE
	6zlnPU1GzDajd/QMHOzv0V6PuSPXQLDQQJnySef7N+Yr5B4Nw/A80It+lc8VqRHfFdLLDnJ56cS
	68zfvfsiRe1QxLWFTRugBFkgUOO8VVBkffn7ZqUM+/99Kqw/tg2poRfDNK8dp5Y+bALxd2iagzP
	6DJHfqa84IGKC8DsvfoDGv5rtXv3q17np8oDxQhGJ35tE8xw==
X-Received: by 2002:a05:6e02:dcc:b0:363:e04b:9d98 with SMTP id l12-20020a056e020dcc00b00363e04b9d98mr262539ilj.8.1707507791566;
        Fri, 09 Feb 2024 11:43:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9+817yaVrC0LeBP9UKxKzYF/DFjp4Ix43fpBrBtcrCfW3eIl5U4viI5iLVhIx8K5fBZE3LA==
X-Received: by 2002:a05:6e02:dcc:b0:363:e04b:9d98 with SMTP id l12-20020a056e020dcc00b00363e04b9d98mr262519ilj.8.1707507791136;
        Fri, 09 Feb 2024 11:43:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcK65V1k/xaFJzoWsx+kFz7DLd0g4EhgbPyuWeapYw91P+yyZV9LLAyyX37UMZtKQHCxdDFEQevZw5t91qvcu0KpzN6co2vKlVt2HK9FF+NbhY0mVPHP8=
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id m3-20020a924b03000000b0036287013d01sm275789ilg.36.2024.02.09.11.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 11:43:10 -0800 (PST)
Message-ID: <739fe39a-0401-4f5d-aef7-759ef82b36bd@redhat.com>
Date: Fri, 9 Feb 2024 13:43:09 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Bill O'Donnell <billodo@redhat.com>,
 David Howells <dhowells@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] udf: convert to new mount API
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert the UDF filesystem to the new mount API.

UDF is slightly unique in that it always preserves prior mount
options across a remount, so that's handled by udf_init_options().

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

Tested by running through xfstests, as well as some targeted testing of
remount behavior.

NB: I did not convert i.e any udf_err() to errorf(fc, ) because the former
does some nice formatting, not sure how or if you'd like to handle that, Jan?

 fs/udf/super.c | 495 +++++++++++++++++++++++++------------------------
 1 file changed, 255 insertions(+), 240 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 928a04d9d9e0..03fa98fe4e1c 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -40,20 +40,20 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/parser.h>
 #include <linux/stat.h>
 #include <linux/cdrom.h>
 #include <linux/nls.h>
 #include <linux/vfs.h>
 #include <linux/vmalloc.h>
 #include <linux/errno.h>
-#include <linux/mount.h>
 #include <linux/seq_file.h>
 #include <linux/bitmap.h>
 #include <linux/crc-itu-t.h>
 #include <linux/log2.h>
 #include <asm/byteorder.h>
 #include <linux/iversion.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 
 #include "udf_sb.h"
 #include "udf_i.h"
@@ -91,16 +91,20 @@ enum { UDF_MAX_LINKS = 0xffff };
 #define UDF_MAX_FILESIZE (1ULL << 42)
 
 /* These are the "meat" - everything else is stuffing */
-static int udf_fill_super(struct super_block *, void *, int);
+static int udf_fill_super(struct super_block *sb, struct fs_context *fc);
 static void udf_put_super(struct super_block *);
 static int udf_sync_fs(struct super_block *, int);
-static int udf_remount_fs(struct super_block *, int *, char *);
 static void udf_load_logicalvolint(struct super_block *, struct kernel_extent_ad);
 static void udf_open_lvid(struct super_block *);
 static void udf_close_lvid(struct super_block *);
 static unsigned int udf_count_free(struct super_block *);
 static int udf_statfs(struct dentry *, struct kstatfs *);
 static int udf_show_options(struct seq_file *, struct dentry *);
+static int udf_init_fs_context(struct fs_context *fc);
+static int udf_parse_param(struct fs_context *fc, struct fs_parameter *param);
+static int udf_reconfigure(struct fs_context *fc);
+static void udf_free_fc(struct fs_context *fc);
+static const struct fs_parameter_spec udf_param_spec[];
 
 struct logicalVolIntegrityDescImpUse *udf_sb_lvidiu(struct super_block *sb)
 {
@@ -119,18 +123,25 @@ struct logicalVolIntegrityDescImpUse *udf_sb_lvidiu(struct super_block *sb)
 }
 
 /* UDF filesystem type */
-static struct dentry *udf_mount(struct file_system_type *fs_type,
-		      int flags, const char *dev_name, void *data)
+static int udf_get_tree(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, udf_fill_super);
+	return get_tree_bdev(fc, udf_fill_super);
 }
 
+static const struct fs_context_operations udf_context_ops = {
+	.parse_param	= udf_parse_param,
+	.get_tree	= udf_get_tree,
+	.reconfigure	= udf_reconfigure,
+	.free		= udf_free_fc,
+};
+
 static struct file_system_type udf_fstype = {
 	.owner		= THIS_MODULE,
 	.name		= "udf",
-	.mount		= udf_mount,
 	.kill_sb	= kill_block_super,
 	.fs_flags	= FS_REQUIRES_DEV,
+	.init_fs_context = udf_init_fs_context,
+	.parameters	= udf_param_spec,
 };
 MODULE_ALIAS_FS("udf");
 
@@ -204,7 +215,6 @@ static const struct super_operations udf_sb_ops = {
 	.put_super	= udf_put_super,
 	.sync_fs	= udf_sync_fs,
 	.statfs		= udf_statfs,
-	.remount_fs	= udf_remount_fs,
 	.show_options	= udf_show_options,
 };
 
@@ -223,6 +233,58 @@ struct udf_options {
 	struct nls_table *nls_map;
 };
 
+/*
+ * UDF has historically preserved prior mount options across
+ * a remount, so copy those here if remounting, otherwise set
+ * initial mount defaults.
+ */
+static void udf_init_options(struct fs_context *fc, struct udf_options *uopt)
+{
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		struct super_block *sb = fc->root->d_sb;
+		struct udf_sb_info *sbi = UDF_SB(sb);
+
+		uopt->flags = sbi->s_flags;
+		uopt->uid   = sbi->s_uid;
+		uopt->gid   = sbi->s_gid;
+		uopt->umask = sbi->s_umask;
+		uopt->fmode = sbi->s_fmode;
+		uopt->dmode = sbi->s_dmode;
+		uopt->nls_map = NULL;
+	} else {
+		uopt->flags = (1 << UDF_FLAG_USE_AD_IN_ICB) | (1 << UDF_FLAG_STRICT);
+		/* By default we'll use overflow[ug]id when UDF inode [ug]id == -1 */
+		uopt->uid = make_kuid(current_user_ns(), overflowuid);
+		uopt->gid = make_kgid(current_user_ns(), overflowgid);
+		uopt->umask = 0;
+		uopt->fmode = UDF_INVALID_MODE;
+		uopt->dmode = UDF_INVALID_MODE;
+		uopt->nls_map = NULL;
+		uopt->session = 0xFFFFFFFF;
+	}
+}
+
+static int udf_init_fs_context(struct fs_context *fc)
+{
+	struct udf_options *uopt;
+
+	uopt = kzalloc(sizeof(*uopt), GFP_KERNEL);
+	if (!uopt)
+		return -ENOMEM;
+
+	udf_init_options(fc, uopt);
+
+	fc->fs_private = uopt;
+	fc->ops = &udf_context_ops;
+
+	return 0;
+}
+
+static void udf_free_fc(struct fs_context *fc)
+{
+	kfree(fc->fs_private);
+}
+
 static int __init init_udf_fs(void)
 {
 	int err;
@@ -358,7 +420,7 @@ static int udf_show_options(struct seq_file *seq, struct dentry *root)
 }
 
 /*
- * udf_parse_options
+ * udf_parse_param
  *
  * PURPOSE
  *	Parse mount options.
@@ -401,12 +463,12 @@ static int udf_show_options(struct seq_file *seq, struct dentry *root)
  *		yield highly unpredictable results.
  *
  * PRE-CONDITIONS
- *	options		Pointer to mount options string.
- *	uopts		Pointer to mount options variable.
+ *	fc		fs_context with pointer to mount options variable.
+ *	param		Pointer to fs_parameter being parsed.
  *
  * POST-CONDITIONS
- *	<return>	1	Mount options parsed okay.
- *	<return>	0	Error parsing mount options.
+ *	<return>	0	Mount options parsed okay.
+ *	<return>	errno	Error parsing mount options.
  *
  * HISTORY
  *	July 1, 1997 - Andrew E. Mileski
@@ -418,229 +480,194 @@ enum {
 	Opt_noadinicb, Opt_adinicb, Opt_shortad, Opt_longad,
 	Opt_gid, Opt_uid, Opt_umask, Opt_session, Opt_lastblock,
 	Opt_anchor, Opt_volume, Opt_partition, Opt_fileset,
-	Opt_rootdir, Opt_utf8, Opt_iocharset,
-	Opt_err, Opt_uforget, Opt_uignore, Opt_gforget, Opt_gignore,
-	Opt_fmode, Opt_dmode
+	Opt_rootdir, Opt_utf8, Opt_iocharset, Opt_err, Opt_fmode, Opt_dmode
 };
 
-static const match_table_t tokens = {
-	{Opt_novrs,	"novrs"},
-	{Opt_nostrict,	"nostrict"},
-	{Opt_bs,	"bs=%u"},
-	{Opt_unhide,	"unhide"},
-	{Opt_undelete,	"undelete"},
-	{Opt_noadinicb,	"noadinicb"},
-	{Opt_adinicb,	"adinicb"},
-	{Opt_shortad,	"shortad"},
-	{Opt_longad,	"longad"},
-	{Opt_uforget,	"uid=forget"},
-	{Opt_uignore,	"uid=ignore"},
-	{Opt_gforget,	"gid=forget"},
-	{Opt_gignore,	"gid=ignore"},
-	{Opt_gid,	"gid=%u"},
-	{Opt_uid,	"uid=%u"},
-	{Opt_umask,	"umask=%o"},
-	{Opt_session,	"session=%u"},
-	{Opt_lastblock,	"lastblock=%u"},
-	{Opt_anchor,	"anchor=%u"},
-	{Opt_volume,	"volume=%u"},
-	{Opt_partition,	"partition=%u"},
-	{Opt_fileset,	"fileset=%u"},
-	{Opt_rootdir,	"rootdir=%u"},
-	{Opt_utf8,	"utf8"},
-	{Opt_iocharset,	"iocharset=%s"},
-	{Opt_fmode,     "mode=%o"},
-	{Opt_dmode,     "dmode=%o"},
-	{Opt_err,	NULL}
-};
-
-static int udf_parse_options(char *options, struct udf_options *uopt,
-			     bool remount)
+static const struct fs_parameter_spec udf_param_spec[] = {
+	fsparam_flag	("novrs",		Opt_novrs),
+	fsparam_flag	("nostrict",		Opt_nostrict),
+	fsparam_u32	("bs",			Opt_bs),
+	fsparam_flag	("unhide",		Opt_unhide),
+	fsparam_flag	("undelete",		Opt_undelete),
+	fsparam_flag	("noadinicb",		Opt_noadinicb),
+	fsparam_flag	("adinicb",		Opt_adinicb),
+	fsparam_flag	("shortad",		Opt_shortad),
+	fsparam_flag	("longad",		Opt_longad),
+	fsparam_string	("gid",			Opt_gid),
+	fsparam_string	("uid",			Opt_uid),
+	fsparam_u32	("umask",		Opt_umask),
+	fsparam_u32	("session",		Opt_session),
+	fsparam_u32	("lastblock",		Opt_lastblock),
+	fsparam_u32	("anchor",		Opt_anchor),
+	fsparam_u32	("volume",		Opt_volume),
+	fsparam_u32	("partition",		Opt_partition),
+	fsparam_u32	("fileset",		Opt_fileset),
+	fsparam_u32	("rootdir",		Opt_rootdir),
+	fsparam_flag	("utf8",		Opt_utf8),
+	fsparam_string	("iocharset",		Opt_iocharset),
+	fsparam_u32	("mode",		Opt_fmode),
+	fsparam_u32	("dmode",		Opt_dmode),
+	{}
+ };
+ 
+static int udf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	char *p;
-	int option;
 	unsigned int uv;
-
-	uopt->novrs = 0;
-	uopt->session = 0xFFFFFFFF;
-	uopt->lastblock = 0;
-	uopt->anchor = 0;
-
-	if (!options)
-		return 1;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		substring_t args[MAX_OPT_ARGS];
-		int token;
-		unsigned n;
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_novrs:
-			uopt->novrs = 1;
-			break;
-		case Opt_bs:
-			if (match_int(&args[0], &option))
-				return 0;
-			n = option;
-			if (n != 512 && n != 1024 && n != 2048 && n != 4096)
-				return 0;
-			uopt->blocksize = n;
-			uopt->flags |= (1 << UDF_FLAG_BLOCKSIZE_SET);
-			break;
-		case Opt_unhide:
-			uopt->flags |= (1 << UDF_FLAG_UNHIDE);
-			break;
-		case Opt_undelete:
-			uopt->flags |= (1 << UDF_FLAG_UNDELETE);
-			break;
-		case Opt_noadinicb:
-			uopt->flags &= ~(1 << UDF_FLAG_USE_AD_IN_ICB);
-			break;
-		case Opt_adinicb:
-			uopt->flags |= (1 << UDF_FLAG_USE_AD_IN_ICB);
-			break;
-		case Opt_shortad:
-			uopt->flags |= (1 << UDF_FLAG_USE_SHORT_AD);
-			break;
-		case Opt_longad:
-			uopt->flags &= ~(1 << UDF_FLAG_USE_SHORT_AD);
-			break;
-		case Opt_gid:
-			if (match_uint(args, &uv))
-				return 0;
+	unsigned int n;
+	struct udf_options *uopt = fc->fs_private;
+	struct fs_parse_result result;
+	int token;
+	bool remount = (fc->purpose & FS_CONTEXT_FOR_RECONFIGURE);
+
+	token = fs_parse(fc, udf_param_spec, param, &result);
+	if (token < 0)
+		return token;
+
+	switch (token) {
+	case Opt_novrs:
+		uopt->novrs = 1;
+		break;
+	case Opt_bs:
+		n = result.uint_32;;
+		if (n != 512 && n != 1024 && n != 2048 && n != 4096)
+			return -EINVAL;
+		uopt->blocksize = n;
+		uopt->flags |= (1 << UDF_FLAG_BLOCKSIZE_SET);
+		break;
+	case Opt_unhide:
+		uopt->flags |= (1 << UDF_FLAG_UNHIDE);
+		break;
+	case Opt_undelete:
+		uopt->flags |= (1 << UDF_FLAG_UNDELETE);
+		break;
+	case Opt_noadinicb:
+		uopt->flags &= ~(1 << UDF_FLAG_USE_AD_IN_ICB);
+		break;
+	case Opt_adinicb:
+		uopt->flags |= (1 << UDF_FLAG_USE_AD_IN_ICB);
+		break;
+	case Opt_shortad:
+		uopt->flags |= (1 << UDF_FLAG_USE_SHORT_AD);
+		break;
+	case Opt_longad:
+		uopt->flags &= ~(1 << UDF_FLAG_USE_SHORT_AD);
+		break;
+	case Opt_gid:
+		if (0 == kstrtoint(param->string, 10, &uv)) {
 			uopt->gid = make_kgid(current_user_ns(), uv);
 			if (!gid_valid(uopt->gid))
-				return 0;
+				return -EINVAL;
 			uopt->flags |= (1 << UDF_FLAG_GID_SET);
-			break;
-		case Opt_uid:
-			if (match_uint(args, &uv))
-				return 0;
+		} else if (!strcmp(param->string, "forget")) {
+			uopt->flags |= (1 << UDF_FLAG_GID_FORGET);
+		} else if (!strcmp(param->string, "ignore")) {
+			/* this option is superseded by gid=<number> */
+			;
+		} else {
+			return -EINVAL;
+		}
+		break;
+	case Opt_uid:
+		if (0 == kstrtoint(param->string, 10, &uv)) {
 			uopt->uid = make_kuid(current_user_ns(), uv);
 			if (!uid_valid(uopt->uid))
-				return 0;
+				return -EINVAL;
 			uopt->flags |= (1 << UDF_FLAG_UID_SET);
-			break;
-		case Opt_umask:
-			if (match_octal(args, &option))
-				return 0;
-			uopt->umask = option;
-			break;
-		case Opt_nostrict:
-			uopt->flags &= ~(1 << UDF_FLAG_STRICT);
-			break;
-		case Opt_session:
-			if (match_int(args, &option))
-				return 0;
-			uopt->session = option;
-			if (!remount)
-				uopt->flags |= (1 << UDF_FLAG_SESSION_SET);
-			break;
-		case Opt_lastblock:
-			if (match_int(args, &option))
-				return 0;
-			uopt->lastblock = option;
-			if (!remount)
-				uopt->flags |= (1 << UDF_FLAG_LASTBLOCK_SET);
-			break;
-		case Opt_anchor:
-			if (match_int(args, &option))
-				return 0;
-			uopt->anchor = option;
-			break;
-		case Opt_volume:
-		case Opt_partition:
-		case Opt_fileset:
-		case Opt_rootdir:
-			/* Ignored (never implemented properly) */
-			break;
-		case Opt_utf8:
-			if (!remount) {
-				unload_nls(uopt->nls_map);
-				uopt->nls_map = NULL;
-			}
-			break;
-		case Opt_iocharset:
-			if (!remount) {
-				unload_nls(uopt->nls_map);
-				uopt->nls_map = NULL;
-			}
-			/* When nls_map is not loaded then UTF-8 is used */
-			if (!remount && strcmp(args[0].from, "utf8") != 0) {
-				uopt->nls_map = load_nls(args[0].from);
-				if (!uopt->nls_map) {
-					pr_err("iocharset %s not found\n",
-						args[0].from);
-					return 0;
-				}
-			}
-			break;
-		case Opt_uforget:
+		} else if (!strcmp(param->string, "forget")) {
 			uopt->flags |= (1 << UDF_FLAG_UID_FORGET);
-			break;
-		case Opt_uignore:
-		case Opt_gignore:
-			/* These options are superseeded by uid=<number> */
-			break;
-		case Opt_gforget:
-			uopt->flags |= (1 << UDF_FLAG_GID_FORGET);
-			break;
-		case Opt_fmode:
-			if (match_octal(args, &option))
-				return 0;
-			uopt->fmode = option & 0777;
-			break;
-		case Opt_dmode:
-			if (match_octal(args, &option))
-				return 0;
-			uopt->dmode = option & 0777;
-			break;
-		default:
-			pr_err("bad mount option \"%s\" or missing value\n", p);
-			return 0;
+		} else if (!strcmp(param->string, "ignore")) {
+			/* this option is superseded by uid=<number> */
+			;
+		} else {
+			return -EINVAL;
+		}
+		break;
+	case Opt_umask:
+		uopt->umask = result.uint_32;
+		break;
+	case Opt_nostrict:
+		uopt->flags &= ~(1 << UDF_FLAG_STRICT);
+		break;
+	case Opt_session:
+		uopt->session = result.uint_32;
+		if (!remount)
+			uopt->flags |= (1 << UDF_FLAG_SESSION_SET);
+		break;
+	case Opt_lastblock:
+		uopt->lastblock = result.uint_32;
+		if (!remount)
+			uopt->flags |= (1 << UDF_FLAG_LASTBLOCK_SET);
+		break;
+	case Opt_anchor:
+		uopt->anchor = result.uint_32;
+		break;
+	case Opt_volume:
+	case Opt_partition:
+	case Opt_fileset:
+	case Opt_rootdir:
+		/* Ignored (never implemented properly) */
+		break;
+	case Opt_utf8:
+		if (!remount) {
+			unload_nls(uopt->nls_map);
+			uopt->nls_map = NULL;
+		}
+		break;
+	case Opt_iocharset:
+		if (!remount) {
+			unload_nls(uopt->nls_map);
+			uopt->nls_map = NULL;
 		}
+		/* When nls_map is not loaded then UTF-8 is used */
+		if (!remount && strcmp(param->string, "utf8") != 0) {
+			uopt->nls_map = load_nls(param->string);
+			if (!uopt->nls_map) {
+				errorf(fc, "iocharset %s not found",
+					param->string);
+				return -EINVAL;;
+			}
+		}
+		break;
+	case Opt_fmode:
+		uopt->fmode = result.uint_32 & 0777;
+		break;
+	case Opt_dmode:
+		uopt->dmode = result.uint_32 & 0777;
+		break;
+	default:
+		errorf(fc, "bad mount option \"%s\" or missing value", p);
+		return -EINVAL;
 	}
-	return 1;
+	return 0;
 }
 
-static int udf_remount_fs(struct super_block *sb, int *flags, char *options)
+static int udf_reconfigure(struct fs_context *fc)
 {
-	struct udf_options uopt;
+	struct udf_options *uopt = fc->fs_private;
+	struct super_block *sb = fc->root->d_sb;
 	struct udf_sb_info *sbi = UDF_SB(sb);
+	int readonly = fc->sb_flags & SB_RDONLY;
 	int error = 0;
 
-	if (!(*flags & SB_RDONLY) && UDF_QUERY_FLAG(sb, UDF_FLAG_RW_INCOMPAT))
+	if (!readonly && UDF_QUERY_FLAG(sb, UDF_FLAG_RW_INCOMPAT))
 		return -EACCES;
 
 	sync_filesystem(sb);
 
-	uopt.flags = sbi->s_flags;
-	uopt.uid   = sbi->s_uid;
-	uopt.gid   = sbi->s_gid;
-	uopt.umask = sbi->s_umask;
-	uopt.fmode = sbi->s_fmode;
-	uopt.dmode = sbi->s_dmode;
-	uopt.nls_map = NULL;
-
-	if (!udf_parse_options(options, &uopt, true))
-		return -EINVAL;
-
 	write_lock(&sbi->s_cred_lock);
-	sbi->s_flags = uopt.flags;
-	sbi->s_uid   = uopt.uid;
-	sbi->s_gid   = uopt.gid;
-	sbi->s_umask = uopt.umask;
-	sbi->s_fmode = uopt.fmode;
-	sbi->s_dmode = uopt.dmode;
+	sbi->s_flags = uopt->flags;
+	sbi->s_uid   = uopt->uid;
+	sbi->s_gid   = uopt->gid;
+	sbi->s_umask = uopt->umask;
+	sbi->s_fmode = uopt->fmode;
+	sbi->s_dmode = uopt->dmode;
 	write_unlock(&sbi->s_cred_lock);
 
-	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
+	if (readonly == sb_rdonly(sb))
 		goto out_unlock;
 
-	if (*flags & SB_RDONLY)
+	if (readonly)
 		udf_close_lvid(sb);
 	else
 		udf_open_lvid(sb);
@@ -2084,23 +2111,15 @@ u64 lvid_get_unique_id(struct super_block *sb)
 	return ret;
 }
 
-static int udf_fill_super(struct super_block *sb, void *options, int silent)
+static int udf_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	int ret = -EINVAL;
 	struct inode *inode = NULL;
-	struct udf_options uopt;
+	struct udf_options *uopt = fc->fs_private;
 	struct kernel_lb_addr rootdir, fileset;
 	struct udf_sb_info *sbi;
 	bool lvid_open = false;
-
-	uopt.flags = (1 << UDF_FLAG_USE_AD_IN_ICB) | (1 << UDF_FLAG_STRICT);
-	/* By default we'll use overflow[ug]id when UDF inode [ug]id == -1 */
-	uopt.uid = make_kuid(current_user_ns(), overflowuid);
-	uopt.gid = make_kgid(current_user_ns(), overflowgid);
-	uopt.umask = 0;
-	uopt.fmode = UDF_INVALID_MODE;
-	uopt.dmode = UDF_INVALID_MODE;
-	uopt.nls_map = NULL;
+	int silent = fc->sb_flags & SB_SILENT;
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
@@ -2110,25 +2129,22 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
 
 	mutex_init(&sbi->s_alloc_mutex);
 
-	if (!udf_parse_options((char *)options, &uopt, false))
-		goto parse_options_failure;
-
 	fileset.logicalBlockNum = 0xFFFFFFFF;
 	fileset.partitionReferenceNum = 0xFFFF;
 
-	sbi->s_flags = uopt.flags;
-	sbi->s_uid = uopt.uid;
-	sbi->s_gid = uopt.gid;
-	sbi->s_umask = uopt.umask;
-	sbi->s_fmode = uopt.fmode;
-	sbi->s_dmode = uopt.dmode;
-	sbi->s_nls_map = uopt.nls_map;
+	sbi->s_flags = uopt->flags;
+	sbi->s_uid = uopt->uid;
+	sbi->s_gid = uopt->gid;
+	sbi->s_umask = uopt->umask;
+	sbi->s_fmode = uopt->fmode;
+	sbi->s_dmode = uopt->dmode;
+	sbi->s_nls_map = uopt->nls_map;
 	rwlock_init(&sbi->s_cred_lock);
 
-	if (uopt.session == 0xFFFFFFFF)
+	if (uopt->session == 0xFFFFFFFF)
 		sbi->s_session = udf_get_last_session(sb);
 	else
-		sbi->s_session = uopt.session;
+		sbi->s_session = uopt->session;
 
 	udf_debug("Multi-session=%d\n", sbi->s_session);
 
@@ -2139,16 +2155,16 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
 	sb->s_magic = UDF_SUPER_MAGIC;
 	sb->s_time_gran = 1000;
 
-	if (uopt.flags & (1 << UDF_FLAG_BLOCKSIZE_SET)) {
-		ret = udf_load_vrs(sb, &uopt, silent, &fileset);
+	if (uopt->flags & (1 << UDF_FLAG_BLOCKSIZE_SET)) {
+		ret = udf_load_vrs(sb, uopt, silent, &fileset);
 	} else {
-		uopt.blocksize = bdev_logical_block_size(sb->s_bdev);
-		while (uopt.blocksize <= 4096) {
-			ret = udf_load_vrs(sb, &uopt, silent, &fileset);
+		uopt->blocksize = bdev_logical_block_size(sb->s_bdev);
+		while (uopt->blocksize <= 4096) {
+			ret = udf_load_vrs(sb, uopt, silent, &fileset);
 			if (ret < 0) {
 				if (!silent && ret != -EACCES) {
 					pr_notice("Scanning with blocksize %u failed\n",
-						  uopt.blocksize);
+						  uopt->blocksize);
 				}
 				brelse(sbi->s_lvid_bh);
 				sbi->s_lvid_bh = NULL;
@@ -2161,7 +2177,7 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
 			} else
 				break;
 
-			uopt.blocksize <<= 1;
+			uopt->blocksize <<= 1;
 		}
 	}
 	if (ret < 0) {
@@ -2266,8 +2282,7 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
 
 error_out:
 	iput(sbi->s_vat_inode);
-parse_options_failure:
-	unload_nls(uopt.nls_map);
+	unload_nls(uopt->nls_map);
 	if (lvid_open)
 		udf_close_lvid(sb);
 	brelse(sbi->s_lvid_bh);
-- 
2.43.0




