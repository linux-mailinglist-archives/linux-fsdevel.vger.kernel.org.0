Return-Path: <linux-fsdevel+bounces-49562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EA7ABED90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 10:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECB93B5849
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 08:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768FE235C14;
	Wed, 21 May 2025 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E0hdLvQH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D777323536A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747814863; cv=none; b=F3ui0j2xf9dmqlDZSFBS780G3Y3HIII8jDLb2bVTh8JqIUBIIhFCISZlLsPDBmPz0zrP0KjVXCeqBQAxA8j+4SDIK0LNoxGS/LJTWrRjiP9a8qF63WVD/pMksK9Kb9v+Bq2ZBFokMZS8vhdBhWbsgOereDhAF102U48yzmlh/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747814863; c=relaxed/simple;
	bh=9Wu/5+pZRgvbXLVfxj0ht7kYsXhLJaM3KULAqCkCQFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rco1w4tUzbl3NWRX1Eiz67qht8DiNJsP3hSFokFi2Z4yj5eDIsDGns8LjmTEj5yXigsFkyeCwUXSLZyoMFUXh1bXresX64zsqrhXGIL7mJgkNXe9RHrfch0gdJ6RL5dohHM6rIImXy1OpOzNYdIrw++/OEgfhqBITFAK/wyXIQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E0hdLvQH; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <34bd0faf-30b9-41f1-a768-0ed7165b4b98@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747814858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEaKuSnjA40/mgx1OTc7sUEXciIH5kxDTRhEgaMMCXg=;
	b=E0hdLvQHY6k4outi1igGRNlJCmNjcYXgUyQwytoFhz0WUt5flz3q2OeoVUzsJH3N1iKjwV
	f7totfAZlNsEJNAoaPFVtFHgqBY24NB8UJ79uHxuT6dSAdoEBL7bQXeJNszZJfYiA8mhkG
	B4bUnoIFIwPsU6jbrBQahnTUVc+Xc2s=
Date: Wed, 21 May 2025 16:07:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] tools/testing/selftests: add VMA merge tests for KSM
 merge
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
 Xu Xin <xu.xin16@zte.com.cn>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <95db1783c752fd4032fc0e81431afe7e6d128630.1747431920.git.lorenzo.stoakes@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <95db1783c752fd4032fc0e81431afe7e6d128630.1747431920.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/5/19 16:51, Lorenzo Stoakes wrote:
> Add test to assert that we have now allowed merging of VMAs when KSM
> merging-by-default has been set by prctl(PR_SET_MEMORY_MERGE, ...).
> 
> We simply perform a trivial mapping of adjacent VMAs expecting a merge,
> however prior to recent changes implementing this mode earlier than before,
> these merges would not have succeeded.
> 
> Assert that we have fixed this!
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Tested-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks!

> ---
>   tools/testing/selftests/mm/merge.c | 78 ++++++++++++++++++++++++++++++
>   1 file changed, 78 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
> index c76646cdf6e6..2380a5a6a529 100644
> --- a/tools/testing/selftests/mm/merge.c
> +++ b/tools/testing/selftests/mm/merge.c
> @@ -2,10 +2,12 @@
>   
>   #define _GNU_SOURCE
>   #include "../kselftest_harness.h"
> +#include <linux/prctl.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include <sys/mman.h>
> +#include <sys/prctl.h>
>   #include <sys/wait.h>
>   #include "vm_util.h"
>   
> @@ -31,6 +33,11 @@ FIXTURE_TEARDOWN(merge)
>   {
>   	ASSERT_EQ(munmap(self->carveout, 12 * self->page_size), 0);
>   	ASSERT_EQ(close_procmap(&self->procmap), 0);
> +	/*
> +	 * Clear unconditionally, as some tests set this. It is no issue if this
> +	 * fails (KSM may be disabled for instance).
> +	 */
> +	prctl(PR_SET_MEMORY_MERGE, 0, 0, 0, 0);
>   }
>   
>   TEST_F(merge, mprotect_unfaulted_left)
> @@ -452,4 +459,75 @@ TEST_F(merge, forked_source_vma)
>   	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 5 * page_size);
>   }
>   
> +TEST_F(merge, ksm_merge)
> +{
> +	unsigned int page_size = self->page_size;
> +	char *carveout = self->carveout;
> +	struct procmap_fd *procmap = &self->procmap;
> +	char *ptr, *ptr2;
> +	int err;
> +
> +	/*
> +	 * Map two R/W immediately adjacent to one another, they should
> +	 * trivially merge:
> +	 *
> +	 * |-----------|-----------|
> +	 * |    R/W    |    R/W    |
> +	 * |-----------|-----------|
> +	 *      ptr         ptr2
> +	 */
> +
> +	ptr = mmap(&carveout[page_size], page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +	ptr2 = mmap(&carveout[2 * page_size], page_size,
> +		    PROT_READ | PROT_WRITE,
> +		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +	ASSERT_NE(ptr2, MAP_FAILED);
> +	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
> +	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
> +	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
> +
> +	/* Unmap the second half of this merged VMA. */
> +	ASSERT_EQ(munmap(ptr2, page_size), 0);
> +
> +	/* OK, now enable global KSM merge. We clear this on test teardown. */
> +	err = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
> +	if (err == -1) {
> +		int errnum = errno;
> +
> +		/* Only non-failure case... */
> +		ASSERT_EQ(errnum, EINVAL);
> +		/* ...but indicates we should skip. */
> +		SKIP(return, "KSM memory merging not supported, skipping.");
> +	}
> +
> +	/*
> +	 * Now map a VMA adjacent to the existing that was just made
> +	 * VM_MERGEABLE, this should merge as well.
> +	 */
> +	ptr2 = mmap(&carveout[2 * page_size], page_size,
> +		    PROT_READ | PROT_WRITE,
> +		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +	ASSERT_NE(ptr2, MAP_FAILED);
> +	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
> +	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
> +	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
> +
> +	/* Now this VMA altogether. */
> +	ASSERT_EQ(munmap(ptr, 2 * page_size), 0);
> +
> +	/* Try the same operation as before, asserting this also merges fine. */
> +	ptr = mmap(&carveout[page_size], page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +	ptr2 = mmap(&carveout[2 * page_size], page_size,
> +		    PROT_READ | PROT_WRITE,
> +		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +	ASSERT_NE(ptr2, MAP_FAILED);
> +	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
> +	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
> +	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
> +}
> +
>   TEST_HARNESS_MAIN

