Return-Path: <linux-fsdevel+bounces-65727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19292C0F315
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 840E24FCA70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A5E311C06;
	Mon, 27 Oct 2025 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IcBHqm7f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD6311969
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581372; cv=none; b=KR7swkYSRKrXZmPi0vJfwtQBQ5Ah0OusWSdoEe/cXiJESe4OKoODPq480prnanjISpqE1FeEPRlKX1oKmbwL6Th5mBDCsRRqjCVgoZueX0GHETvpGYtzFdGJnIU5eP/4E4jOV1g2gBYgukZwmRjY4yvPYUjO2kt1sQzgEz1DGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581372; c=relaxed/simple;
	bh=Ip6risDW9tTbsO2jqPpdXFWuol17OZMU9AeN0DDZC0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWqVwcG7Z8SdtpTB8NlFE++4qDP9BSrJpdmzx653k6RW83JI3dMq6/Zq64PCd0cGehx8xOzlmrHHOWxvO32SsfEpqD0TIPOX8tJ429vHrkkBYi1kHUtQDlaND0TgAfI4e91DE7rHIjuIE1pRkDegpL0KNYdTOgc2XjmIMiJopHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IcBHqm7f; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8a114591f15so237133485a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761581369; x=1762186169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=anSGbOUh9PRDsyCb0fgwZTMvbpzdcHnK6psdZLJfHyQ=;
        b=IcBHqm7fU43ySr4jxg1yFycM5TUboENAPgV0PPQ8nLUO0nwiE/ZwVB6PYrWLv5HQPS
         lW+V7ySyEgrtWmoOD8v9RN6JtdSKa7CA+HYSkFc3uAkUjQ/Fi161lT95fxKmFqwiMBFa
         PZnQ7y7fR47yEX4ug1dDiAc602ytkP0bRa2CwA9WJw2tzhCnYCOqGworuYtc3suStXun
         NCNpcI0Io5nLReoujMyPHQbPO3BywFJHUncVShVYVhokCuV2XlvrS/BEBYQOEFggHII3
         IPB1NQ+qYfN3SEUy6T9RqVV51b4Gb2tL/k2G3ERO2sj7DDGeU6fyE/UFui2BmhuHc6th
         pjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761581369; x=1762186169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anSGbOUh9PRDsyCb0fgwZTMvbpzdcHnK6psdZLJfHyQ=;
        b=JMRDNOyTE3GANDvsIhQVmxhycplxK8kO9NA7aBvU/lnjmA5vg7D69AmLvZYNk+TRpp
         vzC15/WBlkAQ5UqROeWuLCe2XPwwgxF/O/RWMDcH75vtPaAfYFqHNmBUEhuAVVpf8Drb
         bMx5/UV6+IBDyX11zxCxp8lBlKy6re6OkSz+Rl6CFtLOBA2fGB7BosFGs/2aCSnXBRVb
         LniwStlO5TxtdUDaQpxNrxmiZHdEVP8wwci6DNT19cPEiT/hrdUNqGS2fOWZ8VIYwlJv
         Yl4V4iqOqjHIrq4mgDQo39mXyrdyJRWnFyOlFDMT1aRkRqL9h5gP5mD5uMZaSZyw1vpa
         CYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUpnIk/PA4kYfa9XHVDFiHyq/hWPlCXTw9RSM3jo+JRdtwGQAUks2OU/wSUIvYwbTVASMdnUCV3NjxVP1s@vger.kernel.org
X-Gm-Message-State: AOJu0YxUkXREHT27V+RHSpL/oAmJ6JcAXBsS6apx3XvpCjvEsC3yQ2Ss
	S+88v6BYKetE20XdduOOSYtw6TSc0bmzccjhbTf4IvZ49R8ozVeXl66rxSFOD/xq538=
X-Gm-Gg: ASbGncu2noD8DwXuYZSVMwHSIg4TGpDj/hG3tqZgxZq3z23SiVImGgVPNfeuchJHVcm
	iJefvn2ffsLh6K0Gwb0aboFWth8/WygD2ceHIAUXKvqtllB42VEGkWxMb3kfI4dzOX0K7udqnkN
	auFkfqna5ma9dfD5dF1bFQYYZIGBm9M5/HiwPjLybha0cQ9LGbgk8YMx7zFTipP6XyttZeYCivF
	G27JucH1T42OO4MH09qYYuG395KdHwauVXPtXpZvbYrlniPLg9Yo/HzPLcuExfzHOGxK+yVqYTu
	DqDD8ktbRa+emI/NRgJAJMNc96MPMASYtiAwGIWTY+fkfYX8Zyk738C8T2jimpc9FBkFfYILwDe
	9rH+2rjSH0weyfnMS6FnUVTmHJlZt7qSIMU05LhtL7rHWjrQYYFSzmhG+CaqzzxsMaCRiSUEvNk
	X+8wqtHAcMm6qprOm/6F635PaOuuizRTgZFcBW/lPTQIboAO/mjd7KLWdv
X-Google-Smtp-Source: AGHT+IHlNcX7M4ho1Hgm07pKSXRDLSWwAqfcPM4p2At44BY4PwXR6XnbKFaciXa2MkD0JUoTO3ORTg==
X-Received: by 2002:a05:620a:1aa1:b0:8a3:9a05:ec15 with SMTP id af79cd13be357-8a6d072570emr95429085a.19.1761581364508;
        Mon, 27 Oct 2025 09:09:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25c8a34dsm624408985a.48.2025.10.27.09.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:09:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vDPmd-00000004HT9-1p2Z;
	Mon, 27 Oct 2025 13:09:23 -0300
Date: Mon, 27 Oct 2025 13:09:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Leon Romanovsky <leon@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/12] remove is_swap_[pte, pmd]() + non-swap
 confusion
Message-ID: <20251027160923.GF760669@ziepe.ca>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761288179.git.lorenzo.stoakes@oracle.com>

On Fri, Oct 24, 2025 at 08:41:16AM +0100, Lorenzo Stoakes wrote:
> There's an established convention in the kernel that we treat leaf page
> tables (so far at the PTE, PMD level) as containing 'swap entries' should
> they be neither empty (i.e. p**_none() evaluating true) nor present
> (i.e. p**_present() evaluating true).

I have to say I've never liked the none-vs-present naming either.

> This is deeply confusing, so this series goes further and eliminates the
> non_swap_entry() predicate, replacing it with is_non_present_entry() - with
> an eye to a new convention of referring to these non-swap 'swap entries' as
> non-present.

I'm not keen on is_non_present_entry(), it seems confusing again.

It looks like we are stuck with swp_entry_t as the being the handle
for a non-present pte. Oh well, not a great name, but fine..

So we think of that swp_entry_t having multiple types: swap, migration,
device private, etc, etc

Then I'd think the general pattern should be to get a swp_entry_t:

    if (pte_present(pte))
        return;
    swpent = pte_to_swp_entry(pte);

And then evaluate the type:

    if (swpent_is_swap()) {
    }


If you keep the naming as "swp_entry" indicates the multi-type value,
then "swap" can mean a swp_entry which is used by the swap subsystem.

That suggests functions like this:

swpent_is_swap()
swpent_is_migration()
..

and your higher level helpers like:

/* True if the pte is a swpent_is_swap() */
static inline bool swpent_get_swap_pte(pte_t pte, swp_entry_t *entryp)
{
   if (pte_present(pte))
        return false;
   *swpent = pte_to_swp_entry(pte);
   return swpent_is_swap(*swpent);
}

I also think it will be more readable to keep all these things under a
swpent namespace instead of using unstructured english names.

> * pte_to_swp_entry_or_zero() - allows for convenient conversion from a PTE
>   to a swap entry if present, or an empty swap entry if none. This is
>   useful as many swap entry conversions are simply checking for flags for
>   which this suffices.

I'd expect a safe function should be more like

   *swpent = pte_to_swp_entry_safe(pte);
   return swpent_is_swap(*swpent);

Where "safe" means that if the PTE is None or Present then
swpent_is_XX() == false. Ie it returns a 0 swpent and 0 swpent is
always nothing.

> * get_pte_swap_entry() - Retrieves a PTE swap entry if it truly is a swap
>   entry (i.e. not a non-present entry), returning true if so, otherwise
>   returns false. This simplifies a lot of logic that previously open-coded
>   this.

Like this is still a tortured function:

+static inline bool get_pte_swap_entry(pte_t pte, swp_entry_t *entryp)
+{
+       if (pte_present(pte))
+               return false;
+       if (pte_none(pte))
+               return false;
+
+       *entryp = pte_to_swp_entry(pte);
+       if (non_swap_entry(*entryp))
+               return false;
+
+       return true;
+}
+

static inline bool get_pte_swap_entry(pte_t pte, swp_entry_t *entryp)
{
   return swpent_is_swap(*swpent = pte_to_swp_entry_safe(pte));
}

Maybe it doesn't even need an inline at that point?

> * is_huge_pmd() - Determines if a PMD contains either a present transparent
>   huge page entry or a huge non-present entry. This again simplifies a lot
>   of logic that simply open-coded this.

is_huge_or_swpent_pmd() would be nicer, IMHO. I think it is surprising
when any of these APIs accept swap entries without being explicit

Jason

