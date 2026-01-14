Return-Path: <linux-fsdevel+bounces-73622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA3ED1CE8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5592430178FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6560637BE62;
	Wed, 14 Jan 2026 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WFFnBPut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB6334E760;
	Wed, 14 Jan 2026 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376528; cv=none; b=JLLdmU+3sF0b6zOvZJWK4bG/i0Bq0GuZlqAZRxDqiTj51graqHWXrTvC5KI8vjg4lyYccJY273AdC3EVxBubYIIG6ruXKDtAdXPtxzAToWXDvceGDKnc+BdiYWePJ7Jpu6XDK25ehspIRNMorH7B5akvNFCx3lHa2Bvab0X8H2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376528; c=relaxed/simple;
	bh=GJ1oKmnDP37Jb9BXKyvzbmVhZbftS+PHr8QRwOZFqOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGOTTInld2CoCvlENcLQUsf0Cf0w0COhtxa3D9m45d4ZLBqjmULej7M17iYsZoMHIz9GWBclaKQp3WsUWFHsnVNKkYJZuCr3g8iYEnTkf+G76vLimUamnYaryz66Rj5q1ZWBwKs8qG5sBDqXlJ6zGuyhI/jLVf/vaKy6R75cvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WFFnBPut; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=szw3/B/ne+BABndo/Nl4eMPVvDooE6ItKnVO892TolQ=; b=WFFnBPutI/FhEKhnqaoVq7VNao
	K/+dOD0ZT3FzQsiBozAnZcBdr4DY/elIzCZy3FTp+JUQArMVAMwRD/BeUg3IYZ+zHluyPfkj5t27v
	VIYjLQmqrS+P77pCynze7oOytXfuLhfOssWFGaq1Sq7vs4On/SqMxsljCpQkuE2D1nCAbIkzDn8Gp
	ywOwXXSL4QI/WH9xOzgCijCG3mY/hMFKDUNbGnkA5QQJS4RO5QxUV1ubgm1b1SgpXZyEutRTm+AsE
	/J8wCDoAaOrcgIyC93/pipJ/f3MtiI/yltWcEptvpyWM6piQKwyFOTuNVrjfOkTAVigZD6nxOrHj/
	c4/8Ez/Q==;
Received: from 85-127-106-146.dsl.dynamic.surfer.at ([85.127.106.146] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvVm-00000008DlJ-33DA;
	Wed, 14 Jan 2026 07:41:51 +0000
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
Subject: bounce buffer direct I/O when stable pages are required
Date: Wed, 14 Jan 2026 08:40:58 +0100
Message-ID: <20260114074145.3396036-1-hch@lst.de>
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
which I have patches for that will sent as soon as we are done with
this series.

Diffstat:
 block/bio.c           |  323 ++++++++++++++++++++++++++++++--------------------
 block/blk.h           |   11 -
 fs/iomap/direct-io.c  |  189 +++++++++++++++--------------
 fs/iomap/ioend.c      |    8 +
 fs/xfs/xfs_aops.c     |    8 -
 fs/xfs/xfs_file.c     |   41 +++++-
 include/linux/bio.h   |   26 ++++
 include/linux/iomap.h |    9 +
 include/linux/uio.h   |    3 
 lib/iov_iter.c        |   98 +++++++++++++++
 10 files changed, 490 insertions(+), 226 deletions(-)

