Return-Path: <linux-fsdevel+bounces-33463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6651E9B913F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8DC6B22573
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 12:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADB819E997;
	Fri,  1 Nov 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+JlR7nJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1224713B592;
	Fri,  1 Nov 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465024; cv=none; b=Z5gKSSXENem2eHYys2rq6oDWd/psvYAIjd1ovX03qm5dHpQ/rfSn4wXqyL5fdZXC59fnO+XeslCfSJTQ5dvaMVCuTO2hTDnxl+SiaxRmHgoKfvZbmX0TH+jZh7ReQZmzSZPx/55ELn0QeqOJHtXIElrg+V2GR9IwKckT0FqT2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465024; c=relaxed/simple;
	bh=LKPvwtfooqqGCKLHuuPXyWLTC4PRAVB9xOz6xBRHHNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbCi0qBiXf7OlIK6fZnqC9ZzSOSI4/PN3Vt+Jyhh6y+4mheHS7ezN8eJT9XQPk5TrUhQ3m1yTigiL+HesVN3p4k1PdjdeneLOe0HS46+jhCCqAzt1J22ozaDrBZ5p1wyI/twTTEWICPOdkjipn0vUmRxdIW2TqUcbGW+UIiUQME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+JlR7nJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94587C4CECD;
	Fri,  1 Nov 2024 12:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730465023;
	bh=LKPvwtfooqqGCKLHuuPXyWLTC4PRAVB9xOz6xBRHHNg=;
	h=From:To:Cc:Subject:Date:From;
	b=o+JlR7nJKA4NXkT1FgFGCBn/rpxm6Vu0Fzlax97RCWNCZaN85lin7345DVuwn+buB
	 Pn71g4itQaSrjS584XMOErxSlNmQa8Z3+ZY3KZNwp/bdPjpo6cDCR8UYoIRQvnyh+T
	 clYbUxp2yVdxS90Lkyeh9ZrKoyyjhqoEAsXob6HKbAoCdsktK/1lIgogHaPxw3ZLVS
	 QZ8tpyHXrZfuIaPk4MfjLdJINFIw4fwOj72hR/IqLyQ+/NBw6Aq3Y37cvqRe6J0ZhO
	 /pYnsfrAJSrrqGH3FR6zFv+PL5lTcB0Wym7/oCXecwWkFAE5sh418ZemwOJed4kwAN
	 YChrN9UyfOppQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs iomap fixes
Date: Fri,  1 Nov 2024 13:43:33 +0100
Message-ID: <20241101-vfs-iomap-fixes-6ef0e93508fe@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3894; i=brauner@kernel.org; h=from:subject:message-id; bh=LKPvwtfooqqGCKLHuuPXyWLTC4PRAVB9xOz6xBRHHNg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSrnPmZd/Zphdj693Wyn+o1jjVUP/bfIj3t7MRdq3Nen m6eVSKj2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRtbsYGc5svXyV5XBYXIPZ YbtO1fmNE1V3ZbXxT2yJ1u2zktnw/THD//QIrTb2CAOO//XLHP+u0Fyyjynjqde/jT2LVs5uMX3 swwkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains fixes for iomap to prevent data corruption bugs in the
fallocate unshare range implementation of fsdax and a small cleanup to
turn iomap_want_unshare_iter() into an inline function.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-3)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.11-rc2 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

There will be a minor merge conflict with mainline due to some xfs
changes that came in. After conflict resolution mainline should looke like this:

diff --cc include/linux/iomap.h
index d0420e962ffd,0198f36e521e..000000000000
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@@ -256,20 -256,25 +256,39 @@@ static inline const struct iomap *iomap
        return &i->iomap;
  }

 +/*
 + * Return the file offset for the first unchanged block after a short write.
 + *
 + * If nothing was written, round @pos down to point at the first block in
 + * the range, else round up to include the partially written block.
 + */
 +static inline loff_t iomap_last_written_block(struct inode *inode, loff_t pos,
 +              ssize_t written)
 +{
 +      if (unlikely(!written))
 +              return round_down(pos, i_blocksize(inode));
 +      return round_up(pos + written, i_blocksize(inode));
 +}
 +
+ /*
+  * Check if the range needs to be unshared for a FALLOC_FL_UNSHARE_RANGE
+  * operation.
+  *
+  * Don't bother with blocks that are not shared to start with; or mappings that
+  * cannot be shared, such as inline data, delalloc reservations, holes or
+  * unwritten extents.
+  *
+  * Note that we use srcmap directly instead of iomap_iter_srcmap as unsharing
+  * requires providing a separate source map, and the presence of one is a good
+  * indicator that unsharing is needed, unlike IOMAP_F_SHARED which can be set
+  * for any data that goes into the COW fork for XFS.
+  */
+ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
+ {
+       return (iter->iomap.flags & IOMAP_F_SHARED) &&
+               iter->srcmap.type == IOMAP_MAPPED;
+ }
+
  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
                const struct iomap_ops *ops, void *private);
  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12-rc6.iomap

for you to fetch changes up to 6db388585e486c0261aeef55f8bc63a9b45756c0:

  iomap: turn iomap_want_unshare_iter into an inline function (2024-10-21 17:01:01 +0200)

(Note, I'm still not fully recovered so currently with a little reduced
 activity.)
Please consider pulling these changes from the signed vfs-6.12-rc6.iomap tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.12-rc6.iomap

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "fsdax/xfs: unshare range fixes for 6.12"

Christoph Hellwig (1):
      iomap: turn iomap_want_unshare_iter into an inline function

Darrick J. Wong (4):
      xfs: don't allocate COW extents when unsharing a hole
      iomap: share iomap_unshare_iter predicate code with fsdax
      fsdax: remove zeroing code from dax_unshare_iter
      fsdax: dax_unshare_iter needs to copy entire blocks

 fs/dax.c               | 45 ++++++++++++++++++++++++++++-----------------
 fs/iomap/buffered-io.c | 17 +----------------
 fs/xfs/xfs_iomap.c     |  2 +-
 include/linux/iomap.h  | 19 +++++++++++++++++++
 4 files changed, 49 insertions(+), 34 deletions(-)

