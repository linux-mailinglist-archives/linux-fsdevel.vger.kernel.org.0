Return-Path: <linux-fsdevel+bounces-47766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2662FAA56CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CEE5042D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FC82D5CF0;
	Wed, 30 Apr 2025 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EbcXvme0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD3F2D0261;
	Wed, 30 Apr 2025 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048128; cv=none; b=O/1Ot/bqoMxcERxthcsZaO5IKbHfHYAR0jE6/CITfYwTV8j/klVqJgLwDkNx2lzv/U0LbnexhyPDQ9iyybyq3txQ//irMVe4H6yuGklIsHrWiGyBI+5yqeGH9bx2g+DlXIzbEAVEgfDYp+j9MQNTM7hK49aSEP9H/cZIHUQsuGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048128; c=relaxed/simple;
	bh=aSuIrbsU7iPfmUiQAkVCXhmL6aZYHSF3QTItzix92p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mS3NRfaSk5H/B/wXlC+fdyM781p0AREenX9TiDPwED7qDUXijwjqU+C/VZBOylImItuA2sfVmGH/QM2T3N7iKOsx9WEXyxtHo6SXIqRLzZctSNl7izHQUzZKTxUm9S7DIm+mV6hM9RKP/P5OyGMhZxkiZSiUdH9eXkMu7GVDP7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EbcXvme0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=j24qsqHxCKaWzZXCgXMBqVsWj3DT0iprynbePLhpEf8=; b=EbcXvme0E0cBsWY54dwvJZZqer
	uIZ0ovYKY7tb0g5mesAB2Aa53BsNGnyUpr0aIhFwDxVuZ7QEzSrwaB/QpKI2UmZRBwlzldilEkyZE
	/gsDx6ahG4xHt7dwOn0hsCwoB0wjk12SWjASHgCAhzz+jEdla3bAoVaBllqIGdKmLGe2xlVhivkHV
	Ybrv4J51tZ1WKFDny0HFc5MJuPRCC6iQACPMdU1mrvbibbspt0NZ93Hw0ygM6ryqYp2i2ZyKZI5jm
	P548WpXmX+694wfG3IGVmh0RoJ/M6pCAU5mD6ne7Bu67yQMrRCpQKA5GfD8c2V69LUv8UIMW6iNdI
	9jXs5dKQ==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEsT-0000000E2VP-3mpt;
	Wed, 30 Apr 2025 21:22:02 +0000
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
	linux-pm@vger.kernel.org
Subject: add more bio helpers v2
Date: Wed, 30 Apr 2025 16:21:30 -0500
Message-ID: <20250430212159.2865803-1-hch@lst.de>
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

Changes since v1:
 - typo fixes
 - improve commit messages and kerneldoc comments
 - move bio_add_virt_nofail out of line
 - make the number of bio_vecs calculation helper more generic
 - add another vmalloc helper for the common case

Diffstat:
 block/bio.c                   |  101 +++++++++++++++++++++++++++++++++++++++++
 block/blk-map.c               |   92 +++++++++----------------------------
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
 fs/btrfs/scrub.c              |   10 ----
 fs/gfs2/ops_fstype.c          |   24 +++------
 fs/hfsplus/wrapper.c          |   46 +++---------------
 fs/xfs/xfs_bio_io.c           |   30 ++++--------
 fs/xfs/xfs_buf.c              |   43 +++--------------
 fs/xfs/xfs_log.c              |   32 ++-----------
 fs/zonefs/super.c             |   34 ++++---------
 include/linux/bio.h           |   25 +++++++++-
 include/linux/blk-mq.h        |    4 -
 kernel/power/swap.c           |  103 ++++++++++++++++++------------------------
 22 files changed, 270 insertions(+), 318 deletions(-)

