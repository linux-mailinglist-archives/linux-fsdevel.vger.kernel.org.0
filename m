Return-Path: <linux-fsdevel+bounces-36349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607949E1FC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 15:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C56284970
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 14:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256111F4734;
	Tue,  3 Dec 2024 14:42:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6FE1E25E4;
	Tue,  3 Dec 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236952; cv=none; b=RDtpN74qb1B7SxxnlIYJuJTZWAXLEF5+QZRv/P14K6hAKNf+EEQy+PePhHx/1Hb7QSd7qaq9JwBpya7rDKk/HjyDV4DcSwCUJ3FVWSu20KRAFzou3CSbX3x+2CNv/MIPu1vqi4ILzCJ9W2hWmmc+vLftoKQ18CnPZRU0dTojKAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236952; c=relaxed/simple;
	bh=a1sv7yNgLfruuxtj7ruwGgaD5fU0gF2JQ7MMM+qelH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PmLz7h0hh9Mj0/FvGTm97EApSp2q6FZyZ51uPNcSsgIsT8rddhtaAhDdWDj9jXRZyCyxGC2J2D5vAyMGaGiurE+F9eAWEx35PlpMQHjXjeG1e4FSe3WlGReKixRlo1j5W4L1PyQX4oyHXb3A/BT7L9Ie7E+X4hWe+wjAh+bl7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A46D2FEC;
	Tue,  3 Dec 2024 06:42:57 -0800 (PST)
Received: from [10.57.90.133] (unknown [10.57.90.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64AD63F71E;
	Tue,  3 Dec 2024 06:42:27 -0800 (PST)
Message-ID: <f2d58d57-df38-42eb-a00c-a993ca7299ba@arm.com>
Date: Tue, 3 Dec 2024 14:42:25 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: count large pages smaller than PMD size to
 anonymous_thp
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Wenchao Hao
 <haowenchao22@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrii Nakryiko <andrii@kernel.org>, Peter Xu <peterx@redhat.com>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20241203134949.2588947-1-haowenchao22@gmail.com>
 <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/12/2024 14:17, David Hildenbrand wrote:
> On 03.12.24 14:49, Wenchao Hao wrote:
>> Currently, /proc/xxx/smaps reports the size of anonymous huge pages for
>> each VMA, but it does not include large pages smaller than PMD size.
>>
>> This patch adds the statistics of anonymous huge pages allocated by
>> mTHP which is smaller than PMD size to AnonHugePages field in smaps.
>>
>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
>> ---
>>   fs/proc/task_mmu.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 38a5a3e9cba2..b655011627d8 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -717,6 +717,12 @@ static void smaps_account(struct mem_size_stats *mss,
>> struct page *page,
>>           if (!folio_test_swapbacked(folio) && !dirty &&
>>               !folio_test_dirty(folio))
>>               mss->lazyfree += size;
>> +
>> +        /*
>> +         * Count large pages smaller than PMD size to anonymous_thp
>> +         */
>> +        if (!compound && PageHead(page) && folio_order(folio))
>> +            mss->anonymous_thp += folio_size(folio);
>>       }
>>         if (folio_test_ksm(folio))
> 
> 
> I think we decided to leave this (and /proc/meminfo) be one of the last
> interfaces where this is only concerned with PMD-sized ones:
> 
> Documentation/admin-guide/mm/transhuge.rst:
> 
> The number of PMD-sized anonymous transparent huge pages currently used by the
> system is available by reading the AnonHugePages field in ``/proc/meminfo``.
> To identify what applications are using PMD-sized anonymous transparent huge
> pages, it is necessary to read ``/proc/PID/smaps`` and count the AnonHugePages
> fields for each mapping. (Note that AnonHugePages only applies to traditional
> PMD-sized THP for historical reasons and should have been called
> AnonHugePmdMapped).
> 

Agreed. If you need per-process metrics for mTHP, we have a python script at
tools/mm/thpmaps which does a fairly good job of parsing pagemap. --help gives
you all the options.


