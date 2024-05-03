Return-Path: <linux-fsdevel+bounces-18592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE898BAA48
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CD01F2300D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1047515217C;
	Fri,  3 May 2024 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2qf468M5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D414F9E4;
	Fri,  3 May 2024 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730044; cv=none; b=pPJin3wC0tS0hNnX+UmgfEfnmwNapK1Gstc/BNfw2jyZ2htJqmd2FoivYWspANXTRk0zMU1x4zxRcjA1kNaLtpYefKTy94HMqf9/MCWoyVfSbzu7LwrcdluEl7vxlC1j4YcI50bN7Z/hcrEFFV6NuixYsO4YAyBa/dxbzOpgA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730044; c=relaxed/simple;
	bh=x/qHM+8+KOOgQuPF1OFt59ApCHtcscLof0zo4oBIjoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uX4OO27J2GBM0Hyl3ElNSdn2iyWZUhrlfwHvf/7C9nLBRYTi8uZvIaVvDzp/khu3YMiY/FNOPAsZ1DtpURE6LCKTilkPrwlRMk6Pw/LqfAnR1sagaoygY9l4TgfUt4M+1wthITYlWZc96EcIJylSSjyePG6K/AClAVzUEVznZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2qf468M5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RHyoQ5MeMPOJuHOHR3udnfU/iHZQj7DT1fxrfrX8N6E=; b=2qf468M5NYODQCoDLTcrc43FtK
	/iR7zVVzXU4Pagy9bazcOeQhZP3xF8VslzicxT/A4zbKA6ZNrv3CNhW7bXTLx76PZzyUali+yFhal
	lVmsI39fMAfT0NqziS1mxPlXOu6MlTrO7Deewn4YCyQmYryDehvIuFRJPb8zF1TkYkIq8LSLoTUTZ
	YcW+VL+WSR8OnA1unlFHaMRsNIpRAoM6Ih0lcukDeKhwHBX7f2npAVyBxDOaJE54GLKZ0XtolFeb8
	IAE0CHqxKCPV18AgbZHgjKqphyJCNSH2Wq4KnC9mGNq5xBeqhNGEfjLV+wOH5qpGWlD1Wpnaddr1k
	/Ut43srQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2pc3-0000000Fw3m-1Iwd;
	Fri, 03 May 2024 09:53:55 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	djwong@kernel.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com
Cc: hare@suse.de,
	ritesh.list@gmail.com,
	john.g.garry@oracle.com,
	ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH v5 07/11] iomap: fix iomap_dio_zero() for fs bs > system page size
Date: Fri,  3 May 2024 02:53:49 -0700
Message-ID: <20240503095353.3798063-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503095353.3798063-1-mcgrof@kernel.org>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

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
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 fs/iomap/direct-io.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f3b43d223a46..5f481068de5b 100644
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


