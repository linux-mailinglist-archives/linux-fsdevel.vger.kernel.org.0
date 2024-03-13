Return-Path: <linux-fsdevel+bounces-14308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F38287AF22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01801286F0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6D91998BA;
	Wed, 13 Mar 2024 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="mvvw8Uxd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE6B199896;
	Wed, 13 Mar 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349415; cv=none; b=mJgbBAtf/e33SBzU6Fjr9WdRgMFj7JI8hiGOuOJHMrpor/DIwK1i5cNLKbw/uZA3Lo42dNORH05q0DeMUkWvK6SuqJiMbWGWAjIx4H3oFpXPsbmCGW6xKSVaRnEy/s4qEQvaiftuGD/Ijt2qt0b/FC6W5qSuuC6/IPVdxz2OI6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349415; c=relaxed/simple;
	bh=OPjPelr7jC5j/AA2ZEydqVDJmFXOxA3MXRxWvzjeqDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1efBD2hwGcC7x4yH4uum4uxdvFpyA5GH2SwTI7LCy4r3O8PU14HG5loau9w3oT5Y+/kPYGcG2SlEQTytwE3IAhAGkRBxyqXrV7cIaVUBRb64Ydd1HztIz7ik2iAdjLRHH/1n+6tPcI+KsvS3KhnR6UCvaFSc3BGfQ0UEP++x4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=mvvw8Uxd; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Tvxfp0XHQz9sjG;
	Wed, 13 Mar 2024 18:03:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1710349410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CoSlfuEyGkiaGErrLwm5tBbxdIgWjqVT8F2G+alxKAU=;
	b=mvvw8Uxd8FI+cZwtRvS7Jb6PzVhcuKI2aUQbkfgZAXBDtjhGQc6l/aHdA/AuoMYeLf+Pha
	JCQRnn+aIlO10MBf3ldx/ILo5zGxFbvlXtliBuGk8I6tmj9crdNElXPe7JhhVnVL0YLvPx
	LcYQMAhx+gx+SIMNo/J1uYdpG21GWg6Pb7M8jLF7uAaV+FC9tnL6YC2H9w32hGf2WG4AI6
	fQ1dBQ7uxhT+3f/VbS3J8HxQWXhZ1lxrpQZeNv4/66sHoQuND7xbilehbB17lzfXSqHkiD
	OamFwpDDrG1taP1i/YuGszkIkYVB9r3HPNQFh+JapI6Y5/q/DwMfYzwX3Z1bdQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: gost.dev@samsung.com,
	chandan.babu@oracle.com,
	hare@suse.de,
	mcgrof@kernel.org,
	djwong@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	akpm@linux-foundation.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 08/11] iomap: fix iomap_dio_zero() for fs bs > system page size
Date: Wed, 13 Mar 2024 18:02:50 +0100
Message-ID: <20240313170253.2324812-9-kernel@pankajraghav.com>
In-Reply-To: <20240313170253.2324812-1-kernel@pankajraghav.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Tvxfp0XHQz9sjG

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


