Return-Path: <linux-fsdevel+bounces-19576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 038998C744D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 12:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D35B1F22078
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 10:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0087D14388C;
	Thu, 16 May 2024 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LCl4wetQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852DC143754;
	Thu, 16 May 2024 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853775; cv=none; b=dPA/w2/GX2488A1dQByF9N6T13bGIjKQSwtRb/YALQJw2Zv8GXIub8oI2WThc9J1Q6NO3H/UQ3icLZHKYeTuXrpw12BVQobdFst9J5uxhMth58YZS+UwnnaXQRt1zvIl9v/idAVjUeqV5kcuxgJtI31SlvqM3pqtIq5BXTXeFKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853775; c=relaxed/simple;
	bh=fSDUWdbj6u4J90+ZqNskVcuj6+DewOQodyGSTeGQTWs=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:References; b=pn4sE+CXSfvbgdg6W5eBqhrZk7THA9fqF5s0IGaaC1Qt6dNig6MCmAy24x8BgFgOU/m6JidHFk4AYa0SmggaPngAk9agWZG5T7DEdZ31l1TxvVTG02QrEfIBi4rzM0hHdEQJadEQPQ+xc8SO16YZV2m7ZUgyxYDEIIUc+GKXLzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LCl4wetQ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240516100245euoutp01060b7d78c442949021f6b621596a18ac~P7_iKF1PM3237232372euoutp01R;
	Thu, 16 May 2024 10:02:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240516100245euoutp01060b7d78c442949021f6b621596a18ac~P7_iKF1PM3237232372euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715853765;
	bh=SwG1joKrd+CNmx/6bSQnQoreC0wo/ZKAfOe70CwpPVc=;
	h=Date:From:To:CC:Subject:References:From;
	b=LCl4wetQP64x7hcNpaDORW7xBXKbpB/iPZ8xjbeDGhw/YtTnQ9XGfAmQkVJLai5zN
	 XouO2OpAaoODJEdvi1AeW1GHFnK+IPg8jUyWjAEkKoQddRmIJBAjBJabmYxE4d7uQZ
	 8yphD1UgYtD2MdbTZ1uCyLyJ3LBozqR9D/lDr9HQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240516100244eucas1p253fbb235943d19ba8fc53d01c640242f~P7_iAdQ5d2964029640eucas1p2I;
	Thu, 16 May 2024 10:02:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id F3.6C.09624.4C9D5466; Thu, 16
	May 2024 11:02:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240516100244eucas1p1cd749a8cc08b1dc0b073e6f0832c2d52~P7_hhM-YY3101231012eucas1p1l;
	Thu, 16 May 2024 10:02:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240516100244eusmtrp2f2b0849d6be47377268ad1add2e5ca71~P7_hgarED1995119951eusmtrp27;
	Thu, 16 May 2024 10:02:44 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-f1-6645d9c43969
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D9.01.09010.4C9D5466; Thu, 16
	May 2024 11:02:44 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240516100244eusmtip23525e6f173207bd629e94a694730a33d~P7_hTam2n1162611626eusmtip2f;
	Thu, 16 May 2024 10:02:44 +0000 (GMT)
Received: from localhost (106.210.248.3) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 16 May 2024 11:02:43 +0100
Date: Thu, 16 May 2024 12:02:39 +0200
From: Joel Granados <j.granados@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas
	=?utf-8?B?V2Vp77+9c2NodWg=?= <linux@weissschuh.net>, Valentin Schneider
	<vschneid@redhat.com>, Kees Cook <keescook@chromium.org>, Joel Granados
	<j.granados@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [GIT PULL] sysctl changes for v6.10-rc1
Message-ID: <20240516100239.grazwwcra43imjg3@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="qbei5b5ac7ye43tq"
Content-Disposition: inline
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7djP87pHbrqmGcz+q2fx/fdsZosz3bkW
	e/aeZLG4vGsOm8XvH8+YLG5MeMposXi5msXx3gNMFv8ff2W12NfxgMniUd9bdoutR7+zO/B4
	zG64yOLRsu8Wu8fmFVoem1Z1snmcmPGbxeP9vqtsHuu3XGXx+LxJzqO/+xh7AGcUl01Kak5m
	WWqRvl0CV8b+xQvYC9ZrV7ROnsrewHhcoYuRk0NCwERiztcPjF2MXBxCAisYJZbeXcgO4Xxh
	lOh5cIIVwvnMKHH+8zI2mJbmCf+hEssZJeav2MYOkgCrenkaKrGZUWLWBYgOFgFViZmHzzOB
	2GwCOhLn39xhBrFFBIwkPr+4AtbALPCAWWJS2zNGkISwgIHEiUtLwJp5BRwk3v5/yghhC0qc
	nPmEBcRmFqiQaF56DKiGA8iWllj+jwPiOkWJdeevsEDYtRKnttxiApkvIbCfU+LEy2OsEAkX
	iTvb7zND2MISr45vYYewZST+75wP1TCZUWL/vw/sEM5qRolljV+ZIKqsJVquPIHqcJT4sfsc
	2BUSAnwSN94KQhzHJzFp23RmiDCvREebEES1msTqe29YIMIyEuc+8U1gVJqF5LNZSD6bhfAZ
	RFhHYsHuT5jC2hLLFr5mhrBtJdate8+ygJF9FaN4amlxbnpqsWFearlecWJucWleul5yfu4m
	RmCCPP3v+KcdjHNffdQ7xMjEwXiIUQWo+dGG1RcYpVjy8vNSlUR4RdKc04R4UxIrq1KL8uOL
	SnNSiw8xSnOwKInzqqbIpwoJpCeWpGanphakFsFkmTg4pRqY+BcdKPVoftwxcYXJPUuPc59L
	18UWqC39v8R9lpmr2Tc389L9Dv9nMa7cEdq/v0vfu6js8W3L8nx7+fPZ03kqDphe+RGQNv1Z
	ksP6p0YZP3Mf+CQtyfq/adYfhh9PAioqc7y42WKiIjZ0ftNfcneLTHf8pw2eE2cXft933DKU
	s4zd/1vk+eC+mT/n7Jz1ZNevO0fuT1TM2FxepDZnyqmyWdvb/s3fXLfR5ZPC1qkH39pJCU61
	crwQkL3m5mQ9HdOWkriEfxu805lsDCwtCn/2vIv3dvGYmMKz5qCG7/QHZ2MEA0JMZO7Vp3xf
	YbXHukR6TjOfrIahyeaz8tLHPkrcc2af9TTxy6zG+BIf2YXzlFiKMxINtZiLihMB23jDOQsE
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xe7pHbrqmGWx9IGjx/fdsZosz3bkW
	e/aeZLG4vGsOm8XvH8+YLG5MeMposXi5msXx3gNMFv8ff2W12NfxgMniUd9bdoutR7+zO/B4
	zG64yOLRsu8Wu8fmFVoem1Z1snmcmPGbxeP9vqtsHuu3XGXx+LxJzqO/+xh7AGeUnk1RfmlJ
	qkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbTTVwFa7Urnu25
	y9bAeFShi5GTQ0LARKJ5wn/WLkYuDiGBpYwS8/avZYJIyEhs/HKVFcIWlvhzrYsNougjo8T0
	5/NYIJzNjBInzl0Cq2IRUJWYefg8WDebgI7E+Td3mEFsEQEjic8vroCtYBZ4wCxxcONOdpCE
	sICBxIlLS9hAbF4BB4m3/58yQtiCEidnPmEBsZkFyiSWzLgL1MwBZEtLLP/HAXGRosS681dY
	IOxaic9/nzFOYBSchaR7FpLuWQjdEGEtiRv/XjJhCGtLLFv4mhnCtpVYt+49ywJG9lWMIqml
	xbnpucVGesWJucWleel6yfm5mxiBUb/t2M8tOxhXvvqod4iRiYPxEKMKUOejDasvMEqx5OXn
	pSqJ8IqkOacJ8aYkVlalFuXHF5XmpBYfYjQFhtZEZinR5HxgOsoriTc0MzA1NDGzNDC1NDNW
	Euf1LOhIFBJITyxJzU5NLUgtgulj4uCUamDafztlWaLLM2//k57vTb7dsPzL13J3Pt81s2M1
	j1p+r/Hd+7n4nIlVY2n6dF7llbufrrq6JbKCuyCrqdBh85OVuUf2q15PethhXrtmY+LOL5/u
	/r+WdifVdnH10bVPHzG8ebR2dvzzxMeH1h2/ujyD7UJovVflsd8xHLe/dbCtfX9g5bylR3m/
	Czboat3lOOepLLPg0GqLNXt+ilodTFx4Zo0i5xUjv5+r3qr3CZ3Ytz1XoFJV7X+osfXKTI5l
	krOvHOu+PrdJSvdL93x1pYm7V2ZeMgrzzpvw2NHopphh6u9JH7xeHvRzDJT66sPNerye7+30
	mnDdd+zvpL8rbPv29d2i9ljRB3OuSStZs+pNLVBiKc5INNRiLipOBAB/8JZljwMAAA==
X-CMS-MailID: 20240516100244eucas1p1cd749a8cc08b1dc0b073e6f0832c2d52
X-Msg-Generator: CA
X-RootMTR: 20240516100244eucas1p1cd749a8cc08b1dc0b073e6f0832c2d52
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240516100244eucas1p1cd749a8cc08b1dc0b073e6f0832c2d52
References: <CGME20240516100244eucas1p1cd749a8cc08b1dc0b073e6f0832c2d52@eucas1p1.samsung.com>

--qbei5b5ac7ye43tq
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysc=
tl-6.10-rc1

for you to fetch changes up to a35dd3a786f57903151b18275b1eed105084cf72:

  sysctl: drop now unnecessary out-of-bounds check (2024-04-24 09:43:54 +02=
00)

----------------------------------------------------------------
sysctl changes for v6.10-rc1

Summary
* Removed sentinel elements from ctl_table structs in kernel/*

  Removing sentinels in ctl_table arrays reduces the build time size and
  runtime memory consumed by ~64 bytes per array. Removals for net/, io_uri=
ng/,
  mm/, ipc/ and security/ are set to go into mainline through their respect=
ive
  subsystems making the next release the most likely place where the final
  series that removes the check for proc_name =3D=3D NULL will land. This P=
R adds
  to removals already in arch/, drivers/ and fs/.

* Adjusted ctl_table definitions and references to allow constification

  Adjustments:
    - Removing unused ctl_table function arguments
    - Moving non-const elements from ctl_table to ctl_table_header
    - Making ctl_table pointers const in ctl_table_root structure

  Making the static ctl_table structs const will increase safety by keeping=
 the
  pointers to proc_handler functions in .rodata. Though no ctl_tables where
  made const in this PR, the ground work for making that possible has start=
ed
  with these changes sent by Thomas Wei?schuh.

Testing
* These changes went into linux-next after v6.9-rc4; giving it a good month=
 of
  testing.

----------------------------------------------------------------
Joel Granados (10):
      kernel misc: Remove the now superfluous sentinel elements from ctl_ta=
ble array
      umh: Remove the now superfluous sentinel elements from ctl_table array
      ftrace: Remove the now superfluous sentinel elements from ctl_table a=
rray
      timekeeping: Remove the now superfluous sentinel elements from ctl_ta=
ble array
      seccomp: Remove the now superfluous sentinel elements from ctl_table =
array
      scheduler: Remove the now superfluous sentinel elements from ctl_tabl=
e array
      printk: Remove the now superfluous sentinel elements from ctl_table a=
rray
      kprobes: Remove the now superfluous sentinel elements from ctl_table =
array
      delayacct: Remove the now superfluous sentinel elements from ctl_tabl=
e array
      bpf: Remove the now superfluous sentinel elements from ctl_table array

Thomas Wei?schuh (5):
      sysctl: treewide: drop unused argument ctl_table_root::set_ownership(=
table)
      sysctl: treewide: constify argument ctl_table_root::permissions(table)
      sysctl: drop sysctl_is_perm_empty_ctl_table
      sysctl: move sysctl type to ctl_table_header
      sysctl: drop now unnecessary out-of-bounds check

 fs/proc/proc_sysctl.c            | 21 +++++++++------------
 include/linux/sysctl.h           | 25 ++++++++++++-------------
 ipc/ipc_sysctl.c                 |  5 ++---
 ipc/mq_sysctl.c                  |  5 ++---
 kernel/acct.c                    |  1 -
 kernel/bpf/syscall.c             |  1 -
 kernel/delayacct.c               |  1 -
 kernel/exit.c                    |  1 -
 kernel/hung_task.c               |  1 -
 kernel/kexec_core.c              |  1 -
 kernel/kprobes.c                 |  1 -
 kernel/latencytop.c              |  1 -
 kernel/panic.c                   |  1 -
 kernel/pid_namespace.c           |  1 -
 kernel/pid_sysctl.h              |  1 -
 kernel/printk/sysctl.c           |  1 -
 kernel/reboot.c                  |  1 -
 kernel/sched/autogroup.c         |  1 -
 kernel/sched/core.c              |  1 -
 kernel/sched/deadline.c          |  1 -
 kernel/sched/fair.c              |  1 -
 kernel/sched/rt.c                |  1 -
 kernel/sched/topology.c          |  1 -
 kernel/seccomp.c                 |  1 -
 kernel/signal.c                  |  1 -
 kernel/stackleak.c               |  1 -
 kernel/sysctl.c                  |  2 --
 kernel/time/timer.c              |  1 -
 kernel/trace/ftrace.c            |  1 -
 kernel/trace/trace_events_user.c |  1 -
 kernel/ucount.c                  |  5 ++---
 kernel/umh.c                     |  1 -
 kernel/utsname_sysctl.c          |  1 -
 kernel/watchdog.c                |  2 --
 net/sysctl_net.c                 |  3 +--
 35 files changed, 28 insertions(+), 67 deletions(-)

--=20

Joel Granados

--qbei5b5ac7ye43tq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmZF2b4ACgkQupfNUreW
QU/Fdwv+NkXa2MTyqmBA4u3wANPPDgd4QM9JlB9o/1mLlWaJRspyA7pmbS3waLkh
E10GqbL3fAkWUoSjrmD9X3hwuOn5/nHGYByGtI0oDCDBZ8eAHdGAxH/n+VPEoRIA
l543osxssK8Sr+MrxWSfEZVGpSSRKfdn+gA+hLzNLl5yPfazQuHlYIxBsG3B6X9J
bpX2dhSJzDpbXQWBqymtKklvV9aSK5J+zOtQuUZz8ThipC5rHxWylPxmYSfFY/sj
zEltgJsljZlbpG/Q6BdJIlIs5f9VtqsG3z3dT8kcmhJOc145JynkMcqul/h039aa
8QlZgbuBh0Ho04j3b+a92y8nvh4uEeNsKKyN1tkd5w2ci0kPrEP9ml5xWQgAlGFK
dpAQP8cJH56aGZjc2adw5v0tgaa0fLY5aJI+4kB00vzVJ4G8np3ST8MiIQ3HsNXk
9nUtbMGbMGFqXy4/EDQWraCRhqEd0JoTlo0IC2m+4jI7LV2nd1uLfbxHyhonxkS6
eM7eJFPX
=nRiH
-----END PGP SIGNATURE-----

--qbei5b5ac7ye43tq--

