Return-Path: <linux-fsdevel+bounces-3577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 596887F6ABC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 03:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCEF4B20F18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 02:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CF4258C;
	Fri, 24 Nov 2023 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rxOvgmZb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CF2101
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 18:37:46 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700793464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jTrWgPTmhL+pfMdbtv8oZ0hXd6mtQwXeT2Ul7xLq8pM=;
	b=rxOvgmZby8bs+M3u65ZmeIsiqbfYUlsFgcTKzcFbx4s3TWRBH3/Fy2bflm9Ge7uAnlhMg7
	NRSN9f6J3N1rxV/qkm6ezPqAmqnkBD83WnvIhOO9PFpHKRVf5fljDi2N+FXichstd1OsF7
	OsnIgQ0FQNEpn6Pdym/EEmcM2fMpV7o=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] fs/Kconfig: Make hugetlbfs a menuconfig
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <de256121-f613-42d3-b267-9cd9fbfc8946@infradead.org>
Date: Fri, 24 Nov 2023 10:37:06 +0800
Cc: Peter Xu <peterx@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7830CCC4-B1E4-4CCD-B96B-61744FAF2C79@linux.dev>
References: <20231123223929.1059375-1-peterx@redhat.com>
 <de256121-f613-42d3-b267-9cd9fbfc8946@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>,
 Peter Xu <peterx@redhat.com>
X-Migadu-Flow: FLOW_OUT



> On Nov 24, 2023, at 08:19, Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> BTW:
> 
> On 11/23/23 14:39, Peter Xu wrote:
>> Hugetlb vmemmap default option (HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON)
>> is a sub-option to hugetlbfs, but it shows in the same level as hugetlbfs
>> itself, under "Pesudo filesystems".
>> Make the vmemmap option a sub-option to hugetlbfs, by changing hugetlbfs
>> into a menuconfig.
>> 
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Cc: Muchun Song <songmuchun@bytedance.com>
>> Cc: linux-fsdevel@vger.kernel.org
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>> fs/Kconfig | 20 +++++++++++---------
>> 1 file changed, 11 insertions(+), 9 deletions(-)
>> 
>> diff --git a/fs/Kconfig b/fs/Kconfig
>> index fd1f655b4f1f..8636198a8689 100644
>> --- a/fs/Kconfig
>> +++ b/fs/Kconfig
>> @@ -254,7 +254,7 @@ config TMPFS_QUOTA
>> config ARCH_SUPPORTS_HUGETLBFS
>> def_bool n
>> 
>> -config HUGETLBFS
>> +menuconfig HUGETLBFS
>> bool "HugeTLB file system support"
>> depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
>> depends on (SYSFS || SYSCTL)
>> @@ -266,14 +266,7 @@ config HUGETLBFS
>> 
>>  If unsure, say N.
>> 
>> -config HUGETLB_PAGE
>> - def_bool HUGETLBFS
>> -
>> -config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>> - def_bool HUGETLB_PAGE
>> - depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>> - depends on SPARSEMEM_VMEMMAP
>> -
>> +if HUGETLBFS
>> config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
>> bool "HugeTLB Vmemmap Optimization (HVO) defaults to on"
>> default n
>> @@ -282,6 +275,15 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
>>  The HugeTLB VmemmapvOptimization (HVO) defaults to off. Say Y here to
> 
> Is this small 'v'            ^ a typo?

Yes. Thanks for pointing it out. Although it is not related to this
patch, but it will be nice for me to carry this tiny typo fix. Hi,
Peter, would you like help me do this?

Thanks.


