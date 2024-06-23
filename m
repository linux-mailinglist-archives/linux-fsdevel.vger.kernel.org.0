Return-Path: <linux-fsdevel+bounces-22196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E8A9137C0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 07:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3054F2837EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 05:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B6A3A8D0;
	Sun, 23 Jun 2024 05:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObyLgvwu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70752BCE3;
	Sun, 23 Jun 2024 05:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719119509; cv=none; b=ApEHjzdJNH6HKkU8ERWY9PcGdosXuTAHN0zEBs5QsXT0zy1BpWvV7DTTwx5bNAQ5OY71O1rz09hd+xSftnaUcn+Bf8ucXbpgoYJZjFTjieQlBNr9MoAPL6gea0Lx2Gu8IP+B3DJ3md4BoVUGEHKn5SSMhd3h7UyUrvdOFyDThig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719119509; c=relaxed/simple;
	bh=KnxIZFudG3C1TxSI8/CmS0sJBmROfHw8jGPU93w5fu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kIy+bjz1tyWmrj2W6RBVTBoCEHSTyMihy+n6XAYhZs/HxoCxtcESVijZAxqw9B41nmKrfjWn7Joy06uDBVNMttZ2SaD5SEEQ45/30VQUghuOwrUir3JkYVovqElvRIQ2zuuyqUF7rQOcY/smQc6bODqTuFlmbWDMtl1rtf/Evqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObyLgvwu; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7066c799382so692631b3a.3;
        Sat, 22 Jun 2024 22:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719119507; x=1719724307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAvwFpe4xOuU3RCpzs53rLmBv8KRl44T9Keb6/shdb0=;
        b=ObyLgvwuCvFcJkg9qMalecjt3mgrbidrf757/6T0YwU26qiIisM7WlUK6+UoNEM0oQ
         HOtLkmBc8ij01RAQFmVsp5RO0Zj39GWmBhyQ6F1to6lKoHTo0RBChyZ+yWPfAJV/o4x7
         PAfmDa+F1eCHSu8HNgGkQKMVWiwpRB7rWnX3q10zUKwCtREyN0VpN3gNGjrVAKbBD5X6
         1JJZV0IKWSaNz224fO/9+4zhgiMPeDA2AP2E537s8vxxSd/QYMtBw9Zg/uAdYdHC6woV
         GoIxrM32AYPRdjNx5LZKCbknfUGV75L5m4mSjKl0vkvfZFIfpA178f/lTEi1iv3RDtZw
         vNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719119507; x=1719724307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAvwFpe4xOuU3RCpzs53rLmBv8KRl44T9Keb6/shdb0=;
        b=eN7jAj3IKL4JoOttEaTgnlycvJz7APatZUOFbe2yAsRey1Rfwa0ZoAIcy/iT02IsoF
         4HyCtVkuTitYRcnYNgC1zdpiDuCdGDOVMXBX70KFAKYFvQsjQzJ2+vYBJWtOo8/gwc+3
         3JQa1NGRSZETrp7JRqEUOeTmftNRP3rqzpI+X89kAdpWdzcPhW3xztEicrdXcVvcKw/1
         JjaK9000k01ZhaBCTdLNq2XEws/SBEG2LeQgPGqZJ8Dd+V3vZSMoQz6Jpps5nuOn72Qo
         +WgoiegDPXa39KgyZrp8J7PuHaFHGffZpzlVsQm+icsWhZmpbK6c6IYXtALvhs8NOKPJ
         G4yA==
X-Forwarded-Encrypted: i=1; AJvYcCV/SkRE+cOdbefIO8VJr6Ki9TvK7P2c5JJrG7mSuimgz0iKAaMBGzbDBhOdjA+L659vfjMXABuv9oId6NvrAOPY02IDuLo1pvCUDKWOFo1AjPxLI0ylazJ46HEBWeimW3sAyeRABbM16NR7ag==
X-Gm-Message-State: AOJu0YxCSTQy6IpAWsNeKXgTRe9U4oyUCemQaKFqbBMCkBPAp/9DXHVY
	SGY6QHd8Bw1ypbMiJ6e/ES2tDIkEHGz7rmtFB7G2npu8wAfwSI6KaMZEVQ==
X-Google-Smtp-Source: AGHT+IGlOVArsdPGcw35kvPGEqXKkqr+FViW/sPKKeoxDxroMFVMAS0N4X8ESJRTWqYkOsHZHpE4DA==
X-Received: by 2002:a05:6a00:1b44:b0:705:b15e:747b with SMTP id d2e1a72fcca58-7067471c5f6mr1816847b3a.30.1719119506929;
        Sat, 22 Jun 2024 22:11:46 -0700 (PDT)
Received: from carrot.. (i114-180-52-104.s42.a014.ap.plala.or.jp. [114.180.52.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512d3034sm4042844b3a.170.2024.06.22.22.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 22:11:46 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs <linux-nilfs@vger.kernel.org>,
	syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	LKML <linux-kernel@vger.kernel.org>,
	hdanton@sina.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	willy@infradead.org
Subject: [PATCH 1/3] nilfs2: fix inode number range checks
Date: Sun, 23 Jun 2024 14:11:33 +0900
Message-Id: <20240623051135.4180-2-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623051135.4180-1-konishi.ryusuke@gmail.com>
References: <000000000000fe2d22061af9206f@google.com>
 <20240623051135.4180-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current implementation of nilfs2, "nilfs->ns_first_ino", which
gives the first non-reserved inode number, is read from the
superblock, but its lower limit is not checked.

As a result, if a number that overlaps with the inode number range of
reserved inodes such as the root directory or metadata files is set in
the super block parameter, the inode number test macros
(NILFS_MDT_INODE and NILFS_VALID_INODE) will not function properly.

In addition, these test macros use left bit-shift calculations using
with the inode number as the shift count via the BIT macro, but the
result of a shift calculation that exceeds the bit width of an integer
is undefined in the C specification, so if "ns_first_ino" is set to a
large value other than the default value NILFS_USER_INO (=11), the
macros may potentially malfunction depending on the environment.

Fix these issues by checking the lower bound of "nilfs->ns_first_ino"
and by preventing bit shifts equal to or greater than the
NILFS_USER_INO constant in the inode number test macros.

Also, change the type of "ns_first_ino" from signed integer to
unsigned integer to avoid the need for type casting in comparisons
such as the lower bound check introduced this time.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/nilfs.h     | 5 +++--
 fs/nilfs2/the_nilfs.c | 6 ++++++
 fs/nilfs2/the_nilfs.h | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 728e90be3570..7e39e277c77f 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -116,9 +116,10 @@ enum {
 #define NILFS_FIRST_INO(sb) (((struct the_nilfs *)sb->s_fs_info)->ns_first_ino)
 
 #define NILFS_MDT_INODE(sb, ino) \
-	((ino) < NILFS_FIRST_INO(sb) && (NILFS_MDT_INO_BITS & BIT(ino)))
+	((ino) < NILFS_USER_INO && (NILFS_MDT_INO_BITS & BIT(ino)))
 #define NILFS_VALID_INODE(sb, ino) \
-	((ino) >= NILFS_FIRST_INO(sb) || (NILFS_SYS_INO_BITS & BIT(ino)))
+	((ino) >= NILFS_FIRST_INO(sb) ||				\
+	 ((ino) < NILFS_USER_INO && (NILFS_SYS_INO_BITS & BIT(ino))))
 
 /**
  * struct nilfs_transaction_info: context information for synchronization
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index f41d7b6d432c..e44dde57ab65 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -452,6 +452,12 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 	}
 
 	nilfs->ns_first_ino = le32_to_cpu(sbp->s_first_ino);
+	if (nilfs->ns_first_ino < NILFS_USER_INO) {
+		nilfs_err(nilfs->ns_sb,
+			  "too small lower limit for non-reserved inode numbers: %u",
+			  nilfs->ns_first_ino);
+		return -EINVAL;
+	}
 
 	nilfs->ns_blocks_per_segment = le32_to_cpu(sbp->s_blocks_per_segment);
 	if (nilfs->ns_blocks_per_segment < NILFS_SEG_MIN_BLOCKS) {
diff --git a/fs/nilfs2/the_nilfs.h b/fs/nilfs2/the_nilfs.h
index 85da0629415d..1e829ed7b0ef 100644
--- a/fs/nilfs2/the_nilfs.h
+++ b/fs/nilfs2/the_nilfs.h
@@ -182,7 +182,7 @@ struct the_nilfs {
 	unsigned long		ns_nrsvsegs;
 	unsigned long		ns_first_data_block;
 	int			ns_inode_size;
-	int			ns_first_ino;
+	unsigned int		ns_first_ino;
 	u32			ns_crc_seed;
 
 	/* /sys/fs/<nilfs>/<device> */
-- 
2.34.1


