Return-Path: <linux-fsdevel+bounces-51518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8951EAD7B72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 21:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A7617AA99F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 19:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B362D5417;
	Thu, 12 Jun 2025 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="AQ8Uk+bQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5EE2D4B49
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757856; cv=none; b=U2yFR4HDUiJN2qNTWra/VnwdGER9cxJ1NDnfxRU1VcZIl0RwVzNTtAaZeJqmH4wx4+C+ytoV63bARxGd7YAlAGPeup0S2cTT+xe8bcwCUXGcJIU4DEHcMVc0qYTTISBXRhRac9hjC87U0+Nq5KPcdYutcDYYUAtfvEQT6Lm3x64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757856; c=relaxed/simple;
	bh=aKTlR7HA9qAeG/nCQedL5G41cfrkAam4TI7EPEu0ce4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NCUrC7FCY2jLMC9zsrioh9f7jTEd4QGVe1yPR7aYJJ0ZbzMdXPle9NXSwiQyR73RaxR4xooWn5Sgtwj6J0pI5PH4dwdkb2Im33GaXISy2G5WWtz6PUVIjh7I3a20zoWfeRB6VTM0f4owZzaznga6yBZToMnjYsLv7XBbOayUvgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=AQ8Uk+bQ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e767ce72eso13182497b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1749757852; x=1750362652; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aKTlR7HA9qAeG/nCQedL5G41cfrkAam4TI7EPEu0ce4=;
        b=AQ8Uk+bQCngMPmuswWnDMIfGWjGbEdafsPHH0npoBgM+FOPFCoBmOhIhoJD4R+pxnD
         1LwXIiyFvmysWOpNiE+C/ScqS13D8AbJj2d5flb/0AABymlQnXbSLi//SaVINxWgmcWC
         6W+oe8Oil5BZbrgPDUoueCxDwe6onLlMKGD8LKUgqKDNQjdO5XkhJfEdqvz8cMCA4XaI
         biogi/z7nfFbu8qtEy2eyDcBL4XzJ7/kNxzD5GZaoCOhjXb9ri4p4kfe2jIweMw/SrmB
         ZzMwlMbw+us2VgN4M5tezng4ZXDy8fxse0c1SKAo2URGVWMe511KyxhjN/CGmHO0SQR+
         PGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749757852; x=1750362652;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aKTlR7HA9qAeG/nCQedL5G41cfrkAam4TI7EPEu0ce4=;
        b=NlTLCDicSmpRnh+JhHoWaxvERlz8kANfN/bNmlLCK4tTnIl7ALlsECH9sZP7h1ROiG
         ZoIrDNwIvoSKumh1NjunABUJLT/6aQ+h5wCYZgozyaak2muk+v4leApM0kSafaBCzYF1
         s7lQ1QApPlKOG3cPlICTjatNBNjYJt5KDCQrzvTqTDgO8QiKw/xNcp+09KVfFrABx+jK
         AOKd3/DH8mUcJT/4Zu9nGD8rSIZorVcZOwAG/In/o67+wdK5fTva2q21ctVkqV16EY/w
         zVyIIcEoMW0AUSdqs9htMCwhQLTTuNcSVDN7TlyE0b2T7chLqLSV448uVTWlZKdu3FgV
         nxLA==
X-Forwarded-Encrypted: i=1; AJvYcCWvLlhYjRoSb2+QCI7Gz4VammEUKeCWcCLO8wDGZtPIuZSh6C4/8+wVQyp/QuNgdycrAGUsyzKXD3i8adFJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzQCWsjCT+ptmX1s7mB2GgXLcFmBP5z5dGC+W2w1nwfxbxFrFP1
	ffH9C3BULyloucEWvlLmKQVCBKXd4yJPT0Sgdy7rr5c3/UKDXQ8eP1Ap4UaQZaZOr3U4e6yrd09
	RAchZXCw=
X-Gm-Gg: ASbGnctVo6+1mH2G7EKlIP8a7YXpfWIc23m0FIlzSN8ypdaXPpgp73u/rcGJXwdiE8h
	XBiJHIUjlZmpZ6WafxA8jCFM/7nybZYtmTPsUNfUHxYKlQg7qjmNnuZ6C6sEqZ2rGeGOv5ERBZ0
	YCO5vh6WgEgq4WCsizylupRmRsnuu33bIhMvkVMCpnb4UpQF9Rc0yo1o2CelkDlKQ9QJoz/hiEc
	p+GV1IwPONF3G5Byo3TjqcPI9SEPGqKYY9g9FFMBY5yYSBl8P9eewGqex067jBL6uZrmtS/Zn+F
	zI75SyqkQ6gBcwdaM2r69mOmPXnESTYkJ/9cC5Fe5dTCasEh63ORIK2lHIudf0BePl7zM0n4XdR
	jPMqHfUTVwgx3gTWZcyh5Dthz07Dd6QksgQ==
X-Google-Smtp-Source: AGHT+IEplsy1yBqk98ULEihHylHZFPji5KYkhaT3dZyGZKioHiXPVTYzfT9BTAjsq07UMcK9/XAK8A==
X-Received: by 2002:a05:690c:3510:b0:70e:29af:844a with SMTP id 00721157ae682-71163781971mr9357547b3.18.1749757852494;
        Thu, 12 Jun 2025 12:50:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:f1cc:a889:5913:28fa? ([2600:1700:6476:1430:f1cc:a889:5913:28fa])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-711520598ebsm3879677b3.22.2025.06.12.12.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 12:50:51 -0700 (PDT)
Message-ID: <670fd7d013c0309844530e88a9e5de15d91bcf59.camel@dubeyko.com>
Subject: Re: [PATCH v5] ceph: fix slab-use-after-free in
 have_mon_and_osd_map()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, amarkuze@redhat.com, 
	Slava.Dubeyko@ibm.com
Date: Thu, 12 Jun 2025 12:50:49 -0700
In-Reply-To: <CAOi1vP_+0f-RjBrCHNGpuNtYqfcg6A+CKPGGf-Nb_dLC4phVUg@mail.gmail.com>
References: <20250414221013.157819-1-slava@dubeyko.com>
	 <CAOi1vP8QreVDgY363c5b1Ke35N7tmRArcLfqQcwQiwJ-ULeWxg@mail.gmail.com>
	 <f6ef96ecfb43cdb695eb9292388434329ad3bc91.camel@dubeyko.com>
	 <CAOi1vP_+0f-RjBrCHNGpuNtYqfcg6A+CKPGGf-Nb_dLC4phVUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 10:20 +0200, Ilya Dryomov wrote:
> On Thu, Jun 12, 2025 at 1:14=E2=80=AFAM Viacheslav Dubeyko
> <slava@dubeyko.com> wrote:
> >=20
> > On Wed, 2025-06-11 at 13:22 +0200, Ilya Dryomov wrote:
> > > On Tue, Apr 15, 2025 at 12:10=E2=80=AFAM Viacheslav Dubeyko
> > > <slava@dubeyko.com> wrote:
> > > >=20
> > > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > >=20
> > > > The generic/395 and generic/397 is capable of generating
> > > > the oops is on line net/ceph/ceph_common.c:794 with
> > > > KASAN enabled.
> > > >=20
> > > > BUG: KASAN: slab-use-after-free in
> > > > have_mon_and_osd_map+0x56/0x70
> > > > Read of size 4 at addr ffff88811012d810 by task
> > > > mount.ceph/13305
> > > >=20
> > > > CPU: 2 UID: 0 PID: 13305 Comm: mount.ceph Not tainted 6.14.0-
> > > > rc2-
> > > > build2+ #1266
> > > > Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
> > > > Call Trace:
> > > > <TASK>
> > > > dump_stack_lvl+0x57/0x80
> > > > ? have_mon_and_osd_map+0x56/0x70
> > > > print_address_description.constprop.0+0x84/0x330
> > > > ? have_mon_and_osd_map+0x56/0x70
> > > > print_report+0xe2/0x1e0
> > > > ? rcu_read_unlock_sched+0x60/0x80
> > > > ? kmem_cache_debug_flags+0xc/0x20
> > > > ? fixup_red_left+0x17/0x30
> > > > ? have_mon_and_osd_map+0x56/0x70
> > > > kasan_report+0x8d/0xc0
> > > > ? have_mon_and_osd_map+0x56/0x70
> > > > have_mon_and_osd_map+0x56/0x70
> > > > ceph_open_session+0x182/0x290
> > > > ? __pfx_ceph_open_session+0x10/0x10
> > > > ? __init_swait_queue_head+0x8d/0xa0
> > > > ? __pfx_autoremove_wake_function+0x10/0x10
> > > > ? shrinker_register+0xdd/0xf0
> > > > ceph_get_tree+0x333/0x680
> > > > vfs_get_tree+0x49/0x180
> > > > do_new_mount+0x1a3/0x2d0
> > > > ? __pfx_do_new_mount+0x10/0x10
> > > > ? security_capable+0x39/0x70
> > > > path_mount+0x6dd/0x730
> > > > ? __pfx_path_mount+0x10/0x10
> > > > ? kmem_cache_free+0x1e5/0x270
> > > > ? user_path_at+0x48/0x60
> > > > do_mount+0x99/0xe0
> > > > ? __pfx_do_mount+0x10/0x10
> > > > ? lock_release+0x155/0x190
> > > > __do_sys_mount+0x141/0x180
> > > > do_syscall_64+0x9f/0x100
> > > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > RIP: 0033:0x7f01b1b14f3e
> > > > Code: 48 8b 0d d5 3e 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
> > > > 0f
> > > > 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f
> > > > 05
> > > > <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a2 3e 0f 00 f7 d8 64 89
> > > > 01 48
> > > > RSP: 002b:00007fffd129fa08 EFLAGS: 00000246 ORIG_RAX:
> > > > 00000000000000a5
> > > > RAX: ffffffffffffffda RBX: 0000564ec01a7850 RCX:
> > > > 00007f01b1b14f3e
> > > > RDX: 0000564ec00f2225 RSI: 00007fffd12a1964 RDI:
> > > > 0000564ec0147a20
> > > > RBP: 00007fffd129fbd0 R08: 0000564ec014da90 R09:
> > > > 0000000000000080
> > > > R10: 0000000000000000 R11: 0000000000000246 R12:
> > > > 00007fffd12a194e
> > > > R13: 0000000000000000 R14: 00007fffd129fa50 R15:
> > > > 00007fffd129fa40
> > > > </TASK>
> > > >=20
> > > > Allocated by task 13305:
> > > > stack_trace_save+0x8c/0xc0
> > > > kasan_save_stack+0x1e/0x40
> > > > kasan_save_track+0x10/0x30
> > > > __kasan_kmalloc+0x3a/0x50
> > > > __kmalloc_noprof+0x247/0x290
> > > > ceph_osdmap_alloc+0x16/0x130
> > > > ceph_osdc_init+0x27a/0x4c0
> > > > ceph_create_client+0x153/0x190
> > > > create_fs_client+0x50/0x2a0
> > > > ceph_get_tree+0xff/0x680
> > > > vfs_get_tree+0x49/0x180
> > > > do_new_mount+0x1a3/0x2d0
> > > > path_mount+0x6dd/0x730
> > > > do_mount+0x99/0xe0
> > > > __do_sys_mount+0x141/0x180
> > > > do_syscall_64+0x9f/0x100
> > > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > >=20
> > > > Freed by task 9475:
> > > > stack_trace_save+0x8c/0xc0
> > > > kasan_save_stack+0x1e/0x40
> > > > kasan_save_track+0x10/0x30
> > > > kasan_save_free_info+0x3b/0x50
> > > > __kasan_slab_free+0x18/0x30
> > > > kfree+0x212/0x290
> > > > handle_one_map+0x23c/0x3b0
> > > > ceph_osdc_handle_map+0x3c9/0x590
> > > > mon_dispatch+0x655/0x6f0
> > > > ceph_con_process_message+0xc3/0xe0
> > > > ceph_con_v1_try_read+0x614/0x760
> > > > ceph_con_workfn+0x2de/0x650
> > > > process_one_work+0x486/0x7c0
> > > > process_scheduled_works+0x73/0x90
> > > > worker_thread+0x1c8/0x2a0
> > > > kthread+0x2ec/0x300
> > > > ret_from_fork+0x24/0x40
> > > > ret_from_fork_asm+0x1a/0x30
> > > >=20
> > > > The buggy address belongs to the object at ffff88811012d800
> > > > which belongs to the cache kmalloc-512 of size 512
> > > > The buggy address is located 16 bytes inside of
> > > > freed 512-byte region [ffff88811012d800, ffff88811012da00)
> > > >=20
> > > > The buggy address belongs to the physical page:
> > > > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
> > > > pfn:0x11012c
> > > > head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0
> > > > pincount:0
> > > > flags: 0x200000000000040(head|node=3D0|zone=3D2)
> > > > page_type: f5(slab)
> > > > raw: 0200000000000040 ffff888100042c80 dead000000000100
> > > > dead000000000122
> > > > raw: 0000000000000000 0000000080100010 00000000f5000000
> > > > 0000000000000000
> > > > head: 0200000000000040 ffff888100042c80 dead000000000100
> > > > dead000000000122
> > > > head: 0000000000000000 0000000080100010 00000000f5000000
> > > > 0000000000000000
> > > > head: 0200000000000002 ffffea0004404b01 ffffffffffffffff
> > > > 0000000000000000
> > > > head: 0000000000000004 0000000000000000 00000000ffffffff
> > > > 0000000000000000
> > > > page dumped because: kasan: bad access detected
> > > >=20
> > > > Memory state around the buggy address:
> > > > ffff88811012d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > fc
> > > > ffff88811012d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > fc
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 ffff88811012d800: fa fb fb fb fb fb fb fb fb fb =
fb fb fb fb
> > > > fb
> > > > fb
> > > >=20
> > > > ^
> > > > ffff88811012d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > fb
> > > > ffff88811012d900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > fb
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > =3D=3D=3D
> > > > Disabling lock debugging due to kernel taint
> > > > libceph: client274326 fsid 8598140e-35c2-11ee-b97c-001517c545cc
> > > > libceph: mon0 (1)90.155.74.19:6789 session established
> > > > libceph: client274327 fsid 8598140e-35c2-11ee-b97c-001517c545cc
> > > >=20
> > > > We have such scenario:
> > > >=20
> > > > Thread 1:
> > > > void ceph_osdmap_destroy(...) {
> > > > =C2=A0=C2=A0=C2=A0 <skipped>
> > > > =C2=A0=C2=A0=C2=A0 kfree(map);
> > > > }
> > > > Thread 1 sleep...
> > > >=20
> > > > Thread 2:
> > > > static bool have_mon_and_osd_map(struct ceph_client *client) {
> > > > =C2=A0=C2=A0=C2=A0 return client->monc.monmap && client->monc.monma=
p->epoch &&
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client->osdc.osdmap && c=
lient->osdc.osdmap->epoch;
> > > > }
> > > > Thread 2 has oops...
> > > >=20
> > > > Thread 1 wake up:
> > > > static int handle_one_map(...) {
> > > > =C2=A0=C2=A0=C2=A0 <skipped>
> > > > =C2=A0=C2=A0=C2=A0 osdc->osdmap =3D newmap;
> > > > =C2=A0=C2=A0=C2=A0 <skipped>
> > > > }
> > > >=20
> > > > This patch introduces a have_mon_and_osd_map atomic_t
> > > > field in struct ceph_client. If there is no OSD and
> > > > monitor maps, then the client->have_mon_and_osd_map
> > > > is equal to zero. The OSD and monitor maps initialization
> > > > results in incrementing of client->have_mon_and_osd_map
> > > > under the lock. As a result, have_mon_and_osd_map() function
> > > > simply checks now that client->have_mon_and_osd_map is equal to
> > > > CEPH_CLIENT_HAS_MON_AND_OSD_MAP.
> > > >=20
> > > > Patch adds locking in the ceph_osdc_stop()
> > > > method during the destructruction of osdc->osdmap and
> > > > assigning of NULL to the pointer. The lock is used
> > > > in the ceph_monc_stop() during the freeing of monc->monmap
> > > > and assigning NULL to the pointer too. The monmap_show()
> > > > and osdmap_show() methods were reworked to prevent
> > > > the potential race condition during the methods call.
> > > >=20
> > > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > ---
> > > > =C2=A0include/linux/ceph/libceph.h | 20 ++++++++++++++++++++
> > > > =C2=A0net/ceph/ceph_common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 6 ++++--
> > > > =C2=A0net/ceph/debugfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 17 +++++++++++++----
> > > > =C2=A0net/ceph/mon_client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 18 +++++++++++++++++-
> > > > =C2=A0net/ceph/osd_client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 11 +++++++++++
> > > > =C2=A05 files changed, 65 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/include/linux/ceph/libceph.h
> > > > b/include/linux/ceph/libceph.h
> > > > index 733e7f93db66..f5694bf5bd54 100644
> > > > --- a/include/linux/ceph/libceph.h
> > > > +++ b/include/linux/ceph/libceph.h
> > > > @@ -132,6 +132,7 @@ struct ceph_client {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_messenger ms=
gr;=C2=A0=C2=A0 /* messenger instance */
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_mon_client m=
onc;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_osd_client o=
sdc;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_t have_mon_and_osd_map=
;
> > > >=20
> > > > =C2=A0#ifdef CONFIG_DEBUG_FS
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *debugfs_d=
ir;
> > > > @@ -141,6 +142,25 @@ struct ceph_client {
> > > > =C2=A0#endif
> > > > =C2=A0};
> > > >=20
> > > > +/*
> > > > + * The have_mon_and_osd_map possible states
> > > > + */
> > > > +enum {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CEPH_CLIENT_HAS_NO_MON_AND_NO=
_OSD_MAP =3D 0,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CEPH_CLIENT_HAS_ONLY_ONE_MAP =
=3D 1,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CEPH_CLIENT_HAS_MON_AND_OSD_M=
AP =3D 2,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CEPH_CLIENT_MAP_STATE_UNKNOWN
> > > > +};
> > > > +
> > > > +static inline
> > > > +bool is_mon_and_osd_map_state_invalid(struct ceph_client
> > > > *client)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int have_mon_and_osd_map =3D =
atomic_read(&client-
> > > > > have_mon_and_osd_map);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return have_mon_and_osd_map <
> > > > CEPH_CLIENT_HAS_NO_MON_AND_NO_OSD_MAP ||
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 have_mon_and_osd_map >=3D
> > > > CEPH_CLIENT_MAP_STATE_UNKNOWN;
> > > > +}
> > > > +
> > > > =C2=A0#define from_msgr(ms)=C2=A0 container_of(ms, struct ceph_clie=
nt,
> > > > msgr)
> > > >=20
> > > > =C2=A0static inline bool ceph_msgr2(struct ceph_client *client)
> > > > diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> > > > index 4c6441536d55..62efceb3b19d 100644
> > > > --- a/net/ceph/ceph_common.c
> > > > +++ b/net/ceph/ceph_common.c
> > > > @@ -723,6 +723,8 @@ struct ceph_client
> > > > *ceph_create_client(struct
> > > > ceph_options *opt, void *private)
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_init(&client->moun=
t_mutex);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init_waitqueue_head(&cli=
ent->auth_wq);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&client->have_mon_=
and_osd_map,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CEPH_CLIENT_HAS_NO_MON_AND_NO_OSD_MAP)=
;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client->auth_err =3D 0;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client->extra_mon_dispat=
ch =3D NULL;
> > > > @@ -790,8 +792,8 @@ EXPORT_SYMBOL(ceph_reset_client_addr);
> > > > =C2=A0 */
> > > > =C2=A0static bool have_mon_and_osd_map(struct ceph_client *client)
> > > > =C2=A0{
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return client->monc.monmap &&=
 client->monc.monmap-
> > > > >epoch &&
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 client->osdc.osdmap && client->osdc.osdmap-
> > > > >epoch;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return atomic_read(&client->h=
ave_mon_and_osd_map) =3D=3D
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > CEPH_CLIENT_HAS_MON_AND_OSD_MAP;
> > > > =C2=A0}
> > > >=20
> > > > =C2=A0/*
> > > > diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> > > > index 2110439f8a24..7b45c169a859 100644
> > > > --- a/net/ceph/debugfs.c
> > > > +++ b/net/ceph/debugfs.c
> > > > @@ -36,8 +36,10 @@ static int monmap_show(struct seq_file *s,
> > > > void
> > > > *p)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_client *clie=
nt =3D s->private;
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&client->monc.mute=
x);
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (client->monc.monmap =
=3D=3D NULL)
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto out_unlock;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(s, "epoch %d\=
n", client->monc.monmap-
> > > > >epoch);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < client=
->monc.monmap->num_mon; i++) {
> > > > @@ -48,6 +50,10 @@ static int monmap_show(struct seq_file *s,
> > > > void
> > > > *p)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ENTITY_NAME(inst->name),
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ceph_pr_addr(&inst->addr));
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > +
> > > > +out_unlock:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&client->monc.mu=
tex);
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > =C2=A0}
> > > >=20
> > > > @@ -56,13 +62,15 @@ static int osdmap_show(struct seq_file *s,
> > > > void
> > > > *p)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_client *clie=
nt =3D s->private;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_osd_client *=
osdc =3D &client->osdc;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_osdmap *map =3D o=
sdc->osdmap;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_osdmap *map =3D N=
ULL;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rb_node *n;
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 down_read(&osdc->lock);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map =3D osdc->osdmap;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (map =3D=3D NULL)
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto out_unlock;
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 down_read(&osdc->lock);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(s, "epoch %u =
barrier %u flags 0x%x\n", map-
> > > > > epoch,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os=
dc->epoch_barrier, map->flags);
> > > >=20
> > > > @@ -131,6 +139,7 @@ static int osdmap_show(struct seq_file *s,
> > > > void
> > > > *p)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(s, "]\n");
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > +out_unlock:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 up_read(&osdc->lock);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > =C2=A0}
> > > > diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> > > > index ab66b599ac47..5cf802236426 100644
> > > > --- a/net/ceph/mon_client.c
> > > > +++ b/net/ceph/mon_client.c
> > > > @@ -562,12 +562,16 @@ static void ceph_monc_handle_map(struct
> > > > ceph_mon_client *monc,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_dec(&client->have_mon_=
and_osd_map);
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(monc->monmap);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monc->monmap =3D monmap;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __ceph_monc_got_map(monc=
, CEPH_SUB_MONMAP, monc-
> > > > >monmap-
> > > > > epoch);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client->have_fsid =3D tr=
ue;
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_inc(&client->have_mon_=
and_osd_map);
> > > > +
> > > > =C2=A0out:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&monc->mute=
x);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wake_up_all(&client->aut=
h_wq);
> > > > @@ -1220,6 +1224,9 @@ int ceph_monc_init(struct ceph_mon_client
> > > > *monc, struct ceph_client *cl)
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monc->fs_cluster_id =3D =
CEPH_FS_CLUSTER_ID_NONE;
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_inc(&monc->client->hav=
e_mon_and_osd_map);
> > >=20
> > > Hi Slava,
> > >=20
> > > Incrementing client->have_mon_and_osd_map here and in
> > > ceph_osdc_init()
> > > means that counter would be set to 2
> > > (CEPH_CLIENT_HAS_MON_AND_OSD_MAP)
> > > at the initialization time, way before a session with the monitor
> > > is
> > > established and any map is received.=C2=A0 This effectively disables
> > > the
> > > wait logic in __ceph_open_session() because of
> > > have_mon_and_osd_map()
> > > immediately returning true.=C2=A0 __ceph_open_session() is responsibl=
e
> > > for
> > > setting up the debugfs directory and that is affected too: it's
> > > created
> > > as 00000000-0000-0000-0000-000000000000.client0 because neither
> > > the
> > > cluster FSID nor the client ID is known without the monmap.
> > >=20
> > > This patch seems to be over-complicated for what it needs to do:
> > > I don't see a compelling reason for introducing the atomic and as
> > > mentioned before there is no need to attempt to guard against
> > > someone
> > > continuing to use the client after ceph_osdc_stop() and
> > > ceph_monc_stop()
> > > are called.=C2=A0 It's the point of no return and the client itself
> > > gets
> > > freed very shortly after.
> > >=20
> > > Why not just open-code the wait loop in __ceph_open_session() to
> > > allow
> > > for monc->mutex and osdc->lock (for read) to be taken freely?=C2=A0 I=
t
> > > should
> > > be a small change in __ceph_open_session() --
> > > net/ceph/mon_client.c
> > > and
> > > net/ceph/osd_client.c wouldn't need to be touched at all.
> > >=20
> >=20
> > Hi Ilya,
> >=20
> > Frankly speaking, I don't quite follow to your point. The main
> > issue
> > happens when one thread calls ceph_osdc_handle_map() [1] ->
> > handle_one_map() [2]:
> >=20
> > ceph_osdmap_destroy() [3] -> kfree(map) -> go to sleep
> >=20
> > <-- another thread receives time slices to execute:
> > have_mon_and_osd_map() BUT osdc->osdmap is already freed and
> > invalid
> > here!!!
> >=20
> > osdc->osdmap =3D newmap;
> >=20
> > So, it's not about ceph_osdc_stop() or ceph_monc_stop() but it's
> > about
> > regular operations.
>=20
> I know, but on top of the regular operations (to be precise, one
> regular operation -- __ceph_open_session()) the current patch also
> tries to harden ceph_osdc_stop() and ceph_monc_stop().=C2=A0 I wanted to
> reiterate that it's not needed.
>=20
> >=20
> > I've tried to exclude the necessity to use locks at all in
> > have_mon_and_osd_map(). Do you mean that wait loop will be better
> > solution?
>=20
> Yes, it seems preferable over an otherwise redundant (i.e. not used
> for
> anything else) atomic which turned out to be tricky enough to get
> right
> on the first try.
>=20
> > It sounds pretty complicated too for my taste and it will
> > require coordination among threads. No? I am not completely sure
> > that I
> > follow to your vision.
>=20
> With the help of woken_wake_function() primitive it shouldn't be
> complicated at all.=C2=A0 The diff would be limited to
> __ceph_open_session()
> and I would expect it to be on par with the current patch.=C2=A0 Making i=
t
> possible to freely take locks there would also squash another related
> buglet: client->auth_err shouldn't be accessed outside of monc->mutex
> either.=C2=A0 Being just an int, it's not complained about by KASAN ;)
>=20
> Since __ceph_open_session() is the only user of
> have_mon_and_osd_map()
> it could be open-coded inside of the wait loop.
>=20

OK. Let me try to rework my patch yet another time. :)

Thanks,
Slava.

