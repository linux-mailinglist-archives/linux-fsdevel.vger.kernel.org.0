Return-Path: <linux-fsdevel+bounces-50160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EC3AC8A40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 10:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 759AC7A4A35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC29521C9EE;
	Fri, 30 May 2025 08:59:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9D11D9663;
	Fri, 30 May 2025 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748595585; cv=none; b=TnDEbHb2TC9OCw0ICxj3km0LldfPJ3lzYy9LgnHBVpp+zhucMiTCa9EiODiskSJ87kvlrsY83PUz05xgpuEWmv1s+BMnKN64m5tnn7zU1FHMdKjaHfRCUXxE4EBkvAE9zOye1ZKqczFMWGj0gh6H4HI8mT4aO+9QdgHQTv6KSy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748595585; c=relaxed/simple;
	bh=RaQLPUUg+ZvY1aIfMu6PF0lA/P8xLcjONkdn20WRZpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyFFOE6/a9/C3nLHM4GzDRhthkWLKkRsY068/2EQVbQ3P192Tlxy9pNjN3+CgpkKToiDQkOSih6uMA1aR/vjxELPcQ38OoAoh79ahQKy41KL0yNr+J1KTVlUJ6epSqKnZO4q9hNA1HJei75+yWjnDKIJvD7DBm5/oR+92Fz+IWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBDC616F2;
	Fri, 30 May 2025 01:59:26 -0700 (PDT)
Received: from [10.57.95.14] (unknown [10.57.95.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8351C3F5A1;
	Fri, 30 May 2025 01:59:41 -0700 (PDT)
Message-ID: <9b1bac6c-fd9f-4dc1-8c94-c4da0cbb9e7f@arm.com>
Date: Fri, 30 May 2025 09:59:39 +0100
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
 Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 dev.jain@arm.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
 <05d60e72-3113-41f0-b81f-225397f06c81@arm.com>
 <f3dad5b5-143d-4896-b315-38e1d7bb1248@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <f3dad5b5-143d-4896-b315-38e1d7bb1248@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/05/2025 09:44, David Hildenbrand wrote:
> On 30.05.25 10:04, Ryan Roberts wrote:
>> On 29/05/2025 09:23, Baolin Wang wrote:
>>> As we discussed in the previous thread [1], the MADV_COLLAPSE will ignore
>>> the system-wide anon/shmem THP sysfs settings, which means that even though
>>> we have disabled the anon/shmem THP configuration, MADV_COLLAPSE will still
>>> attempt to collapse into a anon/shmem THP. This violates the rule we have
>>> agreed upon: never means never. This patch set will address this issue.
>>
>> This is a drive-by comment from me without having the previous context, but...
>>
>> Surely MADV_COLLAPSE *should* ignore the THP sysfs settings? It's a deliberate
>> user-initiated, synchonous request to use huge pages for a range of memory.
>> There is nothing *transparent* about it, it just happens to be implemented using
>> the same logic that THP uses.
>>
>> I always thought this was a deliberate design decision.
> 
> If the admin said "never", then why should a user be able to overwrite that?

Well my interpretation would be that the admin is saying never *transparently*
give anyone any hugepages; on balance it does more harm than good for my
workloads. The toggle is called transparent_hugepage/enabled, after all.

Whereas MADV_COLLAPSE is deliberately applied to a specific region at an
opportune moment in time, presumably because the user knows that the region
*will* benefit and because that point in the execution is not sensitive to latency.

I see them as logically separate.

> 
> The design decision I recall is that if VM_NOHUGEPAGE is set, we'll ignore that.
> Because that was set by the app itself (MADV_NOHUEPAGE).

Hmm, ok. My instinct would have been the opposite; MADV_NOHUGEPAGE means "I
don't want the risk of latency spikes and memory bloat that THP can cause". Not
"ignore my explicit requests to MADV_COLLAPSE".

But if that descision was already taken and that's the current behavior then I
agree we have an inconsistency with respect to the sysfs control.

Perhaps we should be guided by real world usage - AIUI there is a cloud that
disables THP at system level today (Google?). Is there any concern that there
are workloads in such environments that are using MADV_COLLAPSE today that would
then see a performance drop?


