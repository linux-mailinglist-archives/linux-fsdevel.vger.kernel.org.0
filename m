Return-Path: <linux-fsdevel+bounces-56139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA97B13DD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 17:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB5297A1BA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C09326FA60;
	Mon, 28 Jul 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESPW5u1A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99AC26A1B9
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715207; cv=none; b=BkvZlUayIP9YRdrawLQcfc5iBs+TfR4/hBf50n4OFOKQ4cVNTZDeehdVv8+7hkevFElzgbN/XKMwYalD5BZnyxnqKvnSkOooD3OpQs28Zh6S3jrfLD48KEbNbxEgpPH8fyDFlCmEMy8oEDXm9ApNhPPXgdlXEBQt9nAcN2rPaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715207; c=relaxed/simple;
	bh=+sFivDz8h9w0TUDOSxirDkBAONN3IjruXMO2Y1ewnIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXNXBZi4yactKR/EDH7An1fpjoBkW58jlWQxmT1CIZPBMI72FBw45+77nXtENEhFg2lCQSH9VsItc7W6MNK2p/VSXipT4cWaa/p5W3XizxQ/ni/51lfv95i03QVkptaIM39puiLQq+v3kN65yDSGAf03QStpRhe39ajR8NNcDMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESPW5u1A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753715204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YUi1XDTtiYjcSAgdzLC88rh3X0hvU+3avtLd78dgEV8=;
	b=ESPW5u1AmU4V+otF6HX4fm7r5l3DrFiYszxRO1xdXwhaLej/56pilRvn1UUbyK9VZ/uCkc
	E2yQa8y4Qy5KX0R57VI3bMXGIiAnm0iq4qKu45LDXvxaGDxH838BxuKHVAmAp5lErbjLiK
	QwZvYurfggjBtsOIFPPoYateLAdTI1U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-hSZ-aJCWPy2PPV5HQMyDiQ-1; Mon, 28 Jul 2025 11:06:43 -0400
X-MC-Unique: hSZ-aJCWPy2PPV5HQMyDiQ-1
X-Mimecast-MFC-AGG-ID: hSZ-aJCWPy2PPV5HQMyDiQ_1753715202
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45611579300so30850175e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 08:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753715202; x=1754320002;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YUi1XDTtiYjcSAgdzLC88rh3X0hvU+3avtLd78dgEV8=;
        b=rZYBR25TOp7h20jAdIA3uGK0K+xM59p23B7qmZy3gfY8W69hmnuHembjkoLUD82ijp
         sy3/nmFN4il4UXDzzGoIc4cayNL9GWzWfhyQKnj5sQlfbIbzKKpQLrL1Jx/xV1kZIyIm
         sOkNraXnSRq1ipDUjY/tpjCjlnEj9VGrQLgScYA8XbDuFxjPhbgIXlJLbrR3smBouWMh
         le2U9fKoqtXe67lfaf4o9Nn0gkdLM+SxqLfrrXddAgvFpmipFSyWO9Oxfixrl8j3gHEr
         0UeS6VZWDCEZ5uLt4AI13QcaW409LUV3TycTgGyADKolyu9vc/7NY6pq1XkK+9wHSRIV
         85cQ==
X-Gm-Message-State: AOJu0YxNgldzyyX8ItUYXnZkUgpOz3k/0qafrHGxQk12/orcMXuFWFUt
	yvQlvnXNCMQcFBZG/Pz3QLlUEmbQwUE3+UD5ZGrgYVyI6BChAxF3EvhtLDcfQjxKuQyBBpCCnl4
	wFqNmg7phGckzrmZ2mEUsqDM69yy14h4yH3S2+ZEHHMuRy+2X0RZ5m5I3cwUqZAT9AIA=
X-Gm-Gg: ASbGncs44bqz6wOv4zFCrcpKjGfRFCvjEBi3S3rGqBfS9aP8sPzv15Sr7uD0hhG3rEk
	G8Q5s+F4K1LchpShoqJTQ3b0GzRQmXuR82qSNEABjgDJbzFB9SDg40+grVHWVGNWanUWJIwsSlx
	B+KKZ5KZb3yREJD8Fy35wzYYUL3vcbCPgllAWwz8ZXFVROkjcQuIebePEKmuN+BkVyT1dXZ4/jT
	PH8UNU7Pw+SE20f96kdnngeHRmcXYJAgC7JFEGnPBUDzLgvEA/iAWhJe+WEbNqZnIXhPazbADuw
	h4Urlw9UnlvYlF8grU5MjHMUWGkaUuPqbsmf6SoW6jVlPO1x84fQ0qebzdpV061TbzZI8aq9rH6
	T5jqdvWhZObnH3fKRBTbdTV05+2pP8wI/Gu22LwSbAdiMG3zXaBOLXNNY9f9W8kC9NLo=
X-Received: by 2002:a05:600c:83c9:b0:450:d04e:22d6 with SMTP id 5b1f17b1804b1-458762fcb8cmr93391275e9.7.1753715201631;
        Mon, 28 Jul 2025 08:06:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8y/k01+6pf881FBgdTOGh4dIwIsXNTHMk88WH2WhZwB/CzKNLtjbz7C+TgRP2GPYL26Xh3w==
X-Received: by 2002:a05:600c:83c9:b0:450:d04e:22d6 with SMTP id 5b1f17b1804b1-458762fcb8cmr93390655e9.7.1753715200961;
        Mon, 28 Jul 2025 08:06:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587ac58162sm101784195e9.18.2025.07.28.08.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 08:06:40 -0700 (PDT)
Message-ID: <b9c72ab9-9687-4953-adfe-0a588a6dd0f7@redhat.com>
Date: Mon, 28 Jul 2025 17:06:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] selftests: prctl: introduce tests for disabling THPs
 completely
To: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250725162258.1043176-1-usamaarif642@gmail.com>
 <20250725162258.1043176-5-usamaarif642@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250725162258.1043176-5-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.07.25 18:22, Usama Arif wrote:
> The test will set the global system THP setting to madvise and
> the 2M setting to inherit before it starts (and reset to original
> at teardown)
> 
> This tests if the process can:
> - successfully set and get the policy to disable THPs completely.
> - never get a hugepage when the THPs are completely disabled,
>    including with MADV_HUGE and MADV_COLLAPSE.
> - successfully reset the policy of the process.
> - get hugepages only on MADV_HUGE and MADV_COLLAPSE after reset.
> - repeat the above tests in a forked process to make sure
>    the policy is carried across forks.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>   tools/testing/selftests/mm/.gitignore         |   1 +
>   tools/testing/selftests/mm/Makefile           |   1 +
>   .../testing/selftests/mm/prctl_thp_disable.c  | 162 ++++++++++++++++++
>   3 files changed, 164 insertions(+)
>   create mode 100644 tools/testing/selftests/mm/prctl_thp_disable.c
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index e7b23a8a05fe..eb023ea857b3 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -58,3 +58,4 @@ pkey_sighandler_tests_32
>   pkey_sighandler_tests_64
>   guard-regions
>   merge
> +prctl_thp_disable
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index d13b3cef2a2b..2bb8d3ebc17c 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -86,6 +86,7 @@ TEST_GEN_FILES += on-fault-limit
>   TEST_GEN_FILES += pagemap_ioctl
>   TEST_GEN_FILES += pfnmap
>   TEST_GEN_FILES += process_madv
> +TEST_GEN_FILES += prctl_thp_disable
>   TEST_GEN_FILES += thuge-gen
>   TEST_GEN_FILES += transhuge-stress
>   TEST_GEN_FILES += uffd-stress
> diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
> new file mode 100644
> index 000000000000..52f7e6659b1f
> --- /dev/null
> +++ b/tools/testing/selftests/mm/prctl_thp_disable.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Basic tests for PR_GET/SET_THP_DISABLE prctl calls
> + *
> + * Author(s): Usama Arif <usamaarif642@gmail.com>
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <sys/prctl.h>
> +#include <sys/wait.h>
> +
> +#include "../kselftest_harness.h"
> +#include "thp_settings.h"
> +#include "vm_util.h"
> +
> +#ifndef PR_THP_DISABLE_EXCEPT_ADVISED
> +#define PR_THP_DISABLE_EXCEPT_ADVISED (1 << 1)
> +#endif

Into patch #2 I guess.

> +
> +#define NR_HUGEPAGES 6
> +
> +static int sz2ord(size_t size, size_t pagesize)
> +{
> +	return __builtin_ctzll(size / pagesize);
> +}
> +
> +enum madvise_buffer {
> +	NONE,
> +	HUGE,
> +	COLLAPSE
> +};

Is that rather something like:

enum thp_collapse_type {
	THP_COLLAPSE_NONE,
	THP_COLLAPSE_MADV_HUGEPAGE, /* MADV_HUGEPAGE before access */
	THP_COLLAPSE_MADV_COLLAPSE, /* MADV_COLLAPSE after access */
};

> +
> +/*
> + * Function to mmap a buffer, fault it in, madvise it appropriately (before
> + * page fault for MADV_HUGE, and after for MADV_COLLAPSE), and check if the
> + * mmap region is huge.
> + * returns:
> + * 0 if test doesn't give hugepage
> + * 1 if test gives a hugepage
> + * -1 if mmap fails
> + */
> +static int test_mmap_thp(enum madvise_buffer madvise_buf, size_t pmdsize)
> +{
> +	int ret;
> +	int buf_size = NR_HUGEPAGES * pmdsize;
> +
> +	char *buffer = (char *)mmap(NULL, buf_size, PROT_READ | PROT_WRITE,
> +				    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

Can we get rid of NR_HUGEPAGES and just use a single one, aligning in a bigger area? This is similar to what we do in cow.c

/* For alignment purposes, we need twice the thp size. */
mmap_size = 2 * pmdsize;
mmap_area = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

if (mmap_area == MAP_FAILED)
	return -errno; /* todo, document that above */

buffer = (char *)(((uintptr_t)mmap_area + pmdsize) & ~(pmdsize - 1));

...

ret = check_huge_anon(buffer, NR_HUGEPAGES, pmdsize);

...

munmap(mmap_area, mmap_size);

> +	if (buffer == MAP_FAILED)
> +		return -1;
> +
> +	if (madvise_buf == HUGE)
> +		madvise(buffer, buf_size, MADV_HUGEPAGE);
> +
> +	/* Ensure memory is allocated */
> +	memset(buffer, 1, buf_size);
> +
> +	if (madvise_buf == COLLAPSE)
> +		madvise(buffer, buf_size, MADV_COLLAPSE);
> +
> +	ret = check_huge_anon(buffer, NR_HUGEPAGES, pmdsize);
> +	munmap(buffer, buf_size);
> +	return ret;
> +}

Empty line missing :)

> +FIXTURE(prctl_thp_disable_completely)
> +{
> +	struct thp_settings settings;
> +	size_t pmdsize;
> +};
> +
> +FIXTURE_SETUP(prctl_thp_disable_completely)
> +{
> +	if (!thp_is_enabled())
> +		SKIP(return, "Transparent Hugepages not available\n");

Heh, not completely correct. enabled != available.

Do we want a thp_available() that is essentially the first part of thp_is_enabled() ?

> +
> +	self->pmdsize = read_pmd_pagesize();
> +	if (!self->pmdsize)
> +		SKIP(return, "Unable to read PMD size\n");
> +
> +	thp_read_settings(&self->settings);
> +	self->settings.thp_enabled = THP_MADVISE;
> +	self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
> +	thp_save_settings();
> +	thp_push_settings(&self->settings);

push without pop, should that be alarming? :)

Can we just use thp_write_settings()? (not sure why that push/pop is required ... is it?)

> +}
> +
> +FIXTURE_TEARDOWN(prctl_thp_disable_completely)
> +{> +	thp_restore_settings();
> +}
> +
> +/* prctl_thp_disable_except_madvise fixture sets system THP setting to madvise */
> +static void prctl_thp_disable_completely(struct __test_metadata *const _metadata,
> +					 size_t pmdsize)
> +{
> +	int res = 0;
> +
> +	res = prctl(PR_GET_THP_DISABLE, NULL, NULL, NULL, NULL);
> +	ASSERT_EQ(res, 1);
> +
> +	/* global = madvise, process = never, we shouldn't get HPs even with madvise */

s/HPs/THPs/

> +	res = test_mmap_thp(NONE, pmdsize);
> +	ASSERT_EQ(res, 0);
> +
> +	res = test_mmap_thp(HUGE, pmdsize);
> +	ASSERT_EQ(res, 0);
> +
> +	res = test_mmap_thp(COLLAPSE, pmdsize);
> +	ASSERT_EQ(res, 0);
> +
> +	/* Reset to system policy */
> +	res =  prctl(PR_SET_THP_DISABLE, 0, NULL, NULL, NULL);
> +	ASSERT_EQ(res, 0);
> +
> +	/* global = madvise */
> +	res = test_mmap_thp(NONE, pmdsize);
> +	ASSERT_EQ(res, 0);
> +
> +	res = test_mmap_thp(HUGE, pmdsize);
> +	ASSERT_EQ(res, 1);
> +
> +	res = test_mmap_thp(COLLAPSE, pmdsize);
> +	ASSERT_EQ(res, 1);


Makes me wonder: should we test for global=always and global=always?

(or simply for all possible values, including global=never if easily possible?)

At least testing with global=always should exercise more possible paths
than global=always (esp., test_mmap_thp(NONE, pmdsize) which would
never apply in madvise mode).


-- 
Cheers,

David / dhildenb


