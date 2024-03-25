Return-Path: <linux-fsdevel+bounces-15249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874CF88B028
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 20:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B64A302B19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 19:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4421BF2F;
	Mon, 25 Mar 2024 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g56R/uco"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8502E18EA1;
	Mon, 25 Mar 2024 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395441; cv=none; b=ImgjGqR4y3irzNHAlm3OyAB4suM5eWTlobMdPBS3F/1dAsHknTXdS1VD/VYo6oSZeAWtpVEPhrXfgBP0qLjNmZ4mx1SD9SU7GF6Rayp8f/MHT23mbpEtlfU8YCqHDVryUw5sFwIXC5BcxwvDd9vIEB2Bl6iyRx1BC7yUheABAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395441; c=relaxed/simple;
	bh=hsbC3daJJj5MZQZX3Vn6TiLijDDCKLP5QTkvRi3Kw14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bO/776tu0+IcCffJ2GVt+fnlkAQV8TqoTTqXYSFrHr6+5VEybp2KCuEmBF1WuSLHLZIbDINk9eoEeE60Uehm9NGWSrdFppfuxsQl4045zUxh6ok70loNRu344oWaNrnohINgD8/XsNpOEjdwSnuVCd7yFEHdPR3prf2DlhA19v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g56R/uco; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dc8b280155so2863692a34.0;
        Mon, 25 Mar 2024 12:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711395438; x=1712000238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90CH8AJ6hrKo9mJJq8CyynE7gOcGB4303/vwGgiZAY8=;
        b=g56R/ucoX0ZlRy1EymV45N47Knqpo/zx/w+hgStd9ppHkzaDg8OJePeIYB48n6ULa3
         thwPcsIZ/Yfev5nppawdgCVlSiHycaIfnn7bTKYqSd32ZYQz79F5Cjy+G3DHVJnTl8Ef
         5scUY7LXZdJySI6pRS3iI4+/RG78qyZyVQmz4NDaFjBCYrVysprfBcwR8TQVMiRXK1zj
         pcOQ+1fqCnIJ/dgdXUtgeNAWMlfQXYQG4lk05nj1tXw+UBhwCLpqRT2D/id/HP4SSgdN
         mhqdmKvkTdqDm8mO0byb5/BEa9+FYRnpzNYPduYXub72IX/Nn/P7WNcQOeIgMLwxXNCl
         rQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395438; x=1712000238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90CH8AJ6hrKo9mJJq8CyynE7gOcGB4303/vwGgiZAY8=;
        b=V7pJpipVxFJ4iNjhI947vEWljrTddreGWEC2LNt79AF8VLCw01qfQ0p7CMurvub6No
         PdXta9ejGM4B0URXkB9v/LugVUCS1wpOyisdzAUmXsDCJUGsuj2aVvR4Oaz4vQoo7Ong
         MTITaUQ5zPuigSYrKDhSVd1141bg4me/RV8ivdVuC1eETowXWv2HWCs7D2YyN6GpOAKe
         Y9lE3s3kHOqAOXwuuhVp1vQU6mVnDkb+ZpbffoOg36rt7bmFthSso58oUIRxzQ0qSYzT
         pN0LpmlI67nh6hHDxxcoCcAbLciAl4m5UNIPa9LwaIwuMsqiu2E9d855vAW6Tw+V9zHy
         QY7w==
X-Forwarded-Encrypted: i=1; AJvYcCXrL1vlrg8m32xmC/HkKjAy6Qf/kI5fNOyc9Q2DoLcL9Th1HCg53IbekWLFESglkYUvy/zDISX4AYQ16mDNG6AQmygDSs/AIGSzarBQe73EejWmj8ibdjKcQcC+nDrlQciGBm3F9R3+pfcULDLZGkyPhoAZXCGFnpfenSOMYG9AVtelCKql9kk=
X-Gm-Message-State: AOJu0YwhRVyoEvm3t3sMLxhEzWqqw1nM8ja+WU3AJjOhb3XxlJWJHYAp
	CSzE7gKfT14yb6XaavSI8J/EmZwkCCI9aKyUIna9RhEaP4MQzu87PxCOlO4ngbgNdcIeSqxg7H7
	MQvX1DXJPKzrYhH5OSe3SoBAwTAg=
X-Google-Smtp-Source: AGHT+IF3VDAGVGLUHUxQIydW0V+qUEjZ2t1sxmzA/I4vbE9BQVjOevbN/A3c+HXOFfjVcuvFf/i0ka6/7Cbn92GbWng=
X-Received: by 2002:a05:6870:1381:b0:229:f106:492d with SMTP id
 1-20020a056870138100b00229f106492dmr7018985oas.12.1711395438612; Mon, 25 Mar
 2024 12:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e119b3e2-09a0-47a7-945c-98a1f03633ef@redhat.com>
 <f453061e-6e01-4ad7-8fc6-a39108beacfc@redhat.com> <d689e8bf-6628-499e-8a11-c74ce1b1fd8b@redhat.com>
 <6f5b9d18-2d04-495c-970c-eb5eada5f676@redhat.com>
In-Reply-To: <6f5b9d18-2d04-495c-970c-eb5eada5f676@redhat.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 25 Mar 2024 20:37:06 +0100
Message-ID: <CAOi1vP-yf=VNLpcRPnd7qwxkgsxUpnZYKUx96pJr+WMQeLwyvA@mail.gmail.com>
Subject: Re: kernel BUG at mm/usercopy.c:102 -- pc : usercopy_abort
To: David Hildenbrand <david@redhat.com>
Cc: Xiubo Li <xiubli@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Ceph Development <ceph-devel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 6:39=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 25.03.24 13:06, Xiubo Li wrote:
> >
> > On 3/25/24 18:14, David Hildenbrand wrote:
> >> On 25.03.24 08:45, Xiubo Li wrote:
> >>> Hi guys,
> >>>
> >>> We are hitting the same crash frequently recently with the latest ker=
nel
> >>> when testing kceph, and the call trace will be something likes:
> >>>
> >>> [ 1580.034891] usercopy: Kernel memory exposure attempt detected from
> >>> SLUB object 'kmalloc-192' (offset 82, size 499712)!^M
> >>> [ 1580.045866] ------------[ cut here ]------------^M
> >>> [ 1580.050551] kernel BUG at mm/usercopy.c:102!^M
> >>> ^M
> >>> Entering kdb (current=3D0xffff8881211f5500, pid 172901) on processor =
4
> >>> Oops: (null)^M
> >>> due to oops @ 0xffffffff8138cabd^M
> >>> CPU: 4 PID: 172901 Comm: fsstress Tainted: G S 6.6.0-g623393c9d50c #1=
^M
> >>> Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 1.0c 09/07/2015=
^M
> >>> RIP: 0010:usercopy_abort+0x6d/0x80^M
> >>> Code: 4c 0f 44 d0 41 53 48 c7 c0 1c e9 13 82 48 c7 c6 71 62 13 82 48 =
0f
> >>> 45 f0 48 89 f9 48 c7 c7 f0 6b 1b 82 4c 89 d2 e8 63 2b df ff <0f> 0b 4=
9
> >>> c7 c1 44 c8 14 82 4d 89 cb 4d 89 c8 eb a5 66 90 f3 0f 1e^M
> >>> RSP: 0018:ffffc90006dfba88 EFLAGS: 00010246^M
> >>> RAX: 000000000000006a RBX: 000000000007a000 RCX: 0000000000000000^M
> >>> RDX: 0000000000000000 RSI: ffff88885fd1d880 RDI: ffff88885fd1d880^M
> >>> RBP: 000000000007a000 R08: 0000000000000000 R09: c0000000ffffdfff^M
> >>> R10: 0000000000000001 R11: ffffc90006dfb930 R12: 0000000000000001^M
> >>> R13: ffff8882b7bbed12 R14: ffff88827a375830 R15: ffff8882b7b44d12^M
> >>> FS:  00007fb24c859500(0000) GS:ffff88885fd00000(0000)
> >>> knlGS:0000000000000000^M
> >>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
> >>> CR2: 000055c2bcf9eb00 CR3: 000000028956c005 CR4: 00000000001706e0^M
> >>> Call Trace:^M
> >>>     <TASK>^M
> >>>     ? kdb_main_loop+0x32c/0xa10^M
> >>>     ? kdb_stub+0x216/0x420^M
> >>> more>
> >>>
> >>> You can see more detail in ceph tracker
> >>> https://tracker.ceph.com/issues/64471.
> >>
> >> Where is the full backtrace? Above contains only the backtrace of kdb.
> >>
> > Hi David,
> >
> > The bad news is that there is no more backtrace. All the failures we hi=
t
> > are similar with the following logs:
> >
>
> That's unfortunate :/
>
> "exposure" in the message means we are in copy_to_user().
>
> SLUB object 'kmalloc-192' means that we come from __check_heap_object()
> ... we have 192 bytes, but the length we want to access is 499712 ...
> 488 KiB.
>
> So we ended  up somehow in
>
> __copy_to_user()->check_object_size()->__check_object_size()->
> check_heap_object()->__check_heap_object()->usercopy_abort()
>
>
> ... but the big question is which code tried to copy way too much memory
> out of a slab folio to user space.
>
> >
> >> That link also contains:
> >>
> >> Entering kdb (current=3D0xffff9115d14fb980, pid 61925) on processor 5
> >> Oops: (null)^M
> >> due to oops @ 0xfffffffface3a1d2^M
> >> CPU: 5 PID: 61925 Comm: ld Kdump: loaded Not tainted
> >> 5.14.0-421.el9.x86_64 #1^M
> >> Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 2.0 12/17/2015^M
> >> RIP: 0010:usercopy_abort+0x74/0x76^M
> >> Code: 14 74 ad 51 48 0f 44 d6 49 c7 c3 cb 9f 73 ad 4c 89 d1 57 48 c7
> >> c6 60 83 75 ad 48 c7 c7 00 83 75 ad 49 0f 44 f3 e8 1b 3b ff ff <0f> 0b
> >> 0f b6 d3 4d 89 e0 48 89 e9 31 f6 48 c7 c7 7f 83 75 ad e8 73^M
> >> RSP: 0018:ffffbb97c16af8d0 EFLAGS: 00010246^M
> >> RAX: 0000000000000072 RBX: 0000000000000112 RCX: 0000000000000000^M
> >> RDX: 0000000000000000 RSI: ffff911d1fd60840 RDI: ffff911d1fd60840^M
> >> RBP: 0000000000004000 R08: 80000000ffff84b4 R09: 0000000000ffff0a^M
> >> R10: 0000000000000004 R11: 0000000000000076 R12: ffff9115c0be8b00^M
> >> R13: 0000000000000001 R14: ffff911665df9f68 R15: ffff9115d16be112^M
> >> FS:  00007ff20442eb80(0000) GS:ffff911d1fd40000(0000)
> >> knlGS:0000000000000000^M
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
> >> CR2: 00007ff20446142d CR3: 00000001215ec003 CR4: 00000000003706e0^M
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000^M
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400^M
> >> Call Trace:^M
> >>   <TASK>^M
> >>   ? show_trace_log_lvl+0x1c4/0x2df^M
>
>
> ... are we stuck in show_trace_log_lvl(), probably deadlocked not being
> able to print the actuall callstack? If so, that's nasty.

Hi David,

I don't think so.  This appears to be a cut-and-paste from what is
essentially a non-interactive serial console.  Stack trace entries
prefixed with ? aren't exact and kdb prompt

    more>

is there in all cases which is what hides the rest of the stack.

There are four ways to get the entire stack trace here:

a) try to attach to the serial console and interact with kdb -- this
   is very much hit or miss due to general IPMI/BMC unreliability and
   the fact that it would be already attached to for logging
b) disable kdb by passing "kdb: false" in the job definition -- this
   should result in /sys/module/kgdboc/parameters/kgdboc cleared after
   booting into the kernel under test (or just hack teuthology to not
   pass "kdb: true" which it does by default if "-k <kernel>" is given
   when scheduling)
c) if b) fails, rebuild the kernel with kdb disabled in Kconfig
d) configure kdump and grab a vmcore -- these is no teuthology support
   for this, so it would be challenging but would provide the most data
   to chew on

Xiubo, I'd recommend going with b), but take your pick ;)

Thanks,

                Ilya

