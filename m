Return-Path: <linux-fsdevel+bounces-50161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3170AC8A71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF0AE7AE8C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051EC21CC52;
	Fri, 30 May 2025 09:07:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4390113A244;
	Fri, 30 May 2025 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748596037; cv=none; b=FIfEnRUZ/ZNszRGrouF3gR3Ktv/sokYwZrEbdTJBJz0EeifzsRK7lVm6o1iKezItWyBp1gGpCV8fGZWco5cJvps3RO1we1h4oaohc8iBlGrnLKN7+j5wkx0PR0DAtX0yqIX9hQRCbEamq+2nItDl/qBkZi5g++xH0temu3eaPP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748596037; c=relaxed/simple;
	bh=iViSuV0R+rv+QTUVkg89jRMRkjWH+ao1h5/HuE8kknI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ednUkCryZrhHxj7Qc9gyWS3buzvPa/6ioQs07MXASkP7ZyvY8X/8jnMJTii98a2bF3uEcocoBUZZGS53by/p3k+stjZz0OaQYPzETKIvkF4aVFsH74BzKWL4lHzDUe1fES9Q0I3U6AqsK0JEtvNetNAa4dtV6DmO+JgfOojkFp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2882016F2;
	Fri, 30 May 2025 02:06:58 -0700 (PDT)
Received: from [10.57.95.14] (unknown [10.57.95.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFAAD3F5A1;
	Fri, 30 May 2025 02:07:12 -0700 (PDT)
Message-ID: <00999fc3-3a4a-4ee5-8021-81c73253fe7f@arm.com>
Date: Fri, 30 May 2025 10:07:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fix MADV_COLLAPSE issue if THP settings are disabled
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com, Liam.Howlett@oracle.com, npache@redhat.com,
 dev.jain@arm.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
 <05d60e72-3113-41f0-b81f-225397f06c81@arm.com>
 <f3dad5b5-143d-4896-b315-38e1d7bb1248@redhat.com>
 <ade3bdb7-7103-4ecd-bce2-7768a0d729ef@lucifer.local>
 <9c920642-228b-4eb0-920a-269473ea824e@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <9c920642-228b-4eb0-920a-269473ea824e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/05/2025 09:52, David Hildenbrand wrote:
> On 30.05.25 10:47, Lorenzo Stoakes wrote:
>> On Fri, May 30, 2025 at 10:44:36AM +0200, David Hildenbrand wrote:
>>> On 30.05.25 10:04, Ryan Roberts wrote:
>>>> On 29/05/2025 09:23, Baolin Wang wrote:
>>>>> As we discussed in the previous thread [1], the MADV_COLLAPSE will ignore
>>>>> the system-wide anon/shmem THP sysfs settings, which means that even though
>>>>> we have disabled the anon/shmem THP configuration, MADV_COLLAPSE will still
>>>>> attempt to collapse into a anon/shmem THP. This violates the rule we have
>>>>> agreed upon: never means never. This patch set will address this issue.
>>>>
>>>> This is a drive-by comment from me without having the previous context, but...
>>>>
>>>> Surely MADV_COLLAPSE *should* ignore the THP sysfs settings? It's a deliberate
>>>> user-initiated, synchonous request to use huge pages for a range of memory.
>>>> There is nothing *transparent* about it, it just happens to be implemented
>>>> using
>>>> the same logic that THP uses.
>>>>
>>>> I always thought this was a deliberate design decision.
>>>
>>> If the admin said "never", then why should a user be able to overwrite that?
>>>
>>> The design decision I recall is that if VM_NOHUGEPAGE is set, we'll ignore
>>> that. Because that was set by the app itself (MADV_NOHUEPAGE).
>>>
>>
>> I'm with David on this one.
>>
>> I think it's principal of least surprise - to me 'never' is pretty
>> emphatic, and keep in mind the other choices are 'always' and...  'madvise'
>> :) which explicitly is 'hey only do this if madvise tells you to'.

I think it's a bit reductive to suggest that enabled=madvise means all madvise
calls though. I don't think anyone would suggest MADV_DONTNEED should be ignored
if enabled=never. MADV_COLLAPSE just happens to be implemented on top of the THP
logic. But it's a different feature in my view.

>>
>> I'd be rather surprised if I hadn't set madvise and a user uses madvise to
>> in some fashion override the never.
>>
>> I mean I think we all agree this interface is to use a technical term -
>> crap - and we need something a lot more fine-grained and smart, 

Yes agreed there!

>> but I think
>> given the situation we're in we should make it at least as least surprising
>> as possible.

> 
> Yes. If you configure "never" you are supposed to suffer, consistently.
> 

OK fair enough. Just giving my 2 cents.


