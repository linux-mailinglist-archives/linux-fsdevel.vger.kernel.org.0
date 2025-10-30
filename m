Return-Path: <linux-fsdevel+bounces-66459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFADFC1FE38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 12:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8B11883F3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 11:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A8033FE34;
	Thu, 30 Oct 2025 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vfrNgpMm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E26A33509D;
	Thu, 30 Oct 2025 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825109; cv=none; b=Wbkdic4QHonvHXKT3mfKE6hFEVSMA8i0HiWcxPYt3WtHtS44yjbijH90QscUhr4SgWmeLb4sgTmrcd8+jeEl2A/BWpGczPaLIIalV+/yXFg9TXTSzrk70UtSphNMyvPLId8QRoOZ1G5iU3EMqP2qO7H5KtudgdpAY4rftvE1kls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825109; c=relaxed/simple;
	bh=XQ1oXMaxqZeGMDaRBoHQ0jpp2R37p8bd1pWjG1h0TH0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PIcO+bIFldVwZzoqZq9UezRF5bOylOreCe+dBPj7TuP/6ASDCu4LU0DimXrwYkDKioPo4Ud0EumLkLrPmOlum9OQbXoYUMykh+VsAaGipJePrEsDYmi+X6VoTICkH3GdCc2+3B47FlK/WPz2fLTHK1NsUKmQBmUggGM8l6kHxac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vfrNgpMm; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Nh5loDZHBR2aksoB6uCQ/lMUHV6h0uNP+3aSbia5tGc=;
	b=vfrNgpMmkXgqbSYfXZ3V1v/bCK4I7My7du3Bzz5TlGXy1XzzpH2MFNVJMJI3OCgPBKhBVZXdF
	nlp7F4g3hndm89KyhSUDGx5XXHusPtS018Vd17K1Jk5ywxYCb+JSNtpA7AUQBgCiyB1MLrmRNTx
	dV10jOoc4Slzkv8KnnJCCn8=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4cy2WP21CYzRhRF;
	Thu, 30 Oct 2025 19:51:13 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B70B147B7D;
	Thu, 30 Oct 2025 19:51:43 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Oct 2025 19:51:38 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Oct 2025 19:51:36 +0800
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
To: Harry Yoo <harry.yoo@oracle.com>, Jiaqi Yan <jiaqiyan@google.com>
CC: =?UTF-8?Q?=e2=80=9cWilliam_Roche?= <william.roche@oracle.com>, "Ackerley
 Tng" <ackerleytng@google.com>, <jgg@nvidia.com>, <akpm@linux-foundation.org>,
	<ankita@nvidia.com>, <dave.hansen@linux.intel.com>, <david@redhat.com>,
	<duenwen@google.com>, <jane.chu@oracle.com>, <jthoughton@google.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <muchun.song@linux.dev>, <nao.horiguchi@gmail.com>,
	<osalvador@suse.de>, <peterx@redhat.com>, <rientjes@google.com>,
	<sidhartha.kumar@oracle.com>, <tony.luck@intel.com>,
	<wangkefeng.wang@huawei.com>, <willy@infradead.org>
References: <20250118231549.1652825-1-jiaqiyan@google.com>
 <20250919155832.1084091-1-william.roche@oracle.com>
 <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com>
 <aPjXdP63T1yYtvkq@hyeyoo>
 <CACw3F50As2jPzy1rRjzpm3uKOALjX_9WmKxMPGnQcok96OfQkA@mail.gmail.com>
 <aQBqGupCN_v8ysMX@hyeyoo>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d3d35586-c63f-c1be-c95e-fbd7aafd43f3@huawei.com>
Date: Thu, 30 Oct 2025 19:51:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aQBqGupCN_v8ysMX@hyeyoo>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/10/28 15:00, Harry Yoo wrote:
> On Mon, Oct 27, 2025 at 09:17:31PM -0700, Jiaqi Yan wrote:
>> On Wed, Oct 22, 2025 at 6:09 AM Harry Yoo <harry.yoo@oracle.com> wrote:
>>>
>>> On Mon, Oct 13, 2025 at 03:14:32PM -0700, Jiaqi Yan wrote:
>>>> On Fri, Sep 19, 2025 at 8:58 AM “William Roche <william.roche@oracle.com> wrote:
>>>>>
>>>>> From: William Roche <william.roche@oracle.com>
>>>>>
>>>>> Hello,
>>>>>
>>>>> The possibility to keep a VM using large hugetlbfs pages running after a memory
>>>>> error is very important, and the possibility described here could be a good
>>>>> candidate to address this issue.
>>>>
>>>> Thanks for expressing interest, William, and sorry for getting back to
>>>> you so late.
>>>>
>>>>>
>>>>> So I would like to provide my feedback after testing this code with the
>>>>> introduction of persistent errors in the address space: My tests used a VM
>>>>> running a kernel able to provide MFD_MF_KEEP_UE_MAPPED memfd segments to the
>>>>> test program provided with this project. But instead of injecting the errors
>>>>> with madvise calls from this program, I get the guest physical address of a
>>>>> location and inject the error from the hypervisor into the VM, so that any
>>>>> subsequent access to the location is prevented directly from the hypervisor
>>>>> level.
>>>>
>>>> This is exactly what VMM should do: when it owns or manages the VM
>>>> memory with MFD_MF_KEEP_UE_MAPPED, it is then VMM's responsibility to
>>>> isolate guest/VCPUs from poisoned memory pages, e.g. by intercepting
>>>> such memory accesses.
>>>>
>>>>>
>>>>> Using this framework, I realized that the code provided here has a problem:
>>>>> When the error impacts a large folio, the release of this folio doesn't isolate
>>>>> the sub-page(s) actually impacted by the poison. __rmqueue_pcplist() can return
>>>>> a known poisoned page to get_page_from_freelist().
>>>>
>>>> Just curious, how exactly you can repro this leaking of a known poison
>>>> page? It may help me debug my patch.
>>>>
>>>>>
>>>>> This revealed some mm limitations, as I would have expected that the
>>>>> check_new_pages() mechanism used by the __rmqueue functions would filter these
>>>>> pages out, but I noticed that this has been disabled by default in 2023 with:
>>>>> [PATCH] mm, page_alloc: reduce page alloc/free sanity checks
>>>>> https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
>>>>
>>>> Thanks for the reference. I did turned on CONFIG_DEBUG_VM=y during dev
>>>> and testing but didn't notice any WARNING on "bad page"; It is very
>>>> likely I was just lucky.
>>>>
>>>>>
>>>>>
>>>>> This problem seems to be avoided if we call take_page_off_buddy(page) in the
>>>>> filemap_offline_hwpoison_folio_hugetlb() function without testing if
>>>>> PageBuddy(page) is true first.
>>>>
>>>> Oh, I think you are right, filemap_offline_hwpoison_folio_hugetlb
>>>> shouldn't call take_page_off_buddy(page) depend on PageBuddy(page) or
>>>> not. take_page_off_buddy will check PageBuddy or not, on the page_head
>>>> of different page orders. So maybe somehow a known poisoned page is
>>>> not taken off from buddy allocator due to this?
>>>
>>> Maybe it's the case where the poisoned page is merged to a larger page,
>>> and the PGTY_buddy flag is set on its buddy of the poisoned page, so
>>> PageBuddy() returns false?:
>>>
>>>   [ free page A ][ free page B (poisoned) ]
>>>
>>> When these two are merged, then we set PGTY_buddy on page A but not on B.
>>
>> Thanks Harry!
>>
>> It is indeed this case. I validate by adding some debug prints in
>> take_page_off_buddy:
>>
>> [ 193.029423] Memory failure: 0x2800200: [yjq] PageBuddy=0 after drain_all_pages
>> [ 193.029426] 0x2800200: [yjq] order=0, page_order=0, PageBuddy(page_head)=0
>> [ 193.029428] 0x2800200: [yjq] order=1, page_order=0, PageBuddy(page_head)=0
>> [ 193.029429] 0x2800200: [yjq] order=2, page_order=0, PageBuddy(page_head)=0
>> [ 193.029430] 0x2800200: [yjq] order=3, page_order=0, PageBuddy(page_head)=0
>> [ 193.029431] 0x2800200: [yjq] order=4, page_order=0, PageBuddy(page_head)=0
>> [ 193.029432] 0x2800200: [yjq] order=5, page_order=0, PageBuddy(page_head)=0
>> [ 193.029434] 0x2800200: [yjq] order=6, page_order=0, PageBuddy(page_head)=0
>> [ 193.029435] 0x2800200: [yjq] order=7, page_order=0, PageBuddy(page_head)=0
>> [ 193.029436] 0x2800200: [yjq] order=8, page_order=0, PageBuddy(page_head)=0
>> [ 193.029437] 0x2800200: [yjq] order=9, page_order=0, PageBuddy(page_head)=0
>> [ 193.029438] 0x2800200: [yjq] order=10, page_order=10, PageBuddy(page_head)=1
>>
>> In this case, page for 0x2800200 is hwpoisoned, and its buddy page is
>> 0x2800000 with order 10.
> 
> Woohoo, I got it right!
> 
>>> But even after fixing that we need to fix the race condition.
>>
>> What exactly is the race condition you are referring to?
> 
> When you free a high-order page, the buddy allocator doesn't not check
> PageHWPoison() on the page and its subpages. It checks PageHWPoison()
> only when you free a base (order-0) page, see free_pages_prepare().

I think we might could check PageHWPoison() for subpages as what free_page_is_bad()
does. If any subpage has HWPoisoned flag set, simply drop the folio. Even we could
do it better -- Split the folio and let healthy subpages join the buddy while reject
the hwpoisoned one.

> 
> AFAICT there is nothing that prevents the poisoned page to be
> allocated back to users because the buddy doesn't check PageHWPoison()
> on allocation as well (by default).
> 
> So rather than freeing the high-order page as-is in
> dissolve_free_hugetlb_folio(), I think we have to split it to base pages
> and then free them one by one.

It might not be worth to do that as this would significantly increase the overhead
of the function while memory failure event is really rare.

Thanks both.
.

> 
> That way, free_pages_prepare() will catch that it's poisoned and won't
> add it back to the freelist. Otherwise there will always be a window
> where the poisoned page can be allocated to users - before it's taken
> off from the buddy.
> 


