Return-Path: <linux-fsdevel+bounces-44552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A066A6A494
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74AF68A2B9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613E421D3F8;
	Thu, 20 Mar 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nQ4SLRp8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA521C9FE;
	Thu, 20 Mar 2025 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469223; cv=none; b=BHa+Tb3PuCOqOyktPFsR1yKLmABWZWhjwpvQpT6s2Wtts4Sa712ofhhaxnnsX/gLRz53M+WEwbdoUmxlQJjueXjr+2t/50WEkZlU2QVfvCvsYyOM1PR6FEnCQUgt+OtLiSifcn6BuWI/hJJXa7kVLAZHHWf4UJH8WTto/R0clBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469223; c=relaxed/simple;
	bh=Yv/QyXen/MVWoFbGC0/9RIHDrXtmkEkP7+bsyO2cfgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tf0EtnE6+aBcorHiWiUVb8eddS3AmQIYfZJ9OHJSTY0MttaIOlwfM6vd4a1x03hya+B+BLvbGntFQO7L4OCw4CngmVUUMf9novFOLfYP2OVIEbbPhItRQqVvto42ycyzPuH7JmEs+JCApTrUJyb1wMITNESfhUfwfYdnNBibTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nQ4SLRp8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WS4+PxUYUf19jfxnqS2EQlmOXbGsS87CgpVY0Jf14I8=; b=nQ4SLRp8pgRrgY0eqG6fpORerE
	+/jDoFDBF+u18IAKjQaTHK6XVtvFyLe2a5XNQbeuIISOdvQlFIqvg1CwaoEX/csVtXSQC5HBPk7oS
	STGsU2WwCKLjHs44liiXHF5/E5UbYirwWVT/Jx/4QZjt1rwGnikjNy9DagBCsX6J5DVH4b9qfVMmC
	fq0R2Fmj0sTVsvDRoSg0DjtIe9/6ilLHO6o9ezmLrNxodTVvbCtJkurNvtatLpcrH6cdKP+a6nTjb
	scyNfjsnYlQwI2bElpvGnXte1/kqfsFnuKUNThTJxM0dGQcriEUQfhXmsp6txniVcyfBvDqmSASR/
	HupGc0TQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvDqB-0000000BvGH-0d8w;
	Thu, 20 Mar 2025 11:13:35 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: leon@kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	joro@8bytes.org,
	brauner@kernel.org,
	hare@suse.de,
	willy@infradead.org,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [RFC 0/4] nvme-pci: breaking the 512 KiB max IO boundary
Date: Thu, 20 Mar 2025 04:13:24 -0700
Message-ID: <20250320111328.2841690-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Now that we have bs > ps for block device sector sizes on linux-next the next
eye sore is why our max sector size is stuck at 64k while we should be able to
go up to in theory to the max supported by the page cache. On x86_64 that's 2
MiB.

The reason we didn't jump to 2 MiB is because testing with a higher limit than
64k proved to have issues. While we've looked into them a glaring issue was
scatter list limitation on the NVMe PCI driver. While we could adopt scatter
list chaining, the work Christoph and Leon have been working on with the two
step DMA API seems to be the way to go since the scatter lists are tied to
PAGE_SIZE restrictions, and the scatter list chaining is just a mess.

So it begs the question, with the new two step DMA API, does the problem
get easier? The answer is yes, and for those that want to experiment this
will let you do just that.

With this we can enable 2 MiB LBA format on NVMe and we can issue single IOs
up to 8 MiB for both buffered IO and direct IO. The last two patches are not
really intended for upstream, but rather experimental code to let folks muck
around with large sector sizes.

Daniel Gomez has taken Leon Romanovsky's new two step DMA API [0] and
Christoph Hellwig's "Block and NMMe PCI use of new DMA mapping API" [1].
We then used this to apply on top the 64k sector size patches now merged on
linux-next and backported them to v6.14-rc5. The patches on this RFC
are the patches on top of all that so to demonstrate the minimal changes
needed to enable up to 8 MiB IOs on NVMe leveraging a 2 MiB max block
sector size on x86_64 after the two-step DMA API and the NVMe cleanup.

If you want a git tree to play with you can use our large-block-buffer-heads-2m
linux branch from kdevops.

[0] https://lore.kernel.org/all/20250302085717.GO53094@unreal/ 
[1] https://lore.kernel.org/all/cover.1730037261.git.leon@kernel.org/
[2] https://github.com/linux-kdevops/linux/tree/large-block-buffer-heads-2m

Luis Chamberlain (4):
  iomap: use BLK_MAX_BLOCK_SIZE for the iomap zero page
  blkdev: lift BLK_MAX_BLOCK_SIZE to page cache limit
  nvme-pci: bump segments to what the device can use
  nvme-pci: add quirk for qemu with bogus NOWS

 drivers/nvme/host/core.c |   2 +
 drivers/nvme/host/nvme.h |   5 ++
 drivers/nvme/host/pci.c  | 167 ++-------------------------------------
 fs/iomap/direct-io.c     |   2 +-
 include/linux/blkdev.h   |   7 +-
 5 files changed, 15 insertions(+), 168 deletions(-)

-- 
2.47.2


