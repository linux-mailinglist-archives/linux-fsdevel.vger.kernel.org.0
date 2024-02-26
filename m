Return-Path: <linux-fsdevel+bounces-12778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380BB86703E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FEA1F2A0C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999166E604;
	Mon, 26 Feb 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ftPcgErq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898796BB32;
	Mon, 26 Feb 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941031; cv=none; b=E44cmvBOZPJ4sWRXjEFus1xinKHP116wrLRuJCO08/Chjg+ccEwDnJZBgvR4aAQ1c4LviGx80CpWgre/JCxOGHvcqIQsoRppbveQh0DaMWNVKTycW2pr92+Z2OlwOdPXqaq/6ZOEDMY2y1U88VApLvtn1TPaKzUjvfvAK1bOXVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941031; c=relaxed/simple;
	bh=OPjPelr7jC5j/AA2ZEydqVDJmFXOxA3MXRxWvzjeqDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAF1zTu4o6UrYTWNFMSAo7w23m/tWRaSNSEhhftwu+sftzXiENGay+vrF0o2EeTjokC5hvX//ATys/D0VUc7JQvJAsW2xo3hMmOSIoz6e1WamdrTPcxE2d0huguibZG+HbhxD9u7SA0u0RB9gS+nhI8VSRpF5Lmnh5ddr/KrXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ftPcgErq; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TjwpV0ZL1z9ssH;
	Mon, 26 Feb 2024 10:50:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1708941026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CoSlfuEyGkiaGErrLwm5tBbxdIgWjqVT8F2G+alxKAU=;
	b=ftPcgErqnPBTbun/dhyU0NKfoVEkMjjZg0CZNyhDa1KTOioigQfA3tSxToEOkKPQT/5uVW
	CEY6E5/8D+UDJP+TbD41sLzkafb7BBOKarhRvsqEpaL3/dvCB7+HuFndTFm+FosZeS0VQl
	h4YFFeZ/Y+oZy/EKgfiAs1/xt1ctY/D6Fjyj/FcCTutVY6I2tpKMSKZ5oAox1iVPEfEzBX
	WpNNRQKPXKgxbceDl4iniriCVCxFMh9t7y74jc8ICR+vUH/CIUoQtd3pG5pxH9Qm8gddRV
	m/HS4ri7tPBppNTTqo7BDAzkBzabfNdsNicJ8dOItqWJP3LIMduq7kYp7b2sPQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	ziy@nvidia.com,
	hare@suse.de,
	djwong@kernel.org,
	gost.dev@samsung.com,
	linux-mm@kvack.org,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 10/13] iomap: fix iomap_dio_zero() for fs bs > system page size
Date: Mon, 26 Feb 2024 10:49:33 +0100
Message-ID: <20240226094936.2677493-11-kernel@pankajraghav.com>
In-Reply-To: <20240226094936.2677493-1-kernel@pankajraghav.com>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
< fs block size. iomap_dio_zero() has an implicit assumption that fs block
size < page_size. This is true for most filesystems at the moment.

If the block size > page size, this will send the contents of the page
next to zero page(as len > PAGE_SIZE) to the underlying block device,
causing FS corruption.

iomap is a generic infrastructure and it should not make any assumptions
about the fs block size and the page size of the system.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/direct-io.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bcd3f8cf5ea4..04f6c5548136 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -239,14 +239,23 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 	struct page *page = ZERO_PAGE(0);
 	struct bio *bio;
 
-	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
+	WARN_ON_ONCE(len > (BIO_MAX_VECS * PAGE_SIZE));
+
+	bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
+				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 				  GFP_KERNEL);
+
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	__bio_add_page(bio, page, len, 0);
+	while (len) {
+		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
+
+		__bio_add_page(bio, page, io_len, 0);
+		len -= io_len;
+	}
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 }
 
-- 
2.43.0


