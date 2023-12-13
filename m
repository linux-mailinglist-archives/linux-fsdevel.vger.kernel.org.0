Return-Path: <linux-fsdevel+bounces-5787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B95B81089D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44816281823
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 03:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401E763A6;
	Wed, 13 Dec 2023 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uO2Ui/w0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F15B0
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 19:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=j6kPaRQAdQQXWt+rtLmzuZXpf2thtmwy+PGeO97If1s=; b=uO2Ui/w0CphlKsmAt7DXDjuI15
	v7db8zw3wann2gOnHQvO2Ctgq8+elm7gg/SeMoLF8MfdSVACtJ4aT3zXYrT/6PVaTF2wGLyfjhhAR
	ivwzeVSb+lJTVa72Oh642LzoxGmzdm7POwEWWxxSa+T1GSvNnfPtXYF99DiuSI7/d3KQkLkWt1nxE
	fJwEHjZpox/deAdvbW7jsUA7wpoX9QUqhhFgJjYoA+CUYBMGlD3K9Nh5F7bLwr6xuHczHHMo3P27e
	VY4NN61snEpV8Hb8uKWdbJaCmm2VSHIYm5Dq0CYPNKP07i+dXjqzjtkSTCSLsejFzbi5xxCZkQ/ww
	7u3Vrkzw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDFjj-00BbuQ-1W;
	Wed, 13 Dec 2023 03:16:39 +0000
Date: Wed, 13 Dec 2023 03:16:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [patches][cft] ufs stuff
Message-ID: <20231213031639.GJ1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	More old stuff, this time UFS one.  Part of that is
yet another kmap_local_page() conversion, part - assorted
cleanups.
	It seems to survive local beating, but it needs
more review and testing.

The branch is available in vfs.git #work.ufs; individual patches
in followups.

Shortlog:
Al Viro (8):
      ufs: fix handling of delete_entry and set_link failures
      ufs: untangle ubh_...block...() macros, part 1
      ufs: untangle ubh_...block...(), part 2
      ufs: untangle ubh_...block...(), part 3
      ufs_clusteracct(): switch to passing fragment number
      ufs_inode_getfrag(): remove junk comment
      ufs: get rid of ubh_{ubhcpymem,memcpyubh}()
      clean ufs_trunc_direct() up a bit...

Fabio M. De Francesco (4):
      fs/ufs: Use the offset_in_page() helper
      fs/ufs: Change the signature of ufs_get_page()
      fs/ufs: Use ufs_put_page() in ufs_rename()
      fs/ufs: Replace kmap() with kmap_local_page()

Diffstat:
 fs/ufs/balloc.c |  29 +++++------
 fs/ufs/dir.c    | 156 +++++++++++++++++++++++++++++---------------------------
 fs/ufs/inode.c  | 144 ++++++++++++++++++++++-----------------------------
 fs/ufs/namei.c  |  52 ++++++++-----------
 fs/ufs/super.c  |  45 ++++++----------
 fs/ufs/ufs.h    |   2 +-
 fs/ufs/util.c   |  46 -----------------
 fs/ufs/util.h   |  61 +++++++++++-----------
 8 files changed, 222 insertions(+), 313 deletions(-)

Beginning of the series is the kmap_local_page() conversion and
fixes, parallel to what's been done for sysv/ext2/minixfs:

1/12) fs/ufs: Use the offset_in_page() helper
2/12) fs/ufs: Change the signature of ufs_get_page()
3/12) fs/ufs: Use ufs_put_page() in ufs_rename()
4/12) fs/ufs: Replace kmap() with kmap_local_page()
5/12) ufs: fix handling of delete_entry and set_link failures

After that it's assorted cleanups; there's quite a bit of obfuscation
caused by trying to hide the fragment numbers behind a forest of
macros, presumably in attempt to make it more similar to ext2 et.al.
These patches untangle some of that.

6/12) ufs: untangle ubh_...block...() macros, part 1
passing implicit argument to a macro by having it in a variable
with special name is Not Nice(tm); just pass it explicitly.
kill an unused macro, while we are at it...

7/12) ufs: untangle ubh_...block...(), part 2
pass cylinder group descriptor instead of its buffer head (ubh,
always UCPI_UBH(ucpi)) and its ->c_freeoff.

8/12) ufs: untangle ubh_...block...(), part 3
Pass fragment number instead of a block one.  It's available in all
callers and it makes the logics inside those helpers much simpler.
The bitmap they operate upon is with bit per fragment, block being
an aligned group of 1, 2, 4 or 8 adjacent fragments.  We still
need a switch by the number of fragments in block (== number of
bits to check/set/clear), but finding the byte we need to work
with becomes uniform and that makes the things easier to follow.

9/12) ufs_clusteracct(): switch to passing fragment number

10/12) ufs_inode_getfrag(): remove junk comment
It used to be a stubbed out beginning of ufs2 support, which had
been implemented differently quite a while ago.  Remove the
commented-out (pseudo-)code.

11/12) ufs: get rid of ubh_{ubhcpymem,memcpyubh}()
used only in ufs_read_cylinder_structures()/ufs_put_super_internal()
and there we can just as well avoid bothering with ufs_buffer_head
and just deal with it fragment-by-fragment.

12/12) clean ufs_trunc_direct() up a bit...
For short files (== no indirect blocks needed) UFS allows the last
block to be a partial one.  That creates some complications for
truncation down to "short file" lengths.  ufs_trunc_direct() is
called when we'd already made sure that new EOF is not in a hole;
nothing needs to be done if we are extending the file and in
case we are shrinking the file it needs to
	* shrink or free the old final block.
	* free all full direct blocks between the new and old EOF.
	* possibly shrink the new final block.
The logics is needlessly complicated by trying to keep all cases
handled by the same sequence of operations.
	if not shrinking
		nothing to do
	else if number of full blocks unchanged
		free the tail of possibly partial last block
	else
		free the tail of (full) new last block
		free all present (full) blocks in between
		free the (possibly partial) old last block
is easier to follow than the result of trying to unify these
cases.

