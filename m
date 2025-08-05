Return-Path: <linux-fsdevel+bounces-56732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D711BB1B207
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 12:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A33B17DC5D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 10:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A34F4A06;
	Tue,  5 Aug 2025 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0QXJtJ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE811552FA
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389831; cv=none; b=XGb0sQgwly+b9Y+YePuuX02FX0yzsFXZg1Ai8gyu432ourZaONhUa9ATtngQT9NUVrmZElteAm+u3bcqCOo3pBteUGkwh6vK5RxJw1+CLYyy9Sm10ZDyUeOTwQmYPhUhOPzhEmcsT4VlZPu2o94dEHXSiOa64vUCgUzc8cb83yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389831; c=relaxed/simple;
	bh=lYTsqHfgtClSaq4hDWkmMzi3zRvfGNpaaiR4LI3ZV4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVv4SH/C53Bi/DUEYdGWFWakM/xQ6HTPP7V4UgHKpEpTD4dvWby5eNFx2/7SiXQy2aTuaCB0EimipPi0K7UVnc+6AwtIG3tch+5uw9X6kOfw2+Ggtrs8TigeYOn67QCy2tEhsveIN5So5PVwYc8cVNsOq5BI3xR6W8moepZtsQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0QXJtJ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754389829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5QBRGAqc9wV2ClFxJdEhBBHYCynit2/ZYJDeC1A7nhI=;
	b=f0QXJtJ1IRJ0iZFsI2d+6JInanogkBsidZod2z+losqONy3WjMr5b7DJGDx7F9fqzBQdVJ
	ItBbed3gnuNEzj3Wfns9aZO21KlMy7nFpFCmHxY72TYJr3gdyqxfQ541u46cZPcP+S38xa
	y6O2wW+BDyMsDmMhDrBjXb0pp8zHtlI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-NhxeCisrMwKAczxc0wy7NA-1; Tue, 05 Aug 2025 06:30:28 -0400
X-MC-Unique: NhxeCisrMwKAczxc0wy7NA-1
X-Mimecast-MFC-AGG-ID: NhxeCisrMwKAczxc0wy7NA_1754389827
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so2203595f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 03:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754389827; x=1754994627;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5QBRGAqc9wV2ClFxJdEhBBHYCynit2/ZYJDeC1A7nhI=;
        b=nLYinBbcg6eDiNZSMI0wrLERW4vSjohrQWD4sjHiaES720se/WlOPUYSjaAtRu8eZw
         7iD3SBVQjz6/3qZlml96F6iweWD/QeZ2ZPGqn9LspjjO6PcguF7rJONf8Zd/RyKbTQ5X
         5uHhAJIjjCDaDCd9m768PwG56ETM9Tj8cM9AhJCMMfWwsyKHTLWItm/5entRxZ/Cd553
         Bd4MtBKTWaZTpLdFJMLR7Ts98sDgDeqAtvb6RkdUJfkkkvrCKXWgxQ2pEujhPgv16nCD
         eYqynVsYiMXNzydO5mo1xedX4bhgxNZWhNm+Ut8ictbqyDumfzgDNjstT/9Ys61jsvio
         CkdQ==
X-Gm-Message-State: AOJu0Yydejq+Pt+nP+sKyM+epY2Etjh1KYQ4GnHHhVtMv/C5zFmzx3yt
	oZ7CPSmXW/Bcwbf985Hyu6bYyPnpIwDYQ0jDdu42ik5/kkvf3H5slNN518jwNHpuea4KoOcfMfP
	58LQQ22cIi/+eAQ/u1dSbQJ0IpDmLXl+PQ2kOdSSXPi66fzpXvpgx61mCuwXnoOnxZQU=
X-Gm-Gg: ASbGncsKiM+9408YrK40Ky3xjxlfpo0hZuk8Ddnn1VRL5CqsmwaDBt32MQUYAzSpOE2
	hqiDKONLZ7X4BwpgfKKzhgg9/r9kS0Wtb5KKqgrPfstiIKM7tE82V5Mp+Ibr3IE4sZEynl43veU
	iBO/WtNbqjfBjw75VYGlIt0Bx0i0UN/ayMUHsTaevSK4J/sKre1zFBwNPgYCYbORfC7VJwEavPt
	J2uyrB97MiLsUB4XNIoKk5LtZCX9bL/4yIIBHy5zDmN6yJF3KJUYXSAJfBoSWpgDivlKXjVWNpY
	vCO7Yw1lfGCNCDntSx2V8Ehl5cKDP5zFZkxz80vTK7NuD1wztgxo/KPlpcCxy03w02pCf3qKmRm
	204im4IWb9diTvQU/qBFfVC2cVfeMyCB/gaTyZO/991oFsiFCrr3gkmN7mhtj7s5u+as=
X-Received: by 2002:a5d:5849:0:b0:3b7:8481:e365 with SMTP id ffacd0b85a97d-3b8d946807cmr8921452f8f.10.1754389826739;
        Tue, 05 Aug 2025 03:30:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1mB+c6XVjZUqBR7O+G7xU80WhlBPcGKDy3bCyz+mMN14dRewdIyXB/kqLc4gAzRNnToKQLw==
X-Received: by 2002:a5d:5849:0:b0:3b7:8481:e365 with SMTP id ffacd0b85a97d-3b8d946807cmr8921405f8f.10.1754389826173;
        Tue, 05 Aug 2025 03:30:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459d712c386sm81117925e9.23.2025.08.05.03.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 03:30:25 -0700 (PDT)
Message-ID: <eec7e868-a61f-41ed-a8ef-7ff80548089f@redhat.com>
Date: Tue, 5 Aug 2025 12:30:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] selftests: prctl: introduce tests for disabling
 THPs completely
To: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com,
 Donet Tom <donettom@linux.ibm.com>
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-6-usamaarif642@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250804154317.1648084-6-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 17:40, Usama Arif wrote:
> The test will set the global system THP setting to never, madvise
> or always depending on the fixture variant and the 2M setting to
> inherit before it starts (and reset to original at teardown).
> 
> This tests if the process can:
> - successfully set and get the policy to disable THPs completely.
> - never get a hugepage when the THPs are completely disabled
>    with the prctl, including with MADV_HUGE and MADV_COLLAPSE.
> - successfully reset the policy of the process.
> - after reset, only get hugepages with:
>    - MADV_COLLAPSE when policy is set to never.
>    - MADV_HUGE and MADV_COLLAPSE when policy is set to madvise.
>    - always when policy is set to "always".
> - repeat the above tests in a forked process to make sure
>    the policy is carried across forks.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>   tools/testing/selftests/mm/.gitignore         |   1 +
>   tools/testing/selftests/mm/Makefile           |   1 +
>   .../testing/selftests/mm/prctl_thp_disable.c  | 173 ++++++++++++++++++
>   tools/testing/selftests/mm/thp_settings.c     |   9 +-
>   tools/testing/selftests/mm/thp_settings.h     |   1 +
>   5 files changed, 184 insertions(+), 1 deletion(-)
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
> index 000000000000..ef150180daf4
> --- /dev/null
> +++ b/tools/testing/selftests/mm/prctl_thp_disable.c
> @@ -0,0 +1,173 @@
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
> +static int sz2ord(size_t size, size_t pagesize)
> +{
> +	return __builtin_ctzll(size / pagesize);
> +}

Note: We have this helper duplicated elsewhere (e.g., cow.c).

See [1] how we're going to clean it up.

Not sure how to resolve this. Probably, which series lands first in 
mm-unstable should clean it up.

I would assume that Donet's series would go in first, such that you can 
just reuse the helper from vm_utils.h

[1] https://lkml.kernel.org/r/20250804090410.of5xwrlker665bdp@master


Nothing else jumped at me

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


