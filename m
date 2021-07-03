Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10C13BA6C5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 04:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhGCDAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 23:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhGCDAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 23:00:39 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25239C061762;
        Fri,  2 Jul 2021 19:58:07 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzVr4-00EfPq-47; Sat, 03 Jul 2021 02:58:06 +0000
Date:   Sat, 3 Jul 2021 02:58:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git iov_iter stuff
Message-ID: <YN/SPsDU3qdweQX0@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	iov_iter cleanups and fixes; there are followups, but this is what
had sat in -next this cycle.  IMO the macro forest in there became much
thinner and easier to follow...

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter

for you to fetch changes up to 6852df1266995c35b8621a95dcb7f91ca11ea409:

  csum_and_copy_to_pipe_iter(): leave handling of csum_state to caller (2021-06-10 11:45:25 -0400)

----------------------------------------------------------------
Al Viro (36):
      ntfs_copy_from_user_iter(): don't bother with copying iov_iter
      generic_perform_write()/iomap_write_actor(): saner logics for short copy
      fuse_fill_write_pages(): don't bother with iov_iter_single_seg_count()
      teach copy_page_to_iter() to handle compound pages
      copy_page_to_iter(): fix ITER_DISCARD case
      [xarray] iov_iter_fault_in_readable() should do nothing in xarray case
      iov_iter_advance(): use consistent semantics for move past the end
      iov_iter: switch ..._full() variants of primitives to use of iov_iter_revert()
      iov_iter: reorder handling of flavours in primitives
      iov_iter_advance(): don't modify ->iov_offset for ITER_DISCARD
      iov_iter: separate direction from flavour
      iov_iter: optimize iov_iter_advance() for iovec and kvec
      sanitize iov_iter_fault_in_readable()
      iov_iter_alignment(): don't bother with iterate_all_kinds()
      iov_iter_gap_alignment(): get rid of iterate_all_kinds()
      get rid of iterate_all_kinds() in iov_iter_get_pages()/iov_iter_get_pages_alloc()
      iov_iter_npages(): don't bother with iterate_all_kinds()
      [xarray] iov_iter_npages(): just use DIV_ROUND_UP()
      iov_iter: replace iov_iter_copy_from_user_atomic() with iterator-advancing variant
      csum_and_copy_to_iter(): massage into form closer to csum_and_copy_from_iter()
      iterate_and_advance(): get rid of magic in case when n is 0
      iov_iter: massage iterate_iovec and iterate_kvec to logics similar to iterate_bvec
      iov_iter: unify iterate_iovec and iterate_kvec
      iterate_bvec(): expand bvec.h macro forest, massage a bit
      iov_iter: teach iterate_{bvec,xarray}() about possible short copies
      iov_iter: get rid of separate bvec and xarray callbacks
      iov_iter: make the amount already copied available to iterator callbacks
      iov_iter: make iterator callbacks use base and len instead of iovec
      pull handling of ->iov_offset into iterate_{iovec,bvec,xarray}
      iterate_xarray(): only of the first iteration we might get offset != 0
      copy_page_to_iter(): don't bother with kmap_atomic() for bvec/kvec cases
      copy_page_from_iter(): don't need kmap_atomic() for kvec/bvec cases
      iov_iter: clean csum_and_copy_...() primitives up a bit
      pipe_zero(): we don't need no stinkin' kmap_atomic()...
      clean up copy_mc_pipe_to_iter()
      csum_and_copy_to_pipe_iter(): leave handling of csum_state to caller

David Howells (1):
      iov_iter: Remove iov_iter_for_each_range()

 Documentation/filesystems/porting.rst |    9 +
 fs/btrfs/file.c                       |   23 +-
 fs/fuse/file.c                        |    4 +-
 fs/iomap/buffered-io.c                |   35 +-
 fs/ntfs/file.c                        |   33 +-
 include/linux/uio.h                   |   66 +-
 include/net/checksum.h                |   14 +-
 lib/iov_iter.c                        | 1231 +++++++++++++++------------------
 mm/filemap.c                          |   36 +-
 9 files changed, 643 insertions(+), 808 deletions(-)
