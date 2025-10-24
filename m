Return-Path: <linux-fsdevel+bounces-65547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4979CC077D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32DE11C48018
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B1F344022;
	Fri, 24 Oct 2025 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sLJuSdEG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB6631A808
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325710; cv=none; b=S15pxlveiW2ROVWmo5sVbhLWwKJAUNsOxW7syeshWrF4ZkpDQ78tIQthwIPq2HPncjCtDdFKlUh58rH/lHEiWj/F4e6sd1jE6h2wpqYh5kt55r5Zo+Vx7r4NS/C/SF6YV/hq6JK9LMMzrn0k29LWP9B1LiV9LbxcVlDd8TfiRpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325710; c=relaxed/simple;
	bh=cqLugLT2vr42ztNvc7cW9cHrhVpkdy4lK/eJig7kk3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHSNxbVD993WRzMg8fj69rLaCaLlfLEIRHAEpC2p1FCXybSBmUc32TM7GRCTsHfWKT5F4TGG3tYNtcvO8M93kt+FZYLvq2eR9QkUFWlY53oWRBrB1py8Kbl3k3P63TpYfDeq1Cd2vANmMNViBSqYrHDZWBNBa6pELaK8deRo1gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sLJuSdEG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=+gUKrpFEhHQN2wsFSN0klr2a/MXcPaovKiDg5IBYFas=; b=sLJuSdEGMd8veXfDgue/9Nf/jn
	NRi5fexQCbdguJcfPkCD+dQTGGnLuvjEBOCl2ec7yt9tZJs9nPi/rNxJSCVhokf0V7oCQD1nnVjyu
	9V39V0Bv7aXDdEeoqI70xvZ0NbwaqvUOP2FcO+G/jMP4wL3L/wQnEKgtgxcLcube7UfVUrOW+Podd
	hSU7iNecRkAnmca1oUhm1LKOEdcGx1DdnFk9FHAnBARQgrUn7RInO8p7oPsEmuWdwICFb1GohGAaW
	bsO9OzucNQy1t8PP7fvSZoklUM6WFVuxXhcEQrG3B9FnyPuZpT50eX9LPm5reAUf2Zv6DbpPjQM6J
	T2mW3mJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCLH6-00000005zKj-00XS;
	Fri, 24 Oct 2025 17:08:24 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/10] Add and use folio_next_pos()
Date: Fri, 24 Oct 2025 18:08:08 +0100
Message-ID: <20251024170822.1427218-1-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's relatively common in filesystems to want to know the end of the
current folio we're looking at.  So common in fact that btrfs has its own
helper for that.  Lift that helper to filemap and use it everywhere that
I've noticed it could be used.  This actually fixes a long-standing bug
in ocfs2 on 32-bit systems with files larger than 2GiB.  Presumably this
is not a common configuration, but I've marked it for backport anyway.

The other filesystems are all fine; none of them have a bug, they're
just mildly inefficient.  I think this should all go in via Christian's
tree, ideally with acks from the various fs maintainers (cc'd on their
individual patches).

Matthew Wilcox (Oracle) (10):
  filemap: Add folio_next_pos()
  btrfs: Use folio_next_pos()
  buffer: Use folio_next_pos()
  ext4: Use folio_next_pos()
  f2fs: Use folio_next_pos()
  gfs2: Use folio_next_pos()
  iomap: Use folio_next_pos()
  netfs: Use folio_next_pos()
  xfs: Use folio_next_pos()
  mm: Use folio_next_pos()

 fs/btrfs/compression.h    |  4 ++--
 fs/btrfs/defrag.c         |  7 ++++---
 fs/btrfs/extent_io.c      | 16 ++++++++--------
 fs/btrfs/file.c           |  9 +++++----
 fs/btrfs/inode.c          | 11 ++++++-----
 fs/btrfs/misc.h           |  5 -----
 fs/btrfs/ordered-data.c   |  2 +-
 fs/btrfs/subpage.c        |  5 +++--
 fs/buffer.c               |  2 +-
 fs/ext4/inode.c           | 10 +++++-----
 fs/f2fs/compress.c        |  2 +-
 fs/gfs2/aops.c            |  3 +--
 fs/iomap/buffered-io.c    | 10 ++++------
 fs/netfs/buffered_write.c |  2 +-
 fs/netfs/misc.c           |  2 +-
 fs/ocfs2/alloc.c          |  2 +-
 fs/xfs/scrub/xfarray.c    |  2 +-
 fs/xfs/xfs_aops.c         |  2 +-
 include/linux/pagemap.h   | 11 +++++++++++
 mm/shmem.c                |  2 +-
 mm/truncate.c             |  2 +-
 21 files changed, 59 insertions(+), 52 deletions(-)

-- 
2.47.2


