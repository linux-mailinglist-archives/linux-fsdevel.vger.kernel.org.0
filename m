Return-Path: <linux-fsdevel+bounces-63157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3548BAFE86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 11:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADBB2A0F67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581502DC323;
	Wed,  1 Oct 2025 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWn9d93b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6EC2DA755
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311835; cv=none; b=FMw5r6JrgfrjblkgB77Dhy04UB256T6H25Ob5snMXs8xRD9D8rrTE2A1N5bMnfpxMnymYYYtkUMnlF6z3GzLl0T0FLs/Jo1GBpZ7eczUhaPTKZjwmFRO0/+pG0hKtzXXNT2KPumYKLCmEWchb7NTfavsCCjFk0UCIQWAOfshF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311835; c=relaxed/simple;
	bh=ongDB0Pty1DRgDK7cUbIM5q/ExUfYVOWDm6lciYAdr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCMpkMwKPNgsXusvg94RL/XAq/zuz4tkUwS5y6yBmp8H2dYlIB3RRKgbT57qaYdABOJYE74WcGoWHAVkrP1SXwz4k5nKxgeUx5SpcRIXGe0l14Q/BABMf4Hhy4Yrxlk+3SgXJ20cAvYx7rNZQwYu4Y8FehkRXXcYaY46oa6FOMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWn9d93b; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781997d195aso3128431b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Oct 2025 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759311833; x=1759916633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4vdJdBt+Nr80DlfAVPf7IR3F3kl2Y2rk5v2m5tTJwGs=;
        b=bWn9d93bogdaR/AWBk2lxAV2Keng+pX3rNx6tcqHOfOD7uY29ZO2dg4+CP3tnlUPZE
         la4clzi2iq0HZ3UD9N2JDuCqEz/gd3g/VJgTgLR4d1v47CTKMmM+PFhDv2+Vv+G4j157
         si90qzkIW36ly42H6IX0wZC0wuiKUgwaIvr472wEGsbkr+TcovONdbIfA6lmuSxe8zUs
         1P8E/lv1D7xhanCeQIZ8WhjndFn1wSGouA0QxV+F5ZtyET0ccB+z21CKjiY791JSnBCW
         foBGZ7BRVszwwZdDbo1zNBjP//YQJe9lDSkheUxh0TjeTZtrt/8gl9dO7NrXX7Ik+cKP
         tngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759311833; x=1759916633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vdJdBt+Nr80DlfAVPf7IR3F3kl2Y2rk5v2m5tTJwGs=;
        b=RwCbBk9xJMaeTrt5khCaGm+Yfl/KsIYsbW5B5IwkHcBBgVHbyTsoRS5MQLqcDAxaAJ
         1NTM4S08wU2w07fU2kU7z02sUgQMb4el7DhSWye3ADiijOMOWb81rqtoAwExbl0yPISG
         FgUkiwoelCXd/KrCYvHSmy6dD0FYTTM+u1cBavN4yE1QyxF6RnYfCzr8njkKbpWO1oET
         Wi8t9fw2/XOF88hcRSoz7zyMKrTSyO5zo6v9XEX9LWi0VS4qPw8qKz/hCLLymhzQJUou
         yphfjpfQ7SNVUg13e2b2h/yQpbbLvpSxANkzp2hTUatlftK0wK3olTzCC7YcJx1EbKU4
         BptQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4D+NqsD4cwNAOSPwhzYZrYPxbQPOZDZGW+FLpln5GjZyGwT2aVsya9Ofh7oLZc8hcCF8Xsl4/iBNeFvwC@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2huAIL2MmtkkbPYDRMDmtYMRc+eEz3EuXpxjStEBy+1rasLN
	B9FQehatxZiJCZu5R2Nu4kF8tef1WVJFU32vSh2yrciZ5CmGMt0+OsAs
X-Gm-Gg: ASbGncuoTySBkKv8O/5y2fZd/1M/SFlOfSrDV9TDKcTq67iu/UKUzKnCal3mbul/0Tp
	8gao7Z7taAzF9m/Nn1tx3Zv3zalnucweH2zjQawb4Nf8QtxULmnp2WOEZnjOoQqGVv7AiJjlVm+
	5t+ounJuQB2ayroJFzZknAmojegnUNlrq8TrQhToS/WWTD5qyyq1MaslMomYCRtoX5ew0bP+qUr
	4qCtwKq5r+UCzZR5Jd2RDVtgRu/uu+eNuDwkqZ3jI00GIVGyIfYAocOcWzS5UEyj2djDnsojLU1
	auscxsgEi+9R75Tg8KKVzDR+qGO/VnhwTrMxZmDDFzX7m/eIrWQYbdATizIViwgAG3qJuO9S9xH
	KY327M1I08M1sjkdTp2MlTzBcVVnz7mf/V5mJjIyZu5TgJAhV03P2ydk/X7IVrGCrAbGkGNiUMy
	NL8ENottxvzR9O7Vwt/Z6oCmrnxLeB/0qOpjDrXg==
X-Google-Smtp-Source: AGHT+IGlxxcNR7XDAyX4adXF1GcePCKMdbrxEUyXnPCJOnQwtrOiaD0zrpCNu1lna5j8aUrWpQM91w==
X-Received: by 2002:a05:6a20:d0a3:b0:319:75fe:783 with SMTP id adf61e73a8af0-321dc4bb48bmr4007826637.27.1759311832950;
        Wed, 01 Oct 2025 02:43:52 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:bf1f:a781:827e:8d26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c057ecsm15780763b3a.80.2025.10.01.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:43:52 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com
Subject: [PATCH] isofs: fix inode leak caused by disconnected dentries from exportfs
Date: Wed,  1 Oct 2025 15:13:10 +0530
Message-ID: <20251001094310.1672933-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When open_by_handle_at() is used with iso9660 filesystems, exportfs
creates disconnected dentries during file handle resolution. If the
operation fails (e.g., with -ESTALE during reconnect_path()), these
dentries remain cached with their associated inodes.

During unmount, shrink_dcache_for_umount() does not fully evict these
disconnected dentries, leaving their inodes with non-zero reference
counts. This triggers the "VFS: Busy inodes after unmount" warning
and causes inode leaks that accumulate across mount/unmount cycles.

The issue occurs because:
1. open_by_handle_at() calls exportfs_decode_fh_raw() to resolve
   file handles
2. For iso9660 with Joliet extensions, this creates disconnected
   dentries for both primary (iso9660) and secondary (Joliet) root
   inodes
3. When path reconnection fails with -ESTALE, the dentries are left
   in DCACHE_DISCONNECTED state
4. shrink_dcache_for_umount() in generic_shutdown_super() does not
   aggressively evict these disconnected dentries
5. The associated inodes (typically root inodes 1792 and 1807)
   remain with i_count=1, triggering the busy inode check

Add explicit shrink_dcache_sb() call in isofs_put_super() to ensure
all cached dentries, including disconnected ones created by exportfs
operations, are released before the superblock is destroyed.

Reported-by: syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com
Tested-by: syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/isofs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 6f0e6b19383c..bee410705442 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -52,6 +52,7 @@ static int isofs_dentry_cmp_ms(const struct dentry *dentry,
 static void isofs_put_super(struct super_block *sb)
 {
 	struct isofs_sb_info *sbi = ISOFS_SB(sb);
+	shrink_dcache_sb(sb);
 
 #ifdef CONFIG_JOLIET
 	unload_nls(sbi->s_nls_iocharset);
-- 
2.43.0


