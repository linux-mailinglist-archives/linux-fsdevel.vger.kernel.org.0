Return-Path: <linux-fsdevel+bounces-51604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F91AD94B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 20:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B773B9251
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 18:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C64242D80;
	Fri, 13 Jun 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="PQOCR2C9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7323BCE2
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749840266; cv=none; b=PzgLXditflTcnDJQM39TZCRbBtVi23Q4nHLssSXFdpVoruEREoadBGKrPEYcWcW7kPAkDm+QvvFuykXIkWjuLP21vaW/mNJcHejCCxAOKNmjijN8GRz36yVh80+xRlyWxx13NqW9+jg+Af8q5N93Brb5PEgtuBC7yvNpxXWvbrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749840266; c=relaxed/simple;
	bh=Aa99YGYiHf5TTqf8HeWzJqRQLuUwH189Y5517b5p+eU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aB9wQH161qo4cMof45Jr0+sxlKNMU/AHlwm2TQp7o8x3ORbqJAhbfPx7U1wMSYY0oxVYA31UfKb13ar8277MAI7l41EgzpSTJvyXqy/NslgjgJbaeofTV20ttKeVmPzIOhr9N2vYjgQZ04WZLVjomIkd4R+7X8S/lNUKyNP1zW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=PQOCR2C9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2c49373c15so1978489a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1749840263; x=1750445063; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Aa99YGYiHf5TTqf8HeWzJqRQLuUwH189Y5517b5p+eU=;
        b=PQOCR2C9yfbuyvKibVkcWSNf2UHv5YYgVGZbLswmM2kvMyjPqZz2AoChNpvLFGZG72
         Lu7TdrmYDvn8r9GECLidOKGoSRQmMVY6vHPF4Fpsngg7lJzGqNYRP79bFdGNKHAE0Z1I
         S5hS3I8IGI7F4uIb0ZMZdAuIdLL+jMoaRmMVrLC/A6+/m+IibY2mxugiSwFfQcAeNM2I
         tRgwH67VYlIeoIijOKA0087QOQTxM/h1HCPHQvAmgwtX24+GtwpXjkk6q5zOeGoQwe+7
         E44PioErilj8XJYTHanVKu3O70ktpPEXN7NCvyXS28ECSvuSwbpUqyF4aaFCvxLSbZbM
         I/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749840263; x=1750445063;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aa99YGYiHf5TTqf8HeWzJqRQLuUwH189Y5517b5p+eU=;
        b=Nfl0ba+Rx01qEh0kT7T0TeDYQUAVJ6RyIcaqlper7onYePcZhAnvXa7kJ4kmmL5SOB
         LFHB6uRC8LNYWsnzMeUXZ+ZSsuqOM+h/jahOTdAhCR7YBxvXhZ6stVrWc2duy7FkQ+hN
         bYrJN4VuZuvNpOf6Q1kawoN0ABhfyXiPHoNekwJRAs5TgCXTkFJUwyAc4vJyCGlWBsqq
         mDARjjJrbct0cHyT3vYyu/STgbGq2FDknTHUStKufZENmbf5zJoCt/EYqvOFpEZH2hDg
         c6qrHE2wW5JTx/KdBduThblDoeDjRd2IlyrVpZLhp01BLyFfCzkaJJMrTBL2ofJGRNfb
         xw+g==
X-Forwarded-Encrypted: i=1; AJvYcCUE9uFTQaTbofeHBL7fALA2oC5KGig/Hk/N5+HCip1TbOpH9nKmKHGHvwiY14gUaQbRyD7sBYB5EIn6hYCy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+JJilyBxjDQKUVJluo/rG8e/kChROwxtvY1L8bCpITVgEGoKW
	uJpVC5j7hMKRmOZxSRxgbe+oT+Xw+jFcNKbo1nmc+1BAyVSHOCPjsvgcAdHJv2uJBsU=
X-Gm-Gg: ASbGncvad6vnjrvbJCBbgaDsaJiNrHE5y7Gcx69tRuXxXDuMhkgDVcQBR05gzFtqLdB
	3ZbqMGBR52d7TsDrB/a1nnfRaAOlxiqZz6yZKbzR4TTRCN21DyvjledPagPmCqnmMN2q6HFG8uy
	f2Ic3Z/DlGevK1OZQGdUVeO445my7msxgGgxhhZXBvGHMBIBXuVYdOq7L1QhIrirT41aGUS2Meu
	5v/tzduIGLp6ZNjc7lUr1/7MBcoNONlvWPRX1GJVQw1P18fXhbDjfMKi0Tw0iQK1wZjTwevqhR5
	tHYxIsd6kmCw0SVOm48JU7DyOOKx1Go21BM1vROzM6/goChCf8HZJEBNy1oAVNQeltun4cek+pc
	U3A==
X-Google-Smtp-Source: AGHT+IHS3VCuO0DELyvMXqSmUjp0hvq4Hsp6gx5PrETNMFgIvIGY1aaBdKJghR4spANzYYomy/4u5Q==
X-Received: by 2002:a17:90b:2e48:b0:311:d670:a10a with SMTP id 98e67ed59e1d1-313f1d68751mr958561a91.21.1749840263062;
        Fri, 13 Jun 2025 11:44:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430::3d? ([2600:1700:6476:1430::3d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365e0cff72sm17848015ad.241.2025.06.13.11.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 11:44:22 -0700 (PDT)
Message-ID: <137894454df573d26827d7d42354dbfd5502fa3c.camel@dubeyko.com>
Subject: Re: [PATCH v5] ceph: fix slab-use-after-free in
 have_mon_and_osd_map()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, amarkuze@redhat.com, 
	Slava.Dubeyko@ibm.com
Date: Fri, 13 Jun 2025 11:44:21 -0700
In-Reply-To: <670fd7d013c0309844530e88a9e5de15d91bcf59.camel@dubeyko.com>
References: <20250414221013.157819-1-slava@dubeyko.com>
		 <CAOi1vP8QreVDgY363c5b1Ke35N7tmRArcLfqQcwQiwJ-ULeWxg@mail.gmail.com>
		 <f6ef96ecfb43cdb695eb9292388434329ad3bc91.camel@dubeyko.com>
		 <CAOi1vP_+0f-RjBrCHNGpuNtYqfcg6A+CKPGGf-Nb_dLC4phVUg@mail.gmail.com>
	 <670fd7d013c0309844530e88a9e5de15d91bcf59.camel@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 12:50 -0700, Viacheslav Dubeyko wrote:
> On Thu, 2025-06-12 at 10:20 +0200, Ilya Dryomov wrote:
> > On Thu, Jun 12, 2025 at 1:14=E2=80=AFAM Viacheslav Dubeyko
> > <slava@dubeyko.com> wrote:
> > >=20
> > > On Wed, 2025-06-11 at 13:22 +0200, Ilya Dryomov wrote:
> > > > On Tue, Apr 15, 2025 at 12:10=E2=80=AFAM Viacheslav Dubeyko
> > > > <slava@dubeyko.com> wrote:
> > > > >=20
> > > > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > >=20
> > > > > The generic/395 and generic/397 is capable of generating
> > > > > the oops is on line net/ceph/ceph_common.c:794 with
> > > > > KASAN enabled.
> > > > >=20
> > > > > BUG: KASAN: slab-use-after-free in
> > > > > have_mon_and_osd_map+0x56/0x70
> > > > > Read of size 4 at addr ffff88811012d810 by task
> > > > > mount.ceph/13305
> > > > >=20
> > > > > CPU: 2 UID: 0 PID: 13305 Comm: mount.ceph Not tainted 6.14.0-
> > > > > rc2-
> > > > > build2+ #1266
> > > > > Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
> > > > > Call Trace:
> > > > > <TASK>
> > > > > dump_stack_lvl+0x57/0x80
> > > > > ? have_mon_and_osd_map+0x56/0x70
> > > > > print_address_description.constprop.0+0x84/0x330
> > > > > ? have_mon_and_osd_map+0x56/0x70
> > > > > print_report+0xe2/0x1e0
> > > > > ? rcu_read_unlock_sched+0x60/0x80
> > > > > ? kmem_cache_debug_flags+0xc/0x20
> > > > > ? fixup_red_left+0x17/0x30
> > > > > ? have_mon_and_osd_map+0x56/0x70
> > > > > kasan_report+0x8d/0xc0
> > > > > ? have_mon_and_osd_map+0x56/0x70
> > > > > have_mon_and_osd_map+0x56/0x70
> > > > > ceph_open_session+0x182/0x290
> > > > > ? __pfx_ceph_open_session+0x10/0x10
> > > > > ? __init_swait_queue_head+0x8d/0xa0
> > > > > ? __pfx_autoremove_wake_function+0x10/0x10
> > > > > ? shrinker_register+0xdd/0xf0
> > > > > ceph_get_tree+0x333/0x680
> > > > > vfs_get_tree+0x49/0x180
> > > > > do_new_mount+0x1a3/0x2d0
> > > > > ? __pfx_do_new_mount+0x10/0x10
> > > > > ? security_capable+0x39/0x70
> > > > > path_mount+0x6dd/0x730
> > > > > ? __pfx_path_mount+0x10/0x10
> > > > > ? kmem_cache_free+0x1e5/0x270
> > > > > ? user_path_at+0x48/0x60
> > > > > do_mount+0x99/0xe0
> > > > > ? __pfx_do_mount+0x10/0x10
> > > > > ? lock_release+0x155/0x190
> > > > > __do_sys_mount+0x141/0x180
> > > > > do_syscall_64+0x9f/0x100
> > > > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > RIP: 0033:0x7f01b1b14f3e
> > > > > Code: 48 8b 0d d5 3e 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66
> > > > > 2e
> > > > > 0f
> > > > > 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00
> > > > > 0f
> > > > > 05
> > > > > <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a2 3e 0f 00 f7 d8 64 89
> > > > > 01 48
> > > > > RSP: 002b:00007fffd129fa08 EFLAGS: 00000246 ORIG_RAX:
> > > > > 00000000000000a5
> > > > > RAX: ffffffffffffffda RBX: 0000564ec01a7850 RCX:
> > > > > 00007f01b1b14f3e
> > > > > RDX: 0000564ec00f2225 RSI: 00007fffd12a1964 RDI:
> > > > > 0000564ec0147a20
> > > > > RBP: 00007fffd129fbd0 R08: 0000564ec014da90 R09:
> > > > > 0000000000000080
> > > > > R10: 0000000000000000 R11: 0000000000000246 R12:
> > > > > 00007fffd12a194e
> > > > > R13: 0000000000000000 R14: 00007fffd129fa50 R15:
> > > > > 00007fffd129fa40
> > > > > </TASK>
> > > > >=20
> > > > > Allocated by task 13305:
> > > > > stack_trace_save+0x8c/0xc0
> > > > > kasan_save_stack+0x1e/0x40
> > > > > kasan_save_track+0x10/0x30
> > > > > __kasan_kmalloc+0x3a/0x50
> > > > > __kmalloc_noprof+0x247/0x290
> > > > > ceph_osdmap_alloc+0x16/0x130
> > > > > ceph_osdc_init+0x27a/0x4c0
> > > > > ceph_create_client+0x153/0x190
> > > > > create_fs_client+0x50/0x2a0
> > > > > ceph_get_tree+0xff/0x680
> > > > > vfs_get_tree+0x49/0x180
> > > > > do_new_mount+0x1a3/0x2d0
> > > > > path_mount+0x6dd/0x730
> > > > > do_mount+0x99/0xe0
> > > > > __do_sys_mount+0x141/0x180
> > > > > do_syscall_64+0x9f/0x100
> > > > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > >=20
> > > > > Freed by task 9475:
> > > > > stack_trace_save+0x8c/0xc0
> > > > > kasan_save_stack+0x1e/0x40
> > > > > kasan_save_track+0x10/0x30
> > > > > kasan_save_free_info+0x3b/0x50
> > > > > __kasan_slab_free+0x18/0x30
> > > > > kfree+0x212/0x290
> > > > > handle_one_map+0x23c/0x3b0
> > > > > ceph_osdc_handle_map+0x3c9/0x590
> > > > > mon_dispatch+0x655/0x6f0
> > > > > ceph_con_process_message+0xc3/0xe0
> > > > > ceph_con_v1_try_read+0x614/0x760
> > > > > ceph_con_workfn+0x2de/0x650
> > > > > process_one_work+0x486/0x7c0
> > > > > process_scheduled_works+0x73/0x90
> > > > > worker_thread+0x1c8/0x2a0
> > > > > kthread+0x2ec/0x300
> > > > > ret_from_fork+0x24/0x40
> > > > > ret_from_fork_asm+0x1a/0x30
> > > > >=20
> > > > > The buggy address belongs to the object at ffff88811012d800
> > > > > which belongs to the cache kmalloc-512 of size 512
> > > > > The buggy address is located 16 bytes inside of
> > > > > freed 512-byte region [ffff88811012d800, ffff88811012da00)
> > > > >=20
> > > > > The buggy address belongs to the physical page:
> > > > > page: refcount:0 mapcount:0 mapping:0000000000000000
> > > > > index:0x0
> > > > > pfn:0x11012c
> > > > > head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0
> > > > > pincount:0
> > > > > flags: 0x200000000000040(head|node=3D0|zone=3D2)
> > > > > page_type: f5(slab)
> > > > > raw: 0200000000000040 ffff888100042c80 dead000000000100
> > > > > dead000000000122
> > > > > raw: 0000000000000000 0000000080100010 00000000f5000000
> > > > > 0000000000000000
> > > > > head: 0200000000000040 ffff888100042c80 dead000000000100
> > > > > dead000000000122
> > > > > head: 0000000000000000 0000000080100010 00000000f5000000
> > > > > 0000000000000000
> > > > > head: 0200000000000002 ffffea0004404b01 ffffffffffffffff
> > > > > 0000000000000000
> > > > > head: 0000000000000004 0000000000000000 00000000ffffffff
> > > > > 0000000000000000
> > > > > page dumped because: kasan: bad access detected
> > > > >=20
> > > > > Memory state around the buggy address:
> > > > > ffff88811012d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > > fc
> > > > > fc
> > > > > ffff88811012d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > > fc
> > > > > fc
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 ffff88811012d800: fa fb fb fb fb fb fb fb fb f=
b fb fb fb
> > > > > fb
> > > > > fb
> > > > > fb
> > > > >=20
> > > > > ^
> > > > > ffff88811012d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > > fb
> > > > > fb
> > > > > ffff88811012d900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > > fb
> > > > > fb
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > =3D=3D
> > > > > =3D=3D=3D
> > > > > Disabling lock debugging due to kernel taint
> > > > > libceph: client274326 fsid 8598140e-35c2-11ee-b97c-
> > > > > 001517c545cc
> > > > > libceph: mon0 (1)90.155.74.19:6789 session established
> > > > > libceph: client274327 fsid 8598140e-35c2-11ee-b97c-
> > > > > 001517c545cc
> > > > >=20
> > > > > We have such scenario:
> > > > >=20
> > > > > Thread 1:
> > > > > void ceph_osdmap_destroy(...) {
> > > > > =C2=A0=C2=A0=C2=A0 <skipped>
> > > > > =C2=A0=C2=A0=C2=A0 kfree(map);
> > > > > }
> > > > > Thread 1 sleep...
> > > > >=20
> > > > > Thread 2:
> > > > > static bool have_mon_and_osd_map(struct ceph_client *client)
> > > > > {
> > > > > =C2=A0=C2=A0=C2=A0 return client->monc.monmap && client->monc.mon=
map->epoch
> > > > > &&
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client->osdc.osdmap &&=
 client->osdc.osdmap->epoch;
> > > > > }
> > > > > Thread 2 has oops...
> > > > >=20
> > > > > Thread 1 wake up:
> > > > > static int handle_one_map(...) {
> > > > > =C2=A0=C2=A0=C2=A0 <skipped>
> > > > > =C2=A0=C2=A0=C2=A0 osdc->osdmap =3D newmap;
> > > > > =C2=A0=C2=A0=C2=A0 <skipped>
> > > > > }
> > > > >=20
> > > > > This patch introduces a have_mon_and_osd_map atomic_t
> > > > > field in struct ceph_client. If there is no OSD and
> > > > > monitor maps, then the client->have_mon_and_osd_map
> > > > > is equal to zero. The OSD and monitor maps initialization
> > > > > results in incrementing of client->have_mon_and_osd_map
> > > > > under the lock. As a result, have_mon_and_osd_map() function
> > > > > simply checks now that client->have_mon_and_osd_map is equal
> > > > > to
> > > > > CEPH_CLIENT_HAS_MON_AND_OSD_MAP.
> > > > >=20
> > > > > Patch adds locking in the ceph_osdc_stop()
> > > > > method during the destructruction of osdc->osdmap and
> > > > > assigning of NULL to the pointer. The lock is used
> > > > > in the ceph_monc_stop() during the freeing of monc->monmap
> > > > > and assigning NULL to the pointer too. The monmap_show()
> > > > > and osdmap_show() methods were reworked to prevent
> > > > > the potential race condition during the methods call.
> > > > >=20
> > > > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > > ---
> > > > > =C2=A0include/linux/ceph/libceph.h | 20 ++++++++++++++++++++
> > > > > =C2=A0net/ceph/ceph_common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 6 ++++--
> > > > > =C2=A0net/ceph/debugfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 17 +++++++++++++----
> > > > > =C2=A0net/ceph/mon_client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 18 +++++++++++++++++-
> > > > > =C2=A0net/ceph/osd_client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 11 +++++++++++
> > > > > =C2=A05 files changed, 65 insertions(+), 7 deletions(-)
> > > > >=20
> > > > > diff --git a/include/linux/ceph/libceph.h
> > > > > b/include/linux/ceph/libceph.h
> > > > > index 733e7f93db66..f5694bf5bd54 100644
> > > > > --- a/include/linux/ceph/libceph.h
> > > > > +++ b/include/linux/ceph/libceph.h
> > > > > @@ -132,6 +132,7 @@ struct ceph_client {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_messenger =
msgr;=C2=A0=C2=A0 /* messenger instance
> > > > > */
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_mon_client=
 monc;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_osd_client=
 osdc;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_t have_mon_and_osd_m=
ap;
> > > > >=20
> > > > > =C2=A0#ifdef CONFIG_DEBUG_FS
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *debugfs=
_dir;
> > > > > @@ -141,6 +142,25 @@ struct ceph_client {
> > > > > =C2=A0#endif
> > > > > =C2=A0};
> > > > >=20
> > > > > +/*
> > > > > + * The have_mon_and_osd_map possible states
> > > > > + */
> > > > > +enum {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CEPH_CLIENT_HAS_NO_MON_AND_=
NO_OSD_MAP =3D 0,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CEPH_CLIENT_HAS_ONLY_ONE_MA=
P =3D 1,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CEPH_CLIENT_HAS_MON_AND_OSD=
_MAP =3D 2,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CEPH_CLIENT_MAP_STATE_UNKNO=
WN
> > > > > +};
> > > > > +
> > > > > +static inline
> > > > > +bool is_mon_and_osd_map_state_invalid(struct ceph_client
> > > > > *client)
> > > > > +{
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int have_mon_and_osd_map =
=3D atomic_read(&client-
> > > > > > have_mon_and_osd_map);
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return have_mon_and_osd_map=
 <
> > > > > CEPH_CLIENT_HAS_NO_MON_AND_NO_OSD_MAP ||
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 have_mon_and_osd_map >=3D
> > > > > CEPH_CLIENT_MAP_STATE_UNKNOWN;
> > > > > +}
> > > > > +
> > > > > =C2=A0#define from_msgr(ms)=C2=A0 container_of(ms, struct ceph_cl=
ient,
> > > > > msgr)
> > > > >=20
> > > > > =C2=A0static inline bool ceph_msgr2(struct ceph_client *client)
> > > > > diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> > > > > index 4c6441536d55..62efceb3b19d 100644
> > > > > --- a/net/ceph/ceph_common.c
> > > > > +++ b/net/ceph/ceph_common.c
> > > > > @@ -723,6 +723,8 @@ struct ceph_client
> > > > > *ceph_create_client(struct
> > > > > ceph_options *opt, void *private)
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_init(&client->mo=
unt_mutex);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init_waitqueue_head(&c=
lient->auth_wq);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&client->have_mo=
n_and_osd_map,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CEPH_CLIENT_HAS_NO_MON_AND_NO_OSD_M=
AP);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client->auth_err =3D 0=
;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client->extra_mon_disp=
atch =3D NULL;
> > > > > @@ -790,8 +792,8 @@ EXPORT_SYMBOL(ceph_reset_client_addr);
> > > > > =C2=A0 */
> > > > > =C2=A0static bool have_mon_and_osd_map(struct ceph_client *client=
)
> > > > > =C2=A0{
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return client->monc.monmap =
&& client->monc.monmap-
> > > > > > epoch &&
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 client->osdc.osdmap && client->osdc.osdmap-
> > > > > > epoch;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return atomic_read(&client-=
>have_mon_and_osd_map) =3D=3D
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > CEPH_CLIENT_HAS_MON_AND_OSD_MAP;
> > > > > =C2=A0}
> > > > >=20
> > > > > =C2=A0/*
> > > > > diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> > > > > index 2110439f8a24..7b45c169a859 100644
> > > > > --- a/net/ceph/debugfs.c
> > > > > +++ b/net/ceph/debugfs.c
> > > > > @@ -36,8 +36,10 @@ static int monmap_show(struct seq_file *s,
> > > > > void
> > > > > *p)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_client *cl=
ient =3D s->private;
> > > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&client->monc.mu=
tex);
> > > > > +
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (client->monc.monma=
p =3D=3D NULL)
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out_unlock;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(s, "epoch %=
d\n", client->monc.monmap-
> > > > > > epoch);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < clie=
nt->monc.monmap->num_mon; i++) {
> > > > > @@ -48,6 +50,10 @@ static int monmap_show(struct seq_file *s,
> > > > > void
> > > > > *p)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ENTITY_NAME(inst->name),
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ceph_pr_addr(&inst->addr));
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > +
> > > > > +out_unlock:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&client->monc.=
mutex);
> > > > > +
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > =C2=A0}
> > > > >=20
> > > > > @@ -56,13 +62,15 @@ static int osdmap_show(struct seq_file
> > > > > *s,
> > > > > void
> > > > > *p)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_client *cl=
ient =3D s->private;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_osd_client=
 *osdc =3D &client->osdc;
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_osdmap *map =3D=
 osdc->osdmap;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_osdmap *map =3D=
 NULL;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rb_node *n;
> > > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 down_read(&osdc->lock);
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map =3D osdc->osdmap;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (map =3D=3D NULL)
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out_unlock;
> > > > >=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 down_read(&osdc->lock);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(s, "epoch %=
u barrier %u flags 0x%x\n",
> > > > > map-
> > > > > > epoch,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 osdc->epoch_barrier, map->flags);
> > > > >=20
> > > > > @@ -131,6 +139,7 @@ static int osdmap_show(struct seq_file
> > > > > *s,
> > > > > void
> > > > > *p)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(s, "]\n");
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > >=20
> > > > > +out_unlock:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 up_read(&osdc->lock);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > =C2=A0}
> > > > > diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> > > > > index ab66b599ac47..5cf802236426 100644
> > > > > --- a/net/ceph/mon_client.c
> > > > > +++ b/net/ceph/mon_client.c
> > > > > @@ -562,12 +562,16 @@ static void ceph_monc_handle_map(struct
> > > > > ceph_mon_client *monc,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_dec(&client->have_mo=
n_and_osd_map);
> > > > > +
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(monc->monmap);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monc->monmap =3D monma=
p;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __ceph_monc_got_map(mo=
nc, CEPH_SUB_MONMAP, monc-
> > > > > > monmap-
> > > > > > epoch);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client->have_fsid =3D =
true;
> > > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_inc(&client->have_mo=
n_and_osd_map);
> > > > > +
> > > > > =C2=A0out:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&monc->mu=
tex);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wake_up_all(&client->a=
uth_wq);
> > > > > @@ -1220,6 +1224,9 @@ int ceph_monc_init(struct
> > > > > ceph_mon_client
> > > > > *monc, struct ceph_client *cl)
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monc->fs_cluster_id =
=3D CEPH_FS_CLUSTER_ID_NONE;
> > > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_inc(&monc->client->h=
ave_mon_and_osd_map);
> > > >=20
> > > > Hi Slava,
> > > >=20
> > > > Incrementing client->have_mon_and_osd_map here and in
> > > > ceph_osdc_init()
> > > > means that counter would be set to 2
> > > > (CEPH_CLIENT_HAS_MON_AND_OSD_MAP)
> > > > at the initialization time, way before a session with the
> > > > monitor
> > > > is
> > > > established and any map is received.=C2=A0 This effectively disable=
s
> > > > the
> > > > wait logic in __ceph_open_session() because of
> > > > have_mon_and_osd_map()
> > > > immediately returning true.=C2=A0 __ceph_open_session() is
> > > > responsible
> > > > for
> > > > setting up the debugfs directory and that is affected too: it's
> > > > created
> > > > as 00000000-0000-0000-0000-000000000000.client0 because neither
> > > > the
> > > > cluster FSID nor the client ID is known without the monmap.
> > > >=20
> > > > This patch seems to be over-complicated for what it needs to
> > > > do:
> > > > I don't see a compelling reason for introducing the atomic and
> > > > as
> > > > mentioned before there is no need to attempt to guard against
> > > > someone
> > > > continuing to use the client after ceph_osdc_stop() and
> > > > ceph_monc_stop()
> > > > are called.=C2=A0 It's the point of no return and the client itself
> > > > gets
> > > > freed very shortly after.
> > > >=20
> > > > Why not just open-code the wait loop in __ceph_open_session()
> > > > to
> > > > allow
> > > > for monc->mutex and osdc->lock (for read) to be taken freely?=C2=A0
> > > > It
> > > > should
> > > > be a small change in __ceph_open_session() --
> > > > net/ceph/mon_client.c
> > > > and
> > > > net/ceph/osd_client.c wouldn't need to be touched at all.
> > > >=20
> > >=20
> > > Hi Ilya,
> > >=20
> > > Frankly speaking, I don't quite follow to your point. The main
> > > issue
> > > happens when one thread calls ceph_osdc_handle_map() [1] ->
> > > handle_one_map() [2]:
> > >=20
> > > ceph_osdmap_destroy() [3] -> kfree(map) -> go to sleep
> > >=20
> > > <-- another thread receives time slices to execute:
> > > have_mon_and_osd_map() BUT osdc->osdmap is already freed and
> > > invalid
> > > here!!!
> > >=20
> > > osdc->osdmap =3D newmap;
> > >=20
> > > So, it's not about ceph_osdc_stop() or ceph_monc_stop() but it's
> > > about
> > > regular operations.
> >=20
> > I know, but on top of the regular operations (to be precise, one
> > regular operation -- __ceph_open_session()) the current patch also
> > tries to harden ceph_osdc_stop() and ceph_monc_stop().=C2=A0 I wanted t=
o
> > reiterate that it's not needed.
> >=20
> > >=20
> > > I've tried to exclude the necessity to use locks at all in
> > > have_mon_and_osd_map(). Do you mean that wait loop will be better
> > > solution?
> >=20
> > Yes, it seems preferable over an otherwise redundant (i.e. not used
> > for
> > anything else) atomic which turned out to be tricky enough to get
> > right
> > on the first try.
> >=20
> > > It sounds pretty complicated too for my taste and it will
> > > require coordination among threads. No? I am not completely sure
> > > that I
> > > follow to your vision.
> >=20
> > With the help of woken_wake_function() primitive it shouldn't be
> > complicated at all.=C2=A0 The diff would be limited to
> > __ceph_open_session()
> > and I would expect it to be on par with the current patch.=C2=A0 Making
> > it
> > possible to freely take locks there would also squash another
> > related
> > buglet: client->auth_err shouldn't be accessed outside of monc-
> > >mutex
> > either.=C2=A0 Being just an int, it's not complained about by KASAN ;)
> >=20
> > Since __ceph_open_session() is the only user of
> > have_mon_and_osd_map()
> > it could be open-coded inside of the wait loop.
> >=20
>=20
> OK. Let me try to rework my patch yet another time. :)
>=20

Hi Ilya,

Probably, we need to consider of adding Ceph related xfstests' test-
case for checking debugfs items. What do you think? Which debugfs items
this test should check? Also, maybe, we need to add a test for checking
snapshot functionality in Ceph when CephFS kernel client operates?

Thanks,
Slava.

