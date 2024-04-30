Return-Path: <linux-fsdevel+bounces-18208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44968B683D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127E41C2172E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6589BFC02;
	Tue, 30 Apr 2024 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhWYmLrl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4814DDDA;
	Tue, 30 Apr 2024 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447118; cv=none; b=EdYEu00XzH2ltfyO3bwza7JbDm7Zmk0kGAn3csbb9xEvHq/eIqxbavux8nNCYQ2O9UdLxdsO9eCxZrtOeVH76tAQ4VzY6x/39sr/mHGBSaChnjRb9VAurY4jDgAP64VZ5joHUIx72/bovFrMeRwO0+SsmP/HPp6pLS1V+b2bBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447118; c=relaxed/simple;
	bh=OE+6BcBWqdBR28p2ql6S6XK5gbn2kgnRE8ScEA18iVY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDThPZfjyrzsO+KXzIwnS96R5zPqFObPJVqRYiBA/m2L8/YDLHTsW+mTyPwhKBACPUCThuLvQ6z2qFO5pJeC4NX3gJ6OfbUabzDsJJurTB6tkiEK5KIox088GNt8qAC1ZgwvcqDGxvTN9jVDS6tRgmDLKD0PdzNTfKJAJT9iw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhWYmLrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F35EC116B1;
	Tue, 30 Apr 2024 03:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447118;
	bh=OE+6BcBWqdBR28p2ql6S6XK5gbn2kgnRE8ScEA18iVY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DhWYmLrlIlyL/46cfAgPazDXo5Eze6mCuW01bH09bmRjd8YJsfSFzNKPL/S52Sj6z
	 wfm1vxScSKKGA7eEfBgGOOxNtbwVCFb/qLAnNo4Y6h/vbCCmZXJ9MA4hKp/KrzQcu2
	 Qi/PBhTo5a2O/ZcrRZSTvVfZxnpevt0p5Sdrs21w8BqpxOhhlZdasj/g0XI55f34Xq
	 n6NEh7irQh2e0rIlXqtjHqiFa6QmZj56+HLJ3S2IQCIXqwZn19L8sP0IpNHMGRxw/f
	 5iNEi8UNTcFxqGhmA7bcf3Y/6D20na8Gnhbv/m0tRW9dzHkl7HicTm+2AO7ttEdBql
	 xSIT1ohaPhcOw==
Date: Mon, 29 Apr 2024 20:18:37 -0700
Subject: [PATCHSET v5.6 1/2] fs-verity: support merkle tree access by blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
 alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Message-ID: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
In-Reply-To: <20240430031134.GH360919@frogsfrogsfrogs>
References: <20240430031134.GH360919@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

I've split Andrey's fsverity patchset into two parts -- refactoring
fsverity to support per-block (instead of per-page) access to merkle
tree blocks, moving all filesystems to a per-superblock workqueue, and
enhancing iomap to support validating readahead with fsverity data.
This will hopefully address everything that Eric Biggers noted in his
review of the v5 patchset.

To eliminate the requirement of using a verified bitmap, I added to the
fsverity_blockbuf object the ability to pass around verified bits so
that the underlying implementation can remember if the fsverity common
code actually validated a block.

To support cleaning up stale/dead merkle trees and online repair, I've
added a couple of patches to export enough of the merkle tree geometry
to XFS so that it can erase remnants of previous attempts to enable
verity.  I've also augmented it to share with XFS the hash of a
completely zeroed data block so that we can elide writing merkle leaves
for sparse regions of a file.  This might be useful for enabling
fsverity on gold master disk images.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity-by-block
---
Commits in this patchset:
 * fs: add FS_XFLAG_VERITY for verity files
 * fsverity: pass tree_blocksize to end_enable_verity()
 * fsverity: convert verification to use byte instead of page offsets
 * fsverity: support block-based Merkle tree caching
 * fsverity: pass the merkle tree block level to fsverity_read_merkle_tree_block
 * fsverity: add per-sb workqueue for post read processing
 * fsverity: add tracepoints
 * fsverity: pass the new tree size and block size to ->begin_enable_verity
 * fsverity: expose merkle tree geometry to callers
 * fsverity: box up the write_merkle_tree_block parameters too
 * fsverity: pass the zero-hash value to the implementation
 * fsverity: report validation errors back to the filesystem
 * fsverity: pass super_block to fsverity_enqueue_verify_work
 * ext4: use a per-superblock fsverity workqueue
 * f2fs: use a per-superblock fsverity workqueue
 * btrfs: use a per-superblock fsverity workqueue
 * fsverity: remove system-wide workqueue
 * iomap: integrate fs-verity verification into iomap's read path
---
 Documentation/filesystems/fsverity.rst |    8 +
 MAINTAINERS                            |    1 
 fs/btrfs/super.c                       |   14 ++
 fs/btrfs/verity.c                      |   13 +-
 fs/buffer.c                            |    7 +
 fs/ext4/readpage.c                     |    4 -
 fs/ext4/super.c                        |   11 ++
 fs/ext4/verity.c                       |   13 +-
 fs/f2fs/compress.c                     |    3 
 fs/f2fs/data.c                         |    2 
 fs/f2fs/super.c                        |   11 ++
 fs/f2fs/verity.c                       |   13 +-
 fs/ioctl.c                             |   11 ++
 fs/iomap/buffered-io.c                 |  133 +++++++++++++++++-
 fs/super.c                             |    3 
 fs/verity/enable.c                     |   20 ++-
 fs/verity/fsverity_private.h           |   13 ++
 fs/verity/init.c                       |    2 
 fs/verity/open.c                       |   61 ++++++++
 fs/verity/read_metadata.c              |   66 ++++-----
 fs/verity/verify.c                     |  232 +++++++++++++++++++++++---------
 include/linux/fs.h                     |    2 
 include/linux/fsverity.h               |  166 ++++++++++++++++++++++-
 include/linux/iomap.h                  |    5 +
 include/trace/events/fsverity.h        |  162 ++++++++++++++++++++++
 include/uapi/linux/fs.h                |    1 
 26 files changed, 835 insertions(+), 142 deletions(-)
 create mode 100644 include/trace/events/fsverity.h


