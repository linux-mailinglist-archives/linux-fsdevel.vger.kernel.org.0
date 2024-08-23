Return-Path: <linux-fsdevel+bounces-26959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7E095D4EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1154A1F235B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA6E191F6B;
	Fri, 23 Aug 2024 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gyg2ycKW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5742A9F;
	Fri, 23 Aug 2024 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436865; cv=none; b=t/635D0DaCTxlzv/w3VjWdipLuqFTc3wlDOeF4dj8qn6t20xhXNK7jFJ2+LzPXOuC3XunqXOiFP3s5QLx5FvchT1FH0Vj80gWMDxtFhYoVaqjJ7ym/yf4lGgUVDGEC6IvtLw0G864CbLqGjvFve21FgAUiDVePAMRxq/6ZPdxK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436865; c=relaxed/simple;
	bh=zWSKsvPWHcX4+RfKTGu0/IANwk8++jpzdOdARdWerxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJUZrkZpBvenIE/CNPrTEEhRAiCxF0pyDUUEdi2Ll8JAWyfYdBO8czZbd7b0W/unUZzERG35rjNSDzu39gZfMmQ4x+LqPRGKRVfmI9q+QtTVIhJa8v4ZrRFps4P8kzIzMpmhLP361A73sGAA8nztS8dqbjB7lwdwiFjdhyrPGU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gyg2ycKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D9FC32786;
	Fri, 23 Aug 2024 18:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724436865;
	bh=zWSKsvPWHcX4+RfKTGu0/IANwk8++jpzdOdARdWerxQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Gyg2ycKWnKT5bqvZix3vInkixerefhZbIKzPK1SR0RtNtrP4bTnMMbcftTXNh/N++
	 sxMyO7ud5IDeguaiqZJFdNr4CR3hgDp+yw4dlgF71bair38HGymI5t+3nFOzRjsN8O
	 V8NouVQEpuwkJ0iTO15KEgL7PRCFdqaShWo+hWpHNzWzDLlhi7aC4onJ6Q+uXNGDl5
	 nn9WYYgfqc9LDxI5zjZ2yzAkvyfNo+ooaezP6fk7Q6zTQJUne7a1HdR1sBCDTGcBfS
	 y/6o0rPGHwUdYUkzmA5ceFdXD37bFTYF1JHTW7rmmuQF8BhkgSWp5A4yEWFBoryUpc
	 2NPjOHxkdRPmQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 00/19] nfs/nfsd: add support for localio
Date: Fri, 23 Aug 2024 14:13:58 -0400
Message-ID: <20240823181423.20458-1-snitzer@kernel.org>
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

Changes since v12:
- Rebased to rearrange code to avoid "churn" that Jeff Layton felt
  distracting (biggest improvement came from folding switch from
  struct file to nfsd_file changes in from the start of the series)
- Updated relevant patch headers accordingly.
- Updated localio.rst to provide more performance data.
- Dropped v12's buggy "nfsd: fix nfsfh tracepoints to properly handle
  NULL rqstp" patch -- fixing localio to support fh_verify tracepoints
  will need more think-time and discussion, but they aren't of
  critical importance so fixing them doesn't need to hold things up.

Please also see v12's patch header for v12's extensive changes:
https://marc.info/?l=linux-nfs&m=172409139907981&w=2

Thanks,
Mike

Mike Snitzer (9):
  nfs_common: factor out nfs_errtbl and nfs_stat_to_errno
  nfs_common: factor out nfs4_errtbl and nfs4_stat_to_errno
  nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
  SUNRPC: remove call_allocate() BUG_ONs
  nfs_common: add NFS LOCALIO auxiliary protocol enablement
  nfsd: implement server support for NFS_LOCALIO_PROGRAM
  nfs: pass struct nfsd_file to nfs_init_pgio and nfs_init_commit
  nfs: implement client support for NFS_LOCALIO_PROGRAM
  nfs: add Documentation/filesystems/nfs/localio.rst

NeilBrown (3):
  nfsd: factor out __fh_verify to allow NULL rqstp to be passed
  nfsd: add nfsd_file_acquire_local()
  SUNRPC: replace program list with program array

Trond Myklebust (4):
  nfs: enable localio for non-pNFS IO
  pnfs/flexfiles: enable localio support
  nfs/localio: use dedicated workqueues for filesystem read and write
  nfs: add FAQ section to Documentation/filesystems/nfs/localio.rst

Weston Andros Adamson (3):
  SUNRPC: add rpcauth_map_clnt_to_svc_cred_local
  nfsd: add localio support
  nfs: add localio support

 Documentation/filesystems/nfs/localio.rst | 276 ++++++++
 fs/Kconfig                                |   3 +
 fs/nfs/Kconfig                            |  15 +
 fs/nfs/Makefile                           |   1 +
 fs/nfs/client.c                           |  15 +-
 fs/nfs/filelayout/filelayout.c            |   6 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    | 142 +++-
 fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
 fs/nfs/inode.c                            |  57 +-
 fs/nfs/internal.h                         |  61 +-
 fs/nfs/localio.c                          | 784 ++++++++++++++++++++++
 fs/nfs/nfs2xdr.c                          |  70 +-
 fs/nfs/nfs3xdr.c                          | 108 +--
 fs/nfs/nfs4xdr.c                          |  84 +--
 fs/nfs/nfstrace.h                         |  61 ++
 fs/nfs/pagelist.c                         |  16 +-
 fs/nfs/pnfs_nfs.c                         |   2 +-
 fs/nfs/write.c                            |  12 +-
 fs/nfs_common/Makefile                    |   5 +
 fs/nfs_common/common.c                    | 134 ++++
 fs/nfs_common/nfslocalio.c                | 194 ++++++
 fs/nfsd/Kconfig                           |  15 +
 fs/nfsd/Makefile                          |   1 +
 fs/nfsd/export.c                          |   8 +-
 fs/nfsd/filecache.c                       |  90 ++-
 fs/nfsd/filecache.h                       |   5 +
 fs/nfsd/localio.c                         | 183 +++++
 fs/nfsd/netns.h                           |   8 +-
 fs/nfsd/nfsctl.c                          |   2 +-
 fs/nfsd/nfsd.h                            |   6 +-
 fs/nfsd/nfsfh.c                           | 122 ++--
 fs/nfsd/nfsfh.h                           |   5 +
 fs/nfsd/nfssvc.c                          | 100 ++-
 fs/nfsd/trace.h                           |   3 +-
 fs/nfsd/vfs.h                             |  10 +
 include/linux/nfs.h                       |   9 +
 include/linux/nfs_common.h                |  17 +
 include/linux/nfs_fs_sb.h                 |  10 +
 include/linux/nfs_xdr.h                   |  20 +-
 include/linux/nfslocalio.h                |  56 ++
 include/linux/sunrpc/auth.h               |   4 +
 include/linux/sunrpc/svc.h                |   7 +-
 net/sunrpc/auth.c                         |  22 +
 net/sunrpc/clnt.c                         |   6 -
 net/sunrpc/svc.c                          |  68 +-
 net/sunrpc/svc_xprt.c                     |   2 +-
 net/sunrpc/svcauth_unix.c                 |   3 +-
 48 files changed, 2434 insertions(+), 402 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/localio.rst
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfs_common/common.c
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 fs/nfsd/localio.c
 create mode 100644 include/linux/nfs_common.h
 create mode 100644 include/linux/nfslocalio.h

-- 
2.44.0


