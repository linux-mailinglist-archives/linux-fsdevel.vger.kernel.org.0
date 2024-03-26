Return-Path: <linux-fsdevel+bounces-15359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A051488C96D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 17:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BCE2E33E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5311CD2E;
	Tue, 26 Mar 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="YG/rrmZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E0D1C6B0;
	Tue, 26 Mar 2024 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470794; cv=none; b=n7j9EOtiEvtgN3EDVHV0hlg5M2f6F0YifWtGiirosQ3qPBTvFyqABDFnF5q5bCDN2VRJuUTCDO9Wg5We/dz+p5lVG0ZPLsmPxXkB0IptrKC7Q4xaGu944GcyCb2ZjTkhIO1wmBfm3V057nH+eMBBgIrCyMqRKmPCXwmS3QjW48g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470794; c=relaxed/simple;
	bh=b6+z+ErMJZ6d/LvPwD2TtjcfY1+d2dVNtImvoKvEkcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/4IshTBmX6t2A6G6zifpov4OQAMSL73UxjeW0Yz6gXG+lH+50c2oe+QQiWBem35J2KXHLsGgt4z2E2Z9oEIX1br5f7anJa8fyuR5Twj6eWfFLL8oehA5hRv/xEznWua6v8TmpCqFthyvkdiYMD1n4IRg4ykXLHraeFCzEjDmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=YG/rrmZS; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4V3wMk65pcz9sS4;
	Tue, 26 Mar 2024 17:33:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1711470786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3moU2wlvHsr8+p9ny8JT8xaCQs7lbw0goaeSoNHDbDc=;
	b=YG/rrmZS5RDXubydtX68X+RaWK/eokcLFx8xmRnde3361DFaGekau5YHR1Fi0jFuv1TU2K
	IxNElpVIEPCddV8SOUtdRHe8uazMsQLkiP3vP5EVBSOw4CH8hCGTaYOEuYe47ZBo67zIGC
	uId8BkyuZYZ79+v4C5NL2iViEaj9u7n2kzI+zDXf+jfPharGpymhh6LSXkI2DNYjKAwC70
	0nzI2WZBoAFFNl+1A2WDU3Zx/59oXxsndeEV0UVfbTIhHkDhw/vGXfu+fCp9oGrIg//oDO
	R7v6sZcSaWxX+Q9Bc/h7jbAIfM85ToFgR8x+30XVQiDhJPSgBehcvkYfhcR2Pg==
Message-ID: <c0c777d9-8393-47f0-b5c3-1617c3a7b3ba@pankajraghav.com>
Date: Tue, 26 Mar 2024 17:33:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 07/11] mm: do not split a folio if it has minimum folio
 order requirement
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gost.dev@samsung.com,
 chandan.babu@oracle.com, hare@suse.de, mcgrof@kernel.org, djwong@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@fromorbit.com,
 akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-8-kernel@pankajraghav.com>
 <ZgHLHNYdK-kU3UAi@casper.infradead.org>
 <muprk3zff7dsn3futp3by3t6bxuy5m62rpylmrp77ss3kay24k@wx4fn7uw7y6r>
 <EE249FE8-2FE9-4BB0-B27A-6202F93B6C12@nvidia.com>
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <EE249FE8-2FE9-4BB0-B27A-6202F93B6C12@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4V3wMk65pcz9sS4

On 26/03/2024 17:23, Zi Yan wrote:
> On 26 Mar 2024, at 12:10, Pankaj Raghav (Samsung) wrote:
> 
>> On Mon, Mar 25, 2024 at 07:06:04PM +0000, Matthew Wilcox wrote:
>>> On Wed, Mar 13, 2024 at 06:02:49PM +0100, Pankaj Raghav (Samsung) wrote:
>>>> From: Pankaj Raghav <p.raghav@samsung.com>
>>>>
>>>> As we don't have a way to split a folio to a any given lower folio
>>>> order yet, avoid splitting the folio in split_huge_page_to_list() if it
>>>> has a minimum folio order requirement.
>>>
>>> FYI, Zi Yan's patch to do that is now in Andrew's tree.
>>> c010d47f107f609b9f4d6a103b6dfc53889049e9 in current linux-next (dated
>>> Feb 26)
>>
>> Yes, I started playing with the patches but I am getting a race condition
>> resulting in a null-ptr-deref for which I don't have a good answer for
>> yet.
>>
>> @zi yan Did you encounter any issue like this when you were testing?
>>
>> I did the following change (just a prototype) instead of this patch:
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 9859aa4f7553..63ee7b6ed03d 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3041,6 +3041,10 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>  {
>>         struct folio *folio = page_folio(page);
>>         struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>> +       unsigned int mapping_min_order = mapping_min_folio_order(folio->mapping);
> 
> I am not sure if this is right. Since folio can be anonymous and folio->mapping
> does not point to struct address_space.
> 
>> +
>> +       if (!folio_test_anon(folio))

Hmm, but I update the new_order only if it is not anonymous. Do you think it is still
wrong?

>> +               new_order = max_t(unsigned int, mapping_min_order, new_order);
>>         /* reset xarray order to new order after split */
>>         XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
>>         struct anon_vma *anon_vma = NULL;
>> @@ -3117,6 +3121,8 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>                         goto out;
>>                 }
>>
>> +               // XXX: Remove it later
>> +               VM_WARN_ON_FOLIO((new_order < mapping_min_order), folio);
>>                 gfp = current_gfp_context(mapping_gfp_mask(mapping) &
>>                                                         GFP_RECLAIM_MASK);
>>
>> I am getting a random null-ptr deref when I run generic/176 multiple
>> times with different blksizes. I still don't have a minimal reproducer
>> for this issue. Race condition during writeback:
>>
>> filemap_get_folios_tag+0x171/0x5c0:
>> arch_atomic_read at arch/x86/include/asm/atomic.h:23
>> (inlined by) raw_atomic_read at include/linux/atomic/atomic-arch-fallback.h:457
>> (inlined by) raw_atomic_fetch_add_unless at include/linux/atomic/atomic-arch-fallback.h:2426
>> (inlined by) raw_atomic_add_unless at include/linux/atomic/atomic-arch-fallback.h:2456
>> (inlined by) atomic_add_unless at include/linux/atomic/atomic-instrumented.h:1518
>> (inlined by) page_ref_add_unless at include/linux/page_ref.h:238
>> (inlined by) folio_ref_add_unless at include/linux/page_ref.h:247
>> (inlined by) folio_ref_try_add_rcu at include/linux/page_ref.h:280
>> (inlined by) folio_try_get_rcu at include/linux/page_ref.h:313
>> (inlined by) find_get_entry at mm/filemap.c:1984
>> (inlined by) filemap_get_folios_tag at mm/filemap.c:2222
>>
>>
>>
>> [  537.863105] ==================================================================
>> [  537.863968] BUG: KASAN: null-ptr-deref in filemap_get_folios_tag+0x171/0x5c0
>> [  537.864581] Write of size 4 at addr 0000000000000036 by task kworker/u32:5/366
>> [  537.865123]
>> [  537.865293] CPU: 6 PID: 366 Comm: kworker/u32:5 Not tainted 6.8.0-11739-g7d0c6e7b5a7d-dirty #795
>> [  537.867201] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>> [  537.868444] Workqueue: writeback wb_workfn (flush-254:32)
>> [  537.869055] Call Trace:
>> [  537.869341]  <TASK>
>> [  537.869569]  dump_stack_lvl+0x4f/0x70
>> [  537.869938]  kasan_report+0xbd/0xf0
>> [  537.870293]  ? filemap_get_folios_tag+0x171/0x5c0
>> [  537.870767]  ? filemap_get_folios_tag+0x171/0x5c0
>> [  537.871578]  kasan_check_range+0x101/0x1b0
>> [  537.871893]  filemap_get_folios_tag+0x171/0x5c0
>> [  537.872269]  ? __pfx_filemap_get_folios_tag+0x10/0x10
>> [  537.872857]  ? __pfx___submit_bio+0x10/0x10
>> [  537.873326]  ? mlock_drain_local+0x234/0x3f0
>> [  537.873938]  writeback_iter+0x59a/0xe00
>> [  537.874477]  ? __pfx_iomap_do_writepage+0x10/0x10
>> [  537.874969]  write_cache_pages+0x7f/0x100
>> [  537.875396]  ? __pfx_write_cache_pages+0x10/0x10
>> [  537.875892]  ? do_raw_spin_lock+0x12d/0x270
>> [  537.876345]  ? __pfx_do_raw_spin_lock+0x10/0x10
>> [  537.876804]  iomap_writepages+0x88/0xf0
>> [  537.877186]  xfs_vm_writepages+0x120/0x190
>> [  537.877705]  ? __pfx_xfs_vm_writepages+0x10/0x10
>> [  537.878161]  ? lock_release+0x36f/0x670
>> [  537.878521]  ? __wb_calc_thresh+0xe5/0x3b0
>> [  537.878892]  ? __pfx_lock_release+0x10/0x10
>> [  537.879308]  do_writepages+0x170/0x7a0
>> [  537.879676]  ? __pfx_do_writepages+0x10/0x10
>> [  537.880182]  ? writeback_sb_inodes+0x312/0xe40
>> [  537.880689]  ? reacquire_held_locks+0x1f1/0x4a0
>> [  537.881193]  ? writeback_sb_inodes+0x312/0xe40
>> [  537.881665]  ? find_held_lock+0x2d/0x110
>> [  537.882104]  ? lock_release+0x36f/0x670
>> [  537.883344]  ? wbc_attach_and_unlock_inode+0x3b8/0x710
>> [  537.883853]  ? __pfx_lock_release+0x10/0x10
>> [  537.884229]  ? __pfx_lock_release+0x10/0x10
>> [  537.884604]  ? lock_acquire+0x138/0x2f0
>> [  537.884952]  __writeback_single_inode+0xd4/0xa60
>> [  537.885369]  writeback_sb_inodes+0x4cf/0xe40
>> [  537.885760]  ? __pfx_writeback_sb_inodes+0x10/0x10
>> [  537.886208]  ? __pfx_move_expired_inodes+0x10/0x10
>> [  537.886640]  __writeback_inodes_wb+0xb4/0x200
>> [  537.887037]  wb_writeback+0x55b/0x7c0
>> [  537.887372]  ? __pfx_wb_writeback+0x10/0x10
>> [  537.887750]  ? lock_acquire+0x138/0x2f0
>> [  537.888094]  ? __pfx_register_lock_class+0x10/0x10
>> [  537.888521]  wb_workfn+0x648/0xbb0
>> [  537.888835]  ? __pfx_wb_workfn+0x10/0x10
>> [  537.889192]  ? lock_acquire+0x128/0x2f0
>> [  537.889539]  ? lock_acquire+0x138/0x2f0
>> [  537.889890]  process_one_work+0x7ff/0x1710
>> [  537.890272]  ? __pfx_process_one_work+0x10/0x10
>> [  537.890685]  ? assign_work+0x16c/0x240
>> [  537.891026]  worker_thread+0x6e8/0x12b0
>> [  537.891381]  ? __pfx_worker_thread+0x10/0x10
>> [  537.891768]  kthread+0x2ad/0x380
>> [  537.892064]  ? __pfx_kthread+0x10/0x10
>> [  537.892403]  ret_from_fork+0x2d/0x70
>> [  537.892728]  ? __pfx_kthread+0x10/0x10
>> [  537.893068]  ret_from_fork_asm+0x1a/0x30
>> [  537.893434]  </TASK>
> 
> 
> --
> Best Regards,
> Yan, Zi

