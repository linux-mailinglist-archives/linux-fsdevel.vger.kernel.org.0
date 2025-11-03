Return-Path: <linux-fsdevel+bounces-66832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61401C2D2C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 17:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73C354E4C41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 16:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA063191A9;
	Mon,  3 Nov 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9Xh9GEq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE743191BE
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187844; cv=none; b=NBD5S4A1IYkeUyhGr1xQuHt8WK5tw2OQoT+oCG1R3gK3eIqIJQ/kd3cwH7oeEAK577rMv9UyEwvZk3yUVr7jENF6gSM1Kg8dJjI02jgulgoG1XB6X74zRYtsaHwoXSVxvW4LrLAJ5itGF69yj4pspCbQbAFYzAgR4g1k6ayzO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187844; c=relaxed/simple;
	bh=wJjmntvfExnlICRxK102abAFvivMt90fKAxX98hdlYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uqft9bALyHfhnM29n405HFdT5JlavQUR7DIhkjYxjbQlGunWTW/WH8tmCHIkYQIyLz6Ukiw0LICIQFlnbwPB2IzQnpv4y6L4JCowOYNKxbouc+o79VOoVbUnyDwMatZzzhzz4HeHWVgYNzZPPJwOctkS811ci5OfLIPn9RZWLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9Xh9GEq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso1268688b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762187842; x=1762792642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqJ5gNa1nUUGBUXHUrJf6QlrVR0rCRb3Pp7Ymbcprkc=;
        b=V9Xh9GEqqakLENJv++F44TPZ6hs4GdYcXT+kdy11SDPwcY5sh8xJLitGOpmCtW8JDr
         XgXLIGp9vDzDFUwwTpZ9lesxspeUbb4xtz7rQpOA3E8Hb53ijuSEmtzUL1WUMVf7nvXI
         cznb0gCHxb98GYaWQWVdF7b7stGWR9ZMa6CJTApPDpqC5kwUbF3wSz3xWKr84P2sWdS5
         9wWbQY6Wzd5q10MATigfea4EHH70mPWtlC82+ik/TUhToHOdX1ljggAyq78S+lfxwnTW
         QTGRgKHCXEcW1V2kj4LgfIbUb683rfXk+oV1lKY/7kDkjnxRBKucT27jSsbvhxD62gsW
         IAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187842; x=1762792642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqJ5gNa1nUUGBUXHUrJf6QlrVR0rCRb3Pp7Ymbcprkc=;
        b=psrdXNfRhKsKgchCzKzdet2y9Qa9s64r09xrs/vfGcO8WVu7R1m6iBqhtN2x/HhhBv
         uc6D4m8a1xNmleECVePNS9hDR5Rb3PGzz/Ktr2uuWY8unTG9STvcXJbOxXBjutA1WMiF
         Ap0R7axaBnR9jjXNGL4eRWXL6EtHRL4GhCuPgSL/VXtnL6q2Fbd+1o5uBHW4UT6Pn8Bo
         Uf8JLM1erNbFFRjpE2MWRCIETjaM7sGdaUYqNhoI8taQ82M+Oj5AG/0j62TTovSm/1Uf
         d3+sBLmgtpqHpW70yvfFdBmCipVyjU2U+6W6GppePEZK1QvHi0olNT9xYGan88xW5XE6
         KFlw==
X-Forwarded-Encrypted: i=1; AJvYcCU18QM2Pi1elrJduuqViyOVXPOClR/PY4xFg0pOuy58M4haie+FeDMwRlvDmOdWZysAoEO+NUN048AgV2VI@vger.kernel.org
X-Gm-Message-State: AOJu0YxyXNOjaRTB5NYIwKzl08nObWrSeGwYmlYn7KfxoqMmTYyiJ6G9
	x2CdMBPsVTI1PlYbK4H4WusnWtz04nMsnsXbVf/xuwGuiAurE3CGC1hR
X-Gm-Gg: ASbGncsGxhRSj3nMYs1asm1QSyLTuyS0SkM1C8CmT7QmpBN5wMSPsiPD6PtvY7ecrlz
	VIgX5VnLG86M1fjyPXhn93mb349QIE7yZIlC4Z0gZr3GA0eY4knk0KVTOIu9jAjy2UCsxivLz5n
	P5uIql04tDhHidC4nduOvAs1QvxHbWvK/ffRztFwXPAitwrwnRTHpQ8KO22egVzM4Spcnh+7URV
	TOf9mUEFsOZH11COagRmglXeLAMV94NvlEQ0iMxNMpn9PKTXQZQLj8igDPQYlaCLeuxqFyWj5bD
	WbTGRHrCrr89jzoaWWjq3ULvyT/azI47bw/Ryjdk8vUAqB/z9bkJ9fKOgo0HEOapeZfnTQ+hAjm
	VpBr//D5MtUvr7VdfwqLbPkFsrvPyU/haZropOenipa7BWIAtTeDLd1k0TeXxvqAF3fbX9qOJlg
	Way8NzPoohRCpzBTHGX6MU/uor8Xw=
X-Google-Smtp-Source: AGHT+IG+w7iJAzmb9LjCnbErWEAX7LNvJkcpla1jAFDM+Y4gmMZZU0oJMClikIddg63gu998oSNJwA==
X-Received: by 2002:a05:6a20:939f:b0:246:d43a:3856 with SMTP id adf61e73a8af0-348ca565705mr15735758637.22.1762187841867;
        Mon, 03 Nov 2025 08:37:21 -0800 (PST)
Received: from monty-pavel.. ([120.245.115.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ec24330sm6853704a91.2.2025.11.03.08.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:37:21 -0800 (PST)
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
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: [PATCH v4 2/5] exfat: check return value of sb_min_blocksize in exfat_read_boot_sector
Date: Tue,  4 Nov 2025 00:36:15 +0800
Message-ID: <20251103163617.151045-3-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
References: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
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


