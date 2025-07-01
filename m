Return-Path: <linux-fsdevel+bounces-53582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5D7AF0436
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 21:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7717116EB38
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA3F28468D;
	Tue,  1 Jul 2025 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw+//fCu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4F200112;
	Tue,  1 Jul 2025 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399887; cv=none; b=AZb7zclb7Im7r3rS3EiI5w4+zUgRcjFNWewXaWFSrpDDh3iXXL+ULeA19F0EdH0PVi56F2oEfTNVA8GTznoIxYtWiuCM+5Q6qS0ZChui31OlnMUayK1XBIab2/TsqSqCQ22MKc2ATgjY5uz18A8VJMiEflWZr7QEArU8/NnZREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399887; c=relaxed/simple;
	bh=mh13/K2C3YH46fd5VgRsKUd7xhh7UShj7//mgZNl1Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0qgE2+Q717QCC9Eksh9vq3dY27zwR63m7rFkHLmnAD6bvoTFFeWdtTB8cUAulzvDuNjPF5k3UCLJe7kwE2dtSl+bOW6ESERDUbSbvVuPUg9CUPCdcXcpySCHZSYzBmHd2YlDJCuIDRopHlqC7OjzZXBpH5AEUJRTS2BDfqUEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hw+//fCu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2363497cc4dso51620665ad.1;
        Tue, 01 Jul 2025 12:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751399885; x=1752004685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmXSKJuzG9fYEMivZ/nOpZUlPnVXgIe5HngikPOgmZk=;
        b=hw+//fCuBTWsq+w9wYMnVyi3lJpSOl52rm1zyO+Sp2N2J4FhS1lgkedw0nJHJ0Ybol
         FRhe4pk8p474+Dh3ZpScM5BVM9ZTMeUQer39UqgAkePaHuCt5qAzPBi8qPq2qMpCX8rY
         IHxaZacRRfTzauxP0OBPkOLjaKvn+32L4XhbbESo0qOgSBJ1/s7VxTBoOXBnecqkrBtF
         +b0HeRBG7xWFy/VTsgT2An9cuXG1rUqRdf8PHXI6+s541vG57oPSs2ihccMoEaJghoaF
         i2vgWe0EPLQsTcWcOu66+61auOUv4dLZj7p52L7w8j/OTlx+yfbMyAHUJVwh9igIDyto
         JVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751399885; x=1752004685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmXSKJuzG9fYEMivZ/nOpZUlPnVXgIe5HngikPOgmZk=;
        b=LZcZbRcKhtJz126ARda1hBzHFLr7K/QoSgJh5bKH96uNMTwZRoZANdO0k5P3EnGIul
         jhWj4QwAlx2GJ3nXDp+SVYUSyeDcOnxUwop6bDOs44Yhrnv+iB/I42b4S7P6KKtomER+
         1V3sAGf6+pm0dv3FaD2Mq6cnVNYc/vFGdyS8MoDZEQkk+tPExfCGJVxjIo4oYefPes16
         9Odb/HKbRPjwPHRyQ8TVej7cIWgopkC3RIXGBpgzKqEa4E2wqw3oBbhMhM6Cj/yJadzd
         arxj6inrhmooIu+WbnoyvtDYQ4WeIUHIyZOuYVGJDwu/a3Zer6wMNo0LJ6ktZDaglDUF
         XIOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfMK5mKa7qXOCvEEQc2a48Pz2LEnQx+TG56XxqUO4GKm11LcGReyd2W+gPBssYoQJMy5bdRbSqvgasB87w@vger.kernel.org
X-Gm-Message-State: AOJu0YxiolUXsjFY4yvxSKL7uimf02TNfTG2NY4dDLucgMo7DQGtE4Ov
	FwK9arlrAEPsmfl4IuzmltKTkpXosZkSi86YwZ+wSTkQn+a7kU3Meq8Dy78ARCDvdoVA9mOvpJW
	O4aKOYgu8rzQ4ZglzNFVQy9XrfVWqXe0=
X-Gm-Gg: ASbGncvf33BL7MzW3lavKQj8hime1BRzb6BhBYYgzJz4jROSYllFN078kOS4RUCNDwx
	pvcyVlee2m8XzRt+Z80JQn0WAqrRK50TqZ/ZDPgSVTEpiA9gy7zCoW7VOpVSkPMHXGX2/pJUH4D
	P+HntxJc5rn/kuDSnwfdWiSDvxLqA4GiufpOp+r831omY=
X-Google-Smtp-Source: AGHT+IHHBwn0oOW7PxvZqPDdPlNvZrpbA5ic4HSrfsn/Iay+n1g4+7/IXt7CCKaQ7cjc+n0tZdaa58yx5CyOIBI65/I=
X-Received: by 2002:a17:902:e84f:b0:235:f49f:479d with SMTP id
 d9443c01a7336-23c6e452307mr218215ad.3.1751399884589; Tue, 01 Jul 2025
 12:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618191635.683070-1-slava@dubeyko.com>
In-Reply-To: <20250618191635.683070-1-slava@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 1 Jul 2025 21:57:52 +0200
X-Gm-Features: Ac12FXw-CC-ZZW3-erv5j4PL4aQKnA3ZXT-uqCQOMDT9S5JXD34r9yWF-WPaCNE
Message-ID: <CAOi1vP9_869BCjUMsQkQPZ6now_nvsQxv-SKZrTrCP7YFX1TyQ@mail.gmail.com>
Subject: Re: [PATCH v6] ceph: fix slab-use-after-free in have_mon_and_osd_map()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, amarkuze@redhat.com, 
	Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 9:16=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
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

Hi Slava,

This looks much better but misses two points raised in the comments on
previous versions.  The first point is that it would be better to
access client->auth_err under client->monc.mutex, matching how it's set
in finish_auth() -- now that locks can be freely taken here it should
be a trivial change.

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

Separately, I wonder if the new nested loop which checks both for the
presence of maps and client->auth_err could be merged into the existing
outer loop which currently checks for the presence of maps in the loop
condition and client->auth_err here in the loop body.  Having a single
loop with everything checked in just one place would be a lot cleaner.

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

The second point is that locking (or any changes at all) in
ceph_monc_stop() and ceph_osdc_stop() shouldn't be needed.  As
mentioned before, it's the point of no return where the entire client
including monc and osdc parts gets freed very shortly after.

Thanks,

                Ilya

