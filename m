Return-Path: <linux-fsdevel+bounces-46723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB12A944AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 18:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB083BC32C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 16:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7452B1DFE20;
	Sat, 19 Apr 2025 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaTzX5kK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEAE3595C;
	Sat, 19 Apr 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745080435; cv=none; b=UK1aL71eoNUSZmTSHjBF8QO9dc9PxOUYbcMANA0w46Y2gwU7w1APhsJW8asLCbqZ3ZmrKkJ8LMSIEQPvqMKPowxGbU7kYCYPVemN2gMHqv/zGeUeT8Ssl4fS7ahjQF6+kEkrrCtPrInKslr0Fd1vOO4JMvuvd0LOfTcI/RCnoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745080435; c=relaxed/simple;
	bh=zeikM7q8nt9Cnfm43oJ4ZdAOO+q9/IXexiXqIs21+Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfweyLsytIe4VKiQulpZsRWUR38moA6s0P21vHoADRkZwOFmMKqaeM6IUWjOGIKsjaWTLUMG47fVLOmxgFHiAWQyw30X6zOVSLEichdi+M6+JPzFgLRrfnP330wJsIbu/w2eA0OzvwSOV9s2CXEw6zexgO1q8RsOQKdzWTl212E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaTzX5kK; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54d65eb26b2so2461301e87.2;
        Sat, 19 Apr 2025 09:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745080432; x=1745685232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7G+GIZNarc3SHoXMoseZHYLu7UGj4EQrIMKm2cXpml0=;
        b=aaTzX5kKvGI4EoRcrTh6gA/nUE2GmGmJzCjMFxYu7w+4a2Tgjlx85cB9/ZyuPiFzSB
         FVcdTz4w9ahlC3YOvES5QZV34U397omTpBWhD3l99EnUZWoh8/Hwatvnk2yA+hPhOXdL
         5Wv1GRchXorz5EsZfBVqPQGG7LyOqQjxmbAbZNkAGnbQbXRIEVuVtlOG9S8D3S0O/XE4
         p4ZAaPtM5U9u49I96Xybt3qYKyskw9S/l0AD9yl03dCEIcrMXYmf0+P5ecEJtq1Phqqy
         NDai/3gywYHd2eHm6wAXsA+W6V8t9ZV6kCU7QHAU00RoCyNPdLVPDsnEcOoNFi5f5NJ+
         9wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745080432; x=1745685232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7G+GIZNarc3SHoXMoseZHYLu7UGj4EQrIMKm2cXpml0=;
        b=C9/+W0vy+bxZe9hcw+lazSzF8LCFNhtohlqOqU8jXjJfEnJVIkHmTc65oWMm2Tjc/R
         DoEz9vwbs4OPJQe9BNLm/jxvS9g1TSLUI3WLjXlRE5bw4TR2FViIsd15LDShqjjroUpU
         cJmYsavKOh8RBd9/eNZ6DAKTjIOcc0ICulCCyLzQfeyLpTAMLqooI6VaCJjEJk2fDw6t
         I3keTTVUcOuBRrOEc621sCbyBkkDdHz0/JcECDrL4INgvYhMBv0rgb39ZN7AKrfIxRJf
         CmRKSCGXuX090/7ZcSl4+Uz34ga0mzz2Dbl8SdKkzt5UfgDdEN9MaJ0FnNge+bi5eTVV
         29fQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0g2I2ozrmMECr3m9rGS7crINIHfifTGWEupw7/rRkiE1AUnkCf+mDBkq/7vhRvItqrRlo+AtBpnsf@vger.kernel.org, AJvYcCVX2gtfxJlKTZpajDLOpPkXH1JjhG/np5C3UKhcJRB6hZLlDp30rpnsmepiNpblb/r0CJrSvgka34TL@vger.kernel.org, AJvYcCWdEfJHDNP9cK3fJtazl864UsPlIp6raH/6usxGCuzW/GaEW7LqHMZ86sEMc4t1DUjtvmbPP13m@vger.kernel.org, AJvYcCWpmsSnbwnbS/40kTcPF1myOQEnYYygOgwtyM0XjIYpEV5Nty+8bM0PbuGMSO0ufOAtkJ0jG9YtqroHVHhw5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZDE+gCI8dEwXzUG6xB8BTFAuf8IzojmvQ52+LYZtCUgFYa3Mi
	/UhZBtKxy8h09qxJj/1rwZVdhHKFZroeH1ZQt9dJK1FeUEk/oK1CI1WOwZrDBWl8Lx9RK168FOj
	UaOMgtVKoATaguGqX9LneDfBJafc=
X-Gm-Gg: ASbGncvlxudxTi/ehwzx5ow1Yc2avrpInnT0hOjouKqYLYbHfjEglR8wmoYkTWfbcyL
	Y+8UQ+dygfnzEHA+NV7TPjYjQ0nFHms6qsYDqvEwisclNYILI/ZVCCol4Ma0XGGkX9kE4BTzZuk
	R8Qyb2G/KkqcwvEFJ0IFHuJA==
X-Google-Smtp-Source: AGHT+IEWvft2ookxtDiV7Uwop5ebC5INPd5L7jdy0dsyDGnurVaekeNdA7/VNKhd/bKNxw2lUi1147ljR7qwNzyrDTA=
X-Received: by 2002:a05:6512:118b:b0:545:c7d:1791 with SMTP id
 2adb3069b0e04-54d6e663ee5mr1704791e87.43.1745080431264; Sat, 19 Apr 2025
 09:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303163014.1128035-1-david@redhat.com> <20250303163014.1128035-14-david@redhat.com>
 <CAMgjq7D+ea3eg9gRCVvRnto3Sv3_H3WVhupX4e=k8T5QAfBHbw@mail.gmail.com> <c7e85336-5e34-4dd9-950f-173f48ff0be1@redhat.com>
In-Reply-To: <c7e85336-5e34-4dd9-950f-173f48ff0be1@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 20 Apr 2025 00:33:34 +0800
X-Gm-Features: ATxdqUFwMuyqe8OWkCceLCpNh3dlMS_fBv5LDlIGCufhQHJV96svfzO18XX-ZUI
Message-ID: <CAMgjq7DMpOMAi8Y9Db43P=4g7V5JPBb4E6sA_n5Rp8Y+34AjQQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/20] mm: Copy-on-Write (COW) reuse support for
 PTE-mapped THP
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Muchun Song <muchun.song@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2025 at 12:26=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 19.04.25 18:02, Kairui Song wrote:
> > On Tue, Mar 4, 2025 at 12:46=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> Currently, we never end up reusing PTE-mapped THPs after fork. This
> >> wasn't really a problem with PMD-sized THPs, because they would have t=
o
> >> be PTE-mapped first, but it's getting a problem with smaller THP
> >> sizes that are effectively always PTE-mapped.
> >>
> >> With our new "mapped exclusively" vs "maybe mapped shared" logic for
> >> large folios, implementing CoW reuse for PTE-mapped THPs is straight
> >> forward: if exclusively mapped, make sure that all references are
> >> from these (our) mappings. Add some helpful comments to explain the
> >> details.
> >>
> >> CONFIG_TRANSPARENT_HUGEPAGE selects CONFIG_MM_ID. If we spot an anon
> >> large folio without CONFIG_TRANSPARENT_HUGEPAGE in that code, somethin=
g
> >> is seriously messed up.
> >>
> >> There are plenty of things we can optimize in the future: For example,=
 we
> >> could remember that the folio is fully exclusive so we could speedup
> >> the next fault further. Also, we could try "faulting around", turning
> >> surrounding PTEs that map the same folio writable. But especially the
> >> latter might increase COW latency, so it would need further
> >> investigation.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>   mm/memory.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++----=
--
> >>   1 file changed, 75 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 73b783c7d7d51..bb245a8fe04bc 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -3729,19 +3729,86 @@ static vm_fault_t wp_page_shared(struct vm_fau=
lt *vmf, struct folio *folio)
> >>          return ret;
> >>   }
> >>
> >> -static bool wp_can_reuse_anon_folio(struct folio *folio,
> >> -                                   struct vm_area_struct *vma)
> >> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> +static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
> >> +               struct vm_area_struct *vma)
> >>   {
> >> +       bool exclusive =3D false;
> >> +
> >> +       /* Let's just free up a large folio if only a single page is m=
apped. */
> >> +       if (folio_large_mapcount(folio) <=3D 1)
> >> +               return false;
> >> +
> >>          /*
> >> -        * We could currently only reuse a subpage of a large folio if=
 no
> >> -        * other subpages of the large folios are still mapped. Howeve=
r,
> >> -        * let's just consistently not reuse subpages even if we could
> >> -        * reuse in that scenario, and give back a large folio a bit
> >> -        * sooner.
> >> +        * The assumption for anonymous folios is that each page can o=
nly get
> >> +        * mapped once into each MM. The only exception are KSM folios=
, which
> >> +        * are always small.
> >> +        *
> >> +        * Each taken mapcount must be paired with exactly one taken r=
eference,
> >> +        * whereby the refcount must be incremented before the mapcoun=
t when
> >> +        * mapping a page, and the refcount must be decremented after =
the
> >> +        * mapcount when unmapping a page.
> >> +        *
> >> +        * If all folio references are from mappings, and all mappings=
 are in
> >> +        * the page tables of this MM, then this folio is exclusive to=
 this MM.
> >>           */
> >> -       if (folio_test_large(folio))
> >> +       if (folio_test_large_maybe_mapped_shared(folio))
> >> +               return false;
> >> +
> >> +       VM_WARN_ON_ONCE(folio_test_ksm(folio));
> >> +       VM_WARN_ON_ONCE(folio_mapcount(folio) > folio_nr_pages(folio))=
;
> >> +       VM_WARN_ON_ONCE(folio_entire_mapcount(folio));
> >> +
> >> +       if (unlikely(folio_test_swapcache(folio))) {
> >> +               /*
> >> +                * Note: freeing up the swapcache will fail if some PT=
Es are
> >> +                * still swap entries.
> >> +                */
> >> +               if (!folio_trylock(folio))
> >> +                       return false;
> >> +               folio_free_swap(folio);
> >> +               folio_unlock(folio);
> >> +       }
> >> +
> >> +       if (folio_large_mapcount(folio) !=3D folio_ref_count(folio))
> >>                  return false;
> >>
> >> +       /* Stabilize the mapcount vs. refcount and recheck. */
> >> +       folio_lock_large_mapcount(folio);
> >> +       VM_WARN_ON_ONCE(folio_large_mapcount(folio) < folio_ref_count(=
folio));
> >
> > Hi David, I'm seeing this WARN_ON being triggered on my test machine:
>
> Hi!
>
> So I assume the following will not sort out the issue for you, correct?
>
> https://lore.kernel.org/all/20250415095007.569836-1-david@redhat.com/T/#u

Yes, double checked the commit I'm testing
dc683247117ee018e5da6b04f1c499acdc2a1418 (akpm/mm-unstable) includes
this fix.

>
> >
> > I'm currently working on my swap table series and testing heavily with
> > swap related workloads. I thought my patch may break the kernel, but
> > after more investigation and reverting to current mm-unstable, it
> > still occurs (with a much lower chance though, I think my series
> > changed the timing so it's more frequent in my case).
> >
> > The test is simple, I just enable all mTHP sizes and repeatedly build
> > linux kernel in a 1G memcg using tmpfs.
> >
> > The WARN is reproducible with current mm-unstable
> > (dc683247117ee018e5da6b04f1c499acdc2a1418):
> >
> > [ 5268.100379] ------------[ cut here ]------------
> > [ 5268.105925] WARNING: CPU: 2 PID: 700274 at mm/memory.c:3792
> > do_wp_page+0xfc5/0x1080
> > [ 5268.112437] Modules linked in: zram virtiofs
> > [ 5268.115507] CPU: 2 UID: 0 PID: 700274 Comm: cc1 Kdump: loaded Not
> > tainted 6.15.0-rc2.ptch-gdc683247117e #1434 PREEMPT(voluntary)
> > [ 5268.120562] Hardware name: Red Hat KVM/RHEL-AV, BIOS 0.0.0 02/06/201=
5
> > [ 5268.123025] RIP: 0010:do_wp_page+0xfc5/0x1080
> > [ 5268.124807] Code: 0d 80 77 32 02 0f 85 3e f1 ff ff 0f 1f 44 00 00
> > e9 34 f1 ff ff 48 0f ba 75 00 1f 65 ff 0d 63 77 32 02 0f 85 21 f1 ff
> > ff eb e1 <0f> 0b e9 10 fd ff ff 65 ff 00 f0 48 0f b
> > a 6d 00 1f 0f 83 ec fc ff
> > [ 5268.132034] RSP: 0000:ffffc900234efd48 EFLAGS: 00010297
> > [ 5268.134002] RAX: 0000000000000080 RBX: 0000000000000000 RCX: 000ffff=
fffe00000
> > [ 5268.136609] RDX: 0000000000000081 RSI: 00007f009cbad000 RDI: ffffea0=
012da0000
> > [ 5268.139371] RBP: ffffea0012da0068 R08: 80000004b682d025 R09: 00007f0=
09c7c0000
> > [ 5268.142183] R10: ffff88839c48b8c0 R11: 0000000000000000 R12: ffff888=
39c48b8c0
> > [ 5268.144738] R13: ffffea0012da0000 R14: 00007f009cbadf10 R15: ffffc90=
0234efdd8
> > [ 5268.147540] FS:  00007f009d1fdac0(0000) GS:ffff88a07ae14000(0000)
> > knlGS:0000000000000000
> > [ 5268.150715] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 5268.153270] CR2: 00007f009cbadf10 CR3: 000000016c7c0001 CR4: 0000000=
000770eb0
> > [ 5268.155674] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [ 5268.158100] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [ 5268.160613] PKRU: 55555554
> > [ 5268.161662] Call Trace:
> > [ 5268.162609]  <TASK>
> > [ 5268.163438]  ? ___pte_offset_map+0x1b/0x110
> > [ 5268.165309]  __handle_mm_fault+0xa51/0xf00
> > [ 5268.166848]  ? update_load_avg+0x80/0x760
> > [ 5268.168376]  handle_mm_fault+0x13d/0x360
> > [ 5268.169930]  do_user_addr_fault+0x2f2/0x7f0
> > [ 5268.171630]  exc_page_fault+0x6a/0x140
> > [ 5268.173278]  asm_exc_page_fault+0x26/0x30
> > [ 5268.174866] RIP: 0033:0x120e8e4
> > [ 5268.176272] Code: 84 a9 00 00 00 48 39 c3 0f 85 ae 00 00 00 48 8b
> > 43 20 48 89 45 38 48 85 c0 0f 85 b7 00 00 00 48 8b 43 18 48 8b 15 6c
> > 08 42 01 <0f> 11 43 10 48 89 1d 61 08 42 01 48 89 53 18 0f 11 03 0f 11
> > 43 20
> > [ 5268.184121] RSP: 002b:00007fff8a855160 EFLAGS: 00010246
> > [ 5268.186343] RAX: 00007f009cbadbd0 RBX: 00007f009cbadf00 RCX: 0000000=
000000000
> > [ 5268.189209] RDX: 00007f009cbba030 RSI: 00000000000006f4 RDI: 0000000=
000000000
> > [ 5268.192145] RBP: 00007f009cbb6460 R08: 00007f009d10f000 R09: 0000000=
00000016c
> > [ 5268.194687] R10: 0000000000000000 R11: 0000000000000010 R12: 00007f0=
09cf97660
> > [ 5268.197172] R13: 00007f009756ede0 R14: 00007f0097582348 R15: 0000000=
000000002
> > [ 5268.199419]  </TASK>
> > [ 5268.200227] ---[ end trace 0000000000000000 ]---
> >
> > I also once changed the WARN_ON to WARN_ON_FOLIO and I got more info he=
re:
> >
> > [ 3994.907255] page: refcount:9 mapcount:1 mapping:0000000000000000
> > index:0x7f90b3e98 pfn:0x615028
> > [ 3994.914449] head: order:3 mapcount:8 entire_mapcount:0
> > nr_pages_mapped:8 pincount:0
> > [ 3994.924534] memcg:ffff888106746000
> > [ 3994.927868] anon flags:
> > 0x17ffffc002084c(referenced|uptodate|owner_2|head|swapbacked|node=3D0|z=
one=3D2|lastcpupid=3D0x1fffff)
> > [ 3994.933479] raw: 0017ffffc002084c ffff88816edd9128 ffffea000beac108
> > ffff8882e8ba6bc9
> > [ 3994.936251] raw: 00000007f90b3e98 0000000000000000 0000000900000000
> > ffff888106746000
> > [ 3994.939466] head: 0017ffffc002084c ffff88816edd9128
> > ffffea000beac108 ffff8882e8ba6bc9
> > [ 3994.943355] head: 00000007f90b3e98 0000000000000000
> > 0000000900000000 ffff888106746000
> > [ 3994.946988] head: 0017ffffc0000203 ffffea0018540a01
> > 0000000800000007 00000000ffffffff
> > [ 3994.950328] head: ffffffff00000007 00000000800000a3
> > 0000000000000000 0000000000000008
> > [ 3994.953684] page dumped because:
> > VM_WARN_ON_FOLIO(folio_large_mapcount(folio) < folio_ref_count(folio))
> > [ 3994.957534] ------------[ cut here ]------------
> > [ 3994.959917] WARNING: CPU: 16 PID: 555282 at mm/memory.c:3794
> > do_wp_page+0x10c0/0x1110
> > [ 3994.963069] Modules linked in: zram virtiofs
> > [ 3994.964726] CPU: 16 UID: 0 PID: 555282 Comm: sh Kdump: loaded Not
> > tainted 6.15.0-rc1.ptch-ge39aef85f4c0-dirty #1431 PREEMPT(voluntary)
> > [ 3994.969985] Hardware name: Red Hat KVM/RHEL-AV, BIOS 0.0.0 02/06/201=
5
> > [ 3994.972905] RIP: 0010:do_wp_page+0x10c0/0x1110
> > [ 3994.974477] Code: fe ff 0f 0b bd f5 ff ff ff e9 16 fb ff ff 41 83
> > a9 bc 12 00 00 01 e9 2f fb ff ff 48 c7 c6 90 c2 49 82 4c 89 ef e8 40
> > fd fe ff <0f> 0b e9 6a fc ff ff 65 ff 00 f0 48 0f b
> > a 6d 00 1f 0f 83 46 fc ff
> > [ 3994.981033] RSP: 0000:ffffc9002b3c7d40 EFLAGS: 00010246
> > [ 3994.982636] RAX: 000000000000005b RBX: 0000000000000000 RCX: 0000000=
000000000
> > [ 3994.984778] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff889=
ffea16a80
> > [ 3994.986865] RBP: ffffea0018540a68 R08: 0000000000000000 R09: c000000=
0ffff7fff
> > [ 3994.989316] R10: 0000000000000001 R11: ffffc9002b3c7b80 R12: ffff888=
10cfd7d40
> > [ 3994.991654] R13: ffffea0018540a00 R14: 00007f90b3e9d620 R15: ffffc90=
02b3c7dd8
> > [ 3994.994076] FS:  00007f90b3caa740(0000) GS:ffff88a07b194000(0000)
> > knlGS:0000000000000000
> > [ 3994.996939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 3994.998902] CR2: 00007f90b3e9d620 CR3: 0000000104088004 CR4: 0000000=
000770eb0
> > [ 3995.001314] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [ 3995.003746] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [ 3995.006173] PKRU: 55555554
> > [ 3995.007117] Call Trace:
> > [ 3995.007988]  <TASK>
> > [ 3995.008755]  ? __pfx_default_wake_function+0x10/0x10
> > [ 3995.010490]  ? ___pte_offset_map+0x1b/0x110
> > [ 3995.011929]  __handle_mm_fault+0xa51/0xf00
> > [ 3995.013346]  handle_mm_fault+0x13d/0x360
> > [ 3995.014796]  do_user_addr_fault+0x2f2/0x7f0
> > [ 3995.016331]  ? sigprocmask+0x77/0xa0
> > [ 3995.017656]  exc_page_fault+0x6a/0x140
> > [ 3995.018978]  asm_exc_page_fault+0x26/0x30
> > [ 3995.020309] RIP: 0033:0x7f90b3d881a7
> > [ 3995.021461] Code: e8 4e b1 f8 ff 66 66 2e 0f 1f 84 00 00 00 00 00
> > 0f 1f 00 f3 0f 1e fa 55 31 c0 ba 01 00 00 00 48 89 e5 53 48 89 fb 48
> > 83 ec 08 <f0> 0f b1 15 71 54 11 00 0f 85 3b 01 00 0
> > 0 48 8b 35 84 54 11 00 48
> > [ 3995.028091] RSP: 002b:00007ffc33632c90 EFLAGS: 00010206
> > [ 3995.029992] RAX: 0000000000000000 RBX: 0000560cfbfc0a40 RCX: 0000000=
000000000
> > [ 3995.032456] RDX: 0000000000000001 RSI: 0000000000000005 RDI: 0000560=
cfbfc0a40
> > [ 3995.034794] RBP: 00007ffc33632ca0 R08: 00007ffc33632d50 R09: 00007ff=
c33632cff
> > [ 3995.037534] R10: 00007ffc33632c70 R11: 00007ffc33632d00 R12: 0000560=
cfbfc0a40
> > [ 3995.041063] R13: 00007f90b3e97fd0 R14: 00007f90b3e97fa8 R15: 0000000=
000000000
> > [ 3995.044390]  </TASK>
> > [ 3995.045510] ---[ end trace 0000000000000000 ]---
> >
> > My guess is folio_ref_count is not a reliable thing to check here,
> > anything can increase the folio's ref account even without locking it,
> > for example, a swap cache lookup or maybe anything iterating the LRU.
>
> It is reliable, we are holding the mapcount lock, so for each mapcount
> we must have a corresponding refcount. If that is not the case, we have
> an issue elsewhere.

Yes, each mapcount should have a refcount, but could there be any
other thing to increase the refcount?

The check is: folio_large_mapcount(folio) < folio_ref_count(folio), so
maybe something just called folio_try_get and then put the folio
quickly.

>
> Other reference may only increase the refcount, but not violate the
> mapcount vs. refcount condition.
>
> Can you reproduce also with swap disabled?

I'm not sure how to reproduce it else way, I only saw this while the
swap stress test.

>
> --
> Cheers,
>
> David / dhildenb
>

