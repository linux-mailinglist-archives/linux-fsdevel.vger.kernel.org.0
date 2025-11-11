Return-Path: <linux-fsdevel+bounces-67981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E832C4F9E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 20:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B031E4E2C41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 19:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7869F329E63;
	Tue, 11 Nov 2025 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxTDFgMs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771EB329C61
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889924; cv=none; b=N4AMc3zDXBQIe/r8pgWRjI+2ITgC9m8dCUPDB49rI2GWDj6yAd8TqLhmVwUnLXh0/7qdGdoxzdlxs4X1+P5r+LJbG4YDrDG7GonLX8XJoTG9Zj+GWK36/TYgAgz8GpAFav3KvSz5AZY/xKOXvKYiVmbtvwz2rBMtZT5hikodIkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889924; c=relaxed/simple;
	bh=xClvCcCZ4QcdVeopfOk1mYmkGYQDjubx8XsxNA39Wgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rW5pnuNSP/dDjgM/8YaxhVzF0YRbXt46WA4RXShJsDbtJvqiViu3/vCE5ek0l4zsxv4A4+KTsYuxhsIDr5ELK/b+UiRLyauvlCHW/yDUu/C9rJIUem8QZJOeRrAQHZ/Z22Yd68RViHoD9KHJvOBvHXyv+yE8LnRiPldln87xXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxTDFgMs; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so85911b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 11:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762889923; x=1763494723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMDWAZ13FzijDux9SrQUqjpZtJzoLvif7zWiHZm5lkI=;
        b=DxTDFgMsUCtiaHwNDzz44BBkSkM/QZbJnQbiJ3Bzhl0khsd4Auw5VttibwT/Ij5ZxL
         kLbkNn4QQfVIbp2x9dRXIf4cn9ZqZf9uwUZPAHMU7OCwHTHCVp2ND/UasKKppcBfozuf
         f5tob5txO6LWhlZwFkVL4woqgR+8PfpcstRbuE2RT1D3wPmn7ZY9+YoIj9mQQ0VivwLf
         LZzojOROwLpQvNLpPydQitwXaUeTTU9lbUJe1vp3wAkeDrE1iF5Lr1oRzgwmyQdLKJuq
         Hdb8vd5syjLe6qrd/BWnhw2BNQg3Gm7ecdsppuGRIFuvr3EwK0rAalFV2EBSBH/1Ver/
         W5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889923; x=1763494723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yMDWAZ13FzijDux9SrQUqjpZtJzoLvif7zWiHZm5lkI=;
        b=nlwL0nMyJiADRNqbbP79bOIOQ1EhVDcnWzhKWrX79reGKHadY/mMpGb7vidHrnXSPh
         VmEWUjijvCwkJfw5JMCaQaTXiuq8+z0im7g2hNQIsMJvAm3FZP3Q9a90lSNzcbnYSvuI
         NLh/6XGimqXK35+T9KG8swEqnTwqlBG2bBZUI/MKLnJZklJAeR4t+xE656ZzrAfFCJfL
         G1LeTj46Ai6/Kt688yZ94GoJvwopQU0d7vgkGA8tJS++HEprsuFi/hdFqpRGhDO/Kwje
         SpzBs84S7aVno+ffEx7LC6R2uDXNYf60LJlTlu8qZF027UJub3U3wOzHB/9CPmDj6mNI
         edGA==
X-Forwarded-Encrypted: i=1; AJvYcCW7pUV6/USs3wfrlvo0NTaIg1yrqYNXl8j55OncpKcH8YljlgXYMgmK0u3GpVA3wQ+O2DvDcz2bFLrvzMtw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb2uyQwPT6+YauurfFAkEwwqaIXRQGwrnlcp1FrcSJg/ObjfBy
	ZFJbbS58umwmtJRGAHVxBv1QhsLVWP2nlIarnvZ+A5x77IblPTTmCspJ6tO2Ig==
X-Gm-Gg: ASbGncu5zamO/SbWTKlFF4ZQ2zZ75PmeSBOALY+N/U3q3P0ITktfOiKdZNa8y/72PBG
	1/MwS/R398TP61OVD+SY7U7QuPnG76/l9r9W4LX8npufkKiUtzEyB9UN5uA8FjrbaSzON8a/Iwg
	FMhrYcBb5urAfp0v8XJA1yW9akN4fRhoQ7nuhm6rEuxN2+3L1zptVDMwCu0PLxpGiRiwdVY9bFN
	rEHf7RH8/iOX6n415Ly1btsgvnSh0LV+k3o6RscyqrmpGKwiW88zFQ+4PcTJDrEx/2v+m15bH4W
	PYDVEZNtZVTHA35lPyK3aX+wEaulh/glaBd1mlIcNE13iRTbfU5nYiKo4Y+WYdSKJeORn4gHEAA
	2NrPyXVxZHtfFx7usvAVIdR2ACIBKOGXlsQIA8N3V6ngFTXETpPRl/5wtWMFWk336qf6wdjzxdi
	CXU2yw6NCldXF1gGQgZpl3a8Q=
X-Google-Smtp-Source: AGHT+IEeenU2Ox7GpMfG9cPYyvogxhXEOBkqH5A2DDW02HVlrdLDhfzYckT+VJcyb6P/0+dRg1vaeQ==
X-Received: by 2002:a05:6a00:63c1:b0:7b7:4441:4b32 with SMTP id d2e1a72fcca58-7b7a4fdc2fbmr147699b3a.29.1762889922769;
        Tue, 11 Nov 2025 11:38:42 -0800 (PST)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc1765bdsm15916645b3a.36.2025.11.11.11.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:38:42 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 2/9] iomap: account for unaligned end offsets when truncating read range
Date: Tue, 11 Nov 2025 11:36:51 -0800
Message-ID: <20251111193658.3495942-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111193658.3495942-1-joannelkoong@gmail.com>
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7dcb8bbc9484..0eb439b523b1 100644
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


