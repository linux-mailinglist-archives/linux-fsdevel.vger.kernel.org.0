Return-Path: <linux-fsdevel+bounces-40053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFCAA1BBD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18625188FDBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C18121C165;
	Fri, 24 Jan 2025 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="JIbIB9RK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF5D1FDE1B;
	Fri, 24 Jan 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737741598; cv=none; b=YaIab6WBVVXTJxzgyog9onaBmRUS1VURC9UQDYjInfFnNS+hGkc8zjbarQEehqAjWHIrM3pZDCNqdVWybDHwstfzpV44giHOOnO+ksX6HRpsf62qOz/7K32l+gyxRTsxzqC8Ze/SA9xkG3aJmolx1v2QeVmEesLpwOwtxyax/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737741598; c=relaxed/simple;
	bh=BXEp/Ifx1dkFW+s6C1bLT7iPr5FF0eKvtB+OTekdsY0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENXO8vJB+N+TWZYcbv7YCyxZNPfvUVyha7ej4TU/97LYW7S3utIvs2MF/La1POGjayyLVMTnt5xz4GBMqWKWkpvK5r1vDD8cH5jrm0+gE6DYTAoqBm6G5X7bGAG3F1L6zhmLLtY89PhxTHFSOzsZqNmbLGBimSeKXwnjIn/JqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=JIbIB9RK; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737741587; x=1738000787;
	bh=4rrjsE+MvicrrQ6Y6gD9cIT/HyQUToaWe+K01zQPoq8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=JIbIB9RK1AoMS0k9EJR6pJxIvCsuc8wWj0+M0dglHO9q1JpdzdAmkHasYCrL6Xtg3
	 yZLr3M62KQpW6QElSB9M+pcd4aMm0HT2wqw0UCCvPmLAHp0lzj3Ee1K42YrTJnD1ZJ
	 iMniNpaAOj+ZqKs0nfS4IhVd194HyBZ9cNCQm9XctxK4WpskYdAABH7CX2J5lBkY13
	 e0IfEJyknM5ANHMu9Kt8dKBp9jMsb84bURnBlrw52rQdtq+69a5McLcAQtpO65sGdt
	 41iS4elHgn1exDbKEeUD8x2Poaxtujd+Vr2jIZyVsNGCPiSgDJOwnEXYL+xEoaLsuF
	 mLAK+CeNGGy/w==
Date: Fri, 24 Jan 2025 17:59:39 +0000
To: David Howells <dhowells@redhat.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Christian Brauner <christian@brauner.io>, Steve French <smfrench@gmail.com>, Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, Dominique Martinet <asmadeus@codewreck.org>, Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v5 27/32] netfs: Change the read result collector to only use one work item
Message-ID: <a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_xwDAhLvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=@pm.me>
In-Reply-To: <20241216204124.3752367-28-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com> <20241216204124.3752367-28-dhowells@redhat.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 2d63f4f4ff77fa7cfd9219388b78b772c9c2eebe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, December 16th, 2024 at 12:41 PM, David Howells <dhowells@redhat.=
com> wrote:

> Change the way netfslib collects read results to do all the collection fo=
r
> a particular read request using a single work item that walks along the
> subrequest queue as subrequests make progress or complete, unlocking foli=
os
> progressively rather than doing the unlock in parallel as parallel reques=
ts
> come in.
>=20
> The code is remodelled to be more like the write-side code, though only
> using a single stream. This makes it more directly comparable and thus
> easier to duplicate fixes between the two sides.
>=20
> This has a number of advantages:
>=20
> (1) It's simpler. There doesn't need to be a complex donation mechanism
> to handle mismatches between the size and alignment of subrequests and
> folios. The collector unlocks folios as the subrequests covering each
> complete.
>=20
> (2) It should cause less scheduler overhead as there's a single work item
> in play unlocking pages in parallel when a read gets split up into a
> lot of subrequests instead of one per subrequest.
>=20
> Whilst the parallellism is nice in theory, in practice, the vast
> majority of loads are sequential reads of the whole file, so
> committing a bunch of threads to unlocking folios out of order doesn't
> help in those cases.
>=20
> (3) It should make it easier to implement content decryption. A folio
> cannot be decrypted until all the requests that contribute to it have
> completed - and, again, most loads are sequential and so, most of the
> time, we want to begin decryption sequentially (though it's great if
> the decryption can happen in parallel).
>=20
> There is a disadvantage in that we're losing the ability to decrypt and
> unlock things on an as-things-arrive basis which may affect some
> applications.
>=20
> Signed-off-by: David Howells dhowells@redhat.com
>=20
> cc: Jeff Layton jlayton@kernel.org
>=20
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
> fs/9p/vfs_addr.c | 3 +-
> fs/afs/dir.c | 8 +-
> fs/ceph/addr.c | 9 +-
> fs/netfs/buffered_read.c | 160 ++++----
> fs/netfs/direct_read.c | 60 +--
> fs/netfs/internal.h | 21 +-
> fs/netfs/main.c | 2 +-
> fs/netfs/objects.c | 34 +-
> fs/netfs/read_collect.c | 716 ++++++++++++++++++++---------------
> fs/netfs/read_pgpriv2.c | 203 ++++------
> fs/netfs/read_retry.c | 207 +++++-----
> fs/netfs/read_single.c | 37 +-
> fs/netfs/write_collect.c | 4 +-
> fs/netfs/write_issue.c | 2 +-
> fs/netfs/write_retry.c | 14 +-
> fs/smb/client/cifssmb.c | 2 +
> fs/smb/client/smb2pdu.c | 5 +-
> include/linux/netfs.h | 16 +-
> include/trace/events/netfs.h | 79 +---
> 19 files changed, 819 insertions(+), 763 deletions(-)

Hello David.

After recent merge from upstream BPF CI started consistently failing
with a task hanging in v9fs_evict_inode. I bisected the failure to
commit e2d46f2ec332, pointing to this patch.

Reverting the patch seems to have helped:
https://github.com/kernel-patches/vmtest/actions/runs/12952856569

Could you please investigate?

Examples of failed jobs:
  * https://github.com/kernel-patches/bpf/actions/runs/12941732247
  * https://github.com/kernel-patches/bpf/actions/runs/12933849075

A log snippet:

    2025-01-24T02:15:03.9009694Z [  246.932163] INFO: task ip:1055 blocked =
for more than 122 seconds.
    2025-01-24T02:15:03.9013633Z [  246.932709]       Tainted: G           =
OE      6.13.0-g2bcb9cf535b8-dirty #149
    2025-01-24T02:15:03.9018791Z [  246.933249] "echo 0 > /proc/sys/kernel/=
hung_task_timeout_secs" disables this message.
    2025-01-24T02:15:03.9025896Z [  246.933802] task:ip              state:=
D stack:0     pid:1055  tgid:1055  ppid:1054   flags:0x00004002
    2025-01-24T02:15:03.9028228Z [  246.934564] Call Trace:
    2025-01-24T02:15:03.9029758Z [  246.934764]  <TASK>
    2025-01-24T02:15:03.9032572Z [  246.934937]  __schedule+0xa91/0xe80
    2025-01-24T02:15:03.9035126Z [  246.935224]  schedule+0x41/0xb0
    2025-01-24T02:15:03.9037992Z [  246.935459]  v9fs_evict_inode+0xfe/0x17=
0
    2025-01-24T02:15:03.9041469Z [  246.935748]  ? __pfx_var_wake_function+=
0x10/0x10
    2025-01-24T02:15:03.9043837Z [  246.936101]  evict+0x1ef/0x360
    2025-01-24T02:15:03.9046624Z [  246.936340]  __dentry_kill+0xb0/0x220
    2025-01-24T02:15:03.9048855Z [  246.936610]  ? dput+0x3a/0x1d0
    2025-01-24T02:15:03.9051128Z [  246.936838]  dput+0x114/0x1d0
    2025-01-24T02:15:03.9053548Z [  246.937069]  __fput+0x136/0x2b0
    2025-01-24T02:15:03.9056154Z [  246.937305]  task_work_run+0x89/0xc0
    2025-01-24T02:15:03.9058593Z [  246.937571]  do_exit+0x2c6/0x9c0
    2025-01-24T02:15:03.9061349Z [  246.937816]  do_group_exit+0xa4/0xb0
    2025-01-24T02:15:03.9064401Z [  246.938090]  __x64_sys_exit_group+0x17/=
0x20
    2025-01-24T02:15:03.9067235Z [  246.938390]  x64_sys_call+0x21a0/0x21a0
    2025-01-24T02:15:03.9069924Z [  246.938672]  do_syscall_64+0x79/0x120
    2025-01-24T02:15:03.9072746Z [  246.938941]  ? clear_bhb_loop+0x25/0x80
    2025-01-24T02:15:03.9075581Z [  246.939230]  ? clear_bhb_loop+0x25/0x80
    2025-01-24T02:15:03.9079275Z [  246.939510]  entry_SYSCALL_64_after_hwf=
rame+0x76/0x7e
    2025-01-24T02:15:03.9081976Z [  246.939875] RIP: 0033:0x7fb86f66f21d
    2025-01-24T02:15:03.9087533Z [  246.940153] RSP: 002b:00007ffdb3cf93f8 =
EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
    2025-01-24T02:15:03.9092590Z [  246.940689] RAX: ffffffffffffffda RBX: =
00007fb86f785fa8 RCX: 00007fb86f66f21d
    2025-01-24T02:15:03.9097722Z [  246.941201] RDX: 00000000000000e7 RSI: =
ffffffffffffff80 RDI: 0000000000000000
    2025-01-24T02:15:03.9102762Z [  246.941705] RBP: 00007ffdb3cf9450 R08: =
00007ffdb3cf93a0 R09: 0000000000000000
    2025-01-24T02:15:03.9107940Z [  246.942215] R10: 00007ffdb3cf92ff R11: =
0000000000000202 R12: 0000000000000001
    2025-01-24T02:15:03.9113002Z [  246.942723] R13: 0000000000000000 R14: =
0000000000000000 R15: 00007fb86f785fc0
    2025-01-24T02:15:03.9114614Z [  246.943244]  </TASK>
    2025-01-24T02:15:03.9115895Z [  246.943415]
    2025-01-24T02:15:03.9119326Z [  246.943415] Showing all locks held in t=
he system:
    2025-01-24T02:15:03.9122278Z [  246.943865] 1 lock held by khungtaskd/3=
2:
    2025-01-24T02:15:03.9128640Z [  246.944162]  #0: ffffffffa9195d90 (rcu_=
read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180
    2025-01-24T02:15:03.9131426Z [  246.944792] 2 locks held by kworker/0:2=
/86:
    2025-01-24T02:15:03.9132752Z [  246.945102]
    2025-01-24T02:15:03.9136561Z [  246.945222] =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

It's worth noting that that the hanging does not happen on *every*
test run, but often enough to fail the CI pipeline.

You may try reproducing with a container I used for bisection:

    docker pull ghcr.io/theihor/bpf:v9fs_evict_inode-repro
    docker run -d --privileged --device=3D/dev/kvm --cap-add ALL -v /path/t=
o/your/kernel/source:/ci/workspace ghcr.io/theihor/bpf:v9fs_evict_inode-rep=
ro
    docker exec -it <container_id_or_name> /bin/bash
    /ci/run.sh # in the container shell

Note that inside the container it's an "ubuntu" user, and you might
have to run `chown -R ubuntu:ubuntu /ci/workspace` first, or switch to
root.

> [...]


