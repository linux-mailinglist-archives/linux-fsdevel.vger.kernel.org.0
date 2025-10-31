Return-Path: <linux-fsdevel+bounces-66564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D3C242FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 10:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B425D4EAADE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42338329E7C;
	Fri, 31 Oct 2025 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NTbfp2cb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D603F2E092D;
	Fri, 31 Oct 2025 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903328; cv=none; b=Iln0mk4TZauBOlKl0Q0UAXGnR5ohOBZY5dofLec9/xyqG3piJURh6/ZNaVE4GLBt2x0/aqUIjgu0WgAxjlxFAFe5jGSNXhwBLthKYeKyTFhtt9sT/63KET6xEuzJaxpaCYW1lxXKxysXaAW0dLzdmN9/VwIPV8pPDOF3M34qO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903328; c=relaxed/simple;
	bh=cvipCw2+AlJ57NnMQhMYyhmLL9VjA0gIYpcYjquQoBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlOiBEAi98jCXLqR8ID+tp14W97NvzPnIIrd3//3aoUkut9E7h4K4aDvu2fjLxERqUJ5gO7S017nKUoe9lqVW1dvIZ3DNZCXVOiPxFgCp0nWMElQRPXV9fkXm0g78KQrIGVcbBtkQhrNGCCGzaUrzd6ld0SPrDTht9pzddN0yNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NTbfp2cb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=IzxoBLtZptFWlFdxYZIHYSOPY03LpnAZh+l14rPj8Jg=; b=NTbfp2cbP6O6sGXkbScnzjglXB
	pbAgTSoPb87GWLEFV0nQfOKC59NW54HS+r3/eQ/ax5kmxVKaUbcTW42n4B274bix1savWZfkxMKPr
	aAVq2K8VkvwCt4LhHKFmyVXopRpTSObAmN6UccBH0oq3w3U5vvUrjHH/9uNYlo7Y+6NOSk94LVf8g
	gUCxnM5safupGnaY11uSGylAdtFeTMKKbhGTS+JwJ4c1ofKolaDDqgcTSfqaHhvpARHWRlcL2moVO
	/j9BME6/32LA5URc26kmkCJI+g1mClPaQcBh4ZlyZBEG5sjv7FKz/Ef2OoszeH2Wwr3RisJXoINiK
	GWyHrqBg==;
Received: from [2001:4bb8:2dc:1001:a959:25cf:98e9:329b] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vElXW-00000005ook-3cUB;
	Fri, 31 Oct 2025 09:35:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: move blk-crypto-fallback to sit above the block layer
Date: Fri, 31 Oct 2025 10:34:30 +0100
Message-ID: <20251031093517.1603379-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

in the past we had various discussions that doing the blk-crypto fallback
below the block layer causes all kinds of problems due to very late
splitting and communicating up features.

This series turns that call chain upside down by requiring the caller to
call into blk-crypto using a new submit_bio wrapper instead so that only
hardware encryption bios are passed through the block layer as such.

While doings this I also noticed that the existing blk-crypto-fallback
code does various unprotected memory allocations which this converts to
mempools, or from loops of mempool allocations to the new safe batch
mempool allocator.

There might be future avenues for optimization by using high order
folio allocations that match the file systems preferred folio size,
but for that'd probably want a batch folio allocator first, in addition
to deferring it to avoid scope creep.

Diffstat:
 block/blk-core.c            |   10 -
 block/blk-crypto-fallback.c |  437 ++++++++++++++++++++------------------------
 block/blk-crypto-internal.h |   31 +--
 block/blk-crypto.c          |   65 ++----
 fs/buffer.c                 |    3 
 fs/crypto/bio.c             |   89 +++++---
 fs/ext4/page-io.c           |    3 
 fs/ext4/readpage.c          |    9 
 fs/f2fs/data.c              |    4 
 fs/f2fs/file.c              |    3 
 fs/iomap/direct-io.c        |    3 
 include/linux/blk-crypto.h  |   16 +
 include/linux/mempool.h     |    7 
 mm/mempool.c                |  173 ++++++++++++-----
 14 files changed, 464 insertions(+), 389 deletions(-)

