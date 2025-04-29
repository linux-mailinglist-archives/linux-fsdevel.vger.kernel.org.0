Return-Path: <linux-fsdevel+bounces-47599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6690BAA0DA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 15:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE8E3AA478
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C3C2D029B;
	Tue, 29 Apr 2025 13:43:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA0218ABD;
	Tue, 29 Apr 2025 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934188; cv=none; b=u93Bu2HsIqvElTkRBpzDa/dV7Yn9Z1DJ5LEwVr9Bmqo7y+rsFFxItroe4LYNu1qx5TP4020/cx0H/7pTucSE6AuEzlsJcXghT7TnzGK0iY3nB2J5N2I2+NEFWsDMDZT5xSTCmZ3wpLDvT0QyGFHrGQNsATkuuBPvq6FzcYPb1YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934188; c=relaxed/simple;
	bh=Vx+bHAFekPXfETD9fq70pqDMxN6RbR5TAqSYQi+2Gtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FnOA6DJ4dyeG2xUkzRPE0CJpi96gcUjpuB8P9Td5eSsa9hWhNKQUDSLVXDD2YyaUWI9nTvBu1aWByMlqxts91qj66sjUH54Iun2XrQGVvxEB6q7yJ58s8m7lIPAKEtx+N2xkZW7kRHv+OIosvpNCAH5NFEImDj6v4ludA8Gohy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf848528aso43240845e9.2;
        Tue, 29 Apr 2025 06:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934184; x=1746538984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3HYGQoa2zNu9TAqoGEmSFG4Pv03gni7UfWB5sdbBAU=;
        b=QD1IhVUppSTotJwlXU4SokD5MJiAbb8V/Z6d/78F5s/bZ/U6GoezR3U+Hxw6E9xgu8
         XPQB5DyWOHcOgOH23zWgg5Bevvg+tgqQK3/kCbEVg4QlGD16Y6xAuwrQRrnnY3JnlQ29
         DJfcBNkKHa3izAqvRRQguVRrmOhHWErbGHIvGngaiT7+xtvlixSAUfrE7HFg/Q27vg4f
         9dlmKayDPP7htcF+8xnlKAHjExeAOCRGXhCgKDrCXcOEux/p10hBMo2VkDuQdm2rWmU3
         JZ4UL2uPN+tQmUu0ORmAyX69/rH7Q7aFUANuq5PpAiI1SLvID3jCZDlEVUJdOMwxwhZn
         gy+A==
X-Gm-Message-State: AOJu0Yy/hYzdT3oE+leMFPZ3V+mtWdpJKhc+9/ftTs3LZCWBjFgGSZxe
	tNzNzeQrczjAE+RClRFOPVBzpcINW9JqA+6Mkwa7AtMAmwB/N/Hf8BWrYA==
X-Gm-Gg: ASbGnct5ihxbynPvoLJCr9VR+4nD4ybTrnfAFkqncybbndcKHM+u5jOUrShpfyv9o/7
	VloqNPDFnIpQZf3VSHg9hMV8Ot0zL90PBcFRPu4i/0fAudTa8WzFRYpVoenAMlu5kimIUNbN2F+
	5tSfje4Mt4PpmN4RL3dJ2yklDf4zfONSAtCiynsPSKysEFDmnzN9sYJxzd6s5S+6Qfnkb+beMkm
	LD6B/R7zx8Eu2erF/3q2Tx3O5GF+3Nt1Y34GbGpX3qBVtSIgtoZ4MVLr0P5CUkBNh4iA+LQgDT3
	L/9x2bS9XcZQea08kyvAvPoPduNa5eahLux4iGntq6GLjMpWE07mHtfBjBA96N3cDAr+KdJdd79
	YW3ZISKU2Oj7uwlow7Aov+fdPiDi8QofIpw==
X-Google-Smtp-Source: AGHT+IG+E02YDGlPfIKtmJhmx+M82MgB5nZwuA2e2fPiATl9VAv4dxXeMZl5jOtmc2LOxP9zm4GpSA==
X-Received: by 2002:a05:600c:a44:b0:43d:1824:aadc with SMTP id 5b1f17b1804b1-441ad4fee66mr22871575e9.29.1745934183531;
        Tue, 29 Apr 2025 06:43:03 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f721c200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:c200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441af9c8769sm11156705e9.16.2025.04.29.06.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:43:03 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] zonefs: use ZONEFS_SUPER_SIZE instead of PAGE_SIZE
Date: Tue, 29 Apr 2025 15:42:53 +0200
Message-ID: <c14f62628e0417498ace0caaa1f4fef2cb0f8477.1745934166.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Use ZONEFS_SUPER_SIZE constant instead of PAGE_SIZE allocating memory for
reading the super block in zonefs_read_super().

While PAGE_SIZE technically isn't incorrect as Linux doesn't support pages
smaller than 4k ZONEFS_SUPER_SIZE is semantically more correct.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
This patch is based on top of Christoph's series titled "add more bio
helper" specifically on top of "[PATCH 16/17] zonefs: use bdev_rw_virt in
zonefs_read_super"
---
 fs/zonefs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index d165eb979f21..4dc7f967c861 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1113,11 +1113,12 @@ static int zonefs_read_super(struct super_block *sb)
 	u32 crc, stored_crc;
 	int ret;
 
-	super = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	super = kmalloc(ZONEFS_SUPER_SIZE, GFP_KERNEL);
 	if (!super)
 		return -ENOMEM;
 
-	ret = bdev_rw_virt(sb->s_bdev, 0, super, PAGE_SIZE, REQ_OP_READ);
+	ret = bdev_rw_virt(sb->s_bdev, 0, super, ZONEFS_SUPER_SIZE,
+			   REQ_OP_READ);
 	if (ret)
 		goto free_super;
 
-- 
2.43.0


