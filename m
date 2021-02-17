Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640AC31D429
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 04:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhBQDIA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 22:08:00 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:2411 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229946AbhBQDH7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 22:07:59 -0500
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; 
   d="scan'208";a="104561806"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Feb 2021 11:07:08 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 8C4954CE6F9B;
        Wed, 17 Feb 2021 11:07:02 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Feb
 2021 11:06:55 +0800
Subject: Re: [PATCH 4/7] fsdax: Replace mmap entry in case of CoW
To:     <dsterba@suse.cz>, <linux-kernel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-fsdevel@vger.kernel.org>, <darrick.wong@oracle.com>,
        <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
        <viro@zeniv.linux.org.uk>, <linux-btrfs@vger.kernel.org>,
        <ocfs2-devel@oss.oracle.com>, <david@fromorbit.com>, <hch@lst.de>,
        <rgoldwyn@suse.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-5-ruansy.fnst@cn.fujitsu.com>
 <20210216131154.GN1993@twin.jikos.cz>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <4e9a79ed-aa99-c57b-6098-f55ef28cc535@cn.fujitsu.com>
Date:   Wed, 17 Feb 2021 11:06:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210216131154.GN1993@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 8C4954CE6F9B.AD540
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/2/16 下午9:11, David Sterba wrote:
> On Mon, Feb 08, 2021 at 01:09:21AM +0800, Shiyang Ruan wrote:
>> We replace the existing entry to the newly allocated one
>> in case of CoW. Also, we mark the entry as PAGECACHE_TAG_TOWRITE
>> so writeback marks this entry as writeprotected. This
>> helps us snapshots so new write pagefaults after snapshots
>> trigger a CoW.
>>
>> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
>> ---
>>   fs/dax.c | 31 +++++++++++++++++++++++--------
>>   1 file changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/dax.c b/fs/dax.c
>> index b2195cbdf2dc..29698a3d2e37 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -722,6 +722,9 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>>   	return 0;
>>   }
>>   
>> +#define DAX_IF_DIRTY		(1ULL << 0)
>> +#define DAX_IF_COW		(1ULL << 1)
> 
> The constants are ULL, but I see other flags only 'unsigned long'
> 
>> +
>>   /*
>>    * By this point grab_mapping_entry() has ensured that we have a locked entry
>>    * of the appropriate size so we don't have to worry about downgrading PMDs to
>> @@ -731,14 +734,16 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>>    */
>>   static void *dax_insert_entry(struct xa_state *xas,
>>   		struct address_space *mapping, struct vm_fault *vmf,
>> -		void *entry, pfn_t pfn, unsigned long flags, bool dirty)
>> +		void *entry, pfn_t pfn, unsigned long flags, bool insert_flags)
> 
> insert_flags is bool
> 
>>   {
>>   	void *new_entry = dax_make_entry(pfn, flags);
>> +	bool dirty = insert_flags & DAX_IF_DIRTY;
> 
> "insert_flags & DAX_IF_DIRTY" is "bool & ULL", this can't be right

This is a mistake caused by rebasing my old version patchset.  Thanks 
for pointing out.  I'll fix this in next version.
> 
>> +	bool cow = insert_flags & DAX_IF_COW;
> 
> Same
> 
>>   
>>   	if (dirty)
>>   		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
>>   
>> -	if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
>> +	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
>>   		unsigned long index = xas->xa_index;
>>   		/* we are replacing a zero page with block mapping */
>>   		if (dax_is_pmd_entry(entry))
>> @@ -750,7 +755,7 @@ static void *dax_insert_entry(struct xa_state *xas,
>>   
>>   	xas_reset(xas);
>>   	xas_lock_irq(xas);
>> -	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
>> +	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
>>   		void *old;
>>   
>>   		dax_disassociate_entry(entry, mapping, false);
>> @@ -774,6 +779,9 @@ static void *dax_insert_entry(struct xa_state *xas,
>>   	if (dirty)
>>   		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
>>   
>> +	if (cow)
>> +		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
>> +
>>   	xas_unlock_irq(xas);
>>   	return entry;
>>   }
>> @@ -1319,6 +1327,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>>   	void *entry;
>>   	pfn_t pfn;
>>   	void *kaddr;
>> +	unsigned long insert_flags = 0;
>>   
>>   	trace_dax_pte_fault(inode, vmf, ret);
>>   	/*
>> @@ -1444,8 +1453,10 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>>   
>>   		goto finish_iomap;
>>   	case IOMAP_UNWRITTEN:
>> -		if (write && iomap.flags & IOMAP_F_SHARED)
>> +		if (write && (iomap.flags & IOMAP_F_SHARED)) {
>> +			insert_flags |= DAX_IF_COW;
> 
> Here's an example of 'unsigned long = unsigned long long', though it'll
> work, it would be better to unify all the types.

Yes, I'll fix it.


--
Thanks,
Ruan Shiyang.
> 
>>   			goto cow;
>> +		}
>>   		fallthrough;
>>   	case IOMAP_HOLE:
>>   		if (!write) {
>> @@ -1555,6 +1566,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>>   	int error;
>>   	pfn_t pfn;
>>   	void *kaddr;
>> +	unsigned long insert_flags = 0;
>>   
>>   	/*
>>   	 * Check whether offset isn't beyond end of file now. Caller is
>> @@ -1670,14 +1682,17 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>>   		result = vmf_insert_pfn_pmd(vmf, pfn, write);
>>   		break;
>>   	case IOMAP_UNWRITTEN:
>> -		if (write && iomap.flags & IOMAP_F_SHARED)
>> +		if (write && (iomap.flags & IOMAP_F_SHARED)) {
>> +			insert_flags |= DAX_IF_COW;
>>   			goto cow;
>> +		}
>>   		fallthrough;
>>   	case IOMAP_HOLE:
>> -		if (WARN_ON_ONCE(write))
>> +		if (!write) {
>> +			result = dax_pmd_load_hole(&xas, vmf, &iomap, &entry);
>>   			break;
>> -		result = dax_pmd_load_hole(&xas, vmf, &iomap, &entry);
>> -		break;
>> +		}
>> +		fallthrough;
>>   	default:
>>   		WARN_ON_ONCE(1);
>>   		break;
>> -- 
>> 2.30.0
>>
>>
> 
> 


