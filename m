Return-Path: <linux-fsdevel+bounces-13438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F5886FE08
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 10:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E84B23724
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 09:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ADE225CF;
	Mon,  4 Mar 2024 09:50:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFE2241E3;
	Mon,  4 Mar 2024 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545837; cv=none; b=JW5fuglhcmmpr/IURSD4UPYwogDPRmjmThxpxzjDJTtkjNOM5VyU+Dxsbyk8G2ZgoJY1RFpvYbaLhrjULdZlH7zTqqNZEsMXzvYQki0FS4cB2mE5DOW2vx0kwjznEDKH3+moGQLhk/VcVQQccBiIt5YTtapqXBqocg+7kYfi1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545837; c=relaxed/simple;
	bh=H7NXG0DJNfXrnrJCrvS2GZLlDD9IRnE/n5Zgd4qxAwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kN/Lr/6DDL8/FFlgD5PSkGKLArY16I9TpNfWlis6/GNL55gDrP8QMxPr4neiSqtPB7Eh0LCzjiOhgMKW58AL2T9ka2UtzzSuB5Dn9ZaODxONgOHfon1DbE9JK2Wv8nzu12sP4MEaO4C83FA5WVew/DpGRJH+2/WBpPt70Igj5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 704111FB;
	Mon,  4 Mar 2024 01:51:11 -0800 (PST)
Received: from [10.57.10.152] (unknown [10.57.10.152])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B11203F738;
	Mon,  4 Mar 2024 01:50:31 -0800 (PST)
Message-ID: <0be630f0-ce8e-4a80-b42f-697ea603cfc6@arm.com>
Date: Mon, 4 Mar 2024 09:50:31 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] mm: huge_memory: enable debugfs to split huge
 pages to any order.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Zach O'Keefe <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <A111EB95-0AF5-4715-82A4-70B8AD900A93@nvidia.com>
 <7E498B77-6CC9-4FC6-B980-D79EEC548CD0@nvidia.com>
 <0685EC19-CDB8-4CD3-BC39-82DE59B5D10C@nvidia.com>
From: Aishwarya TCV <aishwarya.tcv@arm.com>
In-Reply-To: <0685EC19-CDB8-4CD3-BC39-82DE59B5D10C@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/03/2024 21:10, Zi Yan wrote:
> On 1 Mar 2024, at 15:02, Zi Yan wrote:
> 
>> On 1 Mar 2024, at 14:37, Zi Yan wrote:
>>
>>> On 1 Mar 2024, at 4:51, Aishwarya TCV wrote:
>>>
>>>> On 26/02/2024 20:55, Zi Yan wrote:
>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>
>>>>> It is used to test split_huge_page_to_list_to_order for pagecache THPs.
>>>>> Also add test cases for split_huge_page_to_list_to_order via both
>>>>> debugfs.
>>>>>
>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>> ---
>>>>>  mm/huge_memory.c                              |  34 ++++--
>>>>>  .../selftests/mm/split_huge_page_test.c       | 115 +++++++++++++++++-
>>>>>  2 files changed, 131 insertions(+), 18 deletions(-)
>>>>>
>>>>
>>>> Hi Zi,
>>>>
>>>> When booting the kernel against next-master(20240228)with Arm64 on
>>>> Marvell Thunder X2 (TX2), the kselftest-mm test 'split_huge_page_test'
>>>> is failing in our CI (with rootfs over NFS). I can send the full logs if
>>>> required.
>>>>
>>>> A bisect (full log below) identified this patch as introducing the
>>>> failure. Bisected it on the tag "next-20240228" at repo
>>>> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".
>>>>
>>>> This works fine on  Linux version 6.8.0-rc6
>>>
>>> Hi Aishwarya,
>>>
>>> Can you try the attached patch and see if it fixes the failure? I changed
>>> the test to accept XFS dev as input, mount XFS on a temp folder under /tmp,
>>> and skip if no XFS is mounted.
>>
>> Please try this updated one. It allows you to specify a XFS device path
>> in SPLIT_HUGE_PAGE_TEST_XFS_PATH env variable, which is passed to
>> split_huge_page_test in run_vmtests.sh. It at least allow CI/CD to run
>> the test without too much change.
> 
> OK. This hopefully will be my last churn. Now split_huge_page_test accepts
> a path that is backed by XFS and run_vmtest.sh creates a XFS image in /tmp,
> mounts it in /tmp, and gives the path to split_huge_page_test. I tested
> it locally and it works. Let me know if you have any issue. Thanks.
> 
> --
> Best Regards,
> Yan, Zi

Hi Zi,

Tested the patch by applying it on next-20240304. Logs from our CI with
rootfs over nfs is attached below. "Bail out! cannot remove tmp dir:
Directory not empty" is still observed.


Test run log:
# # ------------------------------
# # running ./split_huge_page_test
# # ------------------------------
# # TAP version 13
# # 1..12
# # ok 1 Split huge pages successful
# # ok 2 Split PTE-mapped huge pages successful
# # # Please enable pr_debug in split_huge_pages_in_file() for more info.
# # # Please check dmesg for more information
# # ok 3 File-backed THP split test done
<6>[  639.821657] split_huge_page (111099): drop_caches: 3
<6>[  639.821657] split_huge_page (111099): drop_caches: 3
# # # No large pagecache folio generated, please provide a filesystem
supporting large folio
# # ok 4 # SKIP Pagecache folio split skipped
<6>[  645.392184] split_huge_page (111099): drop_caches: 3
<6>[  645.392184] split_huge_page (111099): drop_caches: 3
# # # No large pagecache folio generated, please provide a filesystem
supporting large folio
# # ok 5 # SKIP Pagecache folio split skipped
<6>[  650.938248] split_huge_page (111099): drop_caches: 3
<6>[  650.938248] split_huge_page (111099): drop_caches: 3
# # # No large pagecache folio generated, please provide a filesystem
supporting large folio
# # ok 6 # SKIP Pagecache folio split skipped
<6>[  656.500149] split_huge_page (111099): drop_caches: 3
<6>[  656.500149] split_huge_page (111099): drop_caches: 3
# # # No large pagecache folio generated, please provide a filesystem
supporting large folio
# # ok 7 # SKIP Pagecache folio split skipped
<6>[  662.044085] split_huge_page (111099): drop_caches: 3
<6>[  662.044085] split_huge_page (111099): drop_caches: 3
# # # No large pagecache folio generated, please provide a filesystem
supporting large folio
# # ok 8 # SKIP Pagecache folio split skipped
<6>[  667.591841] split_huge_page (111099): drop_caches: 3
<6>[  667.591841] split_huge_page (111099): drop_caches: 3
# # # No large pagecache folio generated, please provide a filesystem
supporting large folio
# # ok 9 # SKIP Pagecache folio split skipped
<6>[  673.172441] split_huge_page (111099): drop_caches: 3
<6>[  673.172441] split_huge_page (111099): drop_caches: 3
# # # No large pagecache folio generated, please provide a filesystem
supporting large folio
# # ok 10 # SKIP Pagecache folio split skipped
<6>[  678.726263] split_huge_page (111099): drop_caches: 3
<6>[  678.726263] split_huge_page (111099): drop_caches: 3
# # # No large pagecache folio generated, please provide a filesystem
supporting large folio
# # ok 11 # SKIP Pagecache folio split skipped
<6>[  684.272851] split_huge_page (111099): drop_caches: 3
<6>[  684.272851] split_huge_page (111099): drop_caches: 3
# # # No large pagecache folio generated, please provide a filesystem
supporting large folio
# # ok 12 # SKIP Pagecache folio split skipped
# # Bail out! cannot remove tmp dir: Directory not empty
# # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:9 error:0
# # [FAIL]
# not ok 51 split_huge_page_test # exit=1
# # ------------------

Thanks,
Aishwarya

