Return-Path: <linux-fsdevel+bounces-28409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC7C96A122
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCA928C29E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07CD154BE9;
	Tue,  3 Sep 2024 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZMgiMx5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EBE1422A2;
	Tue,  3 Sep 2024 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374964; cv=none; b=j5mUMN/0Y1RMMLaoMuC5YrAV2i8+dg9zXABDYkKa53XfPpGdp6MEMPHnTEfnsbG344lMMFeXKRAsQ59t2OIMzatgQOJ1eMLWGEB/a8EWd5LEa5jzyJd+XKwEB6stVFgWQWxRV9FmH6hgicRGxad7viN+t8b2FbtThgqr2o5nINI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374964; c=relaxed/simple;
	bh=j9d2naxOGqGBiaFh7JF6OW0pqP6YvjVse+dcm3sPyjU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mDa1MkMbTOypt0bO/ChrhsLW9cnuaJ7F8cSF7aOoMvOujlYa3PiFYQsmxrMiZ64bFWvZE/xWZsNDIJEFBbPgho2/TjgABN/C/u94xR1XT/IVVCs8uRjcwh1Ww9xuPS8euWW8zMj0GEJBasIYholaosBTwGdDe4BpYonarEHoLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZMgiMx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686E0C4CEC4;
	Tue,  3 Sep 2024 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725374964;
	bh=j9d2naxOGqGBiaFh7JF6OW0pqP6YvjVse+dcm3sPyjU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IZMgiMx5deqt3e09iuQocyjoUyyiLk0EkigpKI3/pi0/hUiCcRL9Hs98O3FjLswiU
	 84nwhgt0NRFHyHhOiG+Fi9pupXp/eXLA8oYs7uDiL11Ey5uZFLT8mWJciAY38XYXJG
	 LujH8fPmql0TaL+F/VToT9fsFULgc6sVOG3QvWG1pS64PMmeDluUtw+6+ARdH3a0L9
	 no7BJ9UZVjtel21HwIV8jQ2vNSJcom0VNhUR/tu7UbS+tbvXRBJdci9ITWNeGnhcSl
	 xmyqadM7Qq0sZi2zEtDb3sPkc26xTMDGeGxago+5o/cxT47oie/MdqoPTmkmyGQLLc
	 a/DdElF5Pvk3w==
Message-ID: <0bd8f46b4b4c1e0bc9008014e8442fa3a7f3afe5.camel@kernel.org>
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, 
 Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 linux-fsdevel@vger.kernel.org
Date: Tue, 03 Sep 2024 10:49:22 -0400
In-Reply-To: <20240831223755.8569-1-snitzer@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-08-31 at 18:37 -0400, Mike Snitzer wrote:
> Hi,
>=20
> Happy Labor Day weekend (US holiday on Monday)!  Seems apropos to send
> what I hope the final LOCALIO patchset this weekend: its my birthday
> this coming Tuesday, so _if_ LOCALIO were to get merged for 6.12
> inclusion sometime next week: best b-day gift in a while! ;)
>=20
> Anyway, I've been busy incorporating all the review feedback from v14
> _and_ working closely with NeilBrown to address some lingering net-ns
> refcounting and nfsd modules refcounting issues, and more (Chnagelog
> below):
>=20
> git diff snitzer/nfs-localio-for-next.v14 snitzer/nfs-localio-for-next.v1=
5 | diffstat
>  Documentation/filesystems/nfs/localio.rst |  106 +++++++++--
>  fs/Kconfig                                |   26 ++
>  fs/nfs/Kconfig                            |   16 -
>  fs/nfs/client.c                           |    4
>  fs/nfs/flexfilelayout/flexfilelayout.c    |    8
>  fs/nfs/internal.h                         |   24 +-
>  fs/nfs/localio.c                          |   92 +++------
>  fs/nfs/pagelist.c                         |    4
>  fs/nfs/write.c                            |    4
>  fs/nfs_common/nfslocalio.c                |  287 +++++++++++------------=
-------
>  fs/nfsd/Kconfig                           |   16 -
>  fs/nfsd/Makefile                          |    2
>  fs/nfsd/filecache.c                       |   27 +-
>  fs/nfsd/filecache.h                       |    1
>  fs/nfsd/localio.c                         |   79 ++++----
>  fs/nfsd/netns.h                           |    4
>  fs/nfsd/nfsctl.c                          |   25 ++
>  fs/nfsd/nfsd.h                            |    2
>  fs/nfsd/nfsfh.c                           |    3
>  fs/nfsd/nfssvc.c                          |   11 -
>  fs/nfsd/vfs.h                             |    5
>  include/linux/nfs.h                       |    2
>  include/linux/nfs_fs_sb.h                 |    3
>  include/linux/nfslocalio.h                |   64 +++---
>  24 files changed, 410 insertions(+), 405 deletions(-)
>=20
> These latest changes are available in my git tree here:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=
=3Dnfs-localio-for-next
>=20
> Chuck and Jeff, 2 patches have respective Not-Acked-by and
> Not-Reviewed-by as placeholders because there were enough changes in
> v15 that you'll need to revalidate your provided tags:
> [PATCH v15 16/26] nfsd: add LOCALIO support
> [PATCH v15 17/26] nfsd: implement server support for NFS_LOCALIO_PROGRAM
>=20
> Otherwise, I did add the tags you provided from your review of v14.
> Hopefully I didn't miss any.
>=20
> Changes since v14 (Thursday):
>=20
> - Reviewed, tested, fixed and incorporated NeilBrown's really nice
>   solution for addressing net-ns refcounting issues he identified
>   (first I didn't have adequate protection on net-ns then I had too
>   heavy), see Neil's 6 replacement patches:
>   https://marc.info/?l=3Dlinux-nfs&m=3D172498546024767&w=3D2
>=20
> - Reviewed, tested and incorporated NeilBrown's __module_get
>   improvements that build on his net-ns changes, see:
>   https://marc.info/?l=3Dlinux-nfs&m=3D172499598828454&w=3D2 =20
>=20
> - Added NeilBrown to the Copyright headers of 4 LOCALIO source files,
>   warranted thanks to his contributions.
>=20
> - Switched back from using 'struct nfs_localio_ctx' to 'struct
>   nfsd_file' thanks to NeilBrown's suggestion, much cleaner:
>   https://marc.info/?l=3Dlinux-nfs&m=3D172499732628938&w=3D2
>   - added nfsd_file_put_local() to achieve this.
>=20
> - Cleaned up and refactored nfsd_open_local_fh().
>=20
> - Removed the more elaborate symbol_request()+symbol_put() code from
>   nfs_common/nfslocalio.c in favor of having init_nfsd() copy its
>   nfsd_localio_operations table to 'nfs_to'.
>=20
> - Fixed the Kconfig to only need a single CONFIG_NFS_LOCALIO (which
>   still selects NFS_COMMON_LOCALIO_SUPPORT to control how to build
>   nfs_common's nfs_local enablement, support nfs_localio.ko).
>=20
> - Verified all commits are bisect-clean both with and without
>   CONFIG_NFS_LOCALIO set.
>   - required adding some missing #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>=20
> - Added various Reviewed-by and Acked-by tags from Chuck and Jeff.
>   But again, left Not-<tag> placeholders in nfsd patches 16 and 17.
>=20
> - Reviwed and updated all patch headers as needed to reflect the above
>   changes.
>=20
> - Updated localio.rst to reflect all changes above and improved
>   readability after another pass of proofreading.
>=20
> - Added FAQ 8 to localio.rst (Chuck's question and Neil's answer about
>   export options and LOCALIO.
>=20
> - Moved verbose patch header content about the 2 major interlocking
>   strategies used in LOCALIO to a new "NFS Client and Server
>   Interlock" section in localio.rst (tied it to a new FAQ 9).
>=20
> All review appreciated, thanks!
> Mike
>=20
> Chuck Lever (2):
>   NFSD: Avoid using rqstp->rq_vers in nfsd_set_fh_dentry()
>   NFSD: Short-circuit fh_verify tracepoints for LOCALIO
>=20
> Mike Snitzer (12):
>   nfs_common: factor out nfs_errtbl and nfs_stat_to_errno
>   nfs_common: factor out nfs4_errtbl and nfs4_stat_to_errno
>   nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
>   nfsd: add nfsd_serv_try_get and nfsd_serv_put
>   SUNRPC: remove call_allocate() BUG_ONs
>   nfs_common: add NFS LOCALIO auxiliary protocol enablement
>   nfs_common: prepare for the NFS client to use nfsd_file for LOCALIO
>   nfsd: implement server support for NFS_LOCALIO_PROGRAM
>   nfs: pass struct nfsd_file to nfs_init_pgio and nfs_init_commit
>   nfs: implement client support for NFS_LOCALIO_PROGRAM
>   nfs: add Documentation/filesystems/nfs/localio.rst
>   nfs: add "NFS Client and Server Interlock" section to localio.rst
>=20
> NeilBrown (5):
>   NFSD: Handle @rqstp =3D=3D NULL in check_nfsd_access()
>   NFSD: Refactor nfsd_setuser_and_check_port()
>   nfsd: factor out __fh_verify to allow NULL rqstp to be passed
>   nfsd: add nfsd_file_acquire_local()
>   SUNRPC: replace program list with program array
>=20
> Trond Myklebust (4):
>   nfs: enable localio for non-pNFS IO
>   pnfs/flexfiles: enable localio support
>   nfs/localio: use dedicated workqueues for filesystem read and write
>   nfs: add FAQ section to Documentation/filesystems/nfs/localio.rst
>=20
> Weston Andros Adamson (3):
>   SUNRPC: add svcauth_map_clnt_to_svc_cred_local
>   nfsd: add LOCALIO support
>   nfs: add LOCALIO support
>=20
>  Documentation/filesystems/nfs/localio.rst | 357 ++++++++++
>  fs/Kconfig                                |  23 +
>  fs/nfs/Kconfig                            |   1 +
>  fs/nfs/Makefile                           |   1 +
>  fs/nfs/client.c                           |  15 +-
>  fs/nfs/filelayout/filelayout.c            |   6 +-
>  fs/nfs/flexfilelayout/flexfilelayout.c    |  56 +-
>  fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
>  fs/nfs/inode.c                            |  57 +-
>  fs/nfs/internal.h                         |  53 +-
>  fs/nfs/localio.c                          | 757 ++++++++++++++++++++++
>  fs/nfs/nfs2xdr.c                          |  70 +-
>  fs/nfs/nfs3xdr.c                          | 108 +--
>  fs/nfs/nfs4xdr.c                          |  84 +--
>  fs/nfs/nfstrace.h                         |  61 ++
>  fs/nfs/pagelist.c                         |  16 +-
>  fs/nfs/pnfs_nfs.c                         |   2 +-
>  fs/nfs/write.c                            |  12 +-
>  fs/nfs_common/Makefile                    |   5 +
>  fs/nfs_common/common.c                    | 134 ++++
>  fs/nfs_common/nfslocalio.c                | 162 +++++
>  fs/nfsd/Kconfig                           |   1 +
>  fs/nfsd/Makefile                          |   1 +
>  fs/nfsd/export.c                          |  30 +-
>  fs/nfsd/filecache.c                       | 103 ++-
>  fs/nfsd/filecache.h                       |   5 +
>  fs/nfsd/localio.c                         | 189 ++++++
>  fs/nfsd/netns.h                           |  12 +-
>  fs/nfsd/nfsctl.c                          |  27 +-
>  fs/nfsd/nfsd.h                            |   6 +-
>  fs/nfsd/nfsfh.c                           | 137 ++--
>  fs/nfsd/nfsfh.h                           |   2 +
>  fs/nfsd/nfssvc.c                          | 102 ++-
>  fs/nfsd/trace.h                           |  21 +-
>  fs/nfsd/vfs.h                             |   2 +
>  include/linux/nfs.h                       |   9 +
>  include/linux/nfs_common.h                |  17 +
>  include/linux/nfs_fs_sb.h                 |   9 +
>  include/linux/nfs_xdr.h                   |  20 +-
>  include/linux/nfslocalio.h                |  79 +++
>  include/linux/sunrpc/svc.h                |   7 +-
>  include/linux/sunrpc/svcauth.h            |   5 +
>  net/sunrpc/clnt.c                         |   6 -
>  net/sunrpc/svc.c                          |  68 +-
>  net/sunrpc/svc_xprt.c                     |   2 +-
>  net/sunrpc/svcauth.c                      |  28 +
>  net/sunrpc/svcauth_unix.c                 |   3 +-
>  47 files changed, 2468 insertions(+), 409 deletions(-)
>  create mode 100644 Documentation/filesystems/nfs/localio.rst
>  create mode 100644 fs/nfs/localio.c
>  create mode 100644 fs/nfs_common/common.c
>  create mode 100644 fs/nfs_common/nfslocalio.c
>  create mode 100644 fs/nfsd/localio.c
>  create mode 100644 include/linux/nfs_common.h
>  create mode 100644 include/linux/nfslocalio.h
>=20

This all looks pretty good to me now too. There are some small issues,
but they should be easy to fix up. You can add this to the rest of the
series. Nice work!

Reviewed-by: Jeff Layton <jlayton@kernel.org>

