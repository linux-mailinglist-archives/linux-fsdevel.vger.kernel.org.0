Return-Path: <linux-fsdevel+bounces-72540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C98CFA595
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 19:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E1623040F2E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 18:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B4D35A920;
	Tue,  6 Jan 2026 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USbYp16l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3267C359FA9
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725737; cv=none; b=ALwbXlddM17LlVhUCI7M1Qzd1tQD2Vvt+IPHj0Xrzaubywp4UY61x0mFnGLKwhqUru1xtzndm+2o4fjnASpIIGu6g6bvmCSsOkweFDYvpAjqA3nqOdJIekpUZvMKnSwmRKGoVkrMmWXPP2cT309RxKR0WSGYAqOE03fXkenQ1l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725737; c=relaxed/simple;
	bh=l79MN7k7m7NEtZrL6dffvPEx0BF2/cRLOCmREMCGAsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9kRiALvZw8+rIPc+WgYND5lBnSM5sVfrfGa5OkVwbrbRd/iaNCjJhVnw5SmYteQOdSWLU7O7+Pcox122eIFu33q4Y7+//tO4XNGNb8dmdc88Yb/AKEOAQPinuEITalnXpTHwXjSjUKnr9zOdkJT+cfyj/NFIhC8tTtlqwiumv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USbYp16l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F119C116C6;
	Tue,  6 Jan 2026 18:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767725737;
	bh=l79MN7k7m7NEtZrL6dffvPEx0BF2/cRLOCmREMCGAsE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=USbYp16lLYrltyJvcP4H6/5miQe/JsVg+JK/ckh4Y7nMkM7bXWBJQCjg+7X6pCvjY
	 vZ+IbRdDhXsNpSGmIfbRDX2J7C30nMpLrZUOybTUBWwi66kE/F6iXWeAuwDCOTpf0w
	 wmyjJ72zd1l7CfrR8kd/nbmhHue9BdX/0BOZjyAilN8S9uvLGfbyDkxH1UDr/C/f7L
	 4ih5zK2fuLFlo2va1/TuPAjk6tc+dtPOcA5rnoE+VtfSlE7K/+5LFLymzcyZtB824P
	 RiMuSBBC0Qv4ZxRfOBF4FlbB/0ENUMV3QKJwDkqQkj/8j2ZkaRgJoLMZNcbD0KGwwn
	 BKVhf5gtS/1fw==
Message-ID: <ccd2cf6f-e2c5-4229-baa9-4cb3834b8f70@kernel.org>
Date: Tue, 6 Jan 2026 19:55:29 +0100
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
 <fc73a7a4-c66b-4437-b581-43bd7e5fae8d@kernel.org>
 <43024ae3-4131-4381-a766-5ca674d3f87d@huawei.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
In-Reply-To: <43024ae3-4131-4381-a766-5ca674d3f87d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/31/25 07:29, Jinjiang Tu wrote:
> 
> 在 2025/12/31 5:03, David Hildenbrand (Red Hat) 写道:
>> On 12/27/25 02:24, Jinjiang Tu wrote:
>>>
>>> 在 2025/12/25 12:15, Shardul Bankar 写道:
>>>> On Thu, 2025-12-18 at 21:11 +0800, Jinjiang Tu wrote:
>>>>> 在 2025/12/18 20:49, David Hildenbrand (Red Hat) 写道:
>>>>>>     Thanks for checking. I thought that was also discussed as part of
>>>>>> the other fix.
>>>>>>        See [2] where we have
>>>>>>        "Note: This fixes the leak of pre-allocated nodes. A
>>>>>> separate fix
>>>>>> will
>>>>>>     be needed to clean up empty nodes that were inserted into the tree
>>>>>> by
>>>>>>     xas_create_range() but never populated."
>>>>>>        Is that the issue you are describing? (sounds like it, but I
>>>>>> only
>>>>>> skimmed over the details).
>>>>>>        CCing Shardul.
>>>>> Yes, the same issue. As I descirbed in the first email:
>>>>> "
>>>>> At first, I tried to destory the empty nodes when collapse_file()
>>>>> goes to rollback path. However,
>>>>> collapse_file() only holds xarray lock and may release the lock, so
>>>>> we couldn't prevent concurrent
>>>>> call of collapse_file(), so the deleted empty nodes may be needed by
>>>>> other collapse_file() calls.
>>>>> "
>>>> Hi David, Jinjiang,
>>>>
>>>> As Jinjiang mentioned, this appears to address what I had originally
>>>> referred to in the "Note:" in [1].
>>>>
>>>> Just to clarify the context of the "Note:", that was based on my
>>>> assumption at the time that such empty nodes would be considered leaks.
>>>> After Dev’s feedback in [2]:
>>>> "No "fix" is needed in this case, the empty nodes are there in the tree
>>>> and there is no leak."
>>>>
>>>> and looking at the older discussion in [3]:
>>>> "There's nothing to free; if a node is allocated, then it's stored in
>>>> the tree where it can later be found and reused. "
>>>
>>> However, if the empty nodes aren't reused, When the file is deleted,
>>> shmem_evict_inode()->shmem_truncate_range() traverses all entries and
>>> calls xas_store(xas, NULL) to delete, if the leaf xa_node that stores
>>> deleted entry becomes empty, xas_store() will automatically delete the
>>> empty node and delete it's parent is empty too, until parent node isn't
>>> empty. shmem_evict_inode() won't traverse the empty nodes created by
>>> xas_create_range() due to these nodes doesn't store any entries.
>>
>> So you're saying that nothing/nobody would clean up these xarray
>> entries and we'd be leaking them?
> Yes.
>>
>> "struct xarray" documents "If all of the entries in the array are
>> NULL, @xa_head is a NULL pointer.". So we depend on all entries being
>> set to NULL in order to properly cleanup/free the xarray automatically.
>>
> Yes

Okay, then we really have to tackle this. Any takers? :)

-- 
Cheers

David

