Return-Path: <linux-fsdevel+bounces-74394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F78D3A05E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBE733036B86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EAB3382E4;
	Mon, 19 Jan 2026 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FBWP0VYQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8DD3382CD;
	Mon, 19 Jan 2026 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808714; cv=none; b=Bm9BW8FFX/MYeL0kPJGVDxe1MSzoUPZF8lDPUUilDNBb1faSg0EYXRPCgk6Z/GXdu63p0edanUjvP66vT0Rhdqa106f+bYhU9GDKBaQykC7qANsYTdpztiJY0/+B6gNJWXyAj4cLdgEsuuNxR4s3xrFDZOjYqrv2zoJr09/Ldqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808714; c=relaxed/simple;
	bh=eGIpcV2CF4B4EPe8pf5kT9W0/1cvA2La3RjDSjoqRvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIKDW480Ee7rpHj/eSZlBuhsPVm3Wm6rjb0/8RPw1P0SnMcG+TQ/0jQAHyWvg5SQEEOXlbTHCO4VTWrQlQgp5WCwwS18grO+2+Lewl18y6LiNFsBJtLuIQ+d49So5Tg1x1wE//cQTgilURzD12r6SPy8FvoI3RreXg9tMbEJpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FBWP0VYQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EwLvBSVddkr+9ZVi0JgsYBlKN7Q3Y/y3khbh4dCXlpY=; b=FBWP0VYQPAXqKzr3xA9yib5tTw
	PwMfBqXSTqnjiUkaON8Zyz6a+HmlSccZDbae5c1bteldyKpP/Z6t7Uv+IXUEp+0MD8VdtbHkjjb3a
	A7T7Ic3tTKXK7OBFSHy/cy+c50pBIVd548d/O8DDVi5w5KUmQyyFIpevEp7HEnkzwCEvfFRKm4f9X
	9qN7ITljhDd7W76Natla98IFqB66TqMChZOx2PUoXpQVVNwwBA7OYQF7a/7FPlsBz1nk2RsQzgNIx
	fIj6Vhmm9kSBlD2tNOa7xZhq/q57lgP5OOZw1Ip8eIJw792QYpVNzNVnuu+rHfyVDjn0QIegZuRuf
	60R9mDjA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjwm-00000001WEn-1mfS;
	Mon, 19 Jan 2026 07:45:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/14] iomap: share code between iomap_dio_bio_end_io and iomap_finish_ioend_direct
Date: Mon, 19 Jan 2026 08:44:16 +0100
Message-ID: <20260119074425.4005867-10-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119074425.4005867-1-hch@lst.de>
References: <20260119074425.4005867-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Refactor the two per-bio completion handlers to share common code using
a new helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/direct-io.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bb79519dec65..c1d5db85c8c7 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -211,16 +211,20 @@ static void iomap_dio_done(struct iomap_dio *dio)
 	iomap_dio_complete_work(&dio->aio.work);
 }
 
-void iomap_dio_bio_end_io(struct bio *bio)
+static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
 {
 	struct iomap_dio *dio = bio->bi_private;
 	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
 
-	if (bio->bi_status)
-		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
-
-	if (atomic_dec_and_test(&dio->ref))
+	if (atomic_dec_and_test(&dio->ref)) {
+		/*
+		 * Avoid another context switch for the completion when already
+		 * called from the ioend completion workqueue.
+		 */
+		if (inline_completion)
+			dio->flags &= ~IOMAP_DIO_COMP_WORK;
 		iomap_dio_done(dio);
+	}
 
 	if (should_dirty) {
 		bio_check_pages_dirty(bio);
@@ -229,33 +233,25 @@ void iomap_dio_bio_end_io(struct bio *bio)
 		bio_put(bio);
 	}
 }
+
+void iomap_dio_bio_end_io(struct bio *bio)
+{
+	struct iomap_dio *dio = bio->bi_private;
+
+	if (bio->bi_status)
+		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
+	__iomap_dio_bio_end_io(bio, false);
+}
 EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
 
 u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend)
 {
 	struct iomap_dio *dio = ioend->io_bio.bi_private;
-	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
 	u32 vec_count = ioend->io_bio.bi_vcnt;
 
 	if (ioend->io_error)
 		iomap_dio_set_error(dio, ioend->io_error);
-
-	if (atomic_dec_and_test(&dio->ref)) {
-		/*
-		 * Try to avoid another context switch for the completion given
-		 * that we are already called from the ioend completion
-		 * workqueue.
-		 */
-		dio->flags &= ~IOMAP_DIO_COMP_WORK;
-		iomap_dio_done(dio);
-	}
-
-	if (should_dirty) {
-		bio_check_pages_dirty(&ioend->io_bio);
-	} else {
-		bio_release_pages(&ioend->io_bio, false);
-		bio_put(&ioend->io_bio);
-	}
+	__iomap_dio_bio_end_io(&ioend->io_bio, true);
 
 	/*
 	 * Return the number of bvecs completed as even direct I/O completions
-- 
2.47.3


