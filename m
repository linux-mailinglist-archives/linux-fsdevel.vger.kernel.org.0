Return-Path: <linux-fsdevel+bounces-1818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C167DF1F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 13:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A296B2120B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 12:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DE115E88;
	Thu,  2 Nov 2023 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752B415490
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 12:04:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04854112;
	Thu,  2 Nov 2023 05:04:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6C8B2F4;
	Thu,  2 Nov 2023 05:05:27 -0700 (PDT)
Received: from [10.1.33.173] (XHFQ2J9959.cambridge.arm.com [10.1.33.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A1A93F67D;
	Thu,  2 Nov 2023 05:04:41 -0700 (PDT)
Message-ID: <9edbf5f2-efce-40f1-ae7c-34607d9700ce@arm.com>
Date: Thu, 2 Nov 2023 12:04:40 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v33 6/6] selftests: mm: add pagemap ioctl tests
Content-Language: en-GB
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
 Andrei Vagin <avagin@gmail.com>, Danylo Mocherniuk <mdanylo@google.com>,
 Paul Gofman <pgofman@codeweavers.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>,
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
References: <20230821141518.870589-1-usama.anjum@collabora.com>
 <20230821141518.870589-7-usama.anjum@collabora.com>
 <f8463381-2697-49e9-9460-9dc73452830d@arm.com>
 <a9abc532-2d56-4da9-a016-419e8ae57ac4@collabora.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <a9abc532-2d56-4da9-a016-419e8ae57ac4@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/11/2023 11:49, Muhammad Usama Anjum wrote:
> On 11/2/23 4:45 PM, Ryan Roberts wrote:
>> On 21/08/2023 15:15, Muhammad Usama Anjum wrote:
>>
>> [...]
>>
>>> +
>>> +
>>> +int init_uffd(void)
>>> +{
>>> +	struct uffdio_api uffdio_api;
>>> +
>>> +	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
>>> +	if (uffd == -1)
>>> +		ksft_exit_fail_msg("uffd syscall failed\n");
>>> +
>>> +	uffdio_api.api = UFFD_API;
>>> +	uffdio_api.features = UFFD_FEATURE_WP_UNPOPULATED | UFFD_FEATURE_WP_ASYNC |
>>> +			      UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
>>> +	if (ioctl(uffd, UFFDIO_API, &uffdio_api))
>>> +		ksft_exit_fail_msg("UFFDIO_API\n");
>>> +
>>> +	if (!(uffdio_api.api & UFFDIO_REGISTER_MODE_WP) ||
>>> +	    !(uffdio_api.features & UFFD_FEATURE_WP_UNPOPULATED) ||
>>> +	    !(uffdio_api.features & UFFD_FEATURE_WP_ASYNC) ||
>>> +	    !(uffdio_api.features & UFFD_FEATURE_WP_HUGETLBFS_SHMEM))
>>> +		ksft_exit_fail_msg("UFFDIO_API error %llu\n", uffdio_api.api);
>>
>> Hi,
>>
>> I've just noticed that this fails on arm64 because the required features are not
>> available. It's common practice to skip instead of fail for this sort of
>> condition (and that's how all the other uffd tests work). The current fail
>> approach creates noise in our CI.
>>
>> I see this is already in mm-stable so perhaps we can add a patch to fix on top?
> Yeah, we can add a patch to skip all the tests instead of failing here. Let
> me send a patch this week.

Thats great - thanks for the fast response!

> 
>>
>> Thanks,
>> Ryan
>>
>>
> 


