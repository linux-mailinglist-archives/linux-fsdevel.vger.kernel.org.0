Return-Path: <linux-fsdevel+bounces-46968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69B5A96EAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3563D400CD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D77E28FFD3;
	Tue, 22 Apr 2025 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ns329I0M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9F8284B2F;
	Tue, 22 Apr 2025 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332038; cv=none; b=mda0LcUucL5rFmlPORzNNaVwyE0aYeu0q08neFD3q4bkzDpxoV3jfzXcPhHFPsh1XU9aE2orZ+osf5ZBBiVajvLjvhn8RpRyWIwuzYwjii4fxkO/2zla7i+7xVdDvdrDAChynrPZz28k5NDHGfmKP19pOWhWMJCFHOvn+Zvnbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332038; c=relaxed/simple;
	bh=Gi+lXYhha7aB31jRzzzLHjDm1uvuNr5R/XbzHwG6GvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeWlDDSSakD1L36NIqXr0xrksT24jh7UFX00mq2kwlfZszZKY9tYWY4xdi9voTbHfkGTmtqSaJaX0qDv28Qu2mTHpm5fPjKjJlJayyxIBqSKQj868M4e3m9fiKomqx+vtqDhcdynj4ILsavtbOVlmqBD+R8+XPN2AfH8OmcfRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ns329I0M; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wKCqJxt0nuXHfdjnfZsShjhuKaPavS479EnIaM+nRmg=; b=Ns329I0MoyNqPRIsK2BZcqC5Jp
	8N5Ur6l4lV+J34KFEAYFDAiF7T1afwbC9myT6hR8yioDh2w9RBwKAB0gXqdp5hCGit3NQO3lQ4MlC
	yOxZn+fvALEwPXS42Y31S7PDlmDUWrAvVVmN+5+EKVBZZU2JjsiyPUQMAKJwdQnL1Kjx96wEqxm5k
	1FbjmY//QaYU/jBgqWHogW26ssUE+YCoWBC57BwkEv/3grRs89XZdpjaqfILs/32qk3jkxkCVobkk
	D7Yu62LtNsWVfRh7Qm6oqs6BFOK13fE65s7PtBwu6qK8L3A9SRiBFNi+4WHKcz6pzESVqC6L9Q5T6
	3vOi23sA==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Eah-00000007UOe-3YAO;
	Tue, 22 Apr 2025 14:27:16 +0000
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
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 11/17] xfs: simplify xfs_buf_submit_bio
Date: Tue, 22 Apr 2025 16:26:12 +0200
Message-ID: <20250422142628.1553523-12-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250422142628.1553523-1-hch@lst.de>
References: <20250422142628.1553523-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
bio_add_virt_nofail helper implementing it and use bio_add_vmalloc
to insulate xfs from the details of adding vmalloc memory to a bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_buf.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 1a2b3f06fa71..042a738b7fda 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1339,37 +1339,26 @@ xfs_buf_submit_bio(
 
 	if (is_vmalloc_addr(bp->b_addr)) {
 		unsigned int	size = BBTOB(bp->b_length);
-		unsigned int	alloc_size = roundup(size, PAGE_SIZE);
 		void		*data = bp->b_addr;
+		unsigned int	added;
 
-		bio = bio_alloc(bp->b_target->bt_bdev, alloc_size >> PAGE_SHIFT,
-				xfs_buf_bio_op(bp), GFP_NOIO);
+		bio = bio_alloc(bp->b_target->bt_bdev,
+				howmany(size, PAGE_SIZE), xfs_buf_bio_op(bp),
+				GFP_NOIO);
 
 		do {
-			unsigned int	len = min(size, PAGE_SIZE);
-
-			ASSERT(offset_in_page(data) == 0);
-			__bio_add_page(bio, vmalloc_to_page(data), len, 0);
-			data += len;
-			size -= len;
+			added = bio_add_vmalloc(bio, data, size);
+			data += added;
+			size -= added;
 		} while (size);
-
-		flush_kernel_vmap_range(bp->b_addr, alloc_size);
 	} else {
 		/*
 		 * Single folio or slab allocation.  Must be contiguous and thus
 		 * only a single bvec is needed.
-		 *
-		 * This uses the page based bio add helper for now as that is
-		 * the lowest common denominator between folios and slab
-		 * allocations.  To be replaced with a better block layer
-		 * helper soon (hopefully).
 		 */
 		bio = bio_alloc(bp->b_target->bt_bdev, 1, xfs_buf_bio_op(bp),
 				GFP_NOIO);
-		__bio_add_page(bio, virt_to_page(bp->b_addr),
-				BBTOB(bp->b_length),
-				offset_in_page(bp->b_addr));
+		bio_add_virt_nofail(bio, bp->b_addr, BBTOB(bp->b_length));
 	}
 
 	bio->bi_private = bp;
-- 
2.47.2


