Return-Path: <linux-fsdevel+bounces-75424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNWdJo8Bd2mMaQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:54:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 189B9843EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 016C730027D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74159237180;
	Mon, 26 Jan 2026 05:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A1JvkzoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278D29CE9;
	Mon, 26 Jan 2026 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406858; cv=none; b=RX5hYl/LlQGrmdA/vl+2xKyRVps4bRd+P1Moq1U1L1v88v9xj+wFGp4JT30P2U4FdNx6vMmvpqI4YtXO+uWvK1qIXmvdOPH5TyT+yT30a1OixlMu5H+LmmdDA6nRki5n/2bnV8e1SjV1sN4++Io4UNURYmZUxOzfUwEdXKTZktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406858; c=relaxed/simple;
	bh=VyS1Vh/UcpixWSeTr8u8aTIsT1VL+92os2S3KJQ7OjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+ldLH7ZS6OEfatoX0LaMduUlNbVCfwfHLkGxvcyg0iP2l8vypir3cd0jQ2t3jxH+NkXmYpQbfZmBV5kiBG48evrIGbMy0t7dJ7yg+2aE8kBZJhmFBoR9VxVR9caQqCJKm7EZ2WnSK6ngfxKP+2+5zRY8QC6D2Oo8Mfog+wfHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A1JvkzoV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=p04uGP/MTX7AmZ6atyztOPX6j2smbwyWbkVxRfOzqiQ=; b=A1JvkzoV80drvsknn3Khw+noXT
	rsrPhH0Sr/SUwCOOu+mhU8JlMtnfxBfxKZyeq5rpKCgN/auSG/xJ1ez/G0Yx3Q995VcNYQoU9A7W3
	poiLbJWn9n16uAhupsfCbNjZ4CkxV7MfhVzZ2uHMm05vqPBJ5LZ7BtYRHnItvIEDhHfEmTqct6R2d
	z/YkQVOemAGzYk/iWHmKYwds8wuHj/H65Ki4zqo/5SoD4TE4P7GAFeam0SYUKbfSZcvW7ZF9RFjFV
	l/XX0lpNRefuQ44IEq+m7NRpJ4DtJhcdQEcDjTX2OZgI1rZdWMg0V9ZLrOz2Ec5BtVwd/JeKDq9vd
	1yxPTJMw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkFYB-0000000BxEQ-1xYI;
	Mon, 26 Jan 2026 05:54:11 +0000
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
Subject: bounce buffer direct I/O when stable pages are required v3
Date: Mon, 26 Jan 2026 06:53:31 +0100
Message-ID: <20260126055406.1421026-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75424-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 189B9843EA
X-Rspamd-Action: no action

Hi all,

[note to maintainers:  we're ready to merge I think, and Christian
already said he'd do on Friday.  If acceptable to everyone I'd like
to merge it through the block tree, or topic branch in it due to
pending work on top of this]

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

Changes since v2:
 - add a BIO_MAX_SIZE constant and use it
 - remove a pointless repeated page_folio call
 - fix a comment typo
 - add a new comment about copying to a pinned iter

Changes since v1:
 - spelling fixes
 - add more details to some commit messages
 - add a new code comment about freeing the bio early in the I/O
   completion handler

Diffstat:
 block/bio.c               |  332 ++++++++++++++++++++++++++++------------------
 block/blk-lib.c           |    9 -
 block/blk-merge.c         |    8 -
 block/blk.h               |   11 -
 fs/iomap/direct-io.c      |  191 ++++++++++++++------------
 fs/iomap/ioend.c          |    8 +
 fs/xfs/xfs_aops.c         |    8 -
 fs/xfs/xfs_file.c         |   41 +++++
 include/linux/bio.h       |   26 +++
 include/linux/blk_types.h |    3 
 include/linux/iomap.h     |    9 +
 include/linux/uio.h       |    3 
 lib/iov_iter.c            |   98 +++++++++++++
 13 files changed, 507 insertions(+), 240 deletions(-)

