Return-Path: <linux-fsdevel+bounces-66992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF7EC32F86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70A424EC179
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65DB2DF151;
	Tue,  4 Nov 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKwfMo5X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6E6224AE0
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289505; cv=none; b=duD+FlMzqsnFKoXn5+evm5WtFCYjiSfdBw6kO836bKiWgKkf2p/r6w+fqEXTVJ2tLbI1t+SIn/wfeYQZedlnxAfJv3emgRWNLeuw+izBfuSZvE6VkvImc/sXjIa8Fs0i62URFyZR48neq+e3NsvRpJA2n6RdED89KMIpN/PK8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289505; c=relaxed/simple;
	bh=1tKRHUTUF6wSxYYsu+b15+VtGRiAj97di3oIb3RWeXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIvMXgOXbgRuFBbchAj0GetDQGkU7qi3wgfPhHFHDx+J3a6hUqLjraCiOKqhG2ehBPSDJ6sJqgoJU2sssUcCc9nrJmen3knp8WCtMKNLsQiq5oxmakzzf3uPpdNc4aPLWmE1vf485oRcst70YxrETktA15NuzIZnu0MiQDwQ6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKwfMo5X; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29599f08202so35594425ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 12:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762289502; x=1762894302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/8ZWdSRG6okCCiEhYSH2JyKbnPEHg5wn4F5YiXnt4k=;
        b=eKwfMo5XqFlZC/2F/j3HKlqsdfhleefeMb4OallK8SGkc2BE4Vf/4VNxSa3nqlLUyl
         kmMi+VhSAzGUH8MaZ1N3v+T/LV8oZS9Btov6lbYr2642IStS3dDBSbl+9UAdVxF22cDk
         scvla+vcOGj6R/vTDpBxLYd642sn2r/0GVwqHWNOJPsQsKKWhADHukHW6dSGLCze+zWd
         1BVukg23ENGxV/97WrFLxpvfuhD3xrz+M0qo0MOIxf3k2vaaUc0O9S1vmNgTDJYLvj57
         +tDdRDz9kPDQH+z5SL7Fn5v8M03nmYf2vcu8WhY5nzO8X5sg8/DRXaBySMCgXX1ui1QP
         AmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762289502; x=1762894302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/8ZWdSRG6okCCiEhYSH2JyKbnPEHg5wn4F5YiXnt4k=;
        b=xUbZOX3foUGxrNks6x788fWPPtnFr2cqxfQcK1S9Oagc8rhr/Btg3GGkhpDXUwMCkR
         U65vRKM170uDJxXf+OYqGkS/tEjiK7+w+3tAce/Q/udwc1YtsCSpXaCOS2k5PiZQLmgD
         XvR32JXjGhS6CxsMosop8DYFBw9VXfF9WxzX6wCHY+yAt7nUDGYPXfjRU0eU1Pt4VKxV
         l8d/8cWWKJ5b7ChPgok2mcCBETERi01tgeo1tsfugAU2c/QBUE86l9x2k81ogdstqqfD
         qaLosC1PoFJk000xw/7yZ9DNxgYGU1QdJDvfJMjbhteP2XS7AkFLaTWSNlUJC0YHE5Mi
         bC6g==
X-Forwarded-Encrypted: i=1; AJvYcCXf+lKevdKeU+qoN95pYz3UgYI5arI6BCxiB++Bz22FuTqrnZs2cVPwVcxD/lo+QsDseCqgIbiI8eNA5J+F@vger.kernel.org
X-Gm-Message-State: AOJu0Yxls/XJwu9fTZUwTN3J5mF0T3qwC9yKOy7gZLHVpnZfZbnk31SC
	Xfyiiv4DslIZzYaY76luVKs3/lk54Gn2TQguymfVg2DTNIfDUDiiPk6E
X-Gm-Gg: ASbGncuaE4ZChmlBeImTw94vLP+ldQDXOLaZPo0IBlhP50Soy2E6/S4J2XrJ/zclzd5
	fNuVokdsoGT1qGQUe1RNGRz6KgBV68faV2QNhyoUMSgxcRsYmu49Gm98kEDTCHrlTFErnynBDbr
	Trq8PoqEqrya1a6tGkrOPJS/hsVS8xWQrw3jUSs+w49SgH8H6PWDTxzVITJGFFz3gNtWwFVXy6a
	P8eMXh0sWUdAjRJX4+QUJkq5wDbLiRwTje8zyShQqZZoQtBuORBAfvd7Bb9XK+yFzEm2fqMsoO9
	ZrNKPnuKffZ1XStpfSnhx3YY5gFWBWXoHAR48z5M8cp7vM/XZxV9Et6bEShPidHLlQt7hyVI0/U
	zuNyeNIq3VRR+nE6C1ooZXVqClB2BpeykI4id7JaMjmJRh37p6mQKX2ZnPRBuZSOLLOz5UK1TEF
	KegydUhoz0AZbO8cIzsLVjR973qEo=
X-Google-Smtp-Source: AGHT+IGtTNtLXtct3j/pQ0OndC0vWJq6wVhv0H5+z9/efExsqa0iGjKMd1nzegzbJWV8ZmrWZX0W4w==
X-Received: by 2002:a17:902:e1d4:b0:295:62d:5004 with SMTP id d9443c01a7336-2962ad3ed89mr8006275ad.26.1762289502378;
        Tue, 04 Nov 2025 12:51:42 -0800 (PST)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a39ffbsm36492275ad.62.2025.11.04.12.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 12:51:42 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/8] iomap: account for unaligned end offsets when truncating read range
Date: Tue,  4 Nov 2025 12:51:12 -0800
Message-ID: <20251104205119.1600045-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104205119.1600045-1-joannelkoong@gmail.com>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The end position to start truncating from may be at an offset into a
block, which under the current logic would result in overtruncation.

Adjust the calculation to account for unaligned end offsets.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f099c086cbe8..c79b59e52a49 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -218,6 +218,22 @@ static void ifs_free(struct folio *folio)
 	kfree(ifs);
 }
 
+/*
+ * Calculate how many bytes to truncate based off the number of blocks to
+ * truncate and the end position to start truncating from.
+ */
+static size_t iomap_bytes_to_truncate(loff_t end_pos, unsigned block_bits,
+		unsigned blocks_truncated)
+{
+	unsigned block_size = 1 << block_bits;
+	unsigned block_offset = end_pos & (block_size - 1);
+
+	if (!block_offset)
+		return blocks_truncated << block_bits;
+
+	return ((blocks_truncated - 1) << block_bits) + block_offset;
+}
+
 /*
  * Calculate the range inside the folio that we actually need to read.
  */
@@ -263,7 +279,8 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		/* truncate len if we find any trailing uptodate block(s) */
 		while (++i <= last) {
 			if (ifs_block_is_uptodate(ifs, i)) {
-				plen -= (last - i + 1) * block_size;
+				plen -= iomap_bytes_to_truncate(*pos + plen,
+						block_bits, last - i + 1);
 				last = i - 1;
 				break;
 			}
@@ -279,7 +296,8 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		unsigned end = offset_in_folio(folio, isize - 1) >> block_bits;
 
 		if (first <= end && last > end)
-			plen -= (last - end) * block_size;
+			plen -= iomap_bytes_to_truncate(*pos + plen, block_bits,
+					last - end);
 	}
 
 	*offp = poff;
-- 
2.47.3


