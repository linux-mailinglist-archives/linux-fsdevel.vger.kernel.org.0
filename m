Return-Path: <linux-fsdevel+bounces-61485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5336B58917
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE3E7ABF5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDBF1A01C6;
	Tue, 16 Sep 2025 00:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0/ro+2J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977F625;
	Tue, 16 Sep 2025 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982133; cv=none; b=pofhD2Z3HH1W6KlM68gm11GCkvOrNUn3G2rqeF0tagY6sflwccQhPWakUEVZ7SijlLzCRsnSMuj2M+gPA3uQXm14e5WnW4afAJasQ5ySfVHdtk1qV0mOG5eGo1Hg0685j2pSxvfhgEm3sC87bB4v0B1Qf1DBYjpyY5hSeFnu9u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982133; c=relaxed/simple;
	bh=4l3M4rTQvkyohzZ3R2762l2bRRMr2gY8GAd0wm+Pc9A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nR3JTHkH7pi2k0zlwBYuh2memNe8khutDkjm+vuFrkHwdxSts36CyMcrMUy3N7Wvmgmv10aXBDhCljCSL1g0bII1StBf02wrnE6KUFgh1oalad0H07GTywEozFIjwMyv7Rg83gWYeeRg4gkrL5SgByXBWGlGLnkYIDsGyieHWy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0/ro+2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2281C4CEF1;
	Tue, 16 Sep 2025 00:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982132;
	bh=4l3M4rTQvkyohzZ3R2762l2bRRMr2gY8GAd0wm+Pc9A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=A0/ro+2J0KWfgUOCFvBFxn9CSmVfCK2J4czXtXF2pOmci5A6E57B0YN4ggZ9knXSZ
	 dr1e3n6bwxtwewaLX94E1Y8ofHGMRsd6V4a5eCghq1DEEMetFIdXnnd315142e/A2V
	 JxI2lDN3eXud4kdib1B2Q44rqb8ZQzyKEYRE7A9Oy3S6N6R/OQ8XL8C+da+R2yQ3jy
	 prdbcdlBKkqs0NO9uHjyvvayrO8VRMI0o081C6MjRVqrFdp+C4GQ4fbdTKZUPtZ6ay
	 WIhkbj0YRZhIc6v8J1zq4+5EhoSxLAEXwGywciXXvrWDhmV62uwOeT1e9EuDJU61XG
	 y3WcEjjLKt8Sw==
Date: Mon, 15 Sep 2025 17:22:12 -0700
Subject: [PATCHSET RFC v5 2/9] fuse4fs: fork a low level fuse server
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: amir73il@gmail.com, miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
In-Reply-To: <20250916000759.GA8080@frogsfrogsfrogs>
References: <20250916000759.GA8080@frogsfrogsfrogs>
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
 * fuse2fs: separate libfuse3 and fuse2fs detection in configure
 * fuse2fs: start porting fuse2fs to lowlevel libfuse API
 * debian: create new package for fuse4fs
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
 Makefile.in              |    3 
 configure                |  414 +--
 configure.ac             |  156 +
 debian/control           |   12 
 debian/fuse4fs.install   |    2 
 debian/rules             |   11 
 debugfs/Makefile.in      |   12 
 e2fsck/Makefile.in       |   56 
 fuse4fs/Makefile.in      |  193 +
 fuse4fs/fuse4fs.1.in     |  118 +
 fuse4fs/fuse4fs.c        | 6169 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/config.h.in          |    3 
 lib/e2p/Makefile.in      |    4 
 lib/ext2fs/Makefile.in   |   14 
 lib/support/Makefile.in  |    8 
 lib/support/cache.c      |  853 ++++++
 misc/Makefile.in         |   18 
 misc/tune2fs.c           |    4 
 23 files changed, 8922 insertions(+), 447 deletions(-)
 delete mode 100644 lib/ext2fs/kernel-list.h
 create mode 100644 lib/support/cache.h
 create mode 100644 lib/support/list.h
 create mode 100644 lib/support/xbitops.h
 create mode 100644 debian/fuse4fs.install
 create mode 100644 fuse4fs/Makefile.in
 create mode 100644 fuse4fs/fuse4fs.1.in
 create mode 100644 fuse4fs/fuse4fs.c
 create mode 100644 lib/support/cache.c


