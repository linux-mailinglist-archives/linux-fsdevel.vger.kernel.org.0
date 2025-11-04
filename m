Return-Path: <linux-fsdevel+bounces-66950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23626C310EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9937B422084
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F602EC0B7;
	Tue,  4 Nov 2025 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IonmIC4L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57BF2E092D
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260655; cv=none; b=g2XThKtDoGSJhxqE+BCG4PjdlG3aM8FFufRUBqiBhdwjAVUKCde87Lob8VB/zvYeQZ8BotOIrIvYR7fgWFXaayKE8OD5YLdttZ7olm1S8QMlg7vuI4DO8EMpI0hvwevGj5ZuVabO+UKoC91iCHL84EHeAx5n4sRAyiIPQTbqvwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260655; c=relaxed/simple;
	bh=WmtRZhDWkgJIzqTmohBXn31bc3c2KAlmHgsg5WATPKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ld1p1Z/vahUZWlRlrK7ewz3DMiFD1lFGWoJESMavT7dkiFDoIBcAcY2vMOGdJRg8EXtQ/HiVpQ8PJP5MnTW28j2dgseNKUeS+qabbJ+dvT0QI4BgaqDfx4BqE1q0aW52lCfu3DNAwzmncsMoHuYhRaqyZ2IfRU3eoV8SRKdHaJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IonmIC4L; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781206cce18so5848082b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 04:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260653; x=1762865453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENGYR35a4dVgm7srDfRUWeoMwLvmN51DMzCkTe+nydE=;
        b=IonmIC4LhN1XzPTkIv8HigOViYXPokTfsztF7j9wSpyOwjWz3r9up6tbmwkDz+ddq/
         MyUVPriJjEjAkPOBz/7nwAPHo4QTJcburF0aBIGHXEv0cjF+769y4DplVvCyBbjC8SSJ
         SSvvhbPEtpGWiuP5uFNSHsBha/nS/Sio/DF3b49qf50jhaih6OJRZZBF5DiHzeQrV+VW
         Vg9hqiJuYJfnKoXyWuudeFXrXq6utP50pFtXlfYM286upkugh6X1OM26ITR6jKZfsEQK
         daj+CBBaP0u3gJO3oGGyqlJTTF5xSd3m1jUQ0usAB8kKDRYhrqx9rTeOmvzOPr+HtVgc
         2UtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260653; x=1762865453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENGYR35a4dVgm7srDfRUWeoMwLvmN51DMzCkTe+nydE=;
        b=GhNdNrpfYXPCOfFT6dv7PVyvCIvZ8hCXqVqp0LtlGP7w8RNJsWQILZrwDHNfEixoCt
         juijncy86d1nAZgwCzEcFgmY4B7nkkAT1Hyw/sO1bHEktxrALnUYJvHu7dqEq/E/JYLy
         EMPcK0w/yELT8MkgHczqrqLFX78xDPME4g6Ri7MWdx9ANJEHIVBno8VR8C4ShLVUOFXo
         /44Ppff9CYGGyIvF1qh1VVNqIAnEXqcwV2m0BuxQfCvDNGWpFjwAfd4gjWYmRJxo7u0Y
         Yv+YZ4RtxTsPjRrnp0iB0UYw62kbnGuAL4IZFS0Poe6jsRlrtAM8TOO9l3qmy0D6rRt0
         OP0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0Ad3E5R8PMuETbD7fgDgvIAq7PpJiH0cn1+oo0Dw/QmBEV8FoJ5F+13Toi8124K/JVp4vz2x3PUpFLXel@vger.kernel.org
X-Gm-Message-State: AOJu0YyzmEGvMfFmsxBdKQWZhnZHU1bVtYJvGdm+v1RCzp63iosC/66b
	3lh5Hz8cePb7CoE/l7zjHOXkiosaDvz1vGfQpfPwhM67835dg6/IqrBJ
X-Gm-Gg: ASbGncuYrgONwRlp2SGvgsJOBkq3nPp+QrMS1qquJNZEqvPqeT/YY8bBX5M4iNXEYne
	geUX1y5Kvg9fBHoVPKvelxnFSJV6Q/SyJp05tTadZTELi3TbGylt5E+oRYjUVvezNrxEYm/k2/D
	8FhsdOT/szJ2v7QcEinRRkqA55xoQtLGJBbrQPsO8wjb1iCRe0weKQ3VVeuwvNImDM1zvA/ehHu
	gyOuZV0ZbrvxZHr8JRngonI1JlKvyQntyN6cRpm9AXW8QgUtMOA0ehvXV9I0FuGE8F+NhHLBtkI
	03w1he+sq3HOS6GinkkIbS8tAnGFPh1bCtbjZSp6MY1LYhfsnOS8jI0WdRuspGzQU2s8bixaqjU
	Zi27tHY/+Xkzux0TqKGYn2EP0LEisbcCJCfLoQIDqeTQKpCh+Yv0sfFzkVjSZfrllD4nlG8k8d7
	3t3EBKU3xjGuce6gEAa0wn/7mX9gkSHZTqCVGUMqi/L3DFWP4=
X-Google-Smtp-Source: AGHT+IF9GGj6LSoxr/C7fblJY9vEfziJTCbSQQeza2nw0zDMlzuQfM4TKJWECjNFJLSbFRIBSCyjKA==
X-Received: by 2002:a05:6a00:4188:b0:7ad:8299:6155 with SMTP id d2e1a72fcca58-7ad82997336mr1106651b3a.2.1762260652783;
        Tue, 04 Nov 2025 04:50:52 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6d026dcsm2860710b3a.70.2025.11.04.04.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:50:52 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 2/5] exfat: check return value of sb_min_blocksize in exfat_read_boot_sector
Date: Tue,  4 Nov 2025 20:50:07 +0800
Message-ID: <20251104125009.2111925-3-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
References: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

sb_min_blocksize() may return 0. Check its return value to avoid
accessing the filesystem super block when sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: 719c1e1829166d ("exfat: add super block operations")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/exfat/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 7f9592856bf7..74d451f732c7 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -433,7 +433,10 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
 	/* set block size to read super block */
-	sb_min_blocksize(sb, 512);
+	if (!sb_min_blocksize(sb, 512)) {
+		exfat_err(sb, "unable to set blocksize");
+		return -EINVAL;
+	}
 
 	/* read boot sector */
 	sbi->boot_bh = sb_bread(sb, 0);
-- 
2.43.0


