Return-Path: <linux-fsdevel+bounces-56511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2492B18140
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 13:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9383B6DC4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 11:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3674246786;
	Fri,  1 Aug 2025 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiW7xoPw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD0223707;
	Fri,  1 Aug 2025 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754048564; cv=none; b=Ahb1Kjp+ITw/HKleqWK6lBLK4Ohvh8soZuQswXjxfrvI5gosDkum9nHwHOVoBxDeM6PPxkvWLcu72spyI8M74x8yrzyi30GlCDeZvdEeiUvtb+xJuSSFMod2pt2gqBXRiq7fXgRXT7lInIFZTpW0dGe/bjI+tpUOrFIwxi9bvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754048564; c=relaxed/simple;
	bh=d8OGW4zCuGqhw+09W9cGsbGa1xLxMT7HIjAc6+EofyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gg48NPkssgyf8IqlZrXSW2ikn1rv+32YCLzXaYEtz3OUJR6YSfsSnnD72XdyGlYliBsC4ttEoLubvFC3Lb98NKrURTiXRL+v1bFKa34AWvyc/ahpzhsYQDvu4olaux5YnLgkAkiQi+KoPcu+1wB776r7DJl9wHmvsqb3dkMR4ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiW7xoPw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so15358615e9.0;
        Fri, 01 Aug 2025 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754048560; x=1754653360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=momi1YfOHTpFLGKMVxFm/VGFaTZTo2hyfea3bMFo1dk=;
        b=kiW7xoPwuf7Ot+VI/fII4bEG5ctG++N2E7QE+xkX1+UuehwCDQywARSThw1ce1EfHQ
         t+sRTB9IMb9Pegk3LIZBAUI0G15oZLk1dphEYO6Grn5kwrDqHysFHoDmsTUouy0lpqJk
         mVC97Md3WbPQFRZEU+TDBzPCv/gI3fwBw8AuNidcMGRI2NjTlJWEliqpVw6QS4ZTO/S7
         L3md6NemUAFjGGVCXrrZYjHKahjrQDHygpl0AIEGs7+MvtADHAmBSi3iBaQv4tpEnhVj
         O5Cy11VeDWen42IurbXnGrOoZb3lpD862znAJ1w6fbHLTGRt6LYMweyTGP0METoHDo78
         EpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754048560; x=1754653360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=momi1YfOHTpFLGKMVxFm/VGFaTZTo2hyfea3bMFo1dk=;
        b=Xdk12e2q4onIJwpTTrrKuuDOQashaLjYENjTHwKiMYm4XJ4AII179OxiJG1Cx+fgAd
         XuAtsvWuj3uhvEs0BDNLRwP9+Zvp94Opglv5SuiCvmUtGxDWqnE30wa81mHnR0FH0xu2
         shb+1Tp/0LNFMAOPpMd+ARpAJib+3PANlePV9H1Lf2mzjywxqwwuU02arhx4s/SRhQby
         XiM7kZ7J5ajrzyVVDyNeE+2mLqzjvyo20Iy+dXbXSjg3jh+3x4gU7HLxorcOW4sAjWUb
         P32IBuxZBkMQPMooF3g6SbnuOeGZaBIKnDBlskP2BidrF3iX2ws6yfodn+uwRaLZqJNY
         uJtw==
X-Forwarded-Encrypted: i=1; AJvYcCVInB06GNLxkvcW+5wHwhYWXmpKdm4KzPYeW7UIFZaKgLVbUGKHQy7+KaPGfh7ayjKBUGcwGXi8//hZRUvW@vger.kernel.org, AJvYcCXZGjYQqjCyZvKZWLv1aujHXOwYZ6uTnOwSqNngP83Ti3zr9aK2qrSS0y2y0qRGew7XOo6D5NB9EVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUXCrl5hlHd7kbxVxmoue+ybvryj8jDZFbfiN6UVFoXB/XvgvP
	YScfvJk7383ZfUl51JA3/UHePynSXo0XWbVdKbwW3Jle3pV/LjLeHT1H
X-Gm-Gg: ASbGncu9Rhn+HwJxhfOGElSWnDm4PuNe8wXPMurrJjhqkZXD4a7x3sjg0+rpt5/wkhr
	zBOiSDH5hPyImd3/GY60z7y85L/Q7Li8jvB+lh/KW+eX4t9yeG7BlrkkOdXQCl8P+d6Ggm1NFgt
	pQ7hvEZnFDm2fIqiyBvZXBDJLkEPdnW/9xu9nDJlCPm1Hk8Kf8RojywgD694mmLPn1UjoPsM9Rm
	TZ6t46HRQbIqCVi1Mu5R+FfTUvt1caLoEYbV68tiMo5oeHpwqAMSOjS0RANhSb8Ew3GrHh6hwSK
	AtagrjkFM1ChDcjv0qL3CNOJa3Mc1xB6fTArC6ILqgzFAnNaFUiw3X/JDUd+gGTsxEC2FtXxhSl
	uZjghmTi7Y3yyczeWZ7TXbEPl0YeA+5wLb41kVC8eofKKYvLyaQ9wmHUV7AnUfkwzilXCjOMI2v
	oSOE5kbMrVRGYxoyOIjgfn
X-Google-Smtp-Source: AGHT+IFHDY7W3Ce5xcLtfL4XnnwU/a+0HjPBHBzmVsYbShhebd7Z21HrXzs3mc/awIMb9FyAT2pj+w==
X-Received: by 2002:a05:600c:190a:b0:456:18e:eb7f with SMTP id 5b1f17b1804b1-458a1e0bf9emr62743245e9.3.1754048559998;
        Fri, 01 Aug 2025 04:42:39 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4? ([2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c46ee84sm5508760f8f.57.2025.08.01.04.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 04:42:39 -0700 (PDT)
Message-ID: <22e263a3-a1d2-4159-b3c8-44f7a29bace9@gmail.com>
Date: Fri, 1 Aug 2025 12:42:38 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] selftests: prctl: introduce tests for disabling
 THPs completely
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-5-usamaarif642@gmail.com>
 <7b13d8b5-a534-47f8-b6c5-09a65bffc691@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <7b13d8b5-a534-47f8-b6c5-09a65bffc691@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 31/07/2025 20:42, David Hildenbrand wrote:
> On 31.07.25 14:27, Usama Arif wrote:
>> The test will set the global system THP setting to never, madvise
>> or always depending on the fixture variant and the 2M setting to
>> inherit before it starts (and reset to original at teardown).
>>
>> This tests if the process can:
>> - successfully set and get the policy to disable THPs completely.
>> - never get a hugepage when the THPs are completely disabled
>>    with the prctl, including with MADV_HUGE and MADV_COLLAPSE.
>> - successfully reset the policy of the process.
>> - after reset, only get hugepages with:
>>    - MADV_COLLAPSE when policy is set to never.
>>    - MADV_HUGE and MADV_COLLAPSE when policy is set to madvise.
>>    - always when policy is set to "always".
>> - repeat the above tests in a forked process to make sure
>>    the policy is carried across forks.
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
> 
> [...]
> 
> Looks much better already. Some quirks.
> 
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include <sys/mman.h>
>> +#include <sys/prctl.h>
>> +#include <sys/wait.h>
>> +
>> +#include "../kselftest_harness.h"
>> +#include "thp_settings.h"
>> +#include "vm_util.h"
>> +
>> +static int sz2ord(size_t size, size_t pagesize)
>> +{
>> +    return __builtin_ctzll(size / pagesize);
>> +}
>> +
>> +enum thp_collapse_type {
>> +    THP_COLLAPSE_NONE,
>> +    THP_COLLAPSE_MADV_HUGEPAGE,    /* MADV_HUGEPAGE before access */
>> +    THP_COLLAPSE_MADV_COLLAPSE,    /* MADV_COLLAPSE after access */
>> +};
>> +
>> +enum thp_policy {
>> +    THP_POLICY_NEVER,
>> +    THP_POLICY_MADVISE,
>> +    THP_POLICY_ALWAYS,
>> +};
> 
> Couldn't you have reused "enum thp_enabled" end simply never specified the "THP_INHERIT"? Then, you need to do less translation.

yes, introducing this enum was silly. Have removed it for next revision.> 
>> +
>> +struct test_results {
>> +    int prctl_get_thp_disable;
> 
> The result is always one, does that here make sense?

Its 3 in the next patch for PR_THP_DISABLE_EXCEPT_ADVISED :)

I will remove this struct, but I think maybe it might have been a good idea to squash this
with the next patch to show why the struct was useful.

> 
>> +    int prctl_applied_collapse_none;
> 
> "prctl_applied" is a bit confusing. And most of these always have the same value.
> 
> Can't we special case the remaining two cases on the current policy and avoid this struct compeltely?
> 

The values are different in the next patch when PR_THP_DISABLE_EXCEPT_ADVISED is used.

Just to explain how I came about using this struct test_results (though it doesnt matter as
I will remove it for the next revision):
I wanted to maximise code reuse and only wanted to have one instance of prctl_thp_disable_test.
I actually started with special casing, but went the brute force way of adding too many if else
statements and it was looking quite messy after I added the tests for PR_THP_DISABLE_EXCEPT_ADVISED.
I saw this struct test_results in another kselftest and thought this should make it much better and
extendable.

I have removed struct test_results and changed prctl_thp_disable_test to the following for next revision:

static void prctl_thp_disable_test(struct __test_metadata *const _metadata,
				   size_t pmdsize, enum thp_enabled thp_policy,
				   int prctl_flags)
{
	ASSERT_EQ(prctl(PR_GET_THP_DISABLE, NULL, NULL, NULL, NULL),
		  prctl_flags & PR_THP_DISABLE_EXCEPT_ADVISED ? 3 : 1);

	/* tests after prctl overrides global policy */
	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize), 0);

	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize),
		  thp_policy == THP_NEVER || !prctl_flags ? 0 : 1);

	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_COLLAPSE, pmdsize),
		  !prctl_flags ? 0 : 1);

	/* Reset to global policy */
	ASSERT_EQ(prctl(PR_SET_THP_DISABLE, 0, NULL, NULL, NULL), 0);

	/* tests after prctl is cleared, and only global policy is effective */
	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize),
		  thp_policy == THP_ALWAYS ? 1 : 0);

	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize),
		  thp_policy == THP_NEVER ? 0 : 1);

	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_COLLAPSE, pmdsize), 1);
}




> 
>> +    int prctl_applied_collapse_madv_huge;
>> +    int prctl_applied_collapse_madv_collapse;
>> +    int prctl_removed_collapse_none;
>> +    int prctl_removed_collapse_madv_huge;
>> +    int prctl_removed_collapse_madv_collapse;
>> +};
>> +
>> +/*
>> + * Function to mmap a buffer, fault it in, madvise it appropriately (before
>> + * page fault for MADV_HUGE, and after for MADV_COLLAPSE), and check if the
>> + * mmap region is huge.
>> + * Returns:
>> + * 0 if test doesn't give hugepage
>> + * 1 if test gives a hugepage
>> + * -errno if mmap fails
>> + */
>> +static int test_mmap_thp(enum thp_collapse_type madvise_buf, size_t pmdsize)
>> +{
>> +    char *mem, *mmap_mem;
>> +    size_t mmap_size;
>> +    int ret;
>> +
>> +    /* For alignment purposes, we need twice the THP size. */
>> +    mmap_size = 2 * pmdsize;
>> +    mmap_mem = (char *)mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
>> +                    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> +    if (mmap_mem == MAP_FAILED)
>> +        return -errno;
>> +
>> +    /* We need a THP-aligned memory area. */
>> +    mem = (char *)(((uintptr_t)mmap_mem + pmdsize) & ~(pmdsize - 1));
>> +
>> +    if (madvise_buf == THP_COLLAPSE_MADV_HUGEPAGE)
>> +        madvise(mem, pmdsize, MADV_HUGEPAGE);
>> +
>> +    /* Ensure memory is allocated */
>> +    memset(mem, 1, pmdsize);
>> +
>> +    if (madvise_buf == THP_COLLAPSE_MADV_COLLAPSE)
>> +        madvise(mem, pmdsize, MADV_COLLAPSE);
>> +
> 
> To avoid even mmap_mem to get merged with some other VMA, maybe just do
> before reading the smap here:
> 
> /* HACK: make sure we have a separate VMA that we can check reliably. */
> mprotect(mem, pmdsize, PROT_READ);
> 
Thanks! Yeah this is a nice hack, have used it in the next revision.

> or
> 
> madvise(mem, pmdsize, MADV_DONTFORK);
> 
> before reading smaps.
> 
> That is probably the easiest approach. The you can drop the lengthy comment and perform a single thp check.
> 
> 

[...]

