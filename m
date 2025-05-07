Return-Path: <linux-fsdevel+bounces-48358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B0EAADE0A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FEFF4C031E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3949B25A33E;
	Wed,  7 May 2025 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A9TWos8G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375931FF7B4;
	Wed,  7 May 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619497; cv=none; b=RsdeOCfsd4EoiVeRIEwvKvv+q50A4guYt9KvNtBnQzbOpUsONNWbLTKoUbcEVb2ypKeTES6caPo0y5ESGuth1hVyZSUOkPxoxY0d2c1RWe5nxnB1FaXMK2NMKHzS0dv4RTFX2KdX+C1HcgfEi3ZZQ1smH3kzgkBktEIAWMSZc+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619497; c=relaxed/simple;
	bh=S7C0i6guyQUxOmCmzpSvqnFdBd5hRF8ZNROLA+/7kxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JRFPh7arbif3yah10F5m9BZHqHASvXad6V40pn1Ls/3hESoAuO4lj5QNf9COL6944mnXn4otRhfgEzQQJEBGnvMiAhGOa0Nfp0g040VSpVB1bwjoqX99DsHmYaf4nuJlcQIpvcJWu48TXUXBubV92upi7et1tIltHO5bZoXkD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A9TWos8G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=taTa50vCOqf4qXYa/4iG8HTZJGZUASEUn4x1pmkgTG0=; b=A9TWos8GWPhEHAZOpDq5FqK2Ni
	wmHmUL7vq5tnXVsJAPlg2Fd3H9Lyc3vEC3ayp0PZ0pQcxwbZCyOUYrBt9eNGl/RAPXFBg0bRkKXi0
	iuL8IqEVadvqhfYRBsbbPGCTeb0Ab3N3iyFYBp9Ai/eJNUYqN0kDTYTzEQCEWgIeDf5khCiE+MA6R
	O52BIR//+QAbHZXgMEJ6gb6UG9lhMnh8/PT5xZXP13vn0u2Q5R4GnOhLAV3yZKjntb2cM18o8EksU
	Vv7KVXVQt+ANVEI5gW15AkwboYZR+caE7YC8AWsetDxrPZQQUzxg2rlSd+H1f3HZfmvhXoQYfoxMj
	wacMh52w==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdW9-0000000FJ3e-424a;
	Wed, 07 May 2025 12:04:54 +0000
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
Subject: add more bio helpers v3
Date: Wed,  7 May 2025 14:04:24 +0200
Message-ID: <20250507120451.4000627-1-hch@lst.de>
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

Changes since v2:
 - rebase on top of the latest block for-next branch to resolve
   conflicts with the bonuce buffering removal

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

