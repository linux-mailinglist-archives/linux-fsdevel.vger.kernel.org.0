Return-Path: <linux-fsdevel+bounces-48214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17296AAC06F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042841C2205A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B2126FD84;
	Tue,  6 May 2025 09:53:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17065278142;
	Tue,  6 May 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525195; cv=none; b=aFvOESmv0512yuOSVz9ULJL+K3MJyiZpDQOc7LGCC1rR6Eu6puQ9IzpzOIBjn7Bacb2KoCGtDJdYrgsqoxYIHYSmQW8SestO3O9XkRyq+ihzTE6mnzXdWeSi8ECzdX99hn+IpMFqfhwlC9XmsqQx/5sqPzByqaSPpaOUkUEKEfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525195; c=relaxed/simple;
	bh=mF1A3vX/n2fU9RBpzMdEW5F0yNbhrXJTL4Pr32b2H4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCashHbhs3oMfVSwPkArvIfALCOMu4dPKit8bNpE6MIVsf5XYtRFffzHuUV9bLiCRsCJaKiUt3LkuecZNAqNOs15cQFwXd8Buf5+M2E1z4G5ZJYNSArPRowgdCQ2I16muOmdzoKpIWPZDoxZJzvM+1dflZf2xRxhAfUV/FsMrYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 962BF113E;
	Tue,  6 May 2025 02:53:02 -0700 (PDT)
Received: from [10.57.93.118] (unknown [10.57.93.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ED6E3F5A1;
	Tue,  6 May 2025 02:53:09 -0700 (PDT)
Message-ID: <df09f0f4-fd23-469e-94d7-864b3bdb17c6@arm.com>
Date: Tue, 6 May 2025 10:53:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/5] mm/readahead: Store folio order in struct
 file_ra_state
Content-Language: en-GB
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, David Hildenbrand
 <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-5-ryan.roberts@arm.com>
 <hsh7gqrzzxmgihjnud6p6iqbysustua3rv7vkfgknz4vho4hhx@jvzfztjk4cc4>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <hsh7gqrzzxmgihjnud6p6iqbysustua3rv7vkfgknz4vho4hhx@jvzfztjk4cc4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/05/2025 10:52, Jan Kara wrote:
> On Wed 30-04-25 15:59:17, Ryan Roberts wrote:
>> Previously the folio order of the previous readahead request was
>> inferred from the folio who's readahead marker was hit. But due to the
>> way we have to round to non-natural boundaries sometimes, this first
>> folio in the readahead block is often smaller than the preferred order
>> for that request. This means that for cases where the initial sync
>> readahead is poorly aligned, the folio order will ramp up much more
>> slowly.
>>
>> So instead, let's store the order in struct file_ra_state so we are not
>> affected by any required alignment. We previously made enough room in
>> the struct for a 16 order field. This should be plenty big enough since
>> we are limited to MAX_PAGECACHE_ORDER anyway, which is certainly never
>> larger than ~20.
>>
>> Since we now pass order in struct file_ra_state, page_cache_ra_order()
>> no longer needs it's new_order parameter, so let's remove that.
>>
>> Worked example:
>>
>> Here we are touching pages 17-256 sequentially just as we did in the
>> previous commit, but now that we are remembering the preferred order
>> explicitly, we no longer have the slow ramp up problem. Note
>> specifically that we no longer have 2 rounds (2x ~128K) of order-2
>> folios:
>>
>> TYPE    STARTOFFS     ENDOFFS        SIZE  STARTPG    ENDPG   NRPG  ORDER  RA
>> -----  ----------  ----------  ----------  -------  -------  -----  -----  --
>> HOLE   0x00000000  0x00001000        4096        0        1      1
>> FOLIO  0x00001000  0x00002000        4096        1        2      1      0
>> FOLIO  0x00002000  0x00003000        4096        2        3      1      0
>> FOLIO  0x00003000  0x00004000        4096        3        4      1      0
>> FOLIO  0x00004000  0x00005000        4096        4        5      1      0
>> FOLIO  0x00005000  0x00006000        4096        5        6      1      0
>> FOLIO  0x00006000  0x00007000        4096        6        7      1      0
>> FOLIO  0x00007000  0x00008000        4096        7        8      1      0
>> FOLIO  0x00008000  0x00009000        4096        8        9      1      0
>> FOLIO  0x00009000  0x0000a000        4096        9       10      1      0
>> FOLIO  0x0000a000  0x0000b000        4096       10       11      1      0
>> FOLIO  0x0000b000  0x0000c000        4096       11       12      1      0
>> FOLIO  0x0000c000  0x0000d000        4096       12       13      1      0
>> FOLIO  0x0000d000  0x0000e000        4096       13       14      1      0
>> FOLIO  0x0000e000  0x0000f000        4096       14       15      1      0
>> FOLIO  0x0000f000  0x00010000        4096       15       16      1      0
>> FOLIO  0x00010000  0x00011000        4096       16       17      1      0
>> FOLIO  0x00011000  0x00012000        4096       17       18      1      0
>> FOLIO  0x00012000  0x00013000        4096       18       19      1      0
>> FOLIO  0x00013000  0x00014000        4096       19       20      1      0
>> FOLIO  0x00014000  0x00015000        4096       20       21      1      0
>> FOLIO  0x00015000  0x00016000        4096       21       22      1      0
>> FOLIO  0x00016000  0x00017000        4096       22       23      1      0
>> FOLIO  0x00017000  0x00018000        4096       23       24      1      0
>> FOLIO  0x00018000  0x00019000        4096       24       25      1      0
>> FOLIO  0x00019000  0x0001a000        4096       25       26      1      0
>> FOLIO  0x0001a000  0x0001b000        4096       26       27      1      0
>> FOLIO  0x0001b000  0x0001c000        4096       27       28      1      0
>> FOLIO  0x0001c000  0x0001d000        4096       28       29      1      0
>> FOLIO  0x0001d000  0x0001e000        4096       29       30      1      0
>> FOLIO  0x0001e000  0x0001f000        4096       30       31      1      0
>> FOLIO  0x0001f000  0x00020000        4096       31       32      1      0
>> FOLIO  0x00020000  0x00021000        4096       32       33      1      0
>> FOLIO  0x00021000  0x00022000        4096       33       34      1      0
>> FOLIO  0x00022000  0x00024000        8192       34       36      2      1
>> FOLIO  0x00024000  0x00028000       16384       36       40      4      2
>> FOLIO  0x00028000  0x0002c000       16384       40       44      4      2
>> FOLIO  0x0002c000  0x00030000       16384       44       48      4      2
>> FOLIO  0x00030000  0x00034000       16384       48       52      4      2
>> FOLIO  0x00034000  0x00038000       16384       52       56      4      2
>> FOLIO  0x00038000  0x0003c000       16384       56       60      4      2
>> FOLIO  0x0003c000  0x00040000       16384       60       64      4      2
>> FOLIO  0x00040000  0x00050000       65536       64       80     16      4
>> FOLIO  0x00050000  0x00060000       65536       80       96     16      4
>> FOLIO  0x00060000  0x00080000      131072       96      128     32      5
>> FOLIO  0x00080000  0x000a0000      131072      128      160     32      5
>> FOLIO  0x000a0000  0x000c0000      131072      160      192     32      5
>> FOLIO  0x000c0000  0x000e0000      131072      192      224     32      5
>> FOLIO  0x000e0000  0x00100000      131072      224      256     32      5
>> FOLIO  0x00100000  0x00120000      131072      256      288     32      5
>> FOLIO  0x00120000  0x00140000      131072      288      320     32      5  Y
>> HOLE   0x00140000  0x00800000     7077888      320     2048   1728
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> ...
> 
>> @@ -469,6 +469,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
>>  	int err = 0;
>>  	gfp_t gfp = readahead_gfp_mask(mapping);
>>  	unsigned int min_ra_size = max(4, mapping_min_folio_nrpages(mapping));
>> +	unsigned int new_order = ra->order;
>>  
>>  	/*
>>  	 * Fallback when size < min_nrpages as each folio should be
>> @@ -483,6 +484,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
>>  	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>>  	new_order = max(new_order, min_order);
>>  
>> +	ra->order = new_order;
>> +
>>  	/* See comment in page_cache_ra_unbounded() */
>>  	nofs = memalloc_nofs_save();
>>  	filemap_invalidate_lock_shared(mapping);
>> @@ -525,6 +528,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
>>  	 * ->readahead() may have updated readahead window size so we have to
>>  	 * check there's still something to read.
>>  	 */
>> +	ra->order = 0;
> 
> Hum, so you reset desired folio order if readahead hit some pre-existing
> pages in the page cache. Is this really desirable? Why not leave the
> desired order as it was for the next request?

My aim was to not let order grow unbounded. When the filesystem doesn't support
large folios we end up here (from the "goto fallback") and without this, order
will just grow and grow (perhaps it doesn't matter though). I think we should
keep this.

But I guess your point is that we can also end up here when the filesystem does
support large folios but there is an error. In thta case, yes, I'll change to
not reset order to 0; it has already been fixed up earlier in this path.

How's this:

---8<---
diff --git a/mm/readahead.c b/mm/readahead.c
index 18972bc34861..0054ca18a815 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -475,8 +475,10 @@ void page_cache_ra_order(struct readahead_control *ractl,
         * Fallback when size < min_nrpages as each folio should be
         * at least min_nrpages anyway.
         */
-       if (!mapping_large_folio_support(mapping) || ra->size < min_ra_size)
+       if (!mapping_large_folio_support(mapping) || ra->size < min_ra_size) {
+               ra->order = 0;
                goto fallback;
+       }

        limit = min(limit, index + ra->size - 1);

@@ -528,7 +530,6 @@ void page_cache_ra_order(struct readahead_control *ractl,
         * ->readahead() may have updated readahead window size so we have to
         * check there's still something to read.
         */
-       ra->order = 0;
        if (ra->size > index - start)
                do_page_cache_ra(ractl, ra->size - (index - start),
                                 ra->async_size);
---8<---

Thanks,
Ryan

> 
>>  	if (ra->size > index - start)
>>  		do_page_cache_ra(ractl, ra->size - (index - start),
>>  				 ra->async_size);
> 
> 								Honza


