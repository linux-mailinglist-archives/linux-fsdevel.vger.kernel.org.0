Return-Path: <linux-fsdevel+bounces-72252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C614CEAA4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 22:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BD2030191B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 21:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FE3221F20;
	Tue, 30 Dec 2025 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+JawV1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDC286277
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767128608; cv=none; b=rBDLnH6wiRCRT/a7qfVHbuRzTfAW4F/FcyR0wc/NOsBwSZhwvgFOWpFqozoUgQ2y2bWeQULf75H31YKdj5lijLQZDzPp5BeTYQ7uGLoXl0YDf6PNPxIGx2fta4UnFpFtO+0+0EcgkxtZupGxvbYiKjGqR6elYoVHJwNdKFYeqno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767128608; c=relaxed/simple;
	bh=bgT10EkK03Svs5fHkTLULngDPsGQUnaYXxpVT6Mb6PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEiv7Va+K85nGLAnD4t2lV+ccOTiXAKwwnrobyxIWWm444KP4O9M+cDZabWX6X/EEMQOryXa84xD9Es1bf9iAF6cfDHJICi2SD63Y3kW9VE9wGRj2FPNgKrI2oAtwV+o4YdR78P2+49sSa/n285ot6Ym331+HF1QHwwgKfCv8ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+JawV1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329B0C4CEFB;
	Tue, 30 Dec 2025 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767128607;
	bh=bgT10EkK03Svs5fHkTLULngDPsGQUnaYXxpVT6Mb6PI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U+JawV1p69DJMmJH/Z1+xqQnMTK0Yrgs1k//1yynBy33zml61E9GcZcjClkq0F/92
	 zp93yXLLkoQ99qKtUrUpUaZU9jMM23DUk0ugJSFXKF8Pi9oBufClSK6GsM7xSGHHLA
	 uquCXqY0NYnJhlCwKXQPyE3QTf8qMs6N/eGVzItMvn3F4j4gQokEd3L3vTimz/lJGR
	 MIQL2vDQz6ETlcdfR4oe6DizESV81g1yg5Jv4GAEQfFmybryzSWORe20zADLLV6OWQ
	 gdFN/OgSvml37LQSQOuynk9LiF4/sJywgdXOlAFNVgT0xn7JjFHzHz+anBszo/Ar9U
	 fTH5g+UDfA7Jg==
Message-ID: <fc73a7a4-c66b-4437-b581-43bd7e5fae8d@kernel.org>
Date: Tue, 30 Dec 2025 22:03:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] memory leak of xa_node in collapse_file() when
 rollbacks
To: Jinjiang Tu <tujinjiang@huawei.com>,
 Shardul Bankar <shardul.b@mpiricsoftware.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, ziy@nvidia.com,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, shardulsb08@gmail.com
References: <86834731-02ba-43ea-9def-8b8ca156ec4a@huawei.com>
 <32e4658f-d23b-4bae-9053-acdd5277bb17@kernel.org>
 <4b129453-97d1-4da4-9472-21c1634032d0@huawei.com>
 <05bbe26e-e71a-4a49-95d2-47373b828145@kernel.org>
 <a629d3bb-c7e2-41e0-87e0-7a7a6367c1b6@huawei.com>
 <308b7b3c4f6c74c46906e25d6069049c70222ed8.camel@mpiricsoftware.com>
 <eefae4cc-ec75-4378-a153-c190fdc230c1@huawei.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <eefae4cc-ec75-4378-a153-c190fdc230c1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/27/25 02:24, Jinjiang Tu wrote:
> 
> 在 2025/12/25 12:15, Shardul Bankar 写道:
>> On Thu, 2025-12-18 at 21:11 +0800, Jinjiang Tu wrote:
>>> 在 2025/12/18 20:49, David Hildenbrand (Red Hat) 写道:
>>>    
>>>>    Thanks for checking. I thought that was also discussed as part of
>>>> the other fix.
>>>>    
>>>>    See [2] where we have
>>>>    
>>>>    "Note: This fixes the leak of pre-allocated nodes. A separate fix
>>>> will
>>>>    be needed to clean up empty nodes that were inserted into the tree
>>>> by
>>>>    xas_create_range() but never populated."
>>>>    
>>>>    Is that the issue you are describing? (sounds like it, but I only
>>>> skimmed over the details).
>>>>    
>>>>    CCing Shardul.
>>> Yes, the same issue. As I descirbed in the first email:
>>> "
>>> At first, I tried to destory the empty nodes when collapse_file()
>>> goes to rollback path. However,
>>> collapse_file() only holds xarray lock and may release the lock, so
>>> we couldn't prevent concurrent
>>> call of collapse_file(), so the deleted empty nodes may be needed by
>>> other collapse_file() calls.
>>> "
>> Hi David, Jinjiang,
>>
>> As Jinjiang mentioned, this appears to address what I had originally
>> referred to in the "Note:" in [1].
>>
>> Just to clarify the context of the "Note:", that was based on my
>> assumption at the time that such empty nodes would be considered leaks.
>> After Dev’s feedback in [2]:
>> "No "fix" is needed in this case, the empty nodes are there in the tree
>> and there is no leak."
>>
>> and looking at the older discussion in [3]:
>> "There's nothing to free; if a node is allocated, then it's stored in
>> the tree where it can later be found and reused. "
> 
> However, if the empty nodes aren't reused, When the file is deleted,
> shmem_evict_inode()->shmem_truncate_range() traverses all entries and
> calls xas_store(xas, NULL) to delete, if the leaf xa_node that stores
> deleted entry becomes empty, xas_store() will automatically delete the
> empty node and delete it's parent is empty too, until parent node isn't
> empty. shmem_evict_inode() won't traverse the empty nodes created by
> xas_create_range() due to these nodes doesn't store any entries.

So you're saying that nothing/nobody would clean up these xarray entries 
and we'd be leaking them?

"struct xarray" documents "If all of the entries in the array are NULL, 
@xa_head is a NULL pointer.". So we depend on all entries being set to 
NULL in order to properly cleanup/free the xarray automatically.

-- 
Cheers

David

