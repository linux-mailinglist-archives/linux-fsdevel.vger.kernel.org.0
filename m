Return-Path: <linux-fsdevel+bounces-53696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C62AF60D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359274E0720
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0159A315502;
	Wed,  2 Jul 2025 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="jFgm1VnA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4866309A74
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479964; cv=none; b=P2n33fcZ079yGlQPfW+K3ZU6g9QWcZ42ovQ7uk6N1D17kiLwoW+9CL38fzWkPmuBZPyD3YaBueoqjXAuLefyTLmowsuHKwr8C5n7hxJsH4R4feTlDxmf+0vJCf6ffD1hNIotKhf6dZQGXoeodsbJfbBcoyWkg0QgbDnRJxuNjKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479964; c=relaxed/simple;
	bh=EVPf95pihwwwO1O9Yv7BFZilv3qrU95aIhPCtgrTgAA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IBfI13Vh7lOcrfu9NvrpJ7sspM11ZqjPvLaMDrbr0A/JVl8uopWgjct4zOukzWsDUJ2/pMXLWRYvNQipZTIQJ+3m5c51SrJkU8fAczpWW2wCTLRa9lOxC5DxJiJtaTit2k0A8oc0iug0v0se28FsXlqyaTwSmY10KDGrXRda5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=jFgm1VnA; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-710fe491842so68296927b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1751479959; x=1752084759; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EVPf95pihwwwO1O9Yv7BFZilv3qrU95aIhPCtgrTgAA=;
        b=jFgm1VnA1y+HiP3OQaJjiJccqkeg6Lj1SUbCwmd6+mA5QBq1D7B+JMEsEfw2cOGlcH
         kkFRsOuvScK5YDXmr79hdkM5xfwDa/aZFvx4EnaTLNgD8oXGYxAHtrgEZqr4rXpMSNpj
         pNCISHoimJ+fWNBrfUFZASIzZBsLb8tqccNscwo1zhNk7azhB5NPt4sUUg3Cp42KW/UT
         xfvPAJxXAQS+2jUEhFJ1pvle7GCVHVr56AEnSlBeB3XW6JMwaY6igs9l8Ol4VP3Oc/zm
         d20DIfRRW027S0ZdjwihDsy5mH+lRRtGoZfRTBvGyZcRbGc31qsviKts+uRVm2lHxKw9
         URTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751479959; x=1752084759;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVPf95pihwwwO1O9Yv7BFZilv3qrU95aIhPCtgrTgAA=;
        b=sWtlHjEkfcTUgCsCjrc3uAkoFDPvKtWN72v5SMqa9aaccCaJcdQUYeAncwa7I8cDjC
         5MAomEzyftU4E9YX5S3U0ajo6Hc4GUtq8McskbsgUaLkASx1mTTgR+T1qgPv8/xOH13j
         xGTErFGVOZNuGW/sMA7EKw6/SHXUrUAme/Kr3L0WxBRFhegsG0x9bt5BTfXt2XCI8RGW
         z1oyYqK+6PsP0BOelB2KxXbf2FoJqQu8XxZ+v0SIoPn5vKnz23h/R/Ytxa3SVTBuEg96
         YPOB9Pmkqw/+fXGut6gn9w/O3HIQAhGZnk1hX+483NlQxkXhEGHMvdieNQHQ2jhCnwyE
         Gjnw==
X-Forwarded-Encrypted: i=1; AJvYcCUC2q27mBgzzKtPjhDRDOCXXPapKZxZM47WCEKBrpZu6uY0Q5Ap/KSiFoZGxUy05Pr3/HBoleNNGbq9BHvk@vger.kernel.org
X-Gm-Message-State: AOJu0YzmQgSiV6blEiLOMu9dwe72rhuBocSPN2kXNg2Un9dd5JIrhXyv
	BbqbaRxPubGAC2U/ErN3cU+0MGw+f8xuokcxxTZ8WH8ykHP25YZU4S0rT56Ojx76oa8=
X-Gm-Gg: ASbGncuezIjN6M9y599lRudFLcGK6pJkrvS5JwnovGw3VvGdWPaR+AWuJ2ns7ZAbPaX
	4TGlLgTBWVZvm+Xl1CuOal2/TFzNTPvi5NzgD/ztVo5BQbOR9sGu+vxUxRRvxon0ps0CLuATOZ2
	LUnCQH93Rqfa8zDY6kesGHH/4PMgWfJY92QnILNkwMS8GHrHsKzErZzLZWx9yxLDkUJQfz1UQN6
	2jQsYLRJ0EyhTMTL5+vop6KY8Ei+Wy3qVGB+fRXQkyXWMILC/3RNlrbMkqZnAy+XiEb4oO/iXUK
	1vFWDVlEU2FINkLw0ktPf/DdEEjkvamUuWzP1hp1bhu1pPN1tXSXLv9ED/1MUOW0KRYN7MtnWpT
	2DAA5bbq3BAZ+sybP2opbOFWagImtdUMLyA==
X-Google-Smtp-Source: AGHT+IH5YDVWLUa/B5lmQ1Yo8qBGY0lgApGG/92txptMhQhXuLwlcyajLP21HuIasgdBEEl9j2Xp7g==
X-Received: by 2002:a05:690c:907:b0:713:ff41:37f1 with SMTP id 00721157ae682-7164d59c0e7mr54032007b3.29.1751479959144;
        Wed, 02 Jul 2025 11:12:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:754f:c811:1dbc:f5e8? ([2600:1700:6476:1430:754f:c811:1dbc:f5e8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515c94bd4sm25733037b3.63.2025.07.02.11.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:12:38 -0700 (PDT)
Message-ID: <811f360c85aa9beeab59d55924687e57e670dd5d.camel@dubeyko.com>
Subject: Re: [PATCH v6] ceph: fix slab-use-after-free in
 have_mon_and_osd_map()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, amarkuze@redhat.com, 
	Slava.Dubeyko@ibm.com
Date: Wed, 02 Jul 2025 11:12:36 -0700
In-Reply-To: <CAOi1vP9_869BCjUMsQkQPZ6now_nvsQxv-SKZrTrCP7YFX1TyQ@mail.gmail.com>
References: <20250618191635.683070-1-slava@dubeyko.com>
	 <CAOi1vP9_869BCjUMsQkQPZ6now_nvsQxv-SKZrTrCP7YFX1TyQ@mail.gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
 fAMjjkInIPg7RLGs8FiwxfcpkILP0YbVWHiNAaQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-01 at 21:57 +0200, Ilya Dryomov wrote:
> On Wed, Jun 18, 2025 at 9:16=E2=80=AFPM Viacheslav Dubeyko
> <slava@dubeyko.com> wrote:
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
> > Patch adds locking in the ceph_osdc_stop()
> > method during the destructruction of osdc->osdmap and
> > assigning of NULL to the pointer. The lock is used
> > in the ceph_monc_stop() during the freeing of monc->monmap
> > and assigning NULL to the pointer too. The monmap_show()
> > and osdmap_show() methods were reworked to prevent
> > the potential race condition during the methods call.
> >=20
> > Reported-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > ---
> > =C2=A0net/ceph/ceph_common.c | 34 +++++++++++++++++++++++++++++-----
> > =C2=A0net/ceph/debugfs.c=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++++++++++++----
> > =C2=A0net/ceph/mon_client.c=C2=A0 |=C2=A0 9 ++++++++-
> > =C2=A0net/ceph/osd_client.c=C2=A0 |=C2=A0 4 ++++
> > =C2=A04 files changed, 54 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> > index 4c6441536d55..a28b29c763ca 100644
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
> > @@ -813,9 +823,23 @@ int __ceph_open_session(struct ceph_client
> > *client, unsigned long started)
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
=A0=C2=A0=C2=A0 while (!(have_mon_and_osd_map(client) ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (client->auth_err < 0))) {
>=20
> Hi Slava,
>=20
> This looks much better but misses two points raised in the comments
> on
> previous versions.=C2=A0 The first point is that it would be better to
> access client->auth_err under client->monc.mutex, matching how it's
> set
> in finish_auth() -- now that locks can be freely taken here it should
> be a trivial change.
>=20

OK. Let me rework the patch. I hope it will be trivial change. :)

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (signal_=
pending(current)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D -ERESTARTSYS;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_woken(=
&wait, TASK_INTERRUPTIBLE,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_timeout_jiffies=
(timeout));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 remove_wait_queue(&client->auth_wq, &wait);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (err < 0)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n err;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (client->auth_err < 0)
>=20
> Separately, I wonder if the new nested loop which checks both for the
> presence of maps and client->auth_err could be merged into the
> existing
> outer loop which currently checks for the presence of maps in the
> loop
> condition and client->auth_err here in the loop body.=C2=A0 Having a
> single
> loop with everything checked in just one place would be a lot
> cleaner.
>=20

Let me take a deeper look into the code. I hope I follow your point.

> > diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> > index 2110439f8a24..7b45c169a859 100644
> > --- a/net/ceph/debugfs.c
> > +++ b/net/ceph/debugfs.c
> > @@ -36,8 +36,10 @@ static int monmap_show(struct seq_file *s, void
> > *p)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_client *client =
=3D s->private;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&client->monc.mutex);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (client->monc.monmap =3D=
=3D NULL)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto out_unlock;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(s, "epoch %d\n", =
client->monc.monmap->epoch);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < client->mo=
nc.monmap->num_mon; i++) {
> > @@ -48,6 +50,10 @@ static int monmap_show(struct seq_file *s, void
> > *p)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ENTITY_NAME(inst->name),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ceph_pr_addr(&inst->addr));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +out_unlock:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&client->monc.mutex)=
;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > =C2=A0}
> >=20
> > @@ -56,13 +62,15 @@ static int osdmap_show(struct seq_file *s, void
> > *p)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_client *client =
=3D s->private;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_osd_client *osdc=
 =3D &client->osdc;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_osdmap *map =3D osdc-=
>osdmap;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_osdmap *map =3D NULL;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rb_node *n;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 down_read(&osdc->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map =3D osdc->osdmap;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (map =3D=3D NULL)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto out_unlock;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 down_read(&osdc->lock);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(s, "epoch %u barr=
ier %u flags 0x%x\n", map-
> > >epoch,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 osdc-=
>epoch_barrier, map->flags);
> >=20
> > @@ -131,6 +139,7 @@ static int osdmap_show(struct seq_file *s, void
> > *p)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 seq_printf(s, "]\n");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > +out_unlock:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 up_read(&osdc->lock);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > =C2=A0}
> > diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> > index ab66b599ac47..b299e5bbddb1 100644
> > --- a/net/ceph/mon_client.c
> > +++ b/net/ceph/mon_client.c
> > @@ -1232,6 +1232,7 @@ int ceph_monc_init(struct ceph_mon_client
> > *monc, struct ceph_client *cl)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_auth_destroy(monc->auth=
);
> > =C2=A0out_monmap:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(monc->monmap);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monc->monmap =3D NULL;
> > =C2=A0out:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
> > =C2=A0}
> > @@ -1239,6 +1240,8 @@ EXPORT_SYMBOL(ceph_monc_init);
> >=20
> > =C2=A0void ceph_monc_stop(struct ceph_mon_client *monc)
> > =C2=A0{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_monmap *old_monmap;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dout("stop\n");
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&monc->mutex);
> > @@ -1266,7 +1269,11 @@ void ceph_monc_stop(struct ceph_mon_client
> > *monc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_msg_put(monc->m_subscri=
be);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_msg_put(monc->m_subscri=
be_ack);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(monc->monmap);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&monc->mutex);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_monmap =3D monc->monmap;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monc->monmap =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&monc->mutex);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(old_monmap);
>=20
> The second point is that locking (or any changes at all) in
> ceph_monc_stop() and ceph_osdc_stop() shouldn't be needed.=C2=A0 As
> mentioned before, it's the point of no return where the entire client
> including monc and osdc parts gets freed very shortly after.
>=20

I see. You still dislike this locking logic here. :) OK. I can rework
it too.

Thanks,
Slava.

