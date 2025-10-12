Return-Path: <linux-fsdevel+bounces-63865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 399F1BD0C0A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 22:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A56218964C7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 20:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B855231827;
	Sun, 12 Oct 2025 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRmDr2NQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD9622A4D5
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760301481; cv=none; b=HkxB4app0YoG2UFZW+F1n7+iNataeTnas9QAzt1gCIMspZFNbi1YN76gOeICH0ed8lVpNeVEKa3b3Ytd5S5RYx0IVSA+7P/qlBFr8jB+lrxoC09KcNPfoRO5JDZsO5+A1Ld1RRcOwTzPntDfTVYe8UXyj/RBZJhCh5eGVI9vVJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760301481; c=relaxed/simple;
	bh=cyi48sCfwLZrCToRMzJyR9R5Y6X6innb41X4MCmIIoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dq7ntazn4wMBSdx+13ytHfyN5cxlwQ6Bc/HDCVJ5qs8fWH3fINaZctyzFdhu9Vm2z+dv/ps4Gq+zK/+uhGaa5IjHwvVFfn6qcgQTvbrgf90jz6DdzZOxQ20oLw+//m2xpFDeEgnc4ZtbxysGrA3z82/yYWk4dXM49b0p/ex8H+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRmDr2NQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27edcbbe7bfso43147685ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 13:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760301477; x=1760906277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDMHoauhgzUbfhPB7WNTB4pX1Oro4486gIKDNUjqS8s=;
        b=RRmDr2NQxt2OhZwqRw1nI/qiT37Hr46k9WETQz8ujwau10q+EjGCoyPxscsE2wQ3H6
         Gno42Dz5R+4GlYq3+hTeQX46RRA3h6b+26BqB5op1ArSFR9e5PcDB+e/R3uJ/r1irSRH
         1cOel+1jpwmyxHrt3J3qMbk9hBEf5B96ognTYr+WLCBrQZSpzeqPWHfBhcsaUqy+4le0
         IhOyCyldIC3oWrwN7jSuXVVuc9o7US5E1+Jy91a1j6M2qgwDawSm/rSY4mI2WznVc+YJ
         a7Al7n9oVeWl9UyxbkYmWDfm5B7aEm/UVVfVkCPlkvDJpcaNoomztoPc6dO5t4ltZ3ZJ
         p4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760301477; x=1760906277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDMHoauhgzUbfhPB7WNTB4pX1Oro4486gIKDNUjqS8s=;
        b=xMx/sQ23ABuBHnF43D043CLQpFJd95ZzlsvRDbZVNngedqt7NIco/FWI+xHAX49OVw
         kAtrZ4nKZQ47Fdn47omWRYvwOgxiJ+HrAzcD2cnglI4eurgndrnBEdfsm4SqYKIbsVG8
         H7OB5HXOIjDio6MO4Dzr7NdpPRglhon3OteDlzVyQS7nJPlQ6LuZ1mOXEPISQk3UBmgO
         1GnYVlbLg4r7Xy8bTxGExXpRpzSunxrmSaslLQWpDCN3ZVEXIzCuWpjXQscf0Cr4NzkX
         oHujMMWNAPKBDBWoL5EdZr+3//KYmvBiAqdn6CD+dlvVcI6kKbLOgR6A6wB8kLSXVXVk
         PsGw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Qkt5UekWjm76mbvQop3CgAQbqFvrVUFV628JtphccI9R0PngPnsRFuKtuU4D83sSSb+ajhcdFWfknN1m@vger.kernel.org
X-Gm-Message-State: AOJu0YypMXQRuRgo0igiMoKmIQozIieSC0PS2H1YXh2QBX2uYka1TEuQ
	HYEkmA7/RUhpDyyttfkYltJw9ZA0WA3bGVQTON9dYiZYzhtfXKX5rAEHz21LFBmuslHOp+2fwPQ
	YHgcA8RnkVppgLmJSOcBU5A8GThdR/ZU=
X-Gm-Gg: ASbGncvf7KflhlE6C3nkw3kggbszq0ZLi6vUogGviU8nvZ+EKclsduG9QFU11kcX9eu
	A7xZQzQf9G/iI8ohzH3wJcrHk/5jGIzkNyWdXaEhncF97lKpHPTQPlevLFyTuU4mOd/98HcwfmT
	zdPcecDADtq+QRyur+UQw/ju6lq8LoGcRa4wSev1cex8bfWOriquLPgfPWlDUjejX16O3MYawS9
	1os2sBzW9umRD42l6VuUID+zkemglr4Rwkcq1h2vR5tYd4=
X-Google-Smtp-Source: AGHT+IHCFA3H1KS9kTExi4X1qQswKARze+1oIdFxAbbCy4hBC3von+SAREfIsRSeOzMKqGqZT5vFWV91yLeZp7psPRY=
X-Received: by 2002:a17:903:1b0b:b0:25c:d4b6:f117 with SMTP id
 d9443c01a7336-290272c1ab0mr253900715ad.35.1760301476932; Sun, 12 Oct 2025
 13:37:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821225147.37125-2-slava@dubeyko.com>
In-Reply-To: <20250821225147.37125-2-slava@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Sun, 12 Oct 2025 22:37:44 +0200
X-Gm-Features: AS18NWCuneAFO4z_b_vEBWQOjTotqFxgetP-1IbpFAgzSOW2E-CIjv2u9PpZj3o
Message-ID: <CAOi1vP_ELOunNHzg5LgDPPAye-hYviMPNED0NQ-f9bGaHiEy8A@mail.gmail.com>
Subject: Re: [PATCH v8] ceph: fix slab-use-after-free in have_mon_and_osd_map()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pdonnell@redhat.com, amarkuze@redhat.com, Slava.Dubeyko@ibm.com, 
	dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 12:52=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.=
com> wrote:
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
> The monmap_show() and osdmap_show() methods were reworked
> to prevent the potential race condition during
> the methods call.
>
> v8
> Ilya Dryomov has pointed out that __ceph_open_session()
> has incorrect logic of two nested loops and checking of
> client->auth_err could be missed because of it.
> The logic of __ceph_open_session() has been reworked.

Hi Slava,

I was confused for a good bit because the testing branch still had v7.
I went ahead and dropped it from there.

>
> Reported-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  net/ceph/ceph_common.c | 43 +++++++++++++++++++++++++++++++++++-------
>  net/ceph/debugfs.c     | 17 +++++++++++++----
>  net/ceph/mon_client.c  |  2 ++
>  net/ceph/osd_client.c  |  2 ++
>  4 files changed, 53 insertions(+), 11 deletions(-)
>
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 4c6441536d55..2a7ca942bc2f 100644
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
> @@ -800,6 +810,7 @@ static bool have_mon_and_osd_map(struct ceph_client *=
client)
>  int __ceph_open_session(struct ceph_client *client, unsigned long starte=
d)
>  {
>         unsigned long timeout =3D client->options->mount_timeout;
> +       int auth_err =3D 0;
>         long err;
>
>         /* open session, and wait for mon and osd maps */
> @@ -813,13 +824,31 @@ int __ceph_open_session(struct ceph_client *client,=
 unsigned long started)
>
>                 /* wait */
>                 dout("mount waiting for mon_map\n");
> -               err =3D wait_event_interruptible_timeout(client->auth_wq,
> -                       have_mon_and_osd_map(client) || (client->auth_err=
 < 0),
> -                       ceph_timeout_jiffies(timeout));
> +
> +               DEFINE_WAIT_FUNC(wait, woken_wake_function);
> +
> +               add_wait_queue(&client->auth_wq, &wait);
> +
> +               if (!have_mon_and_osd_map(client)) {

Only half of the original

    have_mon_and_osd_map(client) || (client->auth_err < 0)

condition is checked here.  This means that if finish_auth() sets
client->auth_err and wakes up client->auth_wq before the entry is added
to the wait queue by add_wait_queue(), that wakeup would be missed.
The entire condition needs to be checked between add_wait_queue() and
remove_wait_queue() calls -- anything else is prone to various race
conditions that lead to hangs.

> +                       if (signal_pending(current)) {
> +                               err =3D -ERESTARTSYS;
> +                               break;

If this break is hit, remove_wait_queue() is never called and on top of
that __ceph_open_session() returns success.  ERESTARTSYS gets suppressed
and so instead of aborting the opening of the session the code proceeds
with setting up the debugfs directory and further steps, all with no
monmap or osdmap received or even potentially in spite of a failure to
authenticate.

Thanks,

                Ilya

> +                       }
> +                       wait_woken(&wait, TASK_INTERRUPTIBLE,
> +                                  ceph_timeout_jiffies(timeout));
> +               }
> +
> +               remove_wait_queue(&client->auth_wq, &wait);
> +
>                 if (err < 0)
>                         return err;
> -               if (client->auth_err < 0)
> -                       return client->auth_err;
> +
> +               mutex_lock(&client->monc.mutex);
> +               auth_err =3D client->auth_err;
> +               mutex_unlock(&client->monc.mutex);
> +
> +               if (auth_err < 0)
> +                       return auth_err;
>         }
>
>         pr_info("client%llu fsid %pU\n", ceph_client_gid(client),
> diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> index 2110439f8a24..7b45c169a859 100644
> --- a/net/ceph/debugfs.c
> +++ b/net/ceph/debugfs.c
> @@ -36,8 +36,10 @@ static int monmap_show(struct seq_file *s, void *p)
>         int i;
>         struct ceph_client *client =3D s->private;
>
> +       mutex_lock(&client->monc.mutex);
> +
>         if (client->monc.monmap =3D=3D NULL)
> -               return 0;
> +               goto out_unlock;
>
>         seq_printf(s, "epoch %d\n", client->monc.monmap->epoch);
>         for (i =3D 0; i < client->monc.monmap->num_mon; i++) {
> @@ -48,6 +50,10 @@ static int monmap_show(struct seq_file *s, void *p)
>                            ENTITY_NAME(inst->name),
>                            ceph_pr_addr(&inst->addr));
>         }
> +
> +out_unlock:
> +       mutex_unlock(&client->monc.mutex);
> +
>         return 0;
>  }
>
> @@ -56,13 +62,15 @@ static int osdmap_show(struct seq_file *s, void *p)
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
> +               goto out_unlock;
>
> -       down_read(&osdc->lock);
>         seq_printf(s, "epoch %u barrier %u flags 0x%x\n", map->epoch,
>                         osdc->epoch_barrier, map->flags);
>
> @@ -131,6 +139,7 @@ static int osdmap_show(struct seq_file *s, void *p)
>                 seq_printf(s, "]\n");
>         }
>
> +out_unlock:
>         up_read(&osdc->lock);
>         return 0;
>  }
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index ab66b599ac47..2d67ed4aec8b 100644
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
> @@ -1267,6 +1268,7 @@ void ceph_monc_stop(struct ceph_mon_client *monc)
>         ceph_msg_put(monc->m_subscribe_ack);
>
>         kfree(monc->monmap);
> +       monc->monmap =3D NULL;
>  }
>  EXPORT_SYMBOL(ceph_monc_stop);
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 6664ea73ccf8..5f1e358bdfff 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -5255,6 +5255,7 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, st=
ruct ceph_client *client)
>         mempool_destroy(osdc->req_mempool);
>  out_map:
>         ceph_osdmap_destroy(osdc->osdmap);
> +       osdc->osdmap =3D NULL;
>  out:
>         return err;
>  }
> @@ -5284,6 +5285,7 @@ void ceph_osdc_stop(struct ceph_osd_client *osdc)
>         WARN_ON(atomic_read(&osdc->num_homeless));
>
>         ceph_osdmap_destroy(osdc->osdmap);
> +       osdc->osdmap =3D NULL;
>         mempool_destroy(osdc->req_mempool);
>         ceph_msgpool_destroy(&osdc->msgpool_op);
>         ceph_msgpool_destroy(&osdc->msgpool_op_reply);
> --
> 2.50.1
>

