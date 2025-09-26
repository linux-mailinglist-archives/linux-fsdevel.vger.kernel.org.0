Return-Path: <linux-fsdevel+bounces-62898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A53EBA471A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 17:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD9A383E7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 15:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0E82135B8;
	Fri, 26 Sep 2025 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV4Gn/aa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E2216E1B
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900937; cv=none; b=DGEIOniT2xigcWJrsjNMrOEsgU1hcM4uFq2J3LkaXiZ3hHPViXcMmxHvsyWPl59hy+sCrrn97ba8WyURZ/n0XoARvU1gjOq0T5mqoJdCVzo+Un+2rdjUjSQfMSbXB6FBlxcjui4SqYS5RLABGkpAG52W3w7mQ791ZBRxnnxQa1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900937; c=relaxed/simple;
	bh=6bQ8+f5PBov8iIBeCvczEDonTphL8cBkOFcdiqz2eng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HspyICPnuLEo95uMsH4uEgQeD4CwbWPlvGZXwMxS5LS7kkixEhrJKTBT5KK7oN+ycHz4bHPwmccAui/V/e7BaQ170HpnPhCYrvylrsmAh0JemZxjnItLcSKXf5oOYUAFL62ztt0wLl8TMVtFjJ8zf2zZWITSQrfMPAAgcUoG6KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UV4Gn/aa; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7810289cd4bso2085161b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758900935; x=1759505735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t3QolWh9yQNhYU+vX6JITZzux4tGJdvU1Io4E63l5RY=;
        b=UV4Gn/aajIH3ROux6+Xq3a1HPREJrAU0tPa4nQQhe2LUzWbdTHVpDneOP34xeAaM8u
         DNczL717hqw2aItiHVzRGqjEHCYpBSTWU+HTnOgspjbPF9G6kQE7hwmQgP8Q5oBE2dS5
         svi9GF/8pQsQxS9DLWdm960Qsz+t8vQj57XT1pQlFfDcgyGnXUL01AG5RLlD81cQ/SBl
         XaG/+S4YtZmeLUZJ9eLgE7NyYb8v9tnc58S1XqqKHIvTrWP0i7CcHCX8MX0R9letvMfu
         xrB6UWbEpeeVOI9CMpH5+55e/jbBfN9v9BV98ocBqlqcNBQHYOEtXWSCDeZPc0LX/VRC
         Lzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758900935; x=1759505735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3QolWh9yQNhYU+vX6JITZzux4tGJdvU1Io4E63l5RY=;
        b=ttUGJMETkXZGjTapP80tfExvAx+vYl+PK3piUMIMC6BpS7FNfs4jdur0a3Pbm7idR4
         jEIfQ2VPKMXSUYZ/LKZud51R7jy7kVtegaBnvNJ0PS7qa54vus+oomi5E3C3reJS9HHQ
         EFf4FtIvC24Os07dByRiJESL+kJwurFfYT1+OVIAc5zV2QC2Bh8hp7HyEsZtO2bO1jYM
         RXjUHua4Kh85bkN2SHnbWqQyeCdVtpqQKZPLf7CUm9lvpqcS02V2p1877Ly4tHu+ispX
         fU6fArIixKQiMNuncmioP8OcAIRLl3wvFc+6pqA+flviQcDbgnH/CLbIBNTpiqv9Ibw4
         zfHw==
X-Gm-Message-State: AOJu0YwMJ7I2kw+IuXecovXXFZRS8MdZWSxq9b8qaXXZRRpKWKrGtsFL
	msbaaR0isdBXCfJBRV2t+1rpRPHz5perhTy3TaztWeNRjwwHOjG8SfaK
X-Gm-Gg: ASbGncsWDda5Js3qcloMVa7rj371XNVDUSeoeSZvg/CI+yXgq06vxbJXLKUkegc8hXV
	sxpfxO6c2DM3VeCgFuwwHy/lBs6WNPjyHjqvovLjLNtjYcpGSudHauLGGhaSYl+dhzVih3XCpzT
	4cW25M9sbpEK1E+FVY2NeCD4LNGgQqcVK5vkd0n6aHEzIhvazfz4I9l/PbHBAA+8smNXWX1a6bc
	EHfO9519UIm32yeNFwd67VXgiLdS+xOPME7E6uFqy+fQkzFAhlZNU3190CmX9G44K+fU2fSbL82
	nN1osgqYxOGhlbUyeeUc8qTQS19sV4zdwwkAUelRWyJTO3g6R4C23KK3wseaoKhxELDWDY7qKwA
	wrCnjiO58DyuEskiS9o/GhMGQvak=
X-Google-Smtp-Source: AGHT+IF3S7EfQN9PdbP2G4VJKj9LRuJ1Ck86dbGS/Ex74BrmT0AVyyBaUL2/KOyZVJIrdv8WsTZYGw==
X-Received: by 2002:a05:6a00:2da2:b0:781:1bf7:8c5a with SMTP id d2e1a72fcca58-7811bf798d4mr2285167b3a.1.1758900935397;
        Fri, 26 Sep 2025 08:35:35 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c279f8sm4786497b3a.98.2025.09.26.08.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:35:35 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
Subject: [PATCH v2] exfat: combine iocharset and utf8 option setup
Date: Sat, 27 Sep 2025 00:35:22 +0900
Message-ID: <20250926153522.922821-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, exfat utf8 mount option depends on the iocharset option
value. After exfat remount, utf8 option may become inconsistent with
iocharset option.

If the options are inconsistent; (specifically, iocharset=utf8 but
utf8=0) readdir may reference uninitalized NLS, leading to a null
pointer dereference.

Extract and combine utf8/iocharset setup logic into exfat_set_iocharset().
Then Replace iocharset setup logic to exfat_set_iocharset to prevent
utf8/iocharset option inconsistentcy after remount.

Reported-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3e9cb93e3c5f90d28e19
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Fixes: acab02ffcd6b ("exfat: support modifying mount options via remount")
Tested-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
---
Changes from v1 [1]
- extract utf8/iocharset setup logic to tiny function
- apply utf8/iocharset setup to exfat_init_fs_context()

[1] https://lore.kernel.org/all/20250925184040.692919-1-ekffu200098@gmail.com/
---
 fs/exfat/super.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index e1cffa46eb73..7f9592856bf7 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -31,6 +31,16 @@ static void exfat_free_iocharset(struct exfat_sb_info *sbi)
 		kfree(sbi->options.iocharset);
 }
 
+static void exfat_set_iocharset(struct exfat_mount_options *opts,
+				char *iocharset)
+{
+	opts->iocharset = iocharset;
+	if (!strcmp(opts->iocharset, "utf8"))
+		opts->utf8 = 1;
+	else
+		opts->utf8 = 0;
+}
+
 static void exfat_put_super(struct super_block *sb)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -292,7 +302,7 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_charset:
 		exfat_free_iocharset(sbi);
-		opts->iocharset = param->string;
+		exfat_set_iocharset(opts, param->string);
 		param->string = NULL;
 		break;
 	case Opt_errors:
@@ -664,8 +674,8 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* set up enough so that it can read an inode */
 	exfat_hash_init(sb);
 
-	if (!strcmp(sbi->options.iocharset, "utf8"))
-		opts->utf8 = 1;
+	if (sbi->options.utf8)
+		set_default_d_op(sb, &exfat_utf8_dentry_ops);
 	else {
 		sbi->nls_io = load_nls(sbi->options.iocharset);
 		if (!sbi->nls_io) {
@@ -674,12 +684,8 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 			err = -EINVAL;
 			goto free_table;
 		}
-	}
-
-	if (sbi->options.utf8)
-		set_default_d_op(sb, &exfat_utf8_dentry_ops);
-	else
 		set_default_d_op(sb, &exfat_dentry_ops);
+	}
 
 	root_inode = new_inode(sb);
 	if (!root_inode) {
@@ -809,8 +815,8 @@ static int exfat_init_fs_context(struct fs_context *fc)
 	sbi->options.fs_fmask = current->fs->umask;
 	sbi->options.fs_dmask = current->fs->umask;
 	sbi->options.allow_utime = -1;
-	sbi->options.iocharset = exfat_default_iocharset;
 	sbi->options.errors = EXFAT_ERRORS_RO;
+	exfat_set_iocharset(&sbi->options, exfat_default_iocharset);
 
 	fc->s_fs_info = sbi;
 	fc->ops = &exfat_context_ops;
-- 
2.43.0


