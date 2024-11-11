Return-Path: <linux-fsdevel+bounces-34220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2179C3E3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB605B2339B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 12:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EE119CC04;
	Mon, 11 Nov 2024 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UFTiOrI5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ADC19C56D;
	Mon, 11 Nov 2024 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327227; cv=none; b=FuJ2tuDNwkDRJTEdXt3+xUO69lFE3TJJ0Xhf1o5qn6kzQ/Zo6fKl20hNbNFtL7tM7CUHZRI5SPXRLJKtmpnCj+OkzFbGrnIqoEuIOUlJcbcFRPuilCnnTZlZcvGl84PtLyzhXMcWpDKsb6O7R10STUASYc+Srv//jy/+drbAU+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327227; c=relaxed/simple;
	bh=gBQVEUfuGWGDr5d4kA8rz0t0KWrkq1mOGEvyfZsnzaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfO9aXHUQjEeh+c9NA7q9r154W6m4pS+THHUx8iXhrBTomyRscggHOb1NJnA9xSYYfC/l0g95abCnCYdMG68RLGZnVbDG/k5nBpoqjURx+Qe4ZsijYPs/I9oCQ5zdPkX/KK86gr6csJIjzN3qEa1FwTJbqdvzFsCbeBpW7UX7Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UFTiOrI5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=3+AEn+zfjevbB39dEhh/UvtraX2Que2xQcTnsUzqyzA=; b=UFTiOrI5EumtXb8vf0W0uLLr6B
	0+DFxfc1l6rDQPSxNk+BnUlXkJshaX/Lab4P6WMC7/mCJ31UXiH0N3Ei0O82sPX+TRotItn2msn/i
	2U30tO9B99UFRCvuMWyhQuZ3okCrDymEnOfLlACxBjGHNMbJqgua4GuQQkcEAo9sEbr9hLqNgA7oR
	8P2VPGWrdMgpdHwetIqcL7IwPWm1AHtUf32iZawDdJi0olW5V/ImL5/2o4xWTYkcFOADJMVsE8sdt
	6VjvaVXIzX70EtygKPzoK0LI/SOwdpD2PDWxst1utBZV0sohBH4oPGL9GiSNPpKhBbnwlCve2Bfox
	djRRhTmA==;
Received: from 2a02-8389-2341-5b80-87d4-3858-08b4-a7a1.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:87d4:3858:8b4:a7a1] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tATId-0000000HYng-41Js;
	Mon, 11 Nov 2024 12:13:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] iomap: drop an obsolete comment in iomap_dio_bio_iter
Date: Mon, 11 Nov 2024 13:13:40 +0100
Message-ID: <20241111121340.1390540-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

No more zone append special casing in iomap for quite a while.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ed4764e3b8f0..b521eb15759e 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -383,11 +383,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 			goto out;
 	}
 
-	/*
-	 * Set the operation flags early so that bio_iov_iter_get_pages
-	 * can set up the page vector appropriately for a ZONE_APPEND
-	 * operation.
-	 */
 	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
 
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
-- 
2.45.2


