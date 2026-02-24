Return-Path: <linux-fsdevel+bounces-78222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OKbGyRUnWk2OgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 08:32:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C52DC1830EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 08:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2EB630F57ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 07:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D5345743;
	Tue, 24 Feb 2026 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DvkZMD8B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713E33ADBC;
	Tue, 24 Feb 2026 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918247; cv=none; b=nBrU/joyglldwVVIlag6uZWwlQ4hp5GVCAktTTomi2JHF9JX52n9wF0TKOezUQS7GgUzwvVg0SiYV7N51smxgTuLiqa0fTHM0fE8EpnWg7P30YxrM9iUXmJIYCT8scOyEB1/O6T+OxecUaveVadHwyJJXC7qUAYz+3hMtxn52hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918247; c=relaxed/simple;
	bh=EBGc5KyiM2yeXRLxwMRMc6vl/1yrW8vbdB5HvrfKfSQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oBTaortyooOidTeI8t54J8caXnmYLcjdDrIVZVGhabYuCbb4OMO2xjNAw2DxgVw3h8HVJ8SEr94QDWv1gqFrSjQtQsjnKsSFQYJaTcM+ZQ+EQ2kXCmHN1z3PyFbeP97Z4/EGNUtUi7YcabvVeXgLR64tYmIKFcUgiJPFq0BL4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DvkZMD8B; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=i852AmhqQepEcJU2Va19clWIwPgPW2TCtS0BPtURAUM=;
	b=DvkZMD8BSj1hsYu58fxaLMlH2uV1F8QRDojhe6UKHLneR0msxa0kENmLjyOpvc3+/Sp+Lr5I5
	BBw+gETiMokMwmuBSMZAbkdtmNf+fsSJyCW0zpyV6g81/TBvGenHZmxtUpCFII8HW3/rqqsblhv
	yU7MdpjWCBW/x6VAndWH/3k=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fKq5B6prfzRhSd;
	Tue, 24 Feb 2026 15:25:50 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 75F66404AD;
	Tue, 24 Feb 2026 15:30:36 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Feb 2026 15:30:36 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Feb 2026 15:30:34 +0800
Subject: Re: [PATCH v3 1/3] mm: memfd/hugetlb: introduce memfd-based userspace
 MFR policy
To: Jiaqi Yan <jiaqiyan@google.com>
CC: <nao.horiguchi@gmail.com>, <tony.luck@intel.com>,
	<wangkefeng.wang@huawei.com>, <willy@infradead.org>,
	<akpm@linux-foundation.org>, <osalvador@suse.de>, <rientjes@google.com>,
	<duenwen@google.com>, <jthoughton@google.com>, <jgg@nvidia.com>,
	<ankita@nvidia.com>, <peterx@redhat.com>, <sidhartha.kumar@oracle.com>,
	<ziy@nvidia.com>, <david@redhat.com>, <dave.hansen@linux.intel.com>,
	<muchun.song@linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<william.roche@oracle.com>, <harry.yoo@oracle.com>, <jane.chu@oracle.com>
References: <20260203192352.2674184-1-jiaqiyan@google.com>
 <20260203192352.2674184-2-jiaqiyan@google.com>
 <7ad34b69-2fb4-770b-14e5-bea13cf63d2f@huawei.com>
 <CACw3F50PwJ+sSOX0wySQgBzrEW2XOctxuX5jM37OG0HS_kHdbQ@mail.gmail.com>
 <31cc7bed-c30f-489c-3ac3-4842aa00b869@huawei.com>
 <CACw3F50BwnLJW75EXgz0t5g+eUhr+wKgJ3YfRFq5208N5KfaiA@mail.gmail.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a0d25caf-a18b-e3d8-e74f-fc18fa85252e@huawei.com>
Date: Tue, 24 Feb 2026 15:30:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACw3F50BwnLJW75EXgz0t5g+eUhr+wKgJ3YfRFq5208N5KfaiA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq500010.china.huawei.com (7.202.194.235)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78222-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,huawei.com,infradead.org,linux-foundation.org,suse.de,google.com,nvidia.com,redhat.com,oracle.com,linux.intel.com,linux.dev,kvack.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim,huawei.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmiaohe@huawei.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C52DC1830EB
X-Rspamd-Action: no action

On 2026/2/13 13:01, Jiaqi Yan wrote:
> On Mon, Feb 9, 2026 at 11:31 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2026/2/10 12:47, Jiaqi Yan wrote:
>>> On Mon, Feb 9, 2026 at 3:54 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>> On 2026/2/4 3:23, Jiaqi Yan wrote:
>>>>> Sometimes immediately hard offlining a large chunk of contigous memory
>>>>> having uncorrected memory errors (UE) may not be the best option.
>>>>> Cloud providers usually serve capacity- and performance-critical guest
>>>>> memory with 1G HugeTLB hugepages, as this significantly reduces the
>>>>> overhead associated with managing page tables and TLB misses. However,
>>>>> for today's HugeTLB system, once a byte of memory in a hugepage is
>>>>> hardware corrupted, the kernel discards the whole hugepage, including
>>>>> the healthy portion. Customer workload running in the VM can hardly
>>>>> recover from such a great loss of memory.
>>>>
>>>> Thanks for your patch. Some questions below.
>>>>
>>>>>
>>>>> Therefore keeping or discarding a large chunk of contiguous memory
>>>>> owned by userspace (particularly to serve guest memory) due to
>>>>> recoverable UE may better be controlled by userspace process
>>>>> that owns the memory, e.g. VMM in the Cloud environment.
>>>>>
>>>>> Introduce a memfd-based userspace memory failure (MFR) policy,
>>>>> MFD_MF_KEEP_UE_MAPPED. It is possible to support for other memfd,
>>>>> but the current implementation only covers HugeTLB.
>>>>>
>>>>> For a hugepage associated with MFD_MF_KEEP_UE_MAPPED enabled memfd,
>>>>> whenever it runs into a new UE,
>>>>>
>>>>> * MFR defers hard offline operations, i.e., unmapping and
>>>>
>>>> So the folio can't be unpoisoned until hugetlb folio becomes free?
>>>
>>> Are you asking from testing perspective, are we still able to clean up
>>> injected test errors via unpoison_memory() with MFD_MF_KEEP_UE_MAPPED?
>>>
>>> If so, unpoison_memory() can't turn the HWPoison hugetlb page to
>>> normal hugetlb page as MFD_MF_KEEP_UE_MAPPED automatically dissolves
>>
>> We might loss some testability but that should be an acceptable compromise.
> 
> To clarify, looking at unpoison_memory(), it seems unpoison should
> still work if called before truncated or memfd closed.
> 
> What I wanted to say is, for my test hugetlb-mfr.c, since I really
> want to test the cleanup code (dissolving free hugepage having
> multiple errors) after truncation or memfd closed, so we can only
> unpoison the raw pages rejected by buddy allocator.
> 
>>
>>> it. unpoison_memory(pfn) can probably still turn the HWPoison raw page
>>> back to a normal one, but you already lost the hugetlb page.
>>>
>>>>
>>>>>   dissolving. MFR still sets HWPoison flag, holds a refcount
>>>>>   for every raw HWPoison page, record them in a list, sends SIGBUS
>>>>>   to the consuming thread, but si_addr_lsb is reduced to PAGE_SHIFT.
>>>>>   If userspace is able to handle the SIGBUS, the HWPoison hugepage
>>>>>   remains accessible via the mapping created with that memfd.
>>>>>
>>>>> * If the memory was not faulted in yet, the fault handler also
>>>>>   allows fault in the HWPoison folio.
>>>>>
>>>>> For a MFD_MF_KEEP_UE_MAPPED enabled memfd, when it is closed, or
>>>>> when userspace process truncates its hugepages:
>>>>>
>>>>> * When the HugeTLB in-memory file system removes the filemap's
>>>>>   folios one by one, it asks MFR to deal with HWPoison folios
>>>>>   on the fly, implemented by filemap_offline_hwpoison_folio().
>>>>>
>>>>> * MFR drops the refcounts being held for the raw HWPoison
>>>>>   pages within the folio. Now that the HWPoison folio becomes
>>>>>   free, MFR dissolves it into a set of raw pages. The healthy pages
>>>>>   are recycled into buddy allocator, while the HWPoison ones are
>>>>>   prevented from re-allocation.
>>>>>
>>>> ...
>>>>
>>>>>
>>>>> +static void filemap_offline_hwpoison_folio_hugetlb(struct folio *folio)
>>>>> +{
>>>>> +     int ret;
>>>>> +     struct llist_node *head;
>>>>> +     struct raw_hwp_page *curr, *next;
>>>>> +
>>>>> +     /*
>>>>> +      * Since folio is still in the folio_batch, drop the refcount
>>>>> +      * elevated by filemap_get_folios.
>>>>> +      */
>>>>> +     folio_put_refs(folio, 1);
>>>>> +     head = llist_del_all(raw_hwp_list_head(folio));
>>>>
>>>> We might race with get_huge_page_for_hwpoison()? llist_add() might be called
>>>> by folio_set_hugetlb_hwpoison() just after llist_del_all()?
>>>
>>> Oh, when there is a new UE while we releasing the folio here, right?
>>
>> Right.
>>
>>> In that case, would mutex_lock(&mf_mutex) eliminate potential race?
>>
>> IMO spin_lock_irq(&hugetlb_lock) might be better.
> 
> Looks like I don't need any lock given the correction below.
> 
>>
>>>
>>>>
>>>>> +
>>>>> +     /*
>>>>> +      * Release refcounts held by try_memory_failure_hugetlb, one per
>>>>> +      * HWPoison-ed page in the raw hwp list.
>>>>> +      *
>>>>> +      * Set HWPoison flag on each page so that free_has_hwpoisoned()
>>>>> +      * can exclude them during dissolve_free_hugetlb_folio().
>>>>> +      */
>>>>> +     llist_for_each_entry_safe(curr, next, head, node) {
>>>>> +             folio_put(folio);
>>>>
>>>> The hugetlb folio refcnt will only be increased once even if it contains multiple UE sub-pages.
>>>> See __get_huge_page_for_hwpoison() for details. So folio_put() might be called more times than
>>>> folio_try_get() in __get_huge_page_for_hwpoison().
>>>
>>> The changes in folio_set_hugetlb_hwpoison() should make
>>> __get_huge_page_for_hwpoison() not to take the "out" path which
>>> decrease the increased refcount for folio. IOW, every time a new UE
>>> happens, we handle the hugetlb page as if it is an in-use hugetlb
>>> page.
>>
>> See below code snippet (comment [1] and [2]):
>>
>> int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>>                                  bool *migratable_cleared)
>> {
>>         struct page *page = pfn_to_page(pfn);
>>         struct folio *folio = page_folio(page);
>>         int ret = 2;    /* fallback to normal page handling */
>>         bool count_increased = false;
>>
>>         if (!folio_test_hugetlb(folio))
>>                 goto out;
>>
>>         if (flags & MF_COUNT_INCREASED) {
>>                 ret = 1;
>>                 count_increased = true;
>>         } else if (folio_test_hugetlb_freed(folio)) {
>>                 ret = 0;
>>         } else if (folio_test_hugetlb_migratable(folio)) {
>>
>>                    ^^^^*hugetlb_migratable is checked before trying to get folio refcnt* [1]
>>
>>                 ret = folio_try_get(folio);
>>                 if (ret)
>>                         count_increased = true;
>>         } else {
>>                 ret = -EBUSY;
>>                 if (!(flags & MF_NO_RETRY))
>>                         goto out;
>>         }
>>
>>         if (folio_set_hugetlb_hwpoison(folio, page)) {
>>                 ret = -EHWPOISON;
>>                 goto out;
>>         }
>>
>>         /*
>>          * Clearing hugetlb_migratable for hwpoisoned hugepages to prevent them
>>          * from being migrated by memory hotremove.
>>          */
>>         if (count_increased && folio_test_hugetlb_migratable(folio)) {
>>                 folio_clear_hugetlb_migratable(folio);
>>
>>                 ^^^^^*hugetlb_migratable is cleared when first time seeing folio* [2]
>>
>>                 *migratable_cleared = true;
>>         }
>>
>> Or am I miss something?
> 
> Thanks for your explaination! You are absolutely right. It turns out
> the extra refcount I saw (during running hugetlb-mfr.c) on the folio
> at the moment of filemap_offline_hwpoison_folio_hugetlb() is actually
> because of the MF_COUNT_INCREASED during MADV_HWPOISON. In the past I
> used to think that is the effect of folio_try_get() in
> __get_huge_page_for_hwpoison(), and it is wrong. Now I see two cases:
> - MADV_HWPOISON: instead of __get_huge_page_for_hwpoison(),
> madvise_inject_error() is the one that increments hugepage refcount
> for every error injected. Different from other cases,
> MFD_MF_KEEP_UE_MAPPED makes the hugepage still a in-use page after
> memory_failure(MF_COUNT_INCREASED), so I think madvise_inject_error()
> should decrement in MFD_MF_KEEP_UE_MAPPED case.
> - In the real world: as you pointed out, MF always just increments
> hugepage refcount once in __get_huge_page_for_hwpoison(), even if it
> runs into multiple errors. When

This might not always hold true. When MF occurs while hugetlb folio is under isolation(hugetlb_migratable is
cleared and extra folio refcnt is held by isolating code in that case), __get_huge_page_for_hwpoison won't get
extra folio refcnt.

> filemap_offline_hwpoison_folio_hugetlb() drops the refcount elevated
> by filemap_get_folios(), it only needs to decrement again if
> folio_ref_dec_and_test() returns false. I tested something like below:
> 
>     /* drop the refcount elevated by filemap_get_folios. */
>     folio_put(folio);
>     if (folio_ref_count(folio))
>         folio_put(folio);
>     /* now refcount should be zero. */
>     ret = dissolve_free_hugetlb_folio(folio);

So I think above code might drop the folio refcnt held by isolating code.

Thanks.
.

