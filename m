Return-Path: <linux-fsdevel+bounces-49154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C9BAB89C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 16:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9611BC30B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612811E5B9A;
	Thu, 15 May 2025 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsI+f1b9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B61F9F51;
	Thu, 15 May 2025 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320386; cv=none; b=md8143afktgDuDlgBYK/x3anpme3h3odIHloApAiE9vtiEg6264Uz0so4pHb54/pLzg7qwd/VcWl/j/naBwpGUNUpquqBNkriK2Ae7rl6g1yb6JLZ9lj6LwrOgaF/YO7pIjL9MdXvM/wlP9CmEbFyjXTgbSx4Re37kWHg511sXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320386; c=relaxed/simple;
	bh=nmenGCViwDNQedi4QWW0KsAQugNDij0PzLrNaLTVPs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7SdX+GdjMhbxc6CVM3BEdFgrJxxCn2lZvxq1mS7ZXkfuJHcYCLnpdSAxcU8RYvfKNIAELRmbGn05sjxPVcaQywKtsVn62LNu1bu6iPdxu42zDjn9EFZ6v7i9evexxlNJyMlhc7xlafq2XqLk1kGF1vcuClFqhGkRzY+3ogPGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsI+f1b9; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-86a07a1acffso71695239f.0;
        Thu, 15 May 2025 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747320384; x=1747925184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eoa/EDSXetTErjGzdHQ9FxdI3yBy7eOq06hWOHLaf0=;
        b=AsI+f1b9YkmYnIs2cL8PF0+m0SeUxauS8cvGFY9nLxWhp2FeqGV48z2/kO88d6wJd9
         ++gXbhmrzU9k8WAFKDYQUdvc06XFMPUtPSy9oDBc/VkDUT1z4QXrCpI6+dg+sDLGGqkm
         PrBgKCGxhj+uUvlCnBS11md75JsbIYD8JBC+jAMU8LnFxNx60Hjg801KI2tR0Pytlk7l
         57vRSPLXiXBDC9Ym2o2PtIuuXgV5rVFcUdsKSoCJMWEiLhju9u2xkyM3jM6yHwAZ0rr6
         AEQdrW6sEyFgp2RtX7X/oWbwSvyEumswWZn8hYPke/SvBrkcY5rFOaxdwO91D2rf+4KY
         p68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747320384; x=1747925184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eoa/EDSXetTErjGzdHQ9FxdI3yBy7eOq06hWOHLaf0=;
        b=hLphIkxf1WQWXZKTDGsbu1QWBvfDvD0r7ZcV5O4pnhpw7zxStm3hMSgaO0l4Pb+BHg
         d5gPzMADsHqN2+9UxgBNJ4bLSMu+Z230lmFsjNQrJH/09b+DyadXHg1FZbZ2jLiv0jpj
         26PaDE0EAvh3IIRQk/Z0GiNVmMZ1ht+qF4rMc5yGDn7Tlg3FLIWaFwY0s9ifhmYyamds
         QW1M31g08O1ZwKgq8V6viqukRDJlQYoCIQQdH/q3BLCwMKQdAebufZJ3TWx7e2dDx3yT
         ElPYv9R6ewVcjJfwVgKVyuqXa0DUnfTcCMLqRHD8sufTkmsXQDVtUWLfW9c77z9JfwYz
         6kAg==
X-Forwarded-Encrypted: i=1; AJvYcCVm+GXk/5SyEn+DQdkgCgnPr9cMxQhDpLRYrqz/2rVsFuFf8HyAElJOZ+Q9PvcXV0lcqfrkAHcLmGum1b1/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10Of/TkwxtO6EVmFkQIgip0iCX2HaCc722rHrdxEIleKhY7CV
	0y4sF9XlPnRQIEAx9IjO+chVhJLmBzZa+sC2VYuDQB7TrmYHQ7CNp6OkmQ==
X-Gm-Gg: ASbGnctswpfveVvFz3HdFHMdl9Pdk6KiB935iUjKNwzZwAbaJG6RxwFVAU5nAzdIlv3
	nTebo9im9KQwVaC8QMbM+rDSHTqTS2FOevbvDZaxYMQX9Y8A23xL5TkhwMq8Q1wZM7bZWsFxTjw
	a08qwmVFV2//aBkkpw4ARKGV/5hRHp+9nTc/71KMaeUKO8IvPY2CUB/nF4aym4F+DngJUAHKEay
	Y/ZEbrgID6K+ky2z0++ESyeMj7catvlO2Xg8nCSt1elGp2deHdg4lguq0p1rQ1fB38Jfqr9Qhgs
	qpMXY0sRFGJx0OSaSEpitS0exfuDFfSEgVmloGnuPRS8Ind0JrScJNNZ
X-Google-Smtp-Source: AGHT+IFPtOGxlTS5igPa5DGoAacWS4+S3fGth709jl+apIlHwB1G3Ajh6QA6s2T9c0YS/iw00VCE3A==
X-Received: by 2002:a05:6a20:4304:b0:215:dbb0:2a85 with SMTP id adf61e73a8af0-215fee362damr10943385637.0.1747320373372;
        Thu, 15 May 2025 07:46:13 -0700 (PDT)
Received: from dw-tp.in.ibm.com ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6e6a5sm3451a12.17.2025.05.15.07.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:46:12 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 6/7] ext4: Enable support for ext4 multi-fsblock atomic write using bigalloc
Date: Thu, 15 May 2025 20:15:38 +0530
Message-ID: <59a68459ff90762db2b440ce2d2e68191324492d.1747289779.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747289779.git.ritesh.list@gmail.com>
References: <cover.1747289779.git.ritesh.list@gmail.com>
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
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 181934499624..c6fdb8950535 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4441,13 +4441,16 @@ static int ext4_handle_clustersize(struct super_block *sb)
 
 /*
  * ext4_atomic_write_init: Initializes filesystem min & max atomic write units.
+ * With non-bigalloc filesystem awu will be based upon filesystem blocksize
+ * & bdev awu units.
+ * With bigalloc it will be based upon bigalloc cluster size & bdev awu units.
  * @sb: super block
- * TODO: Later add support for bigalloc
  */
 static void ext4_atomic_write_init(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct block_device *bdev = sb->s_bdev;
+	unsigned int clustersize = EXT4_CLUSTER_SIZE(sb);
 
 	if (!bdev_can_atomic_write(bdev))
 		return;
@@ -4457,7 +4460,7 @@ static void ext4_atomic_write_init(struct super_block *sb)
 
 	sbi->s_awu_min = max(sb->s_blocksize,
 			      bdev_atomic_write_unit_min_bytes(bdev));
-	sbi->s_awu_max = min(sb->s_blocksize,
+	sbi->s_awu_max = min(clustersize,
 			      bdev_atomic_write_unit_max_bytes(bdev));
 	if (sbi->s_awu_min && sbi->s_awu_max &&
 	    sbi->s_awu_min <= sbi->s_awu_max) {
-- 
2.49.0


