Return-Path: <linux-fsdevel+bounces-1816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345C97DF19E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 12:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5C71C20EF2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 11:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C586214F6E;
	Thu,  2 Nov 2023 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SKVfTG98"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191414ABF
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 11:49:57 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF169E4;
	Thu,  2 Nov 2023 04:49:52 -0700 (PDT)
Received: from [100.98.85.67] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 35E696603102;
	Thu,  2 Nov 2023 11:49:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1698925791;
	bh=DnwHAYWfAm3XZipZksuQGXF6sjFyFFaQUCgEARzx934=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=SKVfTG98EttX7MvGf7/J9/7o9DENZJm5T53wD2AxQHucm9rfKzRBoLdUq3eaY6Tyr
	 nnW2hbmTZGZOE+Ob2DHwLFU1t6+jthHUubGWxwLZqGB4y6PDX2m50UVt0zGGV5pvl5
	 yZT6Il+zrTYuFrtEV90z5JjqR1TyVyR0dj4QAzohaVpY6Av92xVj+0X4KeGTJkoNs5
	 G/cYlPaAliy5FnwOTM2qFGRkckMwrSJHdpuB7HJb96c6ac4vobTiT22EEtPT0vvb/e
	 s7OGvqe11DzO6W0Ru0v87mDXSHdbEUCQd4Cjeknr2FndxH67JxejfM/xMbbrjLDx7e
	 /wm3YpqUoO4yw==
Message-ID: <a9abc532-2d56-4da9-a016-419e8ae57ac4@collabora.com>
Date: Thu, 2 Nov 2023 16:49:41 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Yang Shi <shy828301@gmail.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@Oracle.com>, Yun Zhou <yun.zhou@windriver.com>,
 Suren Baghdasaryan <surenb@google.com>, Alex Sierra <alex.sierra@amd.com>,
 Matthew Wilcox <willy@infradead.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 kernel@collabora.com, Cyrill Gorcunov <gorcunov@gmail.com>,
 Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v33 6/6] selftests: mm: add pagemap ioctl tests
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?=
 =?UTF-8?Q?aw?= <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
 Danylo Mocherniuk <mdanylo@google.com>, Paul Gofman <pgofman@codeweavers.com>
References: <20230821141518.870589-1-usama.anjum@collabora.com>
 <20230821141518.870589-7-usama.anjum@collabora.com>
 <f8463381-2697-49e9-9460-9dc73452830d@arm.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <f8463381-2697-49e9-9460-9dc73452830d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/23 4:45 PM, Ryan Roberts wrote:
> On 21/08/2023 15:15, Muhammad Usama Anjum wrote:
> 
> [...]
> 
>> +
>> +
>> +int init_uffd(void)
>> +{
>> +	struct uffdio_api uffdio_api;
>> +
>> +	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
>> +	if (uffd == -1)
>> +		ksft_exit_fail_msg("uffd syscall failed\n");
>> +
>> +	uffdio_api.api = UFFD_API;
>> +	uffdio_api.features = UFFD_FEATURE_WP_UNPOPULATED | UFFD_FEATURE_WP_ASYNC |
>> +			      UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
>> +	if (ioctl(uffd, UFFDIO_API, &uffdio_api))
>> +		ksft_exit_fail_msg("UFFDIO_API\n");
>> +
>> +	if (!(uffdio_api.api & UFFDIO_REGISTER_MODE_WP) ||
>> +	    !(uffdio_api.features & UFFD_FEATURE_WP_UNPOPULATED) ||
>> +	    !(uffdio_api.features & UFFD_FEATURE_WP_ASYNC) ||
>> +	    !(uffdio_api.features & UFFD_FEATURE_WP_HUGETLBFS_SHMEM))
>> +		ksft_exit_fail_msg("UFFDIO_API error %llu\n", uffdio_api.api);
> 
> Hi,
> 
> I've just noticed that this fails on arm64 because the required features are not
> available. It's common practice to skip instead of fail for this sort of
> condition (and that's how all the other uffd tests work). The current fail
> approach creates noise in our CI.
> 
> I see this is already in mm-stable so perhaps we can add a patch to fix on top?
Yeah, we can add a patch to skip all the tests instead of failing here. Let
me send a patch this week.

> 
> Thanks,
> Ryan
> 
> 

-- 
BR,
Muhammad Usama Anjum

