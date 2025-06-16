Return-Path: <linux-fsdevel+bounces-51713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4FDADA985
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 09:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF3607A4BA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 07:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B30B1F417B;
	Mon, 16 Jun 2025 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNswUpyy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D629A54BC6;
	Mon, 16 Jun 2025 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059322; cv=none; b=D9CrSfyLkBzpayKWTsBj+gC3XaqqyrW1g7bw7EI0S38bZEAoXL2OkAvJFWEufkYDASIceImb5YTVBT0yvPayvWfFiJlgRzFQHNjrReS0ZfjvCxdyYXh9LEWvg0WbyNCLsXmWmi3TOXTzsrYfrhNOmenQtOJ3SOVC3SYiMtfzX2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059322; c=relaxed/simple;
	bh=Oq/Tm1Ltqmyqcw8gYzKlEsuDFotiDqg65+Az7rRy9EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGNoCIob+i5fUtGYvlwrDgTtNvkegBUOWjgevrwxkFtpF0xAaLuUZSzrFRtNPdcFHysCrDeVGQhivjvA/memG9P75sabKeRFGxhoCE1kW0e0akqo928ghGm1m8fSQq1bmVY03VNndJVfzy6ZkoDDtb/gZxi0CJ/vIC1O5IPbeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNswUpyy; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-312116d75a6so3534913a91.3;
        Mon, 16 Jun 2025 00:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750059319; x=1750664119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPjpGmlIDBEAJF/iRevhE5Lj52H4JOv8VifHoQBVf0E=;
        b=HNswUpyyNvTv2o0SQcRtishwUqm55mQaSGogEQ9+QXQ2kduguzjtnb7QgOkfdL6LQ6
         WeosT/JUDuIvOSVt+879GHLGyvf1DQiGSt/ITCGgP9N9guCKvJtPzKY8biW0o19oJVGX
         nTzx8+fUfZh+sC7MkCAcnqSEsPaweRvhYjiVOKojYbl7O3WQapDQBldn5MBNT9Ucmp9h
         8I0+vqXIelE7zGXLueAAnABdc09PqMnaVhJV4FinmJDPXPGg1Oxmq+5FOBj+hC76o1fV
         BdVKNd9MBtIg+cW/NnaN1RiQc+TW/eQ2QJspu8o9l/2g4XMOsfLOGPlkxw6ZRNLECcxY
         hn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750059319; x=1750664119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPjpGmlIDBEAJF/iRevhE5Lj52H4JOv8VifHoQBVf0E=;
        b=XKuhrQkKDZWpNGtdg8YaWmiOfZwIbYnVFnhVBlfQ+g05xnssexrWMRSqFaRVDpR8+g
         qZc2kJXxsfL5ZuSDgAoMGzXDZoTUCjsl4gtkb/xq3H23q/rTxMlwctM0BV0ZMzGnZ4QC
         kA8xKcG/tjpUhx0+Gb+t46ga7Vvryp9ry+QMzJckqdESluDBkFU6/UyIqGkaMkAKBRK3
         goYFiW5W1UXd1pwwunWeOvcDwBznKk7JBmAxl3CRDsvhMcgMvCd3AXUAuZ6fM/UbUcME
         bwBFMs0UKZBL0NB0ELnxfSPF6q8SUSyOGJ1lDZeO2NpelrBrx8hr1ak9eI3M8mdXoxi9
         yKEg==
X-Forwarded-Encrypted: i=1; AJvYcCW7tfonbjJhgSYCHKJNo9x28PcENHdyE0eOHtInQk2qr0OYxuFhI2f57ELoK4zc+Fa6FbpZ7o35Tx6nq9aH@vger.kernel.org
X-Gm-Message-State: AOJu0YynpBDpgix/FqwN+TM9G6KUgGGDYwq1SQGT7dpikj6YqZcdiO5l
	HiLMPTbfgQlyvVkhzsibyzrEN/Xphw945hVTmtN7xA2fhXwoL/PirL5rjuzOFYkJRw4NTx9U8QQ
	YrPuutfHUh6dCbGZ26QWq3U9jWFJsypKMOrLk
X-Gm-Gg: ASbGncsGhhrpL9b8/mLV2UWwn2vM+YJkQseQq8B7ZY/5yG4cJZKzFdp9Lo0jC+JuO1x
	x4mpA0w0lwQOn7s0gtHGQHepdv5w/kzXDCZI0fbojoqNiUSr/89gsUdZvn0l4DPP8S63DLRDayY
	QQbCX09Jnpg2HNMkeG8LGRMg8umYeFp0BYEXgxJhSx3rm4Tt10zlfEUw==
X-Google-Smtp-Source: AGHT+IEua49XSxVTvAVhC82O6NooIleOgzufTWp1Gx92BsuMyl1bEVGowYU6btLYY/ARgVS0zAUtomsrnodty4avf6g=
X-Received: by 2002:a17:90b:48ca:b0:312:e90b:419e with SMTP id
 98e67ed59e1d1-313f1cacddfmr17030525a91.12.1750059318901; Mon, 16 Jun 2025
 00:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414221013.157819-1-slava@dubeyko.com> <CAOi1vP8QreVDgY363c5b1Ke35N7tmRArcLfqQcwQiwJ-ULeWxg@mail.gmail.com>
 <f6ef96ecfb43cdb695eb9292388434329ad3bc91.camel@dubeyko.com>
 <CAOi1vP_+0f-RjBrCHNGpuNtYqfcg6A+CKPGGf-Nb_dLC4phVUg@mail.gmail.com>
 <670fd7d013c0309844530e88a9e5de15d91bcf59.camel@dubeyko.com> <137894454df573d26827d7d42354dbfd5502fa3c.camel@dubeyko.com>
In-Reply-To: <137894454df573d26827d7d42354dbfd5502fa3c.camel@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 16 Jun 2025 09:35:07 +0200
X-Gm-Features: AX0GCFtt0fdoln6JQirU1x6on2U3gE1Wnm2wORrv_gZuaTcnwcCHTf2w4wN_Wu8
Message-ID: <CAOi1vP-RQE4EXy-XyJNnuTQO5rnW1nCzTMWzUj4v3E1etFywtQ@mail.gmail.com>
Subject: Re: [PATCH v5] ceph: fix slab-use-after-free in have_mon_and_osd_map()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, amarkuze@redhat.com, 
	Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 8:44=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> On Thu, 2025-06-12 at 12:50 -0700, Viacheslav Dubeyko wrote:
> > On Thu, 2025-06-12 at 10:20 +0200, Ilya Dryomov wrote:
> > > On Thu, Jun 12, 2025 at 1:14=E2=80=AFAM Viacheslav Dubeyko
> > > <slava@dubeyko.com> wrote:
> > > >
> > > > On Wed, 2025-06-11 at 13:22 +0200, Ilya Dryomov wrote:
> > > > > On Tue, Apr 15, 2025 at 12:10=E2=80=AFAM Viacheslav Dubeyko
> > > > > <slava@dubeyko.com> wrote:
> > > > > >
> > > > > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > > >
> > > > > > The generic/395 and generic/397 is capable of generating
> > > > > > the oops is on line net/ceph/ceph_common.c:794 with
> > > > > > KASAN enabled.
> > > > > >
> > > > > > BUG: KASAN: slab-use-after-free in
> > > > > > have_mon_and_osd_map+0x56/0x70
> > > > > > Read of size 4 at addr ffff88811012d810 by task
> > > > > > mount.ceph/13305
> > > > > >
> > > > > > CPU: 2 UID: 0 PID: 13305 Comm: mount.ceph Not tainted 6.14.0-
> > > > > > rc2-
> > > > > > build2+ #1266
> > > > > > Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
> > > > > > Call Trace:
> > > > > > <TASK>
> > > > > > dump_stack_lvl+0x57/0x80
> > > > > > ? have_mon_and_osd_map+0x56/0x70
> > > > > > print_address_description.constprop.0+0x84/0x330
> > > > > > ? have_mon_and_osd_map+0x56/0x70
> > > > > > print_report+0xe2/0x1e0
> > > > > > ? rcu_read_unlock_sched+0x60/0x80
> > > > > > ? kmem_cache_debug_flags+0xc/0x20
> > > > > > ? fixup_red_left+0x17/0x30
> > > > > > ? have_mon_and_osd_map+0x56/0x70
> > > > > > kasan_report+0x8d/0xc0
> > > > > > ? have_mon_and_osd_map+0x56/0x70
> > > > > > have_mon_and_osd_map+0x56/0x70
> > > > > > ceph_open_session+0x182/0x290
> > > > > > ? __pfx_ceph_open_session+0x10/0x10
> > > > > > ? __init_swait_queue_head+0x8d/0xa0
> > > > > > ? __pfx_autoremove_wake_function+0x10/0x10
> > > > > > ? shrinker_register+0xdd/0xf0
> > > > > > ceph_get_tree+0x333/0x680
> > > > > > vfs_get_tree+0x49/0x180
> > > > > > do_new_mount+0x1a3/0x2d0
> > > > > > ? __pfx_do_new_mount+0x10/0x10
> > > > > > ? security_capable+0x39/0x70
> > > > > > path_mount+0x6dd/0x730
> > > > > > ? __pfx_path_mount+0x10/0x10
> > > > > > ? kmem_cache_free+0x1e5/0x270
> > > > > > ? user_path_at+0x48/0x60
> > > > > > do_mount+0x99/0xe0
> > > > > > ? __pfx_do_mount+0x10/0x10
> > > > > > ? lock_release+0x155/0x190
> > > > > > __do_sys_mount+0x141/0x180
> > > > > > do_syscall_64+0x9f/0x100
> > > > > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > > RIP: 0033:0x7f01b1b14f3e
> > > > > > Code: 48 8b 0d d5 3e 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66
> > > > > > 2e
> > > > > > 0f
> > > > > > 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00
> > > > > > 0f
> > > > > > 05
> > > > > > <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a2 3e 0f 00 f7 d8 64 89
> > > > > > 01 48
> > > > > > RSP: 002b:00007fffd129fa08 EFLAGS: 00000246 ORIG_RAX:
> > > > > > 00000000000000a5
> > > > > > RAX: ffffffffffffffda RBX: 0000564ec01a7850 RCX:
> > > > > > 00007f01b1b14f3e
> > > > > > RDX: 0000564ec00f2225 RSI: 00007fffd12a1964 RDI:
> > > > > > 0000564ec0147a20
> > > > > > RBP: 00007fffd129fbd0 R08: 0000564ec014da90 R09:
> > > > > > 0000000000000080
> > > > > > R10: 0000000000000000 R11: 0000000000000246 R12:
> > > > > > 00007fffd12a194e
> > > > > > R13: 0000000000000000 R14: 00007fffd129fa50 R15:
> > > > > > 00007fffd129fa40
> > > > > > </TASK>
> > > > > >
> > > > > > Allocated by task 13305:
> > > > > > stack_trace_save+0x8c/0xc0
> > > > > > kasan_save_stack+0x1e/0x40
> > > > > > kasan_save_track+0x10/0x30
> > > > > > __kasan_kmalloc+0x3a/0x50
> > > > > > __kmalloc_noprof+0x247/0x290
> > > > > > ceph_osdmap_alloc+0x16/0x130
> > > > > > ceph_osdc_init+0x27a/0x4c0
> > > > > > ceph_create_client+0x153/0x190
> > > > > > create_fs_client+0x50/0x2a0
> > > > > > ceph_get_tree+0xff/0x680
> > > > > > vfs_get_tree+0x49/0x180
> > > > > > do_new_mount+0x1a3/0x2d0
> > > > > > path_mount+0x6dd/0x730
> > > > > > do_mount+0x99/0xe0
> > > > > > __do_sys_mount+0x141/0x180
> > > > > > do_syscall_64+0x9f/0x100
> > > > > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > >
> > > > > > Freed by task 9475:
> > > > > > stack_trace_save+0x8c/0xc0
> > > > > > kasan_save_stack+0x1e/0x40
> > > > > > kasan_save_track+0x10/0x30
> > > > > > kasan_save_free_info+0x3b/0x50
> > > > > > __kasan_slab_free+0x18/0x30
> > > > > > kfree+0x212/0x290
> > > > > > handle_one_map+0x23c/0x3b0
> > > > > > ceph_osdc_handle_map+0x3c9/0x590
> > > > > > mon_dispatch+0x655/0x6f0
> > > > > > ceph_con_process_message+0xc3/0xe0
> > > > > > ceph_con_v1_try_read+0x614/0x760
> > > > > > ceph_con_workfn+0x2de/0x650
> > > > > > process_one_work+0x486/0x7c0
> > > > > > process_scheduled_works+0x73/0x90
> > > > > > worker_thread+0x1c8/0x2a0
> > > > > > kthread+0x2ec/0x300
> > > > > > ret_from_fork+0x24/0x40
> > > > > > ret_from_fork_asm+0x1a/0x30
> > > > > >
> > > > > > The buggy address belongs to the object at ffff88811012d800
> > > > > > which belongs to the cache kmalloc-512 of size 512
> > > > > > The buggy address is located 16 bytes inside of
> > > > > > freed 512-byte region [ffff88811012d800, ffff88811012da00)
> > > > > >
> > > > > > The buggy address belongs to the physical page:
> > > > > > page: refcount:0 mapcount:0 mapping:0000000000000000
> > > > > > index:0x0
> > > > > > pfn:0x11012c
> > > > > > head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0
> > > > > > pincount:0
> > > > > > flags: 0x200000000000040(head|node=3D0|zone=3D2)
> > > > > > page_type: f5(slab)
> > > > > > raw: 0200000000000040 ffff888100042c80 dead000000000100
> > > > > > dead000000000122
> > > > > > raw: 0000000000000000 0000000080100010 00000000f5000000
> > > > > > 0000000000000000
> > > > > > head: 0200000000000040 ffff888100042c80 dead000000000100
> > > > > > dead000000000122
> > > > > > head: 0000000000000000 0000000080100010 00000000f5000000
> > > > > > 0000000000000000
> > > > > > head: 0200000000000002 ffffea0004404b01 ffffffffffffffff
> > > > > > 0000000000000000
> > > > > > head: 0000000000000004 0000000000000000 00000000ffffffff
> > > > > > 0000000000000000
> > > > > > page dumped because: kasan: bad access detected
> > > > > >
> > > > > > Memory state around the buggy address:
> > > > > > ffff88811012d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > > > fc
> > > > > > fc
> > > > > > ffff88811012d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > > > fc
> > > > > > fc
> > > > > >
> > > > > >     ffff88811012d800: fa fb fb fb fb fb fb fb fb fb fb fb fb
> > > > > > fb
> > > > > > fb
> > > > > > fb
> > > > > >
> > > > > > ^
> > > > > > ffff88811012d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > > > fb
> > > > > > fb
> > > > > > ffff88811012d900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > > > fb
> > > > > > fb
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > =3D=3D
> > > > > > =3D=3D=3D
> > > > > > Disabling lock debugging due to kernel taint
> > > > > > libceph: client274326 fsid 8598140e-35c2-11ee-b97c-
> > > > > > 001517c545cc
> > > > > > libceph: mon0 (1)90.155.74.19:6789 session established
> > > > > > libceph: client274327 fsid 8598140e-35c2-11ee-b97c-
> > > > > > 001517c545cc
> > > > > >
> > > > > > We have such scenario:
> > > > > >
> > > > > > Thread 1:
> > > > > > void ceph_osdmap_destroy(...) {
> > > > > >     <skipped>
> > > > > >     kfree(map);
> > > > > > }
> > > > > > Thread 1 sleep...
> > > > > >
> > > > > > Thread 2:
> > > > > > static bool have_mon_and_osd_map(struct ceph_client *client)
> > > > > > {
> > > > > >     return client->monc.monmap && client->monc.monmap->epoch
> > > > > > &&
> > > > > >         client->osdc.osdmap && client->osdc.osdmap->epoch;
> > > > > > }
> > > > > > Thread 2 has oops...
> > > > > >
> > > > > > Thread 1 wake up:
> > > > > > static int handle_one_map(...) {
> > > > > >     <skipped>
> > > > > >     osdc->osdmap =3D newmap;
> > > > > >     <skipped>
> > > > > > }
> > > > > >
> > > > > > This patch introduces a have_mon_and_osd_map atomic_t
> > > > > > field in struct ceph_client. If there is no OSD and
> > > > > > monitor maps, then the client->have_mon_and_osd_map
> > > > > > is equal to zero. The OSD and monitor maps initialization
> > > > > > results in incrementing of client->have_mon_and_osd_map
> > > > > > under the lock. As a result, have_mon_and_osd_map() function
> > > > > > simply checks now that client->have_mon_and_osd_map is equal
> > > > > > to
> > > > > > CEPH_CLIENT_HAS_MON_AND_OSD_MAP.
> > > > > >
> > > > > > Patch adds locking in the ceph_osdc_stop()
> > > > > > method during the destructruction of osdc->osdmap and
> > > > > > assigning of NULL to the pointer. The lock is used
> > > > > > in the ceph_monc_stop() during the freeing of monc->monmap
> > > > > > and assigning NULL to the pointer too. The monmap_show()
> > > > > > and osdmap_show() methods were reworked to prevent
> > > > > > the potential race condition during the methods call.
> > > > > >
> > > > > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > > > ---
> > > > > >  include/linux/ceph/libceph.h | 20 ++++++++++++++++++++
> > > > > >  net/ceph/ceph_common.c       |  6 ++++--
> > > > > >  net/ceph/debugfs.c           | 17 +++++++++++++----
> > > > > >  net/ceph/mon_client.c        | 18 +++++++++++++++++-
> > > > > >  net/ceph/osd_client.c        | 11 +++++++++++
> > > > > >  5 files changed, 65 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/ceph/libceph.h
> > > > > > b/include/linux/ceph/libceph.h
> > > > > > index 733e7f93db66..f5694bf5bd54 100644
> > > > > > --- a/include/linux/ceph/libceph.h
> > > > > > +++ b/include/linux/ceph/libceph.h
> > > > > > @@ -132,6 +132,7 @@ struct ceph_client {
> > > > > >         struct ceph_messenger msgr;   /* messenger instance
> > > > > > */
> > > > > >         struct ceph_mon_client monc;
> > > > > >         struct ceph_osd_client osdc;
> > > > > > +       atomic_t have_mon_and_osd_map;
> > > > > >
> > > > > >  #ifdef CONFIG_DEBUG_FS
> > > > > >         struct dentry *debugfs_dir;
> > > > > > @@ -141,6 +142,25 @@ struct ceph_client {
> > > > > >  #endif
> > > > > >  };
> > > > > >
> > > > > > +/*
> > > > > > + * The have_mon_and_osd_map possible states
> > > > > > + */
> > > > > > +enum {
> > > > > > +       CEPH_CLIENT_HAS_NO_MON_AND_NO_OSD_MAP =3D 0,
> > > > > > +       CEPH_CLIENT_HAS_ONLY_ONE_MAP =3D 1,
> > > > > > +       CEPH_CLIENT_HAS_MON_AND_OSD_MAP =3D 2,
> > > > > > +       CEPH_CLIENT_MAP_STATE_UNKNOWN
> > > > > > +};
> > > > > > +
> > > > > > +static inline
> > > > > > +bool is_mon_and_osd_map_state_invalid(struct ceph_client
> > > > > > *client)
> > > > > > +{
> > > > > > +       int have_mon_and_osd_map =3D atomic_read(&client-
> > > > > > > have_mon_and_osd_map);
> > > > > > +
> > > > > > +       return have_mon_and_osd_map <
> > > > > > CEPH_CLIENT_HAS_NO_MON_AND_NO_OSD_MAP ||
> > > > > > +               have_mon_and_osd_map >=3D
> > > > > > CEPH_CLIENT_MAP_STATE_UNKNOWN;
> > > > > > +}
> > > > > > +
> > > > > >  #define from_msgr(ms)  container_of(ms, struct ceph_client,
> > > > > > msgr)
> > > > > >
> > > > > >  static inline bool ceph_msgr2(struct ceph_client *client)
> > > > > > diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> > > > > > index 4c6441536d55..62efceb3b19d 100644
> > > > > > --- a/net/ceph/ceph_common.c
> > > > > > +++ b/net/ceph/ceph_common.c
> > > > > > @@ -723,6 +723,8 @@ struct ceph_client
> > > > > > *ceph_create_client(struct
> > > > > > ceph_options *opt, void *private)
> > > > > >
> > > > > >         mutex_init(&client->mount_mutex);
> > > > > >         init_waitqueue_head(&client->auth_wq);
> > > > > > +       atomic_set(&client->have_mon_and_osd_map,
> > > > > > +                  CEPH_CLIENT_HAS_NO_MON_AND_NO_OSD_MAP);
> > > > > >         client->auth_err =3D 0;
> > > > > >
> > > > > >         client->extra_mon_dispatch =3D NULL;
> > > > > > @@ -790,8 +792,8 @@ EXPORT_SYMBOL(ceph_reset_client_addr);
> > > > > >   */
> > > > > >  static bool have_mon_and_osd_map(struct ceph_client *client)
> > > > > >  {
> > > > > > -       return client->monc.monmap && client->monc.monmap-
> > > > > > > epoch &&
> > > > > > -              client->osdc.osdmap && client->osdc.osdmap-
> > > > > > > epoch;
> > > > > > +       return atomic_read(&client->have_mon_and_osd_map) =3D=
=3D
> > > > > > +
> > > > > > CEPH_CLIENT_HAS_MON_AND_OSD_MAP;
> > > > > >  }
> > > > > >
> > > > > >  /*
> > > > > > diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> > > > > > index 2110439f8a24..7b45c169a859 100644
> > > > > > --- a/net/ceph/debugfs.c
> > > > > > +++ b/net/ceph/debugfs.c
> > > > > > @@ -36,8 +36,10 @@ static int monmap_show(struct seq_file *s,
> > > > > > void
> > > > > > *p)
> > > > > >         int i;
> > > > > >         struct ceph_client *client =3D s->private;
> > > > > >
> > > > > > +       mutex_lock(&client->monc.mutex);
> > > > > > +
> > > > > >         if (client->monc.monmap =3D=3D NULL)
> > > > > > -               return 0;
> > > > > > +               goto out_unlock;
> > > > > >
> > > > > >         seq_printf(s, "epoch %d\n", client->monc.monmap-
> > > > > > > epoch);
> > > > > >         for (i =3D 0; i < client->monc.monmap->num_mon; i++) {
> > > > > > @@ -48,6 +50,10 @@ static int monmap_show(struct seq_file *s,
> > > > > > void
> > > > > > *p)
> > > > > >                            ENTITY_NAME(inst->name),
> > > > > >                            ceph_pr_addr(&inst->addr));
> > > > > >         }
> > > > > > +
> > > > > > +out_unlock:
> > > > > > +       mutex_unlock(&client->monc.mutex);
> > > > > > +
> > > > > >         return 0;
> > > > > >  }
> > > > > >
> > > > > > @@ -56,13 +62,15 @@ static int osdmap_show(struct seq_file
> > > > > > *s,
> > > > > > void
> > > > > > *p)
> > > > > >         int i;
> > > > > >         struct ceph_client *client =3D s->private;
> > > > > >         struct ceph_osd_client *osdc =3D &client->osdc;
> > > > > > -       struct ceph_osdmap *map =3D osdc->osdmap;
> > > > > > +       struct ceph_osdmap *map =3D NULL;
> > > > > >         struct rb_node *n;
> > > > > >
> > > > > > +       down_read(&osdc->lock);
> > > > > > +
> > > > > > +       map =3D osdc->osdmap;
> > > > > >         if (map =3D=3D NULL)
> > > > > > -               return 0;
> > > > > > +               goto out_unlock;
> > > > > >
> > > > > > -       down_read(&osdc->lock);
> > > > > >         seq_printf(s, "epoch %u barrier %u flags 0x%x\n",
> > > > > > map-
> > > > > > > epoch,
> > > > > >                         osdc->epoch_barrier, map->flags);
> > > > > >
> > > > > > @@ -131,6 +139,7 @@ static int osdmap_show(struct seq_file
> > > > > > *s,
> > > > > > void
> > > > > > *p)
> > > > > >                 seq_printf(s, "]\n");
> > > > > >         }
> > > > > >
> > > > > > +out_unlock:
> > > > > >         up_read(&osdc->lock);
> > > > > >         return 0;
> > > > > >  }
> > > > > > diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> > > > > > index ab66b599ac47..5cf802236426 100644
> > > > > > --- a/net/ceph/mon_client.c
> > > > > > +++ b/net/ceph/mon_client.c
> > > > > > @@ -562,12 +562,16 @@ static void ceph_monc_handle_map(struct
> > > > > > ceph_mon_client *monc,
> > > > > >                 goto out;
> > > > > >         }
> > > > > >
> > > > > > +       atomic_dec(&client->have_mon_and_osd_map);
> > > > > > +
> > > > > >         kfree(monc->monmap);
> > > > > >         monc->monmap =3D monmap;
> > > > > >
> > > > > >         __ceph_monc_got_map(monc, CEPH_SUB_MONMAP, monc-
> > > > > > > monmap-
> > > > > > > epoch);
> > > > > >         client->have_fsid =3D true;
> > > > > >
> > > > > > +       atomic_inc(&client->have_mon_and_osd_map);
> > > > > > +
> > > > > >  out:
> > > > > >         mutex_unlock(&monc->mutex);
> > > > > >         wake_up_all(&client->auth_wq);
> > > > > > @@ -1220,6 +1224,9 @@ int ceph_monc_init(struct
> > > > > > ceph_mon_client
> > > > > > *monc, struct ceph_client *cl)
> > > > > >
> > > > > >         monc->fs_cluster_id =3D CEPH_FS_CLUSTER_ID_NONE;
> > > > > >
> > > > > > +       atomic_inc(&monc->client->have_mon_and_osd_map);
> > > > >
> > > > > Hi Slava,
> > > > >
> > > > > Incrementing client->have_mon_and_osd_map here and in
> > > > > ceph_osdc_init()
> > > > > means that counter would be set to 2
> > > > > (CEPH_CLIENT_HAS_MON_AND_OSD_MAP)
> > > > > at the initialization time, way before a session with the
> > > > > monitor
> > > > > is
> > > > > established and any map is received.  This effectively disables
> > > > > the
> > > > > wait logic in __ceph_open_session() because of
> > > > > have_mon_and_osd_map()
> > > > > immediately returning true.  __ceph_open_session() is
> > > > > responsible
> > > > > for
> > > > > setting up the debugfs directory and that is affected too: it's
> > > > > created
> > > > > as 00000000-0000-0000-0000-000000000000.client0 because neither
> > > > > the
> > > > > cluster FSID nor the client ID is known without the monmap.
> > > > >
> > > > > This patch seems to be over-complicated for what it needs to
> > > > > do:
> > > > > I don't see a compelling reason for introducing the atomic and
> > > > > as
> > > > > mentioned before there is no need to attempt to guard against
> > > > > someone
> > > > > continuing to use the client after ceph_osdc_stop() and
> > > > > ceph_monc_stop()
> > > > > are called.  It's the point of no return and the client itself
> > > > > gets
> > > > > freed very shortly after.
> > > > >
> > > > > Why not just open-code the wait loop in __ceph_open_session()
> > > > > to
> > > > > allow
> > > > > for monc->mutex and osdc->lock (for read) to be taken freely?
> > > > > It
> > > > > should
> > > > > be a small change in __ceph_open_session() --
> > > > > net/ceph/mon_client.c
> > > > > and
> > > > > net/ceph/osd_client.c wouldn't need to be touched at all.
> > > > >
> > > >
> > > > Hi Ilya,
> > > >
> > > > Frankly speaking, I don't quite follow to your point. The main
> > > > issue
> > > > happens when one thread calls ceph_osdc_handle_map() [1] ->
> > > > handle_one_map() [2]:
> > > >
> > > > ceph_osdmap_destroy() [3] -> kfree(map) -> go to sleep
> > > >
> > > > <-- another thread receives time slices to execute:
> > > > have_mon_and_osd_map() BUT osdc->osdmap is already freed and
> > > > invalid
> > > > here!!!
> > > >
> > > > osdc->osdmap =3D newmap;
> > > >
> > > > So, it's not about ceph_osdc_stop() or ceph_monc_stop() but it's
> > > > about
> > > > regular operations.
> > >
> > > I know, but on top of the regular operations (to be precise, one
> > > regular operation -- __ceph_open_session()) the current patch also
> > > tries to harden ceph_osdc_stop() and ceph_monc_stop().  I wanted to
> > > reiterate that it's not needed.
> > >
> > > >
> > > > I've tried to exclude the necessity to use locks at all in
> > > > have_mon_and_osd_map(). Do you mean that wait loop will be better
> > > > solution?
> > >
> > > Yes, it seems preferable over an otherwise redundant (i.e. not used
> > > for
> > > anything else) atomic which turned out to be tricky enough to get
> > > right
> > > on the first try.
> > >
> > > > It sounds pretty complicated too for my taste and it will
> > > > require coordination among threads. No? I am not completely sure
> > > > that I
> > > > follow to your vision.
> > >
> > > With the help of woken_wake_function() primitive it shouldn't be
> > > complicated at all.  The diff would be limited to
> > > __ceph_open_session()
> > > and I would expect it to be on par with the current patch.  Making
> > > it
> > > possible to freely take locks there would also squash another
> > > related
> > > buglet: client->auth_err shouldn't be accessed outside of monc-
> > > >mutex
> > > either.  Being just an int, it's not complained about by KASAN ;)
> > >
> > > Since __ceph_open_session() is the only user of
> > > have_mon_and_osd_map()
> > > it could be open-coded inside of the wait loop.
> > >
> >
> > OK. Let me try to rework my patch yet another time. :)
> >
>
> Hi Ilya,
>
> Probably, we need to consider of adding Ceph related xfstests' test-
> case for checking debugfs items. What do you think? Which debugfs items
> this test should check? Also, maybe, we need to add a test for checking
> snapshot functionality in Ceph when CephFS kernel client operates?

Hi Slava,

It's up to you.  AFAIU it's the teuthology framework that ends up
poking in debugfs (qa/tasks/cephfs/kernel_mount.py).  Some teuthology
tests then depend on the information obtained from debugfs, so if
something breaks there you are guaranteed to learn about it -- it's
just not as immediate as a local fstests run.

For fstests, the general assumption is likely that debugfs mount is
optional -- ceph/001 runs but skips some checks if it's not available,
for example.  More coverage is always better, but you would probably
need to tag such a test with _require_debugfs or similar.

Thanks,

                Ilya

