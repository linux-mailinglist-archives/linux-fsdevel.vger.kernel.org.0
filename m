Return-Path: <linux-fsdevel+bounces-13288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C6F86E33D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 15:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1361D283E0E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6EB6F50A;
	Fri,  1 Mar 2024 14:23:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7266F074;
	Fri,  1 Mar 2024 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303009; cv=none; b=POBmKRVAJuhPcm9Rkd+cHhfboccoPf8s1V4f60cVgFUt7JPemwjvzgY8bEhFQmD0uhtxf7uytxg3omcLAUVvbi/E7a8DgmI3i4H+/dMO925UE5IHOnrYUuUo9YxeVgZ0UlLW0aW5XvbeIgnaNITvHVheW9PmYj81mSOrum/otCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303009; c=relaxed/simple;
	bh=YeW9orSlRtIML5TQ1wHKvJlrXnf90wDa5Uj1qZDj71M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jG4/2BzxhuZI5L0gnV84xdM02k/OieOEAF1zcT+RDYhzV48nvuhEPIAICRt/fcSEMmnW4R71yOf+CrBN63It4YvjTvGhop2YljibMia7IP8KrQLokP+odiOrmQ4jHnFed2X7WBdH6rAw24yHBShHcSlaNaAVN4VOFPtSgC4/9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7E271FB;
	Fri,  1 Mar 2024 06:24:03 -0800 (PST)
Received: from [10.57.68.58] (unknown [10.57.68.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DA013F73F;
	Fri,  1 Mar 2024 06:23:22 -0800 (PST)
Message-ID: <6645287e-d069-4c37-823b-d1b814ec0efe@arm.com>
Date: Fri, 1 Mar 2024 14:23:20 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] mm: huge_memory: enable debugfs to split huge
 pages to any order.
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>, Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Zach O'Keefe
 <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <2ED5C25C-FDB2-490F-B740-E413E8186C12@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2ED5C25C-FDB2-490F-B740-E413E8186C12@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/03/2024 14:00, Zi Yan wrote:
> On 1 Mar 2024, at 4:51, Aishwarya TCV wrote:
> 
>> On 26/02/2024 20:55, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> It is used to test split_huge_page_to_list_to_order for pagecache THPs.
>>> Also add test cases for split_huge_page_to_list_to_order via both
>>> debugfs.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  mm/huge_memory.c                              |  34 ++++--
>>>  .../selftests/mm/split_huge_page_test.c       | 115 +++++++++++++++++-
>>>  2 files changed, 131 insertions(+), 18 deletions(-)
>>>
>>
>> Hi Zi,
>>
>> When booting the kernel against next-master(20240228)with Arm64 on
>> Marvell Thunder X2 (TX2), the kselftest-mm test 'split_huge_page_test'
>> is failing in our CI (with rootfs over NFS). I can send the full logs if
>> required.
>>
>> A bisect (full log below) identified this patch as introducing the
>> failure. Bisected it on the tag "next-20240228" at repo
>> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".
>>
>> This works fine on  Linux version 6.8.0-rc6
> 
> Hi Aishwarya,
> 
> I am trying to fix the issue. When I am compiling selftests/mm, I encountered
> the error below when I run make under the folder. Am I missing any configuration?
> Since you are able to run the test, I assume you know what is happening. Thanks.

for what its worth, I usually compile from the top level directory with:

# make headers_install
# make -C tools/testing/selftests TARGETS=mm install INSTALL_PATH=~/kself

Perhaps the below is due to the headers not being exported properly. Bad things definitely happen if you omit the headers_install step.

> 
> vm_util.c: In function ‘__pagemap_scan_get_categories’:
> vm_util.c:34:28: error: storage size of ‘arg’ isn’t known
>    34 |         struct pm_scan_arg arg;
>       |                            ^~~
> vm_util.c:41:27: error: invalid application of ‘sizeof’ to incomplete type ‘struct pm_scan_arg’
>    41 |         arg.size = sizeof(struct pm_scan_arg);
>       |                           ^~~~~~
> vm_util.c:45:35: error: ‘PAGE_IS_WPALLOWED’ undeclared (first use in this function)
>    45 |         arg.category_anyof_mask = PAGE_IS_WPALLOWED | PAGE_IS_WRITTEN | PAGE_IS_FILE |
>       |                                   ^~~~~~~~~~~~~~~~~
> vm_util.c:45:35: note: each undeclared identifier is reported only once for each function it appears in
> vm_util.c:45:55: error: ‘PAGE_IS_WRITTEN’ undeclared (first use in this function)
>    45 |         arg.category_anyof_mask = PAGE_IS_WPALLOWED | PAGE_IS_WRITTEN | PAGE_IS_FILE |
>       |                                                       ^~~~~~~~~~~~~~~
> vm_util.c:45:73: error: ‘PAGE_IS_FILE’ undeclared (first use in this function)
>    45 |         arg.category_anyof_mask = PAGE_IS_WPALLOWED | PAGE_IS_WRITTEN | PAGE_IS_FILE |
>       |                                                                         ^~~~~~~~~~~~
> vm_util.c:46:35: error: ‘PAGE_IS_PRESENT’ undeclared (first use in this function); did you mean ‘PAGEMAP_PRESENT’?
>    46 |                                   PAGE_IS_PRESENT | PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |
>       |                                   ^~~~~~~~~~~~~~~
>       |                                   PAGEMAP_PRESENT
> vm_util.c:46:53: error: ‘PAGE_IS_SWAPPED’ undeclared (first use in this function)
>    46 |                                   PAGE_IS_PRESENT | PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |
>       |                                                     ^~~~~~~~~~~~~~~
> vm_util.c:46:71: error: ‘PAGE_IS_PFNZERO’ undeclared (first use in this function)
>    46 |                                   PAGE_IS_PRESENT | PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |
>       |                                                                       ^~~~~~~~~~~~~~~
> vm_util.c:47:35: error: ‘PAGE_IS_HUGE’ undeclared (first use in this function)
>    47 |                                   PAGE_IS_HUGE | PAGE_IS_SOFT_DIRTY;
>       |                                   ^~~~~~~~~~~~
> vm_util.c:47:50: error: ‘PAGE_IS_SOFT_DIRTY’ undeclared (first use in this function); did you mean ‘PM_SOFT_DIRTY’?
>    47 |                                   PAGE_IS_HUGE | PAGE_IS_SOFT_DIRTY;
>       |                                                  ^~~~~~~~~~~~~~~~~~
>       |                                                  PM_SOFT_DIRTY
> vm_util.c:50:26: error: ‘PAGEMAP_SCAN’ undeclared (first use in this function); did you mean ‘PAGEMAP_PFN’?
>    50 |         return ioctl(fd, PAGEMAP_SCAN, &arg);
>       |                          ^~~~~~~~~~~~
>       |                          PAGEMAP_PFN
> 
> --
> Best Regards,
> Yan, Zi


