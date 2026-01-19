Return-Path: <linux-fsdevel+bounces-74385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAFFD3A040
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5376F3009F50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDCA337B8C;
	Mon, 19 Jan 2026 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oBuhYEY5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12F833710F;
	Mon, 19 Jan 2026 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808673; cv=none; b=U9qlgoxhdBG09Wip4Y0kQP7iHVw3PtjqblAj7oDoTRFLDmuW/2Ce8CQI9EYEjYvIj9GWQHx0oS37cibqEJneIk/APuyQ2vpGuHmrbyy3JHfdCSlHDXsUIcyYVI2+m7Y9Rt3GY7sB1cEAAvPdIIoyL1hG3z59aYeRk2trk/AbRkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808673; c=relaxed/simple;
	bh=l97McbaRZO3TQfukZUYzMAM6afrZCrKJrOB5BVWfk9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ExVSfACiKJWCaS5TXnvAWeHjXr1k2yJRvJHrcH2qUHzomXI57x360vut04udQErPY60nZpTYLrdEjODqHIC9VT/h8ccM42Oja38DMng1MZGQFj7MGKpIf+hHwc46lRkOdOfWIak3H9eHgaAvN/YF3/QOzuCVpPTRBVLfBo2LFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oBuhYEY5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0jMumst/DKmc/sQa4zpacgepgiHuibSYZ04TsJOr/m0=; b=oBuhYEY5K6CRaVdSIpWd2LVorD
	x7sLE2IecpZJ5K3Z1NeYP6rnQdQCPtd15oTVau4PRWC5yNFMhY9CGlC0txEY9Yb+WSL/c7tpycpze
	dRpegUdk7qwfN51thGgIPw8FnCU1bSikKEegJZ0Hp9PiiZLpVqHi1KiemSarLrrbm+meTxKl00w/G
	BgpdfHTy15CwfPrtVvJvMqmUF03NDKRwABqN6UXJOk9EUtKhouk0yfmkk3PeoGeAnXLd8teAXfIfp
	AQouDLV9JKX/eLHZSXtUjADpAE9Q72nFc84DQQ6hipLA9GPRQPRJ0IBefCtPdTM2kv4mZ4sIL/miY
	NAyOKtQA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjw6-00000001W8k-1Phr;
	Mon, 19 Jan 2026 07:44:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: bounce buffer direct I/O when stable pages are required v2
Date: Mon, 19 Jan 2026 08:44:07 +0100
Message-ID: <20260119074425.4005867-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series tries to address the problem that under I/O pages can be
modified during direct I/O, even when the device or file system require
stable pages during I/O to calculate checksums, parity or data
operations.  It does so by adding block layer helpers to bounce buffer
an iov_iter into a bio, then wires that up in iomap and ultimately
XFS.

The reason that the file system even needs to know about it, is because
reads need a user context to copy the data back, and the infrastructure
to defer ioends to a workqueue currently sits in XFS.  I'm going to look
into moving that into ioend and enabling it for other file systems.
Additionally btrfs already has it's own infrastructure for this, and
actually an urgent need to bounce buffer, so this should be useful there
and could be wire up easily.  In fact the idea comes from patches by
Qu that did this in btrfs.

This patch fixes all but one xfstests failures on T10 PI capable devices
(generic/095 seems to have issues with a mix of mmap and splice still,
I'm looking into that separate), and make qemu VMs running Windows,
or Linux with swap enabled fine on an XFS file on a device using PI.

Performance numbers on my (not exactly state of the art) NVMe PI test
setup:

  Sequential reads using io_uring, QD=16.
  Bandwidth and CPU usage (usr/sys):

  | size |        zero copy         |          bounce          |
  +------+--------------------------+--------------------------+
  |   4k | 1316MiB/s (12.65/55.40%) | 1081MiB/s (11.76/49.78%) |
  |  64K | 3370MiB/s ( 5.46/18.20%) | 3365MiB/s ( 4.47/15.68%) |
  |   1M | 3401MiB/s ( 0.76/23.05%) | 3400MiB/s ( 0.80/09.06%) |
  +------+--------------------------+--------------------------+

  Sequential writes using io_uring, QD=16.
  Bandwidth and CPU usage (usr/sys):

  | size |        zero copy         |          bounce          |
  +------+--------------------------+--------------------------+
  |   4k |  882MiB/s (11.83/33.88%) |  750MiB/s (10.53/34.08%) |
  |  64K | 2009MiB/s ( 7.33/15.80%) | 2007MiB/s ( 7.47/24.71%) |
  |   1M | 1992MiB/s ( 7.26/ 9.13%) | 1992MiB/s ( 9.21/19.11%) |
  +------+--------------------------+--------------------------+

Note that the 64k read numbers look really odd to me for the baseline
zero copy case, but are reproducible over many repeated runs.

The bounce read numbers should further improve when moving the PI
validation to the file system and removing the double context switch,
which I have patches for that will sent out soon.

Changes since v1:
 - spelling fixes
 - add more details to some commit messages
 - add a new code comment about freeing the bio early in the I/O
   completion handler

Diffstat:
 block/bio.c           |  323 ++++++++++++++++++++++++++++++--------------------
 block/blk.h           |   11 -
 fs/iomap/direct-io.c  |  191 ++++++++++++++++-------------
 fs/iomap/ioend.c      |    8 +
 fs/xfs/xfs_aops.c     |    8 -
 fs/xfs/xfs_file.c     |   41 +++++-
 include/linux/bio.h   |   26 ++++
 include/linux/iomap.h |    9 +
 include/linux/uio.h   |    3 
 lib/iov_iter.c        |   98 +++++++++++++++
 10 files changed, 492 insertions(+), 226 deletions(-)

