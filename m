Return-Path: <linux-fsdevel+bounces-72999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8804D07534
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 07:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4AB4300D2AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 06:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32A92C1589;
	Fri,  9 Jan 2026 06:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zflRt7hY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469629A9E9;
	Fri,  9 Jan 2026 06:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938900; cv=none; b=UirPsCMwVkGQ3s2zb4JGwTVYe9viSv2coIEKynhFp+UUTBrPlYwPMg49Gme9Hh+pF0FBEdAmuABtHvizNO3dZjzcELV16xBnHiTfEh55ejz1SKPIljN+BIMAXPituCFGAHFE+NyBz5F/RuytTOInj77/jBPKW/lmozv88TpiDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938900; c=relaxed/simple;
	bh=EFRKnT4+NhOr3G4up8WDZAyvqvg+mYrx32azDfi+rw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8eM0HCecP18Pw13JY7RroawWZjRu5jXRg3LFaDcj6KX28QM6hszpdGMVeLIu3NwlCQ9wmMxh3czzr86p1UbslsSp1mf5WcYOBuEv1EK/bneEBCgaLSodtf1ymBB5+YM1TYIi6kgna4CNcv1TlRTiiNPlPQNEb5U7aCAyY9oC6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zflRt7hY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KINHBlDOs7olyi+GMNg028DOxSURXS8BU2z7lku9syE=; b=zflRt7hY4arD5o+84U9679Fl+Z
	7MWjo0QZhHzZvvxOuT+8ER53kGe4CS+qv0SVoD1XiNEQ5yFJsxTQrHM5xNklzuxjCUxxf5VIkQa9M
	L85n63aghr+ngPjpyP3tYZkmMuEBiBSW3tx/Vh9ePJNJBhYCkrJw+Jx+r4LsIwlSmwqS+gBGhau+9
	6iRcwI+6JG77nadpUL4ebHtaTu2E61+y+Khdx9XIRg8HRiUJIc8salkPimRa+BKNqN6MXgkbEhBc0
	TCde8QFXKUrws89OD6Uc/NgmThnq62VtArI9kCDK4Vpb94zSwypn2RsjrLX4RPYJ4PjjuDg7yN46O
	kZ2tdGqg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve5fV-00000001WRx-3Ufx;
	Fri, 09 Jan 2026 06:08:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: move blk-crypto-fallback to sit above the block layer v5
Date: Fri,  9 Jan 2026 07:07:40 +0100
Message-ID: <20260109060813.2226714-1-hch@lst.de>
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

Jens and Eric: I guess despite the fscrypt patches, the block tree
would probably be the best fit.  Or do we need a separate branch?

Changes since v4:
 - fix page freeing in encryption error handling one again

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

