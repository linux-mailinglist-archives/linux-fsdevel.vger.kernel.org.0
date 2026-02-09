Return-Path: <linux-fsdevel+bounces-76701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGJfCZTViWklCAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 13:39:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B85EC10ED44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 13:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9529330036C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 11:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5102372B44;
	Mon,  9 Feb 2026 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PJQejhtF";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PJQejhtF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355E230C626;
	Mon,  9 Feb 2026 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770638080; cv=none; b=H+ZZfQN8YP+pyQAPb/+tcVujSBz58xQfbHyyIrXmMGNQA9KneI8XHHoCAvNpEnIyXQA41ISHuGwOlP7KPU8MdvtbDrXibyb3DuURXEdf6tkkYhqjLpy5z7vHsQf1T78wi9A03reB5FTKbR3EGz5BDaYT5nC7MPy6EvMVpSSUUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770638080; c=relaxed/simple;
	bh=Wbgd7ZMDdQl9PFvLa4LseO/xZdDASQbGH8mtuMW1GXY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=R6coQe+6h13p60dMKqiwWnMk8eMFdyZtQkjaGM8WxWxkLfgD9xDFp3WM2kIthGackuxIKx9IaNS/A8GFiW7SSCkG0TfAgL89XZrytEGXgC80ix0g+cLppj44VQcJhnGgUW0BeyoPocUPGzilqOF/N3CIYpN85SZodiwZcRXBWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PJQejhtF; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PJQejhtF; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=87jS9hA6CNFtZFnnBnwUEZeCAKiOLm/Lt+umcyTbarg=;
	b=PJQejhtFjpPok7RdAijwT4qVRey94d/d5Q2JD6Bgs7i9GG9/A9Yn6EDExt4Ws7Xh+HuHdPvrp
	wstjXUuVW2s5YVPxmZhor7wF7Wm2wbIbZvkoU2pl05doyqfkjbd0244GwUnWN/a4vcBPGEto2lU
	A2rxUzdf3cNE+sWShagONgI=
Received: from canpmsgout02.his.huawei.com (unknown [172.19.92.185])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4f8jl63Pdrz1BFRg;
	Mon,  9 Feb 2026 19:53:38 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=87jS9hA6CNFtZFnnBnwUEZeCAKiOLm/Lt+umcyTbarg=;
	b=PJQejhtFjpPok7RdAijwT4qVRey94d/d5Q2JD6Bgs7i9GG9/A9Yn6EDExt4Ws7Xh+HuHdPvrp
	wstjXUuVW2s5YVPxmZhor7wF7Wm2wbIbZvkoU2pl05doyqfkjbd0244GwUnWN/a4vcBPGEto2lU
	A2rxUzdf3cNE+sWShagONgI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4f8jfl2PRhzcbNJ;
	Mon,  9 Feb 2026 19:49:51 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B64C40567;
	Mon,  9 Feb 2026 19:54:23 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Feb 2026 19:54:22 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Feb 2026 19:54:21 +0800
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
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7ad34b69-2fb4-770b-14e5-bea13cf63d2f@huawei.com>
Date: Mon, 9 Feb 2026 19:54:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260203192352.2674184-2-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500010.china.huawei.com (7.202.194.235)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76701-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,huawei.com,infradead.org,linux-foundation.org,suse.de,google.com,nvidia.com,redhat.com,oracle.com,linux.intel.com,linux.dev,kvack.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmiaohe@huawei.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B85EC10ED44
X-Rspamd-Action: no action

On 2026/2/4 3:23, Jiaqi Yan wrote:
> Sometimes immediately hard offlining a large chunk of contigous memory
> having uncorrected memory errors (UE) may not be the best option.
> Cloud providers usually serve capacity- and performance-critical guest
> memory with 1G HugeTLB hugepages, as this significantly reduces the
> overhead associated with managing page tables and TLB misses. However,
> for today's HugeTLB system, once a byte of memory in a hugepage is
> hardware corrupted, the kernel discards the whole hugepage, including
> the healthy portion. Customer workload running in the VM can hardly
> recover from such a great loss of memory.

Thanks for your patch. Some questions below.

> 
> Therefore keeping or discarding a large chunk of contiguous memory
> owned by userspace (particularly to serve guest memory) due to
> recoverable UE may better be controlled by userspace process
> that owns the memory, e.g. VMM in the Cloud environment.
> 
> Introduce a memfd-based userspace memory failure (MFR) policy,
> MFD_MF_KEEP_UE_MAPPED. It is possible to support for other memfd,
> but the current implementation only covers HugeTLB.
> 
> For a hugepage associated with MFD_MF_KEEP_UE_MAPPED enabled memfd,
> whenever it runs into a new UE,
> 
> * MFR defers hard offline operations, i.e., unmapping and

So the folio can't be unpoisoned until hugetlb folio becomes free?

>   dissolving. MFR still sets HWPoison flag, holds a refcount
>   for every raw HWPoison page, record them in a list, sends SIGBUS
>   to the consuming thread, but si_addr_lsb is reduced to PAGE_SHIFT.
>   If userspace is able to handle the SIGBUS, the HWPoison hugepage
>   remains accessible via the mapping created with that memfd.
> 
> * If the memory was not faulted in yet, the fault handler also
>   allows fault in the HWPoison folio.
> 
> For a MFD_MF_KEEP_UE_MAPPED enabled memfd, when it is closed, or
> when userspace process truncates its hugepages:
> 
> * When the HugeTLB in-memory file system removes the filemap's
>   folios one by one, it asks MFR to deal with HWPoison folios
>   on the fly, implemented by filemap_offline_hwpoison_folio().
> 
> * MFR drops the refcounts being held for the raw HWPoison
>   pages within the folio. Now that the HWPoison folio becomes
>   free, MFR dissolves it into a set of raw pages. The healthy pages
>   are recycled into buddy allocator, while the HWPoison ones are
>   prevented from re-allocation.
> 
...

>  
> +static void filemap_offline_hwpoison_folio_hugetlb(struct folio *folio)
> +{
> +	int ret;
> +	struct llist_node *head;
> +	struct raw_hwp_page *curr, *next;
> +
> +	/*
> +	 * Since folio is still in the folio_batch, drop the refcount
> +	 * elevated by filemap_get_folios.
> +	 */
> +	folio_put_refs(folio, 1);
> +	head = llist_del_all(raw_hwp_list_head(folio));

We might race with get_huge_page_for_hwpoison()? llist_add() might be called
by folio_set_hugetlb_hwpoison() just after llist_del_all()?

> +
> +	/*
> +	 * Release refcounts held by try_memory_failure_hugetlb, one per
> +	 * HWPoison-ed page in the raw hwp list.
> +	 *
> +	 * Set HWPoison flag on each page so that free_has_hwpoisoned()
> +	 * can exclude them during dissolve_free_hugetlb_folio().
> +	 */
> +	llist_for_each_entry_safe(curr, next, head, node) {
> +		folio_put(folio);

The hugetlb folio refcnt will only be increased once even if it contains multiple UE sub-pages.
See __get_huge_page_for_hwpoison() for details. So folio_put() might be called more times than
folio_try_get() in __get_huge_page_for_hwpoison().

> +		SetPageHWPoison(curr->page);

If hugetlb folio vmemmap is optimized, I think SetPageHWPoison might trigger BUG.

> +		kfree(curr);
> +	}

Above logic is almost same as folio_clear_hugetlb_hwpoison. Maybe we can reuse that?

> +
> +	/* Refcount now should be zero and ready to dissolve folio. */
> +	ret = dissolve_free_hugetlb_folio(folio);
> +	if (ret)
> +		pr_err("failed to dissolve hugetlb folio: %d\n", ret);
> +}
> +

Thanks.
.


