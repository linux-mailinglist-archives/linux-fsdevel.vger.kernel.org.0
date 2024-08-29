Return-Path: <linux-fsdevel+bounces-27713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBD296374E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A47281D86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DE317C8D;
	Thu, 29 Aug 2024 01:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0RBJc1x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0F12B8B;
	Thu, 29 Aug 2024 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893465; cv=none; b=WNGgzTteNnk1dSKF8e892tXIVNH1QSTRn254WI7fYZWDYM8DLGf+vaSrjNqlikkS/KSoZEB0C6MqqH+S3xZLUAHoXdwM9240mejOn/7922v1KAmZfMYXUDuTlIq6iTZySxQl0SKHMqAqnObm+jUet3e2OHX+K786agARMVFbFfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893465; c=relaxed/simple;
	bh=xNZkWqa5RAya3AhZKEDF0YrweMWNq1MprZH2lezVSUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ND/NUvzGUWwQ4DLauwpsGFFGuHwzzwDz24qVUOuTFbCneL7hysyJM974aUsPrIaV29P4p6qRqz/nur1FqRB9QWVzTUkSMmBCw6Pj1wWDhzhgl5RtLZtLBu7vDxVBFORY0WycAH/0bG4pYYv3WAcHIg99rY+JFc1S6NAcThLoTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0RBJc1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE21C4CEC0;
	Thu, 29 Aug 2024 01:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893465;
	bh=xNZkWqa5RAya3AhZKEDF0YrweMWNq1MprZH2lezVSUE=;
	h=From:To:Cc:Subject:Date:From;
	b=o0RBJc1xZeM5EX9INeFa5LNSuRITbiLtXNyeiK9XGX7Cl7v/qVwM23omtSi3AYDnC
	 02o8YMJTbueykjcb55Nrmbb3hMo6fAgqQHmAHJ5wofeOCHzLf2tn4utkCbFfc0IQIB
	 dB6lL+LbZXKibkjsWdYD3y2FK3v71B6PoK5nimZvoFWrsr683bAOUDF4SfSo0m7A3w
	 6eDl1uYlWhe8vBpqwrtJkeNmS70tZNxnexnLg748nvePtg/BGe/r+MNNilTDV7tOX4
	 qdsff0H6QYz4Fdmt8sJ2ljMMv1FP5u/8dGKEOqlLfDnsFonJH1uLVdQdod4wWTNNsl
	 rQgdtgR+/XxPQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 00/25] nfs/nfsd: add support for LOCALIO
Date: Wed, 28 Aug 2024 21:03:55 -0400
Message-ID: <20240829010424.83693-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These latest changes are available in my git tree here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next

I _think_ I addressed all of v13's very helpful review comments.
Special thanks to Neil and Chuck for their time and help!

And hopefully I didn't miss anything in the changelog below.

Changes since v13:
- Extended the nn->nfsd_serv reference lifetime to be identical to the
  nfsd_file (until after localio's IO is complete), suggested by Neil.
  This is made easier by introducing a 'struct nfs_localio_ctx' that
  contains both the 'nfsd_file' and 'nfsd_net' associated with
  localio.

- Switched nfs_common's 'nfs_to' symbol management locking from using
  mutex to spinlock, suggested by Neil.

- Eliminated nfs_local_file_open() by folding it into
  nfs_local_open_fh(), suggested by Neil.

- Updated nfs_uuid_is_local() to get reference on the net, drop it in
  nfs_local_disable(), suggested by Neil.

- Pushed saving/restoring of client's cred down from
  nfsd_open_local_fh() to nfsd_file_acquire_local(), suggested by
  Neil.

- Dropped the pNFS flexfiles-specific open file caching that caused
  lifetime issues (inability to unmount backing filesystem), noticed
  by Neil. Also removed nfsd_file dummy definition as a side-effect.

- Updated NFSD_LOCALIO in fs/nfsd/Kconfig to explicitly 'default n'
  and improve description, suggested by Chuck. Also made the same
  updates to NFS_LOCALIO in fs/nfs/Kconfig.

- Split out a separate preliminary patch that introduces
  nfsd_serv_try_get() and nfsd_serv_put() and the associated
  percpu_ref, suggested by Chuck.

- Moved rpcauth_map_clnt_to_svc_cred_local from net/sunrpc/auth.c to
  net/sunrpc/svcauth.c and renamed it to
  svcauth_map_clnt_to_svc_cred_local. Also added kdoc. Suggested by
  Chuck.

- Added Chuck's Acked-by to 2 patches.

- Incorporated Chuck's 6 patches that split up and improved the
  __fh_verify and nfsd_file_acquire_local patches.  Added
  fh_verify_local as Chuck suggested.  Used Neil's improved comment
  for localio's early return from check_nfsd_access.

- Revised the answer to FAQ 6 in localio.rst, hopefully for the
  better.

- Fixed issue Neil pointed out about nfs_local_disable() racing with
  nfsd_open_local_fh() by adding the use of a clp->cl_localio_lock
  (spinlock_t) and RCU to dereference clp->cl_nfssvc_net and
  clp->cl_nfssvc_dom.  The call to nfsd_open_local_fh() is covered by
  RCU.

- Split the patch "nfs_common: add NFS LOCALIO auxiliary protocol
  enablement" out to 3 separate patches.  Hope is that it helps reduce
  review burden thanks to each patch header explaining things with
  more precision and detail.

All review appreciated, thanks!
Mike

Chuck Lever (2):
  NFSD: Avoid using rqstp->rq_vers in nfsd_set_fh_dentry()
  NFSD: Short-circuit fh_verify tracepoints for LOCALIO

Mike Snitzer (11):
  nfs_common: factor out nfs_errtbl and nfs_stat_to_errno
  nfs_common: factor out nfs4_errtbl and nfs4_stat_to_errno
  nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
  nfsd: add nfsd_serv_try_get and nfsd_serv_put
  SUNRPC: remove call_allocate() BUG_ONs
  nfs_common: add NFS LOCALIO auxiliary protocol enablement
  nfs_common: introduce nfs_localio_ctx struct and interfaces
  nfsd: implement server support for NFS_LOCALIO_PROGRAM
  nfs: pass struct nfs_localio_ctx to nfs_init_pgio and nfs_init_commit
  nfs: implement client support for NFS_LOCALIO_PROGRAM
  nfs: add Documentation/filesystems/nfs/localio.rst

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
  nfsd: add localio support
  nfs: add localio support

 Documentation/filesystems/nfs/localio.rst | 276 ++++++++
 fs/Kconfig                                |   3 +
 fs/nfs/Kconfig                            |  17 +
 fs/nfs/Makefile                           |   1 +
 fs/nfs/client.c                           |  15 +-
 fs/nfs/filelayout/filelayout.c            |   6 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    |  56 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
 fs/nfs/inode.c                            |  57 +-
 fs/nfs/internal.h                         |  53 +-
 fs/nfs/localio.c                          | 789 ++++++++++++++++++++++
 fs/nfs/nfs2xdr.c                          |  70 +-
 fs/nfs/nfs3xdr.c                          | 108 +--
 fs/nfs/nfs4xdr.c                          |  84 +--
 fs/nfs/nfstrace.h                         |  61 ++
 fs/nfs/pagelist.c                         |  16 +-
 fs/nfs/pnfs_nfs.c                         |   2 +-
 fs/nfs/write.c                            |  12 +-
 fs/nfs_common/Makefile                    |   5 +
 fs/nfs_common/common.c                    | 134 ++++
 fs/nfs_common/nfslocalio.c                | 233 +++++++
 fs/nfsd/Kconfig                           |  17 +
 fs/nfsd/Makefile                          |   1 +
 fs/nfsd/export.c                          |  30 +-
 fs/nfsd/filecache.c                       |  98 ++-
 fs/nfsd/filecache.h                       |   4 +
 fs/nfsd/localio.c                         | 180 +++++
 fs/nfsd/lockd.c                           |   6 +-
 fs/nfsd/netns.h                           |   8 +-
 fs/nfsd/nfsctl.c                          |   2 +-
 fs/nfsd/nfsd.h                            |   6 +-
 fs/nfsd/nfsfh.c                           | 141 ++--
 fs/nfsd/nfsfh.h                           |   2 +
 fs/nfsd/nfssvc.c                          | 105 ++-
 fs/nfsd/trace.h                           |  21 +-
 fs/nfsd/vfs.h                             |   7 +
 include/linux/nfs.h                       |   9 +
 include/linux/nfs_common.h                |  17 +
 include/linux/nfs_fs_sb.h                 |  10 +
 include/linux/nfs_xdr.h                   |  20 +-
 include/linux/nfslocalio.h                |  69 ++
 include/linux/sunrpc/svc.h                |   7 +-
 include/linux/sunrpc/svcauth.h            |   5 +
 net/sunrpc/clnt.c                         |   6 -
 net/sunrpc/svc.c                          |  68 +-
 net/sunrpc/svc_xprt.c                     |   2 +-
 net/sunrpc/svcauth.c                      |  28 +
 net/sunrpc/svcauth_unix.c                 |   3 +-
 48 files changed, 2467 insertions(+), 409 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/localio.rst
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfs_common/common.c
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 fs/nfsd/localio.c
 create mode 100644 include/linux/nfs_common.h
 create mode 100644 include/linux/nfslocalio.h

-- 
2.44.0


