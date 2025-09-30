Return-Path: <linux-fsdevel+bounces-63131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8A2BAECDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 01:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9546C1943086
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 23:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8220F2D2495;
	Tue, 30 Sep 2025 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGQYkKoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1C62EAE3
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276401; cv=none; b=ScMCCGjMXduf6WzyV4NR0v3SRjd88O56M1adOqcmoYaQ5YpIW1V06Xlvo8Lut5J4s0UIPSZj6wWP5cc0E6XdFswIoH77T2SRpt0U5FDVCOb5SNsHPBi4kdOIhhO/ExuaV0/tpbXfdoMzj0+KbQQJu2okYyqxyBT8QMbeMUy13qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276401; c=relaxed/simple;
	bh=fnzDnGDIEr/7xnTBEXTbXV/eznz5SUL2gZTYfAtL/GU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5Yq6EjVSbiN18X9OYtKG0zR1Y9lRBkPVOGemiFIA3y1eA/rBCiFMbwWDaHDsxQ0Qntk4mJLsxXSj7qNSBMvtTOyOuGKwKs7P5+bPSqS7rS7/tP08pXbhscnlz9ZPal5YPzfa4GXdY1fyRwuI79pObsVeHj8yj98ICK+TXC4TR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGQYkKoC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so65502005e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 16:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759276398; x=1759881198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WgLRO9js12XB310Ohs2cmlzDOh4o1hts+MVrdeihU4o=;
        b=EGQYkKoCZE+X0yGP8xj7iqgpCf+XXWY+MDkKgfcGXC6rmfPiqdTG3Lz40foCCRqcVN
         OX33R8p2sVHIeD0g5SnDJOFt2XZvsRQTjdxKwG+nuMaUVlO15JgVuz8qJbRK9aoTe4ye
         1OBCAbd1CQc/XfcqD30Awj8326ZMSxYB6OTzdI7iAy/A7BltyicWgncrTuof4/odQQmB
         DEZIMyuxltc6mLC1BdchjdaH0CAkxYTAcpl2IyBpmN5HR7+SpC0cLthRMq1tL0Pf07xU
         030+Xb/dKeofH/AuGeNs/AQysrzpKVcHD7mxfnN9iGtxL6SUnjtKWN7Zh23fOKgVURFv
         Ppow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759276398; x=1759881198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgLRO9js12XB310Ohs2cmlzDOh4o1hts+MVrdeihU4o=;
        b=oD3nntEoo3LVfQhY5VV1ggjyTI7sQIpSmKXf+0YAWvNkc1eIe6wlNMiHl45z34KWGW
         c0Jo7DLRo1pmatmc+rdIVqLRlPSc82BQc7Uh9MHr6Stl2fjMHbzf2FM83ByvvtjmUH07
         MDcQdfuYBbNyWWAl4wDRROf0x9Rminuo0a40tGJcTpWKgAjVmcwwSifmRnoAr2CgWx4G
         6VaU+W80brUjsPU6RVZG2vVh+nI7tyMlof2EobnoFo54ebd9J32edZWsMLcv2mqqdNni
         QpJ986viiu+ISQSniTEnW4Mtg8HQRQm3fLDbgnrtcn5Ae9OFFcDHTrTmcEWkWyZPpRuO
         ddSA==
X-Forwarded-Encrypted: i=1; AJvYcCWNTjVj2luJ8ZukGDWSeDOeL6RNPLOODz1kcC7iYNAU9+mFyFf1aZC0rxTGXkWs5OZGsYMZnQBlx0IwIVpg@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpXxvjWDSpmzhTxFqQGNvPcBCzmbytpSomTtMEl5waSc2x9+9
	yau4NgrQNxPUjFUcqHQFJ1uBT7jAgIIDjX8arcvwwex8FlS/CqJvaxPb
X-Gm-Gg: ASbGnctD3LodwgXxDvHLmOt2Hgie4PtVJFYixoNVoQrRmV57Kuf7qXaly7Pa14FfJwY
	PdbGQrOedo8wLqirMiBDoX+hCuGzRgIdM4BOHivnlGdlGj9nNfyuxYkIzdEfkMJl9Jr/8nSD7BN
	8NsHQBvLLg04Dfj/Zz5aXEFoMdWLaSmmg/NT4K1LXauO/s+Vodo7Sjt2cKREcPEkTjJHr7Ou2yU
	dd1ey2o9odzhBDHsKb6NOYOF9nRVodFgBGA15/NaCTHbpXKyAbR67k7xXpQSi75Qf1Cs5chDaf1
	TyiNMWjLSAEhyrXgIUugxjYb7vTcDIF2WD4WbIqmtTM56VaEvPFcaAJxtILGp44Jsv4liJntsRV
	D8Yw0RxCGHmj1RZLKUm/PC+yxVLbLVuyojbORjHpmpDwkXW+P/XPe5qJHaux8Wm9geuGd0sPPl1
	wPiHPHfzoTxhUckCKFYVZWnA==
X-Google-Smtp-Source: AGHT+IF9DcVEOSJoK4GyZ0bNGFNGz4ZtdCDXCKLDDmF3uZLhdPpyHjUsCyZasbXoPEK+ArB85uSZUg==
X-Received: by 2002:a05:600c:6306:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-46e612e54acmr10245825e9.34.1759276398455;
        Tue, 30 Sep 2025 16:53:18 -0700 (PDT)
Received: from f.. (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a020a3sm12744365e9.10.2025.09.30.16.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 16:53:17 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: assert ->i_lock held in __iget()
Date: Wed,  1 Oct 2025 01:53:14 +0200
Message-ID: <20250930235314.88372-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also remove the now redundant comment.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

verified this booted with ext4 on root, no splats

 include/linux/fs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9e9d7c757efe..4c773c4ee7aa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3368,11 +3368,9 @@ static inline bool is_zero_ino(ino_t ino)
 	return (u32)ino == 0;
 }
 
-/*
- * inode->i_lock must be held
- */
 static inline void __iget(struct inode *inode)
 {
+	lockdep_assert_held(&inode->i_lock);
 	atomic_inc(&inode->i_count);
 }
 
-- 
2.34.1


