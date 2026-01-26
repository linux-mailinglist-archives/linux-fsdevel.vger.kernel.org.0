Return-Path: <linux-fsdevel+bounces-75436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPpAIz8Cd2maaQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:57:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DD38451D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76504304023C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592C9237180;
	Mon, 26 Jan 2026 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yNYVha3W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34F721B191;
	Mon, 26 Jan 2026 05:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406915; cv=none; b=jpowuyivqDm2aR7OlOlgGV7sFrbmp7papq7rdIiaM/VPRqKsroaJ+dOXHFQea3Y1CgT+klRUrpa3hGKALNAKD7hKQ9BqpeCd7MDzhOb3/cJQP6SZ8qh3rdwUEOGpk9E6pNvXKPaPsDtIYSBnrKU1T8i+F+Wfh5qGKDtLfFaWwYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406915; c=relaxed/simple;
	bh=QSyialDWi3Sk52Xucol05qEDsTAPBvrobPbXXh4j4Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hh0Oh6FhS74hSB2hj38mmh03q5FWKBlRAUwuCNB7HE17Ne0cUbujhGM1w7ncVC6/G/AWfzZsV6AEQLtm+xo28+KdaJgexZprywd1t2/jtNEx2REMZrY0jkZzzEUdNbBuLVS1YsHJIHb9/Fd/ILo3m39ZDAyxgLed9RLx26cF+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yNYVha3W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SvPJ4GBLDawepo24KPyna3qBKX7YMvdKU+8feW57z5A=; b=yNYVha3W2ZfH+ITiVX7CPqfnXq
	gnz+l6Pv2d9zdoC0xjn7gvtSoMxaqEohhJeslWpLhwzrD4vprfw30qP9AF3TyKlVywTYEQXlP0mcG
	jgtXORDEvUU/AVdK+GwOXPJVgvGDUtVecV6a3Os/IA+FxCBU+Knkv9nKZF8iWQvFz2LfjGM88kQMI
	TQ3/mgGXNVLrw6wT7DRlbpvxF+TSJtxFFNKH+W6/6hH1FmhyLQyYIlKz4caVJ0ed9k9QmG3Sjb8lf
	8gqwOCc5/61RGY+elnOimzcxVrOVftAp9HQkAcExK32Iq8WoqQmboB2+eE/pqemO9eUOqrV81ogKT
	Vb6tyX0g==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkFZB-0000000BxJK-0Ecr;
	Mon, 26 Jan 2026 05:55:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 12/15] iomap: rename IOMAP_DIO_DIRTY to IOMAP_DIO_USER_BACKED
Date: Mon, 26 Jan 2026 06:53:43 +0100
Message-ID: <20260126055406.1421026-13-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126055406.1421026-1-hch@lst.de>
References: <20260126055406.1421026-1-hch@lst.de>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75436-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 36DD38451D
X-Rspamd-Action: no action

Match the more descriptive iov_iter terminology instead of encoding
what we do with them for reads only.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/iomap/direct-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index d4d52775ce25..eca7adda595a 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -22,7 +22,7 @@
 #define IOMAP_DIO_WRITE_THROUGH	(1U << 28)
 #define IOMAP_DIO_NEED_SYNC	(1U << 29)
 #define IOMAP_DIO_WRITE		(1U << 30)
-#define IOMAP_DIO_DIRTY		(1U << 31)
+#define IOMAP_DIO_USER_BACKED	(1U << 31)
 
 struct iomap_dio {
 	struct kiocb		*iocb;
@@ -215,7 +215,7 @@ static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
 {
 	struct iomap_dio *dio = bio->bi_private;
 
-	if (dio->flags & IOMAP_DIO_DIRTY) {
+	if (dio->flags & IOMAP_DIO_USER_BACKED) {
 		bio_check_pages_dirty(bio);
 	} else {
 		bio_release_pages(bio, false);
@@ -333,7 +333,7 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 
 	if (dio->flags & IOMAP_DIO_WRITE)
 		task_io_account_write(ret);
-	else if (dio->flags & IOMAP_DIO_DIRTY)
+	else if (dio->flags & IOMAP_DIO_USER_BACKED)
 		bio_set_pages_dirty(bio);
 
 	/*
@@ -679,7 +679,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			goto out_free_dio;
 
 		if (user_backed_iter(iter))
-			dio->flags |= IOMAP_DIO_DIRTY;
+			dio->flags |= IOMAP_DIO_USER_BACKED;
 
 		ret = kiocb_write_and_wait(iocb, iomi.len);
 		if (ret)
-- 
2.47.3


