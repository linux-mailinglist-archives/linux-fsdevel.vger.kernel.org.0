Return-Path: <linux-fsdevel+bounces-52667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 829CDAE59EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE371BC15BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DBF239E7E;
	Tue, 24 Jun 2025 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAOMDCXt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25B231A51;
	Tue, 24 Jun 2025 02:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731790; cv=none; b=SdLzqJdFBaPxQXABlDFf8mPhizyVrIISo6xfYbM5RL4J3Vd4Aq+vGn09XisGRbYTiX7LahfZyK2S55fQRmKguSWP0+RF63Pi5owSAVqOPKhuDZog5zhWZmLaWcWQO+jr5duiwcHvKoKsByRXDgt9QFNEop4iOQmNmxRnRwV38Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731790; c=relaxed/simple;
	bh=DuFDYi6x2GDu8XCgCXdktULX1gXUCzSc3Jt7r8VI/KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DATqm7jNq2lDTNua06VkHm1vraDnFceTzMu+KDmXWYCtvL81wSPVVHYHnO8Mzl2S/nuUR1OeUobJq51iEsSht8QBS05Ki3wkhOuBLlXtYi8hgmp0dMHrCZ0nduiqNNb/RFzavXsMNyIChC8kwk0QEwyU3JNps3tKYdAHe7dFzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAOMDCXt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7490702fc7cso2597695b3a.1;
        Mon, 23 Jun 2025 19:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731788; x=1751336588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbcCkgg55M0bdQitvnUlRX8wbIsKazYAcM3SmCzuIfk=;
        b=BAOMDCXtTnxLIHgtgBA6thh+HnFOp5pG5Hi0GLVKwy/M1zuc2cHQO3qMRs43xUdzQz
         Xf976j0IzJ3czyFJvDjJfGyubGuDqEwq32uyiUW6eF09iJA78pNuGfiZGVttidB/tuOs
         0fOmwxgSNIwtuvKjOA+1pcwRpq/NQE2BFK6/RXvD6ndPU0zwcOyx8T2e2rbrlr/isWLb
         pxXpzj8iSDKTUjctQKtU1G9ikZV/X6pxRgn7v1zRreNUgv47hqbBy+afV6bmqWPE0ecf
         EXJIgrGe/PbARjCwnby91Z7FUfG+8QPuCU/F/JRE9J4b5NFmpORpF4nPB645VYce9sAU
         /DPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731788; x=1751336588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbcCkgg55M0bdQitvnUlRX8wbIsKazYAcM3SmCzuIfk=;
        b=CW5C138t7m9oSWPCrbc89KoFcY6j15fIWR0FgyB1+eBB8EuvDleHwjPkAZjlOuTvpY
         Ojlt+zOExsHYro1DhIRDJbvk8pSM6hvm21zbAMpj8RQNR0VSS30ov0Kw2ldkNtcBnsmK
         AW0I65ieh0tTyf+lz+3+6n/W5tIMEzQ2jEHYg32yt1DnsnBPKKVkOoZ3IcgJFbPWaZTV
         1SgpFaCynPnjXknMa+wbrrc5EFpM2T+W1ztmwjYsAe1u3KL9JuGzgWXDZOx7aiGDmhz+
         1c7hxrO+bJgQQOSaTpTJ16PJl7GTIIMIx6si+jmzgHSQFRyLjrO8f85R2S+eA26j7Mbt
         ++xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdeZ9OZ5hm39VKOodVdiBLKh/CUU20tqd+0ghhmbnB+MB0gMXriOPyeJsfBBDgT16/Xl1662XTYFl+3A==@vger.kernel.org, AJvYcCVBbpplA3eFEvLgcbrpcqBu201ohQIWGje/1gDfU9SSz5Jk80qiimTj2CKyHf8AKKkoZauYc4khSyNJ@vger.kernel.org, AJvYcCXR0b04KQU1Bzo8Zw15hcmrkmO8O5y5mGuo1eCk4WJoN+F02A2kmvCR81q2wZEnEaHDGu7GEyPWaYCT@vger.kernel.org
X-Gm-Message-State: AOJu0YwNcQjyt3oT+wXMk/wrhMxdAs5wseVf7SWe0MQpQg4MBrCwyyrf
	NtTjs1+9RX25f8287LXq8cjeJfcsvIROm1qkM2M/ddSHtweHmdUHRgGEVwq7MQ==
X-Gm-Gg: ASbGncvI1QDZDx/CH9AfR1QMBK++m2k/vAhBclMqnAAhNlpDmaHjyZorQBktURk4YDR
	3qn2k3BU519hhJmMZDfYYERb384AsX8VG54eSp84ZcquN5S5b4TPkRsKhP6X7sjuODMtGz4R6f6
	zVO80S9b8EyT84WRQUzNeHA/C/SiNRcUQV/UiTZI8ekYdBXczA3MfdYFiypFsgJHl6WzC1nt0MX
	oCjsLc59tzr6X5AWTSHqAHWMlYHIEJsPN8poezjy/YadFSf6mATIiZxIgv1dLt4JOZ2/lk43Kk5
	aQULZrpmg2trxzYWW+Up/jBUe6oowaNJj596psXVqGmzkEnm3mSp/DCu
X-Google-Smtp-Source: AGHT+IEENwAkXzGydPxLzf6WX938YJuS6B9WM8WOwIG5D04Hw1fzs6d1BLLn8TmD3v/7taw6P6gwag==
X-Received: by 2002:a05:6a20:7f8d:b0:21a:de8e:44b1 with SMTP id adf61e73a8af0-22026e6bde2mr26230930637.34.1750731787652;
        Mon, 23 Jun 2025 19:23:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8850c86sm487581b3a.112.2025.06.23.19.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:07 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 07/16] iomap: rename iomap_writepage_map to iomap_writeback_folio
Date: Mon, 23 Jun 2025 19:21:26 -0700
Message-ID: <20250624022135.832899-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624022135.832899-1-joannelkoong@gmail.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

->writepage is gone, and our naming wasn't always that great to start
with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c262f883f9f9..c6bbee68812e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1586,7 +1586,7 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
  * If the folio is entirely beyond i_size, return false.  If it straddles
  * i_size, adjust end_pos and zero all data beyond i_size.
  */
-static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
+static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
 		u64 *end_pos)
 {
 	u64 isize = i_size_read(inode);
@@ -1638,7 +1638,7 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
 	return true;
 }
 
-static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
+static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 		struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
@@ -1656,7 +1656,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 
 	trace_iomap_writepage(inode, pos, folio_size(folio));
 
-	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
+	if (!iomap_writeback_handle_eof(folio, inode, &end_pos)) {
 		folio_unlock(folio);
 		return 0;
 	}
@@ -1741,7 +1741,7 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
 		return -EIO;
 
 	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
-		error = iomap_writepage_map(wpc, folio);
+		error = iomap_writeback_folio(wpc, folio);
 
 	/*
 	 * If @error is non-zero, it means that we have a situation where some
-- 
2.47.1


