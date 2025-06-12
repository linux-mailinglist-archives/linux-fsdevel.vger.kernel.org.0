Return-Path: <linux-fsdevel+bounces-51421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2970AD6A61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 10:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8C83A9D6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 08:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4761C223DD7;
	Thu, 12 Jun 2025 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzPQn1v9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC415573F;
	Thu, 12 Jun 2025 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716449; cv=none; b=g6iH/SecVbKjFnH6h9BIUHwSjO8AXzAfNS91MGERHvoCDV+TyjvkCtSW2sTWK2mIu+vgELi5xKl3tcPyOCsTTYU4ggYzKwq6UmZAvIt4l4BQprmUq+e2qJX2dMe8+reaDW19ud3/A5q9Twj/28rvNs7jD3C+kSYCpGRIf5u0h6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716449; c=relaxed/simple;
	bh=pzQzwpTPN+3WCtbDt6kOi9TvOrz6kEwMy5KYFbbL4Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4kPz0htqD/+hUur9oqqgZyEZzFTwqoBFuLiSk9EeDW9QzRKOsEiZU93gLVIV87U9t3wdlTF0nQnIN4lhtP85ju+3oSoX3ylqisVyqKwjdnR6vgGOCeKUIJjWunL2hINyhsEMfNLxKBpJwed1Tvga7jK2kBaC0lebQ/eIE2+y/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzPQn1v9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2352400344aso6408305ad.2;
        Thu, 12 Jun 2025 01:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749716447; x=1750321247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCgg6Qd2qthOaAUgwzpTVx0r++QO4kkOcF4l09i7VsQ=;
        b=TzPQn1v9OSj80bHdiFFNT2+ZSfU7IRV5chFULR+qd5CaXWlzAjg5mgJex3eU7LY3bU
         +ij9DtvlkHDWn7MOcZRhxA0zfm46Ldo+gsPf4KhAFWTafPXzTJ2E3LLDXnY28OEW8CCD
         conjNatsCoZB+xulj6RkaxaR36FFWlcZcpgzZD1iU5TuWFgoHmflrn64SJTzeVh4RWZG
         AUYMAoHFmZAdHMMWDghaQgV19A+Oa+RKgKaBTh4AIbvVwrsYZQUcDa1ZgVFvQX64nu/f
         Ejd2VZ3EkDQOe9rmpv36WwPFH566b30pkOmJF2DrOtGgbZ8DuUvCpfUDSgPQ2m9WXHJ5
         GSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749716447; x=1750321247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCgg6Qd2qthOaAUgwzpTVx0r++QO4kkOcF4l09i7VsQ=;
        b=S7XL3xiu00U+BpWXfkCekacWLOb2yUpEsHdJ58TQBPDI1J3zeg09QehMqFV0EDCzsh
         v7P5gp78yFWFXsPYpEZXcAeqI4G9fBb9V1xM2+QrygnVSLfjywS1fp9l2aHzqAb5ClNG
         N1hbiMqDhez88596X4+bAx4d/X4lyAEDVIBZt8a0C7Uy85JsmF9pqV8vHPsEpf3nd1nO
         f5bIE7DjmQkmVXI4UbnqwmwcICQnYb1tLYWVf6BfWkvoFdqpKh7Cq+JPr5zZOYM8MCms
         VMH1JEQscNaSHwIHHUh6xxkKDuZ1/sXHs4lm8wDG1eOZ4BVP96hhgdr4tKxGypvY6OLI
         cO/A==
X-Forwarded-Encrypted: i=1; AJvYcCULqQ4eGqjyzws5Q8MHb6CsYR68diR7DHsn0cN/rZQ8m0X/IfxgF7q8QulVMnilGCXO4Rb5JXBeQ2/hgsb1@vger.kernel.org
X-Gm-Message-State: AOJu0YzSXX7ke5h7BNurcA0FviRCXdpXkghP9/SdNby+R8AYujHTAXb9
	pzJosmi9HvkOa2TcmigWazNzwIU9gLcUyjYJG5jN0fcd+gEnxW8oXzlh7FRsFODvimJKP6sWgbB
	UWNGtUOoISBjgJDHqhIFjFV+IFMRHGTCJFDRf
X-Gm-Gg: ASbGnctTFyLIP5vkvIRO0I5krvqKzdymACE7jzwMEPdivUVLkUFrmoBcuK8/39oSUN7
	mEqLNfyaMyc7s9P//kd1nCN/4GnBEXP/1Vv+yLI7jjmMKKKjPgWSr/Evr+CFgOJW2Yi1AVixjFC
	qEuGejLAt9iHSIJede3wLAyDt/YRw0/ajEH3+Dgzuj80A=
X-Google-Smtp-Source: AGHT+IGE23HifexDNFTFQXq2/k+p4IZLYQNGPOEsuHLgaW3zXaVsDT/sJ5YwOpV8bSSAOqm0uF2qB1cIp2tLVBgbuGE=
X-Received: by 2002:a17:902:cf08:b0:234:c8f6:1afb with SMTP id
 d9443c01a7336-236419cbd50mr107561305ad.0.1749716446601; Thu, 12 Jun 2025
 01:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414221013.157819-1-slava@dubeyko.com> <CAOi1vP8QreVDgY363c5b1Ke35N7tmRArcLfqQcwQiwJ-ULeWxg@mail.gmail.com>
 <f6ef96ecfb43cdb695eb9292388434329ad3bc91.camel@dubeyko.com>
In-Reply-To: <f6ef96ecfb43cdb695eb9292388434329ad3bc91.camel@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 12 Jun 2025 10:20:34 +0200
X-Gm-Features: AX0GCFsfqP6T2Hj2W4jZ1ULh7wS0HG-MAR1RVkynHN_04giZ3aRd7SncYsfpOkU
Message-ID: <CAOi1vP_+0f-RjBrCHNGpuNtYqfcg6A+CKPGGf-Nb_dLC4phVUg@mail.gmail.com>
Subject: Re: [PATCH v5] ceph: fix slab-use-after-free in have_mon_and_osd_map()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, amarkuze@redhat.com, 
	Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 1:14=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> On Wed, 2025-06-11 at 13:22 +0200, Ilya Dryomov wrote:
> > On Tue, Apr 15, 2025 at 12:10=E2=80=AFAM Viacheslav Dubeyko
> > <slava@dubeyko.com> wrote:
> > >
> > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > >
> > > The generic/395 and generic/397 is capable of generating
> > > the oops is on line net/ceph/ceph_common.c:794 with
> > > KASAN enabled.
> > >
> > > BUG: KASAN: slab-use-after-free in have_mon_and_osd_map+0x56/0x70
> > > Read of size 4 at addr ffff88811012d810 by task mount.ceph/13305
> > >
> > > CPU: 2 UID: 0 PID: 13305 Comm: mount.ceph Not tainted 6.14.0-rc2-
> > > build2+ #1266
> > > Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
> > > Call Trace:
> > > <TASK>
> > > dump_stack_lvl+0x57/0x80
> > > ? have_mon_and_osd_map+0x56/0x70
> > > print_address_description.constprop.0+0x84/0x330
> > > ? have_mon_and_osd_map+0x56/0x70
> > > print_report+0xe2/0x1e0
> > > ? rcu_read_unlock_sched+0x60/0x80
> > > ? kmem_cache_debug_flags+0xc/0x20
> > > ? fixup_red_left+0x17/0x30
> > > ? have_mon_and_osd_map+0x56/0x70
> > > kasan_report+0x8d/0xc0
> > > ? have_mon_and_osd_map+0x56/0x70
> > > have_mon_and_osd_map+0x56/0x70
> > > ceph_open_session+0x182/0x290
> > > ? __pfx_ceph_open_session+0x10/0x10
> > > ? __init_swait_queue_head+0x8d/0xa0
> > > ? __pfx_autoremove_wake_function+0x10/0x10
> > > ? shrinker_register+0xdd/0xf0
> > > ceph_get_tree+0x333/0x680
> > > vfs_get_tree+0x49/0x180
> > > do_new_mount+0x1a3/0x2d0
> > > ? __pfx_do_new_mount+0x10/0x10
> > > ? security_capable+0x39/0x70
> > > path_mount+0x6dd/0x730
> > > ? __pfx_path_mount+0x10/0x10
> > > ? kmem_cache_free+0x1e5/0x270
> > > ? user_path_at+0x48/0x60
> > > do_mount+0x99/0xe0
> > > ? __pfx_do_mount+0x10/0x10
> > > ? lock_release+0x155/0x190
> > > __do_sys_mount+0x141/0x180
> > > do_syscall_64+0x9f/0x100
> > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > RIP: 0033:0x7f01b1b14f3e
> > > Code: 48 8b 0d d5 3e 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f
> > > 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05
> > > <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a2 3e 0f 00 f7 d8 64 89 01 48
> > > RSP: 002b:00007fffd129fa08 EFLAGS: 00000246 ORIG_RAX:
> > > 00000000000000a5
> > > RAX: ffffffffffffffda RBX: 0000564ec01a7850 RCX: 00007f01b1b14f3e
> > > RDX: 0000564ec00f2225 RSI: 00007fffd12a1964 RDI: 0000564ec0147a20
> > > RBP: 00007fffd129fbd0 R08: 0000564ec014da90 R09: 0000000000000080
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffd12a194e
> > > R13: 0000000000000000 R14: 00007fffd129fa50 R15: 00007fffd129fa40
> > > </TASK>
> > >
> > > Allocated by task 13305:
> > > stack_trace_save+0x8c/0xc0
> > > kasan_save_stack+0x1e/0x40
> > > kasan_save_track+0x10/0x30
> > > __kasan_kmalloc+0x3a/0x50
> > > __kmalloc_noprof+0x247/0x290
> > > ceph_osdmap_alloc+0x16/0x130
> > > ceph_osdc_init+0x27a/0x4c0
> > > ceph_create_client+0x153/0x190
> > > create_fs_client+0x50/0x2a0
> > > ceph_get_tree+0xff/0x680
> > > vfs_get_tree+0x49/0x180
> > > do_new_mount+0x1a3/0x2d0
> > > path_mount+0x6dd/0x730
> > > do_mount+0x99/0xe0
> > > __do_sys_mount+0x141/0x180
> > > do_syscall_64+0x9f/0x100
> > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > > Freed by task 9475:
> > > stack_trace_save+0x8c/0xc0
> > > kasan_save_stack+0x1e/0x40
> > > kasan_save_track+0x10/0x30
> > > kasan_save_free_info+0x3b/0x50
> > > __kasan_slab_free+0x18/0x30
> > > kfree+0x212/0x290
> > > handle_one_map+0x23c/0x3b0
> > > ceph_osdc_handle_map+0x3c9/0x590
> > > mon_dispatch+0x655/0x6f0
> > > ceph_con_process_message+0xc3/0xe0
> > > ceph_con_v1_try_read+0x614/0x760
> > > ceph_con_workfn+0x2de/0x650
> > > process_one_work+0x486/0x7c0
> > > process_scheduled_works+0x73/0x90
> > > worker_thread+0x1c8/0x2a0
> > > kthread+0x2ec/0x300
> > > ret_from_fork+0x24/0x40
> > > ret_from_fork_asm+0x1a/0x30
> > >
> > > The buggy address belongs to the object at ffff88811012d800
> > > which belongs to the cache kmalloc-512 of size 512
> > > The buggy address is located 16 bytes inside of
> > > freed 512-byte region [ffff88811012d800, ffff88811012da00)
> > >
> > > The buggy address belongs to the physical page:
> > > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
> > > pfn:0x11012c
> > > head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0
> > > pincount:0
> > > flags: 0x200000000000040(head|node=3D0|zone=3D2)
> > > page_type: f5(slab)
> > > raw: 0200000000000040 ffff888100042c80 dead000000000100
> > > dead000000000122
> > > raw: 0000000000000000 0000000080100010 00000000f5000000
> > > 0000000000000000
> > > head: 0200000000000040 ffff888100042c80 dead000000000100
> > > dead000000000122
> > > head: 0000000000000000 0000000080100010 00000000f5000000
> > > 0000000000000000
> > > head: 0200000000000002 ffffea0004404b01 ffffffffffffffff
> > > 0000000000000000
> > > head: 0000000000000004 0000000000000000 00000000ffffffff
> > > 0000000000000000
> > > page dumped because: kasan: bad access detected
> > >
> > > Memory state around the buggy address:
> > > ffff88811012d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > ffff88811012d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > >
> > >     ffff88811012d800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > fb
> > >
> > > ^
> > > ffff88811012d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > ffff88811012d900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Disabling lock debugging due to kernel taint
> > > libceph: client274326 fsid 8598140e-35c2-11ee-b97c-001517c545cc
> > > libceph: mon0 (1)90.155.74.19:6789 session established
> > > libceph: client274327 fsid 8598140e-35c2-11ee-b97c-001517c545cc
> > >
> > > We have such scenario:
> > >
> > > Thread 1:
> > > void ceph_osdmap_destroy(...) {
> > >     <skipped>
> > >     kfree(map);
> > > }
> > > Thread 1 sleep...
> > >
> > > Thread 2:
> > > static bool have_mon_and_osd_map(struct ceph_client *client) {
> > >     return client->monc.monmap && client->monc.monmap->epoch &&
> > >         client->osdc.osdmap && client->osdc.osdmap->epoch;
> > > }
> > > Thread 2 has oops...
> > >
> > > Thread 1 wake up:
> > > static int handle_one_map(...) {
> > >     <skipped>
> > >     osdc->osdmap =3D newmap;
> > >     <skipped>
> > > }
> > >
> > > This patch introduces a have_mon_and_osd_map atomic_t
> > > field in struct ceph_client. If there is no OSD and
> > > monitor maps, then the client->have_mon_and_osd_map
> > > is equal to zero. The OSD and monitor maps initialization
> > > results in incrementing of client->have_mon_and_osd_map
> > > under the lock. As a result, have_mon_and_osd_map() function
> > > simply checks now that client->have_mon_and_osd_map is equal to
> > > CEPH_CLIENT_HAS_MON_AND_OSD_MAP.
> > >
> > > Patch adds locking in the ceph_osdc_stop()
> > > method during the destructruction of osdc->osdmap and
> > > assigning of NULL to the pointer. The lock is used
> > > in the ceph_monc_stop() during the freeing of monc->monmap
> > > and assigning NULL to the pointer too. The monmap_show()
> > > and osdmap_show() methods were reworked to prevent
> > > the potential race condition during the methods call.
> > >
> > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > ---
> > >  include/linux/ceph/libceph.h | 20 ++++++++++++++++++++
> > >  net/ceph/ceph_common.c       |  6 ++++--
> > >  net/ceph/debugfs.c           | 17 +++++++++++++----
> > >  net/ceph/mon_client.c        | 18 +++++++++++++++++-
> > >  net/ceph/osd_client.c        | 11 +++++++++++
> > >  5 files changed, 65 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/ceph/libceph.h
> > > b/include/linux/ceph/libceph.h
> > > index 733e7f93db66..f5694bf5bd54 100644
> > > --- a/include/linux/ceph/libceph.h
> > > +++ b/include/linux/ceph/libceph.h
> > > @@ -132,6 +132,7 @@ struct ceph_client {
> > >         struct ceph_messenger msgr;   /* messenger instance */
> > >         struct ceph_mon_client monc;
> > >         struct ceph_osd_client osdc;
> > > +       atomic_t have_mon_and_osd_map;
> > >
> > >  #ifdef CONFIG_DEBUG_FS
> > >         struct dentry *debugfs_dir;
> > > @@ -141,6 +142,25 @@ struct ceph_client {
> > >  #endif
> > >  };
> > >
> > > +/*
> > > + * The have_mon_and_osd_map possible states
> > > + */
> > > +enum {
> > > +       CEPH_CLIENT_HAS_NO_MON_AND_NO_OSD_MAP =3D 0,
> > > +       CEPH_CLIENT_HAS_ONLY_ONE_MAP =3D 1,
> > > +       CEPH_CLIENT_HAS_MON_AND_OSD_MAP =3D 2,
> > > +       CEPH_CLIENT_MAP_STATE_UNKNOWN
> > > +};
> > > +
> > > +static inline
> > > +bool is_mon_and_osd_map_state_invalid(struct ceph_client *client)
> > > +{
> > > +       int have_mon_and_osd_map =3D atomic_read(&client-
> > > >have_mon_and_osd_map);
> > > +
> > > +       return have_mon_and_osd_map <
> > > CEPH_CLIENT_HAS_NO_MON_AND_NO_OSD_MAP ||
> > > +               have_mon_and_osd_map >=3D
> > > CEPH_CLIENT_MAP_STATE_UNKNOWN;
> > > +}
> > > +
> > >  #define from_msgr(ms)  container_of(ms, struct ceph_client, msgr)
> > >
> > >  static inline bool ceph_msgr2(struct ceph_client *client)
> > > diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> > > index 4c6441536d55..62efceb3b19d 100644
> > > --- a/net/ceph/ceph_common.c
> > > +++ b/net/ceph/ceph_common.c
> > > @@ -723,6 +723,8 @@ struct ceph_client *ceph_create_client(struct
> > > ceph_options *opt, void *private)
> > >
> > >         mutex_init(&client->mount_mutex);
> > >         init_waitqueue_head(&client->auth_wq);
> > > +       atomic_set(&client->have_mon_and_osd_map,
> > > +                  CEPH_CLIENT_HAS_NO_MON_AND_NO_OSD_MAP);
> > >         client->auth_err =3D 0;
> > >
> > >         client->extra_mon_dispatch =3D NULL;
> > > @@ -790,8 +792,8 @@ EXPORT_SYMBOL(ceph_reset_client_addr);
> > >   */
> > >  static bool have_mon_and_osd_map(struct ceph_client *client)
> > >  {
> > > -       return client->monc.monmap && client->monc.monmap->epoch &&
> > > -              client->osdc.osdmap && client->osdc.osdmap->epoch;
> > > +       return atomic_read(&client->have_mon_and_osd_map) =3D=3D
> > > +                               CEPH_CLIENT_HAS_MON_AND_OSD_MAP;
> > >  }
> > >
> > >  /*
> > > diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> > > index 2110439f8a24..7b45c169a859 100644
> > > --- a/net/ceph/debugfs.c
> > > +++ b/net/ceph/debugfs.c
> > > @@ -36,8 +36,10 @@ static int monmap_show(struct seq_file *s, void
> > > *p)
> > >         int i;
> > >         struct ceph_client *client =3D s->private;
> > >
> > > +       mutex_lock(&client->monc.mutex);
> > > +
> > >         if (client->monc.monmap =3D=3D NULL)
> > > -               return 0;
> > > +               goto out_unlock;
> > >
> > >         seq_printf(s, "epoch %d\n", client->monc.monmap->epoch);
> > >         for (i =3D 0; i < client->monc.monmap->num_mon; i++) {
> > > @@ -48,6 +50,10 @@ static int monmap_show(struct seq_file *s, void
> > > *p)
> > >                            ENTITY_NAME(inst->name),
> > >                            ceph_pr_addr(&inst->addr));
> > >         }
> > > +
> > > +out_unlock:
> > > +       mutex_unlock(&client->monc.mutex);
> > > +
> > >         return 0;
> > >  }
> > >
> > > @@ -56,13 +62,15 @@ static int osdmap_show(struct seq_file *s, void
> > > *p)
> > >         int i;
> > >         struct ceph_client *client =3D s->private;
> > >         struct ceph_osd_client *osdc =3D &client->osdc;
> > > -       struct ceph_osdmap *map =3D osdc->osdmap;
> > > +       struct ceph_osdmap *map =3D NULL;
> > >         struct rb_node *n;
> > >
> > > +       down_read(&osdc->lock);
> > > +
> > > +       map =3D osdc->osdmap;
> > >         if (map =3D=3D NULL)
> > > -               return 0;
> > > +               goto out_unlock;
> > >
> > > -       down_read(&osdc->lock);
> > >         seq_printf(s, "epoch %u barrier %u flags 0x%x\n", map-
> > > >epoch,
> > >                         osdc->epoch_barrier, map->flags);
> > >
> > > @@ -131,6 +139,7 @@ static int osdmap_show(struct seq_file *s, void
> > > *p)
> > >                 seq_printf(s, "]\n");
> > >         }
> > >
> > > +out_unlock:
> > >         up_read(&osdc->lock);
> > >         return 0;
> > >  }
> > > diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> > > index ab66b599ac47..5cf802236426 100644
> > > --- a/net/ceph/mon_client.c
> > > +++ b/net/ceph/mon_client.c
> > > @@ -562,12 +562,16 @@ static void ceph_monc_handle_map(struct
> > > ceph_mon_client *monc,
> > >                 goto out;
> > >         }
> > >
> > > +       atomic_dec(&client->have_mon_and_osd_map);
> > > +
> > >         kfree(monc->monmap);
> > >         monc->monmap =3D monmap;
> > >
> > >         __ceph_monc_got_map(monc, CEPH_SUB_MONMAP, monc->monmap-
> > > >epoch);
> > >         client->have_fsid =3D true;
> > >
> > > +       atomic_inc(&client->have_mon_and_osd_map);
> > > +
> > >  out:
> > >         mutex_unlock(&monc->mutex);
> > >         wake_up_all(&client->auth_wq);
> > > @@ -1220,6 +1224,9 @@ int ceph_monc_init(struct ceph_mon_client
> > > *monc, struct ceph_client *cl)
> > >
> > >         monc->fs_cluster_id =3D CEPH_FS_CLUSTER_ID_NONE;
> > >
> > > +       atomic_inc(&monc->client->have_mon_and_osd_map);
> >
> > Hi Slava,
> >
> > Incrementing client->have_mon_and_osd_map here and in
> > ceph_osdc_init()
> > means that counter would be set to 2
> > (CEPH_CLIENT_HAS_MON_AND_OSD_MAP)
> > at the initialization time, way before a session with the monitor is
> > established and any map is received.  This effectively disables the
> > wait logic in __ceph_open_session() because of have_mon_and_osd_map()
> > immediately returning true.  __ceph_open_session() is responsible for
> > setting up the debugfs directory and that is affected too: it's
> > created
> > as 00000000-0000-0000-0000-000000000000.client0 because neither the
> > cluster FSID nor the client ID is known without the monmap.
> >
> > This patch seems to be over-complicated for what it needs to do:
> > I don't see a compelling reason for introducing the atomic and as
> > mentioned before there is no need to attempt to guard against someone
> > continuing to use the client after ceph_osdc_stop() and
> > ceph_monc_stop()
> > are called.  It's the point of no return and the client itself gets
> > freed very shortly after.
> >
> > Why not just open-code the wait loop in __ceph_open_session() to
> > allow
> > for monc->mutex and osdc->lock (for read) to be taken freely?  It
> > should
> > be a small change in __ceph_open_session() -- net/ceph/mon_client.c
> > and
> > net/ceph/osd_client.c wouldn't need to be touched at all.
> >
>
> Hi Ilya,
>
> Frankly speaking, I don't quite follow to your point. The main issue
> happens when one thread calls ceph_osdc_handle_map() [1] ->
> handle_one_map() [2]:
>
> ceph_osdmap_destroy() [3] -> kfree(map) -> go to sleep
>
> <-- another thread receives time slices to execute:
> have_mon_and_osd_map() BUT osdc->osdmap is already freed and invalid
> here!!!
>
> osdc->osdmap =3D newmap;
>
> So, it's not about ceph_osdc_stop() or ceph_monc_stop() but it's about
> regular operations.

I know, but on top of the regular operations (to be precise, one
regular operation -- __ceph_open_session()) the current patch also
tries to harden ceph_osdc_stop() and ceph_monc_stop().  I wanted to
reiterate that it's not needed.

>
> I've tried to exclude the necessity to use locks at all in
> have_mon_and_osd_map(). Do you mean that wait loop will be better
> solution?

Yes, it seems preferable over an otherwise redundant (i.e. not used for
anything else) atomic which turned out to be tricky enough to get right
on the first try.

> It sounds pretty complicated too for my taste and it will
> require coordination among threads. No? I am not completely sure that I
> follow to your vision.

With the help of woken_wake_function() primitive it shouldn't be
complicated at all.  The diff would be limited to __ceph_open_session()
and I would expect it to be on par with the current patch.  Making it
possible to freely take locks there would also squash another related
buglet: client->auth_err shouldn't be accessed outside of monc->mutex
either.  Being just an int, it's not complained about by KASAN ;)

Since __ceph_open_session() is the only user of have_mon_and_osd_map()
it could be open-coded inside of the wait loop.

Thanks,

                Ilya

