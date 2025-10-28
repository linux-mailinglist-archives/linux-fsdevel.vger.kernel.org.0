Return-Path: <linux-fsdevel+bounces-65874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC67C12D85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 05:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056893BEFBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 04:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3D52882D0;
	Tue, 28 Oct 2025 04:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WlVuSCYz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E9D1C3F0C
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 04:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761625061; cv=none; b=sutXklz0Q6/ZsmZ1TMubhO2QYq1ugN4FIEJsep6oQMhqAgcxj8p7NzcKlPZw0eySNXIVz+vFOziBuTPJDovJv+V4/kfqLhovTTqkpqwIgJ5JqnWdS7qjMV7S12qYInkMoacH3Xu+JxjDzLeG0LMlbWHlKC7XGZJQjWw5zRsf028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761625061; c=relaxed/simple;
	bh=1bEKqU8kV0ErBu1ALa2/+teuG5Dzt3u1bm7EjGr0028=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f137n21Vc0DK4kHv+6cgulHbQwD2wR+4nlEEhY71u3AGpBCt5komISIf72BbZVHyqpwywPfnUa2w4TxeBUUrwq5bau9EE9K4UTDdSWKUxl2DTojjTM3DRN3SZ+UH3OeT4/aY39UamozL6/lbRz6Reh8w2S1EhtKw9X2HiMJ+mLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WlVuSCYz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-470ff2f6e56so45335e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 21:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761625058; x=1762229858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cAevRJm/yIdn/zFvFaKRkG15E90y6nwgwebq1Zvcoo=;
        b=WlVuSCYziGB96dcM/scbdZjN139A6nf52m83sofbm3QT54a1ZID32/+1xLjMmjFE7y
         kp0fJuyVJzcqOTghEOd3EYfHiIM8Xpe++6UsSULma1TW+UCWoU8lPS6+F/GQa4AW3SJy
         e41atNT8nCT1BOi8SzL4u7NA2MqQmVBwzW+ICaVjQ3YSBF4zQVK/2/YadJmNdq3VLeeP
         6AfQMZGfXBTEgRC6Z7fzae1Oggq2FLBBw3yVBLAc+W0HOdHsfhDHRnc+OZXJRgfTpOw9
         LNPG1IccuoRVv9k5wDTlJUNosgTwpyeO3Ct9QchX7cIr59PmXFjEiYweoS/YfdARVqxN
         Exxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761625058; x=1762229858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cAevRJm/yIdn/zFvFaKRkG15E90y6nwgwebq1Zvcoo=;
        b=w9mI+5m2T/kRkET01eggpYWty5uWXIjC9EwIeZvluFSLp2j0jnT3E+wFf6C5bRzNOm
         NWYoJcNP3A96qrCVTNbSb0S43cgQYJGLDCgt0KFmAmkWv4+xMWz/394wNXOKjWL+yWN1
         99QNqvgMbA4C8oYktGEdG+9FGF9grcu1YaEx/Q0G7gHZWwNOCFsqNiB2y3QGYwV+N2Yw
         lvESq0RoWZ4hrIIr+vCvEixSnMAksB1il/hoH5yWFzc7xRuWRL6E6fiJjVLUdgZstTX5
         re8TgbnoCLVj/j5TkLwCc9+l32KO+R+4M79eAZ1AI8m+LJoy4C8asWxcwvxTGopKLk4M
         aeag==
X-Forwarded-Encrypted: i=1; AJvYcCWqzZGdw4tqrNDE9l68wAk3R9OCzjG7nISpUtAfOwKI/ROfUXmiBpak6jgoSA/wlB+aFAT/WI9rLn8QPcEb@vger.kernel.org
X-Gm-Message-State: AOJu0YyUBT5lSlKY4JwhtbINaYuj7n9SqK9bI/55q//2mOT0dLqpYNI/
	CX7X98fqpuieDSCT0VNWDMZPBYqB/WiFGzXSZ8DyAjCKtd2D8OCw+I9PR3CKB1NBeMEO8JmY1Z6
	1RYUQbhS47PbzpiGVbEz54kF+BLlG4Mhb+LdeU+7k
X-Gm-Gg: ASbGncuiqIzuSgh9bbjUcr6MeOzktWmAeMRl/8nMofkqQMlAYhZ2ZvYJCnR4cEj55zR
	P+UG+5hG7dNQ+7HkwHYNHeUqH1vvxjp0NAwnH7GppjhatuYjdm0xiBA8MX9xSot8L0rCvBLsRux
	vDjnp8wqbBDJT+MtDKrn3Apms2ldEYnaV8MsrRQxhEG7V4sxnEsX0y6QFLMHIm3RUJ9bcqz+b76
	MbUsv+ZfljYks3dFUYHlfCt/A4q7ZkESMTThSiw2qCOQ9BbjUFO2BlW8lhxFD23SiQbzaUYvLIq
	ETfLydVNb7zjJTe3ExRs7YPPDfhV
X-Google-Smtp-Source: AGHT+IE+E4tY+etIsCFF2nPDoUHnyT22SnJy9UYp9PvQ/KhLgWN6YLuk42P54iQFHSSSkaspkz8UX/surNJ8nzJ1vaM=
X-Received: by 2002:a05:600c:c0da:b0:475:da0c:38a8 with SMTP id
 5b1f17b1804b1-47718507566mr1227225e9.4.1761625057533; Mon, 27 Oct 2025
 21:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250118231549.1652825-1-jiaqiyan@google.com> <20250919155832.1084091-1-william.roche@oracle.com>
 <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com> <24367c05-ad1f-4546-b2ed-69e587113a54@oracle.com>
In-Reply-To: <24367c05-ad1f-4546-b2ed-69e587113a54@oracle.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 27 Oct 2025 21:17:26 -0700
X-Gm-Features: AWmQ_bmX6ASj90LVpGKygNwiwwkhojJGWTI7LXhkciYIpunIwL2ADJiOsQmDDCU
Message-ID: <CACw3F53ycL5xDwHC2dYxi9RXBAF=nQjwT4HWnRWewQLaHFU_kw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
To: William Roche <william.roche@oracle.com>
Cc: Ackerley Tng <ackerleytng@google.com>, jgg@nvidia.com, akpm@linux-foundation.org, 
	ankita@nvidia.com, dave.hansen@linux.intel.com, david@redhat.com, 
	duenwen@google.com, jane.chu@oracle.com, jthoughton@google.com, 
	linmiaohe@huawei.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev, 
	nao.horiguchi@gmail.com, osalvador@suse.de, peterx@redhat.com, 
	rientjes@google.com, sidhartha.kumar@oracle.com, tony.luck@intel.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, harry.yoo@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:57=E2=80=AFPM William Roche <william.roche@oracle=
.com> wrote:
>
> On 10/14/25 00:14, Jiaqi Yan wrote:
>  > On Fri, Sep 19, 2025 at 8:58=E2=80=AFAM William Roche wrote:
>  > [...]
>  >>
>  >> Using this framework, I realized that the code provided here has a
>  >> problem:
>  >> When the error impacts a large folio, the release of this folio
>  >> doesn't isolate the sub-page(s) actually impacted by the poison.
>  >> __rmqueue_pcplist() can return a known poisoned page to
>  >> get_page_from_freelist().
>  >
>  > Just curious, how exactly you can repro this leaking of a known poison
>  > page? It may help me debug my patch.
>  >
>
> When the memfd segment impacted by a memory error is released, the
> sub-page impacted by a memory error is not removed from the freelist and
> an allocation of memory (large enough to increase the chance to get this
> page) crashes the system with the following stack trace (for example):
>
> [  479.572513] RIP: 0010:clear_page_erms+0xb/0x20
> [...]
> [  479.587565]  post_alloc_hook+0xbd/0xd0
> [  479.588371]  get_page_from_freelist+0x3a6/0x6d0
> [  479.589221]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  479.590122]  __alloc_frozen_pages_noprof+0x186/0x380
> [  479.591012]  alloc_pages_mpol+0x7b/0x180
> [  479.591787]  vma_alloc_folio_noprof+0x70/0xf0
> [  479.592609]  alloc_anon_folio+0x1a0/0x3a0
> [  479.593401]  do_anonymous_page+0x13f/0x4d0
> [  479.594174]  ? pte_offset_map_rw_nolock+0x1f/0xa0
> [  479.595035]  __handle_mm_fault+0x581/0x6c0
> [  479.595799]  handle_mm_fault+0xcf/0x2a0
> [  479.596539]  do_user_addr_fault+0x22b/0x6e0
> [  479.597349]  exc_page_fault+0x67/0x170
> [  479.598095]  asm_exc_page_fault+0x26/0x30
>
> The idea is to run the test program in the VM and instead of using
> madvise to poison the location, I take the physical address of the
> location, and use Qemu 'gpa2hpa' address of the location,
> so that I can inject the error on the hypervisor with the
> hwpoison-inject module (for example).
> Let the test program finish and run a memory allocator (trying to take
> as much memory as possible)
> You should end up on a panic of the VM.

Thanks William, I can even repro with the hugetlb-mfr selftest withou a VM.

>
>  >>
>  >> This revealed some mm limitations, as I would have expected that the
>  >> check_new_pages() mechanism used by the __rmqueue functions would
>  >> filter these pages out, but I noticed that this has been disabled by
>  >> default in 2023 with:
>  >> [PATCH] mm, page_alloc: reduce page alloc/free sanity checks
>  >> https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
>  >
>  > Thanks for the reference. I did turned on CONFIG_DEBUG_VM=3Dy during d=
ev
>  > and testing but didn't notice any WARNING on "bad page"; It is very
>  > likely I was just lucky.
>  >
>  >>
>  >>
>  >> This problem seems to be avoided if we call take_page_off_buddy(page)
>  >> in the filemap_offline_hwpoison_folio_hugetlb() function without
>  >> testing if PageBuddy(page) is true first.
>  >
>  > Oh, I think you are right, filemap_offline_hwpoison_folio_hugetlb
>  > shouldn't call take_page_off_buddy(page) depend on PageBuddy(page) or
>  > not. take_page_off_buddy will check PageBuddy or not, on the page_head
>  > of different page orders. So maybe somehow a known poisoned page is
>  > not taken off from buddy allocator due to this?
>  >
>  > Let me try to fix it in v2, by the end of the week. If you could test
>  > with your way of repro as well, that will be very helpful!
>
>
> Of course, I'll run the test on your v2 version and let you know how it
> goes.

Sorry it took more than I expect to prepare v2. I want to get rid of
populate_memfd_hwp_folios and want to insert
filemap_offline_hwpoison_folio into remove_inode_single_folio so that
everything can be done on the fly in remove_inode_hugepages's while
loop. This refactor isn't as trivial as I thought.

I was struggled with page refcount for some time, for a couple of reasons:
1. filemap_offline_hwpoison_folio has to put 1 refcount on hwpoison-ed
folio so it can be dissolved. But I immediately got a "BUG: Bad page
state in process" due to "page: refcount:-1".
2. It turns out to be that remove_inode_hugepages also puts folios'
refcount via folio_batch_release. I avoided this for hwpoison-ed folio
by removing it from the fbatch.

I have just tested v2 with the hugetlb-mfr selftest and didn't see
"BUG: Bad page" for either nonzero refcount or hwpoison after some
hours of running/up time. Meanwhile, I will send v2 as a draft to you
for more test coverage.

>
>
>  >> But according to me it leaves a (small) race condition where a new
>  >> page allocation could get a poisoned sub-page between the dissolve
>  >> phase and the attempt to remove it from the buddy allocator.
>
> I still think that the way we recycle the impacted large page still has
> a (much smaller) race condition where a memory allocation can get the
> poisoned page, as we don't have the checks to filter the poisoned page
> from the freelist.
> I'm not sure we have a way to recycle the page without having a moment
> when the poison page is in the freelist.
> (I'd be happy to be proven wrong ;) )
>
>
>  >> If performance requires using Hugetlb pages, than maybe we could
>  >> accept to loose a huge page after a memory impacted
>  >> MFD_MF_KEEP_UE_MAPPED memfd segment is released ? If it can easily
>  >> avoid some other corruption.
>
> What I meant is: if we don't have a reliable way to recycle an impacted
> large page, we could start with a version of the code where we don't
> recycle it, just to avoid the risk...
>
>
>  >
>  > There is also another possible path if VMM can change to back VM
>  > memory with *1G guest_memfd*, which wraps 1G hugetlbfs. In Ackerley's
>  > work [1], guest_memfd can split the 1G page for conversions. If we
>  > re-use the splitting for memory failure recovery, we can probably
>  > achieve something generally similar to THP's memory failure recovery:
>  > split 1G to 2M and 4k chunks, then unmap only 4k of poisoned page. We
>  > still lose the 1G TLB size so VM may be subject to some performance
>  > sacrifice.
>  >
>  > [1]
> https://lore.kernel.org/linux-mm/2ae41e0d80339da2b57011622ac2288fed65cd01=
.1747264138.git.ackerleytng@google.com
>
>
> Thanks for the pointer.
> I personally think that splitting the large page into base pages, is
> just fine.
> The main possibility I see in this project is to significantly increase
> the probability to survive a memory error on large pages backed VMs.
>
> HTH.
>
> Thanks a lot,
> William.

