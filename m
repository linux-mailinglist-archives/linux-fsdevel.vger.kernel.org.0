Return-Path: <linux-fsdevel+bounces-58417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF72B2E8FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ACED7BE18F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 23:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C1E2E22AE;
	Wed, 20 Aug 2025 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="2ORRglJd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592072E174C
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 23:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733260; cv=none; b=mXGizydBeGxxv7Qhrj3uS99Oh78YKxp67oBFaMVabEvU4+uBj9/j/ZBdPbVBK3U3GCIqxahqKVgoOz26lrT60PgTqXRYBP0WXNEPLMcPbi6ONJLuer9Y7TqJ/Clt3krSSxLKekF/jb/tiuyxyZZyVEKdRvJFwwFq/Zm+XYHW1A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733260; c=relaxed/simple;
	bh=vCMuKWeNTW799qzE7lt97a++FykZ9goH0gV2kjt1XHw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Je5ERjYrhKV2yvhNwuuSHR8urjSK50RMNG3kUkm7IFBnWwZGAvkFdeimN1GbXY4rY/HbJMJmImeAwNFZk5ODu7n5ZLvvmFvoMjvOZOIn5YOGT6d1FUtt6IVy7v/3qtb89Bs1wNbdsLIagINZCDnUZZo2/nDSDLUlSJU5EKrlmYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=2ORRglJd; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e95075d60b6so204742276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 16:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1755733257; x=1756338057; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vCMuKWeNTW799qzE7lt97a++FykZ9goH0gV2kjt1XHw=;
        b=2ORRglJdSmCyvatXXToW6wj3DKDaMnKP2kgRX3liXsIZkny9xNlrADgWrx0Pz81rmP
         V8HYVv2XxjQ9IuCLggkqF9TDto18ZrCZsXoJmfJloCl2rGthtu7VAtBCbwho/7Zp5Rxr
         K4vbhR8sdyv41X/Hzm3L8EWzGwUNofvdx2ywcAui25urwLv77B/WvnXOJcXZSXlgXhCM
         mf8PD953z0WfbBExzp0ECEv1QTwTtcO1jjcPy4DrLSaq54oG5lecoxWA8k1nEouCf1P/
         nNCbG0KsfaiT+f9JNZosLVQUSWWaWpSLZxEkIxgjghZtHzg+Bab9/AZTu2Cc9o+6FbBB
         grAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733257; x=1756338057;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCMuKWeNTW799qzE7lt97a++FykZ9goH0gV2kjt1XHw=;
        b=XXRL89MMER1/21vhK5Ci2wgFOO03Bo6tK5JfDAaXegy9F/X71FDJNOsiEIBhsmCwao
         KFmj75bHA/RZ2iC3jtw6UjvnWYqNhNEL0DeyvJjCq06+qpHl2KTZrxM1FsIu204tMElA
         PETIUQ6pduJ0wM6E8XnVXG5QFye7o4xkd7Q0xDGa7KffHJgGHHGYYIg4iSzwVjt9OEP4
         f9DefXwHuYd7EA2EOCbyfnNDwgQ9uhShb+10SOCki6sXnP22l3zqQUvDQpu4OhlxzO7c
         3JGNRYO2UTGvAFlgp54N6D4eaUnD6fY74Tj4qGMAdB5V8lxi0mGp7LunMRHvVhWWQvzn
         BrRA==
X-Forwarded-Encrypted: i=1; AJvYcCXc2KX+LW/R+VA3eVI2TsdBJiBQd3EfoC5Z60JtsY33/AY9HInOPku9uDFxP1Q/xmPFJ8fcA+IBP6V4/l7o@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4aQ0MfZIPlLJRzq9Oc2JQ30i9fjJQChHC0fiksgdn1YxRaA13
	fy4PhbOXl7AWTY2es2Ru8vW2hwHj+Jdz5lP/Xe6VAUlS4vihVjOmHfgzq0ecgMD+K/Q=
X-Gm-Gg: ASbGncsLcYM9gc4UF1+EBBQL5hul6Relcm/12CaWL4i4LOytg0gTTWvv8MIi3p1Mbxc
	KIOh8zdzhqEiUBe5zx/kr2BUt5Z4MqNaPOF+OweDMwxbJMvKeKCfHAk5It4Qd2biXcJEFUn80yC
	s6SVz/nR514IK1Cu/eGIbuj1CBVwIZ/ssBpOTpeJjRoT14XkUU4UUwHnULZ7rbJ+h7kMyxH3KGu
	3bPUN5F1Pj4S61If2gVMxHLekr/eZ9LhwjzXnTr0uFQAiLOLUWKtZ/yTZigDIKJDoZP+ms5HsSR
	+FWVjw/0LeyDKAwl905vZB8Djk+Buww4Rcph7/g24xQJ2kEeOJmbJk+pbIhT4b43NPZASv+ZM3c
	84xBCxZ2T/0BygEo0Ox43ZiwTXy+PDrsM
X-Google-Smtp-Source: AGHT+IFpUa14q7SJ9POs7IDip00KllXuY7nP0NUdJfc1P/9G+65qMgvgYyB56JGBelkotu8Qfm1zdg==
X-Received: by 2002:a05:6902:983:b0:e93:3a7c:10da with SMTP id 3f1490d57ef6-e9509a440fbmr764783276.37.1755733257079;
        Wed, 20 Aug 2025 16:40:57 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:3803:c8a:daa8:762e])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94e6749b90sm2129954276.2.2025.08.20.16.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:40:56 -0700 (PDT)
Message-ID: <17d22d0e159b4c6ee10544e8bf917559b1d3b5fe.camel@dubeyko.com>
Subject: Re: [PATCH v7] ceph: fix slab-use-after-free in
 have_mon_and_osd_map()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, amarkuze@redhat.com, 
	Slava.Dubeyko@ibm.com
Date: Wed, 20 Aug 2025 16:40:54 -0700
In-Reply-To: <CAOi1vP8Meq-TBetLmkmKBKzsqf9gzyZwZc8413bfE19WhpmPvA@mail.gmail.com>
References: <20250703174128.500301-1-slava@dubeyko.com>
	 <CAOi1vP8Meq-TBetLmkmKBKzsqf9gzyZwZc8413bfE19WhpmPvA@mail.gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-20 at 22:04 +0200, Ilya Dryomov wrote:
> On Thu, Jul 3, 2025 at 7:41=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.=
com>
> wrote:
> >=20
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >=20
> > The generic/395 and generic/397 is capable of generating
> > the oops is on line net/ceph/ceph_common.c:794 with
> > KASAN enabled.
> >=20
> > BUG: KASAN: slab-use-after-free in have_mon_and_osd_map+0x56/0x70
> > Read of size 4 at addr ffff88811012d810 by task mount.ceph/13305
> >=20
> > CPU: 2 UID: 0 PID: 13305 Comm: mount.ceph Not tainted 6.14.0-rc2-
> > build2+ #1266
> > Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
> > Call Trace:
> > <TASK>
> > dump_stack_lvl+0x57/0x80
> > ? have_mon_and_osd_map+0x56/0x70
> > print_address_description.constprop.0+0x84/0x330
> > ? have_mon_and_osd_map+0x56/0x70
> > print_report+0xe2/0x1e0
> > ? rcu_read_unlock_sched+0x60/0x80
> > ? kmem_cache_debug_flags+0xc/0x20
> > ? fixup_red_left+0x17/0x30
> > ? have_mon_and_osd_map+0x56/0x70
> > kasan_report+0x8d/0xc0
> > ? have_mon_and_osd_map+0x56/0x70
> > have_mon_and_osd_map+0x56/0x70
> > ceph_open_session+0x182/0x290
> > ? __pfx_ceph_open_session+0x10/0x10
> > ? __init_swait_queue_head+0x8d/0xa0
> > ? __pfx_autoremove_wake_function+0x10/0x10
> > ? shrinker_register+0xdd/0xf0
> > ceph_get_tree+0x333/0x680
> > vfs_get_tree+0x49/0x180
> > do_new_mount+0x1a3/0x2d0
> > ? __pfx_do_new_mount+0x10/0x10
> > ? security_capable+0x39/0x70
> > path_mount+0x6dd/0x730
> > ? __pfx_path_mount+0x10/0x10
> > ? kmem_cache_free+0x1e5/0x270
> > ? user_path_at+0x48/0x60
> > do_mount+0x99/0xe0
> > ? __pfx_do_mount+0x10/0x10
> > ? lock_release+0x155/0x190
> > __do_sys_mount+0x141/0x180
> > do_syscall_64+0x9f/0x100
> > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > RIP: 0033:0x7f01b1b14f3e
> > Code: 48 8b 0d d5 3e 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f
> > 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05
> > <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a2 3e 0f 00 f7 d8 64 89 01 48
> > RSP: 002b:00007fffd129fa08 EFLAGS: 00000246 ORIG_RAX:
> > 00000000000000a5
> > RAX: ffffffffffffffda RBX: 0000564ec01a7850 RCX: 00007f01b1b14f3e
> > RDX: 0000564ec00f2225 RSI: 00007fffd12a1964 RDI: 0000564ec0147a20
> > RBP: 00007fffd129fbd0 R08: 0000564ec014da90 R09: 0000000000000080
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffd12a194e
> > R13: 0000000000000000 R14: 00007fffd129fa50 R15: 00007fffd129fa40
> > </TASK>
> >=20
> > Allocated by task 13305:
> > stack_trace_save+0x8c/0xc0
> > kasan_save_stack+0x1e/0x40
> > kasan_save_track+0x10/0x30
> > __kasan_kmalloc+0x3a/0x50
> > __kmalloc_noprof+0x247/0x290
> > ceph_osdmap_alloc+0x16/0x130
> > ceph_osdc_init+0x27a/0x4c0
> > ceph_create_client+0x153/0x190
> > create_fs_client+0x50/0x2a0
> > ceph_get_tree+0xff/0x680
> > vfs_get_tree+0x49/0x180
> > do_new_mount+0x1a3/0x2d0
> > path_mount+0x6dd/0x730
> > do_mount+0x99/0xe0
> > __do_sys_mount+0x141/0x180
> > do_syscall_64+0x9f/0x100
> > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >=20
> > Freed by task 9475:
> > stack_trace_save+0x8c/0xc0
> > kasan_save_stack+0x1e/0x40
> > kasan_save_track+0x10/0x30
> > kasan_save_free_info+0x3b/0x50
> > __kasan_slab_free+0x18/0x30
> > kfree+0x212/0x290
> > handle_one_map+0x23c/0x3b0
> > ceph_osdc_handle_map+0x3c9/0x590
> > mon_dispatch+0x655/0x6f0
> > ceph_con_process_message+0xc3/0xe0
> > ceph_con_v1_try_read+0x614/0x760
> > ceph_con_workfn+0x2de/0x650
> > process_one_work+0x486/0x7c0
> > process_scheduled_works+0x73/0x90
> > worker_thread+0x1c8/0x2a0
> > kthread+0x2ec/0x300
> > ret_from_fork+0x24/0x40
> > ret_from_fork_asm+0x1a/0x30
> >=20
> > The buggy address belongs to the object at ffff88811012d800
> > which belongs to the cache kmalloc-512 of size 512
> > The buggy address is located 16 bytes inside of
> > freed 512-byte region [ffff88811012d800, ffff88811012da00)
> >=20
> > The buggy address belongs to the physical page:
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
> > pfn:0x11012c
> > head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0
> > pincount:0
> > flags: 0x200000000000040(head|node=3D0|zone=3D2)
> > page_type: f5(slab)
> > raw: 0200000000000040 ffff888100042c80 dead000000000100
> > dead000000000122
> > raw: 0000000000000000 0000000080100010 00000000f5000000
> > 0000000000000000
> > head: 0200000000000040 ffff888100042c80 dead000000000100
> > dead000000000122
> > head: 0000000000000000 0000000080100010 00000000f5000000
> > 0000000000000000
> > head: 0200000000000002 ffffea0004404b01 ffffffffffffffff
> > 0000000000000000
> > head: 0000000000000004 0000000000000000 00000000ffffffff
> > 0000000000000000
> > page dumped because: kasan: bad access detected
> >=20
> > Memory state around the buggy address:
> > ffff88811012d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff88811012d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >=20
> > =C2=A0=C2=A0=C2=A0 ffff88811012d800: fa fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb
> > fb
> >=20
> > ^
> > ffff88811012d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ffff88811012d900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Disabling lock debugging due to kernel taint
> > libceph: client274326 fsid 8598140e-35c2-11ee-b97c-001517c545cc
> > libceph: mon0 (1)90.155.74.19:6789 session established
> > libceph: client274327 fsid 8598140e-35c2-11ee-b97c-001517c545cc
> >=20
> > We have such scenario:
> >=20
> > Thread 1:
> > void ceph_osdmap_destroy(...) {
> > =C2=A0=C2=A0=C2=A0 <skipped>
> > =C2=A0=C2=A0=C2=A0 kfree(map);
> > }
> > Thread 1 sleep...
> >=20
> > Thread 2:
> > static bool have_mon_and_osd_map(struct ceph_client *client) {
> > =C2=A0=C2=A0=C2=A0 return client->monc.monmap && client->monc.monmap->e=
poch &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client->osdc.osdmap && clien=
t->osdc.osdmap->epoch;
> > }
> > Thread 2 has oops...
> >=20
> > Thread 1 wake up:
> > static int handle_one_map(...) {
> > =C2=A0=C2=A0=C2=A0 <skipped>
> > =C2=A0=C2=A0=C2=A0 osdc->osdmap =3D newmap;
> > =C2=A0=C2=A0=C2=A0 <skipped>
> > }
> >=20
> > This patch fixes the issue by means of locking
> > client->osdc.lock and client->monc.mutex before
> > the checking client->osdc.osdmap and
> > client->monc.monmap in have_mon_and_osd_map() function.
> > The monmap_show() and osdmap_show() methods were reworked
> > to prevent the potential race condition during
> > the methods call.
> >=20
> > Reported-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > ---
> > =C2=A0net/ceph/ceph_common.c | 43 +++++++++++++++++++++++++++++++++++--=
-
> > ----
> > =C2=A0net/ceph/debugfs.c=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++++++++++++----
> > =C2=A0net/ceph/mon_client.c=C2=A0 |=C2=A0 2 ++
> > =C2=A0net/ceph/osd_client.c=C2=A0 |=C2=A0 2 ++
> > =C2=A04 files changed, 53 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> > index 4c6441536d55..bf2be6e43ff7 100644
> > --- a/net/ceph/ceph_common.c
> > +++ b/net/ceph/ceph_common.c
> > @@ -790,8 +790,18 @@ EXPORT_SYMBOL(ceph_reset_client_addr);
> > =C2=A0 */
> > =C2=A0static bool have_mon_and_osd_map(struct ceph_client *client)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return client->monc.monmap && cli=
ent->monc.monmap->epoch &&
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 client->osdc.osdmap && client->osdc.osdmap->epoch;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool have_mon_map =3D false;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool have_osd_map =3D false;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&client->monc.mutex);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 have_mon_map =3D client->monc.mon=
map && client->monc.monmap-
> > >epoch;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&client->monc.mutex)=
;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 down_read(&client->osdc.lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 have_osd_map =3D client->osdc.osd=
map && client->osdc.osdmap-
> > >epoch;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 up_read(&client->osdc.lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return have_mon_map && have_osd_m=
ap;
> > =C2=A0}
> >=20
> > =C2=A0/*
> > @@ -800,6 +810,7 @@ static bool have_mon_and_osd_map(struct
> > ceph_client *client)
> > =C2=A0int __ceph_open_session(struct ceph_client *client, unsigned long
> > started)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long timeout =3D cl=
ient->options->mount_timeout;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int auth_err =3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long err;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* open session, and wait fo=
r mon and osd maps */
> > @@ -808,18 +819,36 @@ int __ceph_open_session(struct ceph_client
> > *client, unsigned long started)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return err;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (!have_mon_and_osd_map=
(client)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mutex_lock(&client->monc.mutex);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 auth_err =3D client->auth_err;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mutex_unlock(&client->monc.mutex);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (auth_err < 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return auth=
_err;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (timeout && time_after_eq(jiffies, started +
> > timeout))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n -ETIMEDOUT;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* wait */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dout("mount waiting for mon_map\n");
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 err =3D wait_event_interruptible_timeout(client-
> > >auth_wq,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 have_mon_an=
d_osd_map(client) || (client-
> > >auth_err < 0),
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_timeou=
t_jiffies(timeout));
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DEFINE_WAIT_FUNC(wait, woken_wake_function);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 add_wait_queue(&client->auth_wq, &wait);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 while (!have_mon_and_osd_map(client)) {
>=20
> Hi Slava,
>=20
> This still doesn't seem right to me.
>=20
> There is a nested while loop with the same
> !have_mon_and_osd_map(client)
> condition which suggests that one of those is redundant -- once the
> nested loop is entered there is no way for the outer loop to be
> entered
> again (i.e. continued) because upon exit from the nested loop either
> have_mon_and_osd_map() would no longer be false or err would be set
> to
> ERESTARTSYS.
>=20
> An important detail also got lost in the change: client->auth_err < 0
> was previously part of wait_event_interruptible_timeout() condition
> which meant that it was checked repeatedly on every wakeup whereas
> now
> it's checked just once at the beginning.=C2=A0 This would lead to a hang
> on
> any authentication-related error raised by the monitor client.
>=20
>=20

OK. Makes sense. Let me double check the logic.

Thanks,
Slava.

