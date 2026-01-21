Return-Path: <linux-fsdevel+bounces-74796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE5mJjl2cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:46:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8985243D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF0F74C5776
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462EF44B67E;
	Wed, 21 Jan 2026 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C45hwxXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F8428492;
	Wed, 21 Jan 2026 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977835; cv=none; b=krN5heXIPyC75+D4nR3Rm6veTdGP34wYCOlCZXL0MYCfu4fo7v4D7GcJk/8lHap4mqB/RnZO4Oz5/nqvWUmpZ1dEmLJq2EZIt/2+ccAkJWVsNAYHX/ngd3ZJHby4OPb6Wvo7MGoD6TuQZ690tdJbA5M8fCfkcCGWUrVsXUh5hBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977835; c=relaxed/simple;
	bh=YLkrbSCKD+G/S3ONCodsuC3JodKBpiXQfNm4R2boeYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M66yoG5TzN6bLGSL7B4w7KE18EFIFY+LbdGlZE3T4i+RZk8zljsthtcz+1Uu3QcA1JXaWr6MNf/jzeFaWH8pO387jYIOjoAQ2irNcc+RtYydtMB9x+I47d+3LYmsYd+SM3bBO/3rYusXZi90ytfoTWqJPME4kY5ct+OXjFmaDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C45hwxXp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=OOSZ5lxgFSCxw3vOeo0QATToTC6dGMgPEe8IAbyjeS4=; b=C45hwxXpyIHpfLmfrch4W+CjAD
	iBlgZ1r3Fsy5jBRqTWfl/SUWozYaN+3xzw0e/XkQ0azK4a2/OpJawzOq+unGsPEczju9gjLF8K2VQ
	oXrDyuQdiu2RxfqqJVh2sgSIal6eUz0db0OWbmDYJRlXdc7kr/QZZptjJ0JEkDVDPTjv0r0K4J1Lg
	8l2E09iqEfv1uPtPMDYfN/DiuYfwkt1oSH/xN8dlQK4dWgfFdiW4b3ajAmcDQesaXqRWe0r5K3Alh
	DpxDQDuKs2lDJ0u3Bc5KV9WZr2Ta7C748h3f3MeL/TIjLOMDSfmXeVcTP5H/ah3gcnwum2XUGKH9f
	/q+gz/MA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viRwP-00000004xX9-3C4s;
	Wed, 21 Jan 2026 06:43:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: support file system generated / verified integrity information
Date: Wed, 21 Jan 2026 07:43:08 +0100
Message-ID: <20260121064339.206019-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-74796-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,infradead.org:url,infradead.org:dkim,lst.de:mid]
X-Rspamd-Queue-Id: 3B8985243D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

this series adds support to generate and verify integrity information
(aka T10 PI) in the file system, instead of the automatic below the
covers support that is currently used.

There two reasons for this:

  a) to increase the protection enveloped.  Right now this is just a
     minor step from the bottom of the block layer to the file system,
     but it is required to support io_uring integrity data passthrough in
     the file system similar to the currently existing support for block
     devices, which will follow next.  It also allows the file system to
     directly see the integrity error and act upon in, e.g. when using
     RAID either integrated (as in btrfs) or by supporting reading
     redundant copies through the block layer.
  b) to make the PI processing more efficient.  This is primarily a
     concern for reads, where the block layer auto PI has to schedule a
     work item for each bio, and the file system them has to do it again
     for bounce buffering.  Additionally the current iomap post-I/O
     workqueue handling is a lot more efficient by supporting merging and
     avoiding workqueue scheduling storms.

The implementation is based on refactoring the existing block layer PI
code to be reusable for this use case, and then adding relatively small
wrappers for the file system use case.  These are then used in iomap
to implement the semantics, and wired up in XFS with a small amount of
glue code.

Compared to the baseline (iomap-bounce branch), this does not change
performance for writes, but increases read performance up to 15% for 4k
I/O, with the benefit decreasing with larger I/O sizes as even the
baseline maxes out the device quickly.  But even for larger I/O sizes,
the number of context switches decreases and cpu usage sees a minor
decrease.

The patches both require the recent integrity changes in the block tree
and the direct I/O bounce buffering series I previously sent out, so
you're probably better off just using the git tree instead of applying
the patches.

Git tree:

    git://git.infradead.org/users/hch/misc.git iomap-pi

Gitweb:

    https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/iomap-pi

Diffstat:
 block/Makefile                |    2 
 block/bio-integrity-auto.c    |   80 +++---------------------
 block/bio-integrity-fs.c      |   81 +++++++++++++++++++++++++
 block/bio-integrity.c         |   64 +++++++++++++++++++
 block/bio.c                   |   17 +++--
 block/blk-mq.c                |    6 +
 block/blk-settings.c          |   13 ----
 block/blk.h                   |    6 +
 block/t10-pi.c                |   12 +--
 drivers/nvdimm/btt.c          |    6 +
 fs/fuse/file.c                |    5 -
 fs/iomap/bio.c                |  135 ++++++++++++++++++++++++++++--------------
 fs/iomap/buffered-io.c        |    8 +-
 fs/iomap/direct-io.c          |   15 ++++
 fs/iomap/internal.h           |   14 ++++
 fs/iomap/ioend.c              |   28 +++++++-
 fs/xfs/xfs_aops.c             |   47 +++++++++++++-
 fs/xfs/xfs_iomap.c            |    9 +-
 include/linux/bio-integrity.h |   12 ++-
 include/linux/bio.h           |    2 
 include/linux/blk-integrity.h |   21 ++++--
 include/linux/blkdev.h        |   34 ++++++++--
 include/linux/iomap.h         |   20 +++++-
 23 files changed, 456 insertions(+), 181 deletions(-)

