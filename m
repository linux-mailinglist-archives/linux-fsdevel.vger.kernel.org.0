Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6687D1CE938
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 01:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgEKXdm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 19:33:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35420 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgEKXdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 19:33:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BNWCCB096110;
        Mon, 11 May 2020 23:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SUCMQvMGKbnOyya5OIEHaJXAFNdV/cZdhlH9Unt5TlA=;
 b=oO5fFGiOYKj0RbbJQITeWxcUQMrXtrZVRi3R2Fulw132X/tYQnlj79YbUdTnBWhNKfSH
 eV6tEp/NNkqh3DfCWTXfsx30F6h81y0TCEgFhcc7NHVxQ0OAN865/dleihwB2OCr7sAh
 rzBuM+aUlIcGjkCV6wA9EUQo2jOpXSVm/Kf0bupmgtXOAcgYhLhoR8filBeCE6RdqM1Q
 gXw2VdmADaEGV5FygM++Io6vC8Qeecbza5waPi2DapIqBHyePc6WcStmmn19xKeREfhq
 yt2kJpdWBwhG/ImSssEqd3EBJXWPhOlHW4qZh4TI0a2hrJpMgzeb2yDU34zDmQZkuhpG qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30x3mbqy9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 23:32:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BNNu4b005736;
        Mon, 11 May 2020 23:29:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30ydsp8634-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 23:29:56 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04BNTbb3004361;
        Mon, 11 May 2020 23:29:37 GMT
Received: from [10.154.189.6] (/10.154.189.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2020 16:29:37 -0700
Subject: Re: [RFC 14/43] mm: memblock: PKRAM: prevent memblock resize from
 clobbering preserved pages
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, hughd@google.com, ebiederm@xmission.com,
        masahiroy@kernel.org, ardb@kernel.org, ndesaulniers@google.com,
        dima@golovin.in, daniel.kiper@oracle.com, nivedita@alum.mit.edu,
        rafael.j.wysocki@intel.com, dan.j.williams@intel.com,
        zhenzhong.duan@oracle.com, jroedel@suse.de, bhe@redhat.com,
        guro@fb.com, Thomas.Lendacky@amd.com,
        andriy.shevchenko@linux.intel.com, keescook@chromium.org,
        hannes@cmpxchg.org, minchan@kernel.org, mhocko@kernel.org,
        ying.huang@intel.com, yang.shi@linux.alibaba.com,
        gustavo@embeddedor.com, ziqian.lzq@antfin.com,
        vdavydov.dev@gmail.com, jason.zeng@intel.com, kevin.tian@intel.com,
        zhiyuan.lv@intel.com, lei.l.li@intel.com, paul.c.lai@intel.com,
        ashok.raj@intel.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
 <1588812129-8596-15-git-send-email-anthony.yznaga@oracle.com>
 <20200511135727.GA983798@linux.ibm.com>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
Organization: Oracle Corporation
Message-ID: <54773d69-1a2b-1ab3-24d9-b322d580fb42@oracle.com>
Date:   Mon, 11 May 2020 16:29:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200511135727.GA983798@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=2 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=2 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110173
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/11/20 6:57 AM, Mike Rapoport wrote:
> On Wed, May 06, 2020 at 05:41:40PM -0700, Anthony Yznaga wrote:
>> The size of the memblock reserved array may be increased while preserved
>> pages are being reserved. When this happens, preserved pages that have
>> not yet been reserved are at risk for being clobbered when space for a
>> larger array is allocated.
>> When called from memblock_double_array(), a wrapper around
>> memblock_find_in_range() walks the preserved pages pagetable to find
>> sufficiently sized ranges without preserved pages and passes them to
>> memblock_find_in_range().
> I'd suggest to create an array of memblock_region's that will contain
> the PKRAM ranges before kexec and pass this array to the new kernel.
> Then, somewhere in start_kerenel() replace replace
> memblock.reserved->regions with that array. 

I'll look into doing this.  Thanks!

Anthony

>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
>>  include/linux/pkram.h |  3 +++
>>  mm/memblock.c         | 15 +++++++++++++--
>>  mm/pkram.c            | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 67 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/pkram.h b/include/linux/pkram.h
>> index edc5d8bef9d3..409022e1472f 100644
>> --- a/include/linux/pkram.h
>> +++ b/include/linux/pkram.h
>> @@ -62,6 +62,9 @@ struct page *pkram_load_page(struct pkram_stream *ps, unsigned long *index,
>>  ssize_t pkram_write(struct pkram_stream *ps, const void *buf, size_t count);
>>  size_t pkram_read(struct pkram_stream *ps, void *buf, size_t count);
>>  
>> +phys_addr_t pkram_memblock_find_in_range(phys_addr_t start, phys_addr_t end,
>> +					 phys_addr_t size, phys_addr_t align);
>> +
>>  #ifdef CONFIG_PKRAM
>>  extern unsigned long pkram_reserved_pages;
>>  void pkram_reserve(void);
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index c79ba6f9920c..69ae883b8d21 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/kmemleak.h>
>>  #include <linux/seq_file.h>
>>  #include <linux/memblock.h>
>> +#include <linux/pkram.h>
>>  
>>  #include <asm/sections.h>
>>  #include <linux/io.h>
>> @@ -349,6 +350,16 @@ phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
>>  	return ret;
>>  }
>>  
>> +phys_addr_t __init_memblock __memblock_find_in_range(phys_addr_t start,
>> +					phys_addr_t end, phys_addr_t size,
>> +					phys_addr_t align)
>> +{
>> +	if (IS_ENABLED(CONFIG_PKRAM))
>> +		return pkram_memblock_find_in_range(start, end, size, align);
>> +	else
>> +		return memblock_find_in_range(start, end, size, align);
>> +}
>> +
>>  static void __init_memblock memblock_remove_region(struct memblock_type *type, unsigned long r)
>>  {
>>  	type->total_size -= type->regions[r].size;
>> @@ -447,11 +458,11 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
>>  		if (type != &memblock.reserved)
>>  			new_area_start = new_area_size = 0;
>>  
>> -		addr = memblock_find_in_range(new_area_start + new_area_size,
>> +		addr = __memblock_find_in_range(new_area_start + new_area_size,
>>  						memblock.current_limit,
>>  						new_alloc_size, PAGE_SIZE);
>>  		if (!addr && new_area_size)
>> -			addr = memblock_find_in_range(0,
>> +			addr = __memblock_find_in_range(0,
>>  				min(new_area_start, memblock.current_limit),
>>  				new_alloc_size, PAGE_SIZE);
>>  
>> diff --git a/mm/pkram.c b/mm/pkram.c
>> index dd3c89614010..e49c9bcd3854 100644
>> --- a/mm/pkram.c
>> +++ b/mm/pkram.c
>> @@ -1238,3 +1238,54 @@ void pkram_free_pgt(void)
>>  	__free_pages_core(virt_to_page(pkram_pgd), 0);
>>  	pkram_pgd = NULL;
>>  }
>> +
>> +static int __init_memblock pkram_memblock_find_cb(struct pkram_pg_state *st, unsigned long base, unsigned long size)
>> +{
>> +	unsigned long end = base + size;
>> +	unsigned long addr;
>> +
>> +	if (size < st->min_size)
>> +		return 0;
>> +
>> +	addr =  memblock_find_in_range(base, end, st->min_size, PAGE_SIZE);
>> +	if (!addr)
>> +		return 0;
>> +
>> +	st->retval = addr;
>> +	return 1;
>> +}
>> +
>> +/*
>> + * It may be necessary to allocate a larger reserved memblock array
>> + * while populating it with ranges of preserved pages.  To avoid
>> + * trampling preserved pages that have not yet been added to the
>> + * memblock reserved list this function implements a wrapper around
>> + * memblock_find_in_range() that restricts searches to subranges
>> + * that do not contain preserved pages.
>> + */
>> +phys_addr_t __init_memblock pkram_memblock_find_in_range(phys_addr_t start,
>> +					phys_addr_t end, phys_addr_t size,
>> +					phys_addr_t align)
>> +{
>> +	struct pkram_pg_state st = {
>> +		.range_cb = pkram_memblock_find_cb,
>> +		.min_addr = start,
>> +		.max_addr = end,
>> +		.min_size = PAGE_ALIGN(size),
>> +		.find_holes = true,
>> +	};
>> +
>> +	if (!pkram_reservation_in_progress)
>> +		return memblock_find_in_range(start, end, size, align);
>> +
>> +	if (!pkram_pgd) {
>> +		WARN_ONCE(1, "No preserved pages pagetable\n");
>> +		return memblock_find_in_range(start, end, size, align);
>> +	}
>> +
>> +	WARN_ONCE(memblock_bottom_up(), "PKRAM: bottom up memblock allocation not yet supported\n");
>> +
>> +	pkram_walk_pgt_rev(&st, pkram_pgd);
>> +
>> +	return st.retval;
>> +}
>> -- 
>> 2.13.3
>>

