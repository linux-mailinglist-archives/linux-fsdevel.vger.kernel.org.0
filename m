Return-Path: <linux-fsdevel+bounces-77943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOZiEPpUnGkAEQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:24:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 953C2176C35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A53F630341BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E340D1FC7FB;
	Mon, 23 Feb 2026 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZRaZMR7R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC0F18CBE1;
	Mon, 23 Feb 2026 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852923; cv=none; b=RNjX+i6192txycN+lF6mEK+HL/Lq74ngLtnbX/0anqwpaVDCDP2pO6Fskb/DiJhbPwCmz1CPQ1m6eUgUvAHobtGHUsFGmodM3eCXrJ6y6GmdUrK8sVdAVbzihVa1xIdsLtq19+yPJGTpUCabovXm8zsKDK13ebJRTQFI8Mj9Nzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852923; c=relaxed/simple;
	bh=qy8kAjwQVIpMfNGokBf/u2atO1HGTf60md7gjr1tf+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDa94cSAkIfJgVz0U92uGYieDMd55Yv2v0KRSwp2ZHddRaBJwL/60GcyfK8biWAoyOTmhyZ7z+YFUg4d3lcHHig9TWZaRPLGdnuaF6axx5KZArBw6GoGZUBLQMjo3l74z8QerRnYcdDRr+dhsudOu8vLZMUSpFZ8Qa6rDmzNW6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZRaZMR7R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+A0rObcFfgdd0PuUHX3+v1XDTdW55Rp9xT/Yf5/RHG0=; b=ZRaZMR7RXKZbXYWVSK8k2duJpi
	i49i8x1o9BUAunFbRARWxnlZS7yaElW7DYSdrnDslEQvpaJrXX16S9E26esdQ+hOW+rObeFLHKRxE
	ncD9ZzVDi4ViAJYCMNAiZDZU2OHivTlAdvu8J13UDufFauYI8rauErSqSCKTrD5MNY1aWVn8KyJbE
	tfuOxPw3B7PC5LGOSODvsdiBKAXRPWVveVF9j62RupeyHdD+d8Lcc6RXBYUcPuYIqKsm9b0Stbpdb
	Lrh2zypaxe7iTpiHiF7Xo9KLUt1fdj4Epr0k5tLNMQIsHRfAJmv7pS9ghfrP2EJfLW9drtmc/blSX
	Un+8KSPA==;
Received: from [94.156.175.41] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuVsu-00000000LxN-0R83;
	Mon, 23 Feb 2026 13:22:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 07/16] block: pass a maxlen argument to bio_iov_iter_bounce
Date: Mon, 23 Feb 2026 05:20:07 -0800
Message-ID: <20260223132021.292832-8-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223132021.292832-1-hch@lst.de>
References: <20260223132021.292832-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-77943-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lst.de:mid,lst.de:email,samsung.com:email]
X-Rspamd-Queue-Id: 953C2176C35
X-Rspamd-Action: no action

Allow the file system to limit the size processed in a single
bounce operation.  This is needed when generating integrity data
so that the size of a single integrity segment can't overflow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/bio.c          | 17 ++++++++++-------
 fs/iomap/direct-io.c |  2 +-
 include/linux/bio.h  |  2 +-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d80d5d26804e..784d2a66d3ae 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1327,9 +1327,10 @@ static void bio_free_folios(struct bio *bio)
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
@@ -1367,9 +1368,10 @@ static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter)
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
@@ -1408,6 +1410,7 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
  * bio_iov_iter_bounce - bounce buffer data from an iter into a bio
  * @bio:	bio to send
  * @iter:	iter to read from / write into
+ * @maxlen:	maximum size to bounce
  *
  * Helper for direct I/O implementations that need to bounce buffer because
  * we need to checksum the data or perform other operations that require
@@ -1415,11 +1418,11 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
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
index 95254aa1b654..21d4fad2eeb8 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -338,7 +338,7 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
 	if (dio->flags & IOMAP_DIO_BOUNCE)
-		ret = bio_iov_iter_bounce(bio, dio->submit.iter);
+		ret = bio_iov_iter_bounce(bio, dio->submit.iter, BIO_MAX_SIZE);
 	else
 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
 					     alignment - 1);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 36a3f2275ecd..9693a0d6fefe 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -474,7 +474,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
 
-int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter);
+int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter, size_t maxlen);
 void bio_iov_iter_unbounce(struct bio *bio, bool is_error, bool mark_dirty);
 
 extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
-- 
2.47.3


