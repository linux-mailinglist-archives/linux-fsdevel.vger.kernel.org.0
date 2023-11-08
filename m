Return-Path: <linux-fsdevel+bounces-2381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9767E5336
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 11:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EAC6B20E1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 10:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C8F10A39;
	Wed,  8 Nov 2023 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/25LQDf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177D710A18
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 10:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A247CC433C8;
	Wed,  8 Nov 2023 10:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699438752;
	bh=Y/KrJVMORd6UY9eo+/z3E2ahVEEgtWXA4S1w71HjX6A=;
	h=From:To:Cc:Subject:Date:From;
	b=V/25LQDfmgS1/R+6++vnawPZLiksIVMWJ6rsp0MjwJxNcbnIeKBJUFEFrzGN22NGZ
	 3xOiJ80ydxz2tmxssj9YdRgmnzZeOHXACBhbui3ah9/CKAtOI0dd++GP31iHBas3t3
	 YccU2Jn/3JhKwIc3hGNMtB8yjBu7bY0LGoQGNWxRlc2Fpmuag9jiMu38s9qIkWsZpc
	 izVHhV/RBsIp9mgbm9kZuiDG4wVsvj1O6cC6XCpB9qvOuQIgn8FQzofyNNPHW29ETh
	 lA8Jsq+AK+EAKpdKDEKPj7VH0RT9KEp1sMBNtxLzkx48nglwr7gLNy6U5mLUH7Te5K
	 6CpMAuzq0Jlyw==
User-agent: mu4e 1.8.10; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org, chandanbabu@kernel.org
Cc: catherine.hoang@oracle.com,cheng.lin130@zte.com.cn,dchinner@redhat.com,djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,osandov@fb.com
Subject: [GIT PULL] xfs: new code for 6.7
Date: Wed, 08 Nov 2023 15:26:29 +0530
Message-ID: <87fs1g1rac.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch with changes for xfs for 6.7-rc1.

The important changes include,
1. CPU usage optimizations for realtime allocator.
2. Allowing read operations to continue while a FICLONE ioctl is being
   serviced.

The remaining changes are limited to bug fixes and code cleanups.

There was a delay in me pushing the changes to XFS' for-next branch and hence
a delay in the code changes reaching the linux-next tree. The XFS changes
reached linux-next on 31st of October. The delay was due to me having to drop
a patch from the XFS tree and having to initiate execution of the test suite
once again on October 26th. The complete test run requires around 4 days to
complete.

During a discussion, Darrick told me that in such scenarios he would limit
testing to non-fuzz tests which take around 12 hours to complete.  Hence, in
hindsight, I could have limited the time taken to execute tests after dropping
the patch. I will make sure to update XFS' for-next branch well before the
merge window period begins from next release onwards.

The changes that are part of the current pull request are contained within XFS
i.e. there are no patches which straddle across other subsystems. I have been
executing fstests on linux-next for more than a week now. There were no new
regressions found in XFS during the test run.

I had performed a test merge with latest contents of torvalds/linux.git. i.e.

305230142ae0637213bf6e04f6d9f10bbcb74af8
Author:     Linus Torvalds <torvalds@linux-foundation.org>
AuthorDate: Tue Nov 7 17:16:23 2023 -0800
Commit:     Linus Torvalds <torvalds@linux-foundation.org>
CommitDate: Tue Nov 7 17:16:23 2023 -0800
Merge tag 'pm-6.7-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

This resulted in merge conflicts. The following diff should resolve the merge
conflicts.

diff --cc fs/xfs/libxfs/xfs_rtbitmap.c
index 396648acb5be,b332ab490a48..84e27b9987f8
--- a/fs/xfs/libxfs/xfs_rtbitmap.c
+++ b/fs/xfs/libxfs/xfs_rtbitmap.c
@@@ -960,19 -931,18 +931,19 @@@ xfs_rtcheck_alloc_range
   * Free an extent in the realtime subvolume.  Length is expressed in
   * realtime extents, as is the block number.
   */
- int					/* error */
+ int
  xfs_rtfree_extent(
- 	xfs_trans_t	*tp,		/* transaction pointer */
- 	xfs_rtblock_t	bno,		/* starting block number to free */
- 	xfs_extlen_t	len)		/* length of extent freed */
+ 	struct xfs_trans	*tp,	/* transaction pointer */
+ 	xfs_rtxnum_t		start,	/* starting rtext number to free */
+ 	xfs_rtxlen_t		len)	/* length of extent freed */
  {
- 	int		error;		/* error value */
- 	xfs_mount_t	*mp;		/* file system mount structure */
- 	xfs_fsblock_t	sb;		/* summary file block number */
- 	struct xfs_buf	*sumbp = NULL;	/* summary file block buffer */
- 	struct timespec64 atime;
- 
- 	mp = tp->t_mountp;
+ 	struct xfs_mount	*mp = tp->t_mountp;
+ 	struct xfs_rtalloc_args	args = {
+ 		.mp		= mp,
+ 		.tp		= tp,
+ 	};
+ 	int			error;
++	struct timespec64	atime;
  
  	ASSERT(mp->m_rbmip->i_itemp != NULL);
  	ASSERT(xfs_isilocked(mp->m_rbmip, XFS_ILOCK_EXCL));
@@@ -1000,13 -970,46 +971,49 @@@
  	    mp->m_sb.sb_rextents) {
  		if (!(mp->m_rbmip->i_diflags & XFS_DIFLAG_NEWRTBM))
  			mp->m_rbmip->i_diflags |= XFS_DIFLAG_NEWRTBM;
 -		*(uint64_t *)&VFS_I(mp->m_rbmip)->i_atime = 0;
 +
 +		atime = inode_get_atime(VFS_I(mp->m_rbmip));
 +		*((uint64_t *)&atime) = 0;
 +		inode_set_atime_to_ts(VFS_I(mp->m_rbmip), atime);
  		xfs_trans_log_inode(tp, mp->m_rbmip, XFS_ILOG_CORE);
  	}
- 	return 0;
+ 	error = 0;
+ out:
+ 	xfs_rtbuf_cache_relse(&args);
+ 	return error;
+ }
+ 
+ /*
+  * Free some blocks in the realtime subvolume.  rtbno and rtlen are in units of
+  * rt blocks, not rt extents; must be aligned to the rt extent size; and rtlen
+  * cannot exceed XFS_MAX_BMBT_EXTLEN.
+  */
+ int
+ xfs_rtfree_blocks(
+ 	struct xfs_trans	*tp,
+ 	xfs_fsblock_t		rtbno,
+ 	xfs_filblks_t		rtlen)
+ {
+ 	struct xfs_mount	*mp = tp->t_mountp;
+ 	xfs_rtxnum_t		start;
+ 	xfs_filblks_t		len;
+ 	xfs_extlen_t		mod;
+ 
+ 	ASSERT(rtlen <= XFS_MAX_BMBT_EXTLEN);
+ 
+ 	len = xfs_rtb_to_rtxrem(mp, rtlen, &mod);
+ 	if (mod) {
+ 		ASSERT(mod == 0);
+ 		return -EIO;
+ 	}
+ 
+ 	start = xfs_rtb_to_rtxrem(mp, rtbno, &mod);
+ 	if (mod) {
+ 		ASSERT(mod == 0);
+ 		return -EIO;
+ 	}
+ 
+ 	return xfs_rtfree_extent(tp, start, len);
  }
  
  /* Find all the free records within a given range. */
diff --cc fs/xfs/xfs_rtalloc.c
index 2e1a4e5cd03d,ba66442910b1..0254c573086a
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@@ -1420,16 -1414,16 +1414,16 @@@ xfs_rtunmount_inodes
   */
  int					/* error */
  xfs_rtpick_extent(
- 	xfs_mount_t		*mp,		/* file system mount point */
- 	xfs_trans_t		*tp,		/* transaction pointer */
- 	xfs_extlen_t		len,		/* allocation length (rtextents) */
- 	xfs_rtblock_t		*pick)		/* result rt extent */
- 	{
- 	xfs_rtblock_t		b;		/* result block */
- 	int			log2;		/* log of sequence number */
- 	uint64_t		resid;		/* residual after log removed */
- 	uint64_t		seq;		/* sequence number of file creation */
- 	struct timespec64	ts;		/* temporary timespec64 storage */
 -	xfs_mount_t	*mp,		/* file system mount point */
 -	xfs_trans_t	*tp,		/* transaction pointer */
 -	xfs_rtxlen_t	len,		/* allocation length (rtextents) */
 -	xfs_rtxnum_t	*pick)		/* result rt extent */
++	xfs_mount_t		*mp,	/* file system mount point */
++	xfs_trans_t		*tp,	/* transaction pointer */
++	xfs_rtxlen_t		len,	/* allocation length (rtextents) */
++	xfs_rtxnum_t		*pick)	/* result rt extent */
+ {
 -	xfs_rtxnum_t	b;		/* result rtext */
 -	int		log2;		/* log of sequence number */
 -	uint64_t	resid;		/* residual after log removed */
 -	uint64_t	seq;		/* sequence number of file creation */
 -	uint64_t	*seqp;		/* pointer to seqno in inode */
++	xfs_rtxnum_t		b;	/* result rtext */
++	int			log2;	/* log of sequence number */
++	uint64_t		resid;	/* residual after log removed */
++	uint64_t		seq;	/* sequence number of file creation */
++	struct timespec64	ts;	/* temporary timespec64 storage */
  
  	ASSERT(xfs_isilocked(mp->m_rbmip, XFS_ILOCK_EXCL));

Please let me know if you encounter any problems.

The following changes since commit 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1:

  Linux 6.6-rc7 (2023-10-22 12:11:21 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.7-merge-2

for you to fetch changes up to 14a537983b228cb050ceca3a5b743d01315dc4aa:

  xfs: allow read IO and FICLONE to run concurrently (2023-10-23 12:02:26 +0530)

----------------------------------------------------------------
New code for 6.7:

  * Realtime device subsystem
    - Cleanup usage of xfs_rtblock_t and xfs_fsblock_t data types.
    - Replace open coded conversions between rt blocks and rt extents with
      calls to static inline helpers.
    - Replace open coded realtime geometry compuation and macros with helper
      functions.
    - CPU usage optimizations for realtime allocator.
    - Misc. Bug fixes associated with Realtime device.
  * Allow read operations to execute while an FICLONE ioctl is being serviced.
  * Misc. bug fixes
    - Alert user when xfs_droplink() encounters an inode with a link count of zero.
    - Handle the case where the allocator could return zero extents when
      servicing an fallocate request.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Catherine Hoang (1):
      xfs: allow read IO and FICLONE to run concurrently

Chandan Babu R (6):
      Merge tag 'realtime-fixes-6.7_2023-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.7-mergeA
      Merge tag 'clean-up-realtime-units-6.7_2023-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.7-mergeA
      Merge tag 'refactor-rt-unit-conversions-6.7_2023-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.7-mergeA
      Merge tag 'refactor-rtbitmap-macros-6.7_2023-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.7-mergeA
      Merge tag 'refactor-rtbitmap-accessors-6.7_2023-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.7-mergeA
      Merge tag 'rtalloc-speedups-6.7_2023-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.7-mergeA

Cheng Lin (1):
      xfs: introduce protection for drop nlink

Christoph Hellwig (1):
      xfs: handle nimaps=0 from xfs_bmapi_write in xfs_alloc_file_space

Darrick J. Wong (30):
      xfs: bump max fsgeom struct version
      xfs: hoist freeing of rt data fork extent mappings
      xfs: prevent rt growfs when quota is enabled
      xfs: rt stubs should return negative errnos when rt disabled
      xfs: fix units conversion error in xfs_bmap_del_extent_delay
      xfs: make sure maxlen is still congruent with prod when rounding down
      xfs: move the xfs_rtbitmap.c declarations to xfs_rtbitmap.h
      xfs: convert xfs_extlen_t to xfs_rtxlen_t in the rt allocator
      xfs: create a helper to convert rtextents to rtblocks
      xfs: convert rt bitmap/summary block numbers to xfs_fileoff_t
      xfs: create a helper to compute leftovers of realtime extents
      xfs: convert rt bitmap extent lengths to xfs_rtbxlen_t
      xfs: create a helper to convert extlen to rtextlen
      xfs: rename xfs_verify_rtext to xfs_verify_rtbext
      xfs: create helpers to convert rt block numbers to rt extent numbers
      xfs: convert rt extent numbers to xfs_rtxnum_t
      xfs: convert do_div calls to xfs_rtb_to_rtx helper calls
      xfs: create rt extent rounding helpers for realtime extent blocks
      xfs: convert the rtbitmap block and bit macros to static inline functions
      xfs: use shifting and masking when converting rt extents, if possible
      xfs: remove XFS_BLOCKWSIZE and XFS_BLOCKWMASK macros
      xfs: convert open-coded xfs_rtword_t pointer accesses to helper
      xfs: convert rt summary macros to helpers
      xfs: create a helper to handle logging parts of rt bitmap/summary blocks
      xfs: create helpers for rtbitmap block/wordcount computations
      xfs: use accessor functions for bitmap words
      xfs: create helpers for rtsummary block/wordcount computations
      xfs: use accessor functions for summary info words
      xfs: simplify xfs_rtbuf_get calling conventions
      xfs: simplify rt bitmap/summary block accessor functions

Dave Chinner (1):
      xfs: consolidate realtime allocation arguments

Omar Sandoval (6):
      xfs: cache last bitmap block in realtime allocator
      xfs: invert the realtime summary cache
      xfs: return maximum free size from xfs_rtany_summary()
      xfs: limit maxlen based on available space in xfs_rtallocate_extent_near()
      xfs: don't try redundant allocations in xfs_rtallocate_extent_near()
      xfs: don't look for end of extent further than necessary in xfs_rtallocate_extent_near()

 fs/xfs/libxfs/xfs_bmap.c       |  45 +--
 fs/xfs/libxfs/xfs_format.h     |  34 +-
 fs/xfs/libxfs/xfs_rtbitmap.c   | 803 ++++++++++++++++++++++-------------------
 fs/xfs/libxfs/xfs_rtbitmap.h   | 383 ++++++++++++++++++++
 fs/xfs/libxfs/xfs_sb.c         |   2 +
 fs/xfs/libxfs/xfs_sb.h         |   2 +-
 fs/xfs/libxfs/xfs_trans_resv.c |  10 +-
 fs/xfs/libxfs/xfs_types.c      |   4 +-
 fs/xfs/libxfs/xfs_types.h      |  10 +-
 fs/xfs/scrub/bmap.c            |   2 +-
 fs/xfs/scrub/fscounters.c      |   2 +-
 fs/xfs/scrub/inode.c           |   3 +-
 fs/xfs/scrub/rtbitmap.c        |  28 +-
 fs/xfs/scrub/rtsummary.c       |  72 ++--
 fs/xfs/scrub/trace.c           |   1 +
 fs/xfs/scrub/trace.h           |  15 +-
 fs/xfs/xfs_bmap_util.c         |  74 ++--
 fs/xfs/xfs_file.c              |  63 +++-
 fs/xfs/xfs_fsmap.c             |  15 +-
 fs/xfs/xfs_inode.c             |  24 ++
 fs/xfs/xfs_inode.h             |   9 +
 fs/xfs/xfs_inode_item.c        |   3 +-
 fs/xfs/xfs_ioctl.c             |   5 +-
 fs/xfs/xfs_linux.h             |  12 +
 fs/xfs/xfs_mount.h             |   8 +-
 fs/xfs/xfs_ondisk.h            |   4 +
 fs/xfs/xfs_reflink.c           |   4 +
 fs/xfs/xfs_rtalloc.c           | 626 ++++++++++++++++----------------
 fs/xfs/xfs_rtalloc.h           |  94 +----
 fs/xfs/xfs_super.c             |   3 +-
 fs/xfs/xfs_trans.c             |   7 +-
 31 files changed, 1425 insertions(+), 942 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_rtbitmap.h

