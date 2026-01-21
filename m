Return-Path: <linux-fsdevel+bounces-74803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK9aJMV2cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:48:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 542BF5251D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B4254E1D1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A3B44CF27;
	Wed, 21 Jan 2026 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pmCIfBm0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2402C44BC82;
	Wed, 21 Jan 2026 06:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977860; cv=none; b=Exe+MNXGwh2qtZgILAB81XqrDYEvWJpxJ5GHxPYo4ld9CSURuDXgUzNEgLJ5PeZD1BrykTtKXMglG0zRsW+OB4TCeikUKUuhhHRCfZfyFt5FhViVzd27aVyogvBEFXOoQqRU6FGeFY7xp71B1ZcNAtjuCCW+Tz4ewPz+PtqS9F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977860; c=relaxed/simple;
	bh=JQVLIbOmM0G8IIbEmIxFeMOnflSNiQeuvvaQxrlboSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiR+zAgKdqJJZKbubtyhyzipH5Rn/lqPfBYf5SqNg1McLM1sJ+m2+znQ1pA1genvWaPZkIh9J+izg6WRHC2+FiyHit2gxGlgAEjarMiiDxys3tTi02uumhRVpPV7KertSf1YD5iovXRYZR6P6dWL6c0zQk6bwuBvo7cIT4TNHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pmCIfBm0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gaxtR/vSv+k24HZ2H7WG5vuWJEK+XOvRKYCy8woT1II=; b=pmCIfBm07OEcCRW7uxd0ypYRYV
	z3GhFxsvYqENCxfEX2YJlkpFO2dfBTygDL2kNFAJIVdCAFv+TF8WD++DWdceM2eaapatU2NG501w5
	ycFH/xXnJYNZOyHPhWnx9dpEpXUxfWuR4sUjK5gZSCBpbTUPvePmwivw4TVdr8JJn4kBg8eVQkjtC
	FCXGZHzwl85ZALVzgT7/c3HtOm8kTS9z9dRUtkkxFiAJ8xemRF2MygoUAduZXDu/ggpXcgBGFvU6h
	KdTPiRgx0ITNWV03LWtnwu/7afeUKS1Hqmchv7xzLEHSCd5QZK736SU+53WL02XcEOkLfhK7JZIxU
	AGYwuP3g==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viRwv-00000004xaE-2uoA;
	Wed, 21 Jan 2026 06:44:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 07/15] block: pass a maxlen argument to bio_iov_iter_bounce
Date: Wed, 21 Jan 2026 07:43:15 +0100
Message-ID: <20260121064339.206019-8-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121064339.206019-1-hch@lst.de>
References: <20260121064339.206019-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-74803-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,lst.de:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,infradead.org:dkim]
X-Rspamd-Queue-Id: 542BF5251D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow the file system to limit the size processed in a single
bounce operation.  This is needed when generating integrity data
so that the size of a single integrity segment can't overflow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c          | 17 ++++++++++-------
 fs/iomap/direct-io.c |  2 +-
 include/linux/bio.h  |  2 +-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index da795b1df52a..e89b24dc0283 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1293,9 +1293,10 @@ static void bio_free_folios(struct bio *bio)
 	}
 }
 
-static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter)
+static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter,
+		size_t maxlen)
 {
-	size_t total_len = iov_iter_count(iter);
+	size_t total_len = min(maxlen, iov_iter_count(iter));
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return -EINVAL;
@@ -1333,9 +1334,10 @@ static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter)
 	return 0;
 }
 
-static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
+static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
+		size_t maxlen)
 {
-	size_t len = min(iov_iter_count(iter), SZ_1M);
+	size_t len = min3(iov_iter_count(iter), maxlen, SZ_1M);
 	struct folio *folio;
 
 	folio = folio_alloc_greedy(GFP_KERNEL, &len);
@@ -1372,6 +1374,7 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
  * bio_iov_iter_bounce - bounce buffer data from an iter into a bio
  * @bio:	bio to send
  * @iter:	iter to read from / write into
+ * @maxlen:	maximum size to bounce
  *
  * Helper for direct I/O implementations that need to bounce buffer because
  * we need to checksum the data or perform other operations that require
@@ -1379,11 +1382,11 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
  * copies the data into it.  Needs to be paired with bio_iov_iter_unbounce()
  * called on completion.
  */
-int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter)
+int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter, size_t maxlen)
 {
 	if (op_is_write(bio_op(bio)))
-		return bio_iov_iter_bounce_write(bio, iter);
-	return bio_iov_iter_bounce_read(bio, iter);
+		return bio_iov_iter_bounce_write(bio, iter, maxlen);
+	return bio_iov_iter_bounce_read(bio, iter, maxlen);
 }
 
 static void bvec_unpin(struct bio_vec *bv, bool mark_dirty)
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9c572de0d596..842fc7fecb2d 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -326,7 +326,7 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
 	if (dio->flags & IOMAP_DIO_BOUNCE)
-		ret = bio_iov_iter_bounce(bio, dio->submit.iter);
+		ret = bio_iov_iter_bounce(bio, dio->submit.iter, UINT_MAX);
 	else
 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
 					     alignment - 1);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 95cfc79b88b8..df0d7e71372a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -479,7 +479,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
 
-int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter);
+int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter, size_t maxlen);
 void bio_iov_iter_unbounce(struct bio *bio, bool is_error, bool mark_dirty);
 
 extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
-- 
2.47.3


