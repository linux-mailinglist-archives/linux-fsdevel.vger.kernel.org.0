Return-Path: <linux-fsdevel+bounces-48522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B86CAB04FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1F51BC79BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7C2221285;
	Thu,  8 May 2025 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDkTCrfe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708B212B02;
	Thu,  8 May 2025 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746737485; cv=none; b=LzUHCtKGQnC91ZxRZaSFkDVZI1O0ctKNuolpudjfnNPUEii7vB3H88A2aNX80Ddwsfs4nO9IA1aY2iGCEPfDQCBmGqHgmf2cMimrExkR2YM3w0MAvcivQV8VwrQGDe3DoRibXbP77q8/jOdP+kQ/7QzAgaQ6jyuAyP+7x5LOM5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746737485; c=relaxed/simple;
	bh=Ny0ZZhMS+5P8yPln5Dq/snA6ohaeYdu/uVcZZbdLv/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKTLXHAq1Y4fQ3YmlRzGAf705Hd8vzE+wqV4yHOR1ahlINOXeKhPmSX4/KV7KzDUW6CobwBETI0d5Eg7XydEAVAbQq2mJMZF8OQojhNmS2s6Rs31kaKepTvX8dSUrX/HY7EElCgBuK+JWhGZKRb+JdTnuRS2mUqGAZoJd3ae5Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDkTCrfe; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736c277331eso2373612b3a.1;
        Thu, 08 May 2025 13:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746737482; x=1747342282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTW1EQI+W2Yod2KIAb61diUo3qzGFGH+XuXQV642XOI=;
        b=KDkTCrfe4dp7c3lKUw8+h77Z28iPqwO6TAqJ3BTd1ZcxNMx0akl6Pp/jiYxbxmIVnq
         GJo5J+teikL03MYgtoS6kQFw2R3kGQAOhfJBSULvlRfFeUiSU26if4+LtsxqgXdixyG9
         wj0Ro8OmaQHoM9bJpkCYHb3taL+ZleCWTKas+TBAh9bMTlp+lIStCHfPNfq+7tzwZH3L
         2Za4BgkkH7VYS036wCsqPGz1yVIGCkAY6tgQ/MMcHEhdLoOMbEHLQtaEhM7RnNocXkAO
         JRDIZotmc8R7St9S+HdwLUWZSc9bG2nDq29Yn2vpOG9vgur8b4qGqaFS8pfmZM0RPsM8
         UOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746737482; x=1747342282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTW1EQI+W2Yod2KIAb61diUo3qzGFGH+XuXQV642XOI=;
        b=L8UXoWUmQ+Gpo4zlgHqy36KXzV2B+uwgzEpoj4sUnSDEi8DxkhINL0aWmSpRlQ8Lfs
         49k5JOF1G6e51tME1kWch/Fc/NiH4jjtnNSU1h/A21DwPaVfsIaZHxv5/cxnUHuW1s7u
         7yYlJYuiO2Pk81DDl4It5gfFu8dAAwt3UQwuLed7oO6fwo8yo6DyIiSkGiiau17kdZ5T
         eDsSR5VI8Xai8YcRqQUBMXRetMMDjulZXiptGs1B6LyvUnGPFH2sn63Z85oer/SMieyS
         eOb7KzJtwUc8n11gOYLjfjs0qUSgaonm6AISy70fs6DLvMwa7bVTln6pMsayM3g+4rVT
         357A==
X-Forwarded-Encrypted: i=1; AJvYcCXSWb71gKO3yy+hH/W8ydVQAwuIW8b1S/tKACFdPl7ZyesdJwqsAtkb00CdjadDYv4MlUzTbg8sPY0Ip/rs@vger.kernel.org
X-Gm-Message-State: AOJu0YzkcrgR1ryty0q8lxA1+7EhtHhoWFHIeqMLwQ95kC1VWNz5cb8M
	9qbzH4/x3FYkPH9jwMjPC7tt6wh08yKJ4C5q2BjObU5CTcdL4jXRJiroSw==
X-Gm-Gg: ASbGncusnKAKLWRgj+7j4mFqlbUkaQVJRfF78TNGaGz2LBFDpGMoDYN6J2W92r0zK1I
	IbZvojnHvSalhoyFsqXJxx4jNZiScgbPW+89nyxo0EKyGOBpbC7pCa03UwyZApu4/KtjGjsI+bP
	xSD/GyCgzvLrI3ZqqV/mCSpIlgxhJMj3cvivq9LkkQ2Oe8012A/pBmIqz7lTmTELK0aS6+2i9dm
	RK88mQ2ljhrLCbUDQQ0YccLgHIz+xqOFDZGMTDwkkFgva0t6nypO7fCOZm1xHMt7K29897h0j9s
	4063aik9oue4hlZ5Cllziorpy/ygNakR/NyVP7MkOU714pY=
X-Google-Smtp-Source: AGHT+IGau5q2vnesh3J9VHqW37kmJAkNm9/uiBaElNILArUNORANjPdFayy5ur3RcpAHqwfheaNXdg==
X-Received: by 2002:a05:6a21:a4c1:b0:1fe:8f7c:c8e with SMTP id adf61e73a8af0-215ab637034mr1047268637.15.1746737482470;
        Thu, 08 May 2025 13:51:22 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a97de2sm463763b3a.175.2025.05.08.13.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 13:51:21 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 6/7] ext4: Enable support for ext4 multi-fsblock atomic write using bigalloc
Date: Fri,  9 May 2025 02:20:36 +0530
Message-ID: <71c65793ebc15d59e8ff4112f47df85f3ed766e3.1746734746.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746734745.git.ritesh.list@gmail.com>
References: <cover.1746734745.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Last couple of patches added the needed support for multi-fsblock atomic
writes using bigalloc. This patch ensures that filesystem advertizes the
needed atomic write unit min and max values for enabling multi-fsblock
atomic write support with bigalloc.

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 181934499624..508ea5cff1c7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4442,12 +4442,12 @@ static int ext4_handle_clustersize(struct super_block *sb)
 /*
  * ext4_atomic_write_init: Initializes filesystem min & max atomic write units.
  * @sb: super block
- * TODO: Later add support for bigalloc
  */
 static void ext4_atomic_write_init(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct block_device *bdev = sb->s_bdev;
+	unsigned int clustersize = sb->s_blocksize;
 
 	if (!bdev_can_atomic_write(bdev))
 		return;
@@ -4455,9 +4455,12 @@ static void ext4_atomic_write_init(struct super_block *sb)
 	if (!ext4_has_feature_extents(sb))
 		return;
 
+	if (ext4_has_feature_bigalloc(sb))
+		clustersize = EXT4_CLUSTER_SIZE(sb);
+
 	sbi->s_awu_min = max(sb->s_blocksize,
 			      bdev_atomic_write_unit_min_bytes(bdev));
-	sbi->s_awu_max = min(sb->s_blocksize,
+	sbi->s_awu_max = min(clustersize,
 			      bdev_atomic_write_unit_max_bytes(bdev));
 	if (sbi->s_awu_min && sbi->s_awu_max &&
 	    sbi->s_awu_min <= sbi->s_awu_max) {
-- 
2.49.0


