Return-Path: <linux-fsdevel+bounces-71508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 10296CC6216
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 07:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 893FF30145CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 06:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5383F2D59E8;
	Wed, 17 Dec 2025 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qHjjCuDt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259DB2D323D;
	Wed, 17 Dec 2025 06:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765951672; cv=none; b=eXrvFherU+VUizVAJ+hDxThhD1RnwFhNWZWgyREBnTsLkvyT53ihtPPWvNGL3QkcdZ6JrYyi7NCdSHO6LkovMIO+XuCBtFkgN0nHhuW0/tjYJf2aqRmKivyR9AParjtG/IF6Tj+8jN24SGX6n/RTDBWWIvz+zOPrG1J3DvbKSec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765951672; c=relaxed/simple;
	bh=eExQzGfBj6psi3YL80CDqzX+OuS72Q8WjgOYf/om3sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMYbYirQE2LzCvLBWpt4urHmyzdPKkqyziOhvebAZJ9lVTcbcq5QkSwp/5ajQbLSFpcfAZUNGGzGGXclFWBvCDg73a3f/wG1ucSJLr9qEZp0bBIeIqkqa0SC/WioMKI7mWi2oQHEYEYcWR1152IUnKUL3lov4l4JvYemC+5ihPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qHjjCuDt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Q8fnJCAxIboHaGMCCiZzVJBJGBTeYABIzMowgl6Kolc=; b=qHjjCuDtl3/MhygSBvA7ZRm9ch
	aQBOEn26J0zj8Ns4hnON6hwEds2UICe7SgeRK6X7CEeqbf+umbHHnxjkr13ROVxL9+LQekeWtV72S
	MRmTGuvx7pXHT1LhsBWLc/XyapLs28C3Dd2txRUud8Lwt+ON3whCi8w14PytQLsOFWfWKHeOqxX14
	FpwSo+vjMxVKFKKptFSGslkkC1EhmpqBUnlG+3KW7cU/HsYhAKLSYblZ4s20eGPYfyq/Tec3J4yo2
	MgXh/p6qKp+9F7EuyhQhSY8l//b4Iypxc6FA8Ci4ApZGWoyFpRhobKgBN88oQ9SfQSufRZQJqgjFy
	C6l9CEtQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVkhO-00000006DBz-03eE;
	Wed, 17 Dec 2025 06:07:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: move blk-crypto-fallback to sit above the block layer v3
Date: Wed, 17 Dec 2025 07:06:43 +0100
Message-ID: <20251217060740.923397-1-hch@lst.de>
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

TODO:

 - what to pass to mempool_alloc bulk (patch)
 - bio_has_crypt_ctx wrapper??

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
 block/blk-crypto-fallback.c               |  428 ++++++++++++++----------------
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
 14 files changed, 369 insertions(+), 340 deletions(-)

