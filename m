Return-Path: <linux-fsdevel+bounces-65332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D950C01A39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 16:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14213B8501
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BDD328630;
	Thu, 23 Oct 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XTyGcvwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951C2319848;
	Thu, 23 Oct 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227774; cv=none; b=jTv3olZflq72basAKyU/c/vpYU57zJ5eFbhGLJTZaJr7qckmViAa7q/0gXY0JJJkHHB6I3Xi18DhzizcLmjPThXCG3ltn6Q7l4Ixk2WIQ3EUJgN2uJwcJLxv+4x1UgXUggryynZ+FW+BGOVEgJ1WGoq4RcMfjQmH3elLn7q15xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227774; c=relaxed/simple;
	bh=bExGS0E830iX0u8V2QOvPcpSL8LeCrf8DbBjs4ggJz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlkVUyCXTrHdWbPaXXcCgE4OaySRcTJ8SVQq/yoSX0L1djR9l742fZyl5TeL1WP4Vke5EuSRs0d+5QNV62imJcKz0XF+gWOtG5qul0CYwn1BNGwNNcplCZL9DokWzoJe4WJNaiDdVDcINf4CY7iTeKXxQYlEBGIAFqp8Oza709I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XTyGcvwq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pUm97qkbs6DLer0aeoRsJmDSBGw+qdiQMnpbKUsBn2k=; b=XTyGcvwqOjdxCQFAf3f5UuCgP4
	L6NPdXDtKzSg4hDCqzseEHaGj7dgkyboLokOTcZL845pd04f8RN5wcekcga0ihu5h3iKMBToAIR6u
	srBBnhVBW4FXEoiRgo24E7DgdMJg0yt27vF9yDyHX4Vsp5rtt4Bv1RzhVZigtBYVTTwzKyZdya+6S
	212/UpNW1nEBt9D2QhoPq+mc96Qf5UzdtJOiwnXf71Zi3y+Q+P2FZaNyPUmfXmdZ3n+081wo3I5Ld
	kAbUYJq4YwlwoHQZNNReEa5RbLSA6M2i3KYDqCmaDo0WuITF6P2uK+FiV1N0z806blFmallOo6/Z/
	WdtJ/MxQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBvnX-00000006Ucu-2ceR;
	Thu, 23 Oct 2025 13:56:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] FIXUP: iomap: aligning to larger than fs block size doesn't make sense
Date: Thu, 23 Oct 2025 15:55:43 +0200
Message-ID: <20251023135559.124072-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023135559.124072-1-hch@lst.de>
References: <20251023135559.124072-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

All of the VFS and helpers assume that the file system block size must
be larger or equal to the device block size.  So doing a max of both
doesn't really make much sense.  Siplify the code in iomap_dio_bio_iter
to do a simple if/else.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ce9cbd2bace0..8d094d6f5f3e 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -336,17 +336,19 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	int nr_pages, ret = 0;
 	u64 copied = 0;
 	size_t orig_count;
-	unsigned int alignment = bdev_logical_block_size(iomap->bdev);
+	unsigned int alignment;
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
 		return -EINVAL;
 
 	/*
-	 * Align to the larger one of bdev and fs block size, to meet the
-	 * alignment requirement of both layers.
+	 * File systems that write out of place and always allocate new blocks
+	 * need each bio to be block aligned as that's the unit of allocation.
 	 */
 	if (dio->flags & IOMAP_DIO_FSBLOCK_ALIGNED)
-		alignment = max(alignment, fs_block_size);
+		alignment = fs_block_size;
+	else
+		alignment = bdev_logical_block_size(iomap->bdev);
 
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		bio_opf |= REQ_OP_WRITE;
-- 
2.47.3


