Return-Path: <linux-fsdevel+bounces-45994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE37A80FEE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722EF424D42
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4076722B8B3;
	Tue,  8 Apr 2025 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6C7hk8L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAD722ACE3;
	Tue,  8 Apr 2025 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125669; cv=none; b=tC0SS5HzHQg1/qws2nIXDNz2GqOdVbq3EWY3NG2J0JSnOh7yxmOD/Iy0HTSDBC/Kr6nybZ+wKCxDwadnpclJ5FUhgvQnV+ybIDuvUYpEbg5SkH88CuJ/DCF3vrsbYRUpv+0zGXDx7TZkC4rSUhM21YR2n14ITNxQ6YWoAuyWBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125669; c=relaxed/simple;
	bh=tlASbFsigJX3SSXNOR5BwZ6wBMU9hlwNoPLD0u+SAzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oF3PROHwPBYjal8gjrtxg7UKPshsP+V2sIpvvUIBs1dIf3Vn9BG5mOpHbNHv8ldWkMp9KgWA4vtIUp+au1+Qb5MdTUUGBSQtHsgpTcqasa26DlEoVd3VzvZaSUgxwTHudntavRuLJ6rLA9xuMmu85a3uRf7suBYEzwjOCyvJi/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6C7hk8L; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso4021499a91.1;
        Tue, 08 Apr 2025 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744125667; x=1744730467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyM5QAkblowIQiFcHDeZQk/KXFh+UxVQpiVBK0Pf8CQ=;
        b=J6C7hk8Lp0V4W530EXrjSxT5NSm2BR9m0eo932g/k8qRaUDS/mOCHKE6g+TsEN3WXV
         CwyV6vwrhspj44vo+QRFA2sqSmk3zeVRP6XdTUNIBZ7OCqdb812jMREqmplkSwLojJnV
         DAiycGzES8JX8Q8HnZoy4k5awilZtz1dKwfBqDGU86Hb5PQaS+JF3ZQAxS2LXkpRCToo
         qjQjHpkDI5jHkj4FfSarB8JU4gZAZE3jsr02BGAURw6YzTJCep0oDH0YUiNyBnNHonDu
         mNj4rzx2MFQWnXsMp+Qrb9cm3CiN9YtjzGmxu+FAaKM4KN1yTFTFVjKXLQMVNlBVQjCX
         q12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744125667; x=1744730467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyM5QAkblowIQiFcHDeZQk/KXFh+UxVQpiVBK0Pf8CQ=;
        b=PrVRBhI14vsV/rfr6ZlwkDGlPWSnlj5vgaBdVdQLhfAms4TFKiFrQjfRP0zwWRGXHk
         Q9F9UDiV1bBCZvsbKRKVROyE42kromJXk018pP1f/9FmraFif7qjTOp/tvaYNMobXsPS
         YiKhCBHBt9Wfp0haARukpboXq3wMk4ntkdSkP8Nlu7u8eCBGKwGcQhAl0bx2pFEEvUxi
         d1lF+L441IPJT4VwY37Izttol8sCUuoRGAuPSZFwKUbbvSC9XV8wtqHes03KJMyal02R
         AY/RRVK+Fqapm2LYuJxFqGoOI9Q6rnhyDpjzMvlnkKDtcllKFOb/dD2A4T5sbiH1OdvI
         XSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZNYl0o9qcQOHxsJ7ISCPv/U3oG2ZGlrrTQ28VTZthoWtzBLTPtYk0lcrawxUigOIQh9sz5x0jDHsXLTFB@vger.kernel.org
X-Gm-Message-State: AOJu0YwVRgP3dTEitjb0FQ4s2XrhmPeJLIbVfQXLRc1pF5hyJjA00IJ2
	O65EwZ/jTUe6qXDBdJ0Z4hWF0yE8v/2FRxee7EdddmRGcKbJemiNvzVcyKlxgz2p5qB3KJYsPTz
	NEDfgRW33EVVkoUO5Y99B3D/wSs4=
X-Gm-Gg: ASbGncsQxpO+VjTA/7ssE1tJHqBz4bi4jEBoOu+OAOS+SwGMCPoU/382D51EsZ5VLuE
	i4plHX6vPcnHHlHC7ZPf/N496GXEdva5ui6WHPJdP8pzPHJdFiD9G1MdCSnbTyoo5qEQVd2q+K6
	q88z5mHH71m3Ffl3WFCK83AtAgxw==
X-Google-Smtp-Source: AGHT+IFQXUIp2gr0kTVRugpWYUZRGkMW/vPlZXC2oJneTy/OvnPV7+1fEK78WZjYFPPoxY15nDZi2ZDqGYYOlngkGbk=
X-Received: by 2002:a17:90b:5490:b0:2ff:62b7:dcc0 with SMTP id
 98e67ed59e1d1-306a615b74dmr23025985a91.15.1744125666775; Tue, 08 Apr 2025
 08:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305194437.59309-1-slava@dubeyko.com>
In-Reply-To: <20250305194437.59309-1-slava@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 8 Apr 2025 17:20:54 +0200
X-Gm-Features: ATxdqUGpFH2a3r_TvNkWPXpg08ymvx9r0VWR3gtLCDa6JKV2o0wnUBtNkr6WhFI
Message-ID: <CAOi1vP_=TAq_2iECmp9hn9fV2JF5=1CzM_U+kdax4atx6A6wEA@mail.gmail.com>
Subject: Re: [PATCH v4] ceph: fix slab-use-after-free in have_mon_and_osd_map()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, dhowells@redhat.com, amarkuze@redhat.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 8:44=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.co=
m> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The generic/395 and generic/397 is capable of generating
> the oops is on line net/ceph/ceph_common.c:794 with
> KASAN enabled.
>
> BUG: KASAN: slab-use-after-free in have_mon_and_osd_map+0x56/0x70
> Read of size 4 at addr ffff88811012d810 by task mount.ceph/13305
>
> CPU: 2 UID: 0 PID: 13305 Comm: mount.ceph Not tainted 6.14.0-rc2-build2+ =
#1266
> Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
> Call Trace:
> <TASK>
> dump_stack_lvl+0x57/0x80
> ? have_mon_and_osd_map+0x56/0x70
> print_address_description.constprop.0+0x84/0x330
> ? have_mon_and_osd_map+0x56/0x70
> print_report+0xe2/0x1e0
> ? rcu_read_unlock_sched+0x60/0x80
> ? kmem_cache_debug_flags+0xc/0x20
> ? fixup_red_left+0x17/0x30
> ? have_mon_and_osd_map+0x56/0x70
> kasan_report+0x8d/0xc0
> ? have_mon_and_osd_map+0x56/0x70
> have_mon_and_osd_map+0x56/0x70
> ceph_open_session+0x182/0x290
> ? __pfx_ceph_open_session+0x10/0x10
> ? __init_swait_queue_head+0x8d/0xa0
> ? __pfx_autoremove_wake_function+0x10/0x10
> ? shrinker_register+0xdd/0xf0
> ceph_get_tree+0x333/0x680
> vfs_get_tree+0x49/0x180
> do_new_mount+0x1a3/0x2d0
> ? __pfx_do_new_mount+0x10/0x10
> ? security_capable+0x39/0x70
> path_mount+0x6dd/0x730
> ? __pfx_path_mount+0x10/0x10
> ? kmem_cache_free+0x1e5/0x270
> ? user_path_at+0x48/0x60
> do_mount+0x99/0xe0
> ? __pfx_do_mount+0x10/0x10
> ? lock_release+0x155/0x190
> __do_sys_mount+0x141/0x180
> do_syscall_64+0x9f/0x100
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f01b1b14f3e
> Code: 48 8b 0d d5 3e 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 0=
0 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 8b 0d a2 3e 0f 00 f7 d8 64 89 01 48
> RSP: 002b:00007fffd129fa08 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000564ec01a7850 RCX: 00007f01b1b14f3e
> RDX: 0000564ec00f2225 RSI: 00007fffd12a1964 RDI: 0000564ec0147a20
> RBP: 00007fffd129fbd0 R08: 0000564ec014da90 R09: 0000000000000080
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffd12a194e
> R13: 0000000000000000 R14: 00007fffd129fa50 R15: 00007fffd129fa40
> </TASK>
>
> Allocated by task 13305:
> stack_trace_save+0x8c/0xc0
> kasan_save_stack+0x1e/0x40
> kasan_save_track+0x10/0x30
> __kasan_kmalloc+0x3a/0x50
> __kmalloc_noprof+0x247/0x290
> ceph_osdmap_alloc+0x16/0x130
> ceph_osdc_init+0x27a/0x4c0
> ceph_create_client+0x153/0x190
> create_fs_client+0x50/0x2a0
> ceph_get_tree+0xff/0x680
> vfs_get_tree+0x49/0x180
> do_new_mount+0x1a3/0x2d0
> path_mount+0x6dd/0x730
> do_mount+0x99/0xe0
> __do_sys_mount+0x141/0x180
> do_syscall_64+0x9f/0x100
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Freed by task 9475:
> stack_trace_save+0x8c/0xc0
> kasan_save_stack+0x1e/0x40
> kasan_save_track+0x10/0x30
> kasan_save_free_info+0x3b/0x50
> __kasan_slab_free+0x18/0x30
> kfree+0x212/0x290
> handle_one_map+0x23c/0x3b0
> ceph_osdc_handle_map+0x3c9/0x590
> mon_dispatch+0x655/0x6f0
> ceph_con_process_message+0xc3/0xe0
> ceph_con_v1_try_read+0x614/0x760
> ceph_con_workfn+0x2de/0x650
> process_one_work+0x486/0x7c0
> process_scheduled_works+0x73/0x90
> worker_thread+0x1c8/0x2a0
> kthread+0x2ec/0x300
> ret_from_fork+0x24/0x40
> ret_from_fork_asm+0x1a/0x30
>
> The buggy address belongs to the object at ffff88811012d800
> which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 16 bytes inside of
> freed 512-byte region [ffff88811012d800, ffff88811012da00)
>
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1101=
2c
> head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0x200000000000040(head|node=3D0|zone=3D2)
> page_type: f5(slab)
> raw: 0200000000000040 ffff888100042c80 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
> head: 0200000000000040 ffff888100042c80 dead000000000100 dead000000000122
> head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
> head: 0200000000000002 ffffea0004404b01 ffffffffffffffff 0000000000000000
> head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
> ffff88811012d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff88811012d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>
>     ffff88811012d800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>
> ^
> ffff88811012d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88811012d900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Disabling lock debugging due to kernel taint
> libceph: client274326 fsid 8598140e-35c2-11ee-b97c-001517c545cc
> libceph: mon0 (1)90.155.74.19:6789 session established
> libceph: client274327 fsid 8598140e-35c2-11ee-b97c-001517c545cc
>
> We have such scenario:
>
> Thread 1:
> void ceph_osdmap_destroy(...) {
>     <skipped>
>     kfree(map);
> }
> Thread 1 sleep...
>
> Thread 2:
> static bool have_mon_and_osd_map(struct ceph_client *client) {
>     return client->monc.monmap && client->monc.monmap->epoch &&
>         client->osdc.osdmap && client->osdc.osdmap->epoch;
> }
> Thread 2 has oops...
>
> Thread 1 wake up:
> static int handle_one_map(...) {
>     <skipped>
>     osdc->osdmap =3D newmap;
>     <skipped>
> }
>
> This patch fixes the issue by means of locking
> client->osdc.lock and client->monc.mutex before
> the checking client->osdc.osdmap and
> client->monc.monmap in have_mon_and_osd_map() function.
> Patch adds locking in the ceph_osdc_stop()
> method during the destructruction of osdc->osdmap and
> assigning of NULL to the pointer. The lock is used
> in the ceph_monc_stop() during the freeing of monc->monmap
> and assigning NULL to the pointer too. The monmap_show()
> and osdmap_show() methods were reworked to prevent
> the potential race condition during the methods call.
>
> Reported-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> ---
>  net/ceph/ceph_common.c | 14 ++++++++++++--
>  net/ceph/debugfs.c     | 33 +++++++++++++++++++--------------
>  net/ceph/mon_client.c  |  9 ++++++++-
>  net/ceph/osd_client.c  |  4 ++++
>  4 files changed, 43 insertions(+), 17 deletions(-)
>
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 4c6441536d55..5c8fd78d6bd5 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -790,8 +790,18 @@ EXPORT_SYMBOL(ceph_reset_client_addr);
>   */
>  static bool have_mon_and_osd_map(struct ceph_client *client)
>  {
> -       return client->monc.monmap && client->monc.monmap->epoch &&
> -              client->osdc.osdmap && client->osdc.osdmap->epoch;
> +       bool have_mon_map =3D false;
> +       bool have_osd_map =3D false;
> +
> +       mutex_lock(&client->monc.mutex);

Hi Slava,

This introduces a potential sleep into a function that is used as
a wait_event condition in __ceph_open_session() which could result in
a nested sleep.  This is frowned up by the scheduler because the task
state may get reset to TASK_RUNNING when not desired:

  do not call blocking ops when !TASK_RUNNING; state=3D1 set at
[<ffffffff819c19fc>] prepare_to_wait_event+0x3ac/0x460
kernel/sched/wait.c:298

You would probably need to open-code waiting in __ceph_open_session()
per [1].

> +       have_mon_map =3D client->monc.monmap && client->monc.monmap->epoc=
h;
> +       mutex_unlock(&client->monc.mutex);
> +
> +       down_read(&client->osdc.lock);
> +       have_osd_map =3D client->osdc.osdmap && client->osdc.osdmap->epoc=
h;
> +       up_read(&client->osdc.lock);
> +
> +       return have_mon_map && have_osd_map;
>  }
>
>  /*
> diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> index 2110439f8a24..6e2014c813ca 100644
> --- a/net/ceph/debugfs.c
> +++ b/net/ceph/debugfs.c
> @@ -36,18 +36,20 @@ static int monmap_show(struct seq_file *s, void *p)
>         int i;
>         struct ceph_client *client =3D s->private;
>
> -       if (client->monc.monmap =3D=3D NULL)
> -               return 0;
> -
> -       seq_printf(s, "epoch %d\n", client->monc.monmap->epoch);
> -       for (i =3D 0; i < client->monc.monmap->num_mon; i++) {
> -               struct ceph_entity_inst *inst =3D
> -                       &client->monc.monmap->mon_inst[i];
> -
> -               seq_printf(s, "\t%s%lld\t%s\n",
> -                          ENTITY_NAME(inst->name),
> -                          ceph_pr_addr(&inst->addr));
> +       mutex_lock(&client->monc.mutex);
> +       if (client->monc.monmap) {
> +               seq_printf(s, "epoch %d\n", client->monc.monmap->epoch);
> +               for (i =3D 0; i < client->monc.monmap->num_mon; i++) {
> +                       struct ceph_entity_inst *inst =3D
> +                               &client->monc.monmap->mon_inst[i];
> +
> +                       seq_printf(s, "\t%s%lld\t%s\n",
> +                                  ENTITY_NAME(inst->name),
> +                                  ceph_pr_addr(&inst->addr));
> +               }
>         }
> +       mutex_unlock(&client->monc.mutex);

Nit: I'd prefer

        mutex_lock(&client->monc.mutex);
        if (client->monc.monmap =3D=3D NULL)
                goto out_unlock;

        ...

out_unlock:
        mutex_unlock(&client->monc.mutex);
        return 0;

to an additional level of indentation here.

> +
>         return 0;
>  }
>
> @@ -56,13 +58,15 @@ static int osdmap_show(struct seq_file *s, void *p)
>         int i;
>         struct ceph_client *client =3D s->private;
>         struct ceph_osd_client *osdc =3D &client->osdc;
> -       struct ceph_osdmap *map =3D osdc->osdmap;
> +       struct ceph_osdmap *map =3D NULL;
>         struct rb_node *n;
>
> +       down_read(&osdc->lock);
> +
> +       map =3D osdc->osdmap;
>         if (map =3D=3D NULL)
> -               return 0;
> +               goto finish_osdmap_show;
>
> -       down_read(&osdc->lock);
>         seq_printf(s, "epoch %u barrier %u flags 0x%x\n", map->epoch,
>                         osdc->epoch_barrier, map->flags);
>
> @@ -131,6 +135,7 @@ static int osdmap_show(struct seq_file *s, void *p)
>                 seq_printf(s, "]\n");
>         }
>
> +finish_osdmap_show:

Nit: I'd rename this label to out_unlock so that name communicates what
the label is for.

>         up_read(&osdc->lock);
>         return 0;
>  }
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index ab66b599ac47..b299e5bbddb1 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -1232,6 +1232,7 @@ int ceph_monc_init(struct ceph_mon_client *monc, st=
ruct ceph_client *cl)
>         ceph_auth_destroy(monc->auth);
>  out_monmap:
>         kfree(monc->monmap);
> +       monc->monmap =3D NULL;
>  out:
>         return err;
>  }
> @@ -1239,6 +1240,8 @@ EXPORT_SYMBOL(ceph_monc_init);
>
>  void ceph_monc_stop(struct ceph_mon_client *monc)
>  {
> +       struct ceph_monmap *old_monmap;
> +
>         dout("stop\n");
>
>         mutex_lock(&monc->mutex);
> @@ -1266,7 +1269,11 @@ void ceph_monc_stop(struct ceph_mon_client *monc)
>         ceph_msg_put(monc->m_subscribe);
>         ceph_msg_put(monc->m_subscribe_ack);
>
> -       kfree(monc->monmap);
> +       mutex_lock(&monc->mutex);

Did you have a specific reason for adding locking here and in
ceph_osdc_stop()?  I see that David inquired about this in a comment
on v2 and I think the answer to his question is no.  By this point we
are long past the point of no return and no new messages can arrive for
e.g. handle_one_map() to be called.

[1] https://lwn.net/Articles/628628/

Thanks,

                Ilya

