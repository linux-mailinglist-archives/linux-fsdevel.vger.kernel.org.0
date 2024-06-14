Return-Path: <linux-fsdevel+bounces-21704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9B69089F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 12:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816461C25A4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 10:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C19F194A4C;
	Fri, 14 Jun 2024 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3zWYEmT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F371946A4
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jun 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360836; cv=none; b=MWltS/wu7bujG9XkVpmIoVO/qq53utQ+9edsB2nG9uLVQLKboFPIkIXFZDomaGQXnk+or04jfwrCtwse8ftZ1SwrlO3sWNOlsn43TqI1NNABPGW4j1ASKUIDh11wqjkPtkMxJeRmOTA9LiKvOeKgSA2sf7Ys8LoSDPEixzrIvYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360836; c=relaxed/simple;
	bh=uQwBR5/IeYNCJ2k2xmZxdPpu0fmtMqj4dPE01ycZ7Hw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TmmGFd2lJfSAsyVckNVXvsNxckEBbhp1N9WcstlCA6SfzvBiFp91qvDj1gt7a/aop+01Zr0cJNMx9qKvjf4/ardXGnS8PIpYrFJx7Y2hxlnLhhNfnRPV/U6+X9zNfcdFjKWwBDa4bfuxW1/psDMDTGkA4S9b+KF1UtI62yXH2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3zWYEmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92694C4AF1A;
	Fri, 14 Jun 2024 10:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718360836;
	bh=uQwBR5/IeYNCJ2k2xmZxdPpu0fmtMqj4dPE01ycZ7Hw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=I3zWYEmTz/8YNdjGXrtv0pLT2NkfCTQsetv4J/X73Nb9hx44KOghgTRK25JbxnJut
	 OQsAXpe6LjRn8qrxPgWlhnFlB2KNNG/aFqu5PG2iX0R/D/kC7En7mrq1byUjAX93od
	 0tLlbMNPNQvcSBh4PzCRAXUazhGl50hS4yH58jc/Rp2M7g08fxqJ5/ZIwBiy8R8Hrx
	 rGosuvNN4dTyvQOB8M/+21a6m0eO1OzNXe1XzxcFvYpEyoKEC2SI1z3H2aFaY0ZJBb
	 B1Tn+ochpkwRKbsQigqtL8z1pL4GlFlurlbm4R35Zw8vKddJsYp8a+yrWuDl/v+xMW
	 mzLeivhLCxaNg==
Message-ID: <724ffb0a2962e912ea62bb0515deadf39c325112.camel@kernel.org>
Subject: Re: [PATCH] Fix BUG: KASAN: use-after-free in
 trace_event_raw_event_filelock_lock
From: Jeff Layton <jlayton@kernel.org>
To: Light Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=98=8E=E7=87=88=29?=
	 <Light.Hsieh@mediatek.com>
Cc: Ed Tsai =?UTF-8?Q?=28=E8=94=A1=E5=AE=97=E8=BB=92=29?=
 <Ed.Tsai@mediatek.com>, linux-fsdevel@vger.kernel.org,
 chuck.lever@oracle.com,  alex.aring@gmail.com
Date: Fri, 14 Jun 2024 06:27:14 -0400
In-Reply-To: <SI2PR03MB5260D225AAF32A837882210784C22@SI2PR03MB5260.apcprd03.prod.outlook.com>
References: <20230721051904.9317-1-Will.Shiu@mediatek.com>
	 <d50c6c34035f1a0b143507d9ab9fcf0d27a5dc86.camel@kernel.org>
	 <SI2PR03MB554528497A79492CCAC040808BC22@SI2PR03MB5545.apcprd03.prod.outlook.com>
	 <SI2PR03MB5260D225AAF32A837882210784C22@SI2PR03MB5260.apcprd03.prod.outlook.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40app1) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-14 at 06:31 +0000, Light Hsieh (=E8=AC=9D=E6=98=8E=E7=87=88=
) wrote:
> Hi, Jeff
>=20
> We still get use-after-free  issue on trace_posix_lock_inode() within pos=
ix_lock_inodes().
> Do you think invoke trace_posix_lock_inode() just before spin_unlock(&ctx=
->flc_lock) is better?
>=20

(cc'ing linux-fsdevel and the other file locking maintainers)

Thanks for the bug report!

Note that the UAF was detected in the context of pid 26303, but the
object was allocated and freed by pid 26304. So, this is a race between
threads.

I suspect that what's happening is that the "request" pointer is being
overwritten by one of the objects on the list and then that lock is
being freed after we release the spinlock but before the tracepoint
happens.

Moving the tracepoint inside the spinlock does sound like what we need
to do. Care to propose a patch?

Thanks,
Jeff

> [36705.493785] [T626354] BackgroundHandl: audit: audit_lost=3D637997 audi=
t_rate_limit=3D5 audit_backlog_limit=3D64
> [36705.493799] [T626354] BackgroundHandl: audit: rate limit exceeded
> [36705.558088] [T226303] BackgroundHandl: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [36705.558104] [T226303] BackgroundHandl: BUG: KASAN: slab-use-after-free=
 in trace_event_raw_event_filelock_lock+0x7c/0x128
> [36705.558123] [T226303] BackgroundHandl: Read at addr fbffff80d9ea9dc0 b=
y task BackgroundHandl/26303
> [36705.558129] [T226303] BackgroundHandl: Pointer tag: [fb], memory tag: =
[fe]
> [36705.558132] [T226303] BackgroundHandl:=20
> [36705.558136] [T226303] BackgroundHandl: CPU: 2 PID: 26303 Comm: Backgro=
undHandl Tainted: G        W  OE      6.6.29-android15-5-gaace8ad45e01 #1
> [36705.558142] [T226303] BackgroundHandl: Hardware name: MT6991(ENG) (DT)
> [36705.558145] [T226303] BackgroundHandl: Call trace:
> [36705.558148] [T226303] BackgroundHandl:  dump_backtrace+0xec/0x138
> [36705.558155] [T226303] BackgroundHandl:  show_stack+0x18/0x24
> [36705.558159] [T226303] BackgroundHandl:  dump_stack_lvl+0x50/0x6c
> [36705.558165] [T226303] BackgroundHandl:  print_report+0x1b0/0x714
> [36705.558175] [T226303] BackgroundHandl:  kasan_report+0xc4/0x124
> [36705.558179] [T226303] BackgroundHandl:  __do_kernel_fault+0xbc/0x2d4
> [36705.558191] [T226303] BackgroundHandl:  do_bad_area+0x30/0xdc
> [36705.558196] [T226303] BackgroundHandl:  do_tag_check_fault+0x20/0x34
> [36705.558200] [T226303] BackgroundHandl:  do_mem_abort+0x58/0x118
> [36705.558205] [T226303] BackgroundHandl:  el1_abort+0x3c/0x5c
> [36705.558209] [T226303] BackgroundHandl:  el1h_64_sync_handler+0x54/0x90
> [36705.558213] [T226303] BackgroundHandl:  el1h_64_sync+0x68/0x6c
> [36705.558217] [T226303] BackgroundHandl:  trace_event_raw_event_filelock=
_lock+0x7c/0x128
> [36705.558222] [T226303] BackgroundHandl:  posix_lock_inode+0xe34/0xe94
> [36705.558228] [T226303] BackgroundHandl:  do_lock_file_wait+0xc4/0x1a4
> [36705.558234] [T226303] BackgroundHandl:  fcntl_setlk+0x2dc/0x448
> [36705.558239] [T226303] BackgroundHandl:  do_fcntl+0x90/0x570
> [36705.558251] [T226303] BackgroundHandl:  __arm64_sys_fcntl+0x7c/0xc8
> [36705.558256] [T226303] BackgroundHandl:  invoke_syscall+0x58/0x114
> [36705.558269] [T226303] BackgroundHandl:  el0_svc_common+0x80/0xe0
> [36705.558274] [T226303] BackgroundHandl:  do_el0_svc+0x1c/0x28
> [36705.558279] [T226303] BackgroundHandl:  el0_svc+0x38/0x68
> [36705.558283] [T226303] BackgroundHandl:  el0t_64_sync_handler+0x68/0xbc
> [36705.558287] [T226303] BackgroundHandl:  el0t_64_sync+0x1a8/0x1ac
> [36705.558290] [T226303] BackgroundHandl:=20
> [36705.558292] [T226303] BackgroundHandl: Allocated by task 26304:
> [36705.558296] [T226303] BackgroundHandl:  kasan_save_stack+0x40/0x70
> [36705.558300] [T226303] BackgroundHandl:  save_stack_info+0x34/0x128
> [36705.558306] [T226303] BackgroundHandl:  kasan_save_alloc_info+0x14/0x2=
0
> [36705.558310] [T226303] BackgroundHandl:  __kasan_slab_alloc+0x168/0x174
> [36705.558315] [T226303] BackgroundHandl:  slab_post_alloc_hook+0x88/0x3a=
4
> [36705.558331] [T226303] BackgroundHandl:  kmem_cache_alloc+0x18c/0x2c8
> [36705.558336] [T226303] BackgroundHandl:  posix_lock_inode+0xb4/0xe94
> [36705.558341] [T226303] BackgroundHandl:  do_lock_file_wait+0xc4/0x1a4
> [36705.558346] [T226303] BackgroundHandl:  fcntl_setlk+0x2dc/0x448
> [36705.558350] [T226303] BackgroundHandl:  do_fcntl+0x90/0x570
> [36705.558355] [T226303] BackgroundHandl:  __arm64_sys_fcntl+0x7c/0xc8
> [36705.558360] [T226303] BackgroundHandl:  invoke_syscall+0x58/0x114
> [36705.558365] [T226303] BackgroundHandl:  el0_svc_common+0x80/0xe0
> [36705.558370] [T226303] BackgroundHandl:  do_el0_svc+0x1c/0x28
> [36705.558375] [T226303] BackgroundHandl:  el0_svc+0x38/0x68
> [36705.558378] [T226303] BackgroundHandl:  el0t_64_sync_handler+0x68/0xbc
> [36705.558382] [T226303] BackgroundHandl:  el0t_64_sync+0x1a8/0x1ac
> [36705.558385] [T226303] BackgroundHandl:=20
> [36705.558387] [T226303] BackgroundHandl: Freed by task 26304:
> [36705.558391] [T226303] BackgroundHandl:  kasan_save_stack+0x40/0x70
> [36705.558395] [T226303] BackgroundHandl:  save_stack_info+0x34/0x128
> [36705.558399] [T226303] BackgroundHandl:  kasan_save_free_info+0x18/0x28
> [36705.558403] [T226303] BackgroundHandl:  ____kasan_slab_free+0x254/0x25=
c
> [36705.558407] [T226303] BackgroundHandl:  __kasan_slab_free+0x10/0x20
> [36705.558411] [T226303] BackgroundHandl:  slab_free_freelist_hook+0x174/=
0x1e0
> [36705.558415] [T226303] BackgroundHandl:  kmem_cache_free+0xc4/0x348
> [36705.558420] [T226303] BackgroundHandl:  locks_dispose_list+0x3c/0x164
> [36705.558425] [T226303] BackgroundHandl:  posix_lock_inode+0xb78/0xe94
> [36705.558429] [T226303] BackgroundHandl:  do_lock_file_wait+0xc4/0x1a4
> [36705.558434] [T226303] BackgroundHandl:  fcntl_setlk+0x2dc/0x448
> [36705.558439] [T226303] BackgroundHandl:  do_fcntl+0x90/0x570
> [36705.558444] [T226303] BackgroundHandl:  __arm64_sys_fcntl+0x7c/0xc8
> [36705.558448] [T226303] BackgroundHandl:  invoke_syscall+0x58/0x114
> [36705.558454] [T226303] BackgroundHandl:  el0_svc_common+0x80/0xe0
> [36705.558459] [T226303] BackgroundHandl:  do_el0_svc+0x1c/0x28
> [36705.558464] [T226303] BackgroundHandl:  el0_svc+0x38/0x68
> [36705.558468] [T226303] BackgroundHandl:  el0t_64_sync_handler+0x68/0xbc
> [36705.558472] [T226303] BackgroundHandl:  el0t_64_sync+0x1a8/0x1ac
> [36705.558475] [T226303] BackgroundHandl:=20
> [36705.558477] [T226303] BackgroundHandl: The buggy address belongs to th=
e object at ffffff80d9ea9dc0
>  which belongs to the cache file_lock_cache of size 216
> [36705.558481] [T226303] BackgroundHandl: The buggy address is located 0 =
bytes inside of
>  216-byte region [ffffff80d9ea9dc0, ffffff80d9ea9e98)
> [36705.558485] [T226303] BackgroundHandl:=20
> [36705.558487] [T226303] BackgroundHandl: The buggy address belongs to th=
e physical page:
> [36705.558491] [T226303] BackgroundHandl: page:000000002f0b235f refcount:=
1 mapcount:0 mapping:0000000000000000 index:0xf6ffff80d9ea9b20 pfn:0x159ea8
> [36705.558495] [T226303] BackgroundHandl: head:000000002f0b235f order:1 e=
ntire_mapcount:0 nr_pages_mapped:0 pincount:0
> [36705.558499] [T226303] BackgroundHandl: flags: 0x4000000000000840(slab|=
head|zone=3D1|kasantag=3D0x0)
> [36705.558505] [T226303] BackgroundHandl: page_type: 0xffffffff()
> [36705.558509] [T226303] BackgroundHandl: raw: 4000000000000840 f8ffff801=
2e57b00 fffffffe06a4fb00 0000000000000004
> [36705.558513] [T226303] BackgroundHandl: raw: f6ffff80d9ea9b20 000000008=
0240021 00000001ffffffff 0000000000000000
> [36705.558516] [T226303] BackgroundHandl: page dumped because: kasan: bad=
 access detected
> [36705.558519] [T226303] BackgroundHandl: page_owner tracks the page as a=
llocated
> [36705.558522] [T226303] BackgroundHandl: page last allocated via order 1=
, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|_=
_GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 23092, tgid 2=
3025 (elastic_NPS), ts 15865705548286, free_ts 15865538036285
> [36705.558529] [T226303] BackgroundHandl:  post_alloc_hook+0x18c/0x194
> [36705.558542] [T226303] BackgroundHandl:  prep_new_page+0x28/0x13c
> [36705.558548] [T226303] BackgroundHandl:  get_page_from_freelist+0x1928/=
0x198c
> [36705.558553] [T226303] BackgroundHandl:  __alloc_pages+0x158/0x310
> [36705.558558] [T226303] BackgroundHandl:  alloc_slab_page+0x8c/0x178
> [36705.558562] [T226303] BackgroundHandl:  new_slab+0xa4/0x340
> [36705.558565] [T226303] BackgroundHandl:  ___slab_alloc+0x648/0x98c
> [36705.558569] [T226303] BackgroundHandl:  __slab_alloc+0x6c/0xac
> [36705.558575] [T226303] BackgroundHandl:  kmem_cache_alloc+0x1e8/0x2c8
> [36705.558580] [T226303] BackgroundHandl:  posix_lock_inode+0x108/0xe94
> [36705.558584] [T226303] BackgroundHandl:  do_lock_file_wait+0xc4/0x1a4
> [36705.558589] [T226303] BackgroundHandl:  fcntl_setlk+0x2dc/0x448
> [36705.558594] [T226303] BackgroundHandl:  do_fcntl+0x90/0x570
> [36705.558599] [T226303] BackgroundHandl:  __arm64_sys_fcntl+0x7c/0xc8
> [36705.558603] [T226303] BackgroundHandl:  invoke_syscall+0x58/0x114
> [36705.558609] [T226303] BackgroundHandl:  el0_svc_common+0x80/0xe0
> [36705.558614] [T226303] BackgroundHandl: page last free pid 23092 tgid 2=
3025 stack trace:
> [36705.558617] [T226303] BackgroundHandl:  free_unref_page_prepare+0x2e8/=
0x310
> [36705.558622] [T226303] BackgroundHandl:  free_unref_page_list+0x90/0x37=
4
> [36705.558627] [T226303] BackgroundHandl:  release_pages+0x44c/0x488
> [36705.558642] [T226303] BackgroundHandl:  free_pages_and_swap_cache+0x58=
/0x70
> [36705.558648] [T226303] BackgroundHandl:  tlb_flush_mmu+0xa0/0x144
> [36705.558662] [T226303] BackgroundHandl:  tlb_finish_mmu+0x48/0xb0
> [36705.558667] [T226303] BackgroundHandl:  zap_page_range_single+0x168/0x=
1a0
> [36705.558671] [T226303] BackgroundHandl:  do_madvise+0x2f4/0xf00
> [36705.558675] [T226303] BackgroundHandl:  __arm64_sys_madvise+0x20/0x34
> [36705.558679] [T226303] BackgroundHandl:  invoke_syscall+0x58/0x114
> [36705.558684] [T226303] BackgroundHandl:  el0_svc_common+0x80/0xe0
> [36705.558689] [T226303] BackgroundHandl:  do_el0_svc+0x1c/0x28
> [36705.558694] [T226303] BackgroundHandl:  el0_svc+0x38/0x68
> [36705.558698] [T226303] BackgroundHandl:  el0t_64_sync_handler+0x68/0xbc
> [36705.558701] [T226303] BackgroundHandl:  el0t_64_sync+0x1a8/0x1ac
> [36705.558705] [T226303] BackgroundHandl:=20
> [36705.558708] [T226303] BackgroundHandl: Memory state around the buggy a=
ddress:
> [36705.558711] [T226303] BackgroundHandl:  ffffff80d9ea9b00: f2 f2 fe fe =
fe fe fe fe fe fe fe fe fe fe fe fe
> [36705.558714] [T226303] BackgroundHandl:  ffffff80d9ea9c00: f9 f9 f9 f9 =
f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f5 f5
> [36705.558718] [T226303] BackgroundHandl: >ffffff80d9ea9d00: f5 f5 f5 f5 =
f5 f5 f5 f5 f5 f5 f5 f5 fe fe fe fe
> [36705.558721] [T226303] BackgroundHandl:                                =
                        ^
> [36705.558724] [T226303] BackgroundHandl:  ffffff80d9ea9e00: fe fe fe fe =
fe fe fe fe fe fe fa fa fa fa fa fa
> [36705.558728] [T226303] BackgroundHandl:  ffffff80d9ea9f00: fa fa fa fa =
fa fa fa fa fe fe fe fe fe fe fe fe
> [36705.558738] [T226303] BackgroundHandl: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> =C2=A0
>=20
>=20
> -----Original Message-----
> From: Jeff Layton <jlayton@kernel.org>
> Sent: Friday, July 21, 2023 6:35 PM
> To: Will Shiu (=E8=A8=B1=E6=81=AD=E7=91=9C) <Will.Shiu@mediatek.com>; Chu=
ck Lever <chuck.lever@oracle.com>; Alexander Viro <viro@zeniv.linux.org.uk>=
; Christian Brauner <brauner@kernel.org>; Matthias Brugger <matthias.bgg@gm=
ail.com>; AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.c=
om>; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm=
-kernel@lists.infradead.org; linux-mediatek@lists.infradead.org
> Subject: Re: [PATCH] Fix BUG: KASAN: use-after-free in trace_event_raw_ev=
ent_filelock_lock
>=20
> On Fri, 2023-07-21 at 13:19 +0800, Will Shiu wrote:
> > As following backtrace, the struct file_lock request , in
> > posix_lock_inode is free before ftrace function using.
> > Replace the ftrace function ahead free flow could fix the
> > use-after-free issue.
> >=20
> > [name:report&]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > BUG:KASAN: use-after-free in
> > trace_event_raw_event_filelock_lock+0x80/0x12c
> > [name:report&]Read at addr f6ffff8025622620 by task NativeThread/16753
> > [name:report_hw_tags&]Pointer tag: [f6], memory tag: [fe]
> > [name:report&]
> > BT:
> > Hardware name: MT6897 (DT)
> > Call trace:
> > =C2=A0 dump_backtrace+0xf8/0x148
> > =C2=A0 show_stack+0x18/0x24
> > =C2=A0 dump_stack_lvl+0x60/0x7c
> > =C2=A0 print_report+0x2c8/0xa08
> > =C2=A0 kasan_report+0xb0/0x120
> > =C2=A0 __do_kernel_fault+0xc8/0x248
> > =C2=A0 do_bad_area+0x30/0xdc
> > =C2=A0 do_tag_check_fault+0x1c/0x30
> > =C2=A0 do_mem_abort+0x58/0xbc
> > =C2=A0 el1_abort+0x3c/0x5c
> > =C2=A0 el1h_64_sync_handler+0x54/0x90
> > =C2=A0 el1h_64_sync+0x68/0x6c
> > =C2=A0 trace_event_raw_event_filelock_lock+0x80/0x12c
> > =C2=A0 posix_lock_inode+0xd0c/0xd60
> > =C2=A0 do_lock_file_wait+0xb8/0x190
> > =C2=A0 fcntl_setlk+0x2d8/0x440
> > ...
> > [name:report&]
> > [name:report&]Allocated by task 16752:
> > ...
> > =C2=A0 slab_post_alloc_hook+0x74/0x340
> > =C2=A0 kmem_cache_alloc+0x1b0/0x2f0
> > =C2=A0 posix_lock_inode+0xb0/0xd60
> > ...
> > =C2=A0 [name:report&]
> > =C2=A0 [name:report&]Freed by task 16752:
> > ...
> > =C2=A0=C2=A0 kmem_cache_free+0x274/0x5b0
> > =C2=A0=C2=A0 locks_dispose_list+0x3c/0x148
> > =C2=A0=C2=A0 posix_lock_inode+0xc40/0xd60
> > =C2=A0=C2=A0 do_lock_file_wait+0xb8/0x190
> > =C2=A0=C2=A0 fcntl_setlk+0x2d8/0x440
> > =C2=A0=C2=A0 do_fcntl+0x150/0xc18
> > ...
> >=20
> > Signed-off-by: Will Shiu <Will.Shiu@mediatek.com>
> > ---
> > =C2=A0 fs/locks.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/locks.c b/fs/locks.c
> > index df8b26a42524..a552bdb6badc 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -1301,6 +1301,7 @@ static int posix_lock_inode(struct inode *inode, =
struct file_lock *request,
> > =C2=A0=C2=A0 out:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&ctx->flc_lock);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 percpu_up_read(&file_rwsem);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 trace_posix_lock_inode(inode, request, error)=
;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Free any unused lock=
s.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > @@ -1309,7 +1310,6 @@ static int posix_lock_inode(struct inode *inode, =
struct file_lock *request,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (new_fl2)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 locks_free_lock(new_fl2);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 locks_dispose_list(&dispose)=
;
> > -=C2=A0=C2=A0=C2=A0=C2=A0 trace_posix_lock_inode(inode, request, error)=
;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return error;
> > =C2=A0 }
>=20
> Could you send along the entire KASAN log message? I'm not sure I see how=
 this is being tripped. The lock we're passing in here is "request"
> and that shouldn't be freed since it's allocated and owned by the caller.
>=20
> --
> Jeff Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@kernel.org>

