Return-Path: <linux-fsdevel+bounces-74362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9060ED39E58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A401C30204AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 06:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C77526CE1E;
	Mon, 19 Jan 2026 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uv+zEQZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7960FF4FA;
	Mon, 19 Jan 2026 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768803784; cv=none; b=uEd2ZTCgAU8JGk12dIlWzfiKnKMxpepphRgEHFcU+PTNzrM99DaRtKoj6voOSAqdXtCc7ZNuPYsxArgNSKDZOjs2ikE9pyMFE1Qp6bq8ebLBu7cSpB6+kilvDRZzOP2lyxBSW6aQE9FgmhJqOZCAZs1JFesCWCUvlSpziJuq6os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768803784; c=relaxed/simple;
	bh=7ImVCdUFWJ5tfAQJGL2fAtn0fmRWFqdxtALAjyPT4gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3Vjh17H35jxubZUrLq73LUOLh0a46zpEEaRu/lFgJhoJwOtZAt6kCZiTVgdboBvgtGsZMqRzFnDzgJQIB6OegGrZmCe07mZujENVJ3BPwjf4Z2hyi/ITNtUM0GkBtudG4G0ry6j6YkmkUvrQcy0YNAAtR7EGIYEMeowYZwWIBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uv+zEQZW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=g1gUM1qUSn4H3JQ9fYis1PYTtD3a+GOXK7bkV07wamk=; b=uv+zEQZWbbt2YUP/gixE//7H64
	dNgrrLieQtPM6kJp1hnWdwgiX1QtJdSg3ftE7FT+d3dNKBOIvZ93Ajp7JzHjwDmfyz9zCya2vi1Nw
	rcaHQAgw4PcByMpAdw1NDFgWx1xCV0+Nvlv9OAspFHj+P0fhfqV7JvN1d3vuIELhDHl2TwijEucfw
	g2LsrRR7FqINItaLtBXxPcr10EtiBJewvDKhVUTsLiMBXyTx2QeY6sqC+bBGXvU8D6oXjx2KddHCz
	134IDuIXGsl8GIda/IcsASMmIwC94E7i9fBVw6GsNreGPgQdJOJaRX8KfmfdWoIdgPDUTgCoC+iTv
	PZu3zjwg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhifB-00000001Ona-0jyL;
	Mon, 19 Jan 2026 06:22:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: fsverity optimzations and speedups
Date: Mon, 19 Jan 2026 07:22:41 +0100
Message-ID: <20260119062250.3998674-1-hch@lst.de>
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

this series has a hodge podge of fsverity enhances that I looked into as
part of the review of the xfs fsverity support series.

The first three patches call fsverity code from VFS code instead of
requiring a lot of boilerplate in the file systems.  The first fixes a
bug in btrfs as part of that, as btrfs was missing a check.  An xfstests
test case for this will be sent separately.

Patch 4 removes the need to have a pointer to the fsverity_info in the
inode structure and uses a global resizable hash table instead.

Patch 5 passes down the struct file in the write path.

Patch 6 optimizes the fsvvrity read path by kicking off readahead for the
fsverity hashes from the data read submission context, which in my
simply testing showed huge benefits for sequential reads using dd.
I haven't been able to get fio to run on a preallocated fio file, but
I expect random read benefits would be significantly better than that
still.

Diffstat:
 fs/attr.c                    |   12 +++
 fs/btrfs/btrfs_inode.h       |    4 -
 fs/btrfs/file.c              |    6 -
 fs/btrfs/inode.c             |   13 ---
 fs/btrfs/verity.c            |   11 +--
 fs/ext4/ext4.h               |    4 -
 fs/ext4/file.c               |    4 -
 fs/ext4/inode.c              |    4 -
 fs/ext4/readpage.c           |    4 +
 fs/ext4/super.c              |    4 -
 fs/ext4/verity.c             |   34 ++++-----
 fs/f2fs/data.c               |    4 +
 fs/f2fs/f2fs.h               |    3 
 fs/f2fs/file.c               |    8 --
 fs/f2fs/inode.c              |    1 
 fs/f2fs/super.c              |    3 
 fs/f2fs/verity.c             |   34 ++++-----
 fs/inode.c                   |    9 ++
 fs/open.c                    |    8 +-
 fs/verity/enable.c           |   39 ++++++-----
 fs/verity/fsverity_private.h |   17 ++--
 fs/verity/open.c             |   90 ++++++++++++++-----------
 fs/verity/read_metadata.c    |   10 +-
 fs/verity/verify.c           |   98 +++++++++++++++++++--------
 include/linux/fsverity.h     |  152 +++++++++----------------------------------
 25 files changed, 262 insertions(+), 314 deletions(-)

