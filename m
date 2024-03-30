Return-Path: <linux-fsdevel+bounces-15701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69D889281A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B23C281B73
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F232710E9;
	Sat, 30 Mar 2024 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGYrsH9e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF0197;
	Sat, 30 Mar 2024 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758745; cv=none; b=PDTHVA/Blj0p0NLyJ0xgCQgKrYAoMpRO6vvCHUxvzs7sTp3b3oJ+yQJX4lm0XNomIKSH6C4T59i6ipUwzC8Hcn/Z5ubf33hZad04J0MMZcLIakzZcr1FFJPhfPCZMBxJDak5t3HOowLwFAfIzEqOUB+Lj9689R5h3mzf/faJP10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758745; c=relaxed/simple;
	bh=bxONVS8NbkPuJsLXWv4ZoXDAuvOvbkbdjSsXZ/RA1rs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfx7tZqqEPkpPsXN+KIfqOn8shkKlLpOU91t7+rtzO68yfabb2yhQJNe3O2NWOtPryAqq8CgYGy8o65yadvmr1yL2LUz4evwPcrsa2VKsedxR0iXsDakwbYZrUTl+SlfjD+6Wg6DWdCefqJvvD5B4tx8JKWWsMxTCk6Gne1mkYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGYrsH9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8526C433C7;
	Sat, 30 Mar 2024 00:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758745;
	bh=bxONVS8NbkPuJsLXWv4ZoXDAuvOvbkbdjSsXZ/RA1rs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OGYrsH9ezlssotjg3+bCpyYJIQmLIq8XrrEtLm6TJMTVweE5XdrsNicluM1EW91t4
	 otJcDczf5dWnIL+ynlC+dRE56T5rkyhkpw8kceyECxKQztehf0wKhI1AYKwdgJJBI+
	 q8AY+CXAfnp59nLh260USMovnA2050oTLc2VcJD42lqTqLsgzQzuKo+trN/KcK8QnX
	 Yy4TAzpnueazQpI57hiPjvxsfGPudjyBb7CbjRn/DOZy7Em31NaOxk50msS5arQwxp
	 +CQIQQ2hMf1nOOD2hXq2QTfeXB8sXWZf3w3uapwlftTyhcuMTXSRZv9kTOKPIEu16o
	 qfb8LwVLsLqXw==
Date: Fri, 29 Mar 2024 17:32:24 -0700
Subject: [PATCHSET v5.5 1/2] fs-verity: support merkle tree access by blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Message-ID: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
In-Reply-To: <20240330003039.GT6390@frogsfrogsfrogs>
References: <20240330003039.GT6390@frogsfrogsfrogs>
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
 * fsverity: support block-based Merkle tree caching
 * fsverity: add per-sb workqueue for post read processing
 * fsverity: add tracepoints
 * fsverity: send the level of the merkle tree block to ->read_merkle_tree_block
 * fsverity: pass the new tree size and block size to ->begin_enable_verity
 * fsverity: expose merkle tree geometry to callers
 * fsverity: box up the write_merkle_tree_block parameters too
 * fsverity: pass the zero-hash value to the implementation
 * fsverity: report validation errors back to the filesystem
 * fsverity: remove system-wide workqueue
 * iomap: integrate fs-verity verification into iomap's read path
---
 Documentation/filesystems/fsverity.rst |    8 +
 MAINTAINERS                            |    1 
 fs/btrfs/super.c                       |    6 +
 fs/btrfs/verity.c                      |   13 +-
 fs/buffer.c                            |    7 +
 fs/ext4/readpage.c                     |    5 +
 fs/ext4/super.c                        |    3 
 fs/ext4/verity.c                       |   13 +-
 fs/f2fs/compress.c                     |    3 
 fs/f2fs/data.c                         |    2 
 fs/f2fs/super.c                        |    3 
 fs/f2fs/verity.c                       |   13 +-
 fs/ioctl.c                             |   11 ++
 fs/iomap/buffered-io.c                 |  128 +++++++++++++++++-
 fs/super.c                             |    7 +
 fs/verity/enable.c                     |   20 ++-
 fs/verity/fsverity_private.h           |   41 ++++++
 fs/verity/init.c                       |    2 
 fs/verity/open.c                       |   40 +++++-
 fs/verity/read_metadata.c              |   63 ++++-----
 fs/verity/verify.c                     |  227 +++++++++++++++++++++++---------
 include/linux/fs.h                     |    2 
 include/linux/fsverity.h               |  159 +++++++++++++++++++++-
 include/linux/iomap.h                  |    4 +
 include/trace/events/fsverity.h        |  142 ++++++++++++++++++++
 include/uapi/linux/fs.h                |    1 
 26 files changed, 788 insertions(+), 136 deletions(-)
 create mode 100644 include/trace/events/fsverity.h


