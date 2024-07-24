Return-Path: <linux-fsdevel+bounces-24212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AD793B84C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 23:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BCF2854C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 21:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2CE13BC3D;
	Wed, 24 Jul 2024 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TX5MYsYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6751878C60;
	Wed, 24 Jul 2024 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721854826; cv=none; b=ijFpn7w3xsRjBT2FUW4mEL1SlmQjLzmNM6CEJ/LLEciqI3dnrweEl9W2+Z1vW0XreO7fWOxm9JlTZRJNX+g7ehgyklhx8WJfEnt76spXmvSIrxrCPyr7c0XThSrbSMST5JvgWPW4+F28rTx5z83UkgFZC3wPe/MvrVhBVUrq9yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721854826; c=relaxed/simple;
	bh=MWPyVHqyGAdLPGNh/jcvXb92SGEZuZ9xxlgHcr3qQcE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:References; b=A1j+ydKXNP4x5yl4fIWrgvs6IrUwTx6etrGsCEhl4LbBAQ3NY6G3z346N2hiShsgLna8q6SD5o2milajy8gkhYyI5/WZM4FXccfQ0MI794MwaLaaVomVXxc9Ysza2Olf5iL+zIw7Fec33WgodurhZe66ZVYXx+9f7QvwSICPur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TX5MYsYU; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240724210021euoutp0231d7e8e05684c7fd4c00635de6447bfd~lQdZhL_N12009420094euoutp02z;
	Wed, 24 Jul 2024 21:00:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240724210021euoutp0231d7e8e05684c7fd4c00635de6447bfd~lQdZhL_N12009420094euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721854821;
	bh=6BetKsi/JkRZ4DymqJrR3MQXQeSQizzSeZc0DIGgj2A=;
	h=Date:From:To:CC:Subject:References:From;
	b=TX5MYsYUAk/lCQnbloJX/1xyvmFoLoZq1rLyEKiXNvi8HcjkATrMtfJUG54sZ15uC
	 3xRNQ1Rdi4G19n6puLWjeC/DJO7G8cwLdX5Soo4n/mz7MkjaVQmXRfMBI1Leutbp89
	 tRWoWmCvNiNzvQdU2Ry8KKOp4aaf03qHXG2EXOng=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240724210021eucas1p14b3444339aa43fc76f8f3039d1a05213~lQdZG6ssu3068230682eucas1p1n;
	Wed, 24 Jul 2024 21:00:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 10.90.09875.46B61A66; Wed, 24
	Jul 2024 22:00:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61~lQdYcJjOV1618116181eucas1p2F;
	Wed, 24 Jul 2024 21:00:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240724210020eusmtrp23954d5dd21bfc13f1ff8cc809fa8fafb~lQdYZk0eX2668126681eusmtrp2q;
	Wed, 24 Jul 2024 21:00:20 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-ea-66a16b64e8e4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 94.8D.09010.46B61A66; Wed, 24
	Jul 2024 22:00:20 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240724210019eusmtip13c5484587fc1cc980c2235c6d2fb06c1~lQdYCFWSP1854318543eusmtip18;
	Wed, 24 Jul 2024 21:00:19 +0000 (GMT)
Received: from localhost (106.210.248.226) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 24 Jul 2024 22:00:19 +0100
Date: Wed, 24 Jul 2024 23:00:14 +0200
From: Joel Granados <j.granados@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Joel Granados <j.granados@samsung.com>, Thomas
	=?utf-8?B?V2Vp77+9c2NodWg=?= <linux@weissschuh.net>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Dave Chinner <david@fromorbit.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<netdev@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-xfs@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
	<bpf@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-hardening@vger.kernel.org>, <bridge@lists.linux.dev>,
	<mptcp@lists.linux.dev>, <lvs-devel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <rds-devel@oss.oracle.com>,
	<linux-sctp@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<apparmor@lists.ubuntu.com>
Subject: [GIT PULL] sysctl constification changes for v6.11-rc1
Message-ID: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxbZRTG8/Z+0qx46VBeGRZTw6KGIZKh7xxxLDHmqjEasg+VLK6xl68B
	W1rYhDkdHxPHJtSCgZWvyyaUwdJKYR0Flg1CWwYyYANC5qwRSt2AytayOAIWKZdl++933nOe
	85wneWlM2kKG0qmZWZwqU5EuJ8W42bY0vE15qD4p2nh+O8qz8QTy9tlJZL5wRoT+sxRhqN3m
	AMjgHiZQ1+AjERoxlxDIND1BoO6rN3BUa1wC6HZnNYkcl1YJNHJ9kEBjlw04cvX+iCOzt5BE
	mvoCDM3wcwR6cHaKRH3GIRx1rnRQaPmxS4SW//URqKDOg6FJzQxAvxnzKWTjX0AawwCObrZ5
	CTRV4qbiw9mB85A1NZ8mWZNHS7H9lcs42/bLd+y9tnOAHa6sB+zE5J84617uF7EjjfMk6zXJ
	2NIzNurTTV+I45RceupRTvXGuwfFKdPGIfJIyftfF5Q6qJNAu60YBNCQ2Q6tlVaiGIhpKdME
	4E8jnaRQLAKo/eN3IBReAMfLbOCJpMRu3JjSA9hYe+Xp1Klxz0bnMoBNP9eSfgnORMCrPX9T
	fiaZSDg8fxfzczATA733xtbdMUZDw/vGgnWPzcwu2Hx9eV0sYeKhpb8TFzgI3jjnXGdsbRHf
	5Xej13gL1Pto4bxXoMPUjQl8Ag603xH590Pmohg6eA8uNN6D47NdpMCb4ay9nRI4DK5a6jYE
	ZQBe8z2ghKJlLWjeI5EwtRMWjjkpvzNkdsPGK2kCBsJJd5BwWyDUmisw4VkCf/heKgi3whbH
	PC48h8GbnkANkOueCaZ7JpjuaTAeYM0ghMtWZyRz6phM7liUWpGhzs5MjvrqcIYJrP3nQZ99
	sQPoZx9G9QIRDXoBpDF5sMQ5W5MklSgVObmc6vCXqux0Tt0LttC4PEQSoQznpEyyIos7xHFH
	ONWTrogOCD0pSsiSv1ia274Ql2/wlOkKy3/tf9iz/0IANrvpwKVTqsSzi9U10qRxqjj/rRg+
	3i4RN6SVE/rKzxpuKZqfnzp2NyVs0rUQHJx12rdypyhi4aXVKn25rHrHCfcB88hxVpa79dr+
	uH+4o1yiqjV2IATVHdzbVvrcR0GWKllNxfxrhYbB1nco3jOD7TbHJFgCbr16cVT7wXRPTNW3
	Op9rqUwWG9lZc/xlsTOqwWplKdQ9tLrH0xpqGf0Qv/2xqykjX7lLvvNtG984l3g/Mjqh6BNL
	Wk4qN5RX/Hl7/UR40FL3N9H849ix4KK/VuTWitE9MumEbCzH5+6w7gif29eX4oyYkePqFMWb
	r2MqteJ/GkR62T4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsVy+t/xu7op2QvTDLoPsFo0HlvAavH5yHE2
	i22Lu5ks/u5sZ7bYcuweo8W6t+dZLXaf/spkcWFbH6vFpsfXWC327D3JYjFv/U9Gi8u75rBZ
	3Fvzn9XiwoHTrBZXtq5jsXh2qJfFYtvnFjaLCQubmS2eLnjNavGh5xGbxZH1Z1ksdv3ZwW7x
	+8czJovf3/+xWjTP/8RscWPCU0aLM+ub2C2OLRCzmLDuFIvFuc2fWS0e9b1ld5D3OLVIwmPT
	qk42j02fJrF7nJjxm8Vj85J6jxebZzJ6nJ+xkNHj2o37LB5vf59g8riw7A2bx+dNch793cfY
	A3ii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIe
	rz/LVtDnVtHcf4+9gXGSbhcjJ4eEgIlE3/H1bF2MXBxCAksZJe707mCDSMhIbPxylRXCFpb4
	c60Lqugjo8TXLcsZIZytjBJTdh4H62ARUJXYe/A5O4jNJqAjcf7NHWYQW0TASOLziyusIA3M
	AhM4JC6ufcgEkhAWsJdYdeA3WDOvgIPEzhO7WCBsQYmTM5+A2cxAgxbs/gRUwwFkS0ss/8cB
	cZGyxL1Ne5gh7FqJz3+fMU5gFJyFpHsWku5ZCN0LGJlXMYqklhbnpucWG+kVJ+YWl+al6yXn
	525iBCadbcd+btnBuPLVR71DjEwcjIcYJTiYlUR4n7yamybEm5JYWZValB9fVJqTWnyI0RTo
	5YnMUqLJ+cC0l1cSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwBTF
	0tF7WtTqeM4ChtjpIvcenUz32ptZELVps1HFvY5tSxe9u1d9fEbQ5tCZc/+qufas3iv5JrJi
	UYmw1RJxm7iw3RrFb+tWyV3qMFlc3n73gPrJk5W/M4t1E6PaGovOd97x9PhYxnFwWuf9728z
	n69fJvnLtdOsStty/Y2H5y71dBfs8tklcFFT8c3NHfyBP004lYyVxfL43586pmehNHNxaFdT
	yXL7it9h7D7RQb4Kj470CfDt4QkJzBApv3dczPzwsSexjw9ci9F7eOjKv3Qprr1Ha5T8c46u
	9FyZwxO+c/PSXpecxOmT5WRit8ZNvS7hwag7PW6uySJztcdHzj+SNeNRUeyKmHmwrTJ0phJL
	cUaioRZzUXEiAGTJglPDAwAA
X-CMS-MailID: 20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61
X-Msg-Generator: CA
X-RootMTR: 20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61
References: <CGME20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61@eucas1p2.samsung.com>

Linus

Constifying ctl_table structs will prevent the modification of
proc_handler function pointers as they would reside in .rodata. To get
there, the proc_handler arguments must first be const qualified which
requires this (fairly large) treewide PR. Sending it in the tail end of
of the merge window after a suggestion from Kees to avoid unneeded merge
conflicts. It has been rebased on top of 7a3fad30fd8b4b5e370906b3c554f64026f56c2f.
I can send it later if it makes more sense on your side; please tell me
what you prefer.

This PR applies on top of what I see as your latest master, but if you
need to generate it, you can do so by executing two commands:
1. Semantic patch: The coccinelle script is here [1]
  `make coccicheck MODE=patch SPFLAGS="--in-place --include-headers --smpl-spacing" COCCI=COCCI_SCRIPT`
2. Sed command: The sed script is here [2]
  `sed --in-place -f SED_SCRIPT fs/xfs/xfs_sysctl.c kernel/watchdog.c`
This is my first time sending out a semantic patch, so get back to me if
you have issues or prefer some other way of receiving it.

Testing was done in sysctl-testing (0-day) to avoid generating
unnecessary merge conflicts in linux-next. I do not expect any
error/regression given that all changes contained in this PR are
non-functional.

[1]
```
virtual patch

@r1@
identifier ctl, write, buffer, lenp, ppos;
identifier func !~ "appldata_(timer|interval)_handler|sched_(rt|rr)_handler|rds_tcp_skbuf_handler|proc_sctp_do_(hmac_alg|rto_min|rto_max|udp_port|alpha_beta|auth|probe_interval)";
@@

int func(
- struct ctl_table *ctl
+ const struct ctl_table *ctl
  ,int write, void *buffer, size_t *lenp, loff_t *ppos);

@r2@
identifier func, ctl, write, buffer, lenp, ppos;
@@

int func(
- struct ctl_table *ctl
+ const struct ctl_table *ctl
  ,int write, void *buffer, size_t *lenp, loff_t *ppos)
{ ... }

@r3@
identifier func;
@@

int func(
- struct ctl_table *
+ const struct ctl_table *
  ,int , void *, size_t *, loff_t *);

@r4@
identifier func, ctl;
@@

int func(
- struct ctl_table *ctl
+ const struct ctl_table *ctl
  ,int , void *, size_t *, loff_t *);

@r5@
identifier func, write, buffer, lenp, ppos;
@@

int func(
- struct ctl_table *
+ const struct ctl_table *
  ,int write, void *buffer, size_t *lenp, loff_t *ppos);
```

[2]
```
s/^xfs_stats_clear_proc_handler(const struct ctl_table \*ctl,$/xfs_stats_clear_proc_handler(\
\tconst struct ctl_table\t*ctl,/
s/^xfs_panic_mask_proc_handler(const struct ctl_table \*ctl,$/xfs_panic_mask_proc_handler(\
\tconst struct ctl_table\t*ctl,/
s/^xfs_deprecated_dointvec_minmax(const struct ctl_table \*ctl,$/xfs_deprecated_dointvec_minmax(\
\tconst struct ctl_table\t*ctl,/
s/proc_watchdog_common(int which, struct ctl_table \*table/proc_watchdog_common(int which, const struct ctl_table *table/
```

The following changes since commit 7a3fad30fd8b4b5e370906b3c554f64026f56c2f:

  Merge tag 'random-6.11-rc1-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random (2024-07-24 10:29:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/constfy-sysctl-6.11-rc1

for you to fetch changes up to 78eb4ea25cd5fdbdae7eb9fdf87b99195ff67508:

  sysctl: treewide: constify the ctl_table argument of proc_handlers (2024-07-24 20:59:29 +0200)

----------------------------------------------------------------
sysctl: treewide: constify the ctl_table argument of proc_handlers

Summary
- const qualify struct ctl_table args in proc_handlers:
  This is a prerequisite to moving the static ctl_table structs into .rodata
  data which will ensure that proc_handler function pointers cannot be
  modified.

----------------------------------------------------------------
Joel Granados (1):
      sysctl: treewide: constify the ctl_table argument of proc_handlers

 arch/arm64/kernel/armv8_deprecated.c      |  2 +-
 arch/arm64/kernel/fpsimd.c                |  2 +-
 arch/s390/appldata/appldata_base.c        | 10 ++---
 arch/s390/kernel/debug.c                  |  2 +-
 arch/s390/kernel/topology.c               |  2 +-
 arch/s390/mm/cmm.c                        |  6 +--
 arch/x86/kernel/itmt.c                    |  2 +-
 drivers/cdrom/cdrom.c                     |  4 +-
 drivers/char/random.c                     |  4 +-
 drivers/macintosh/mac_hid.c               |  2 +-
 drivers/net/vrf.c                         |  2 +-
 drivers/parport/procfs.c                  | 12 +++---
 drivers/perf/arm_pmuv3.c                  |  2 +-
 drivers/perf/riscv_pmu_sbi.c              |  2 +-
 fs/coredump.c                             |  2 +-
 fs/dcache.c                               |  2 +-
 fs/drop_caches.c                          |  2 +-
 fs/exec.c                                 |  2 +-
 fs/file_table.c                           |  2 +-
 fs/fs-writeback.c                         |  2 +-
 fs/inode.c                                |  2 +-
 fs/pipe.c                                 |  2 +-
 fs/quota/dquot.c                          |  2 +-
 fs/xfs/xfs_sysctl.c                       |  6 +--
 include/linux/ftrace.h                    |  4 +-
 include/linux/mm.h                        |  8 ++--
 include/linux/perf_event.h                |  6 +--
 include/linux/security.h                  |  2 +-
 include/linux/sysctl.h                    | 34 ++++++++--------
 include/linux/vmstat.h                    |  4 +-
 include/linux/writeback.h                 |  2 +-
 include/net/ndisc.h                       |  2 +-
 include/net/neighbour.h                   |  6 +--
 include/net/netfilter/nf_hooks_lwtunnel.h |  2 +-
 ipc/ipc_sysctl.c                          |  6 +--
 kernel/bpf/syscall.c                      |  4 +-
 kernel/delayacct.c                        |  2 +-
 kernel/events/callchain.c                 |  2 +-
 kernel/events/core.c                      |  4 +-
 kernel/fork.c                             |  2 +-
 kernel/hung_task.c                        |  2 +-
 kernel/kexec_core.c                       |  2 +-
 kernel/kprobes.c                          |  2 +-
 kernel/latencytop.c                       |  2 +-
 kernel/pid_namespace.c                    |  2 +-
 kernel/pid_sysctl.h                       |  2 +-
 kernel/printk/internal.h                  |  2 +-
 kernel/printk/printk.c                    |  2 +-
 kernel/printk/sysctl.c                    |  2 +-
 kernel/sched/core.c                       |  6 +--
 kernel/sched/rt.c                         |  8 ++--
 kernel/sched/topology.c                   |  2 +-
 kernel/seccomp.c                          |  2 +-
 kernel/stackleak.c                        |  2 +-
 kernel/sysctl.c                           | 64 +++++++++++++++----------------
 kernel/time/timer.c                       |  2 +-
 kernel/trace/ftrace.c                     |  2 +-
 kernel/trace/trace.c                      |  2 +-
 kernel/trace/trace_events_user.c          |  2 +-
 kernel/trace/trace_stack.c                |  2 +-
 kernel/umh.c                              |  2 +-
 kernel/utsname_sysctl.c                   |  2 +-
 kernel/watchdog.c                         | 12 +++---
 mm/compaction.c                           |  6 +--
 mm/hugetlb.c                              |  6 +--
 mm/page-writeback.c                       | 10 ++---
 mm/page_alloc.c                           | 14 +++----
 mm/util.c                                 |  6 +--
 mm/vmstat.c                               |  4 +-
 net/bridge/br_netfilter_hooks.c           |  2 +-
 net/core/neighbour.c                      | 18 ++++-----
 net/core/sysctl_net_core.c                | 20 +++++-----
 net/ipv4/devinet.c                        |  6 +--
 net/ipv4/route.c                          |  2 +-
 net/ipv4/sysctl_net_ipv4.c                | 30 +++++++--------
 net/ipv6/addrconf.c                       | 16 ++++----
 net/ipv6/ndisc.c                          |  2 +-
 net/ipv6/route.c                          |  2 +-
 net/ipv6/sysctl_net_ipv6.c                |  4 +-
 net/mpls/af_mpls.c                        |  4 +-
 net/mptcp/ctrl.c                          |  4 +-
 net/netfilter/ipvs/ip_vs_ctl.c            | 12 +++---
 net/netfilter/nf_conntrack_standalone.c   |  2 +-
 net/netfilter/nf_hooks_lwtunnel.c         |  2 +-
 net/netfilter/nf_log.c                    |  2 +-
 net/phonet/sysctl.c                       |  2 +-
 net/rds/tcp.c                             |  4 +-
 net/sctp/sysctl.c                         | 28 +++++++-------
 net/sunrpc/sysctl.c                       |  4 +-
 net/sunrpc/xprtrdma/svc_rdma.c            |  2 +-
 security/apparmor/lsm.c                   |  2 +-
 security/min_addr.c                       |  2 +-
 security/yama/yama_lsm.c                  |  2 +-
 93 files changed, 258 insertions(+), 258 deletions(-)

-- 

Joel Granados

