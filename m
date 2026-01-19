Return-Path: <linux-fsdevel+bounces-74395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D504D3A060
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E28530399A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB98433858A;
	Mon, 19 Jan 2026 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="StbtpBDx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272423385A6;
	Mon, 19 Jan 2026 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808719; cv=none; b=O0MP7fUAer1jId/n7zEaQZtsLPK+hY2/koEE0Zn73fmMrIsSeCPCmzCPImi1dtgN3pegA5vMYof7YA9vVlPCwXyM0HsAfzlRD/ob3dRt3tZ2zIqhTTMq0V21/6Sc59+4h7r/Va3ej6KGp+P+xeyn0R6Prxcq0HeqC3i5ZGdytMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808719; c=relaxed/simple;
	bh=eCf4/sSGMVeyYviAFQ5CzvVWP30SgFqfdsALZk+sJhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdZDOf0KxiebdQ8fIEOLr/q9Z+DrSZQ4rA0WlUcH2MX0ZYN7osSiD+a9FHfkRHOYBwXnaQhUu43CTbzM005nqJia+L0PpdQgdLCGQ5KlUobSUmp0U8mML8VipjNFCocLDbybdXi7ixadizIfVoNJ0WtLqbsjtZckI5IDrxiq87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=StbtpBDx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MwKtfw/h/OH5EV1oCetmZ6aFafpEIQerhvaCkprW1Qw=; b=StbtpBDxuu+AvU6SYUU4afKfSQ
	Ah/rgo1tN2fntNUcg+ks7tnIC4lNK4nYIAKqgKjrJHGONN4hKAQ39ILq93uNW/o/uyIlj1Q0yMbTK
	cvCXu3YB7U6u2KS4KVgCN5zdwpZ9coNVvufbGhThrMfIXy0bcgoq7R1g8jUng0+CMtr3f45lX0cdZ
	E0z/4eNTgFMgdM8oZ/C4qTe2Kj0aATel/EbE4khOi3nU4+IO2poS5BvCX84wPivgsClaRyrHlmZds
	AQeR2VXmxsDlH4coZiRwG0b5nytjZeyOSq+QYaFtYNv9Sn71CYc4u0WYXLzVxS0HdRJflFi2k3IIp
	Dt4ctBig==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjwq-00000001WFN-1vuO;
	Mon, 19 Jan 2026 07:45:16 +0000
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
Date: Mon, 19 Jan 2026 08:44:17 +0100
Message-ID: <20260119074425.4005867-11-hch@lst.de>
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

There are good arguments for processing the user completions ASAP vs.
freeing resources ASAP, but freeing the bio first here removes potential
use after free hazards when checking flags, and will simplify the
upcoming bounce buffer support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c1d5db85c8c7..d4d52775ce25 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -214,7 +214,15 @@ static void iomap_dio_done(struct iomap_dio *dio)
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
+
+	/* Do not touch bio below, we just gave up our reference. */
 
 	if (atomic_dec_and_test(&dio->ref)) {
 		/*
@@ -225,13 +233,6 @@ static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
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


