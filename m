Return-Path: <linux-fsdevel+bounces-68944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA32C69880
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 14:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34EDD35706A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 13:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE392D9EFF;
	Tue, 18 Nov 2025 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="SCwwqgoP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2567DA937;
	Tue, 18 Nov 2025 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763471136; cv=none; b=JbcQ3V46SdyqeVxkUorQ9s57HvJViD/eT4Gzn6uRZaZYNikIINBLbzuwks6RoAYk1rH9HybNX/a3NpyLNVQ5fvB9NXkH0hMxNWga+GuKy3xHvf+I+0np2IT+rnzHohEwyMG3Ix8bN4BXP7oHVj0FfseGDBIUrT/jqyIk65I09S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763471136; c=relaxed/simple;
	bh=9ONkrj7BZ1m5ej+9LXAaeu8wP26cgyTZ8qiS7R2I/1E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZH+BTQ9GYEUG+oW7gRLNDVIna9/9IMU/f4oWvVVoSMaWFNIpiM7gQITBqWdKizf1yo/c3PSN22E96HaFj5pBmNNiToCsZJ0fEcPclS3uoL9jYz8OxWawXRz08xUnbzJwsCG/T6x7vMhTCeY8omBa/qMcWFnbhePfUuuMxUeDRAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=SCwwqgoP; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id DFCC81E0F;
	Tue, 18 Nov 2025 13:02:00 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=SCwwqgoP;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id D435A222D;
	Tue, 18 Nov 2025 13:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1763471126;
	bh=s/kOILnGEqVR4I6+/Ay3drAHHK2TbmHJyvWWPeLKInc=;
	h=From:To:CC:Subject:Date;
	b=SCwwqgoPxQnVzn6+F11ndM7/55ib69Wi7P/QOzewgfl6KMa9j/pZ7vLZc0XNXzzBO
	 MzgstcpaBT2MizThHwTt/izfHIABulkeEBFs0XqyBI68fsWIWOR3KN70MrFyoWx/rY
	 20r82f+KmsQXH6JHqD41sQ4LKNdRUNO3hJDof4cQ=
Received: from localhost.localdomain (172.30.20.188) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 18 Nov 2025 16:05:25 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: change the default mount options for "acl" and "prealloc"
Date: Tue, 18 Nov 2025 14:05:17 +0100
Message-ID: <20251118130517.411283-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Switch the "acl" and "prealloc" mount parameters to fsparam_flag_no(),
making them enabled by default and allowing users to disable them with
"noacl" and "noprealloc".

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/super.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 344217ab513c..c74e25eb66a5 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -284,9 +284,9 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag("hide_dot_files",	Opt_hide_dot_files),
 	fsparam_flag("windows_names",	Opt_windows_names),
 	fsparam_flag("showmeta",	Opt_showmeta),
-	fsparam_flag("acl",		Opt_acl),
+	fsparam_flag_no("acl",		Opt_acl),
 	fsparam_string("iocharset",	Opt_iocharset),
-	fsparam_flag("prealloc",	Opt_prealloc),
+	fsparam_flag_no("prealloc",	Opt_prealloc),
 	fsparam_flag("nocase",		Opt_nocase),
 	{}
 };
@@ -395,7 +395,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 		param->string = NULL;
 		break;
 	case Opt_prealloc:
-		opts->prealloc = 1;
+		opts->prealloc = !result.negated;
 		break;
 	case Opt_nocase:
 		opts->nocase = 1;
@@ -1259,12 +1259,12 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_export_op = &ntfs_export_ops;
 	sb->s_time_gran = NTFS_TIME_GRAN; // 100 nsec
 	sb->s_xattr = ntfs_xattr_handlers;
-	set_default_d_op(sb, sbi->options->nocase ? &ntfs_dentry_ops : NULL);
+	set_default_d_op(sb, options->nocase ? &ntfs_dentry_ops : NULL);
 
-	sbi->options->nls = ntfs_load_nls(sbi->options->nls_name);
-	if (IS_ERR(sbi->options->nls)) {
-		sbi->options->nls = NULL;
-		errorf(fc, "Cannot load nls %s", fc_opts->nls_name);
+	options->nls = ntfs_load_nls(options->nls_name);
+	if (IS_ERR(options->nls)) {
+		options->nls = NULL;
+		errorf(fc, "Cannot load nls %s", options->nls_name);
 		err = -EINVAL;
 		goto out;
 	}
@@ -1676,10 +1676,11 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 put_inode_out:
 	iput(inode);
 out:
-	if (sbi && sbi->options) {
-		unload_nls(sbi->options->nls);
-		kfree(sbi->options->nls_name);
-		kfree(sbi->options);
+	/* sbi->options == options */
+	if (options) {
+		unload_nls(options->nls);
+		kfree(options->nls_name);
+		kfree(options);
 		sbi->options = NULL;
 	}
 
@@ -1808,6 +1809,12 @@ static int __ntfs_init_fs_context(struct fs_context *fc)
 	opts->fs_gid = current_gid();
 	opts->fs_fmask_inv = ~current_umask();
 	opts->fs_dmask_inv = ~current_umask();
+	opts->prealloc = 1;
+
+#ifdef CONFIG_NTFS3_FS_POSIX_ACL
+	/* Set the default value 'acl' */
+	fc->sb_flags |= SB_POSIXACL;
+#endif
 
 	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
 		goto ok;
-- 
2.43.0


