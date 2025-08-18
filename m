Return-Path: <linux-fsdevel+bounces-58136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9D0B29F45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 12:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20253B4006
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 10:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75D52765D7;
	Mon, 18 Aug 2025 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B37GgHIn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20C258EFF;
	Mon, 18 Aug 2025 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513679; cv=none; b=EuwvILqn9ubFv4fftM865JttbaaDZ2DMSm/C8RjBMN/3qLOZ57LwwK7Dt6mh0wtlmStXVW3xKrrDH9Dy7mSuxEdDe1/1+YdGiJnwWVedk4mslrjg1J2Bw492CSC1H2zLYhMnhlZPTEfyuBAfMCG3So2uKXGPbu9MqceRwxq2Msk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513679; c=relaxed/simple;
	bh=ZVbgjvIAUQZEq8GAesdIxfdSjjdVs7b5JBgGQfKUikM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXvPZ0qsSW2wW85SKTon+81f2c7ynUwFGVjO+7SBEo17P3Vp/MnkdhAMkcsqtjqQ6+mbnj1t9zdJr+9h4fqguv1GoQHyNnjKZr157i4vfYZw8elqh+zU+M51/NzSfh6BWFQWosHEtkl+CWCPMViptZOCMuiUKx4mzNCtkU858Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B37GgHIn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9d41c1149so3044747f8f.0;
        Mon, 18 Aug 2025 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755513676; x=1756118476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BEOAZHx/EHGfD/sfEV5SJgXP8RiWdRzDUoJ3dlTfHJY=;
        b=B37GgHInIm6igICjbYht1ZiVC3mK7pPw6nEia/kUUio86S869T/66FoQOYIX6dgjTn
         TWXgGyZy0/x2CtiK2x31Sn1041tZqPWI8nNknuIXc6HTzaznvzChWogg+3MvnT2ZHuh9
         zUamXAUoXVf9Uav3Y7S43k7FNsMDwZTCFkhZ7xU+RjTfOBfZ/xd/4husT7g1ruDbMDRO
         5gn79yfumMVwNmJQQmX4JIpM5mfy1frl2tUPMJDfgmyOqgqK6gFu8VIFXeK62tD14tbY
         nBghZQd8MReukiZscqIaE29OBJjl/ovk+YOMG1oJjJsb4aukqbisjso/JgGlME4LyEsD
         D49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755513676; x=1756118476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BEOAZHx/EHGfD/sfEV5SJgXP8RiWdRzDUoJ3dlTfHJY=;
        b=C/WTcMHNaQ1nlpKVQLG2N7esBlUT2q+wgLamKiXaqiolkeIqtTS1KQZFp1HXXAE8Nz
         4GZR+4JSfrRkTTYLGkdstDyOXbXUK1/tFHjg6spR8P6Fjf2ah9ttbT1YTfGrAzCuzYmE
         qlaKVUkzqAfEL9UhmAvVL8ukN2eVsDRON3pN3sdCrrAENZ3glGMTyZudyYBcQpcQ9M0Z
         2JlKb+R4AEflv+PfED3Yzd0+ZOhJ2XqF1tJrggYVh7wWyr2ThpzcCwFwC9gfd0ici/zI
         gvSUlHBdvc96+snC/OucCTRlBNkTq9hICiruvmqgmD8RtMFtolEt9+ozh7LtOO6SS5r+
         7e0w==
X-Forwarded-Encrypted: i=1; AJvYcCVQn8y0JZWZdIQ1jOLEX+k0clNSYeO9Ak+7FPoxfZeX6b86aBlz8iWClqSgOqMtkiG0cO7CJDMQ9lM=@vger.kernel.org, AJvYcCXlJE76n0nINQ9PHStzJLI1WTHf34WhujhXLuL3DNSucOdm6+DfuyZb3pVW2zhR3ZR+dogA2F+xp8UL2Too@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIs/SBMB3Pw0c7JDSTLHMkV0Bzy6x2wDI2Wdrx8brc0NwNqS/
	BhAfaG/XoxXmp7XAJuUuShUMkvrGM5oGiOI4S//RWtom6bUhxES/jcN5
X-Gm-Gg: ASbGnctVArkWyGLEdvaAA3E6HSYYthpPwoCzT5gKMzmNVO0w8dDu6jz2nrLcBW+UWya
	3SYTYIAHPMM/ewjxOCWfKRHxXJ5eEv9o+SOPqCyQ/ATRGtvpxxaGOQMgeAx2UDxS3xgIfLPk1DP
	MqWfUTUGgBn3rYWMfID5bC5B8X15a9B4do1peBzvSTKM75I45oDEyDWSzI0WTXt4WcrvIhgaCaP
	0mfXPf23DWBaIuZ5LujXqS20jO8eXI4efgn4Ydx/o7DVgA7D8yj3LuffimcWP0/Rf8dGbA1vD3N
	zPzuSmxFXeIF+f64gJi6MLl0ZaJE5Xrc4FaarJS67lDM0z+YuUgWank6FbhJlwM5ZSVcj3o70WH
	VMV28BuWRJErDTrKUeRVZHnvLmK9YjDNehcNKRwX6P+ytTl5db0Hl1qAbXjp/7IPhghX76Z4=
X-Google-Smtp-Source: AGHT+IEA+CnzAZG5nqPWaucE17ppRYMiLY/83IrR6orHShs0Kok5GpAbtKiOzXR6WepIUKE8wXMAWw==
X-Received: by 2002:a05:6000:1a8d:b0:3b9:16fb:bfe2 with SMTP id ffacd0b85a97d-3bb66f10137mr7575027f8f.18.1755513675369;
        Mon, 18 Aug 2025 03:41:15 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::5:7223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64758d27sm12714320f8f.9.2025.08.18.03.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 03:41:14 -0700 (PDT)
Message-ID: <2d0ea708-ecba-4021-b6ca-e93f1413d60a@gmail.com>
Date: Mon, 18 Aug 2025 11:41:10 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] selftests: prctl: introduce tests for disabling
 THPs completely
To: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250815135549.130506-1-usamaarif642@gmail.com>
 <20250815135549.130506-7-usamaarif642@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250815135549.130506-7-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/08/2025 14:54, Usama Arif wrote:
> The test will set the global system THP setting to never, madvise
> or always depending on the fixture variant and the 2M setting to
> inherit before it starts (and reset to original at teardown).
> The fixture setup will also test if PR_SET_THP_DISABLE prctl call can
> be made to disable all THPs and skip if it fails.
> 
> This tests if the process can:
> - successfully get the policy to disable THPs completely.
> - never get a hugepage when the THPs are completely disabled
>   with the prctl, including with MADV_HUGE and MADV_COLLAPSE.
> - successfully reset the policy of the process.
> - after reset, only get hugepages with:
>   - MADV_COLLAPSE when policy is set to never.
>   - MADV_HUGE and MADV_COLLAPSE when policy is set to madvise.
>   - always when policy is set to "always".
> - never get a THP with MADV_NOHUGEPAGE.
> - repeat the above tests in a forked process to make sure
>   the policy is carried across forks.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  tools/testing/selftests/mm/.gitignore         |   1 +
>  tools/testing/selftests/mm/Makefile           |   1 +
>  .../testing/selftests/mm/prctl_thp_disable.c  | 175 ++++++++++++++++++
>  tools/testing/selftests/mm/thp_settings.c     |   9 +-
>  tools/testing/selftests/mm/thp_settings.h     |   1 +
>  5 files changed, 186 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/mm/prctl_thp_disable.c
>

Andrew, could you please apply the below fixlet on top of this patch as suggested
by David in https://lore.kernel.org/all/a385e09f-f582-4ede-9e60-1d85cee02a3c@redhat.com/?

Thanks!

From db9306c06cbd6057c2a8839e5d4c1d2559b58b70 Mon Sep 17 00:00:00 2001
From: Usama Arif <usamaarif642@gmail.com>
Date: Mon, 18 Aug 2025 11:27:04 +0100
Subject: [PATCH 2/4] [fixlet] selftests: prctl: return after executing test in
 child process

The next step after executing the test is a wait, but there is nothing to wait
for in the child, so just return.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 tools/testing/selftests/mm/prctl_thp_disable.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
index e9e519c85224c..df3cce278e10a 100644
--- a/tools/testing/selftests/mm/prctl_thp_disable.c
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -161,8 +161,10 @@ TEST_F(prctl_thp_disable_completely, fork)
 	pid = fork();
 	ASSERT_GE(pid, 0);
 
-	if (!pid)
+	if (!pid) {
 		prctl_thp_disable_completely_test(_metadata, self->pmdsize, variant->thp_policy);
+		return;
+	}
 
 	wait(&ret);
 	if (WIFEXITED(ret))
-- 
2.47.3



