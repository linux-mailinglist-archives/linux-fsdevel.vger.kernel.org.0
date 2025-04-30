Return-Path: <linux-fsdevel+bounces-47773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D74D0AA56F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E741B504779
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028CF2D8683;
	Wed, 30 Apr 2025 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aNc8KvNU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084CA2D110F;
	Wed, 30 Apr 2025 21:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048146; cv=none; b=OqIpqKRV5Wu3XFk8WRSHg/V3xneVPEnIcPSmtiv+PUFoQlFlj/zmYdRY6/JjvW2uhxxgVcBDenoqo3hKdtm8Jo0fGmitii2iK1xWs8Fj1E2a/inYQ+tOEKzXCN/n4AOxlu+hWXL3brIvCDeyG0CXBW/z7EgnmDPPWr5gknQDQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048146; c=relaxed/simple;
	bh=uL+BGQKI+sn+LgrFgbd7Kl5Y6Gz/UibZg1d25jUGdQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L85X9r2saeg+17fKNA9ERZFHoXsJsmg9om1aO2vBqkWCmS3LEGHYDiS6BI6sdypX2b3uD+S5Z70ChZpCDLZHvQCWWdq6/rlgc4d/5eiFVs7JrAe2ryxametzj9tujS7K+3ClFpnkd7aiQV3F5uMX5LnfuhIadqHZbUic63jDUvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aNc8KvNU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vMgZ4C1bKQgx5DFySXr3zeeqwMUuRYFSx6W6DnOMpK0=; b=aNc8KvNUYxCGNkJnpU1W8fnuYo
	iVnZ34zlQA5cbB9JVnGXCvn9KAIBmobkp4rVRZ33mvQ9M6US68nBHrfBefXGOK07/fCVw1XOIv49s
	zCPd5n4f99axHvXXDlhhzDSSaljjC3q7JVumd9npO+Nvv+wXfXfagvLN8vDnYJfG3zOr/nF7ZnKB3
	bFGVQL9Hdes1a7ztDFvVXNVCIyBF3KdoQbx1ZWqwpdCAjhQOI9JdmjUOiJY1OhqS3ncJ3Nzox+G+i
	vwj+N0fnIC00ZlKPvLSXuRvd7y4JRyz7TjCd3yqdkVOUR7spK4k7ya2mq9QcXNJlC0ml/bHy83y4b
	L0NC0bqQ==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEsp-0000000E2aD-3Gq1;
	Wed, 30 Apr 2025 21:22:24 +0000
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
Date: Wed, 30 Apr 2025 16:21:38 -0500
Message-ID: <20250430212159.2865803-9-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430212159.2865803-1-hch@lst.de>
References: <20250430212159.2865803-1-hch@lst.de>
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


