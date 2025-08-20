Return-Path: <linux-fsdevel+bounces-58404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8434B2E608
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 22:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92468A25E68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 20:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34285277C9A;
	Wed, 20 Aug 2025 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0DQ4HCq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0791186284;
	Wed, 20 Aug 2025 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755720311; cv=none; b=iN4gOn5vkBJXTE4P8ffPuIlqla1GefTLEQJtv/KITdAesKR+awHN75iZxtUMio6v3aUUfVcgUuLQ11qe7rGPMmlolVTvENqfZwYlehp43lQeYETu9kd0qdoVMRDM7PNdilV3S60y2eWy1yNWtZg2bpVaxs5wrEPzL6aR7JC/gsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755720311; c=relaxed/simple;
	bh=NXKhnrmP2+WOlqtA9iIw9deXGel772xFPmj1x6Tafwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKNsTtkkEI19DqJ4IGUw3G3N+fHwroN7tL6Vh8v/ZDmGaTrgyBOqQotrQYTWB+RILU3KBNQ7svtSO1bwG95S2d0M0qvqZ1sYq+myv/Ov8J0xI+fLONHSPUJjFG+iG+P7iHU/S/nCuPg+SXJckyG7lycBJDKShWejEeE7f8Uf4e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0DQ4HCq; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b471738daabso186104a12.1;
        Wed, 20 Aug 2025 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755720309; x=1756325109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jw6DbvmnadkwbsdKYC/JmQbLE5ZfMoqy/PBV4EG436w=;
        b=h0DQ4HCqXs18q5uLxijgpGP8J4kma2Gujo4KTqv949M51otS8szdPFOCVl1YYUemqt
         SrqzNBq44xIg9ep4OZ2360TAWdcKTxxNsBi5Cu7qKnG1k+R+Yow/Ja8qz/IoIP1mgpvj
         Vam6emqKiCmhQpy+ln8I+iL4DBBlyDnoSyfK1DKtxAsVXpzrFG0VneiQQ/Jq4Dgrzpuj
         6gsVUOpMxWd26WhDmgJjkBh59ypYH+axIsN4qHaLD0qj8seLoZhwfS20rrOTXUdVc8k/
         UDoordVO1TCGI34OtVaKnoXSTBRaIOH4udIMuo/qjNIIa7C545khnFFh/JE55OfLYDEc
         Hecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755720309; x=1756325109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jw6DbvmnadkwbsdKYC/JmQbLE5ZfMoqy/PBV4EG436w=;
        b=jOLw/FGQgb2hVMmSbuEawLLBo4M6kBK5srGBCNzSMppK7buqhx5+VJTBd80zrcAWaY
         YBwLj17GrCGmp/1Ga63a04Hdd762oTWg48xNOBZcQ2d3eiXmbaQGUm6KbYUeSrp23H21
         hjKN8F+ummAyF17//X5XfBBUuAe2p+ZT2jg+XUSN+Oh8PtkYcWFjOuArqjJfqppFZdsz
         nPWtV9O/O0X34q45VCPkdIcvxqnyZp1oGc9CiRI2glWrB246xxFbgsGjCs9uLLWfsJn9
         R6iZeqnCjiJOSXtjzxMVhhkbDOywxrWJwKZX2WEaYGs4y8InkSSbSTc+pyiO7f6krhYu
         JNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBl/wj21LbjHdE5wQBVTI7reRV5EpFsCa7lqJyP7xkNZwRhqCse/agIg35r/3ujjEeXwK9++qOlAmFVIR+@vger.kernel.org
X-Gm-Message-State: AOJu0YxX7/WzhvuUqxLQkkXcmKoW7FMOEbZdGEh3TchJog9Du/KHDEWD
	YBhM9BcKLlrK2gkpnrAnr/tEWgan6H8TzGax71NF2AhyF43jk8pOJive7+KbLe1XK05/LyvBNQb
	hajpw6SPPjQGawL4V+WQ8wRYHmp8b5h8=
X-Gm-Gg: ASbGncv23xqdSWt2mfJIUzFIyV7y9BWwxvoWyFUzYW66ULUxJmLUGdr4o897um6y1FP
	AhZYQB77X1lEAYWHYg4PblQlAGrCMJlwy20/jL+P2cimz8WKdqrnAbf9sGqaEiRW69CEjD5kFGI
	YTb79q7BlB9pw1vFdKSDRnKzOgfAglq4ra65s3JM1xMaGFHE8YgqjC8ux2XZYYNKb0lPVRBYMBr
	0sMiEk=
X-Google-Smtp-Source: AGHT+IGqIjXihU7TFlfCySZ5X4PtUBsvcMXK80hZ8qMbgXi1JQzbFQb6wdWed2wruPjWvQhjQvyX9h6EtIEtNn4CAZY=
X-Received: by 2002:a17:902:ebc5:b0:240:763d:e9a6 with SMTP id
 d9443c01a7336-245fec13bb3mr423195ad.25.1755720308967; Wed, 20 Aug 2025
 13:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703174128.500301-1-slava@dubeyko.com>
In-Reply-To: <20250703174128.500301-1-slava@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 20 Aug 2025 22:04:57 +0200
X-Gm-Features: Ac12FXyOM3KX7eMw44OzcaTw1pqnqhHzbWRTmKMfKfL_OpwMPJb9EI-DZ4BD3x8
Message-ID: <CAOi1vP8Meq-TBetLmkmKBKzsqf9gzyZwZc8413bfE19WhpmPvA@mail.gmail.com>
Subject: Re: [PATCH v7] ceph: fix slab-use-after-free in have_mon_and_osd_map()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, amarkuze@redhat.com, 
	Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 7:41=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.co=
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
> The monmap_show() and osdmap_show() methods were reworked
> to prevent the potential race condition during
> the methods call.
>
> Reported-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> ---
>  net/ceph/ceph_common.c | 43 +++++++++++++++++++++++++++++++++++-------
>  net/ceph/debugfs.c     | 17 +++++++++++++----
>  net/ceph/mon_client.c  |  2 ++
>  net/ceph/osd_client.c  |  2 ++
>  4 files changed, 53 insertions(+), 11 deletions(-)
>
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 4c6441536d55..bf2be6e43ff7 100644
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
> @@ -808,18 +819,36 @@ int __ceph_open_session(struct ceph_client *client,=
 unsigned long started)
>                 return err;
>
>         while (!have_mon_and_osd_map(client)) {
> +               mutex_lock(&client->monc.mutex);
> +               auth_err =3D client->auth_err;
> +               mutex_unlock(&client->monc.mutex);
> +
> +               if (auth_err < 0)
> +                       return auth_err;
> +
>                 if (timeout && time_after_eq(jiffies, started + timeout))
>                         return -ETIMEDOUT;
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
> +               while (!have_mon_and_osd_map(client)) {

Hi Slava,

This still doesn't seem right to me.

There is a nested while loop with the same !have_mon_and_osd_map(client)
condition which suggests that one of those is redundant -- once the
nested loop is entered there is no way for the outer loop to be entered
again (i.e. continued) because upon exit from the nested loop either
have_mon_and_osd_map() would no longer be false or err would be set to
ERESTARTSYS.

An important detail also got lost in the change: client->auth_err < 0
was previously part of wait_event_interruptible_timeout() condition
which meant that it was checked repeatedly on every wakeup whereas now
it's checked just once at the beginning.  This would lead to a hang on
any authentication-related error raised by the monitor client.

Thanks,

                Ilya

