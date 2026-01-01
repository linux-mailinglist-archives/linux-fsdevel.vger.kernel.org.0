Return-Path: <linux-fsdevel+bounces-72303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B61B0CECFAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 12:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D709300A1CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 11:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE12D288C08;
	Thu,  1 Jan 2026 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2VK2Bnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70E32522BA
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jan 2026 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767265935; cv=none; b=FGKLdLsbTIoVBlyZsUjWMgdsA7XCsz2LpVDjdUiWiKUo5pwe+cuB3jM/wdakbeslpDsyRlA1nPoq+seIMyAM5wJb6c33waXnZ/j/HMSuGPdN97bJK5hqgbGlDJtxtin41O98dwQYCmml5bKWDS/vjunBtOx22GQ07kosOHSFZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767265935; c=relaxed/simple;
	bh=R1MOVECXK3sqsMn+Mx9E14uA8RiLKnycrhsD20xCPTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J59AEoUI4ufBi9a91KRyXe2l0pzUcSduOg49yldfLU5dE5ojWhCb7WmWCyejGUudt0FVBTcIoq1OshnNFDrYstH3mBe43d3aeZFDzb3DOKM9ffC8/qcuN2u4QLdtiHBYWHh7tiS4f2f0Y7CruuEIA2KJxxxRsl56g4uZOqIVC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2VK2Bnh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c2f335681so8546256a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jan 2026 03:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767265933; x=1767870733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uj1TWbqZEVpCJMC53klX2kUfu7ywMyphYkzhWZw10pc=;
        b=E2VK2BnhLTby6QB3Je2S5rKvOAd9QEopqBNdrtHT5jsTtbfxGE4CvGtbI+TwoebySx
         S7AxFASGh2yBdRAKJP+oLU5zw/LxM9tstzbBfoeCIt6nUZoPI5f/V3/U/3GHpSyawxEv
         BpVBwpfWU63hZEPzuM37u3YY2anHBk3lpoDJmHEPzzD/w4Z9mz+aFrBbtDuLdpRU2GQc
         +o4DAhKLXTf3R2jMJQgcCu0DnX9F+RNnFTuGZzYnTcAa6yHvifh3annN+ZwrgFreOG0V
         Go2Upc8O5H83ni2wKHxQOkyRWb1ZlwvIlflHoaoCbDRbwMkQnAA9hmEzVB+Ic3mAJ8W8
         wKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767265933; x=1767870733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uj1TWbqZEVpCJMC53klX2kUfu7ywMyphYkzhWZw10pc=;
        b=rldO76BfWx9ikT3Dqs/Xgqd5boK2k11CazwW+KO3CgO5sEQhQe+HvK5z3tzMvyXIoA
         yy5n/31/M1m5mXjhgECqyYzsQJ3djxJXZ+juuaNzAlFI+D/bW9wsrVnspEImsX69ii2j
         ZI06dtPPqYZ2wuOxuUJRZ+2VwZvNmJB6Hqghxwa1iu26S+k/fIbU7eT6EfAt+bMbKlmK
         taUDOsEu9oLik6U4dl9/A5vrsnEtULCf6BvEykA/FRAi5l9qsK3+vST5gt4DyPZe4+y2
         wog89Bs3/ev0QDivHnzdJuqwyd8x5B1PnXywMgWPefzkkcS0jmIMY9H7K2CRd5hS3Uw8
         nSFQ==
X-Gm-Message-State: AOJu0YyJbJILsK1rLYId1Xfk3ACouXL4f9g6+9v+pZ9sDYRYTj51uwMy
	M3sS0iXDiXZFZooro5+cAbC94gIGLxUEc1VRpbR4QcF5+NNgnDShWQl3
X-Gm-Gg: AY/fxX4X1GETjvIRzgWBQ/4jjxwMDlVQLDwaNJP9g1U61RF/zdb7LrLxruO72Kd78BL
	W9Oor9Ym8uhTedNHv2525P2eCAqNXkkKMdKcvRVM1Wv4wKuV3DmggOQ6IYv6yA3XUZZVrddg2BD
	z/xMPvkc0vFGhp10NVM3Y3dyy/g38UcK4gTwOcoGDdqKZDfqEaSnB6HqhPOhQyXnKdHxpmh24nW
	Xit1c2d5IWhQvgU3SLtBCcKxpNozgUs2ZPs+VP329oB7uE78UtK/WKr0MjAf/Xppz1Z3N4WA6HT
	5FZ/cdgvl3OvmSEYUNxpZwEr4u25quSriIY4AyV8Vhpz/EYCoBzDQSSmEMgPeHsRWsyH04ele7l
	ZrTsYarVqaAff8jahKHFysObYUKYJ2j8+ybqQyXxaE757mgJ12nxkmG8cKq/Ld4tcr8Qlw4sW57
	CzPN45eUe9WSuImeMHeBPDHZGdzA6DVbEVbM52whrqxF5LyopHT0X1lwib6vkdn6LS5w==
X-Google-Smtp-Source: AGHT+IF0O7FTZv5t+moL2f3nVBNSmH+XjOdX+4LYTLzJeCO7v9W9CgwezVB8jY//JEZqeqOo/1kYpQ==
X-Received: by 2002:a17:90b:4b43:b0:340:e8e9:cc76 with SMTP id 98e67ed59e1d1-34e92144873mr33965006a91.11.1767265932428;
        Thu, 01 Jan 2026 03:12:12 -0800 (PST)
Received: from localhost.localdomain ([159.226.94.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e76de1c3csm19632961a91.2.2026.01.01.03.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 03:12:12 -0800 (PST)
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
To: hirofumi@mail.parknet.co.jp,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhiyu Zhang <zhiyuzhang999@gmail.com>
Subject: [PATCH] fat: avoid parent link count underflow in rmdir
Date: Thu,  1 Jan 2026 19:11:48 +0800
Message-Id: <20260101111148.1437-1-zhiyuzhang999@gmail.com>
X-Mailer: git-send-email 2.39.1.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrupted FAT images can leave a directory inode with an incorrect
i_nlink (e.g. 2 even though subdirectories exist). rmdir then
unconditionally calls drop_nlink(dir) and can drive i_nlink to 0,
triggering the WARN_ON in drop_nlink().

Add a sanity check in vfat_rmdir() and msdos_rmdir(): only drop the
parent link count when it is at least 3, otherwise report a filesystem
error.

Fixes: 9a53c3a783c2 ("[PATCH] r/o bind mounts: unlink: monitor i_nlink")
Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Closes: https://lore.kernel.org/linux-fsdevel/aVN06OKsKxZe6-Kv@casper.infradead.org/T/#t
Tested-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
---
 fs/fat/namei_msdos.c | 7 ++++++-
 fs/fat/namei_vfat.c  | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 0b920ee40a7f..262ec1b790b5 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -325,7 +325,12 @@ static int msdos_rmdir(struct inode *dir, struct dentry *dentry)
 	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
 	if (err)
 		goto out;
-	drop_nlink(dir);
+	if (dir->i_nlink >= 3)
+		drop_nlink(dir);
+	else {
+		fat_fs_error(sb, "parent dir link count too low (%u)",
+			dir->i_nlink);
+	}
 
 	clear_nlink(inode);
 	fat_truncate_time(inode, NULL, S_CTIME);
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 5dbc4cbb8fce..47ff083cfc7e 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -803,7 +803,12 @@ static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
 	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
 	if (err)
 		goto out;
-	drop_nlink(dir);
+	if (dir->i_nlink >= 3)
+		drop_nlink(dir);
+	else {
+		fat_fs_error(sb, "parent dir link count too low (%u)",
+			dir->i_nlink);
+	}
 
 	clear_nlink(inode);
 	fat_truncate_time(inode, NULL, S_ATIME|S_MTIME);
-- 
2.34.1


