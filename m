Return-Path: <linux-fsdevel+bounces-47778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21308AA5723
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44958164499
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD00E2D996E;
	Wed, 30 Apr 2025 21:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NS0OoDcv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BC62D92E8;
	Wed, 30 Apr 2025 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048160; cv=none; b=SL9F72IXOlXaAy7+Pba4yB7s7v2vbQauN/dzjGn6lar8ZaBUAcX+LS/qd5CnnjiB3uZRud9te0bvBL2QLcCK6FzKN4oPVg2aJT9Xbn98PgQo1uCsigJ0lZesH2gqZT9YISoA0i/AYHYTn+Ygfrx+NJ9uTN8NfDF+LNwW6E4OhXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048160; c=relaxed/simple;
	bh=kDYwOx/zVRboCqBkeSS8Pd+4TpHWVwhwgGPwjRcElMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWOBiIRLLxFIdvoGKACEK6RmslxoU+KxDl8y1dTvUsjA01i5mcgaCph3E0GR3Gu8YU0rg6ujCIkulHio0YLBNehsf3wfrF+Q3hAgJuu6u6s4my2QrCdItk4d/0PhX3+VHv9dwKIaQJwVKKHYuKh/2TSjKEYBjuB2NaK8wc5V8Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NS0OoDcv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZTYJCzf/NCrzhYP7OvRMpUnvV/HyquzulkAeAeeSF7w=; b=NS0OoDcvaoSt+EozRY5YwgENt6
	z6yyLWRWPgOk6SFDl3Vi/91rouBZmsQwudU6E9n7paFtaNh3zIKm4n54HGFRNV5+86bCZ6kYV2cGG
	msNm3xI2gEcwru+KrPEUEyADC4XnzRQoy3aticWx4tb439sweP8a1IKcn/FLz1xfyEig2XpN7YDF1
	e1rfSrJq2BHY+bG3qmnHtM7Pyt0F/a5qHNvzudr8wPTydAGW0gWBlL4A8RfHK+32dSmm461210KRZ
	/EV66XuDzfSzlsSHbyrs5MPhhuhE7MBRD3QMDWezlpcQYouTSWDopz2gIJqzmTieD3YmVR0ekquwb
	II6QN4ZQ==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEt3-0000000E2do-2yEr;
	Wed, 30 Apr 2025 21:22:38 +0000
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
Subject: [PATCH 13/19] dm-bufio: use bio_add_virt_nofail
Date: Wed, 30 Apr 2025 16:21:43 -0500
Message-ID: <20250430212159.2865803-14-hch@lst.de>
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-bufio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 9c8ed65cd87e..e82cd5dc83ce 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1362,7 +1362,7 @@ static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
 	ptr = (char *)b->data + offset;
 	len = n_sectors << SECTOR_SHIFT;
 
-	__bio_add_page(bio, virt_to_page(ptr), len, offset_in_page(ptr));
+	bio_add_virt_nofail(bio, ptr, len);
 
 	submit_bio(bio);
 }
-- 
2.47.2


