Return-Path: <linux-fsdevel+bounces-54059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DFBAFABF0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 08:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0AE16F665
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 06:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E28D277013;
	Mon,  7 Jul 2025 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C7Kp8Kwk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD8F2749E6
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 06:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751869925; cv=none; b=b+QxuRbpp3DSCBKDJJihbuSo4NR//LrT2uku5ZZrSLib1SHUXOFzaWuGbT0Ge2gvm3k/ZZbiFNUfPY/CuFhxCk/yMJ0oyKeIvaKwchoMhBqwrceQnnFbouhXlqoexVSqDDK8fGh36cQ3b2oLVQ40RxSgiEqM0zh2rG0hoRi1FDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751869925; c=relaxed/simple;
	bh=vxJe+BPm71cWBNm4iliT8N1/neqQZh47yL4hqyujN3w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mj9zu2uwsmh+es/CaLLH+GEf5ViS3at4uTlG7QgMx+YhSGw4w3RyA12W+HINXytFOB7W5oLiWWrhMLQD4Hb2hzQaqWpVKl7CP7Ej8ct5FwAHNfgVSjzY7sxqQCsV5p+IBIVYggtg3RvX3cQR/fHVtOlrVH60ZYD+IyJtFR0NA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C7Kp8Kwk; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-711a3dda147so24030697b3.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Jul 2025 23:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751869923; x=1752474723; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9eregAcGFAIzSiU/cuG1dEAU9nmydwBb6E55/BzC4wc=;
        b=C7Kp8KwkJhlW/vL9PIkC6RWtWdr3RMOeCBw9Zd+oNUDqo9GqvdcYvKueFcILKikV+k
         iidiAHJowMd+yZCyfsyx/CCgLUQeZI16S8XGpqIc4ujqi2wlduh/K8ZmD1ThR+wcDWOK
         0dpk2lJQS7uX6IyeE7w3+paFhrFFl3fZ85queRhXCvjewc+ziB9wjVPTw00gT4Y+uCv/
         9tleajVzWITHJoBuMLBshX9KwgPkaMNxT9sE3rUPY3V4Et/pYTRKmISnxi6dnLgKDyeM
         e0oIjM/86UBBCTKE83XQOvKgAmd5Yd8T6ovyuABQpiAHQSXVQ9woeO3rgFkkAf6VkfiZ
         r0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751869923; x=1752474723;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9eregAcGFAIzSiU/cuG1dEAU9nmydwBb6E55/BzC4wc=;
        b=QuzFjdvKUVx5Bj7CA0GCT/qHRO0LYBAKpbPtOuFXWzz5QsxxmqEYlTXepT2MPivBYc
         s+h7diO8z77wwZeVfBoR78Uu5YpiFcssN4ieiLjvIb7e8oqx06/YfdoCVR+CIWXXaiRc
         Cw2Lr9ZIFTwtA2V1eXtC6CUItNilVjYo99y49OX4bYp3Tfl3DKe17pu3yGKTDgZCXrgX
         7l1QoypK6rFQsEP+II4GyvW10L1oq+u5IRIrtrxw4zWmDewAbPqb8nkbUg4KP4HoJyVd
         2EIEVYD4uUhm0XFlcaPdG8kwi3JOpoGgon7YqDOoeydxerYWa3T5NTGm6WQpV7eWis/i
         MLSw==
X-Forwarded-Encrypted: i=1; AJvYcCVO+KJ+fzu/okwrhpouXn64JFpBxVd6ljnNozYDTOEj2Ti2PNaoFue2++z9SX62YohTAS5Cvzpa2l6D/nW7@vger.kernel.org
X-Gm-Message-State: AOJu0YwhvIx7cDrTJU4nnwoRdJJLykrsCVyZsIElVCGF2e4zH1BfmZbR
	ufKpuJ7WsjZ7V6t5AGJRfQqAy9sV9SN1D8PC4Hg6RqVeelAb9ZOPwJyG0DqvFpTc9g==
X-Gm-Gg: ASbGnctpgi250T/tuk/zI2nHepnKjtfaC0DKiK1rOnMdnqH1G2MAwxzO72HFGkgO8cZ
	AVOpTT8IBS/8Y0yLu9rUnFqNRa8xTjTi2+BZg8TXfDAGEWUsMWzxWqc/SycwZWzQzwu8cdo/sEW
	DVtHnTQkFCzJ2yvwsa6RGnaUslYC8FAoYSc+m0X3EUEiAEMZ4oizZQRrFuHnsnBGig5Mloo8TiY
	sDvDhHwhE4lnveD8MaStR0iqlyC1swCrEjrzLBEsfRrzYs8bOH9T1vduGZEF4iiJTKPwq+fRSWP
	KuedAotw8Hr1N1khEGS64kN/+zyk/l2TtBuab0B24mbYM37bKdcdpsIqGBqBufpRid3PRff5q9j
	FeASp9lZgsVmPNAOk9a78U9jMvO2m7wpJ04zbtN2XlAv6epA=
X-Google-Smtp-Source: AGHT+IEFZnGv0RJ81RzX7ADxUWhe/mHbYjhU1NsNdXuTw52DK9SQw7WvK/z0caZXZVeUNpMIcWUJlA==
X-Received: by 2002:a05:690c:b1d:b0:70e:2d3d:ace6 with SMTP id 00721157ae682-7176c9f96e9mr98750467b3.15.1751869922959;
        Sun, 06 Jul 2025 23:32:02 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-716659a1440sm15515367b3.35.2025.07.06.23.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 23:32:02 -0700 (PDT)
Date: Sun, 6 Jul 2025 23:31:50 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: David Hildenbrand <david@redhat.com>
cc: Lance Yang <lance.yang@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
    linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-mm@kvack.org, nvdimm@lists.linux.dev, 
    Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    Dan Williams <dan.j.williams@intel.com>, 
    Alistair Popple <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>, 
    Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
    Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
    Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
    Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
    Lance Yang <ioworker0@gmail.com>
Subject: Re: [PATCH RFC 01/14] mm/memory: drop highest_memmap_pfn sanity
 check in vm_normal_page()
In-Reply-To: <b6d79033-b887-4ce7-b8f2-564cad7ec535@redhat.com>
Message-ID: <b0984e6e-eabd-ed71-63c3-4c4d362553e8@google.com>
References: <20250617154345.2494405-1-david@redhat.com> <20250617154345.2494405-2-david@redhat.com> <aFVZCvOpIpBGAf9w@localhost.localdomain> <c88c29d2-d887-4c5a-8b4e-0cf30e71d596@redhat.com> <CABzRoyZtxBgJUZK4p0V1sPAqbNr=6S-aE1S68u8tKo=cZ2ELSw@mail.gmail.com>
 <5e5e8d79-61b1-465d-ab5a-4fa82d401215@redhat.com> <aa977869-f93f-4c2b-a189-f90e2d3bc7da@linux.dev> <b6d79033-b887-4ce7-b8f2-564cad7ec535@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1279896212-1751869921=:5466"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1279896212-1751869921=:5466
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 4 Jul 2025, David Hildenbrand wrote:
> On 03.07.25 16:44, Lance Yang wrote:
> > On 2025/7/3 20:39, David Hildenbrand wrote:
> >> On 03.07.25 14:34, Lance Yang wrote:
> >>> On Mon, Jun 23, 2025 at 10:04=E2=80=AFPM David Hildenbrand <david@red=
hat.com>
> >>> wrote:
> >>>>
> >>>> On 20.06.25 14:50, Oscar Salvador wrote:
> >>>>> On Tue, Jun 17, 2025 at 05:43:32PM +0200, David Hildenbrand wrote:
> >>>>>> In 2009, we converted a VM_BUG_ON(!pfn_valid(pfn)) to the current
> >>>>>> highest_memmap_pfn sanity check in commit 22b31eec63e5 ("badpage:
> >>>>>> vm_normal_page use print_bad_pte"), because highest_memmap_pfn was
> >>>>>> readily available.
> >>>>>>
> >>>>>> Nowadays, this is the last remaining highest_memmap_pfn user, and =
this
> >>>>>> sanity check is not really triggering ... frequently.
> >>>>>>
> >>>>>> Let's convert it to VM_WARN_ON_ONCE(!pfn_valid(pfn)), so we can
> >>>>>> simplify and get rid of highest_memmap_pfn. Checking for
> >>>>>> pfn_to_online_page() might be even better, but it would not handle
> >>>>>> ZONE_DEVICE properly.
> >>>>>>
> >>>>>> Do the same in vm_normal_page_pmd(), where we don't even report a
> >>>>>> problem at all ...
> >>>>>>
> >>>>>> What might be better in the future is having a runtime option like
> >>>>>> page-table-check to enable such checks dynamically on-demand.
> >>>>>> Something
> >>>>>> for the future.
> >>>>>>
> >>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>

The author of 22b31eec63e5 thinks this is not at all an improvement.
Of course the condition is not triggering frequently, of course it
should not happen: but it does happen, and it still seems worthwhile
to catch it in production with a "Bad page map" than to let it run on
to whatever kind of crash it hits instead.

Hugh
---1463770367-1279896212-1751869921=:5466--

