Return-Path: <linux-fsdevel+bounces-52884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D607AE7F46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 12:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11DA17CF12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C611D2882BD;
	Wed, 25 Jun 2025 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxebEv4/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491BD17A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847422; cv=none; b=A6L9j9uGFk9OB8uCm7oEE5dZ9S7GKOWbGwV64iPniT52bokRd0lAIDt9J4MDMNz8l+/ICHEi/eLKZbdTFRqQd06gD0z2Ji+WbwxsZQkUcx+nswzK7kMI2qzUAlACAl1T8/0857XDbysi6s0fkk239CE9Jf4WD9korzzDrT5k/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847422; c=relaxed/simple;
	bh=ptkbAN9wqd7hvXUDgjllyUn47wW6geoAnJugnyw6Csk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5+QJYjxfqX/VcFZi07qlhiBNZd4zPu9nxUVPg6BVaj2Bpn1nYE1X2+BZdUh83fEy4eX7RmsWhZ3ETg7bmvIhBcU9YLX/b83xvcnp2UPrFKId0vC14mZLvdIvuFV9ztq0OvXbJBeOeaQOTs753AmcxXWiizvcVJ6hKmOTWnNXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FxebEv4/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750847419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8jkOAb6mN+F8JmQ1gdXZ34o9hgWBfxng/Qd5uQIbyGg=;
	b=FxebEv4/jlbZjaNzc6lXbK3LLOrkpNvUNP2p3gECxUGHWFBvJDkf7gpqSVBhsdFdWP7hiX
	MtWAWfKirrA9qq3m342fD7BWL/z4w86l3/hLvdFa/xaRqxwgCzWBrcZF1pSIcS9XkTWRVB
	p9UAZHy9zSsWFGL2bAn3SOhpC2LzaCo=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-y-UJ59_BOmKFnjBe76aZrg-1; Wed, 25 Jun 2025 06:30:18 -0400
X-MC-Unique: y-UJ59_BOmKFnjBe76aZrg-1
X-Mimecast-MFC-AGG-ID: y-UJ59_BOmKFnjBe76aZrg_1750847417
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5314d22c278so1984682e0c.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 03:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750847417; x=1751452217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jkOAb6mN+F8JmQ1gdXZ34o9hgWBfxng/Qd5uQIbyGg=;
        b=oWvGU+VrPWVTfAa4Cpha85hOohbcoyQKezPnIXSJBkMfH3JDpgfphgkdmkRM+y0eoI
         uEyqDz0pliLmaacor50jMSXQLQXPOBojJZJb5anz36nP2ocNtdserngE/KlirtQqXgS7
         GQ6FZaK0tuEjWSjHl+gRPWRjQeu8x5vyOyta4e1WDOc8y9U4im4nt3yZaopOHR03yvt3
         SELGTITnVBBX31wCgrFTqdK28/SB66NaN4ROQB7uFrb66ddu9h9aMtvf9yjSjTWst/nz
         hxjC6n/cPX8a8noff46357JyBF2OWSKIWZR50/q66iEci9LSxfW4AcHHJA1z4jKaQzRM
         cxcg==
X-Forwarded-Encrypted: i=1; AJvYcCX8Rg2SbO1vv5/1V5O7Z8CQg9WBSBrtaoUGEPljvk/eiOm0nbq8jixFko7k/4CRurufce1Wxb149Tc9RUUh@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNnx7NaAavVhUlKex21n/H0azG+ofxtc4qiCVVf6AA5a5Q7Yg
	j6oEiIhfrbWA4thZ6SsmKlMqI9yye/FxyaJPAHvYkcA9nRL+JmNKqpIXLZ3FLG8N5e3OXR6s78Y
	He7Pv+wJMGLoGrjCiMh+rRPezYnYbj8DVAHXnjykXuKll84sJmr+vYIMZym3dCpBKQVpKj93Xw+
	COGLJKZ8JfU5mQHXNsiNr+hop2C32H0kCASgtl0qvQEA==
X-Gm-Gg: ASbGnct67ftSdLZAsp53nFZ6rOVJ8wj9nLEqMcbSVbIcu7H6ug9scfT4fU8B7cOO3z6
	YLBXRz7Fmw1vlm1JL8E2/f2YeZtxYF7YdhyD1YajF+RWL9clnTnvTBM36zpJ4tCuuGeqc1MPfgv
	4n
X-Received: by 2002:a05:6122:398b:b0:531:1d21:dbd5 with SMTP id 71dfb90a1353d-532ef5e8c9dmr1272820e0c.5.1750847417194;
        Wed, 25 Jun 2025 03:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJF5/mu45XLWE0QgK780krYcbpR5HYU6Su3mgDUyKZWuZNFwj+wGhTm4GnEtDSWZzxygdq8EZAAdqIMbS0i4s=
X-Received: by 2002:a05:6122:398b:b0:531:1d21:dbd5 with SMTP id
 71dfb90a1353d-532ef5e8c9dmr1272804e0c.5.1750847416744; Wed, 25 Jun 2025
 03:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618191635.683070-1-slava@dubeyko.com>
In-Reply-To: <20250618191635.683070-1-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 25 Jun 2025 13:30:05 +0300
X-Gm-Features: Ac12FXzIdJvywu7fGzuopzAfl9p6aB7BuXNOOQ8_hDOUVKxrzQF9jRf3y2krPNI
Message-ID: <CAO8a2SiFTkfpHTbEbWCfHf73drTWM_0Sk+P6bdQEQs4=WxXKng@mail.gmail.com>
Subject: Re: [PATCH v6] ceph: fix slab-use-after-free in have_mon_and_osd_map()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, dhowells@redhat.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good analysis of the race condition. The locking approach is sound and
addresses the use-after-free properly.

Reviewed-by: Alex Markuze amarkuze@redhat.com

On Wed, Jun 18, 2025 at 10:17=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.=
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
>  net/ceph/ceph_common.c | 34 +++++++++++++++++++++++++++++-----
>  net/ceph/debugfs.c     | 17 +++++++++++++----
>  net/ceph/mon_client.c  |  9 ++++++++-
>  net/ceph/osd_client.c  |  4 ++++
>  4 files changed, 54 insertions(+), 10 deletions(-)
>
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 4c6441536d55..a28b29c763ca 100644
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
> @@ -813,9 +823,23 @@ int __ceph_open_session(struct ceph_client *client, =
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
> +               while (!(have_mon_and_osd_map(client) ||
> +                                       (client->auth_err < 0))) {
> +                       if (signal_pending(current)) {
> +                               err =3D -ERESTARTSYS;
> +                               break;
> +                       }
> +                       wait_woken(&wait, TASK_INTERRUPTIBLE,
> +                                  ceph_timeout_jiffies(timeout));
> +               }
> +
> +               remove_wait_queue(&client->auth_wq, &wait);
> +
>                 if (err < 0)
>                         return err;
>                 if (client->auth_err < 0)
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
> +       old_monmap =3D monc->monmap;
> +       monc->monmap =3D NULL;
> +       mutex_unlock(&monc->mutex);
> +       kfree(old_monmap);
>  }
>  EXPORT_SYMBOL(ceph_monc_stop);
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 6664ea73ccf8..7f84db538868 100644
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
> @@ -5283,10 +5284,13 @@ void ceph_osdc_stop(struct ceph_osd_client *osdc)
>         WARN_ON(atomic_read(&osdc->num_requests));
>         WARN_ON(atomic_read(&osdc->num_homeless));
>
> +       down_write(&osdc->lock);
>         ceph_osdmap_destroy(osdc->osdmap);
> +       osdc->osdmap =3D NULL;
>         mempool_destroy(osdc->req_mempool);
>         ceph_msgpool_destroy(&osdc->msgpool_op);
>         ceph_msgpool_destroy(&osdc->msgpool_op_reply);
> +       up_write(&osdc->lock);
>  }
>
>  int osd_req_op_copy_from_init(struct ceph_osd_request *req,
> --
> 2.49.0
>


