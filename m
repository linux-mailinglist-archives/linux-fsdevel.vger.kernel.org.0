Return-Path: <linux-fsdevel+bounces-76822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLguHP7eimlIOgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 08:32:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C00A0117F4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 08:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 014E63037E4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219523346A0;
	Tue, 10 Feb 2026 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QqAZweSc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89F01F1534;
	Tue, 10 Feb 2026 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770708699; cv=none; b=OhJLb+FlV6j5n++xojcWDg/qPqt1dyVhDYC9rKu19QCaUvYKegQG1s+a2zRM4xuXqIHujwaUNWV0l1j0mi9HJ6bfn/nF2iGVgZZDrw5iqNn51ExTgB6fJqaUg8LxyYBi02LjKtYqy3cvKGcLcPRF3phvBsz1DWgJC6y165Fz5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770708699; c=relaxed/simple;
	bh=aCoqhIAMFIViG1SQn+JcM52uIO6I31WHZ5Jil7A8iBc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=U7V8Sw003YN+yDjm0lgtkjXq3CqeOAI+3GJG2VcqTYlAY5pgwo+W+jmJuNZr46f/8QJ3HVAd6zgsst2d145JYvsqtmdIjHiN1eK5Y96ODMo71gTJhQPqVR7HdnCO756Yl+XVGfv0WofClPfvASK0rnWdlhRBlehNFbeVPjVmyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QqAZweSc; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JnPhcm04RgXUByNiUINhP/lHOk9f0CuIXS0OCcNO/mI=;
	b=QqAZweScfKIM0otUDQqRMBYp4ndRK7LYYcRAz9om1y/6VCdCqZmLRdebrW1x/l1F6G7yJZcbL
	dW3H7vlomSaq0K2bkM43blnD/hAM7e4DQ1uvAda6EULhNQR29GEe3l67MEjd906ROoaUqHRH6yr
	wZ/sZSH0NHCUEjNIWYH7sDc=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4f9Cn040KTz1T4JY;
	Tue, 10 Feb 2026 15:27:00 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 430AB4036C;
	Tue, 10 Feb 2026 15:31:31 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Feb 2026 15:31:31 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Feb 2026 15:31:29 +0800
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
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <31cc7bed-c30f-489c-3ac3-4842aa00b869@huawei.com>
Date: Tue, 10 Feb 2026 15:31:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACw3F50PwJ+sSOX0wySQgBzrEW2XOctxuX5jM37OG0HS_kHdbQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
	TAGGED_FROM(0.00)[bounces-76822-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,huawei.com,infradead.org,linux-foundation.org,suse.de,google.com,nvidia.com,redhat.com,oracle.com,linux.intel.com,linux.dev,kvack.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim,huawei.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmiaohe@huawei.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C00A0117F4C
X-Rspamd-Action: no action

On 2026/2/10 12:47, Jiaqi Yan wrote:
> On Mon, Feb 9, 2026 at 3:54 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2026/2/4 3:23, Jiaqi Yan wrote:
>>> Sometimes immediately hard offlining a large chunk of contigous memory
>>> having uncorrected memory errors (UE) may not be the best option.
>>> Cloud providers usually serve capacity- and performance-critical guest
>>> memory with 1G HugeTLB hugepages, as this significantly reduces the
>>> overhead associated with managing page tables and TLB misses. However,
>>> for today's HugeTLB system, once a byte of memory in a hugepage is
>>> hardware corrupted, the kernel discards the whole hugepage, including
>>> the healthy portion. Customer workload running in the VM can hardly
>>> recover from such a great loss of memory.
>>
>> Thanks for your patch. Some questions below.
>>
>>>
>>> Therefore keeping or discarding a large chunk of contiguous memory
>>> owned by userspace (particularly to serve guest memory) due to
>>> recoverable UE may better be controlled by userspace process
>>> that owns the memory, e.g. VMM in the Cloud environment.
>>>
>>> Introduce a memfd-based userspace memory failure (MFR) policy,
>>> MFD_MF_KEEP_UE_MAPPED. It is possible to support for other memfd,
>>> but the current implementation only covers HugeTLB.
>>>
>>> For a hugepage associated with MFD_MF_KEEP_UE_MAPPED enabled memfd,
>>> whenever it runs into a new UE,
>>>
>>> * MFR defers hard offline operations, i.e., unmapping and
>>
>> So the folio can't be unpoisoned until hugetlb folio becomes free?
> 
> Are you asking from testing perspective, are we still able to clean up
> injected test errors via unpoison_memory() with MFD_MF_KEEP_UE_MAPPED?
> 
> If so, unpoison_memory() can't turn the HWPoison hugetlb page to
> normal hugetlb page as MFD_MF_KEEP_UE_MAPPED automatically dissolves

We might loss some testability but that should be an acceptable compromise.

> it. unpoison_memory(pfn) can probably still turn the HWPoison raw page
> back to a normal one, but you already lost the hugetlb page.
> 
>>
>>>   dissolving. MFR still sets HWPoison flag, holds a refcount
>>>   for every raw HWPoison page, record them in a list, sends SIGBUS
>>>   to the consuming thread, but si_addr_lsb is reduced to PAGE_SHIFT.
>>>   If userspace is able to handle the SIGBUS, the HWPoison hugepage
>>>   remains accessible via the mapping created with that memfd.
>>>
>>> * If the memory was not faulted in yet, the fault handler also
>>>   allows fault in the HWPoison folio.
>>>
>>> For a MFD_MF_KEEP_UE_MAPPED enabled memfd, when it is closed, or
>>> when userspace process truncates its hugepages:
>>>
>>> * When the HugeTLB in-memory file system removes the filemap's
>>>   folios one by one, it asks MFR to deal with HWPoison folios
>>>   on the fly, implemented by filemap_offline_hwpoison_folio().
>>>
>>> * MFR drops the refcounts being held for the raw HWPoison
>>>   pages within the folio. Now that the HWPoison folio becomes
>>>   free, MFR dissolves it into a set of raw pages. The healthy pages
>>>   are recycled into buddy allocator, while the HWPoison ones are
>>>   prevented from re-allocation.
>>>
>> ...
>>
>>>
>>> +static void filemap_offline_hwpoison_folio_hugetlb(struct folio *folio)
>>> +{
>>> +     int ret;
>>> +     struct llist_node *head;
>>> +     struct raw_hwp_page *curr, *next;
>>> +
>>> +     /*
>>> +      * Since folio is still in the folio_batch, drop the refcount
>>> +      * elevated by filemap_get_folios.
>>> +      */
>>> +     folio_put_refs(folio, 1);
>>> +     head = llist_del_all(raw_hwp_list_head(folio));
>>
>> We might race with get_huge_page_for_hwpoison()? llist_add() might be called
>> by folio_set_hugetlb_hwpoison() just after llist_del_all()?
> 
> Oh, when there is a new UE while we releasing the folio here, right?

Right.

> In that case, would mutex_lock(&mf_mutex) eliminate potential race?

IMO spin_lock_irq(&hugetlb_lock) might be better.

> 
>>
>>> +
>>> +     /*
>>> +      * Release refcounts held by try_memory_failure_hugetlb, one per
>>> +      * HWPoison-ed page in the raw hwp list.
>>> +      *
>>> +      * Set HWPoison flag on each page so that free_has_hwpoisoned()
>>> +      * can exclude them during dissolve_free_hugetlb_folio().
>>> +      */
>>> +     llist_for_each_entry_safe(curr, next, head, node) {
>>> +             folio_put(folio);
>>
>> The hugetlb folio refcnt will only be increased once even if it contains multiple UE sub-pages.
>> See __get_huge_page_for_hwpoison() for details. So folio_put() might be called more times than
>> folio_try_get() in __get_huge_page_for_hwpoison().
> 
> The changes in folio_set_hugetlb_hwpoison() should make
> __get_huge_page_for_hwpoison() not to take the "out" path which
> decrease the increased refcount for folio. IOW, every time a new UE
> happens, we handle the hugetlb page as if it is an in-use hugetlb
> page.

See below code snippet (comment [1] and [2]):

int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
				 bool *migratable_cleared)
{
	struct page *page = pfn_to_page(pfn);
	struct folio *folio = page_folio(page);
	int ret = 2;	/* fallback to normal page handling */
	bool count_increased = false;

	if (!folio_test_hugetlb(folio))
		goto out;

	if (flags & MF_COUNT_INCREASED) {
		ret = 1;
		count_increased = true;
	} else if (folio_test_hugetlb_freed(folio)) {
		ret = 0;
	} else if (folio_test_hugetlb_migratable(folio)) {

		   ^^^^*hugetlb_migratable is checked before trying to get folio refcnt* [1]

		ret = folio_try_get(folio);
		if (ret)
			count_increased = true;
	} else {
		ret = -EBUSY;
		if (!(flags & MF_NO_RETRY))
			goto out;
	}

	if (folio_set_hugetlb_hwpoison(folio, page)) {
		ret = -EHWPOISON;
		goto out;
	}

	/*
	 * Clearing hugetlb_migratable for hwpoisoned hugepages to prevent them
	 * from being migrated by memory hotremove.
	 */
	if (count_increased && folio_test_hugetlb_migratable(folio)) {
		folio_clear_hugetlb_migratable(folio);

		^^^^^*hugetlb_migratable is cleared when first time seeing folio* [2]

		*migratable_cleared = true;
	}

Or am I miss something?

> 
>>
>>> +             SetPageHWPoison(curr->page);
>>
>> If hugetlb folio vmemmap is optimized, I think SetPageHWPoison might trigger BUG.
> 
> Ah, I see, vmemmap optimization doesn't allow us to move flags from
> raw_hwp_list to tail pages. I guess the best I can do is to bail out
> if vmemmap is enabled like folio_clear_hugetlb_hwpoison().

I think you can do this after hugetlb_vmemmap_restore_folio() is called.

Thanks.
.

