Return-Path: <linux-fsdevel+bounces-77935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBLJDEVUnGmSEAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:21:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BBA176B47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EB2F302FFDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62851C5D57;
	Mon, 23 Feb 2026 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="44FgDVOn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749A1C84D7;
	Mon, 23 Feb 2026 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852840; cv=none; b=cU9oVo/Bf3yO2SIr0B9f1Cf6ZnECPuiSaWMRNzBk1wx/m8jH/gLbtMumylNu/FUuQwLa3lJGHWvGB0Tjkjtd3OZsAlxgb7gOJ69svQSUGiXZVDODI6pPDdUgFUFWWSj6NJn15Ha1bXc1YRobBEOv8RAoFk6qnyu6gpUBIOjwekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852840; c=relaxed/simple;
	bh=wiZjs4v8gJ9qb+ySXKyqn1kStfxgQlvWUlJKcikBJNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ufhAEZvAHOFC0kOa2Jo8ZyGc46m5r7iquYmxFPsB4rBuXoWTevNNH4Y1vUgQBqr+9ONnJRd/MuLCuimf1qLNDAtfO3juF8ho8zuuSigHYmMXrVh5lvqNJuFlRsTiii2vPSuOXEAzuhTOF73KOI/U0ym3qLQWTXlRicVVg49EBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=44FgDVOn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9LEW1BEDa8UyoT689FSHYJ1pNzmSIggfa/UKGjrsmls=; b=44FgDVOnLwyLQidGnNJunPPqsc
	p+x65Ofo3DMcuxf/MOe7ZM/3YO2R+43dwBaWoJgceRT4PNua/Ro4YV6cCwFZEOxkPkirvaQ6VK/SB
	V4I3D+K6OQXGjejUMSJpH5tKUhEWAb6tguIHIK0MtMbmk7oxkeI6PtGwFthTws/xMuO3Ceuv/pvJi
	dBvzVRgqSxgvIF7Dkn52OVqOA2jwhmcgPu9ubIFSKhXFTv7tS7MH+nADbHYIuIR82xbrcC0WPTIaU
	4FJvUf5OXBpwDwvMqQ1BCR34udi1Qv+OJ2E7ExbMZx8a82QLSm6my3nxcl402/lmmU8z3ZwTCZnHK
	NT7bj+8Q==;
Received: from [94.156.175.41] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuVrW-00000000Ls3-2SRc;
	Mon, 23 Feb 2026 13:20:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: support file system generated / verified integrity information v4
Date: Mon, 23 Feb 2026 05:20:00 -0800
Message-ID: <20260223132021.292832-1-hch@lst.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-77935-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,infradead.org:url,infradead.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10BBA176B47
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

Anuj Gupta also measured a large decrease in QD1 latency on an Intel
Optane device for small I/O sizes, but also an increase for very large
ones.

Note that the upcoming XFS fsverity support also depends on some
infrastructure in this series.

Git tree:

    git://git.infradead.org/users/hch/misc.git iomap-pi

Gitweb:

    https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/iomap-pi

Changes since v3:
 - fix the mess than the ntfs3 tree cause in 6.19
 - rebase to 7.0-rc1

Changes since v2:
 - rebased to current linus tree
 - use folio->mapping instead of file->f_mapping to support the upcoming
   fsverity use case
 - rename and slightly refactor the xfs iomap read ops to better addres
   that this will be used by fsverity as well.

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
 fs/ntfs3/inode.c              |   57 +----------------
 fs/xfs/xfs_aops.c             |   47 +++++++++++++-
 fs/xfs/xfs_iomap.c            |    9 +-
 include/linux/bio-integrity.h |   12 ++-
 include/linux/bio.h           |    2 
 include/linux/blk-integrity.h |   28 +++++++-
 include/linux/blkdev.h        |   34 ++++++++--
 include/linux/iomap.h         |   20 +++++-
 24 files changed, 469 insertions(+), 232 deletions(-)

