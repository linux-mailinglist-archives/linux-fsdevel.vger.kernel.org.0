Return-Path: <linux-fsdevel+bounces-40058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9903FA1BC54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD42E188FD52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 18:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C686224AF2;
	Fri, 24 Jan 2025 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="E/l/7uJB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D9F1BEF9E;
	Fri, 24 Jan 2025 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744387; cv=none; b=nkNRpj8cFiXGu2O6uz4F+tZBMaF6/Ev4drNSi0u+OiBzBdQY5QJOPKtoUni0/Qv7sgN/dwr14vwAblf4LuL/6wYwk1+vN3NH9312h280MAUE9IyYkvkvt8TZpuVGKIAouRPgPgeiaIvxdX1CWdc7q5SBlQGGlxA256DxwcFj2Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744387; c=relaxed/simple;
	bh=YEjs1fwtkflEV259p++RHguTbAFij47wYlJev11bbHA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOwQeBtESCY/Dkj6bYJLL6zN+dXhSUEdkYJ0+JK0aT3sLQzSCjM4DVTI7i/aodqy6E0bwfIOGxYFtX+/iy5A/eOdexWlRtADCNyuM/61aGezbcMW7/SEEzcmqXJCTlPlHgdgO87mxoGMf3oboTgp6dgvOeWkzoKqAEHtYdn5kyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=E/l/7uJB; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737744376; x=1738003576;
	bh=NvncBzRcxeOI6PjLZFf+SX3ReeDVUDV3PW59X2TpDhc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=E/l/7uJBS3B/9TMGO9nRot5sTozJn/qHRVOeWlIeUIRZYQxD1JvByn3W/fRVPHLca
	 9tGvQDRnUw0gsyFHq+YtrWrLcJagwt4dOXTtm/sQfabB5Zgv3CscWb4u2OmKKsK7Rc
	 jLVK47aD8THve06aMMnJs2rGWPVQvCBJ+sSIi0jw1z25RWStSzwJ801g8znRZhFjm+
	 pZ+Gn3/eWykL3hC+a6Ea8d8xo6srlzRukBpcC7arjAmjFA6kf4H9iYf5KMjamZglYj
	 EeZrlMeTE6o7DVhQ5vMfjXLcnLWKBEsREGSvGReyIaqoVTtTPcmykYoYMqoyABCo7V
	 /fydUwU3Ms2kA==
Date: Fri, 24 Jan 2025 18:46:11 +0000
To: Marc Dionne <marc.dionne@auristor.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: David Howells <dhowells@redhat.com>, Christian Brauner <christian@brauner.io>, Steve French <smfrench@gmail.com>, Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, Dominique Martinet <asmadeus@codewreck.org>, Paulo Alcantara <pc@manguebit.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v5 27/32] netfs: Change the read result collector to only use one work item
Message-ID: <GHG6tQSGPRj9L93-skG-HGz4vGtXUxy6ibsUTKloUKncNmy8A7xgte0MEiI0iZJ7jD-SSrZiK2oswgvJCRan_0ZMi6xDlP11SHDi1Utf7mI=@pm.me>
In-Reply-To: <CAB9dFdtVFgG7OWZRytL9Vpr=knNPnMe6b_Esg7rgfFfwLa8j0A@mail.gmail.com>
References: <20241216204124.3752367-1-dhowells@redhat.com> <20241216204124.3752367-28-dhowells@redhat.com> <a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_xwDAhLvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=@pm.me> <CAB9dFdtVFgG7OWZRytL9Vpr=knNPnMe6b_Esg7rgfFfwLa8j0A@mail.gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 92d80bfc501a4c70e696781549a4c2f0bd1513cb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, January 24th, 2025 at 10:21 AM, Marc Dionne <marc.dionne@auristo=
r.com> wrote:

>=20
> [...]
>=20
> > A log snippet:
> >=20
> > 2025-01-24T02:15:03.9009694Z [ 246.932163] INFO: task ip:1055 blocked f=
or more than 122 seconds.
> > 2025-01-24T02:15:03.9013633Z [ 246.932709] Tainted: G OE 6.13.0-g2bcb9c=
f535b8-dirty #149
> > 2025-01-24T02:15:03.9018791Z [ 246.933249] "echo 0 > /proc/sys/kernel/h=
ung_task_timeout_secs" disables this message.
> > 2025-01-24T02:15:03.9025896Z [ 246.933802] task:ip state:D stack:0 pid:=
1055 tgid:1055 ppid:1054 flags:0x00004002
> > 2025-01-24T02:15:03.9028228Z [ 246.934564] Call Trace:
> > 2025-01-24T02:15:03.9029758Z [ 246.934764] <TASK>
> > 2025-01-24T02:15:03.9032572Z [ 246.934937] __schedule+0xa91/0xe80
> > 2025-01-24T02:15:03.9035126Z [ 246.935224] schedule+0x41/0xb0
> > 2025-01-24T02:15:03.9037992Z [ 246.935459] v9fs_evict_inode+0xfe/0x170
> > 2025-01-24T02:15:03.9041469Z [ 246.935748] ? __pfx_var_wake_function+0x=
10/0x10
> > 2025-01-24T02:15:03.9043837Z [ 246.936101] evict+0x1ef/0x360
> > 2025-01-24T02:15:03.9046624Z [ 246.936340] __dentry_kill+0xb0/0x220
> > 2025-01-24T02:15:03.9048855Z [ 246.936610] ? dput+0x3a/0x1d0
> > 2025-01-24T02:15:03.9051128Z [ 246.936838] dput+0x114/0x1d0
> > 2025-01-24T02:15:03.9053548Z [ 246.937069] __fput+0x136/0x2b0
> > 2025-01-24T02:15:03.9056154Z [ 246.937305] task_work_run+0x89/0xc0
> > 2025-01-24T02:15:03.9058593Z [ 246.937571] do_exit+0x2c6/0x9c0
> > 2025-01-24T02:15:03.9061349Z [ 246.937816] do_group_exit+0xa4/0xb0
> > 2025-01-24T02:15:03.9064401Z [ 246.938090] __x64_sys_exit_group+0x17/0x=
20
> > 2025-01-24T02:15:03.9067235Z [ 246.938390] x64_sys_call+0x21a0/0x21a0
> > 2025-01-24T02:15:03.9069924Z [ 246.938672] do_syscall_64+0x79/0x120
> > 2025-01-24T02:15:03.9072746Z [ 246.938941] ? clear_bhb_loop+0x25/0x80
> > 2025-01-24T02:15:03.9075581Z [ 246.939230] ? clear_bhb_loop+0x25/0x80
> > 2025-01-24T02:15:03.9079275Z [ 246.939510] entry_SYSCALL_64_after_hwfra=
me+0x76/0x7e
> > 2025-01-24T02:15:03.9081976Z [ 246.939875] RIP: 0033:0x7fb86f66f21d
> > 2025-01-24T02:15:03.9087533Z [ 246.940153] RSP: 002b:00007ffdb3cf93f8 E=
FLAGS: 00000202 ORIG_RAX: 00000000000000e7
> > 2025-01-24T02:15:03.9092590Z [ 246.940689] RAX: ffffffffffffffda RBX: 0=
0007fb86f785fa8 RCX: 00007fb86f66f21d
> > 2025-01-24T02:15:03.9097722Z [ 246.941201] RDX: 00000000000000e7 RSI: f=
fffffffffffff80 RDI: 0000000000000000
> > 2025-01-24T02:15:03.9102762Z [ 246.941705] RBP: 00007ffdb3cf9450 R08: 0=
0007ffdb3cf93a0 R09: 0000000000000000
> > 2025-01-24T02:15:03.9107940Z [ 246.942215] R10: 00007ffdb3cf92ff R11: 0=
000000000000202 R12: 0000000000000001
> > 2025-01-24T02:15:03.9113002Z [ 246.942723] R13: 0000000000000000 R14: 0=
000000000000000 R15: 00007fb86f785fc0
> > 2025-01-24T02:15:03.9114614Z [ 246.943244] </TASK>
>=20
>=20
> That looks very similar to something I saw in afs testing, with a
> similar stack but in afs_evict_inode where it hung waiting in
> netfs_wait_for_outstanding_io.
>=20
> David pointed to this bit where there's a double get in
> netfs_retry_read_subrequests, since netfs_reissue_read already takes
> care of getting a ref on the subrequest:
>=20
> diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
> index 2290af0d51ac..53d62e31a4cc 100644
> --- a/fs/netfs/read_retry.c
> +++ b/fs/netfs/read_retry.c
> @@ -152,7 +152,6 @@ static void netfs_retry_read_subrequests(struct
> netfs_io_request *rreq)
> __clear_bit(NETFS_SREQ_BOUNDARY,
> &subreq->flags);
>=20
> }
>=20
> - netfs_get_subrequest(subreq,
> netfs_sreq_trace_get_resubmit);
> netfs_reissue_read(rreq, subreq);
> if (subreq =3D=3D to)
> break;
>=20
> That seems to help for my afs test case, I suspect it might help in
> your case as well.

Hi Marc. Thank you for the suggestion.

I've just tried this diff on top of bpf-next (d0d106a2bd21):

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 2290af0d51ac..53d62e31a4cc 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -152,7 +152,6 @@ static void netfs_retry_read_subrequests(struct netfs_i=
o_request *rreq)
                                __clear_bit(NETFS_SREQ_BOUNDARY, &subreq->f=
lags);
                        }
=20
-                       netfs_get_subrequest(subreq, netfs_sreq_trace_get_r=
esubmit);
                        netfs_reissue_read(rreq, subreq);
                        if (subreq =3D=3D to)
                                break;


and I'm getting a hung task with the same stack

[  184.362292] INFO: task modprobe:2527 blocked for more than 20 seconds.
[  184.363173]       Tainted: G           OE      6.13.0-gd0d106a2bd21-dirt=
y #1
[  184.363651] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  184.364142] task:modprobe        state:D stack:0     pid:2527  tgid:2527=
  ppid:2134   flags:0x00000002
[  184.364743] Call Trace:
[  184.364907]  <TASK>
[  184.365057]  __schedule+0xa91/0xe80
[  184.365311]  schedule+0x41/0xb0
[  184.365525]  v9fs_evict_inode+0xfe/0x170
[  184.365782]  ? __pfx_var_wake_function+0x10/0x10
[  184.366082]  evict+0x1ef/0x360
[  184.366312]  __dentry_kill+0xb0/0x220
[  184.366561]  ? dput+0x3a/0x1d0
[  184.366765]  dput+0x114/0x1d0
[  184.366962]  __fput+0x136/0x2b0
[  184.367172]  __x64_sys_close+0x9e/0xd0
[  184.367443]  do_syscall_64+0x79/0x120
[  184.367685]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  184.368005] RIP: 0033:0x7f4c6fc7f60b
[  184.368249] RSP: 002b:00007ffc7582beb8 EFLAGS: 00000297 ORIG_RAX: 000000=
0000000003
[  184.368733] RAX: ffffffffffffffda RBX: 0000555e18cff7a0 RCX: 00007f4c6fc=
7f60b
[  184.369176] RDX: 00007f4c6fd64ee0 RSI: 0000000000000001 RDI: 00000000000=
00000
[  184.369634] RBP: 00007ffc7582bee0 R08: 0000000000000000 R09: 00000000000=
00007
[  184.370078] R10: 0000555e18cff980 R11: 0000000000000297 R12: 00000000000=
00000
[  184.370544] R13: 00007f4c6fd65030 R14: 0000555e18cff980 R15: 0000555e18d=
7b750
[  184.371004]  </TASK>
[  184.371151]
[  184.371151] Showing all locks held in the system:
[  184.371560] 1 lock held by khungtaskd/32:
[  184.371816]  #0: ffffffff83195d90 (rcu_read_lock){....}-{1:3}, at: debug=
_show_all_locks+0x2e/0x180
[  184.372397] 2 locks held by kworker/u8:21/2134:
[  184.372695]  #0: ffff9a5300104d48 ((wq_completion)events_unbound){+.+.}-=
{0:0}, at: process_scheduled_works+0x23a/0x600
[  184.373376]  #1: ffff9e9882187e20 ((work_completion)(&sub_info->work)){+=
.+.}-{0:0}, at: process_scheduled_works+0x25a/0x600
[  184.374075]
[  184.374182] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

So this appears to be something different.

>=20
> Marc

