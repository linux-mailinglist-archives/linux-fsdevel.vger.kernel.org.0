Return-Path: <linux-fsdevel+bounces-3918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C017F9D34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 11:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1DE281439
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 10:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A8D182B3;
	Mon, 27 Nov 2023 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IdKAmu4X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B83C0;
	Mon, 27 Nov 2023 02:13:29 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231127101326euoutp01b0b182f6bc34d3b6173f936366385f9a~bc0C908XE0235902359euoutp01V;
	Mon, 27 Nov 2023 10:13:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231127101326euoutp01b0b182f6bc34d3b6173f936366385f9a~bc0C908XE0235902359euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701080006;
	bh=NQH5aPVZVe18Khb5fqSqA2OlfX7SEHlpgFddfPgDbuI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=IdKAmu4Xk0Un30nNt6XDtfvzWE9rLkF8zGmdQQ5ct8XMVOokzAK1ZCSY8492jbO/M
	 5bxyg5DRAE4gomRlwbWENfFVZdPKS39haEet8ikwD8tplWgP//Pb24COQ7XVud7hW+
	 ieTkFJJwbMxfJsSrmoo6SlTV7gSCVbzxAouQBRl0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231127101325eucas1p140cf8a8f9fd8fecb3dbe36c1413c71ff~bc0CxIB_22043720437eucas1p1Y;
	Mon, 27 Nov 2023 10:13:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 71.C3.09814.5CB64656; Mon, 27
	Nov 2023 10:13:25 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231127101325eucas1p23fdfc293d4ef5ff7c730f99a1efa184f~bc0CRanYo2415524155eucas1p2T;
	Mon, 27 Nov 2023 10:13:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231127101325eusmtrp19ea17127d320389bd9b61c6f52321c6b~bc0CQqAXA1967919679eusmtrp1x;
	Mon, 27 Nov 2023 10:13:25 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-f6-65646bc5ea0e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 07.00.09274.5CB64656; Mon, 27
	Nov 2023 10:13:25 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231127101325eusmtip11d0746c15cf59d05b42c668f7a7f3358~bc0CAn3No0812208122eusmtip1L;
	Mon, 27 Nov 2023 10:13:25 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 27 Nov 2023 10:13:24 +0000
Date: Mon, 27 Nov 2023 11:13:23 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin
	<yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 0/7] sysctl: constify sysctl ctl_tables
Message-ID: <20231127101323.sdnibmf7c3d5ovye@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="zn4hpd3vbxzf3eak"
Content-Disposition: inline
In-Reply-To: <20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djP87pHs1NSDa7N0bdoXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBbFJdNSmpOZllqkb5dAlfGtLb3TAVT7CqmTbzC0sD4XauLkZNDQsBE
	4tnOP6xdjFwcQgIrGCUebbnJBuF8YZSYMOksE0iVkMBnRomHO6xgOrZ0nmKCKFoO1NG8jB3C
	ASpqXPiIEcLZwijx5fdpRpAWFgFViS2rprKD2GwCOhLn39xhBrFFBGwkVn77DNbNLLCLSeLx
	w7lg+4QF7CV6Dq5jA7F5Bcwl1l47yQRhC0qcnPmEBcRmFqiQ6Dt2HOhyDiBbWmL5Pw6QMKeA
	q8SbG92MEKcqSXx908sKYddKnNpyC+xsCYHVnBKHd5+FKnKRWPL3HwuELSzx6vgWdghbRuL0
	5B4WiIbJjBL7/31gh+pmlFjW+JUJospaouXKE6gOR4mev2sZQS6SEOCTuPFWEOJQPolJ26Yz
	Q4R5JTrahCCq1SRW33vDMoFReRaS12YheW0WwmsQYT2JG1OnsGEIa0ssW/iaGcK2lVi37j3L
	Akb2VYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIFp7vS/4192MC5/9VHvECMTB+MhRhWg
	5kcbVl9glGLJy89LVRLh1fuYnCrEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7
	NbUgtQgmy8TBKdXAFBTZtH627BuNF838JRrRD/doxC+cLNLnPbPu8rna4GYJg3XrXU8UHX3Z
	vsOXwe7A77Me3E/uHjvp/U6xWPtkunWYTNzpwg0bRR2mCG5jFD346nokv7Kxxw9XTd3gS09q
	Hh1XPHS1a5my8zX3z29XcL8ur6hkY54kOped4XFTwe+0Q4Zps91FNjfveSctxJL8k2N1mMKp
	VXrbOVcX7b1ZFZi1wPLatsR7c7PK4vsT10pZMH9g/vJ9pdG39ztb0jwnvzVV7J3L91S+NaA3
	Kds3Yu9at+xl1W7vq+sP3psx7zaXPK/SoVX/C42rKjaoR8s927BXdG7EHKmpIabye7RaSlke
	/uOcqdUlmS63fReXEktxRqKhFnNRcSIAM52RqO4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsVy+t/xu7pHs1NSDY5e57doXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
	SmpOZllqkb5dgl7GpyULmAom2VVs+nuEvYHxq1YXIyeHhICJxJbOU0xdjFwcQgJLGSWmvtjJ
	ApGQkdj45SorhC0s8edaFxtE0UdGibWnJrNCOFsYJW733wbrYBFQldiyaio7iM0moCNx/s0d
	ZhBbRMBGYuW3z+wgDcwCu5gkHj+cywSSEBawl+g5uI4NxOYVMJdYe+0k1B0zGCWWrD/PApEQ
	lDg58wmQzQHUXSZxf5MOhCktsfwfB0gFp4CrxJsb3YwQlypJfH3TC3V1rcTnv88YJzAKz0Iy
	aBbCoFkIg0AqmIGO3rn1DhuGsLbEsoWvmSFsW4l1696zLGBkX8UoklpanJueW2ykV5yYW1ya
	l66XnJ+7iREY6duO/dyyg3Hlq496hxiZOBgPMaoAdT7asPoCoxRLXn5eqpIIr97H5FQh3pTE
	yqrUovz4otKc1OJDjKbAQJzILCWanA9MQXkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp
	2ampBalFMH1MHJxSDUxabWozHZi2GjW8aDzoaWiwWL9zysONl/g+af6x/+Cg0Ji2nJVXyCWv
	qF9z8i4Hfecnt369EdLziTdIVvyno7DQ56ncjXNT91vx58YxySy39NXRPX3XSdS34PWL+QXN
	jZ/PZqxZ6bNVObD0hUqpIceM04JNV07X1/OrXmxrXveted20Xh2LtrWztKZbx7zgUt2z+WF6
	PvdaHrNbN/axRNk+av0070dVlBGP5+8zf8NDTBhFJu1f8/+ijcOUWr+Sf8fqq1LXZXWUvlhn
	sv6H7NFZa7e4PX8233G+qfjGqWd/WL7bueZdy93NryR2h6ee5rop/t8ztjZXJ/fIbgvmbpl1
	+6a5OBn9P31lff7iEHslluKMREMt5qLiRAA3pGtoiQMAAA==
X-CMS-MailID: 20231127101325eucas1p23fdfc293d4ef5ff7c730f99a1efa184f
X-Msg-Generator: CA
X-RootMTR: 20231125125305eucas1p2ebdf870dd8ef46ea9d346f727b832439
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231125125305eucas1p2ebdf870dd8ef46ea9d346f727b832439
References: <CGME20231125125305eucas1p2ebdf870dd8ef46ea9d346f727b832439@eucas1p2.samsung.com>
	<20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>

--zn4hpd3vbxzf3eak
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Thomas

In general I would like to see more clarity with the motivation and I
would also expect some system testing. My comments inline:

On Sat, Nov 25, 2023 at 01:52:49PM +0100, Thomas Wei=DFschuh wrote:
> Problem description:
>=20
> The kernel contains a lot of struct ctl_table throught the tree.
> These are very often 'static' definitions.
> It would be good to mark these tables const to avoid accidental or
> malicious modifications.
It is unclear to me what you mean here with accidental or malicious
modifications. Do you have a specific attack vector in mind? Do you
have an example of how this could happen maliciously? With
accidental, do you mean in proc/sysctl.c? Can you expand more on the
accidental part?

What happens with the code that modifies these outside the sysctl core?
Like for example in sysctl_route_net_init where the table is modified
depending on the net->user_ns? Would these non-const ctl_table pointers
be ok? would they be handled differently?

> Unfortunately the tables can not be made const because the core
> registration functions expect mutable tables.
>=20
> This is for two reasons:
>=20
> 1) sysctl_{set,clear}_perm_empty_ctl_header in the sysctl core modify
>    the table. This should be fixable by only modifying the header
>    instead of the table itself.
> 2) The table is passed to the handler function as a non-const pointer.
>=20
> This series is an aproach on fixing reason 2).
So number 2 will be sent in another set?

>=20
> Full process:
>=20
> * Introduce field proc_handler_new for const handlers (this series)
> * Migrate all core handlers to proc_handler_new (this series, partial)
>   This can hopefully be done in a big switch, as it only involves
>   functions and structures owned by the core sysctl code.
> * Migrate all other sysctl handlers to proc_handler_new.
> * Drop the old proc_handler_field.
> * Fix the sysctl core to not modify the tables anymore.
> * Adapt public sysctl APIs to take "const struct ctl_table *".
> * Teach checkpatch.pl to warn on non-const "struct ctl_table"
>   definitions.
> * Migrate definitions of "struct ctl_table" to "const" where applicable.
> =20
>=20
> Notes:
>=20
> Just casting the function pointers around would trigger
> CFI (control flow integrity) warnings.
>=20
> The name of the new handler "proc_handler_new" is a bit too long messing
> up the alignment of the table definitions.
> Maybe "proc_handler2" or "proc_handler_c" for (const) would be better.
indeed the name does not say much. "_new" looses its meaning quite fast
:)

In my experience these tree wide modifications are quite tricky. Have you
run any tests to see that everything is as it was? sysctl selftests and
0-day come to mind.

Best
>=20
> ---
> Thomas Wei=DFschuh (7):
>       sysctl: add helper sysctl_run_handler
>       bpf: cgroup: call proc handler through helper
>       sysctl: add proc_handler_new to struct ctl_table
>       net: sysctl: add new sysctl table handler to debug message
>       treewide: sysctl: migrate proc_dostring to proc_handler_new
>       treewide: sysctl: migrate proc_dobool to proc_handler_new
>       treewide: sysctl: migrate proc_dointvec to proc_handler_new
>=20
>  arch/arm/kernel/isa.c                   |  6 +--
>  arch/csky/abiv1/alignment.c             |  8 ++--
>  arch/powerpc/kernel/idle.c              |  2 +-
>  arch/riscv/kernel/vector.c              |  2 +-
>  arch/s390/kernel/debug.c                |  2 +-
>  crypto/fips.c                           |  6 +--
>  drivers/char/hpet.c                     |  2 +-
>  drivers/char/random.c                   |  4 +-
>  drivers/infiniband/core/iwcm.c          |  2 +-
>  drivers/infiniband/core/ucma.c          |  2 +-
>  drivers/macintosh/mac_hid.c             |  4 +-
>  drivers/md/md.c                         |  4 +-
>  drivers/scsi/sg.c                       |  2 +-
>  drivers/tty/tty_io.c                    |  4 +-
>  fs/coda/sysctl.c                        |  6 +--
>  fs/coredump.c                           |  6 +--
>  fs/devpts/inode.c                       |  2 +-
>  fs/lockd/svc.c                          |  4 +-
>  fs/locks.c                              |  4 +-
>  fs/nfs/nfs4sysctl.c                     |  2 +-
>  fs/nfs/sysctl.c                         |  2 +-
>  fs/notify/dnotify/dnotify.c             |  2 +-
>  fs/ntfs/sysctl.c                        |  2 +-
>  fs/ocfs2/stackglue.c                    |  2 +-
>  fs/proc/proc_sysctl.c                   | 16 ++++---
>  fs/quota/dquot.c                        |  2 +-
>  include/linux/sysctl.h                  | 29 +++++++++---
>  init/do_mounts_initrd.c                 |  2 +-
>  io_uring/io_uring.c                     |  2 +-
>  ipc/mq_sysctl.c                         |  2 +-
>  kernel/acct.c                           |  2 +-
>  kernel/bpf/cgroup.c                     |  2 +-
>  kernel/locking/lockdep.c                |  4 +-
>  kernel/printk/sysctl.c                  |  4 +-
>  kernel/reboot.c                         |  4 +-
>  kernel/seccomp.c                        |  2 +-
>  kernel/signal.c                         |  2 +-
>  kernel/sysctl-test.c                    | 20 ++++-----
>  kernel/sysctl.c                         | 80 ++++++++++++++++-----------=
------
>  lib/test_sysctl.c                       | 10 ++---
>  mm/hugetlb.c                            |  2 +-
>  mm/hugetlb_vmemmap.c                    |  2 +-
>  mm/oom_kill.c                           |  4 +-
>  net/appletalk/sysctl_net_atalk.c        |  2 +-
>  net/core/sysctl_net_core.c              | 12 ++---
>  net/ipv4/route.c                        | 18 ++++----
>  net/ipv4/sysctl_net_ipv4.c              | 38 ++++++++--------
>  net/ipv4/xfrm4_policy.c                 |  2 +-
>  net/ipv6/addrconf.c                     | 72 ++++++++++++++-------------=
--
>  net/ipv6/route.c                        |  8 ++--
>  net/ipv6/sysctl_net_ipv6.c              | 18 ++++----
>  net/ipv6/xfrm6_policy.c                 |  2 +-
>  net/mptcp/ctrl.c                        |  2 +-
>  net/netfilter/ipvs/ip_vs_ctl.c          | 36 +++++++--------
>  net/netfilter/nf_conntrack_standalone.c |  8 ++--
>  net/netfilter/nf_log.c                  |  2 +-
>  net/rds/ib_sysctl.c                     |  2 +-
>  net/rds/sysctl.c                        |  6 +--
>  net/sctp/sysctl.c                       | 26 +++++------
>  net/sunrpc/xprtrdma/transport.c         |  2 +-
>  net/sysctl_net.c                        |  5 ++-
>  net/unix/sysctl_net_unix.c              |  2 +-
>  net/x25/sysctl_net_x25.c                |  2 +-
>  net/xfrm/xfrm_sysctl.c                  |  4 +-
>  64 files changed, 280 insertions(+), 262 deletions(-)
> ---
> base-commit: 0f5cc96c367f2e780eb492cc9cab84e3b2ca88da
> change-id: 20231116-const-sysctl-e14624f1295c
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

--=20

Joel Granados

--zn4hpd3vbxzf3eak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVka60ACgkQupfNUreW
QU+Hkgv/fsX1aDSSa8URhpWfgcWFNkt8gE1/YrLUf5bWFX84VcsLpNNFV7ugOfHF
z0U/ZhgJejIQ5VmcDhi8Un86x2YxQ6OQE5LD1Zbk2MKd1W49RGwAR8MRh0qlyHo+
poVDU8p+uf6yPSCUnXLgZlCa+hfohzKy/gbCZw/dQCNoRnfqTDq74vicXvs9pksB
4PM7fRQSyjwibHZeH/LVI2QsgR1rFXcYUHz6AMIYEMCmnQft79TaHwKQXSFLneXW
6H1uyxVsqQIhGhfM7Vxa40bLNyJ6uUoD2Gddf0o5wtALGds8B0aOhQepLbbVWgTw
lX35EnOW9HQg0MW4uR23KUQmMEf15GIdKXO1AJQfWRVKnBCM3U82oTMD0YWjL4oU
m7T/FW87L1eF2xxr+j1RQJqFnLf9Kd4i335UUrcbVKPCzhSQfWFSpy82pw0cq7Wk
4l2yqTSJSB14SzyKBudrciy4rQmF5QAn/SxmbPl9x2svw33umu+N2pjprBiPvSLX
wGXylbx9
=UfF8
-----END PGP SIGNATURE-----

--zn4hpd3vbxzf3eak--

