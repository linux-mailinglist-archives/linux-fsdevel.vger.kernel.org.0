Return-Path: <linux-fsdevel+bounces-22817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EDB91CE48
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 19:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484C52828F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ADE81AD2;
	Sat, 29 Jun 2024 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8aFOXq5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9F54278
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jun 2024 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719682372; cv=none; b=gbgxfJF0JUjUvVkZmhNhWV2wzM6ZEszTomXungtim7lL8dV/dSjv/k20xIjm2ftbdiXPTWjIQD0TQANC8uKmtgWBpuf7Yd/2G8xvcrM2+sRQpfAygeVrFYGCjLe46crddqNcQVLSH2FBB/ZYyB+NeApEKv/CLhodbpfhdrqBxF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719682372; c=relaxed/simple;
	bh=nsbxFTCyB5drBWu6IqbYZQLgltmPqbgFGUuN0rpnJcc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l/IveTaKM10qJPVl6oVCGk7CQy6/DZ57MooZKqbW1x73Ktx5Dhy1qXZJtRZGyEPkYcy9v4WUzxKYrZlafG6waL5/i1PMqiI97LBOFjZIZZglDk7ZlJFweZblrj/YTBlFKCH+mQmAsxZWab2ODwHrI1qTGUczA1TbRyzberby1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8aFOXq5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719682368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uGXslWpsJacAFGeJT96XdRAZLrVEHJPe7+tPX8HrA0=;
	b=E8aFOXq59SRGbPZDXKEaCtpcTKjT6trOOpBaIhRNyDcn+wBSaN+uClyPx3CWP36Hr0IJ7D
	/FC+4rwDfBwznQn/DjzCVQCxJcPswxfhWqvPObESgcSpdtSRxESYlwABzgOV8+HnAch1LQ
	tOUuPt9Pi3fyiLg22eYPQjaBFoCr6HM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447--QBXLQiFPnCMoLs5PlipwA-1; Sat, 29 Jun 2024 13:32:47 -0400
X-MC-Unique: -QBXLQiFPnCMoLs5PlipwA-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f61a2adf94so168586839f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jun 2024 10:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719682366; x=1720287166;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2uGXslWpsJacAFGeJT96XdRAZLrVEHJPe7+tPX8HrA0=;
        b=MP1OrhuQqyRxN4ohquYe/GBBpwZv9KGGHhbTnkHUtyiUT019Al86vlqqYLIqybn2FB
         bfhP0zFGr0rzrK03P3v1vjKRN9g8qHCgr4omRK0FtW/BY25N7MGZgVeKIF6r7/N8Pu6+
         um8ftlfXw6cObPMUADSgCdH+jnRB5VLJ/znmLY/hjTdBFks14OUWSWme9Bnz/LPf6nhz
         ZkQ7xKL7XbjgvjZwtb7+rMtVM8bBBbsUnYtQhojpnO7xBZ3OMDiiTpQP0S6nwnYML8XW
         R8LL86Xd21RY5O/bjsHTrYS1PoAXb49Jp73j/mPqyxLX2iAqcS0503J6fLGW9ojL37zy
         JdNA==
X-Gm-Message-State: AOJu0YzyO+qy433hZtmEeQff/PzlMZAfxoQsva8+s19LWEFRdYr/CnOd
	3Y6pyc/DzHzIdOgcLvpOPy9LxjGTB5ofu/nzRO0NwM37hvKHhRmYWu+qHZle2fJdu9qcBTjCWZx
	PpYuOHnxF6bo4k9AJ3+Cul/pzNkfg6tGKb65MxEC7knaU6lgMbaAefNsNXKV55qkPMLwQaMVXPW
	BpN6N7s4IS/ioDCLnTZ5jxG1Q6APWNZFYHk2X1pIiEF+Fm+w==
X-Received: by 2002:a6b:ec16:0:b0:7f6:2a08:3108 with SMTP id ca18e2360f4ac-7f62ee01e9emr172530639f.2.1719682365705;
        Sat, 29 Jun 2024 10:32:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+03Xm88jERT2VX8cyLjWqTMWtIbuBDGWXbvI9cmjQ6er1RhgvJi+7fhdKqBXIlWBKC5t7/A==
X-Received: by 2002:a6b:ec16:0:b0:7f6:2a08:3108 with SMTP id ca18e2360f4ac-7f62ee01e9emr172527939f.2.1719682364980;
        Sat, 29 Jun 2024 10:32:44 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742b61f2sm1185190173.129.2024.06.29.10.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 10:32:44 -0700 (PDT)
Message-ID: <2509d003-7153-4ce3-8a04-bc0e1f00a1d5@redhat.com>
Date: Sat, 29 Jun 2024 12:32:43 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] fat: Convert to new mount api
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <fe6baab2-a7a0-4fb0-9b94-17c58f73ed62@redhat.com>
Content-Language: en-US
In-Reply-To: <fe6baab2-a7a0-4fb0-9b94-17c58f73ed62@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

vfat and msdos share a common set of options, with additional unique
options for each filesystem.

Each filesystem calls common fc initializization and parsing routines,
with an "is_vfat" parameter. For parsing, if the option is not found
in the common parameter_spec, parsing is retried with the fs-specific
parameter_spec.

This patch leaves nls loading to fill_super, so the codepage and charset
options are not validated as they are requested. This matches current
behavior. It would be possible to test-load as each option is parsed,
but that would make i.e.

mount -o "iocharset=nope,iocharset=iso8859-1"

fail, where it does not fail today because only the last iocharset
option is considered.

The obsolete "conv=" option is set up with an enum of acceptable values;
currently invalid "conv=" options are rejected as such, even though the
option is obsolete, so this patch preserves that behavior.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/fat/fat.h         |  15 +-
 fs/fat/inode.c       | 680 +++++++++++++++++++++----------------------
 fs/fat/namei_msdos.c |  38 ++-
 fs/fat/namei_vfat.c  |  38 ++-
 4 files changed, 413 insertions(+), 358 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 37ced7bb06d5..fe41584ecaf3 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -7,6 +7,8 @@
 #include <linux/hash.h>
 #include <linux/ratelimit.h>
 #include <linux/msdos_fs.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 
 /*
  * vfat shortname flags
@@ -416,12 +418,21 @@ extern struct inode *fat_iget(struct super_block *sb, loff_t i_pos);
 extern struct inode *fat_build_inode(struct super_block *sb,
 			struct msdos_dir_entry *de, loff_t i_pos);
 extern int fat_sync_inode(struct inode *inode);
-extern int fat_fill_super(struct super_block *sb, void *data, int silent,
-			  int isvfat, void (*setup)(struct super_block *));
+extern int fat_fill_super(struct super_block *sb, struct fs_context *fc,
+			  void (*setup)(struct super_block *));
 extern int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de);
 
 extern int fat_flush_inodes(struct super_block *sb, struct inode *i1,
 			    struct inode *i2);
+
+extern const struct fs_parameter_spec fat_param_spec[];
+extern int fat_init_fs_context(struct fs_context *fc, bool is_vfat);
+extern void fat_free_fc(struct fs_context *fc);
+
+int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
+		    int is_vfat);
+extern int fat_reconfigure(struct fs_context *fc);
+
 static inline unsigned long fat_dir_hash(int logstart)
 {
 	return hash_32(logstart, FAT_HASH_BITS);
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 2a6537ba0d49..3d3753479dd1 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -16,7 +16,6 @@
 #include <linux/mpage.h>
 #include <linux/vfs.h>
 #include <linux/seq_file.h>
-#include <linux/parser.h>
 #include <linux/uio.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
@@ -804,16 +803,17 @@ static void __exit fat_destroy_inodecache(void)
 	kmem_cache_destroy(fat_inode_cachep);
 }
 
-static int fat_remount(struct super_block *sb, int *flags, char *data)
+int fat_reconfigure(struct fs_context *fc)
 {
 	bool new_rdonly;
+	struct super_block *sb = fc->root->d_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	*flags |= SB_NODIRATIME | (sbi->options.isvfat ? 0 : SB_NOATIME);
+	fc->sb_flags |= SB_NODIRATIME | (sbi->options.isvfat ? 0 : SB_NOATIME);
 
 	sync_filesystem(sb);
 
 	/* make sure we update state on remount. */
-	new_rdonly = *flags & SB_RDONLY;
+	new_rdonly = fc->sb_flags & SB_RDONLY;
 	if (new_rdonly != sb_rdonly(sb)) {
 		if (new_rdonly)
 			fat_set_state(sb, 0, 0);
@@ -822,6 +822,7 @@ static int fat_remount(struct super_block *sb, int *flags, char *data)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(fat_reconfigure);
 
 static int fat_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
@@ -939,8 +940,6 @@ static const struct super_operations fat_sops = {
 	.evict_inode	= fat_evict_inode,
 	.put_super	= fat_put_super,
 	.statfs		= fat_statfs,
-	.remount_fs	= fat_remount,
-
 	.show_options	= fat_show_options,
 };
 
@@ -1037,355 +1036,282 @@ static int fat_show_options(struct seq_file *m, struct dentry *root)
 }
 
 enum {
-	Opt_check_n, Opt_check_r, Opt_check_s, Opt_uid, Opt_gid,
-	Opt_umask, Opt_dmask, Opt_fmask, Opt_allow_utime, Opt_codepage,
-	Opt_usefree, Opt_nocase, Opt_quiet, Opt_showexec, Opt_debug,
-	Opt_immutable, Opt_dots, Opt_nodots,
-	Opt_charset, Opt_shortname_lower, Opt_shortname_win95,
-	Opt_shortname_winnt, Opt_shortname_mixed, Opt_utf8_no, Opt_utf8_yes,
-	Opt_uni_xl_no, Opt_uni_xl_yes, Opt_nonumtail_no, Opt_nonumtail_yes,
-	Opt_obsolete, Opt_flush, Opt_tz_utc, Opt_rodir, Opt_err_cont,
-	Opt_err_panic, Opt_err_ro, Opt_discard, Opt_nfs, Opt_time_offset,
-	Opt_nfs_stale_rw, Opt_nfs_nostale_ro, Opt_err, Opt_dos1xfloppy,
+	Opt_check, Opt_uid, Opt_gid, Opt_umask, Opt_dmask, Opt_fmask,
+	Opt_allow_utime, Opt_codepage, Opt_usefree, Opt_nocase, Opt_quiet,
+	Opt_showexec, Opt_debug, Opt_immutable, Opt_dots, Opt_dotsOK,
+	Opt_charset, Opt_shortname, Opt_utf8, Opt_utf8_bool,
+	Opt_uni_xl, Opt_uni_xl_bool, Opt_nonumtail, Opt_nonumtail_bool,
+	Opt_obsolete, Opt_flush, Opt_tz, Opt_rodir, Opt_errors, Opt_discard,
+	Opt_nfs, Opt_nfs_enum, Opt_time_offset, Opt_dos1xfloppy,
 };
 
-static const match_table_t fat_tokens = {
-	{Opt_check_r, "check=relaxed"},
-	{Opt_check_s, "check=strict"},
-	{Opt_check_n, "check=normal"},
-	{Opt_check_r, "check=r"},
-	{Opt_check_s, "check=s"},
-	{Opt_check_n, "check=n"},
-	{Opt_uid, "uid=%u"},
-	{Opt_gid, "gid=%u"},
-	{Opt_umask, "umask=%o"},
-	{Opt_dmask, "dmask=%o"},
-	{Opt_fmask, "fmask=%o"},
-	{Opt_allow_utime, "allow_utime=%o"},
-	{Opt_codepage, "codepage=%u"},
-	{Opt_usefree, "usefree"},
-	{Opt_nocase, "nocase"},
-	{Opt_quiet, "quiet"},
-	{Opt_showexec, "showexec"},
-	{Opt_debug, "debug"},
-	{Opt_immutable, "sys_immutable"},
-	{Opt_flush, "flush"},
-	{Opt_tz_utc, "tz=UTC"},
-	{Opt_time_offset, "time_offset=%d"},
-	{Opt_err_cont, "errors=continue"},
-	{Opt_err_panic, "errors=panic"},
-	{Opt_err_ro, "errors=remount-ro"},
-	{Opt_discard, "discard"},
-	{Opt_nfs_stale_rw, "nfs"},
-	{Opt_nfs_stale_rw, "nfs=stale_rw"},
-	{Opt_nfs_nostale_ro, "nfs=nostale_ro"},
-	{Opt_dos1xfloppy, "dos1xfloppy"},
-	{Opt_obsolete, "conv=binary"},
-	{Opt_obsolete, "conv=text"},
-	{Opt_obsolete, "conv=auto"},
-	{Opt_obsolete, "conv=b"},
-	{Opt_obsolete, "conv=t"},
-	{Opt_obsolete, "conv=a"},
-	{Opt_obsolete, "fat=%u"},
-	{Opt_obsolete, "blocksize=%u"},
-	{Opt_obsolete, "cvf_format=%20s"},
-	{Opt_obsolete, "cvf_options=%100s"},
-	{Opt_obsolete, "posix"},
-	{Opt_err, NULL},
+static const struct constant_table fat_param_check[] = {
+	{"relaxed",	'r'},
+	{"r",		'r'},
+	{"strict",	's'},
+	{"s",		's'},
+	{"normal",	'n'},
+	{"n",		'n'},
+	{}
 };
-static const match_table_t msdos_tokens = {
-	{Opt_nodots, "nodots"},
-	{Opt_nodots, "dotsOK=no"},
-	{Opt_dots, "dots"},
-	{Opt_dots, "dotsOK=yes"},
-	{Opt_err, NULL}
+
+static const struct constant_table fat_param_tz[] = {
+	{"UTC",		0},
+	{}
 };
-static const match_table_t vfat_tokens = {
-	{Opt_charset, "iocharset=%s"},
-	{Opt_shortname_lower, "shortname=lower"},
-	{Opt_shortname_win95, "shortname=win95"},
-	{Opt_shortname_winnt, "shortname=winnt"},
-	{Opt_shortname_mixed, "shortname=mixed"},
-	{Opt_utf8_no, "utf8=0"},		/* 0 or no or false */
-	{Opt_utf8_no, "utf8=no"},
-	{Opt_utf8_no, "utf8=false"},
-	{Opt_utf8_yes, "utf8=1"},		/* empty or 1 or yes or true */
-	{Opt_utf8_yes, "utf8=yes"},
-	{Opt_utf8_yes, "utf8=true"},
-	{Opt_utf8_yes, "utf8"},
-	{Opt_uni_xl_no, "uni_xlate=0"},		/* 0 or no or false */
-	{Opt_uni_xl_no, "uni_xlate=no"},
-	{Opt_uni_xl_no, "uni_xlate=false"},
-	{Opt_uni_xl_yes, "uni_xlate=1"},	/* empty or 1 or yes or true */
-	{Opt_uni_xl_yes, "uni_xlate=yes"},
-	{Opt_uni_xl_yes, "uni_xlate=true"},
-	{Opt_uni_xl_yes, "uni_xlate"},
-	{Opt_nonumtail_no, "nonumtail=0"},	/* 0 or no or false */
-	{Opt_nonumtail_no, "nonumtail=no"},
-	{Opt_nonumtail_no, "nonumtail=false"},
-	{Opt_nonumtail_yes, "nonumtail=1"},	/* empty or 1 or yes or true */
-	{Opt_nonumtail_yes, "nonumtail=yes"},
-	{Opt_nonumtail_yes, "nonumtail=true"},
-	{Opt_nonumtail_yes, "nonumtail"},
-	{Opt_rodir, "rodir"},
-	{Opt_err, NULL}
+
+static const struct constant_table fat_param_errors[] = {
+	{"continue",	FAT_ERRORS_CONT},
+	{"panic",	FAT_ERRORS_PANIC},
+	{"remount-ro",	FAT_ERRORS_RO},
+	{}
 };
 
-static int parse_options(struct super_block *sb, char *options, int is_vfat,
-			 int silent, struct fat_mount_options *opts)
-{
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-	char *iocharset;
 
-	opts->isvfat = is_vfat;
+static const struct constant_table fat_param_nfs[] = {
+	{"stale_rw",	FAT_NFS_STALE_RW},
+	{"nostale_ro",	FAT_NFS_NOSTALE_RO},
+	{}
+};
 
-	opts->fs_uid = current_uid();
-	opts->fs_gid = current_gid();
-	opts->fs_fmask = opts->fs_dmask = current_umask();
-	opts->allow_utime = -1;
-	opts->codepage = fat_default_codepage;
-	fat_reset_iocharset(opts);
-	if (is_vfat) {
-		opts->shortname = VFAT_SFN_DISPLAY_WINNT|VFAT_SFN_CREATE_WIN95;
-		opts->rodir = 0;
-	} else {
-		opts->shortname = 0;
-		opts->rodir = 1;
-	}
-	opts->name_check = 'n';
-	opts->quiet = opts->showexec = opts->sys_immutable = opts->dotsOK =  0;
-	opts->unicode_xlate = 0;
-	opts->numtail = 1;
-	opts->usefree = opts->nocase = 0;
-	opts->tz_set = 0;
-	opts->nfs = 0;
-	opts->errors = FAT_ERRORS_RO;
-	opts->debug = 0;
+/*
+ * These are all obsolete but we still reject invalid options.
+ * The corresponding values are therefore meaningless.
+ */
+static const struct constant_table fat_param_conv[] = {
+	{"binary",	0},
+	{"text",	0},
+	{"auto",	0},
+	{"b",		0},
+	{"t",		0},
+	{"a",		0},
+	{}
+};
 
-	opts->utf8 = IS_ENABLED(CONFIG_FAT_DEFAULT_UTF8) && is_vfat;
+/* Core options. See below for vfat and msdos extras */
+const struct fs_parameter_spec fat_param_spec[] = {
+	fsparam_enum	("check",	Opt_check, fat_param_check),
+	fsparam_u32	("uid",		Opt_uid),
+	fsparam_u32	("gid",		Opt_gid),
+	fsparam_u32oct	("umask",	Opt_umask),
+	fsparam_u32oct	("dmask",	Opt_dmask),
+	fsparam_u32oct	("fmask",	Opt_fmask),
+	fsparam_u32oct	("allow_utime",	Opt_allow_utime),
+	fsparam_u32	("codepage",	Opt_codepage),
+	fsparam_flag	("usefree",	Opt_usefree),
+	fsparam_flag	("nocase",	Opt_nocase),
+	fsparam_flag	("quiet",	Opt_quiet),
+	fsparam_flag	("showexec",	Opt_showexec),
+	fsparam_flag	("debug",	Opt_debug),
+	fsparam_flag	("sys_immutable", Opt_immutable),
+	fsparam_flag	("flush",	Opt_flush),
+	fsparam_enum	("tz",		Opt_tz, fat_param_tz),
+	fsparam_s32	("time_offset",	Opt_time_offset),
+	fsparam_enum	("errors",	Opt_errors, fat_param_errors),
+	fsparam_flag	("discard",	Opt_discard),
+	fsparam_flag	("nfs",		Opt_nfs),
+	fsparam_enum	("nfs",		Opt_nfs_enum, fat_param_nfs),
+	fsparam_flag	("dos1xfloppy",	Opt_dos1xfloppy),
+	fsparam_enum	("conv",	Opt_obsolete, fat_param_conv),
+	fsparam_u32	("fat",		Opt_obsolete),
+	fsparam_u32	("blocksize",	Opt_obsolete),
+	fsparam_string	("cvf_format",	Opt_obsolete),
+	fsparam_string	("cvf_options",	Opt_obsolete),
+	fsparam_flag	("posix",	Opt_obsolete),
+	{}
+};
+EXPORT_SYMBOL_GPL(fat_param_spec);
 
-	if (!options)
-		goto out;
+static const struct fs_parameter_spec msdos_param_spec[] = {
+	fsparam_flag_no	("dots",	Opt_dots),
+	fsparam_bool	("dotsOK",	Opt_dotsOK),
+	{}
+};
 
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
-		if (!*p)
-			continue;
+static const struct constant_table fat_param_shortname[] = {
+	{"lower",	VFAT_SFN_DISPLAY_LOWER | VFAT_SFN_CREATE_WIN95},
+	{"win95",	VFAT_SFN_DISPLAY_WIN95 | VFAT_SFN_CREATE_WIN95},
+	{"winnt",	VFAT_SFN_DISPLAY_WINNT | VFAT_SFN_CREATE_WINNT},
+	{"mixed",	VFAT_SFN_DISPLAY_WINNT | VFAT_SFN_CREATE_WIN95},
+	{}
+};
 
-		token = match_token(p, fat_tokens, args);
-		if (token == Opt_err) {
-			if (is_vfat)
-				token = match_token(p, vfat_tokens, args);
-			else
-				token = match_token(p, msdos_tokens, args);
-		}
-		switch (token) {
-		case Opt_check_s:
-			opts->name_check = 's';
-			break;
-		case Opt_check_r:
-			opts->name_check = 'r';
-			break;
-		case Opt_check_n:
-			opts->name_check = 'n';
-			break;
-		case Opt_usefree:
-			opts->usefree = 1;
-			break;
-		case Opt_nocase:
-			if (!is_vfat)
-				opts->nocase = 1;
-			else {
-				/* for backward compatibility */
-				opts->shortname = VFAT_SFN_DISPLAY_WIN95
-					| VFAT_SFN_CREATE_WIN95;
-			}
-			break;
-		case Opt_quiet:
-			opts->quiet = 1;
-			break;
-		case Opt_showexec:
-			opts->showexec = 1;
-			break;
-		case Opt_debug:
-			opts->debug = 1;
-			break;
-		case Opt_immutable:
-			opts->sys_immutable = 1;
-			break;
-		case Opt_uid:
-			if (match_int(&args[0], &option))
-				return -EINVAL;
-			opts->fs_uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(opts->fs_uid))
-				return -EINVAL;
-			break;
-		case Opt_gid:
-			if (match_int(&args[0], &option))
-				return -EINVAL;
-			opts->fs_gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(opts->fs_gid))
-				return -EINVAL;
-			break;
-		case Opt_umask:
-			if (match_octal(&args[0], &option))
-				return -EINVAL;
-			opts->fs_fmask = opts->fs_dmask = option;
-			break;
-		case Opt_dmask:
-			if (match_octal(&args[0], &option))
-				return -EINVAL;
-			opts->fs_dmask = option;
-			break;
-		case Opt_fmask:
-			if (match_octal(&args[0], &option))
-				return -EINVAL;
-			opts->fs_fmask = option;
-			break;
-		case Opt_allow_utime:
-			if (match_octal(&args[0], &option))
-				return -EINVAL;
-			opts->allow_utime = option & (S_IWGRP | S_IWOTH);
-			break;
-		case Opt_codepage:
-			if (match_int(&args[0], &option))
-				return -EINVAL;
-			opts->codepage = option;
-			break;
-		case Opt_flush:
-			opts->flush = 1;
-			break;
-		case Opt_time_offset:
-			if (match_int(&args[0], &option))
-				return -EINVAL;
-			/*
-			 * GMT+-12 zones may have DST corrections so at least
-			 * 13 hours difference is needed. Make the limit 24
-			 * just in case someone invents something unusual.
-			 */
-			if (option < -24 * 60 || option > 24 * 60)
-				return -EINVAL;
-			opts->tz_set = 1;
-			opts->time_offset = option;
-			break;
-		case Opt_tz_utc:
-			opts->tz_set = 1;
-			opts->time_offset = 0;
-			break;
-		case Opt_err_cont:
-			opts->errors = FAT_ERRORS_CONT;
-			break;
-		case Opt_err_panic:
-			opts->errors = FAT_ERRORS_PANIC;
-			break;
-		case Opt_err_ro:
-			opts->errors = FAT_ERRORS_RO;
-			break;
-		case Opt_nfs_stale_rw:
-			opts->nfs = FAT_NFS_STALE_RW;
-			break;
-		case Opt_nfs_nostale_ro:
-			opts->nfs = FAT_NFS_NOSTALE_RO;
-			break;
-		case Opt_dos1xfloppy:
-			opts->dos1xfloppy = 1;
-			break;
+static const struct fs_parameter_spec vfat_param_spec[] = {
+	fsparam_string	("iocharset",	Opt_charset),
+	fsparam_enum	("shortname",	Opt_shortname, fat_param_shortname),
+	fsparam_flag	("utf8",	Opt_utf8),
+	fsparam_bool	("utf8",	Opt_utf8_bool),
+	fsparam_flag	("uni_xlate",	Opt_uni_xl),
+	fsparam_bool	("uni_xlate",	Opt_uni_xl_bool),
+	fsparam_flag	("nonumtail",	Opt_nonumtail),
+	fsparam_bool	("nonumtail",	Opt_nonumtail_bool),
+	fsparam_flag	("rodir",	Opt_rodir),
+	{}
+};
 
-		/* msdos specific */
-		case Opt_dots:
-			opts->dotsOK = 1;
-			break;
-		case Opt_nodots:
-			opts->dotsOK = 0;
-			break;
+int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
+			   int is_vfat)
+{
+	struct fat_mount_options *opts = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
+	char buf[50];
+	kuid_t uid;
+	kgid_t gid;
+
+	opt = fs_parse(fc, fat_param_spec, param, &result);
+	/* If option not found in fat_param_spec, try vfat/msdos options */
+	if (opt == -ENOPARAM) {
+		if (is_vfat)
+			opt = fs_parse(fc, vfat_param_spec, param, &result);
+		else
+			opt = fs_parse(fc, msdos_param_spec, param, &result);
+	}
 
-		/* vfat specific */
-		case Opt_charset:
-			fat_reset_iocharset(opts);
-			iocharset = match_strdup(&args[0]);
-			if (!iocharset)
-				return -ENOMEM;
-			opts->iocharset = iocharset;
-			break;
-		case Opt_shortname_lower:
-			opts->shortname = VFAT_SFN_DISPLAY_LOWER
-					| VFAT_SFN_CREATE_WIN95;
-			break;
-		case Opt_shortname_win95:
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_check:
+		opts->name_check = result.uint_32;
+		break;
+	case Opt_usefree:
+		opts->usefree = 1;
+		break;
+	case Opt_nocase:
+		if (!is_vfat)
+			opts->nocase = 1;
+		else {
+			/* for backward compatibility */
 			opts->shortname = VFAT_SFN_DISPLAY_WIN95
-					| VFAT_SFN_CREATE_WIN95;
-			break;
-		case Opt_shortname_winnt:
-			opts->shortname = VFAT_SFN_DISPLAY_WINNT
-					| VFAT_SFN_CREATE_WINNT;
-			break;
-		case Opt_shortname_mixed:
-			opts->shortname = VFAT_SFN_DISPLAY_WINNT
-					| VFAT_SFN_CREATE_WIN95;
-			break;
-		case Opt_utf8_no:		/* 0 or no or false */
-			opts->utf8 = 0;
-			break;
-		case Opt_utf8_yes:		/* empty or 1 or yes or true */
-			opts->utf8 = 1;
-			break;
-		case Opt_uni_xl_no:		/* 0 or no or false */
-			opts->unicode_xlate = 0;
-			break;
-		case Opt_uni_xl_yes:		/* empty or 1 or yes or true */
-			opts->unicode_xlate = 1;
-			break;
-		case Opt_nonumtail_no:		/* 0 or no or false */
-			opts->numtail = 1;	/* negated option */
-			break;
-		case Opt_nonumtail_yes:		/* empty or 1 or yes or true */
-			opts->numtail = 0;	/* negated option */
-			break;
-		case Opt_rodir:
-			opts->rodir = 1;
-			break;
-		case Opt_discard:
-			opts->discard = 1;
-			break;
-
-		/* obsolete mount options */
-		case Opt_obsolete:
-			fat_msg(sb, KERN_INFO, "\"%s\" option is obsolete, "
-			       "not supported now", p);
-			break;
-		/* unknown option */
-		default:
-			if (!silent) {
-				fat_msg(sb, KERN_ERR,
-				       "Unrecognized mount option \"%s\" "
-				       "or missing value", p);
-			}
-			return -EINVAL;
+				| VFAT_SFN_CREATE_WIN95;
 		}
-	}
-
-out:
-	/* UTF-8 doesn't provide FAT semantics */
-	if (!strcmp(opts->iocharset, "utf8")) {
-		fat_msg(sb, KERN_WARNING, "utf8 is not a recommended IO charset"
-		       " for FAT filesystems, filesystem will be "
-		       "case sensitive!");
-	}
-
-	/* If user doesn't specify allow_utime, it's initialized from dmask. */
-	if (opts->allow_utime == (unsigned short)-1)
-		opts->allow_utime = ~opts->fs_dmask & (S_IWGRP | S_IWOTH);
-	if (opts->unicode_xlate)
-		opts->utf8 = 0;
-	if (opts->nfs == FAT_NFS_NOSTALE_RO) {
-		sb->s_flags |= SB_RDONLY;
-		sb->s_export_op = &fat_export_ops_nostale;
+		break;
+	case Opt_quiet:
+		opts->quiet = 1;
+		break;
+	case Opt_showexec:
+		opts->showexec = 1;
+		break;
+	case Opt_debug:
+		opts->debug = 1;
+		break;
+	case Opt_immutable:
+		opts->sys_immutable = 1;
+		break;
+	case Opt_uid:
+		uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(uid))
+			return -EINVAL;
+		opts->fs_uid = uid;
+		break;
+	case Opt_gid:
+		gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(gid))
+			return -EINVAL;
+		opts->fs_gid = gid;
+		break;
+	case Opt_umask:
+		opts->fs_fmask = opts->fs_dmask = result.uint_32;
+		break;
+	case Opt_dmask:
+		opts->fs_dmask = result.uint_32;
+		break;
+	case Opt_fmask:
+		opts->fs_fmask = result.uint_32;
+		break;
+	case Opt_allow_utime:
+		opts->allow_utime = result.uint_32 & (S_IWGRP | S_IWOTH);
+		break;
+	case Opt_codepage:
+		sprintf(buf, "cp%d", result.uint_32);
+		opts->codepage = result.uint_32;
+		break;
+	case Opt_flush:
+		opts->flush = 1;
+		break;
+	case Opt_time_offset:
+		/*
+		 * GMT+-12 zones may have DST corrections so at least
+		 * 13 hours difference is needed. Make the limit 24
+		 * just in case someone invents something unusual.
+		 */
+		if (result.int_32 < -24 * 60 || result.int_32 > 24 * 60)
+			return -EINVAL;
+		opts->tz_set = 1;
+		opts->time_offset = result.int_32;
+		break;
+	case Opt_tz:
+		opts->tz_set = 1;
+		opts->time_offset = result.uint_32;
+		break;
+	case Opt_errors:
+		opts->errors = result.uint_32;
+		break;
+	case Opt_nfs:
+		opts->nfs = FAT_NFS_STALE_RW;
+		break;
+	case Opt_nfs_enum:
+		opts->nfs = result.uint_32;
+		break;
+	case Opt_dos1xfloppy:
+		opts->dos1xfloppy = 1;
+		break;
+
+	/* msdos specific */
+	case Opt_dots:	/* dots / nodots */
+		opts->dotsOK = !result.negated;
+		break;
+	case Opt_dotsOK:	/* dotsOK = yes/no */
+		opts->dotsOK = result.boolean;
+		break;
+
+	/* vfat specific */
+	case Opt_charset:
+		fat_reset_iocharset(opts);
+		opts->iocharset = param->string;
+		param->string = NULL;	/* Steal string */
+		break;
+	case Opt_shortname:
+		opts->shortname = result.uint_32;
+		break;
+	case Opt_utf8:
+		opts->utf8 = 1;
+		break;
+	case Opt_utf8_bool:
+		opts->utf8 = result.boolean;
+		break;
+	case Opt_uni_xl:
+		opts->unicode_xlate = 1;
+		break;
+	case Opt_uni_xl_bool:
+		opts->unicode_xlate = result.boolean;
+		break;
+	case Opt_nonumtail:
+		opts->numtail = 0;	/* negated option */
+		break;
+	case Opt_nonumtail_bool:
+		opts->numtail = !result.boolean; /* negated option */
+		break;
+	case Opt_rodir:
+		opts->rodir = 1;
+		break;
+	case Opt_discard:
+		opts->discard = 1;
+		break;
+
+	/* obsolete mount options */
+	case Opt_obsolete:
+		infof(fc, "\"%s\" option is obsolete, not supported now",
+		      param->key);
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(fat_parse_param);
 
 static int fat_read_root(struct inode *inode)
 {
@@ -1604,9 +1530,11 @@ static int fat_read_static_bpb(struct super_block *sb,
 /*
  * Read the super block of an MS-DOS FS.
  */
-int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
+int fat_fill_super(struct super_block *sb, struct fs_context *fc,
 		   void (*setup)(struct super_block *))
 {
+	struct fat_mount_options *opts = fc->fs_private;
+	int silent = fc->sb_flags & SB_SILENT;
 	struct inode *root_inode = NULL, *fat_inode = NULL;
 	struct inode *fsinfo_inode = NULL;
 	struct buffer_head *bh;
@@ -1642,10 +1570,27 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	ratelimit_state_init(&sbi->ratelimit, DEFAULT_RATELIMIT_INTERVAL,
 			     DEFAULT_RATELIMIT_BURST);
 
-	error = parse_options(sb, data, isvfat, silent, &sbi->options);
-	if (error)
-		goto out_fail;
+	/* Fix up option set */
+
+	/* UTF-8 doesn't provide FAT semantics */
+	if (!strcmp(opts->iocharset, "utf8")) {
+		fat_msg(sb, KERN_WARNING, "utf8 is not a recommended IO charset"
+		       " for FAT filesystems, filesystem will be"
+		       " case sensitive!");
+	}
+
+	/* If user doesn't specify allow_utime, it's initialized from dmask. */
+	if (opts->allow_utime == (unsigned short)-1)
+		opts->allow_utime = ~opts->fs_dmask & (S_IWGRP | S_IWOTH);
+	if (opts->unicode_xlate)
+		opts->utf8 = 0;
+	if (opts->nfs == FAT_NFS_NOSTALE_RO) {
+		sb->s_flags |= SB_RDONLY;
+		sb->s_export_op = &fat_export_ops_nostale;
+	}
 
+	/* Apply pparsed options to sbi */
+	sbi->options = *opts;
 	setup(sb); /* flavour-specific stuff that needs options */
 
 	error = -EIO;
@@ -1831,7 +1776,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	 */
 
 	error = -EINVAL;
-	sprintf(buf, "cp%d", sbi->options.codepage);
+	sprintf(buf, "cp%d", opts->codepage);
 	sbi->nls_disk = load_nls(buf);
 	if (!sbi->nls_disk) {
 		fat_msg(sb, KERN_ERR, "codepage %s not found", buf);
@@ -1840,10 +1785,10 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 
 	/* FIXME: utf8 is using iocharset for upper/lower conversion */
 	if (sbi->options.isvfat) {
-		sbi->nls_io = load_nls(sbi->options.iocharset);
+		sbi->nls_io = load_nls(opts->iocharset);
 		if (!sbi->nls_io) {
 			fat_msg(sb, KERN_ERR, "IO charset %s not found",
-			       sbi->options.iocharset);
+			       opts->iocharset);
 			goto out_fail;
 		}
 	}
@@ -1949,6 +1894,57 @@ int fat_flush_inodes(struct super_block *sb, struct inode *i1, struct inode *i2)
 }
 EXPORT_SYMBOL_GPL(fat_flush_inodes);
 
+int fat_init_fs_context(struct fs_context *fc, bool is_vfat)
+{
+	struct fat_mount_options *opts;
+
+	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+
+	opts->isvfat = is_vfat;
+	opts->fs_uid = current_uid();
+	opts->fs_gid = current_gid();
+	opts->fs_fmask = opts->fs_dmask = current_umask();
+	opts->allow_utime = -1;
+	opts->codepage = fat_default_codepage;
+	fat_reset_iocharset(opts);
+	if (is_vfat) {
+		opts->shortname = VFAT_SFN_DISPLAY_WINNT|VFAT_SFN_CREATE_WIN95;
+		opts->rodir = 0;
+	} else {
+		opts->shortname = 0;
+		opts->rodir = 1;
+	}
+	opts->name_check = 'n';
+	opts->quiet = opts->showexec = opts->sys_immutable = opts->dotsOK =  0;
+	opts->unicode_xlate = 0;
+	opts->numtail = 1;
+	opts->usefree = opts->nocase = 0;
+	opts->tz_set = 0;
+	opts->nfs = 0;
+	opts->errors = FAT_ERRORS_RO;
+	opts->debug = 0;
+
+	opts->utf8 = IS_ENABLED(CONFIG_FAT_DEFAULT_UTF8) && is_vfat;
+
+	fc->fs_private = opts;
+	/* fc->ops assigned by caller */
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fat_init_fs_context);
+
+void fat_free_fc(struct fs_context *fc)
+{
+	struct fat_mount_options *opts = fc->fs_private;
+
+	if (opts->iocharset != fat_default_iocharset)
+		kfree(opts->iocharset);
+	kfree(fc->fs_private);
+}
+EXPORT_SYMBOL_GPL(fat_free_fc);
+
 static int __init init_fat_fs(void)
 {
 	int err;
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 2116c486843b..b7f462fb9a40 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -650,24 +650,48 @@ static void setup(struct super_block *sb)
 	sb->s_flags |= SB_NOATIME;
 }
 
-static int msdos_fill_super(struct super_block *sb, void *data, int silent)
+static int msdos_fill_super(struct super_block *sb, struct fs_context *fc)
 {
-	return fat_fill_super(sb, data, silent, 0, setup);
+	return fat_fill_super(sb, fc, setup);
 }
 
-static struct dentry *msdos_mount(struct file_system_type *fs_type,
-			int flags, const char *dev_name,
-			void *data)
+static int msdos_get_tree(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, msdos_fill_super);
+	return get_tree_bdev(fc, msdos_fill_super);
+}
+
+static int msdos_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	return fat_parse_param(fc, param, 0);
+}
+
+static const struct fs_context_operations msdos_context_ops = {
+	.parse_param	= msdos_parse_param,
+	.get_tree	= msdos_get_tree,
+	.reconfigure	= fat_reconfigure,
+	.free		= fat_free_fc,
+};
+
+static int msdos_init_fs_context(struct fs_context *fc)
+{
+	int err;
+
+	/* Initialize with isvfat == 0 */
+	err = fat_init_fs_context(fc, 0);
+	if (err)
+		return err;
+
+	fc->ops = &msdos_context_ops;
+	return 0;
 }
 
 static struct file_system_type msdos_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "msdos",
-	.mount		= msdos_mount,
 	.kill_sb	= kill_block_super,
 	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.init_fs_context = msdos_init_fs_context,
+	.parameters	= fat_param_spec,
 };
 MODULE_ALIAS_FS("msdos");
 
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index c4d00999a433..8f1913dd0c83 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1195,24 +1195,48 @@ static void setup(struct super_block *sb)
 		sb->s_d_op = &vfat_dentry_ops;
 }
 
-static int vfat_fill_super(struct super_block *sb, void *data, int silent)
+static int vfat_fill_super(struct super_block *sb, struct fs_context *fc)
 {
-	return fat_fill_super(sb, data, silent, 1, setup);
+	return fat_fill_super(sb, fc, setup);
 }
 
-static struct dentry *vfat_mount(struct file_system_type *fs_type,
-		       int flags, const char *dev_name,
-		       void *data)
+static int vfat_get_tree(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, vfat_fill_super);
+	return get_tree_bdev(fc, vfat_fill_super);
+}
+
+static int vfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	return fat_parse_param(fc, param, 1);
+}
+
+static const struct fs_context_operations vfat_context_ops = {
+	.parse_param	= vfat_parse_param,
+	.get_tree	= vfat_get_tree,
+	.reconfigure	= fat_reconfigure,
+	.free		= fat_free_fc,
+};
+
+static int vfat_init_fs_context(struct fs_context *fc)
+{
+	int err;
+
+	/* Initialize with isvfat == 1 */
+	err = fat_init_fs_context(fc, 1);
+	if (err)
+		return err;
+
+	fc->ops = &vfat_context_ops;
+	return 0;
 }
 
 static struct file_system_type vfat_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "vfat",
-	.mount		= vfat_mount,
 	.kill_sb	= kill_block_super,
 	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.init_fs_context = vfat_init_fs_context,
+	.parameters     = fat_param_spec,
 };
 MODULE_ALIAS_FS("vfat");
 
-- 
2.45.2



