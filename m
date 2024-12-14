Return-Path: <linux-fsdevel+bounces-37413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 583279F1C55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 04:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F2D7A0527
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 03:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2C51684A4;
	Sat, 14 Dec 2024 03:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jn+VzRT6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A2208A0;
	Sat, 14 Dec 2024 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734145861; cv=none; b=Mj4D/e3VauX5arVyQZ9DJ+29kdg3mnrCn/yap12OEgwbq0/701m6NeZmnvs5GfvsYYN982lQlPC51wjV9fWzSm73EfS1P75qNbGzKDjanVOLV9IJJyG5FmDirvxkYU8nA98+nPOjCVpJ56VYJMaAiR5+10cenGvd/E0TYuNWVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734145861; c=relaxed/simple;
	bh=l/RbuV7mG+Q8pAYXvShoEilABA680o9Y1/+f82fwIZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dmt1snhaup2Za6ZHDDMtazg6qNx3BH89+QJQXLRDXhYAbbI0xLb0bchoAEgxqRlCxRBFnmZsiX3mG+Ch1SwSQ4PlP8zqqw7HJXOkhlqTYH0lwED7V/zASZ28KK2r5jDeCyHlny9QM5YabV74zA+PZK+uemRWz00jF3QERYFxm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jn+VzRT6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=nVbdZFLburUKrMDxJT8VFegeQ4rw8dJVhDVUWKaEr00=; b=jn+VzRT6CVJfsvQPJRoW8mkloz
	GoZIpq7JSMgAM6DJmg02YZeZT4X6VBzvBiaADik7dCm/qFzpx3Y3HH1iDIjyN8cSZC5CEi1k5gjxc
	q+i72eyL65QnU8PUj4cofXYJZ2XwsGGDepXY5Q4vFrxwHW++dEgUclNB7IxTEkJrZWDiamgRa1SYc
	d1vycqPDazUd8/H+hOIIrndCmlzG+3kvq6LG3JVMfdUN6QHQLJpvEbeLdglqz/qBnOrzNrsP2Xvsy
	ZuByfAi2EHL26XH9FdtGWBjuewpDVKLys6UBzqDkVwqAB3Mt2HF2JiyEQ2x0ULx1qtrlod+yJwJDU
	HY9us9Ww==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMIYN-00000005c3V-37oA;
	Sat, 14 Dec 2024 03:10:51 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	hch@lst.de,
	hare@suse.de,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	kbusch@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [RFC v2 00/11] enable bs > ps for block devices
Date: Fri, 13 Dec 2024 19:10:38 -0800
Message-ID: <20241214031050.1337920-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Now that LBS is upstream on v6.12 and we have bs > ps for filesystems
this address support for up bs > ps block devices. The first RFC v1 was
posted [0] before the turkey massacre in the US. The changes on this v2
addrsess all the feedback from that series.

The changes on this v2:

  - Simplfy with folio_pos() as suggested by Matthew Wilcox
  - To address support to reduce the buffer head array of
    size MAX_BUF_PER_PAGE to avoid stack growth growth warnings
    on systems with large base page sizes such as Hexagon with 256 KiB
    base page sizes I've added the async batch helper bh_read_batch_async()
    and iterator support for block_read_full_folio().
  - Simplify the bdev_io_min() as suggested by Christoph Hellwig
  - Collect tags, and minor comment enhancements and remove new header
    inclusions where not actually needed

This still goes out as RFCs as I'm still not done with my testing. As part
of my test plan I'm including a baseline of ext4 as we're mucking around with
buffer heads and testing xfs alone won't help to ensure we don't regress
existing buffer head users. I'm also testing XFS with 32k sector size support
given part of this enablement is to allow filesystems to also increase their
support sector size.

Patches 2-4 are really the meat and bones behind these changes and careful
review is appreciated. I suspect a bit of bike shedding potential is in order
there as well for those patches.

If you'd like to help test this, this is available in the kdevops linux
branch large-block-buffer-heads-for-next [1]. It is based on v6.13-rc2, and
on that tree has a fix not yet merged on v6.13-rc2 which is required for LBS.
That fix is already being tested and planned for v6.13-rc3, I carry since
otherwise you wound't be able to mount any LBS filesystem with a filesystem
block size larger than 16k.

[0] https://lkml.kernel.org/r/20241113094727.1497722-1-mcgrof@kernel.org
[1] https://github.com/linux-kdevops/linux/tree/large-block-buffer-heads-for-next

Hannes Reinecke (3):
  fs/mpage: use blocks_per_folio instead of blocks_per_page
  fs/mpage: avoid negative shift for large blocksize
  block/bdev: enable large folio support for large logical block sizes

Luis Chamberlain (8):
  fs/buffer: move async batch read code into a helper
  fs/buffer: add a for_each_bh() for block_read_full_folio()
  fs/buffer: add iteration support for block_read_full_folio()
  fs/buffer: reduce stack usage on bh_read_iter()
  fs/buffer fs/mpage: remove large folio restriction
  block/bdev: lift block size restrictions and use common definition
  nvme: remove superfluous block size check
  bdev: use bdev_io_min() for statx block size

 block/bdev.c             |  13 +--
 drivers/nvme/host/core.c |  10 --
 fs/buffer.c              | 209 +++++++++++++++++++++++++++------------
 fs/mpage.c               |  47 +++++----
 include/linux/blkdev.h   |  11 ++-
 5 files changed, 187 insertions(+), 103 deletions(-)

-- 
2.43.0


