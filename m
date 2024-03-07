Return-Path: <linux-fsdevel+bounces-13922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288178757DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 21:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2571C2186B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 20:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A51384A3;
	Thu,  7 Mar 2024 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0zkhqM1U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1124A137C30;
	Thu,  7 Mar 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841855; cv=none; b=XMXX64AaHB8IhzwSiiBB1smFg1dNTvG7OnbD3vn3lY8+dB4tjclk2WZ1bzFhAiO8DA8JyR+jFb/FYiYqcucJvfgm8Tt8dp0Ml4g+XjubAaQbibpxtPh9V3rqN03rUM9RveHC/bvy8LReaO/7/zz+D45CMvnGq00TPMjQxfvExyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841855; c=relaxed/simple;
	bh=vmRA2zcTbEgN+gj7Iuf2t5fF5GJ0XZBhzsF7y/RhPJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcKk0gKrBFktdiT7flm0sZ1e8sILoYABkfzK8qyM5oPjVjaRK4oShQluHCeyv63qpjSSn74PIE7AKYexJ54kvHsjxgDFLb72JDxxnWLHJumoddWsEAgKPRfBzGGXxPIwPhjq2BHhVn/ytWrbQA9vWIsf0u35iXnwUyDVSCqWZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0zkhqM1U; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=SaP0wPXWBZG8b4HRDLlDNgk7gu+I9jcLT+KulgNLYzI=; b=0zkhqM1U6lVsrsNgtBsY5dv5rV
	5XFxT2KzYbBohyMSuNEnlsTGejAHaJ2Y8Q5EIo8a1wmbaRR0LftydJAduTmr2VDL8PrMmdfKywY34
	8m1RdoJUV/YH1zIcV+oQmCIlX75qb5v+Opa6Bt18zBVclIzpeY1VGlCP6klouMKDPt+szWBj200Ld
	DQMR2+GGfFPE1qqgWcW752+i3BXsIMjRqdnA9UAVZaG0a5RfV6HXnymi7FNNauMDAFUgCWzDBRV+7
	1QPdn9xnz4uNv6GI4ouUzmO/HM/OpkYYY9UfN7oh3ZddPqZnujSncFTGSGKkCku8AAHci6MpRYJwn
	KFcmoSgQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riJy9-00000006C66-0IYm;
	Thu, 07 Mar 2024 20:03:57 +0000
Message-ID: <f12e83ef-5881-4df8-87ae-86f8ca5a6ab4@infradead.org>
Date: Thu, 7 Mar 2024 12:03:54 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 37/37] memprofiling: Documentation
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org,
 muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
 pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
 dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
 keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
 gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com, elver@google.com, dvyukov@google.com,
 shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
 aliceryhl@google.com, rientjes@google.com, minchan@google.com,
 kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <20240306182440.2003814-1-surenb@google.com>
 <20240306182440.2003814-38-surenb@google.com>
 <10a95079-86e4-41bf-8e82-e387936c437d@infradead.org>
 <hsyclfp3ketwzkebjjrucpb56gmalixdgl6uld3oym3rvssyar@fmjlbpdkrczv>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <hsyclfp3ketwzkebjjrucpb56gmalixdgl6uld3oym3rvssyar@fmjlbpdkrczv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/24 10:17, Kent Overstreet wrote:
> On Wed, Mar 06, 2024 at 07:18:57PM -0800, Randy Dunlap wrote:
>> Hi,
>> This includes some editing suggestions and some doc build fixes.
>>
>>

[snip]

>>> +===================
>>> +Theory of operation
>>> +===================
>>> +
>>> +Memory allocation profiling builds off of code tagging, which is a library for
>>> +declaring static structs (that typcially describe a file and line number in
>>
>>                                   typically
>>
>>> +some way, hence code tagging) and then finding and operating on them at runtime
>>
>>                                                                         at runtime,
>>
>>> +- i.e. iterating over them to print them in debugfs/procfs.
>>
>>   i.e., iterating
> 
> i.e. latin id est, that is: grammatically my version is fine
> 

Some of my web search hits say that a comma is required after "i.e.".
At least one of them says that it is optional.
And one says that it is not required in British English.

But writing it with "that is":


hence code tagging) and then finding and operating on them at runtime
- that is iterating over them to print them in debugfs/procfs.

is not good IMO. But it's your document.


-- 
#Randy

