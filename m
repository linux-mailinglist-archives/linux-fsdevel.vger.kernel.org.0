Return-Path: <linux-fsdevel+bounces-42067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F108A3BE61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 13:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8DC3ACEC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 12:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC6A1E0DCD;
	Wed, 19 Feb 2025 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF4wdF+v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA61DF974
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969090; cv=none; b=WbNASAXPJ8dEvA+fJpzkcgkdR7pnpaZ1al7U3AccNpI2aL5GflFBkXj/GriES/lauOo4dib0dQTTHSP685QH6SXrotRH3kLfic8BaG93CI1cSfusQSuGjZafyhQfAIw296O+rVU9utJP27SvFuND1aWuXmvqbCKyoqLaPzdVDCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969090; c=relaxed/simple;
	bh=yMDpB6Zo4D+TTRUTIFhHpwv9UC15iD30hhHIP34BnYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elDqbGG8yKfIn6goqqoqM9+g6FNL546JInf9mELyCXqxPswWUhRWScsBN5dgd1mYYdyyCqIKavc2BSCpsdgkD46WcVfLE8PACnTZwaSvLGudAuMKx1FudfQMdE5insSYosdISsdwPF7bktlvF9j/D9Jga7G317jPJlCu6ZmRE8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dF4wdF+v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739969087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGuYwa0tEb+EDnahlJH+Kml1lukEdn6aNzMvNWvEPss=;
	b=dF4wdF+vIQaxJBT7SDlmwWLdJn72RqjT8+tMvXmzL3tL0WdpMdaM1w7v272LiwRyhLLDlQ
	IvBsRLB0KRFOSNvLxV3q3DAGSIky66QkfMYGOS8flQbvMForS7LagcFuqKLBno8wd2+Ctx
	dngry0KgK8fWrB3ye2WwemmEmIwmdSs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-L8nD_Pw4OtuKH-pAsdCEFw-1; Wed, 19 Feb 2025 07:44:46 -0500
X-MC-Unique: L8nD_Pw4OtuKH-pAsdCEFw-1
X-Mimecast-MFC-AGG-ID: L8nD_Pw4OtuKH-pAsdCEFw_1739969085
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abb8f65af3dso297269466b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 04:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969085; x=1740573885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGuYwa0tEb+EDnahlJH+Kml1lukEdn6aNzMvNWvEPss=;
        b=uEmFgPZun61IsSTv7wVTutK7L2+c+HRF9qpIeoEGpEq/aIP+Hyw2Lr1aE71RQW6Va0
         zZFW4Jq7a/F9Fq4ETOog4n8y055zy/UpbJ5B7trIW1Ln1Zwk6fHeHsiJayoc7xb4o2tG
         GHSeNjC2ef6BqNSnHJuXLIQtSILRiBB2WikRzExYLKu78+S8yekC2XVXd7n3yY2icJXb
         eKVhILSwYpZHmL7rMXGWt5zrSKLozdRIYO+iRKeoXu+evBds0SqeFfoBqpP2ZX0CYdZN
         l0CJ0Rf3zY9dNxOKty4fn6RqvkzWUJSPKk4eqO8Y2vkni26qtHfKZ5g7IYBQtAHR/+Hc
         s33g==
X-Forwarded-Encrypted: i=1; AJvYcCUTIGjtFSkiOAbW5UPmm9NI50q5K8bBhchZu3lYhgFolbz/7CQkGxYtxLMXqsvblVxwEjGOWjkn+CtTKrEM@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMZsoG99l8FHf1LHTCg9TUXSQb2nkK7VxwYSkUpn8aTeq08PH
	wh76ccznhjkbiX3lmIvbJy/g19tDX34gB9TmnXOuhCpthVNFiKwxibHkdnB2VflBGIM8KKjwscv
	mUSUUj6KjLNCyRUEv8XbWHpDNbYwFLatw9IV9bm15O0RNPhPwtbu8hEORkogiOGRW3bUPmj/5oF
	+II5AOUCCpyh1THbvMI+bKBz40sUqZyGfz8o9Sew==
X-Gm-Gg: ASbGncvxr50e7TLil5mi6ZW69aIi/ohKxqkl8ZSmtJKzFg+Xo/SsrW1PT7vNZa8Tc2Y
	/d6ZZu7PUdpL+mcmrhkWxulU5k5DCAdplyu7jrDt1EUHX5tL8i47nCiSdRnI=
X-Received: by 2002:a17:907:3f18:b0:ab2:db7b:5db3 with SMTP id a640c23a62f3a-abbcd0c2b1emr299401066b.54.1739969084671;
        Wed, 19 Feb 2025 04:44:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3/fQsga0scILn/gp/rI/u2nbcj3uPd3PHHFOf5C1dwtjxyfCXeKfmyRL2uv+VEsMDV2Yqi5t8wsFBHkic5jE=
X-Received: by 2002:a17:907:3f18:b0:ab2:db7b:5db3 with SMTP id
 a640c23a62f3a-abbcd0c2b1emr299397966b.54.1739969084234; Wed, 19 Feb 2025
 04:44:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219003419.241017-1-slava@dubeyko.com>
In-Reply-To: <20250219003419.241017-1-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 19 Feb 2025 14:44:32 +0200
X-Gm-Features: AWEUYZk2id_fLg839br33zLq9NKfALR_lvQ09fkQinIRAjPzOSPxi-cpTAvpjsQ
Message-ID: <CAO8a2SjeD0_OryT7i028WgdOG5kB=FyNMe+KnPHEujVtU1p7WQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix slab-use-after-free in have_mon_and_osd_map()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, dhowells@redhat.com, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This fixes the TOCTOU problem of accessing the epoch field after map-free.
I'd like to know if it's not leaving a correctness problem instead. Is
the return value of  have_mon_and_osd_map still valid and relevant in
this case, where it is being concurrently freed?

On Wed, Feb 19, 2025 at 2:34=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.c=
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
> client->monc.monmap.
>
> Reported-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> ---
>  net/ceph/ceph_common.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
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
> --
> 2.48.0
>


