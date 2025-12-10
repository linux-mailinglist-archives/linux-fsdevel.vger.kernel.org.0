Return-Path: <linux-fsdevel+bounces-71056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AC5CB34CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 16:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E7A83101E8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 15:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E811318151;
	Wed, 10 Dec 2025 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VNlimyqZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C126738D;
	Wed, 10 Dec 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380230; cv=none; b=paY6cAeSgHaavkSA05dIN0OhQctMydiE9/w6DazXmGoNwablkIzuH78GleE97ndfbp1KfAvC4RRpayOVPkCsuV0Z4vZJJA3FZrYbsqFHG9gFOfAGuD0cOp8+ohalk3OiYHjrTekEmc9ocXl9N6QdkOrggPL/uD0SqmIReeSE81g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380230; c=relaxed/simple;
	bh=amcwwXQ5Dc69tTZHE7WTuJUNEDuMfLJwAAGxewrAiS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jbzt7016M1z5edW3b2MW1n1vjX7indxZ2Ylh5eEoJSKJK3QqS8lG6Q8+d3Ui+m35H/m9PNczFrAZCIPCNxqDMu5uXhm7E0JIgiVK+lvWZj0qslot+pQzPnxHRkutN+sUgC3IaWh/gsIbRRMa1yJ9q3pWnE8oH0NTqFN7ZLrXBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VNlimyqZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=lItwUDV96BZQRw3gIhWS+WYgL9SDWpyUQbRDIJHp+ZM=; b=VNlimyqZJcknRD/QwbHw5fgk6y
	qpWSALa5ABny23ST1Xd2ITbB5yPFsFG8A82gIvYjk0xiAjoXMOVlnYfBwEAktw1HV6Xd4NkxUzsMc
	ohVf63Nne9KsVEpwa7xa+QC0cJ5QOLlW/rrBYNUKV7MZrMf++fic8fsT6qOyYUr/AuNXKBGHoxM7U
	zyBxAk+uoOF28VYicG2mzpgjzYuVbyOgDR6RyOqENdLmcOn4l5x9nQOEe7ihvMHnQ49Q6WlYgsA9m
	3rEi79JJQ4JCilvej8CjUFnlwqVCSCDJs6Y0aNK1AnrjK1BiO+yEr6+JJ9LeTTtjYo0fV3T7SKuD5
	2De7MpcA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTM2d-0000000FZ1H-2kJN;
	Wed, 10 Dec 2025 15:23:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: move blk-crypto-fallback to sit above the block layer v2
Date: Wed, 10 Dec 2025 16:23:29 +0100
Message-ID: <20251210152343.3666103-1-hch@lst.de>
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
 block/blk-crypto-fallback.c               |  424 ++++++++++++++----------------
 block/blk-crypto-internal.h               |   30 --
 block/blk-crypto.c                        |   78 +----
 block/blk-map.c                           |    2 
 block/blk-merge.c                         |   19 -
 fs/btrfs/bio.c                            |    2 
 fs/buffer.c                               |    3 
 fs/crypto/bio.c                           |   91 +++---
 fs/ext4/page-io.c                         |    3 
 fs/ext4/readpage.c                        |    9 
 fs/f2fs/data.c                            |    4 
 fs/f2fs/file.c                            |    3 
 fs/iomap/direct-io.c                      |    3 
 fs/iomap/ioend.c                          |    2 
 fs/xfs/xfs_zone_gc.c                      |    2 
 include/linux/bio.h                       |    2 
 include/linux/blk-crypto.h                |   22 +
 include/linux/blkdev.h                    |    7 
 20 files changed, 367 insertions(+), 355 deletions(-)

