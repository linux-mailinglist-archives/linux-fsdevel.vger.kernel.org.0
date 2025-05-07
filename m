Return-Path: <linux-fsdevel+bounces-48374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AFAAADE6E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F004C1CD8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FE0269830;
	Wed,  7 May 2025 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i7jRIHqs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A072580CE;
	Wed,  7 May 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619544; cv=none; b=DgP0CvakyCn+A0g5XBS9knUICSI6eZ0wSLS3OlxUPPRn+4Ithkd6jjlVeCQu3zbeoCXc6/MBXgIX/j5wPz1MN0RfyDBbaNoaDKgkEiZ92I8ZwlDN728ZkUqUpV4dnsv9FY1s7PRWNVqL534YAi5q2cmRum3EQ3i7/hqvRU2At9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619544; c=relaxed/simple;
	bh=LtXBRUPuKXCvrQCJzuviq7k/NwRQWMn9ZEy2/gHRtSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xqz9W3NubLz05An+4m+AASd5m/eTq8xqf33Mgc/qNWIlA/D9BLzuVSoX8gWNDuLlQh2h70Y+SuVEnF/Jhg9jiR4pDOL3n68N//e9qiKXD2RAuqVIbJ4zRtBUls9xYiHB2yFmTc2choD9+oG/ulYVBO95fOuxnOHkid6/A9YKoso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i7jRIHqs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=v/Mboo+M2hZh4JrgqAFccQLDjODq+hl95NoNxjdgzwY=; b=i7jRIHqslg8EFZNFHfD4vx7tbZ
	ypyV3dGY6vmJdmhcEveUQV5ubpPSsZn6Wh4+xWq7n8wK+LCjUcyCe+pTgagTqHgcNjZs8vZDCrI5g
	4CcDavcfr5/x2cjxxDF1Eu5KL3Ebq3GpB9julSoCX+1pAGI7Fi/mdxg9IQGu5xmYZYOnoAZmnfTri
	VgNABYR2la/kcARKM2FZz1RR2RBi1ZgiJPR5vqvno8o+VBkq0BpP2960PobX6WQoCv5PucVez3mpL
	yrnUFWIQKOaX73T+aLP/DQkfm5yhQHOkJATUGXnVGEcxU4ySY1UgZq5TIrEzhrnxZu9BYAEPOPIzG
	0C5LKIRg==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdWw-0000000FJGu-0KRa;
	Wed, 07 May 2025 12:05:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 16/19] xfs: simplify xfs_rw_bdev
Date: Wed,  7 May 2025 14:04:40 +0200
Message-ID: <20250507120451.4000627-17-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507120451.4000627-1-hch@lst.de>
References: <20250507120451.4000627-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Delegate to bdev_rw_virt when operating on non-vmalloc memory and use
bio_add_vmalloc_chunk to insulate xfs from the details of adding vmalloc
memory to a bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_bio_io.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/xfs/xfs_bio_io.c b/fs/xfs/xfs_bio_io.c
index fe21c76f75b8..2a736d10eafb 100644
--- a/fs/xfs/xfs_bio_io.c
+++ b/fs/xfs/xfs_bio_io.c
@@ -18,42 +18,36 @@ xfs_rw_bdev(
 	enum req_op		op)
 
 {
-	unsigned int		is_vmalloc = is_vmalloc_addr(data);
-	unsigned int		left = count;
+	unsigned int		done = 0, added;
 	int			error;
 	struct bio		*bio;
 
-	if (is_vmalloc && op == REQ_OP_WRITE)
-		flush_kernel_vmap_range(data, count);
+	op |= REQ_META | REQ_SYNC;
+	if (!is_vmalloc_addr(data))
+		return bdev_rw_virt(bdev, sector, data, count, op);
 
-	bio = bio_alloc(bdev, bio_max_vecs(left), op | REQ_META | REQ_SYNC,
-			GFP_KERNEL);
+	bio = bio_alloc(bdev, bio_max_vecs(count), op, GFP_KERNEL);
 	bio->bi_iter.bi_sector = sector;
 
 	do {
-		struct page	*page = kmem_to_page(data);
-		unsigned int	off = offset_in_page(data);
-		unsigned int	len = min_t(unsigned, left, PAGE_SIZE - off);
-
-		while (bio_add_page(bio, page, len, off) != len) {
+		added = bio_add_vmalloc_chunk(bio, data + done, count - done);
+		if (!added) {
 			struct bio	*prev = bio;
 
-			bio = bio_alloc(prev->bi_bdev, bio_max_vecs(left),
+			bio = bio_alloc(prev->bi_bdev,
+					bio_max_vecs(count - done),
 					prev->bi_opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = bio_end_sector(prev);
 			bio_chain(prev, bio);
-
 			submit_bio(prev);
 		}
-
-		data += len;
-		left -= len;
-	} while (left > 0);
+		done += added;
+	} while (done < count);
 
 	error = submit_bio_wait(bio);
 	bio_put(bio);
 
-	if (is_vmalloc && op == REQ_OP_READ)
+	if (op == REQ_OP_READ)
 		invalidate_kernel_vmap_range(data, count);
 	return error;
 }
-- 
2.47.2


