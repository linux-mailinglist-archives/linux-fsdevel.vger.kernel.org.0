Return-Path: <linux-fsdevel+bounces-73632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72AD1CEB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B2273020B34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9B537BE6B;
	Wed, 14 Jan 2026 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v7dsYq6c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC83624C8;
	Wed, 14 Jan 2026 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376572; cv=none; b=WnpM7dZJNlXBWrEzt5wTsmUqaU1c86hJzWR3V6daOf5js2IpjvDbcbwfqp/x0x+onZ+ztYSuyndvE72Qnb91bIvHFR+IkoiA7pnmVlm+7ZTgimd+fFcjF3MrGM/euenVBYSi0plLjAqzdJSLvpSvpFGCHEGRDU7vxHGYCplX+nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376572; c=relaxed/simple;
	bh=lFHOq5zcAUT9skn7UbYHank3JEDXUEbGSn5g4xs9uIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eccjgHJMQ2kb9D/Wp4zFZqs7AMO6Fy3pHiNxpkQM7FjDGXo9Ycd/LS67dJ/Po/vfJXIeqwSEsYj30HnZiCle98e6G67Xs+OpA7iJukoG4Q3S+1t7WUpjRFUumGshb7J4oHLu38GrxYTF0YwqmZ1LhxX7gMhtZ+Fxr1WQJc14HEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v7dsYq6c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8d/tggncu64cFV4CP2ADjx9YqThgLhoAl4ilAm0UBvs=; b=v7dsYq6cqY1ixSkTUc8PG2PANT
	DwnuDmKCzQxK4pn6Pq97MLMKVHCDsW3YINv3MvDw2NMYd0nDxkfZlSNNr1Bal94sQvLQcFB7lWw/X
	g/QVzqsqrSB0qiyzgObrAO3MecAPjQRqSGuGR1gbpXdIOnKAnziCwm3lB44Jg/3OkkZD/Bv/pdqAG
	tOGWMzVP57JYH6j3uV2DgcYaij0682r2yp5rdXCYWL9hnXSEIy6dsj4RWfxJNew4r/bp9F1uiMLew
	cbvTJUX/VLDgdJEpWLfZvL9Gtov1cWQPNcutOMADKh9gzVi7rPlL/HEp1iigoqvw3V/qCheb6rRGz
	xmpCXqZg==;
Received: from 85-127-106-146.dsl.dynamic.surfer.at ([85.127.106.146] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvWf-00000008DxP-07OR;
	Wed, 14 Jan 2026 07:42:47 +0000
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
Subject: [PATCH 10/14] iomap: free the bio before completing the dio
Date: Wed, 14 Jan 2026 08:41:08 +0100
Message-ID: <20260114074145.3396036-11-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114074145.3396036-1-hch@lst.de>
References: <20260114074145.3396036-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

There are good arguments for processing the user completions ASAP vs.
freeing resources ASAP, but freeing the bio first here removes potential
use after free hazards when checking flags, and will simplify the
upcoming bounce buffer support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bf59241a090b..6f7036e72b23 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -213,7 +213,13 @@ static void iomap_dio_done(struct iomap_dio *dio)
 static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
 {
 	struct iomap_dio *dio = bio->bi_private;
-	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
+
+	if (dio->flags & IOMAP_DIO_DIRTY) {
+		bio_check_pages_dirty(bio);
+	} else {
+		bio_release_pages(bio, false);
+		bio_put(bio);
+	}
 
 	if (atomic_dec_and_test(&dio->ref)) {
 		/*
@@ -224,13 +230,6 @@ static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
 			dio->flags &= ~IOMAP_DIO_COMP_WORK;
 		iomap_dio_done(dio);
 	}
-
-	if (should_dirty) {
-		bio_check_pages_dirty(bio);
-	} else {
-		bio_release_pages(bio, false);
-		bio_put(bio);
-	}
 }
 
 void iomap_dio_bio_end_io(struct bio *bio)
-- 
2.47.3


