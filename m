Return-Path: <linux-fsdevel+bounces-72430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C85CF70EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1078230022CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B330AD1D;
	Tue,  6 Jan 2026 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1oamBACl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B88309F0D;
	Tue,  6 Jan 2026 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685020; cv=none; b=udn1zH4sjwYOWeqDHCJbK4MVcogL8v+gc/gT3QhlL/bm3ZsynPHebjydluEs2lyRNqQc7ZdZ+alLpKH4BSU0ZiHlccKXdzawTbTG7SUYu5y7ygKQsLmEq1PicBpKtE1htvK/LWer/ACn09aHvmyo6mbM1JOOv4l8t3Wthr3zlYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685020; c=relaxed/simple;
	bh=17J5ZkuvWCuqIESrM48lsbMJTWgNcKcV+sQJ67jShlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aoGBLeDGw2fTnbx6LmC4n9IX85I0YVSfjfSt6OFXiQlx8fJH0ZBrWoEgNRiANCwCvyuXvyjMiROHgu2AuYF9CEvuPG9PxxGH5pitb4egjWeN+4WZ1Wjd2qucASZMN6p0nSIJUey6Da05nHJAh96DDz4V5gAwE8OTBYDaW9H7MD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1oamBACl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+YLmZrDKZRJFOsSukLh6n1HXbKWBKCd++9qmBaKw0ZE=; b=1oamBAClPAuRK/OxsF2zhhrsZo
	/s84Yx68TE9yanO9Q2PU97jlSLooxmdtUuM7fTO+w2vC/ZY/OznMO7NiKGjuqzM9vAa3ij+xGpUWE
	E0OAdaMEjC8QIl1/KKrNu8dYad1O3vqLOh/ecvY4ZQiR83eBN0c0MCFUuNKmDHSHB7yyWxiW4Pv7M
	bv+z+sYiq/J1UpRXiBokJ3JUeY8qVgZJbLJlzhQP85AGZMxKsBCziX+gjGtq0UHlAxY2Mugfhqeh8
	TLaH60PKUDo43rbOR18sREytcV1xOwcMMsA2ki1nVyTp+c+GWjhsmyI5s0N/52Ph1/1ODOQm0TSJe
	eLjC5Rcw==;
Received: from [213.208.157.59] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd1cd-0000000CWdq-1CFN;
	Tue, 06 Jan 2026 07:36:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: move blk-crypto-fallback to sit above the block layer v4
Date: Tue,  6 Jan 2026 08:36:23 +0100
Message-ID: <20260106073651.1607371-1-hch@lst.de>
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

Changes since v3:
 - track the number of pages in each encrypted bio explicitly and drop
   nr_segs instead of the slightly more expensive but simpler recalculation
   for each encrypted bio

Changes since v2:
 - drop the block split refactoring that was broken
 - add a bio_crypt_ctx() helper
 - add a missing bio_endio in blk_crypto_fallback_bio_prep
 - fix page freeing in the error path of
   __blk_crypto_fallback_encrypt_bio
 - improve a few comment and commit messages

Changes since v1:
 - drop the mempool bulk allocator that was merged upstream
 - keep call bio_crypt_check_alignment for the hardware crypto case
 - rework the way bios are submitted earlier and reorder the series
   a bit to suit this
 - use struct initializers for struct fscrypt_zero_done in
   fscrypt_zeroout_range_inline_crypt
 - use cmpxchg to make the bi_status update in
   blk_crypto_fallback_encrypt_endio safe
 - rename the bio_set matching it's new purpose
 - remove usage of DECLARE_CRYPTO_WAIT()
 - use consistent GFP flags / scope
 - optimize data unit alignment checking
 - update Documentation/block/inline-encryption.rst for the new
   blk_crypto_submit_bio API
 - optimize alignment checking and ensure it still happens for
   hardware encryption
 - reorder the series a bit
 - improve various comments

Diffstat:
 Documentation/block/inline-encryption.rst |    6 
 block/blk-core.c                          |   10 
 block/blk-crypto-fallback.c               |  447 +++++++++++++++---------------
 block/blk-crypto-internal.h               |   30 --
 block/blk-crypto.c                        |   78 +----
 block/blk-merge.c                         |    9 
 fs/buffer.c                               |    3 
 fs/crypto/bio.c                           |   91 +++---
 fs/ext4/page-io.c                         |    3 
 fs/ext4/readpage.c                        |    9 
 fs/f2fs/data.c                            |    4 
 fs/f2fs/file.c                            |    3 
 fs/iomap/direct-io.c                      |    3 
 include/linux/blk-crypto.h                |   32 ++
 14 files changed, 386 insertions(+), 342 deletions(-)

