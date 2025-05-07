Return-Path: <linux-fsdevel+bounces-48366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF0DAADE37
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E294C7154
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D73925C80F;
	Wed,  7 May 2025 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="let+HiCq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A9259CAE;
	Wed,  7 May 2025 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619520; cv=none; b=iF5bL7iOcwNy9bBGYaf0vHsEpO6zGQ7HKZ2BbZoTvbpw6cwa9Ua65dWumQ8TJJ1R7010ZcxUIYRn6hlv0E+x+sEnQoIbnBr/Bgb4mWWop1F+TbebEcNOp0T3seHwOMS/IX/TEaUoCQC73MbcSO4m2gF2I1T4Oq+CBPQXl69SrLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619520; c=relaxed/simple;
	bh=uL+BGQKI+sn+LgrFgbd7Kl5Y6Gz/UibZg1d25jUGdQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9iDDkpzHlk7Zlmr+oi80pTDJUKBreATXvJDOzJSpkTEE5/gaWLvln/KuNRw1BVHo4WWN338xiQ7nu7Ww80mFsmm68GgX9OfKatt5PAkMGxQ/WjiHG3f/BJgZIrBxgfvGg8sF3TP0Na4AAkBqumuPiWwTJaV73UtKtfaRiH13pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=let+HiCq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vMgZ4C1bKQgx5DFySXr3zeeqwMUuRYFSx6W6DnOMpK0=; b=let+HiCqpJFGw8H57l05KMXx5E
	d3Kol/w+lM6KdIDyme6EdNDKj9dGASuAu+ooqCIsArG8lBn3i3GU9E9W/T/0sFuFTpzUQq0N0MBgs
	/TZPcaR6oCtKSI77bT9tj9Y68zSb992MfDr5er65Aig3vpuzgew3/kgfHSWcU5s6WY1R3pnpO00K1
	aEeLg0TlLB0CSkcquTO2/8iwbhUJ014BdWn0aNwlO0zsa0viZHKVboK2F1B6VohmCQdqvZRLrgJIr
	CmJp4LQaZNNB8OuM10MyywshNvQKcq7qCjqOolwCaE8muGmcPTKgFvBnDfb0SG7OCuJ6qo7C2peja
	oIRzMGJA==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdWY-0000000FJ8u-1kss;
	Wed, 07 May 2025 12:05:18 +0000
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
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 08/19] bcache: use bio_add_virt_nofail
Date: Wed,  7 May 2025 14:04:32 +0200
Message-ID: <20250507120451.4000627-9-hch@lst.de>
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

Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
bio_add_virt_nofail helper implementing it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Coly Li <colyli@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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


