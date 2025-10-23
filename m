Return-Path: <linux-fsdevel+bounces-65333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C46C0196C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 15:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232A51A62383
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7262E328B51;
	Thu, 23 Oct 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bV42DQVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9B313E04;
	Thu, 23 Oct 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227778; cv=none; b=i709MMyvV0CdnZsAOMmGCXn0BIQC4/XYVMkQDTMcqv2rAwZqM5MLPP0P1fGnm3yRf6ziQ5DMG6a4fr7Mik7kCnp3XV7Dn6V13dHMjIik46fqTLAqSKq+X39N/uktzyfpYteW07LfV9pXmbYwNDvECB8OKFR90zm6rK8CU6jqokc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227778; c=relaxed/simple;
	bh=7tLFrtaiFsdirIuqu5btD3yWxVgtEwY3B2zKE1DB1Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBvo1S+Uxvxm5Xt93E3O0UaSPGvVPDajDREZC0pU+oBZ9c9pEeh3Y/uq/P5JiJB4GaF17XXbUMX7idQauSS0qxGtDpAs185V3/BiWVhH2tGf5JenkzF7BfAw2NNH/EHkM4uACUKMx3ZJ7gMNPT7O9QJXBC7FuNiArmicg4bCvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bV42DQVC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=s4HB2vrTzYaN7CIOsSVzK/auYDoH7r0LJUSvUsUP4nU=; b=bV42DQVCK6RE3RIp6rXlGZKsdt
	6VMgzwneeLgWruZFHBkwKf85v7P58zm/yKgb0ugLP27vVwgXmlU6T1cREp1EOu2YP6+XMJtxcE+cd
	2E224gdXSp1RLUt2DLlzG/1+h0AcI6H0CdMjJYewea09tGckq6g2FGpO9jMNU5LeblNw+tdl6Pd43
	qvgkTKLXMX51RXK/Ku6tLctMaYk9dVD7MGSLBctE5/rR3YijHqwKwpd+A/IxYb9s77pWrw7jn+gRJ
	wSibMzFDrEh+WpTJL55uk7FD37DoqDkZhQchS5wy0uwnQicOKyWn+wqDZz49df1CTVyhIQXdibnYf
	lxyttjsw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBvnc-00000006UdJ-2cCS;
	Thu, 23 Oct 2025 13:56:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] FIXUP: iomap: also apply IOMAP_DIO_FSBLOCK_ALIGNED to the iomap range
Date: Thu, 23 Oct 2025 15:55:44 +0200
Message-ID: <20251023135559.124072-4-hch@lst.de>
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

Not just the bios created by bio_iov_iter_get_pages need to be aligned
to the file system block size when IOMAP_DIO_FSBLOCK_ALIGNED is used,
but also the iomap mapped region.  Use the local alignment variable
for this check as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8d094d6f5f3e..13def8418659 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -338,9 +338,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	size_t orig_count;
 	unsigned int alignment;
 
-	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
-		return -EINVAL;
-
 	/*
 	 * File systems that write out of place and always allocate new blocks
 	 * need each bio to be block aligned as that's the unit of allocation.
@@ -350,6 +347,9 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	else
 		alignment = bdev_logical_block_size(iomap->bdev);
 
+	if ((pos | length) & (alignment - 1))
+		return -EINVAL;
+
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		bio_opf |= REQ_OP_WRITE;
 
-- 
2.47.3


