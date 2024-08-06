Return-Path: <linux-fsdevel+bounces-25094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84078948D85
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 13:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310641F2382A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BB51C233F;
	Tue,  6 Aug 2024 11:17:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F4D1BCA04;
	Tue,  6 Aug 2024 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943074; cv=none; b=kT2fwEUTJjMBG7G4GGTlSxPb1d3kPWjhzYSkVuNpuGmVvh28WucOwiE5+ijJkIlob3LnNVbSPo/lnkge+3ulRcdTm7VwWMzOzWancksnO4ltXjOqzJzncxn2k2dCm8N067i2FsPUxsfoNRS0yr8oxBIS719g9oU8JBtOsdq+SdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943074; c=relaxed/simple;
	bh=/NA0QSHaLm4VQwkETTIB9yAdEGKXOx+9QzY4eD4/fKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxA8lvwYjIsZPaHD0eYH5Soqqbt+K0w3sZfvfMbOYjGNhKVqCN3G3TgJ6GVVetxF1JVx7h3TLLEZ/SmHYZgzN4NdQeD7ZyXh2tyqbRw/jDP5TJOQWMRP8aNa/sxG7ayuQUNQAeGIVuIyZtE4IF8Vl5oXbu8adQDuIlPqC5110Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65557367;
	Tue,  6 Aug 2024 04:18:17 -0700 (PDT)
Received: from [10.1.31.182] (unknown [10.1.31.182])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED8603F766;
	Tue,  6 Aug 2024 04:17:48 -0700 (PDT)
Message-ID: <74536df6-98c7-43ac-9ae6-8106eea123ec@arm.com>
Date: Tue, 6 Aug 2024 12:17:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/11] mm/huge_memory: convert split_huge_pages_pid()
 from follow_page() to folio_walk
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Mark Brown <broonie@kernel.org>
References: <20240802155524.517137-1-david@redhat.com>
 <20240802155524.517137-8-david@redhat.com>
 <e1d44e36-06e4-4d1c-8daf-315d149ea1b3@arm.com>
 <ac97ccdc-ee1e-4f07-8902-6360de80c2a0@redhat.com>
 <a5f059a0-32d6-453e-9d18-1f3bfec3a762@redhat.com>
 <c75d1c6c-8ea6-424f-853c-1ccda6c77ba2@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <c75d1c6c-8ea6-424f-853c-1ccda6c77ba2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>>> It's trying to split some pmd-mapped THPs then checking and finding that
>>>> they are not split. The split is requested via
>>>> /sys/kernel/debug/split_huge_pages, which I believe ends up in this function
>>>> you are modifying here. Although I'll admit that looking at the change,
>>>> there is nothing obviously wrong! Any ideas?
>>>
>>> Nothing jumps at me as well. Let me fire up the debugger :)
>>
>> Ah, very likely the can_split_folio() check expects a raised refcount
>> already.
> 
> Indeed, the following does the trick! Thanks Ryan, I could have sworn
> I ran that selftest as well.

Ahha! Thanks for sorting so quickly!


