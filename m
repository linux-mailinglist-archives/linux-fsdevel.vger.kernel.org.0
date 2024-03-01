Return-Path: <linux-fsdevel+bounces-13312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0618186E643
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358A31C248C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A4940866;
	Fri,  1 Mar 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Rf4VH7so"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23E745CD;
	Fri,  1 Mar 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311527; cv=none; b=QImyElls34IijnIvE9Lz5g6SFn8KZvtv26fxsqWwAUo0oVVmp9AkG09HJfY/b0A8Vll+Xf1ADudA0ntdWcMmiKZOjDZ4rwmWAf7FTKFGp8zBjlHIeEi6K9F1dPHmVUbKUu+hl8028kv+rdDH8xSWMNIVqoOAmC6PRE8x9WaR5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311527; c=relaxed/simple;
	bh=OPjPelr7jC5j/AA2ZEydqVDJmFXOxA3MXRxWvzjeqDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2iCstlrmrrB9wG4zFRlD+b7AaFtnB21gNBSS7Qbm3x2uP7x/MZ8mb1gzfn3M0kH4HKqZ8BVQX/Jji6kl9CY8OMbspV3hyd2vlDOpCVWdphIXl6GEo+esSDDpFeETfd0FsNGPlgb3gLicBk7rmBZai1AJRnuJMXvbMLJJZibyPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Rf4VH7so; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TmYqQ3Hk7z9tCB;
	Fri,  1 Mar 2024 17:45:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709311522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CoSlfuEyGkiaGErrLwm5tBbxdIgWjqVT8F2G+alxKAU=;
	b=Rf4VH7soZ/cgnAGRXcTEcKIV/sG+KQuBxSpjF53mjWkAVL6sw+HKmLZew6ousle6MJeTUR
	IHe7T5isExiLl34phOmLhBwfhIZEFdlgboAhxkyuZgZuf5NaxXrr27uqubaNFYdGVJD9SI
	L4yen1nde0OHzhSgMHHVPvrT5AK0WDQ6MA9eXSGNzhILjZ1fr5/v8PTxoP/MEiJ5ivl7kA
	d9Q+olVPgC8eTnAA4azyQ/pNJveDrQS69Ks+aTtNNlTHuVnAlQxPKoYb6QV6h/XK+zmD07
	PfFk8VJkOPsqMYrsi/y++OTMIKetmkWOleeP43XvHi+QSCDr2GUPbuDuaMwb8g==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: djwong@kernel.org,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	hare@suse.de,
	david@fromorbit.com,
	akpm@linux-foundation.org,
	gost.dev@samsung.com,
	linux-kernel@vger.kernel.org,
	chandan.babu@oracle.com,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 10/13] iomap: fix iomap_dio_zero() for fs bs > system page size
Date: Fri,  1 Mar 2024 17:44:41 +0100
Message-ID: <20240301164444.3799288-11-kernel@pankajraghav.com>
In-Reply-To: <20240301164444.3799288-1-kernel@pankajraghav.com>
References: <20240301164444.3799288-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TmYqQ3Hk7z9tCB

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


