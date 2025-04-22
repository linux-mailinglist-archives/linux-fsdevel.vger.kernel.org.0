Return-Path: <linux-fsdevel+bounces-46957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB5A96E5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3553B95CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A1A2857EE;
	Tue, 22 Apr 2025 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wbo/YkAc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF227CB30;
	Tue, 22 Apr 2025 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331996; cv=none; b=Eijrp4V5c/+qByO67X3h7yiPbSvazASj6lv7ZMXm10vhMwxzYcpAC32UkCcv++cA5ISak6JV8RcUNufNJfGgD7N5VVnZvWua2CKKWUep8udB20mT//DNFMRvu//IDzk+r9VSFEW4CJr4QXk+d4exX72alK5sjgFGFVNsZPxpSYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331996; c=relaxed/simple;
	bh=Crj6FNVi7mDhiVzWMlIqnYV4VfaXwOklDJNvmzIXW3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdK39KQDHgdlMdSfhgPEqvT8SiKD2kXcBuBl5nkUMUX38JxV9udzQ6Dd+f0fMLPMAQQwKoZjxfBo15Fg6sd5qFuYk0DnC3J5q6eUr3xvB5x51BzuXhWd9oPMqPdHGAdR8SZWe0SuDaCIGD/qNowrxNyb7ZxikTAZSulvhDLiT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wbo/YkAc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=svFwjk5mDlegrlNjoyNVDlQrYp0eiPHyH4DQI4cVX3M=; b=Wbo/YkAcvVzWpPhyUQpQKOmA1G
	mTD7QdQKJ0YrfWElD2Zo+VU9LwlA9TtAUt/XiX2a3w+j5/y51x+SURVViniD+VH57mava+Vm4Ijxy
	pWwiixY+N13qjJcC0rnrUIhXLO61TJB+cyJuiVAxfVMWXOEHG6hdYk/KqwdiiBmXjetaVSXzNiWqe
	vcmoIh0ChZBTReSCu1zxNNPSApFNGbu+TsyA9NcLynok/WdekMyOjBr+HzkWuv1qAeshNBX23wcQU
	4ZaEVKrAXLVBbKFBkrbJy32z/o2QoqxtImBpPmfBHVMdyiAYifijDpzUezWhen0qpQ9iwm1yBQFvV
	kC5cyLGw==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Ea0-00000007U8i-03JY;
	Tue, 22 Apr 2025 14:26:32 +0000
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
Subject: add more bio helper
Date: Tue, 22 Apr 2025 16:26:01 +0200
Message-ID: <20250422142628.1553523-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series adds more block layer helpers to remove boilerplate code when
adding memory to a bio or to even do the entire synchronous I/O.

The main aim is to avoid having to convert to a struct page in the caller
when adding kernel direct mapping or vmalloc memory.

Diffstat:
 block/bio.c                   |   57 ++++++++++++++++++++++
 block/blk-map.c               |  108 ++++++++++++++++--------------------------
 drivers/block/pktcdvd.c       |    2 
 drivers/block/rnbd/rnbd-srv.c |    7 --
 drivers/block/ublk_drv.c      |    3 -
 drivers/block/virtio_blk.c    |    4 -
 drivers/md/bcache/super.c     |    3 -
 drivers/md/dm-bufio.c         |    2 
 drivers/md/dm-integrity.c     |   16 ++----
 drivers/nvme/host/core.c      |    2 
 drivers/scsi/scsi_ioctl.c     |    2 
 drivers/scsi/scsi_lib.c       |    3 -
 fs/btrfs/scrub.c              |   10 ---
 fs/gfs2/ops_fstype.c          |   24 +++------
 fs/hfsplus/wrapper.c          |   46 +++--------------
 fs/xfs/xfs_bio_io.c           |   30 ++++-------
 fs/xfs/xfs_buf.c              |   27 +++-------
 fs/zonefs/super.c             |   34 ++++---------
 include/linux/bio.h           |   39 ++++++++++++++-
 include/linux/blk-mq.h        |    4 -
 kernel/power/swap.c           |  103 +++++++++++++++++-----------------------
 21 files changed, 253 insertions(+), 273 deletions(-)

