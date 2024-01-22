Return-Path: <linux-fsdevel+bounces-8393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86554835B7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 08:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2784C1F219DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 07:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE5FF505;
	Mon, 22 Jan 2024 07:17:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73002564;
	Mon, 22 Jan 2024 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907844; cv=none; b=p+/bz/pYTxFffi+s7eQLZqf2o3rIZmihJ/3xO6FWB4shGsbtQa9DuNI0sP/pkEWerEzukbzDoa/bmpVgKTTpW7UgLQj+kB2G5LIdsQ/dcax6Sjs7mr7fcYsf63EXsdwwLXabF0HR6omjKklA0WAede4VURO1lhjbknzkBAeY2RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907844; c=relaxed/simple;
	bh=EIzMyARXnac3YZNByVm9pg65cpv8PgZg6NgmGDtv5xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dt5pZnRG0wfB0cH2M/P5w9q0VDDRovnTMoAALM0HdGhuOXN08LlJcwMNwclrm7xcssVIK2r1Znmu7nT8eVIs6A+zEdBpoMQTBT97h+MRD4Bu7pDqhP0GThQmuf82FtHXqLuP7ch3haFqYU9WeXZOKW+dF5Pae2M2y8tABjlr8Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W.2pzwi_1705907838;
Received: from 30.97.48.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W.2pzwi_1705907838)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 15:17:18 +0800
Message-ID: <8f52414c-e0f2-4931-9b32-5c22f1d581f0@linux.alibaba.com>
Date: Mon, 22 Jan 2024 15:17:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: improve dump_mapping() robustness
To: Charan Teja Kalla <quic_charante@quicinc.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
 jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <937ab1f87328516821d39be672b6bc18861d9d3e.1705391420.git.baolin.wang@linux.alibaba.com>
 <20240118013857.GO1674809@ZenIV>
 <d5979f89-7a84-423a-a1c7-29bdbf7c2bc1@linux.alibaba.com>
 <c85fffe6-e455-d0fa-e332-87e81e0a0e86@quicinc.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <c85fffe6-e455-d0fa-e332-87e81e0a0e86@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/19/2024 11:48 PM, Charan Teja Kalla wrote:
> Hi Matthew/Baolin,
> 
> On 1/18/2024 8:13 AM, Baolin Wang wrote:
>>
>>
>> On 1/18/2024 9:38 AM, Al Viro wrote:
>>> On Tue, Jan 16, 2024 at 03:53:35PM +0800, Baolin Wang wrote:
>>>
>>>> With checking the 'dentry.parent' and 'dentry.d_name.name' used by
>>>> dentry_name(), I can see dump_mapping() will output the invalid dentry
>>>> instead of crashing the system when this issue is reproduced again.
>>>
>>>>        dentry_ptr = container_of(dentry_first, struct dentry,
>>>> d_u.d_alias);
>>>> -    if (get_kernel_nofault(dentry, dentry_ptr)) {
>>>> +    if (get_kernel_nofault(dentry, dentry_ptr) ||
>>>> +        !dentry.d_parent || !dentry.d_name.name) {
>>>>            pr_warn("aops:%ps ino:%lx invalid dentry:%px\n",
>>>>                    a_ops, ino, dentry_ptr);
>>>>            return;
>>>
>>> That's nowhere near enough.  Your ->d_name.name can bloody well be
>>> pointing
>>> to an external name that gets freed right under you.  Legitimately so.
>>>
>>> Think what happens if dentry has a long name (longer than would fit into
>>> the embedded array) and gets renamed name just after you copy it into
>>> a local variable.  Old name will get freed.  Yes, freeing is RCU-delayed,
>>> but I don't see anything that would prevent your thread losing CPU
>>> and not getting it back until after the sucker's been freed.
>>
>> Yes, that's possible. And this appears to be a use-after-free issue in
>> the existing code, which is different from the issue that my patch
>> addressed.
>>
>> So how about adding a rcu_read_lock() before copying the dentry to a
>> local variable in case the old name is freed?
>>
> 
> We too seen the below crash while printing the dentry name.
> 
> aops:shmem_aops ino:5e029 dentry name:"dev/zero"
> flags:
> 0x8000000000080006(referenced|uptodate|swapbacked|zone=2|kasantag=0x0)
> raw: 8000000000080006 ffffffc033b1bb60 ffffffc033b1bb60 ffffff8862537600
> raw: 0000000000000001 0000000000000000 00000003ffffffff ffffff807fe64000
> page dumped because: migration failure
> migrating pfn aef223 failed ret:1
> page:000000009e72a120 refcount:3 mapcount:0 mapping:000000003325dda1
> index:0x1 pfn:0xaef223
> memcg:ffffff807fe64000
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000000
> Mem abort info:
>    ESR = 0x0000000096000005
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x05: level 1 translation fault
> Data abort info:
>    ISV = 0, ISS = 0x00000005
>    CM = 0, WnR = 0
> user pgtable: 4k pages, 39-bit VAs, pgdp=000000090c12d000
> [0000000000000000] pgd=0000000000000000, p4d=0000000000000000,
> pud=0000000000000000
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> 
> dentry_name+0x1f8/0x3a8
> pointer+0x3b0/0x6b8
> vsnprintf+0x4a4/0x65c
> vprintk_store+0x168/0x4a8
> vprintk_emit+0x98/0x218
> vprintk_default+0x44/0x70
> vprintk+0xf0/0x138
> _printk+0x54/0x80
> dump_mapping+0x17c/0x188
> dump_page+0x1d0/0x2e8
> offline_pages+0x67c/0x898
> 
> 
> 
> Not much comfortable with block layer internals, TMK, the below is what
> happening in the my case:
> memoffline	     		dput()
> (offline_pages)		 (as part of closing of the shmem file)
> ------------		 --------------------------------------
> 					.......
> 			1) dentry_unlink_inode()
> 			      hlist_del_init(&dentry->d_u.d_alias);
> 
> 			2) iput():
> 			    a) inode->i_state |= I_FREEING
> 				.....
> 			    b) evict_inode()->..->shmem_undo_range
> 			       1) get the folios with elevated refcount
> 3) do_migrate_range():
>     a) Because of the elevated
>     refcount in 2.b.1, the
>     migration of this page will
>     be failed.
> 
> 			       2) truncate_inode_folio() ->
> 				     filemap_remove_folio():
>   				(deletes from the page cache,
> 				 set page->mapping=NULL,
> 				 decrement the refcount on folio)
>    b) Call dump_page():
>       1) mapping = page_mapping(page);
>       2) dump_mapping(mapping)
> 	  a) We unlinked the dentry in 1)
>             thus dentry_ptr from host->i_dentry.first
>             is not a proper one.
> 
>           b) dentry name print with %pd is resulting into
> 	   the mentioned crash.
> 
> 
> At least in this case, I think __this patchset in its current form can
> help us__.

This looks another case of NULL pointer access. Thanks for the detailed 
analysis. Could you provide a Tested-by or Reviewed-by tag if it can 
solve your problem?

