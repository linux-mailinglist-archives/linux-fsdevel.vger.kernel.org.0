Return-Path: <linux-fsdevel+bounces-29428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3652B9799FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 04:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16BD1F2201F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 02:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8F81798F;
	Mon, 16 Sep 2024 02:54:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61EA12E71;
	Mon, 16 Sep 2024 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726455273; cv=none; b=cgT+on6wiEsbvmgsqryeF8GXarCWICaiLWLlqdAs297zGvZgHlJJ9FxbzTNDqsy+ghXsVFwD/KkhCK2F37IX2IU+e3FnY+WEZaV5JJl1VDw/xEPaoKhi/cR4MlcAXVqY9fXutiRXt721j45VzIAPVDFQ4B6mQGHzVXBAno34uS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726455273; c=relaxed/simple;
	bh=4SY9/3+US2zm+crDDfzr5lKhaNSjQwLU5DcGcU1LpiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFPXl3/ZhYPLtIeVK6FRS+0QjFB4jwUZ4X0+nUyvejZtoCfYVP6CoblrJ1X1kbwpdBZJmKPBshhVHvuHUuVUoevps0cK2EgkO0z+VD8B+G819Rh6YpJtRmYr0BeqmMYEwUeZCftRm0WwuVm4QFyUPawJwQd+9A3stWrV7Bm2d9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85C611476;
	Sun, 15 Sep 2024 19:54:54 -0700 (PDT)
Received: from [10.162.16.84] (a077893.blr.arm.com [10.162.16.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DAB73F64C;
	Sun, 15 Sep 2024 19:54:20 -0700 (PDT)
Message-ID: <9d3286bd-7ad4-4472-aa26-2fb7d166fceb@arm.com>
Date: Mon, 16 Sep 2024 08:24:17 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] x86/mm: Drop page table entry address output from
 pxd_ERROR()
To: Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-fsdevel@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
References: <20240913084433.1016256-1-anshuman.khandual@arm.com>
 <20240913084433.1016256-3-anshuman.khandual@arm.com>
 <8e8a94d4-39fe-4c34-9f5d-5b347ca8fe9a@intel.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <8e8a94d4-39fe-4c34-9f5d-5b347ca8fe9a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/13/24 22:51, Dave Hansen wrote:
> On 9/13/24 01:44, Anshuman Khandual wrote:
>> This drops page table entry address output from all pxd_ERROR() definitions
>> which now matches with other architectures. This also prevents build issues
>> while transitioning into pxdp_get() based page table entry accesses.
> 
> Could you be a _little_ more specific than "build issues"?  Is it that
> you want to do:
> 
>  void pmd_clear_bad(pmd_t *pmd)
>  {
> -        pmd_ERROR(*pmd);
> +        pmd_ERROR(pmdp_get(pmd));
>          pmd_clear(pmd);
>  }
> 
> But the pmd_ERROR() macro would expand that to:
> 
> 	&pmdp_get(pmd)
> 
> which is nonsense?

Yes, that's the one which fails the build with the following warning.

error: lvalue required as unary '&' operand

Will update the commit message with these details about the build problem.

> 
> Having the PTEs' kernel addresses _is_ handy, but I guess they're
> scrambled on most end users' systems now and anybody that's actively
> debugging can just use a kprobe or something to dump the pmd_clear_bad()
> argument directly.

Right.

