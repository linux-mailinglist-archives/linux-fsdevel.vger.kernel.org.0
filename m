Return-Path: <linux-fsdevel+bounces-46720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A28EA94461
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 18:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4951E3A15EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 16:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E854E1DF248;
	Sat, 19 Apr 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETqMWJHG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE5B17E;
	Sat, 19 Apr 2025 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745078562; cv=none; b=TVV4XcXGRdrIPtfjDgoojd52MiNxndlsWvfHSIv30CDW9aqrQ7/e7X0hv+wdFptJWRi8VrdyfqJEmO+PtdNNRXaGabyH5+cSoZt8r6HFWKCH4iPoS1wNVF3Q8sIFArNeeyQepPm+hJtEwsv2z5pI7xiKJoskbR6o4PqNnSQD9vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745078562; c=relaxed/simple;
	bh=G3evMe2DJVXrmW73BrDH+8QPyhPzlQHmMTRDWj9nAQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s39sds8gXXA5wNYko27CCm8eGG5SuSy/IZs0IvW8V6GRwgd/GuGKUNInCKsUDUNFnMIgzBeDnYvNu0hHZX+vlwcrykgQukTE1Oxwm9mtPPGMy8yEoXlWU5jDQ9YA200d2okp1l7xZ5DTIkfl74eeRJPh7EpM9umPfBvlcRsI3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETqMWJHG; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30c0517142bso23114031fa.1;
        Sat, 19 Apr 2025 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745078558; x=1745683358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sj3XziqzNKZojjXNv0qiERpxA6K79FzAbz8krAWJEwA=;
        b=ETqMWJHGUw6uHbjq3QJtS8PYzRC4uMhyagHWctnEnizVa6hVsXNLkzBwNfVV9b8fhD
         oe5DT1SQUz1VGnRX10zxDbhpaMKzz0tFCLIc1v72ViHVeXebrMP7JZY8ZeJrDAeTUXOQ
         2INo7gKA0sEg/93e7UqeHXPtl1SqLpofrs4mMN+tZn861IUhCiVvb2Qh6GDDNmDqJyE1
         Tili06VEDdB9gujT8rsN2Qyxbx+efQgyj7DU0aBfLW9qrzTl8I+b3VQLmySLUh+X7ukR
         vOnuitbnw8NrvfQE45a16m7oN4RNo1Q9HcFjfIa16NjsRNNGWoFUXH+ceP/xYd1vvQM2
         YwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745078558; x=1745683358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sj3XziqzNKZojjXNv0qiERpxA6K79FzAbz8krAWJEwA=;
        b=eWyXayaNlhfD1XcEN/7Wdmd3yc6nkhDr4Fbc9miJFw+X+0A5cS9uHO9eRfycnvOXBw
         QBC0GJzBxa70gNIwPkBpyTc74K+FKJSA+pU/C3lIhCMVNMSJhfQH2Yh6Ml/tstmuhk9l
         WDbqiBuJfSPw2w0y79K9mEHLnO+wa/GVoe1yrxNEu5WYauvvcIlmqSK3DSGDdXFkqE6q
         NxL/q9mB8TYetzb5svqPupjQ+3WhPn39yGoGEwrROLKGz/EQMF4nnQABGSrmE7OybgG/
         rQDKSWlEPwBEC38hFZF1AjTLaSh+ttHlKEO8ntn4D3n6z55Tyrv97cuTSqALUVjpLQPi
         H/ig==
X-Forwarded-Encrypted: i=1; AJvYcCURbkoe7VTgLrHU1gdj8fJfQPwEMlhVuxO3zV88JYEUfvHnE8r7TY8nH7XEsUF82EdLT8OgwJWK82gdRkm2Wg==@vger.kernel.org, AJvYcCV3K2ScLgE0gsZ8dVFqJCtbXUCfGMik5qrVd/rnyUerdu7ty001OYgFyFvodpSuWbmJPbMqMqtm@vger.kernel.org, AJvYcCWbG631ztk+4jctEt2VKoX9u/bqmhx4lieiRplsgkVUX+mFmSFWkBbgnRDV7LHNQv+ukJrksrwEartj@vger.kernel.org, AJvYcCXOfGDw39A2FpelzcAixXUBnDnHs9qGuuI2mrNOB3dfv3pbjZJg3HEBExMaS0FWQ0gaul7wC75H3u2n@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjKAHgyiUM1meWC96T3+hM+XlUXCN9HbuRITYuF3kJ4XMkiBg
	S1OT70bZlxfCec2L7cxeAMR+B+PANi0JOXH6oosAVkKI/0whI8+oWw8w76GML7jq89+lVqushYR
	UTomAXUOQgdB3qRTaQ2ZlahtDVRc=
X-Gm-Gg: ASbGnctXYb6AqBpeK5QXbfaYywSJwiRrgvoZcd8Kkl1NFyI8kan4Ae/PqcGu7ONMUiH
	nSKp+M3LloMyi+pxjjl0/6Om2FOCWohG9Vfn4fzMp0QQ6O9lzpim36Jg0uzxQ7jCtTVdWFyrIEP
	ENOfn3Y3KMq7z/+LLUrL5fzg==
X-Google-Smtp-Source: AGHT+IG4/d2R/ib6xd6W/nFMNZFhF2Jx3F/EBh2OQ4FJ5k9Et5flyli2w2rHjQM9IKQ7PJQjwWW3oYEZr7Pu46oD/eI=
X-Received: by 2002:a2e:a98a:0:b0:30b:d156:9e7e with SMTP id
 38308e7fff4ca-310904c7a59mr21136691fa.2.1745078557783; Sat, 19 Apr 2025
 09:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303163014.1128035-1-david@redhat.com> <20250303163014.1128035-14-david@redhat.com>
In-Reply-To: <20250303163014.1128035-14-david@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 20 Apr 2025 00:02:21 +0800
X-Gm-Features: ATxdqUFYccno9Rkm2nKsUZK_XSIxJQ0KqKN3aVdkZiJ0o3osotvQvG1tDs7UQEI
Message-ID: <CAMgjq7D+ea3eg9gRCVvRnto3Sv3_H3WVhupX4e=k8T5QAfBHbw@mail.gmail.com>
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

On Tue, Mar 4, 2025 at 12:46=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> Currently, we never end up reusing PTE-mapped THPs after fork. This
> wasn't really a problem with PMD-sized THPs, because they would have to
> be PTE-mapped first, but it's getting a problem with smaller THP
> sizes that are effectively always PTE-mapped.
>
> With our new "mapped exclusively" vs "maybe mapped shared" logic for
> large folios, implementing CoW reuse for PTE-mapped THPs is straight
> forward: if exclusively mapped, make sure that all references are
> from these (our) mappings. Add some helpful comments to explain the
> details.
>
> CONFIG_TRANSPARENT_HUGEPAGE selects CONFIG_MM_ID. If we spot an anon
> large folio without CONFIG_TRANSPARENT_HUGEPAGE in that code, something
> is seriously messed up.
>
> There are plenty of things we can optimize in the future: For example, we
> could remember that the folio is fully exclusive so we could speedup
> the next fault further. Also, we could try "faulting around", turning
> surrounding PTEs that map the same folio writable. But especially the
> latter might increase COW latency, so it would need further
> investigation.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 75 insertions(+), 8 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 73b783c7d7d51..bb245a8fe04bc 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3729,19 +3729,86 @@ static vm_fault_t wp_page_shared(struct vm_fault =
*vmf, struct folio *folio)
>         return ret;
>  }
>
> -static bool wp_can_reuse_anon_folio(struct folio *folio,
> -                                   struct vm_area_struct *vma)
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
> +               struct vm_area_struct *vma)
>  {
> +       bool exclusive =3D false;
> +
> +       /* Let's just free up a large folio if only a single page is mapp=
ed. */
> +       if (folio_large_mapcount(folio) <=3D 1)
> +               return false;
> +
>         /*
> -        * We could currently only reuse a subpage of a large folio if no
> -        * other subpages of the large folios are still mapped. However,
> -        * let's just consistently not reuse subpages even if we could
> -        * reuse in that scenario, and give back a large folio a bit
> -        * sooner.
> +        * The assumption for anonymous folios is that each page can only=
 get
> +        * mapped once into each MM. The only exception are KSM folios, w=
hich
> +        * are always small.
> +        *
> +        * Each taken mapcount must be paired with exactly one taken refe=
rence,
> +        * whereby the refcount must be incremented before the mapcount w=
hen
> +        * mapping a page, and the refcount must be decremented after the
> +        * mapcount when unmapping a page.
> +        *
> +        * If all folio references are from mappings, and all mappings ar=
e in
> +        * the page tables of this MM, then this folio is exclusive to th=
is MM.
>          */
> -       if (folio_test_large(folio))
> +       if (folio_test_large_maybe_mapped_shared(folio))
> +               return false;
> +
> +       VM_WARN_ON_ONCE(folio_test_ksm(folio));
> +       VM_WARN_ON_ONCE(folio_mapcount(folio) > folio_nr_pages(folio));
> +       VM_WARN_ON_ONCE(folio_entire_mapcount(folio));
> +
> +       if (unlikely(folio_test_swapcache(folio))) {
> +               /*
> +                * Note: freeing up the swapcache will fail if some PTEs =
are
> +                * still swap entries.
> +                */
> +               if (!folio_trylock(folio))
> +                       return false;
> +               folio_free_swap(folio);
> +               folio_unlock(folio);
> +       }
> +
> +       if (folio_large_mapcount(folio) !=3D folio_ref_count(folio))
>                 return false;
>
> +       /* Stabilize the mapcount vs. refcount and recheck. */
> +       folio_lock_large_mapcount(folio);
> +       VM_WARN_ON_ONCE(folio_large_mapcount(folio) < folio_ref_count(fol=
io));

Hi David, I'm seeing this WARN_ON being triggered on my test machine:

I'm currently working on my swap table series and testing heavily with
swap related workloads. I thought my patch may break the kernel, but
after more investigation and reverting to current mm-unstable, it
still occurs (with a much lower chance though, I think my series
changed the timing so it's more frequent in my case).

The test is simple, I just enable all mTHP sizes and repeatedly build
linux kernel in a 1G memcg using tmpfs.

The WARN is reproducible with current mm-unstable
(dc683247117ee018e5da6b04f1c499acdc2a1418):

[ 5268.100379] ------------[ cut here ]------------
[ 5268.105925] WARNING: CPU: 2 PID: 700274 at mm/memory.c:3792
do_wp_page+0xfc5/0x1080
[ 5268.112437] Modules linked in: zram virtiofs
[ 5268.115507] CPU: 2 UID: 0 PID: 700274 Comm: cc1 Kdump: loaded Not
tainted 6.15.0-rc2.ptch-gdc683247117e #1434 PREEMPT(voluntary)
[ 5268.120562] Hardware name: Red Hat KVM/RHEL-AV, BIOS 0.0.0 02/06/2015
[ 5268.123025] RIP: 0010:do_wp_page+0xfc5/0x1080
[ 5268.124807] Code: 0d 80 77 32 02 0f 85 3e f1 ff ff 0f 1f 44 00 00
e9 34 f1 ff ff 48 0f ba 75 00 1f 65 ff 0d 63 77 32 02 0f 85 21 f1 ff
ff eb e1 <0f> 0b e9 10 fd ff ff 65 ff 00 f0 48 0f b
a 6d 00 1f 0f 83 ec fc ff
[ 5268.132034] RSP: 0000:ffffc900234efd48 EFLAGS: 00010297
[ 5268.134002] RAX: 0000000000000080 RBX: 0000000000000000 RCX: 000fffffffe=
00000
[ 5268.136609] RDX: 0000000000000081 RSI: 00007f009cbad000 RDI: ffffea0012d=
a0000
[ 5268.139371] RBP: ffffea0012da0068 R08: 80000004b682d025 R09: 00007f009c7=
c0000
[ 5268.142183] R10: ffff88839c48b8c0 R11: 0000000000000000 R12: ffff88839c4=
8b8c0
[ 5268.144738] R13: ffffea0012da0000 R14: 00007f009cbadf10 R15: ffffc900234=
efdd8
[ 5268.147540] FS:  00007f009d1fdac0(0000) GS:ffff88a07ae14000(0000)
knlGS:0000000000000000
[ 5268.150715] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5268.153270] CR2: 00007f009cbadf10 CR3: 000000016c7c0001 CR4: 00000000007=
70eb0
[ 5268.155674] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 5268.158100] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 5268.160613] PKRU: 55555554
[ 5268.161662] Call Trace:
[ 5268.162609]  <TASK>
[ 5268.163438]  ? ___pte_offset_map+0x1b/0x110
[ 5268.165309]  __handle_mm_fault+0xa51/0xf00
[ 5268.166848]  ? update_load_avg+0x80/0x760
[ 5268.168376]  handle_mm_fault+0x13d/0x360
[ 5268.169930]  do_user_addr_fault+0x2f2/0x7f0
[ 5268.171630]  exc_page_fault+0x6a/0x140
[ 5268.173278]  asm_exc_page_fault+0x26/0x30
[ 5268.174866] RIP: 0033:0x120e8e4
[ 5268.176272] Code: 84 a9 00 00 00 48 39 c3 0f 85 ae 00 00 00 48 8b
43 20 48 89 45 38 48 85 c0 0f 85 b7 00 00 00 48 8b 43 18 48 8b 15 6c
08 42 01 <0f> 11 43 10 48 89 1d 61 08 42 01 48 89 53 18 0f 11 03 0f 11
43 20
[ 5268.184121] RSP: 002b:00007fff8a855160 EFLAGS: 00010246
[ 5268.186343] RAX: 00007f009cbadbd0 RBX: 00007f009cbadf00 RCX: 00000000000=
00000
[ 5268.189209] RDX: 00007f009cbba030 RSI: 00000000000006f4 RDI: 00000000000=
00000
[ 5268.192145] RBP: 00007f009cbb6460 R08: 00007f009d10f000 R09: 00000000000=
0016c
[ 5268.194687] R10: 0000000000000000 R11: 0000000000000010 R12: 00007f009cf=
97660
[ 5268.197172] R13: 00007f009756ede0 R14: 00007f0097582348 R15: 00000000000=
00002
[ 5268.199419]  </TASK>
[ 5268.200227] ---[ end trace 0000000000000000 ]---

I also once changed the WARN_ON to WARN_ON_FOLIO and I got more info here:

[ 3994.907255] page: refcount:9 mapcount:1 mapping:0000000000000000
index:0x7f90b3e98 pfn:0x615028
[ 3994.914449] head: order:3 mapcount:8 entire_mapcount:0
nr_pages_mapped:8 pincount:0
[ 3994.924534] memcg:ffff888106746000
[ 3994.927868] anon flags:
0x17ffffc002084c(referenced|uptodate|owner_2|head|swapbacked|node=3D0|zone=
=3D2|lastcpupid=3D0x1fffff)
[ 3994.933479] raw: 0017ffffc002084c ffff88816edd9128 ffffea000beac108
ffff8882e8ba6bc9
[ 3994.936251] raw: 00000007f90b3e98 0000000000000000 0000000900000000
ffff888106746000
[ 3994.939466] head: 0017ffffc002084c ffff88816edd9128
ffffea000beac108 ffff8882e8ba6bc9
[ 3994.943355] head: 00000007f90b3e98 0000000000000000
0000000900000000 ffff888106746000
[ 3994.946988] head: 0017ffffc0000203 ffffea0018540a01
0000000800000007 00000000ffffffff
[ 3994.950328] head: ffffffff00000007 00000000800000a3
0000000000000000 0000000000000008
[ 3994.953684] page dumped because:
VM_WARN_ON_FOLIO(folio_large_mapcount(folio) < folio_ref_count(folio))
[ 3994.957534] ------------[ cut here ]------------
[ 3994.959917] WARNING: CPU: 16 PID: 555282 at mm/memory.c:3794
do_wp_page+0x10c0/0x1110
[ 3994.963069] Modules linked in: zram virtiofs
[ 3994.964726] CPU: 16 UID: 0 PID: 555282 Comm: sh Kdump: loaded Not
tainted 6.15.0-rc1.ptch-ge39aef85f4c0-dirty #1431 PREEMPT(voluntary)
[ 3994.969985] Hardware name: Red Hat KVM/RHEL-AV, BIOS 0.0.0 02/06/2015
[ 3994.972905] RIP: 0010:do_wp_page+0x10c0/0x1110
[ 3994.974477] Code: fe ff 0f 0b bd f5 ff ff ff e9 16 fb ff ff 41 83
a9 bc 12 00 00 01 e9 2f fb ff ff 48 c7 c6 90 c2 49 82 4c 89 ef e8 40
fd fe ff <0f> 0b e9 6a fc ff ff 65 ff 00 f0 48 0f b
a 6d 00 1f 0f 83 46 fc ff
[ 3994.981033] RSP: 0000:ffffc9002b3c7d40 EFLAGS: 00010246
[ 3994.982636] RAX: 000000000000005b RBX: 0000000000000000 RCX: 00000000000=
00000
[ 3994.984778] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff889ffea=
16a80
[ 3994.986865] RBP: ffffea0018540a68 R08: 0000000000000000 R09: c0000000fff=
f7fff
[ 3994.989316] R10: 0000000000000001 R11: ffffc9002b3c7b80 R12: ffff88810cf=
d7d40
[ 3994.991654] R13: ffffea0018540a00 R14: 00007f90b3e9d620 R15: ffffc9002b3=
c7dd8
[ 3994.994076] FS:  00007f90b3caa740(0000) GS:ffff88a07b194000(0000)
knlGS:0000000000000000
[ 3994.996939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3994.998902] CR2: 00007f90b3e9d620 CR3: 0000000104088004 CR4: 00000000007=
70eb0
[ 3995.001314] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 3995.003746] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 3995.006173] PKRU: 55555554
[ 3995.007117] Call Trace:
[ 3995.007988]  <TASK>
[ 3995.008755]  ? __pfx_default_wake_function+0x10/0x10
[ 3995.010490]  ? ___pte_offset_map+0x1b/0x110
[ 3995.011929]  __handle_mm_fault+0xa51/0xf00
[ 3995.013346]  handle_mm_fault+0x13d/0x360
[ 3995.014796]  do_user_addr_fault+0x2f2/0x7f0
[ 3995.016331]  ? sigprocmask+0x77/0xa0
[ 3995.017656]  exc_page_fault+0x6a/0x140
[ 3995.018978]  asm_exc_page_fault+0x26/0x30
[ 3995.020309] RIP: 0033:0x7f90b3d881a7
[ 3995.021461] Code: e8 4e b1 f8 ff 66 66 2e 0f 1f 84 00 00 00 00 00
0f 1f 00 f3 0f 1e fa 55 31 c0 ba 01 00 00 00 48 89 e5 53 48 89 fb 48
83 ec 08 <f0> 0f b1 15 71 54 11 00 0f 85 3b 01 00 0
0 48 8b 35 84 54 11 00 48
[ 3995.028091] RSP: 002b:00007ffc33632c90 EFLAGS: 00010206
[ 3995.029992] RAX: 0000000000000000 RBX: 0000560cfbfc0a40 RCX: 00000000000=
00000
[ 3995.032456] RDX: 0000000000000001 RSI: 0000000000000005 RDI: 0000560cfbf=
c0a40
[ 3995.034794] RBP: 00007ffc33632ca0 R08: 00007ffc33632d50 R09: 00007ffc336=
32cff
[ 3995.037534] R10: 00007ffc33632c70 R11: 00007ffc33632d00 R12: 0000560cfbf=
c0a40
[ 3995.041063] R13: 00007f90b3e97fd0 R14: 00007f90b3e97fa8 R15: 00000000000=
00000
[ 3995.044390]  </TASK>
[ 3995.045510] ---[ end trace 0000000000000000 ]---

My guess is folio_ref_count is not a reliable thing to check here,
anything can increase the folio's ref account even without locking it,
for example, a swap cache lookup or maybe anything iterating the LRU.

