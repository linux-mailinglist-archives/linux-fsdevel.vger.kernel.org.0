Return-Path: <linux-fsdevel+bounces-29966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161B5984290
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 11:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EB81C2280E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25A15D5B7;
	Tue, 24 Sep 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke8RdNqR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24823335A5;
	Tue, 24 Sep 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171295; cv=none; b=Ohe+4SJ9R4ybfLiTZeukZCXPVssJ2gdAOo/gJsLM8eaPDryeLVsnXfFd61sXWTEkiOk1Q0DGsY0lQ+EHE1E7pHrjb/u82cquRlgzua6G/g9w+3YCYrYtBxNvrVTxcnJmxiZoB9NAEAXUrkxDssC9/TT0Nk6i4LociSxrw0Ew1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171295; c=relaxed/simple;
	bh=IJb2CY2sQexSIpMJlLAZTjDzjCwF7sXuLr8nOkq3T5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDQl5yKkMBPM1x598Uw+2zPSySySHf4XUJ2W2CBedSIePBDwvfMjm+335kB9ZWPztlw2eoLYsjTBEBgKLTmotGFWtERbasj4s9xZSYAtGUs+3aK6aTTwBM+J/dRYpxqWVjuZCo5Y8kznPhElIv1yqDFVFXeZiYDCYlt2fCuMAeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke8RdNqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F92C4CEC4;
	Tue, 24 Sep 2024 09:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727171294;
	bh=IJb2CY2sQexSIpMJlLAZTjDzjCwF7sXuLr8nOkq3T5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ke8RdNqRNrJOuxH3G/Ln6qNlL6QGQ/daYetAAt1sBMZJ0y7LmzxW+cIsoaM+SDRcd
	 /NWgG9uAVX1OmTbwLZrk4VFMjmveHy1t4tOE37b5Y2dGlELjeIm7+IkM7UBrgbIziL
	 1QGpr3l1xvgyERkKlbolB+xbud5VGkGTGjU6JIA8yDzMBiKY+W2wzl5OhT5LmV3ZU0
	 eTUk0TlfWFAObQkz/Ll3WDJbzS8KBoTZ2//YyyX50l+Pw5hXRlPeVVhdVTv6UM9hLz
	 z8Sl1ai3JtBKE54ANx/ZqRBNkENUlruWITPhgRJV2uTN1PVF26og/aWR0YLlquICkM
	 l0CYDkm4yULGg==
Date: Tue, 24 Sep 2024 12:48:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/25] netfs: Use new folio_queue data type and
 iterator instead of xarray iter
Message-ID: <20240924094809.GA1182241@unreal>
References: <20240814203850.2240469-1-dhowells@redhat.com>
 <20240814203850.2240469-16-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240814203850.2240469-16-dhowells@redhat.com>

On Wed, Aug 14, 2024 at 09:38:35PM +0100, David Howells wrote:
> Make the netfs write-side routines use the new folio_queue struct to hold=
 a
> rolling buffer of folios, with the issuer adding folios at the tail and t=
he
> collector removing them from the head as they're processed instead of usi=
ng
> an xarray.
>=20
> This will allow a subsequent patch to simplify the write collector.
>=20
> The primary mark (as tested by folioq_is_marked()) is used to note if the
> corresponding folio needs putting.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/internal.h          |  9 +++-
>  fs/netfs/misc.c              | 76 ++++++++++++++++++++++++++++++++
>  fs/netfs/objects.c           |  1 +
>  fs/netfs/stats.c             |  4 +-
>  fs/netfs/write_collect.c     | 84 +++++++++++++++++++-----------------
>  fs/netfs/write_issue.c       | 28 ++++++------
>  include/linux/netfs.h        |  8 ++--
>  include/trace/events/netfs.h |  1 +
>  8 files changed, 150 insertions(+), 61 deletions(-)

According to git bisect, this commit causes to the following kernel
splat during boot of the system with 9p fs.

#
# Caches
#
CONFIG_NETFS_SUPPORT=3Dy
# CONFIG_NETFS_STATS is not set
# CONFIG_NETFS_DEBUG is not set
# CONFIG_FSCACHE is not set
# end of Caches

=2E..
CONFIG_9P_FS=3Dy
=2E..

[    1.510725][    T1] Run /sbin/init as init process
[    1.510937][    T1]   with arguments:
[    1.511060][    T1]     /sbin/init
[    1.511233][    T1]   with environment:
[    1.511332][    T1]     HOME=3D/
[    1.511448][    T1]     TERM=3Dlinux
[    1.516066][    T1] page: refcount:0 mapcount:0 mapping:0000000000000000=
 index:0x0 pfn:0x6ce48
[    1.516920][    T1] flags: 0x4000000000000000(zone=3D1)
[    1.517112][    T1] raw: 4000000000000000 ffffea0001b39248 ffffea0000158=
3c8 0000000000000000
[    1.517374][    T1] raw: 0000000000000000 0000000000000000 00000000fffff=
fff 0000000000000000
[    1.517767][    T1] page dumped because: VM_BUG_ON_FOLIO(((unsigned int)=
 folio_ref_count(folio) + 127u <=3D 127u))
[    1.518144][    T1] ------------[ cut here ]------------
[    1.518311][    T1] kernel BUG at include/linux/mm.h:1444!
[    1.518488][    T1] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC =
KASAN
[    1.518738][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
1.0+ #2488
[    1.518990][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    1.519325][    T1] RIP: 0010:__iov_iter_get_pages_alloc+0x16d4/0x2210
[    1.519540][    T1] Code: 84 f2 fa ff ff 48 89 ef e8 49 28 98 ff e9 e5 f=
a ff ff 48 8d 48 ff e9 2c fe ff ff 48 c7 c6 20 ee 21 83 48 89 cf e8 7c 2d 8=
a ff <0f> 0b 48 b8 00 00 00 00 00 fc ff df 4c 8b 74 24 68 44 8b 5c 24 30
[    1.520110][    T1] RSP: 0000:ffff8880060f6e40 EFLAGS: 00010286
[    1.520317][    T1] RAX: 000000000000005c RBX: ffffea0001b39234 RCX: 000=
0000000000000
[    1.520547][    T1] RDX: 000000000000005c RSI: 0000000000000004 RDI: fff=
fed1000c1edbb
[    1.520776][    T1] RBP: dffffc0000000000 R08: 0000000000000000 R09: fff=
ffbfff0718ce0
[    1.521027][    T1] R10: 0000000000000003 R11: 0000000000000001 R12: fff=
f8880065bd7e0                                                              =
                                                                    12:43:4=
5 [122/
[    1.521252][    T1] R13: ffff888006644000 R14: 0000000000000002 R15: 000=
0000000001000
[    1.521475][    T1] FS:  0000000000000000(0000) GS:ffff88806ce80000(0000=
) knlGS:0000000000000000
[    1.521761][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.521961][    T1] CR2: 0000000000000000 CR3: 0000000003881001 CR4: 000=
0000000370eb0
[    1.522200][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    1.522418][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    1.522636][    T1] Call Trace:
[    1.522750][    T1]  <TASK>
[    1.522823][    T1]  ? __die+0x52/0x8f
[    1.522939][    T1]  ? die+0x2a/0x50
[    1.523061][    T1]  ? do_trap+0x1d9/0x2c0
[    1.523163][    T1]  ? __iov_iter_get_pages_alloc+0x16d4/0x2210
[    1.523334][    T1]  ? do_error_trap+0xa3/0x160
[    1.523465][    T1]  ? __iov_iter_get_pages_alloc+0x16d4/0x2210
[    1.523633][    T1]  ? handle_invalid_op+0x2c/0x30
[    1.523765][    T1]  ? __iov_iter_get_pages_alloc+0x16d4/0x2210
[    1.523942][    T1]  ? exc_invalid_op+0x29/0x40
[    1.524087][    T1]  ? asm_exc_invalid_op+0x16/0x20
[    1.524238][    T1]  ? __iov_iter_get_pages_alloc+0x16d4/0x2210
[    1.524426][    T1]  ? iov_iter_extract_pages+0x1ee0/0x1ee0
[    1.524575][    T1]  ? radix_tree_node_alloc.constprop.0+0x16a/0x2c0
[    1.524762][    T1]  ? lock_acquire+0xe2/0x500
[    1.524916][    T1]  ? mark_lock+0xfc/0x2dc0
[    1.525071][    T1]  iov_iter_get_pages_alloc2+0x3d/0xe0
[    1.525208][    T1]  ? print_usage_bug.part.0+0x600/0x600
[    1.525392][    T1]  p9_get_mapped_pages.part.0.constprop.0+0x3bf/0x6c0
[    1.525595][    T1]  ? p9pdu_vwritef+0x320/0x1f20
[    1.525756][    T1]  ? p9_virtio_request+0x550/0x550
[    1.525918][    T1]  ? pdu_read+0xc0/0xc0
[    1.526056][    T1]  ? lock_release+0x220/0x780
[    1.526218][    T1]  ? pdu_read+0xc0/0xc0
[    1.526341][    T1]  p9_virtio_zc_request+0x728/0x1020
[    1.526501][    T1]  ? p9pdu_vwritef+0x320/0x1f20
[    1.526662][    T1]  ? p9_virtio_probe+0xa20/0xa20
[    1.526824][    T1]  ? netfs_read_to_pagecache+0x601/0xd50
[    1.526990][    T1]  ? mark_lock+0xfc/0x2dc0
[    1.527159][    T1]  ? p9pdu_finalize+0xdc/0x1d0
[    1.527321][    T1]  ? p9_client_prepare_req+0x235/0x360
[    1.527483][    T1]  ? p9_tag_alloc+0x6e0/0x6e0
[    1.527644][    T1]  ? lock_release+0x220/0x780
[    1.527806][    T1]  p9_client_zc_rpc.constprop.0+0x236/0x7d0
[    1.528013][    T1]  ? __create_object+0x5e/0x80
[    1.528175][    T1]  ? p9_client_flush.isra.0+0x390/0x390
[    1.528345][    T1]  ? lockdep_hardirqs_on_prepare+0x268/0x3e0
[    1.528544][    T1]  ? __call_rcu_common.constprop.0+0x475/0xc80
[    1.528785][    T1]  ? p9_req_put+0x17a/0x200
[    1.528944][    T1]  p9_client_read_once+0x343/0x840
[    1.529114][    T1]  ? p9_client_getlock_dotl+0x3c0/0x3c0
[    1.529274][    T1]  p9_client_read+0xf1/0x150
[    1.529440][    T1]  v9fs_issue_read+0x107/0x2c0
[    1.529608][    T1]  ? v9fs_issue_write+0x140/0x140
[    1.529736][    T1]  netfs_read_to_pagecache+0x601/0xd50
[    1.529858][    T1]  netfs_readahead+0x6af/0xbe0
[    1.530000][    T1]  read_pages+0x17b/0xaf0
[    1.530136][    T1]  ? lru_move_tail+0x8f0/0x8f0
[    1.530299][    T1]  ? file_ra_state_init+0xd0/0xd0
[    1.530479][    T1]  page_cache_ra_unbounded+0x324/0x5f0
[    1.530638][    T1]  filemap_get_pages+0x597/0x16b0
[    1.530801][    T1]  ? filemap_add_folio+0x140/0x140
[    1.530957][    T1]  ? lock_is_held_type+0x81/0xe0
[    1.531121][    T1]  filemap_read+0x2ec/0xa90
[    1.531282][    T1]  ? filemap_get_pages+0x16b0/0x16b0
[    1.531443][    T1]  ? 0xffffffff81000000
[    1.531565][    T1]  ? find_held_lock+0x2d/0x110
[    1.531720][    T1]  ? lock_is_held_type+0x81/0xe0
[    1.531888][    T1]  ? down_read_interruptible+0x1f6/0x490
[    1.532062][    T1]  ? down_read+0x450/0x450
[    1.532229][    T1]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
[    1.532435][    T1]  ? find_held_lock+0x2d/0x110
[    1.532594][    T1]  netfs_buffered_read_iter+0xe2/0x130
[    1.532755][    T1]  ? netfs_file_read_iter+0xb2/0x130
[    1.532904][    T1]  __kernel_read+0x2db/0x8a0
[    1.533066][    T1]  ? __x64_sys_lseek+0x1d0/0x1d0
[    1.533221][    T1]  bprm_execve+0x548/0x1410
[    1.533381][    T1]  ? setup_arg_pages+0xb40/0xb40
[    1.533534][    T1]  ? __cond_resched+0x17/0x70
[    1.533684][    T1]  kernel_execve+0x26a/0x2f0
[    1.533808][    T1]  try_to_run_init_process+0xf/0x30
[    1.533933][    T1]  ? rest_init+0x1b0/0x1b0
[    1.534064][    T1]  kernel_init+0xe2/0x140
[    1.534160][    T1]  ? _raw_spin_unlock_irq+0x24/0x30
[    1.534285][    T1]  ret_from_fork+0x2d/0x70
[    1.534415][    T1]  ? rest_init+0x1b0/0x1b0
[    1.534558][    T1]  ret_from_fork_asm+0x11/0x20
[    1.534730][    T1]  </TASK>
[    1.534858][    T1] Modules linked in:
[    1.535016][    T1] ---[ end trace 0000000000000000 ]---
[    1.535173][    T1] RIP: 0010:__iov_iter_get_pages_alloc+0x16d4/0x2210
[    1.535385][    T1] Code: 84 f2 fa ff ff 48 89 ef e8 49 28 98 ff e9 e5 f=
a ff ff 48 8d 48 ff e9 2c fe ff ff 48 c7 c6 20 ee 21 83 48 89 cf e8 7c 2d 8=
a ff <0f> 0b 48 b8 00 00 00 00 00 fc ff df 4c 8b 74 24 68 44 8b 5c 24 30
[    1.535967][    T1] RSP: 0000:ffff8880060f6e40 EFLAGS: 00010286
[    1.536183][    T1] RAX: 000000000000005c RBX: ffffea0001b39234 RCX: 000=
0000000000000
[    1.536426][    T1] RDX: 000000000000005c RSI: 0000000000000004 RDI: fff=
fed1000c1edbb
[    1.536667][    T1] RBP: dffffc0000000000 R08: 0000000000000000 R09: fff=
ffbfff0718ce0
[    1.536914][    T1] R10: 0000000000000003 R11: 0000000000000001 R12: fff=
f8880065bd7e0
[    1.537163][    T1] R13: ffff888006644000 R14: 0000000000000002 R15: 000=
0000000001000
[    1.537409][    T1] FS:  0000000000000000(0000) GS:ffff88806ce80000(0000=
) knlGS:0000000000000000
[    1.537842][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.538035][    T1] CR2: 0000000000000000 CR3: 0000000003881001 CR4: 000=
0000000370eb0
[    1.538281][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    1.538519][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    1.538779][    T1] ------------[ cut here ]------------
[    1.538904][    T1] WARNING: CPU: 1 PID: 1 at kernel/exit.c:886 do_exit+=
0x17c4/0x23a0
[    1.539110][    T1] Modules linked in:
[    1.539229][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Tainted: G     =
 D            6.11.0+ #2488
[    1.539459][    T1] Tainted: [D]=3DDIE
[    1.539567][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    1.539860][    T1] RIP: 0010:do_exit+0x17c4/0x23a0
[    1.540008][    T1] Code: bb 68 04 00 00 31 f6 e8 5a 92 ff ff e9 d6 f8 f=
f ff 4c 89 fe bf 05 06 00 00 e8 c8 53 02 00 e9 5c ec ff ff 0f 0b e9 b7 e8 f=
f ff <0f> 0b e9 27 ea ff ff 48 89 df e8 ad 90 ff ff 48 85 c0 49 89 c7 0f
[    1.540502][    T1] RSP: 0000:ffff8880060f7e68 EFLAGS: 00010286
[    1.540657][    T1] RAX: dffffc0000000000 RBX: ffff8880060e8000 RCX: 1ff=
ffffff07aebdf
[    1.540860][    T1] RDX: 1ffff11000c1d20b RSI: 0000000000000008 RDI: fff=
f8880060e9058
[    1.541078][    T1] RBP: ffff8880060e8708 R08: 0000000000000000 R09: fff=
ffbfff07ae5c1
[    1.541261][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f888006108000
[    1.541437][    T1] R13: ffff8880060e8710 R14: ffff888006100000 R15: 000=
000000000000b
[    1.541645][    T1] FS:  0000000000000000(0000) GS:ffff88806ce80000(0000=
) knlGS:0000000000000000
[    1.541875][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.542043][    T1] CR2: 0000000000000000 CR3: 0000000003881001 CR4: 000=
0000000370eb0
[    1.542237][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    1.542432][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    1.542622][    T1] Call Trace:
[    1.542733][    T1]  <TASK>
[    1.542801][    T1]  ? __warn.cold+0x5f/0x1ed
[    1.542930][    T1]  ? do_exit+0x17c4/0x23a0
[    1.543063][    T1]  ? report_bug+0x1e6/0x290
[    1.543190][    T1]  ? handle_bug+0x4f/0x90
[    1.543290][    T1]  ? exc_invalid_op+0x13/0x40
[    1.543418][    T1]  ? asm_exc_invalid_op+0x16/0x20
[    1.543545][    T1]  ? do_exit+0x17c4/0x23a0
[    1.543676][    T1]  ? do_exit+0x1c2/0x23a0
[    1.543774][    T1]  ? __cond_resched+0x17/0x70
[    1.543904][    T1]  ? is_current_pgrp_orphaned+0x90/0x90
[    1.544040][    T1]  ? kernel_execve+0x26a/0x2f0
[    1.544169][    T1]  ? __iov_iter_get_pages_alloc+0x16d4/0x2210
[    1.544329][    T1]  make_task_dead+0xf0/0x110
[    1.544462][    T1]  rewind_stack_and_make_dead+0x16/0x20
[    1.544595][    T1] RIP: 0000:0x0
[    1.544708][    T1] Code: Unable to access opcode bytes at 0xfffffffffff=
fffd6.
[    1.544903][    T1] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX=
: 0000000000000000
[    1.545098][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000=
0000000000000
[    1.545286][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    1.545489][    T1] RBP: 0000000000000000 R08: 0000000000000000 R09: 000=
0000000000000
[    1.545699][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 000=
0000000000000
[    1.545898][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
0000000000000
[    1.546099][    T1]  </TASK>
[    1.546198][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    1.546654][    T1] Kernel Offset: disabled
[    1.546769][    T1] ---[ end Kernel panic - not syncing: kernel: panic_o=
n_warn set ... ]---

Thanks

