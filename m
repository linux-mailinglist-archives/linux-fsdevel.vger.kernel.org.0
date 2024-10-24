Return-Path: <linux-fsdevel+bounces-32707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82D99AE091
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8054828484E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F01B6CE7;
	Thu, 24 Oct 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hr6H9iJL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A741B3925;
	Thu, 24 Oct 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761972; cv=none; b=WrffNi0Lt0H0KrexHpw2GJctMUbb1b23ALO21JjCsXl9X8TFHiXolvguIWhhVaOgab3MAXb+PsK3CWTjbeBvtXzFJa8/hGO8IpmXLO+NV1TJwe8zCVh9FmREsEeyQtRwrr7PILxSMY39iKab5u6MUikBcTLqrxTA5x3qmsBBF6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761972; c=relaxed/simple;
	bh=aR0BPAvWEJaq1IINO6JwAVrd0+FSpzvwkh3sGwILIkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvOslGAmXT/1kCZlki7L93pq5dXmJveBB6ycE2HhxRWSMUSkBRatJ9szEhlDDTsK5058hVWdOCg8Cdwlyr1lR1VlZ1n8a4xc7LyoiaSldwyT7snmFOo5THsm6Ke5Ibp/vy4rxv+o44tY6RUmCHrL+7Dwq6aduhfzsmD1lAf50IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hr6H9iJL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e6d988ecfso539479b3a.0;
        Thu, 24 Oct 2024 02:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729761970; x=1730366770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=828W4pUclcW/X5PV9rIvmIQLFWKFsfY8rzBeoqJt6Uw=;
        b=hr6H9iJLFovqMef3XupYDwrf9aNS1S6KWUiBmoq32Ng8R5b8aYJRhYSJFmCa9xu/I8
         1nM4r7VA/v9Cubn7dMQEI69vgqfl1rU2JUN0u1Cv5uEZLoTC5sgaf6YTiQV4CGxJHf2G
         xO5aBHa8oIpu4CPPB9JHpN5hWVw4eZGZHlxy2WFKxBkaW6dsKGl94UOBXLDb9RSwmgkO
         ffU0xXEb3hTQKoimy+HHKLXS07o6faHEggC4x1s7TbW14L/COQvPE6ZZKXTPHc3sq+A5
         6nn6A4i/MiUxI6f5SKTSVL1jKOelqKlVcer2RqNByZ5yI6Pq+5YxsRK37xwm8veEK2Ez
         trbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761970; x=1730366770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=828W4pUclcW/X5PV9rIvmIQLFWKFsfY8rzBeoqJt6Uw=;
        b=SgJsTwTmGfIhtcg74bcUV6FUAVysvUi35i4v/xLSupsUIZmGrlkBnD7biGJS/N49Io
         9QxlK1YgLesZu/PGx5xkFdg6pp/mFId9F7iZH4nKrK2IpPBCgb+GoL/AO7pDV3tr6oN3
         A9h/J+HboyP0CFazs4D5FMQsnfZmZ4C2px/AuduVrwPQcxOllTH7DzJgGPS2RA8STl2Y
         Edq4GdNV1V2WooaBT8ApRJVC/NIowYtZPB2Ba3RbkEI1F4FaP0w+jkGXTYcAecWaHyzY
         MeJ8qvF3Nd+106X546KKnKtRreDgbE4t2f1Vl2sKwfil4/TTwxiGZpB+cpEUzpgJEnmA
         3mFg==
X-Forwarded-Encrypted: i=1; AJvYcCVANO/YgizfteWy0U2e6+Ew5JcqdUXWgPPx3lXslN7vNn21AaVvuHPnkQmP9/M49YrIsCHzpzQ24LXzd8k=@vger.kernel.org, AJvYcCVLHPKywtMatL1EJqy5w+p2owbcwKUdROWgYGuRIIRkMZBr4elOT6Jh1O4ZqxZGpBf+vmJMem6JeHTq4/Zt@vger.kernel.org, AJvYcCWrBL9ckYRwlemCHku4CLjAyVLjnVD45dyVB9Bfv7Fw/K6BTiUIQQyC5rGIHvC5g5tfPkexzTkjxanmSJN8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0UBiQn1CsubVxbxq9UhTL7fx42GiGohcS4AMXUq/kS8EVQBRR
	OMn9LrxnzFc9fwnVJImZ3M+jJvqGrkQe23q1lGwnpLYmO/gg2RDJ
X-Google-Smtp-Source: AGHT+IHwNTDt2Km/E14JqnJAtswJDKwoRBooo1HUJXMdcLegLnogPBz/WFQtOLm6ihp8VMonfMZVcg==
X-Received: by 2002:a05:6a00:22d3:b0:71e:4930:162c with SMTP id d2e1a72fcca58-72030a517f5mr7735804b3a.6.1729761969931;
        Thu, 24 Oct 2024 02:26:09 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d774fsm7608906b3a.106.2024.10.24.02.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:26:09 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/12] nilfs2: convert segment buffer to be folio-based
Date: Thu, 24 Oct 2024 18:25:35 +0900
Message-ID: <20241024092602.13395-2-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024092602.13395-1-konishi.ryusuke@gmail.com>
References: <20241024092602.13395-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the segment buffer (log buffer) implementation, two parts of the
block buffer, CRC calculation and bio preparation, are still
page-based, so convert them to folio-based.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/segbuf.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index dc431b4c34c9..e08cab03366b 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -205,7 +205,6 @@ static void nilfs_segbuf_fill_in_data_crc(struct nilfs_segment_buffer *segbuf,
 {
 	struct buffer_head *bh;
 	struct nilfs_segment_summary *raw_sum;
-	void *kaddr;
 	u32 crc;
 
 	bh = list_entry(segbuf->sb_segsum_buffers.next, struct buffer_head,
@@ -220,9 +219,13 @@ static void nilfs_segbuf_fill_in_data_crc(struct nilfs_segment_buffer *segbuf,
 		crc = crc32_le(crc, bh->b_data, bh->b_size);
 	}
 	list_for_each_entry(bh, &segbuf->sb_payload_buffers, b_assoc_buffers) {
-		kaddr = kmap_local_page(bh->b_page);
-		crc = crc32_le(crc, kaddr + bh_offset(bh), bh->b_size);
-		kunmap_local(kaddr);
+		size_t offset = offset_in_folio(bh->b_folio, bh->b_data);
+		unsigned char *from;
+
+		/* Do not support block sizes larger than PAGE_SIZE */
+		from = kmap_local_folio(bh->b_folio, offset);
+		crc = crc32_le(crc, from, bh->b_size);
+		kunmap_local(from);
 	}
 	raw_sum->ss_datasum = cpu_to_le32(crc);
 }
@@ -374,7 +377,7 @@ static int nilfs_segbuf_submit_bh(struct nilfs_segment_buffer *segbuf,
 				  struct nilfs_write_info *wi,
 				  struct buffer_head *bh)
 {
-	int len, err;
+	int err;
 
 	BUG_ON(wi->nr_vecs <= 0);
  repeat:
@@ -385,8 +388,8 @@ static int nilfs_segbuf_submit_bh(struct nilfs_segment_buffer *segbuf,
 			(wi->nilfs->ns_blocksize_bits - 9);
 	}
 
-	len = bio_add_page(wi->bio, bh->b_page, bh->b_size, bh_offset(bh));
-	if (len == bh->b_size) {
+	if (bio_add_folio(wi->bio, bh->b_folio, bh->b_size,
+			  offset_in_folio(bh->b_folio, bh->b_data))) {
 		wi->end++;
 		return 0;
 	}
-- 
2.43.0


