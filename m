Return-Path: <linux-fsdevel+bounces-75751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE03NuY3eml+4gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:23:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 909B6A5820
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02F94306F44C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F1A30FC35;
	Wed, 28 Jan 2026 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x0rS9/fz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE82417C6;
	Wed, 28 Jan 2026 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616927; cv=none; b=ew4+kVHmH9chAcrHf8fRmvgCKEthkEju9UFNvUGH1CTygK4KHfk5joFRn+8c41AvCG6shlS+HO/QJepzLKIcqVhcsorykGE2A2w9fTysYgiC7JjewKyST/aRC6Abpl07fZS+pvWj+tcWM9s/ge2er00pLxsfnqTDSxMmLLg7BeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616927; c=relaxed/simple;
	bh=Z9IlpsibwbBvhZo4mdX+K5yP0yoUy9h708PyAL/VTM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ntfKOuxAXMIfOPHFakFICTWzZHW4Vya4iJmuzKvAKb3iG49lMWf4nl1+PiJQOxVM0cmznWu1qwJm4lcAyoiEGhqO+b2gKoFzn3pOsfy4Gvr0j6MzO47ubAVmtHELdsJp3qfvCPnOuXamJzW5FXFNDQrhJLEkOjHmob/O0TBQc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x0rS9/fz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Ojr5fLPlE/+baP20jupUrQPThSrd5cjXvZXLOq42KGo=; b=x0rS9/fzby+q6Avzon4H8fwVZ7
	69Y8hTf1RfJ1sQOVIt2wsRMl61XpxhWafczEHifMxfb2AvgSGmVEeNScaVtXk9Fc712pmupzOSGyk
	jH+GVeTih5kBRPIu0HMuuo4Pbe1f42CC3mrPI8CNilqgTZwKMfiS6VTC4L3PGdfKztMDTyGBdr/sH
	1KluHOvoN7QFfUzqxNK3k3EgIbVzrhxKqHHdObU6wklmG9lLI9hhGVtr/zkTTIw0Qa3N0/QOMZ8eb
	DHaZGrOFsjYPazkp1dRxVwoM5ufojDSdoL66AUiwgB6VRWZmoSHE0CiiOJ5ApmNHI/GHHghArWCVd
	LjbXLCiA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl8CP-0000000GMy5-4264;
	Wed, 28 Jan 2026 16:15:22 +0000
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
Subject: support file system generated / verified integrity information v2
Date: Wed, 28 Jan 2026 17:14:55 +0100
Message-ID: <20260128161517.666412-1-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75751-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:mid,infradead.org:url,infradead.org:dkim]
X-Rspamd-Queue-Id: 909B6A5820
X-Rspamd-Action: no action

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
baseline maxes out the device quickly on my older enterprise SSD.

Anuj gupta also measured a large decrease in QD1 latency on an
Intel optane device for small I/O sizes, but also an increase for
very large ones.

The series is based on the for-7.0/block-stable-pages in Jens's tee.

Git tree:

    git://git.infradead.org/users/hch/misc.git iomap-pi

Gitweb:

    https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/iomap-pi

Changes since v1:
 - document usage of BI_ACT_*
 - return the action from fs_bio_integrity_alloc and use it in
   fs_bio_integrity_generation to be safe from misuse
 - use the newly added BIO_MAX_SIZE
 - rename bio_read_ops to xfs_bio_read_ops
 - fix commit message and comment typos

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
 fs/xfs/xfs_aops.c             |   49 ++++++++++++++-
 fs/xfs/xfs_iomap.c            |    9 +-
 include/linux/bio-integrity.h |   12 ++-
 include/linux/bio.h           |    2 
 include/linux/blk-integrity.h |   28 +++++++-
 include/linux/blkdev.h        |   34 ++++++++--
 include/linux/iomap.h         |   20 +++++-
 23 files changed, 465 insertions(+), 181 deletions(-)

