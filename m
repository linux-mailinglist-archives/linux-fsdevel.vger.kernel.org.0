Return-Path: <linux-fsdevel+bounces-75435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL25MDECd2maaQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:57:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6372584507
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 219A5303E2E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955923815D;
	Mon, 26 Jan 2026 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y9wJqvg6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461C32222C5;
	Mon, 26 Jan 2026 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406908; cv=none; b=UOrBcSMs/U8Unhq9oadDhZL0qwB/poeYRRxff6zWZbgvUcGATCC6nWJ1FAUiP5a23QooXILEBKzrAgkx0BqsV4uLMMpFAjL62EfnPfP0DaXZ8zG1UtRb/ml/4MBCAv1zYWRWh20X7/G+k0XwirZ43Xw8Pynb6enZsYZUqWLfY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406908; c=relaxed/simple;
	bh=tVwBxkOiI28J37fbu19CPXltsR4LT5YN+Txrt/UHDcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g87WHfZp5ujbcYlk4YS1x0mO0piNVHhFzfwBQZd6ptcTSGVUGsK+RmVxA7v5wqi9Cyu7g8OQfDRABs2XrFApIZd/aL5px0Nt3LAAIItCLdCMTAOcPbNFiJ+uu3wb5SA7sP0vCQyOlFcW8BNQhhw0qVfhhVaLUb4ESaRCBTX2nYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y9wJqvg6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZZCvcfEKZxowPxRshGW26DrXak0LDj85FJdSqz9kUf4=; b=Y9wJqvg6kg9muUV7cCHoBHewcn
	l80Gmxs2fIPQVK3UWTF6PXA8X/ENLnhWzRIW4o8sUzUrIqx+MORfkrg9KmQ/hVvQgbt+rUytCwlWV
	t6L9KyLd7zRQyEQPbp3+37hl41jgsLHlx8fQOw+ASIEmH2qKu3RIYBVwrFA+Xs0Enm8/AiQ2+aIc/
	oiyE0O4X8N+AYopYrine1+6KMqSgj8FeK7qRKC8QXldksKwdP9c/PJyNTdu1L5xq+AQNbwaZaTUWc
	ab73m6zN94l+6kVqP4PAC2LKAvWJ4XTHrb2xtSaLDge7BxMwN9Ed75PhfC6THwTulfP7gBPa5sT5o
	7/cuovfg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkFZ3-0000000BxIO-3ILa;
	Mon, 26 Jan 2026 05:55:06 +0000
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
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 11/15] iomap: free the bio before completing the dio
Date: Mon, 26 Jan 2026 06:53:42 +0100
Message-ID: <20260126055406.1421026-12-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75435-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 6372584507
X-Rspamd-Action: no action

There are good arguments for processing the user completions ASAP vs.
freeing resources ASAP, but freeing the bio first here removes potential
use after free hazards when checking flags, and will simplify the
upcoming bounce buffer support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
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


