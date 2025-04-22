Return-Path: <linux-fsdevel+bounces-46964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBB6A96EA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429161B6148D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9EB28EA62;
	Tue, 22 Apr 2025 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qrjwXanp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EB128A1FF;
	Tue, 22 Apr 2025 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332022; cv=none; b=cmOfzqs+JNRdJ0Wcb3+zq45YiNTRzcvyw6FoFuHo7H1VmZDLl6kQENpy9U8vV6hEE75nm+/7U4rB50gx5ncYN5TXLSBjRVuHpYERi/U+i6MdhKCOxSOCdF/oEYkcmHQu8TKwMnXlfpNqYWZBzGLZxJJB6xoLQZsYno0Sx/tlfUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332022; c=relaxed/simple;
	bh=PMsEnreKHwfdPL4FRt/iLGCVrnD1TIOOviUqUKte7no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQ0uLRPkg+DmRBsFa4t0YT0r4EXUdnhTPpc/nXTAmeAhAWH4AZQTp4Q2Z99UBlyrZgdEyAAJV1jeY6kpMvlh37AEWHv++pvpaLi/g1/V6pl6vrGC9iGiKrES6wC5L9x2t85vpwaHaEWoMmrZM1hz2VA+ElK9dqMqN6s8nlHSSJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qrjwXanp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wf7/WPPB0WGDj+LKa5WLUpV60fY29Fwqh75w3ddGrK8=; b=qrjwXanpY/Dx8BTAErhjlST99G
	kUS8Umg6iLV2ePrwF7D14nRmiOGxB/hF1biOvTW23it95DX2EoGqaY/hg23pPxNdJ2YuhfAdry8aX
	7t8v19pXsk61j4hEXASUNBLk5HQ3qGa4D3SwTICvWbArvvYcMACYkSn1Ip09JzF5FhdBK+pSWLLVR
	v7w1Muk4KhOG2WJPefHLgeuN5kKI+kVUvmN2WmZdmxLiA1zbRZVjGn9o1gl9MeCd/vouQBiYHbXLw
	K+eWYHzs6ChBB45yKYqgnPxAELu/oTCXhS4z/zRieGXoAe5rkI5sDBal1+O3PpwceZr39Ughd1Puf
	MwhWlEHw==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7EaR-00000007UJ4-1sWF;
	Tue, 22 Apr 2025 14:27:00 +0000
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
Subject: [PATCH 07/17] bcache: use bio_add_virt_nofail
Date: Tue, 22 Apr 2025 16:26:08 +0200
Message-ID: <20250422142628.1553523-8-hch@lst.de>
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
bio_add_virt_nofail helper implementing it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 813b38aec3e4..c40db9c161c1 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -293,8 +293,7 @@ static void __write_super(struct cache_sb *sb, struct cache_sb_disk *out,
 
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_META;
 	bio->bi_iter.bi_sector	= SB_SECTOR;
-	__bio_add_page(bio, virt_to_page(out), SB_SIZE,
-			offset_in_page(out));
+	bio_add_virt_nofail(bio, out, SB_SIZE);
 
 	out->offset		= cpu_to_le64(sb->offset);
 
-- 
2.47.2


