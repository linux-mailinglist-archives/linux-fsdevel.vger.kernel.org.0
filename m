Return-Path: <linux-fsdevel+bounces-50155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EBCAC89A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 10:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB263BF10B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 08:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8861D61AA;
	Fri, 30 May 2025 08:04:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBD638B;
	Fri, 30 May 2025 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748592260; cv=none; b=L8XqPKxJW7+5dhdRCOK4DldJTF7S1bbXhC3pKFZ5DVKrgdXQxT1FZ/KcmdxXRqTX00kAiQbOszdDi/1z+Q3er9OLyZXNlDKA4iYn4VAihX42NFeu7bUlr4Ol7sVBe6lBhaHtWhpFMeoUk7LCPTxg7iHRPgIcTKR1MBeFBSDz3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748592260; c=relaxed/simple;
	bh=PqISbMpO8qeuWTjlG8MDM3jFwckzDRaq5U/AGMNoEIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MctzVQVdvWlsIptN1+0rfGI5snpH444UdG7CL6PsIP/tI4wUy20fnLAkOm2dNW4i5w/EpF30LNd82aSHvXsTO7rCkGRsyQId2JKJ/h8e4rI3OAC6RhYJqZNLoz1bGJKqA+SyipiRUFjLCwpMiDIebpV+dVHMj6OoJf9A596IfCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F33FF16F8;
	Fri, 30 May 2025 01:04:00 -0700 (PDT)
Received: from [10.57.95.14] (unknown [10.57.95.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFFC83F694;
	Fri, 30 May 2025 01:04:14 -0700 (PDT)
Message-ID: <05d60e72-3113-41f0-b81f-225397f06c81@arm.com>
Date: Fri, 30 May 2025 09:04:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fix MADV_COLLAPSE issue if THP settings are disabled
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com, david@redhat.com
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 dev.jain@arm.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/05/2025 09:23, Baolin Wang wrote:
> As we discussed in the previous thread [1], the MADV_COLLAPSE will ignore
> the system-wide anon/shmem THP sysfs settings, which means that even though
> we have disabled the anon/shmem THP configuration, MADV_COLLAPSE will still
> attempt to collapse into a anon/shmem THP. This violates the rule we have
> agreed upon: never means never. This patch set will address this issue.

This is a drive-by comment from me without having the previous context, but...

Surely MADV_COLLAPSE *should* ignore the THP sysfs settings? It's a deliberate
user-initiated, synchonous request to use huge pages for a range of memory.
There is nothing *transparent* about it, it just happens to be implemented using
the same logic that THP uses.

I always thought this was a deliberate design decision.

Thanks,
Ryan

> 
> [1] https://lore.kernel.org/all/1f00fdc3-a3a3-464b-8565-4c1b23d34f8d@linux.alibaba.com/
> 
> Baolin Wang (2):
>   mm: huge_memory: disallow hugepages if the system-wide THP sysfs
>     settings are disabled
>   mm: shmem: disallow hugepages if the system-wide shmem THP sysfs
>     settings are disabled
> 
>  include/linux/huge_mm.h | 23 +++++++++++++++++++----
>  mm/huge_memory.c        |  2 +-
>  mm/shmem.c              | 12 ++++++------
>  3 files changed, 26 insertions(+), 11 deletions(-)
> 


