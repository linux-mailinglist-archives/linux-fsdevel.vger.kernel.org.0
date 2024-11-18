Return-Path: <linux-fsdevel+bounces-35151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098B09D1ADB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 22:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6011FB222A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 21:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402351E7C26;
	Mon, 18 Nov 2024 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J47VDU1O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B42150981
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731966964; cv=none; b=jdBQU/L3LT9etW7bVtgiqKr/Z+6IeeJhLWg936zBQ/TKLhaw63WsCYhYb7Y2t1AJuCT9j4YGCFui9dRezTNtvFQXcqP5ykO22wJmMLeJUmQoyHxdKMNMYPfZes/QmN1e8gTLW6SEzrj5Jf+qk5QFE5FNl9/25vDaUErkPCTzecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731966964; c=relaxed/simple;
	bh=dFqGuN73NKg5Ul2YHfrkoQvbXBHxCp2XwiECgctCa7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pD5KF3EC9eodUp3knp3O+dj+ZLekUjfUkX+BFSZjPlWux2/Xw/hR+bZZ6tgONxijfVikOUaxFbwbEGkONYNAoO4bVu5LJt+u6b+fkmlkxUzte76qwRwNq/H/bBmie+ljIa+d+WL2DmvWT0+sAu54y7HSrmxya0yG1QXhcXmLjNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J47VDU1O; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cfb81a0af9so3356a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 13:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731966961; x=1732571761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcPakxF9jKHtjtmBhR2QQPFYJaNPHuWfmL+ZcLJedzc=;
        b=J47VDU1OeDNjrsSniG5XqybBofPtkSQlSPnaEoJudBnWlNdOIy7pi9sUhPjE3d1EUB
         qsYFOWbr39HFSAH4X68uRNb2lJKln6nb2l3RtYZ973mMRXvBwlNgnfvvPZ9AYRzYC/G8
         F8eyvOHPeAiUcNpnVGT4/BphotyMnMxNEMix6aA3Me5PyL63xYgP4wwevTKVwpsadYqX
         GD/kmkCenBEGYdFgIuNQfGn2xMTwEMKeNbfZ4gPaUSMrXa9ry7V3+4gJHwi/uOk4Olh0
         MD+7ajqFBj15ABmgGhhhnSMP3ZCtxkcELssNLgV8KFgurJpXBEd4+fSmk3bwc+ya8TqD
         bzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731966961; x=1732571761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcPakxF9jKHtjtmBhR2QQPFYJaNPHuWfmL+ZcLJedzc=;
        b=YYQk03Jk1FhLvr5+mOijSbhqNHrvc8Pp42eFPhlC91gp+N8fenWwAkBSSKLbKV5Xcb
         +DmoFZgp2rcDouWzDqmswMZ0H8nfOVh22yQjUIKwv6NQlkt5CCgHmRaUkNgr4mk6xXuN
         2/6R+tHQYZ3D6MkUplAV9oXfNtLoEpSRX+6Zs2fbhumOnik06Xtj3XV40ujSb8W7W6d8
         nB1L0g+d6SB7DaZ4IzQAMIddJwu/nNBHyUFzlaDytiVnUDr48xf9XTdF4xXM2Ns6MmeL
         lSxmti+AANymKwfL8Ssu1OM1f35m3hb698jEvOLf7JP7r8KWnG+Xsu9gehvB3XKoLSa7
         wlwA==
X-Forwarded-Encrypted: i=1; AJvYcCXIDJJltvjW4k47CiSEcyHjkpIOzmwFlQJnqepTB8MLNsYG2vT7h4tDocGHhgeDhV7tw/S5U4ZQxmFnjheJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhvh/Z1jvSs0yijjiinSe4aAmjikD0xfXC6nBrdQ95OWE7yDdA
	MSaK1L6Dx2+ByUAMiAxCtLJuW7sFqOxlmoU+XmVT4d4e/GYlb1J+sUmt0qsJAvfFXdYatDLJoCV
	oY6rJmj3Qg6sSqZX5+IG3wLVb3lAz+ncu3Prr
X-Gm-Gg: ASbGncuSLE9NOhsko1cRxc+fvyAtRekUJUlPrn42QmaY7HG/0Of4E7VfeQ7SIKpELRs
	bCqC6IRb29sl+5q84MwBrlQmD737ryuLabb4OlyDZb0pjuVCvbmQFNl00X8c9
X-Google-Smtp-Source: AGHT+IEmQBLeCGEVSsJbyVXTx3ofqhXea4Wqz/7DGUro15QCcR8ixmXK0vAE1L66ZK1G6ThZtJ4ySWriaqF8oPGf1vk=
X-Received: by 2002:aa7:dac4:0:b0:5cf:4994:501d with SMTP id
 4fb4d7f45d1cf-5cfdfc082ddmr14414a12.3.1731966960689; Mon, 18 Nov 2024
 13:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com> <20241116175922.3265872-5-pasha.tatashin@soleen.com>
In-Reply-To: <20241116175922.3265872-5-pasha.tatashin@soleen.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 18 Nov 2024 22:55:24 +0100
Message-ID: <CAG48ez10dYpom22cQNgj62wkztbjpJiuuSroE5BahNkpnN-y3Q@mail.gmail.com>
Subject: Re: [RFCv1 4/6] misc/page_detective: Introduce Page Detective
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, shuah@kernel.org, 
	vegard.nossum@oracle.com, vattunuru@marvell.com, schalla@marvell.com, 
	david@redhat.com, willy@infradead.org, osalvador@suse.de, 
	usama.anjum@collabora.com, andrii@kernel.org, ryan.roberts@arm.com, 
	peterx@redhat.com, oleg@redhat.com, tandersen@netflix.com, 
	rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 6:59=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
> Page Detective is a kernel debugging tool that provides detailed
> information about the usage and mapping of physical memory pages.
>
> It operates through the Linux debugfs interface, providing access
> to both virtual and physical address inquiries. The output, presented
> via kernel log messages (accessible with dmesg), will help
> administrators and developers understand how specific pages are
> utilized by the system.
>
> This tool can be used to investigate various memory-related issues,
> such as checksum failures during live migration, filesystem journal
> failures, general segfaults, or other corruptions.
[...]
> +/*
> + * Walk kernel page table, and print all mappings to this pfn, return 1 =
if
> + * pfn is mapped in direct map, return 0 if not mapped in direct map, an=
d
> + * return -1 if operation canceled by user.
> + */
> +static int page_detective_kernel_map_info(unsigned long pfn,
> +                                         unsigned long direct_map_addr)
> +{
> +       struct pd_private_kernel pr =3D {0};
> +       unsigned long s, e;
> +
> +       pr.direct_map_addr =3D direct_map_addr;
> +       pr.pfn =3D pfn;
> +
> +       for (s =3D PAGE_OFFSET; s !=3D ~0ul; ) {
> +               e =3D s + PD_WALK_MAX_RANGE;
> +               if (e < s)
> +                       e =3D ~0ul;
> +
> +               if (walk_page_range_kernel(s, e, &pd_kernel_ops, &pr)) {

I think which parts of the kernel virtual address range you can safely
pagewalk is somewhat architecture-specific; for example, X86 can run
under Xen PV, in which case I think part of the page tables may not be
walkable because they're owned by the hypervisor for its own use?
Notably the x86 version of ptdump_walk_pgd_level_core starts walking
at GUARD_HOLE_END_ADDR instead.

See also https://kernel.org/doc/html/latest/arch/x86/x86_64/mm.html
for an ASCII table reference on address space regions.

> +                       pr_info("Received a cancel signal from user, whil=
e scanning kernel mappings\n");
> +                       return -1;
> +               }
> +               cond_resched();
> +               s =3D e;
> +       }
> +
> +       if (!pr.vmalloc_maps) {
> +               pr_info("The page is not mapped into kernel vmalloc area\=
n");
> +       } else if (pr.vmalloc_maps > 1) {
> +               pr_info("The page is mapped into vmalloc area: %ld times\=
n",
> +                       pr.vmalloc_maps);
> +       }
> +
> +       if (!pr.direct_map)
> +               pr_info("The page is not mapped into kernel direct map\n"=
);
> +
> +       pr_info("The page mapped into kernel page table: %ld times\n", pr=
.maps);
> +
> +       return pr.direct_map ? 1 : 0;
> +}
> +
> +/* Print kernel information about the pfn, return -1 if canceled by user=
 */
> +static int page_detective_kernel(unsigned long pfn)
> +{
> +       unsigned long *mem =3D __va((pfn) << PAGE_SHIFT);
> +       unsigned long sum =3D 0;
> +       int direct_map;
> +       u64 s, e;
> +       int i;
> +
> +       s =3D sched_clock();
> +       direct_map =3D page_detective_kernel_map_info(pfn, (unsigned long=
)mem);
> +       e =3D sched_clock() - s;
> +       pr_info("Scanned kernel page table in [%llu.%09llus]\n",
> +               e / NSEC_PER_SEC, e % NSEC_PER_SEC);
> +
> +       /* Canceled by user or no direct map */
> +       if (direct_map < 1)
> +               return direct_map;
> +
> +       for (i =3D 0; i < PAGE_SIZE / sizeof(unsigned long); i++)
> +               sum |=3D mem[i];

If the purpose of this interface is to inspect pages in weird states,
I wonder if it would make sense to use something like
copy_mc_to_kernel() in case that helps avoid kernel crashes due to
uncorrectable 2-bit ECC errors or such. But maybe that's not the kind
of error you're concerned about here? And I also don't have any idea
if copy_mc_to_kernel() actually does anything sensible for ECC errors.
So don't treat this as a fix suggestion, more as a random idea that
should probably be ignored unless someone who understands ECC errors
says it makes sense.

But I think you should at least be using READ_ONCE(), since you're
reading from memory that can change concurrently.

> +       if (sum =3D=3D 0)
> +               pr_info("The page contains only zeroes\n");
> +       else
> +               pr_info("The page contains some data\n");
> +
> +       return 0;
> +}
[...]
> +/*
> + * print information about mappings of pfn by mm, return -1 if canceled
> + * return number of mappings found.
> + */
> +static long page_detective_user_mm_info(struct mm_struct *mm, unsigned l=
ong pfn)
> +{
> +       struct pd_private_user pr =3D {0};
> +       unsigned long s, e;
> +
> +       pr.pfn =3D pfn;
> +       pr.mm =3D mm;
> +
> +       for (s =3D 0; s !=3D TASK_SIZE; ) {

TASK_SIZE does not make sense when inspecting another task, because
TASK_SIZE depends on the virtual address space size of the current
task (whether you are a 32-bit or 64-bit process). Please use
TASK_SIZE_MAX for remote process access.

> +               e =3D s + PD_WALK_MAX_RANGE;
> +               if (e > TASK_SIZE || e < s)
> +                       e =3D TASK_SIZE;
> +
> +               if (mmap_read_lock_killable(mm)) {
> +                       pr_info("Received a cancel signal from user, whil=
e scanning user mappings\n");
> +                       return -1;
> +               }
> +               walk_page_range(mm, s, e, &pd_user_ops, &pr);
> +               mmap_read_unlock(mm);
> +               cond_resched();
> +               s =3D e;
> +       }
> +       return pr.maps;
> +}

