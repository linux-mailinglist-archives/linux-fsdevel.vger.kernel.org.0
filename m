Return-Path: <linux-fsdevel+bounces-28110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F4E96739B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F72B28303E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DFC17E00E;
	Sat, 31 Aug 2024 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gcuh0rwg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70DEEC9;
	Sat, 31 Aug 2024 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143876; cv=none; b=hTXW148zZHpp4PmsMDdQJ5cTP6HJ11L/n9aTXnu0gNmwWO9JN+luihSHTZZxwwUkR61yryyXvk4ey6dQiFRcsqKentN+igubmdnG1Xm36zZzU6jWA1cvp4nHAe06Ggj+LweOzI2ku46d+zGfUtPKgsCJRFKb4oQhImwhGA5zyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143876; c=relaxed/simple;
	bh=qD5seCHMcHlmx6Xg0a1BIRYjhBYx5eW3AxyCHrOIEtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1X6pFaGWhw2rqLPYIdjS8+mEoPidAX7q0PtT5wXYnItxd6kgJZQa7GM6BlitJh0fRABRRpdkXFpcO0sagI4jTEoL7MphnQfKF7sJkESpW8qCxFdktoy5TUhKqdg4usDl5p3pdcs1NX0rDXixEdfs9cZJ/ZjuO+GlhP5dkdF/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gcuh0rwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2BAC4CEC0;
	Sat, 31 Aug 2024 22:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143876;
	bh=qD5seCHMcHlmx6Xg0a1BIRYjhBYx5eW3AxyCHrOIEtw=;
	h=From:To:Cc:Subject:Date:From;
	b=Gcuh0rwgN6UXJtKri7zJaJDeyjo0X/Vk9YOphJf/zNDzlllykgX6yM5L0RaphUGNJ
	 QExe1lMNPBA4h9wXQhYfIPOmfh3OFeX9LhDi/6HsvY6y3rJazWX80a/BsJaW6/Yaz2
	 wcDDtGwiDxwSYVsKO7cqI+Y/2x1EdEQYTp5j/qqREoAz6Vox2Ljv/t1agz6r/UBz1R
	 x3Xal5/1RNEZt4WGebke4/hm4QimnSFd9Eu98cjG6dZf56qWK9F0v+M+I8v3sY6L5s
	 679whMkXIoMiLoObj9BuJNd3uv4KXMa59EabAfEtCF5P1ASnrVXPvk8/NJgmfbt468
	 GEKmyY1d+r2zg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
Date: Sat, 31 Aug 2024 18:37:20 -0400
Message-ID: <20240831223755.8569-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Happy Labor Day weekend (US holiday on Monday)!  Seems apropos to send
what I hope the final LOCALIO patchset this weekend: its my birthday
this coming Tuesday, so _if_ LOCALIO were to get merged for 6.12
inclusion sometime next week: best b-day gift in a while! ;)

Anyway, I've been busy incorporating all the review feedback from v14
_and_ working closely with NeilBrown to address some lingering net-ns
refcounting and nfsd modules refcounting issues, and more (Chnagelog
below):

git diff snitzer/nfs-localio-for-next.v14 snitzer/nfs-localio-for-next.v15 | diffstat
 Documentation/filesystems/nfs/localio.rst |  106 +++++++++--
 fs/Kconfig                                |   26 ++
 fs/nfs/Kconfig                            |   16 -
 fs/nfs/client.c                           |    4
 fs/nfs/flexfilelayout/flexfilelayout.c    |    8
 fs/nfs/internal.h                         |   24 +-
 fs/nfs/localio.c                          |   92 +++------
 fs/nfs/pagelist.c                         |    4
 fs/nfs/write.c                            |    4
 fs/nfs_common/nfslocalio.c                |  287 +++++++++++-------------------
 fs/nfsd/Kconfig                           |   16 -
 fs/nfsd/Makefile                          |    2
 fs/nfsd/filecache.c                       |   27 +-
 fs/nfsd/filecache.h                       |    1
 fs/nfsd/localio.c                         |   79 ++++----
 fs/nfsd/netns.h                           |    4
 fs/nfsd/nfsctl.c                          |   25 ++
 fs/nfsd/nfsd.h                            |    2
 fs/nfsd/nfsfh.c                           |    3
 fs/nfsd/nfssvc.c                          |   11 -
 fs/nfsd/vfs.h                             |    5
 include/linux/nfs.h                       |    2
 include/linux/nfs_fs_sb.h                 |    3
 include/linux/nfslocalio.h                |   64 +++---
 24 files changed, 410 insertions(+), 405 deletions(-)

These latest changes are available in my git tree here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next

Chuck and Jeff, 2 patches have respective Not-Acked-by and
Not-Reviewed-by as placeholders because there were enough changes in
v15 that you'll need to revalidate your provided tags:
[PATCH v15 16/26] nfsd: add LOCALIO support
[PATCH v15 17/26] nfsd: implement server support for NFS_LOCALIO_PROGRAM

Otherwise, I did add the tags you provided from your review of v14.
Hopefully I didn't miss any.

Changes since v14 (Thursday):

- Reviewed, tested, fixed and incorporated NeilBrown's really nice
  solution for addressing net-ns refcounting issues he identified
  (first I didn't have adequate protection on net-ns then I had too
  heavy), see Neil's 6 replacement patches:
  https://marc.info/?l=linux-nfs&m=172498546024767&w=2

- Reviewed, tested and incorporated NeilBrown's __module_get
  improvements that build on his net-ns changes, see:
  https://marc.info/?l=linux-nfs&m=172499598828454&w=2  

- Added NeilBrown to the Copyright headers of 4 LOCALIO source files,
  warranted thanks to his contributions.

- Switched back from using 'struct nfs_localio_ctx' to 'struct
  nfsd_file' thanks to NeilBrown's suggestion, much cleaner:
  https://marc.info/?l=linux-nfs&m=172499732628938&w=2
  - added nfsd_file_put_local() to achieve this.

- Cleaned up and refactored nfsd_open_local_fh().

- Removed the more elaborate symbol_request()+symbol_put() code from
  nfs_common/nfslocalio.c in favor of having init_nfsd() copy its
  nfsd_localio_operations table to 'nfs_to'.

- Fixed the Kconfig to only need a single CONFIG_NFS_LOCALIO (which
  still selects NFS_COMMON_LOCALIO_SUPPORT to control how to build
  nfs_common's nfs_local enablement, support nfs_localio.ko).

- Verified all commits are bisect-clean both with and without
  CONFIG_NFS_LOCALIO set.
  - required adding some missing #if IS_ENABLED(CONFIG_NFS_LOCALIO)

- Added various Reviewed-by and Acked-by tags from Chuck and Jeff.
  But again, left Not-<tag> placeholders in nfsd patches 16 and 17.

- Reviwed and updated all patch headers as needed to reflect the above
  changes.

- Updated localio.rst to reflect all changes above and improved
  readability after another pass of proofreading.

- Added FAQ 8 to localio.rst (Chuck's question and Neil's answer about
  export options and LOCALIO.

- Moved verbose patch header content about the 2 major interlocking
  strategies used in LOCALIO to a new "NFS Client and Server
  Interlock" section in localio.rst (tied it to a new FAQ 9).

All review appreciated, thanks!
Mike

Chuck Lever (2):
  NFSD: Avoid using rqstp->rq_vers in nfsd_set_fh_dentry()
  NFSD: Short-circuit fh_verify tracepoints for LOCALIO

Mike Snitzer (12):
  nfs_common: factor out nfs_errtbl and nfs_stat_to_errno
  nfs_common: factor out nfs4_errtbl and nfs4_stat_to_errno
  nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
  nfsd: add nfsd_serv_try_get and nfsd_serv_put
  SUNRPC: remove call_allocate() BUG_ONs
  nfs_common: add NFS LOCALIO auxiliary protocol enablement
  nfs_common: prepare for the NFS client to use nfsd_file for LOCALIO
  nfsd: implement server support for NFS_LOCALIO_PROGRAM
  nfs: pass struct nfsd_file to nfs_init_pgio and nfs_init_commit
  nfs: implement client support for NFS_LOCALIO_PROGRAM
  nfs: add Documentation/filesystems/nfs/localio.rst
  nfs: add "NFS Client and Server Interlock" section to localio.rst

NeilBrown (5):
  NFSD: Handle @rqstp == NULL in check_nfsd_access()
  NFSD: Refactor nfsd_setuser_and_check_port()
  nfsd: factor out __fh_verify to allow NULL rqstp to be passed
  nfsd: add nfsd_file_acquire_local()
  SUNRPC: replace program list with program array

Trond Myklebust (4):
  nfs: enable localio for non-pNFS IO
  pnfs/flexfiles: enable localio support
  nfs/localio: use dedicated workqueues for filesystem read and write
  nfs: add FAQ section to Documentation/filesystems/nfs/localio.rst

Weston Andros Adamson (3):
  SUNRPC: add svcauth_map_clnt_to_svc_cred_local
  nfsd: add LOCALIO support
  nfs: add LOCALIO support

 Documentation/filesystems/nfs/localio.rst | 357 ++++++++++
 fs/Kconfig                                |  23 +
 fs/nfs/Kconfig                            |   1 +
 fs/nfs/Makefile                           |   1 +
 fs/nfs/client.c                           |  15 +-
 fs/nfs/filelayout/filelayout.c            |   6 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    |  56 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
 fs/nfs/inode.c                            |  57 +-
 fs/nfs/internal.h                         |  53 +-
 fs/nfs/localio.c                          | 757 ++++++++++++++++++++++
 fs/nfs/nfs2xdr.c                          |  70 +-
 fs/nfs/nfs3xdr.c                          | 108 +--
 fs/nfs/nfs4xdr.c                          |  84 +--
 fs/nfs/nfstrace.h                         |  61 ++
 fs/nfs/pagelist.c                         |  16 +-
 fs/nfs/pnfs_nfs.c                         |   2 +-
 fs/nfs/write.c                            |  12 +-
 fs/nfs_common/Makefile                    |   5 +
 fs/nfs_common/common.c                    | 134 ++++
 fs/nfs_common/nfslocalio.c                | 162 +++++
 fs/nfsd/Kconfig                           |   1 +
 fs/nfsd/Makefile                          |   1 +
 fs/nfsd/export.c                          |  30 +-
 fs/nfsd/filecache.c                       | 103 ++-
 fs/nfsd/filecache.h                       |   5 +
 fs/nfsd/localio.c                         | 189 ++++++
 fs/nfsd/netns.h                           |  12 +-
 fs/nfsd/nfsctl.c                          |  27 +-
 fs/nfsd/nfsd.h                            |   6 +-
 fs/nfsd/nfsfh.c                           | 137 ++--
 fs/nfsd/nfsfh.h                           |   2 +
 fs/nfsd/nfssvc.c                          | 102 ++-
 fs/nfsd/trace.h                           |  21 +-
 fs/nfsd/vfs.h                             |   2 +
 include/linux/nfs.h                       |   9 +
 include/linux/nfs_common.h                |  17 +
 include/linux/nfs_fs_sb.h                 |   9 +
 include/linux/nfs_xdr.h                   |  20 +-
 include/linux/nfslocalio.h                |  79 +++
 include/linux/sunrpc/svc.h                |   7 +-
 include/linux/sunrpc/svcauth.h            |   5 +
 net/sunrpc/clnt.c                         |   6 -
 net/sunrpc/svc.c                          |  68 +-
 net/sunrpc/svc_xprt.c                     |   2 +-
 net/sunrpc/svcauth.c                      |  28 +
 net/sunrpc/svcauth_unix.c                 |   3 +-
 47 files changed, 2468 insertions(+), 409 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/localio.rst
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfs_common/common.c
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 fs/nfsd/localio.c
 create mode 100644 include/linux/nfs_common.h
 create mode 100644 include/linux/nfslocalio.h

-- 
2.44.0


