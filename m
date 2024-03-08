Return-Path: <linux-fsdevel+bounces-13990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAB18761A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 11:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78111C21546
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 10:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501A554BF6;
	Fri,  8 Mar 2024 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4I7FSLz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB14954BD6;
	Fri,  8 Mar 2024 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892753; cv=none; b=eh3jUR93Wtx+b/Qqggmz5D5T/IdO04lR6sUIy04eCktU+I2HEEOtUNGi6Anm58WD1Swmg04zlA15yOny4gAKsz5ePoqRN2CGvTF49mgFUo6k0MKyFCKS8wgk/2patPFwA2EyAZmhAWlPrnzTz8RgCdmHN8utEdohbpjfVgj87Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892753; c=relaxed/simple;
	bh=2jQZxIFl4d6HhQOrEl3tjvuyOYix0Nhi5jV758z3jnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjvrY1qaMNmLaUraLrwnPbEIFsAS4E1CdpCzgJ1ryb823R5iUxhEZ23YGCZA5cWMLa0pOGwdzIIr8ky+ILfKUm3cJdqwojoljrfGXgoD0aOsGyIsyYDgxFqitO0aywAn/tujMrg3d28yROmzCa03BszXxljAXziu3ds4Mb4htho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4I7FSLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3BEC433F1;
	Fri,  8 Mar 2024 10:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709892751;
	bh=2jQZxIFl4d6HhQOrEl3tjvuyOYix0Nhi5jV758z3jnU=;
	h=From:To:Cc:Subject:Date:From;
	b=P4I7FSLzVfign3MPAA1epHe8LOlZWqwXPE7JO2SgwS/3Ddu2uKgP1gBWSUC5uymwi
	 e+2XNlsc0b2xFwy/sRrwYpBPYWanH9zMgdfp475hPhSmlxV556416p6FEYTlD00n4x
	 QuPPVBkCR+RXMpYYpkfe6S3GGR2t008uOS73gQVrGb7GgyQHlsu9juZXgf/7wlsg9a
	 /DmelOjXDcePG5P6jZ0+dWrR3ptFXOf0H6AvazBaf0MHIcUYe66Bs1/1M3Vp1kDL+u
	 LqDmEnbwZfIjOJBENrpKe8MTlT/6Y41v8DuQbVQ+bO/+8a69uNhBi0k2GOogYzsXHU
	 hTpi1RP6XrdZA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs iomap
Date: Fri,  8 Mar 2024 11:12:11 +0100
Message-ID: <20240308-vfs-iomap-96ff9703338d@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5168; i=brauner@kernel.org; h=from:subject:message-id; bh=2jQZxIFl4d6HhQOrEl3tjvuyOYix0Nhi5jV758z3jnU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS+etKywW6H679l5R0uF7RWvw+IO3GiY0rSTY6iw/W1Z 5g/fuH53lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRl5cYGTZ7zS1zfVy5e5mc R1/PFdlF7yy8Zz25emWnJQtrdnTA516Gf5arSnbEPpvlOqGvc4Kz7BUBbxHXfouGwACrDmkNy0v 3WQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains a few updates for the iomap code:

* Restore read-write hints in struct bio through the bi_write_hint member for
  the sake of UFS devices in mobile applications. This can result in up to 40%
  lower write amplification in UFS devices. The patch series that builds on
  this will be coming in via the SCSI maintainers. (Bart)

* Overhaul the iomap writeback code. Afterwards ->map_blocks() is able to map
  multiple blocks at once as long as they're in the same folio. This
  reduces CPU usage for buffered write workloads on e.g., xfs on systems
  with lots of cores. (Christoph)

* Record processed bytes in iomap_iter() trace event. (Kassey)

* Extend iomap_writepage_map() trace event after Christoph's ->map_block()
  changes to map mutliple blocks at once. (Zhang)

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.8-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with other trees
================================

[1] linux-next: manual merge of the scsi-mkp tree with the vfs-brauner tree
    https://lore.kernel.org/linux-next/20240227153436.33b48d59@canb.auug.org.au

[2] There's a merge conflict between the vfs-6.9-misc pull request sent as
    https://lore.kernel.org/r/20240308-vfs-misc-a4e7c50ce769@brauner
    that can be resolved like this:

    diff --cc include/linux/fs.h
    index 2ba751d097c1,bdabda5dc364..000000000000
    --- a/include/linux/fs.h
    +++ b/include/linux/fs.h
    @@@ -43,7 -43,7 +43,8 @@@
      #include <linux/cred.h>
      #include <linux/mnt_idmapping.h>
      #include <linux/slab.h>
     +#include <linux/maple_tree.h>
    + #include <linux/rw_hint.h>
    
      #include <asm/byteorder.h>
      #include <uapi/linux/fs.h>

Merge conflicts with mainline
=============================

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.iomap

for you to fetch changes up to 86835c39e08e6d92a9d66d51277b2676bc659743:

  Merge tag 'vfs-6.9.rw_hint' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs (2024-03-04 18:35:21 +0100)

Please consider pulling these changes from the signed vfs-6.9.iomap tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.9.iomap

----------------------------------------------------------------
Bart Van Assche (6):
      fs: Fix rw_hint validation
      fs: Verify write lifetime constants at compile time
      fs: Split fcntl_rw_hint()
      fs: Move enum rw_hint into a new header file
      fs: Propagate write hints to the struct block_device inode
      block, fs: Restore the per-bio/request data lifetime fields

Christian Brauner (1):
      Merge tag 'vfs-6.9.rw_hint' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs

Christoph Hellwig (14):
      iomap: clear the per-folio dirty bits on all writeback failures
      iomap: treat inline data in iomap_writepage_map as an I/O error
      iomap: move the io_folios field out of struct iomap_ioend
      iomap: move the PF_MEMALLOC check to iomap_writepages
      iomap: factor out a iomap_writepage_handle_eof helper
      iomap: move all remaining per-folio logic into iomap_writepage_map
      iomap: clean up the iomap_alloc_ioend calling convention
      iomap: move the iomap_sector sector calculation out of iomap_add_to_ioend
      iomap: don't chain bios
      iomap: only call mapping_set_error once for each failed bio
      iomap: factor out a iomap_writepage_map_block helper
      iomap: submit ioends immediately
      iomap: map multiple blocks at a time
      iomap: pass the length of the dirty region to ->map_blocks

Kassey Li (1):
      iomap: Add processed for iomap_iter

Zhang Yi (1):
      iomap: add pos and dirty_len into trace_iomap_writepage_map

 block/bio.c                 |   2 +
 block/blk-crypto-fallback.c |   1 +
 block/blk-merge.c           |   8 +
 block/blk-mq.c              |   2 +
 block/bounce.c              |   1 +
 block/fops.c                |   5 +-
 fs/buffer.c                 |  12 +-
 fs/direct-io.c              |   2 +
 fs/f2fs/f2fs.h              |   1 +
 fs/fcntl.c                  |  64 +++--
 fs/gfs2/bmap.c              |   2 +-
 fs/inode.c                  |   1 +
 fs/iomap/buffered-io.c      | 579 ++++++++++++++++++++++----------------------
 fs/iomap/direct-io.c        |   1 +
 fs/iomap/trace.h            |  48 +++-
 fs/mpage.c                  |   1 +
 fs/xfs/xfs_aops.c           |   9 +-
 fs/zonefs/file.c            |   3 +-
 include/linux/blk-mq.h      |   2 +
 include/linux/blk_types.h   |   2 +
 include/linux/fs.h          |  16 +-
 include/linux/iomap.h       |  19 +-
 include/linux/rw_hint.h     |  24 ++
 23 files changed, 455 insertions(+), 350 deletions(-)
 create mode 100644 include/linux/rw_hint.h

