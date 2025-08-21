Return-Path: <linux-fsdevel+bounces-58429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C53B2E9B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4D2A23331
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97681EF38C;
	Thu, 21 Aug 2025 00:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCRlD/U/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338E81E00A0;
	Thu, 21 Aug 2025 00:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737363; cv=none; b=YuOkNU59xzvHxThFSvm8kotqBz1T1Em00poeaERLtNwoXi4iRr4gwc2FlAL+JvPzf7A/xjrcR8m9udqStA//bf+GJWDr/YfpAKae/BpKOLLjiR4ApTHsyF01KfvdQ7hjkm5OgRBAmTENYgTMcJFE/mwbRW3m20tuUd1FvkWpTL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737363; c=relaxed/simple;
	bh=O27t8VUnDnfWcEsYJosIjLwoRKzNrX72aD4vKGOQ9g0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TET5IJbXobH4aP/dP4b7IZhSpk/pStHHI1gpGMseoy7gnUy0JVvjX6obuTRsC3Zk13gDFwvQ3rfaCrAIdZs8RCs61hPt+ZtFgS5giv3ghGTJzY46DYHWWPruozm1N7mHhR5j9eSkOf6qoAmMub3wpaQULFZS+57nQTEB1/d8yrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCRlD/U/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1626C4CEE7;
	Thu, 21 Aug 2025 00:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737362;
	bh=O27t8VUnDnfWcEsYJosIjLwoRKzNrX72aD4vKGOQ9g0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oCRlD/U/FCg0ksjZdJFOc82eftIve3mPgkryDTBtKh7YaewHj+0Q8PG2ozcYQ/u6f
	 P3CsHXGqszGZDXxNeDOruxqdLlSdaf8k6Nzho2pqCL7VVXnAs6nukQG0gq6+SDy+a7
	 l1qzXUaCrkGtCYDZHJPVqOS7MGwngOdNXDb9MAcynz1HKNJPhvcw3I9OjZlaqx7I3K
	 j1OVPlptHAIMu+tlTm+pqEE72GaQWlxQi4LDdo43keRV44olk6BpRFTmLoXgdD9wOg
	 8ZCoemRML/xHOgRb6WJiM5Oe4rloj3Cob6Rno0LO8A/yE3fK6FeI+tJJ5MclJSCWuT
	 MI7ULAcS4Tc3A==
Date: Wed, 20 Aug 2025 17:49:22 -0700
Subject: [PATCHSET RFC v4 1/6] fuse4fs: fork a low level fuse server
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: amir73il@gmail.com, John@groves.net, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 amir73il@gmail.com, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <175573712721.20753.5223489399594191991.stgit@frogsfrogsfrogs>
In-Reply-To: <20250821003720.GA4194186@frogsfrogsfrogs>
References: <20250821003720.GA4194186@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Whilst developing the fuse2fs+iomap prototype, I discovered a
fundamental design limitation of the upper-level libfuse API: hardlinks.
The upper level fuse library really wants to communicate with the fuse
server with file paths, instead of using inode numbers.  This works
great for filesystems that don't have inodes, create files dynamically
at runtime, or lack stable inode numbers.

Unfortunately, the libfuse path abstraction assigns a unique nodeid to
every child file in the entire filesystem, without regard to hard links.
In other words, a hardlinked regular file may have one ondisk inode
number but multiple kernel inodes.  For classic fuse2fs this isn't a
problem because all file access goes through the fuse server and the big
library lock protects us from corruption.

For fuse2fs + iomap this is a disaster because we rely on the kernel to
coordinate access to inodes.  For hardlinked files, we *require* that
there only be one in-kernel inode for each ondisk inode.

The path based mechanism is also very inefficient for fuse2fs.  Every
time a file is accessed, the upper level libfuse passes a new nodeid to
the kernel, and on every file access the kernel passes that same nodeid
back to libfuse.  libfuse then walks its internal directory entry cache
to construct a path string for that nodeid and hands it to fuse2fs.
fuse2fs then walks the ondisk directory structure to find the ext2 inode
number.  Every time.

Create a new fuse4fs server from fuse2fs that uses the lowlevel fuse
API.  This affords us direct control over nodeids and eliminates the
path wrangling.  Hardlinks can be supported when iomap is turned on,
and metadata-heavy workloads run twice as fast.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse4fs-fork
---
Commits in this patchset:
 * fuse2fs: port fuse2fs to lowlevel libfuse API
 * fuse4fs: drop fuse 2.x support code
 * fuse4fs: namespace some helpers
 * fuse4fs: convert to low level API
 * libsupport: port the kernel list.h to libsupport
 * libsupport: add a cache
 * cache: disable debugging
 * cache: use modern list iterator macros
 * cache: embed struct cache in the owner
 * cache: pass cache pointer to callbacks
 * cache: pass a private data pointer through cache_walk
 * cache: add a helper to grab a new refcount for a cache_node
 * cache: return results of a cache flush
 * cache: add a "get only if incore" flag to cache_node_get
 * cache: support gradual expansion
 * cache: implement automatic shrinking
 * fuse4fs: add cache to track open files
 * fuse4fs: use the orphaned inode list
 * fuse4fs: implement FUSE_TMPFILE
 * fuse4fs: create incore reverse orphan list
---
 lib/ext2fs/jfs_compat.h  |    2 
 lib/ext2fs/kernel-list.h |  111 -
 lib/support/cache.h      |  177 +
 lib/support/list.h       |  901 +++++++
 lib/support/xbitops.h    |  128 +
 configure                |   50 
 configure.ac             |   31 
 debugfs/Makefile.in      |   12 
 e2fsck/Makefile.in       |   56 
 lib/config.h.in          |    3 
 lib/e2p/Makefile.in      |    4 
 lib/ext2fs/Makefile.in   |   14 
 lib/support/Makefile.in  |    8 
 lib/support/cache.c      |  853 ++++++
 misc/Makefile.in         |   35 
 misc/fuse4fs.c           | 6098 ++++++++++++++++++++++++++++++++++++++++++++++
 misc/tune2fs.c           |    4 
 17 files changed, 8319 insertions(+), 168 deletions(-)
 delete mode 100644 lib/ext2fs/kernel-list.h
 create mode 100644 lib/support/cache.h
 create mode 100644 lib/support/list.h
 create mode 100644 lib/support/xbitops.h
 create mode 100644 lib/support/cache.c
 create mode 100644 misc/fuse4fs.c


