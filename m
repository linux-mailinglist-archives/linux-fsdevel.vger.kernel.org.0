Return-Path: <linux-fsdevel+bounces-17748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4028B20A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495C41F25207
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D5E12BEB6;
	Thu, 25 Apr 2024 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="0i4j7ORW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7F312AACE;
	Thu, 25 Apr 2024 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045638; cv=none; b=cr95Oe86v/v+2tX9fjANMxoqisgb9+E4/l7oy4rL8df+gbmq3yYDaacQJ7e3a9n5YIwS2RUIXx5jCtQHhWczovVlhVspGgpnmFcUut5AF3X1FtAkxy4Q2OHpx8UkgGT5LWSU5ZlxDIKw13o5H7Bb4vAp+PMKEmqbunSRhVi8CDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045638; c=relaxed/simple;
	bh=e1JMgJ3VA2izblNM3szg9lbs5qSkv4SB6uOxM51vUqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZbCLRDZiM+Q0mZSOZViEZSLaZur0uI88LJYf3u2mvZL4OnaFQWzTGYU0/jXKELycPLWnFayk1OLmz6+QceicGRL1DWXe9SMeBysics5DucRDnB1pYVluaqmm4WTYNaahi3I+OsgtVIBsiVysltmUEDLSFYGfJoQPqzpXwQPAyY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=0i4j7ORW; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VQDPj4W0lz9st9;
	Thu, 25 Apr 2024 13:38:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714045097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZEgKM6QrgoQBOd+qQrQCeNmZ9w7P0QsYqZWksJ5EHk=;
	b=0i4j7ORWzhspfs9ixeGdeOd0r1Eo3pwU4BtbEF6woZni4V5L14YKa90J2IqEZYFdXLtLwQ
	d095+992gOcqpTpvDmkxs9wjY7M3TnyMW+njvxML8bzJAjWem3m3XsWdSnSWuFuh+Sj2Qj
	CGfTbZEvR/uGNDzP9Z4zzf/tKBzDsE6Ugs0w6iwnqs2ybQsAfmPk1e45Pn0ZYURDU6HqQs
	gsvloW/OFuuUMDj24VJs5qlh3CmNhbyAybQzf8AuK0YnrBAsRuGirf1A4SpVy33vZBe5H0
	nWRJZVwpcGRXpRVNm+x4Y29XeSpONlxWjPDS1jg0b1WOaVJEhEi9gXgIZO+4IQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	djwong@kernel.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: [PATCH v4 07/11] iomap: fix iomap_dio_zero() for fs bs > system page size
Date: Thu, 25 Apr 2024 13:37:42 +0200
Message-Id: <20240425113746.335530-8-kernel@pankajraghav.com>
In-Reply-To: <20240425113746.335530-1-kernel@pankajraghav.com>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VQDPj4W0lz9st9

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
2.34.1


