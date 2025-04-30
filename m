Return-Path: <linux-fsdevel+bounces-47783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB7DAA574C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0407D503F8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9142DA11F;
	Wed, 30 Apr 2025 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qVPXnh3n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1B2D1933;
	Wed, 30 Apr 2025 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048177; cv=none; b=aIrQPVMdjJ+W68I5rIaz4L581/aDhu1Nk1+4uCH+lMHZYnKi1CasRevGOTz00HyAROw5vM6QRssvjlyuxY8cUYROod5mN4y2AK0wMDFvQI6DuWiCeYDUGbrgp2ogcOYNoc0DRspbvZIbp9v3H+FwQPxrkVS9yyCMzFI5QonFmyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048177; c=relaxed/simple;
	bh=4MSdSK68drach5d5ViWzyrbkW+nuGMgyx/gaD6bR8mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzgF9Mc6NdudCuhXMpsKx1tUKwRPWgFa3mOxppgWJUcrJ+M7TGVWglG+2JeSjPExajGWmHzU6WSNAfxeOyqvproZ2nhdPMsuqkgBR8EC1f40nIwbb50csApT4ODYF7S7mTv07GGOv+/wX59KcSPAf+kdjc8Ewusnhl7n2kzvmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qVPXnh3n; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NHhxO3wQrG8+HzurNRbsetmShFZ/Fx2USFtUoBxxpZY=; b=qVPXnh3nLUIywhqxsV8c0FTyKW
	CkBvJkyUVehofsbXnQBo58dDHJekYIpIHEUON7yIszqN+6JsTyhdlBbWyVyJ39by5/d2B6jaP311l
	TDLQpldeWu+dZFpartIglqzgOLzaz7Go8AOb2hkfYv2SzVU4EVZSm2aKLza6ivyLc3+S07r4VvPXc
	pME6zioBJxrOWFw0tt9LP8YV6acnpkHoYkSjy9hP99rLgm85+MUQlx9NUCnH0DGN/OB+mUwOdtOzQ
	ADfYfIqfOXuInGWgFOrKcHaJjmK6Dhd4tGt8/++FZy6I/r+OneoruLoRO8NrX31VER4z5ppc4+xAl
	Uk4LxItg==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEtK-0000000E2jO-28aU;
	Wed, 30 Apr 2025 21:22:55 +0000
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
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH 18/19] btrfs: use bdev_rw_virt in scrub_one_super
Date: Wed, 30 Apr 2025 16:21:48 -0500
Message-ID: <20250430212159.2865803-19-hch@lst.de>
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

Replace the code building a bio from a kernel direct map address and
submitting it synchronously with the bdev_rw_virt helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2c5edcee9450..7bdb2bc0a212 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2770,17 +2770,11 @@ static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
 			   struct page *page, u64 physical, u64 generation)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct bio_vec bvec;
-	struct bio bio;
 	struct btrfs_super_block *sb = page_address(page);
 	int ret;
 
-	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = physical >> SECTOR_SHIFT;
-	__bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
-	ret = submit_bio_wait(&bio);
-	bio_uninit(&bio);
-
+	ret = bdev_rw_virt(dev->bdev, physical >> SECTOR_SHIFT, sb,
+			BTRFS_SUPER_INFO_SIZE, REQ_OP_READ);
 	if (ret < 0)
 		return ret;
 	ret = btrfs_check_super_csum(fs_info, sb);
-- 
2.47.2


