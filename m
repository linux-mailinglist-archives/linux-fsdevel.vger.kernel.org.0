Return-Path: <linux-fsdevel+bounces-47907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AF5AA6FD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 12:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89ED93B4963
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA6D241CB0;
	Fri,  2 May 2025 10:34:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9219524168D;
	Fri,  2 May 2025 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182052; cv=none; b=PjLeHu28JEvwXE/OFmvTBayjLgylvEJBfzk6rXLteip9I9gmPC9oGZpAO+asKgs9lUYAFl1DHs9qlhRm0J/3TAyqBBpta1Fjjt3pTff+jPv3YyS2a7RilriIKOy7pUOF8/zYTAzxBbjpvz2BQsCNuKZzuwpokF2AVI4g6B0sYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182052; c=relaxed/simple;
	bh=JIAnjzkbPg5UsFHHkqMsK7bzwm1mdjJllyX7ftMuJGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DT52W2usKrv6IrYsw8mjVOJSE5CHhzovxQ0q7sFgRlI2325qjranTXp8VsOVpEv+v0iARzRd4srYLkmnTiDnpzt2E9R1qDPDEl61VAbO1qgi4TdgGxkqddAfUy21+J492hI4EZsFvkPWOANM3xMxkXaxkPvStkmKtCrcKggQH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E94A106F;
	Fri,  2 May 2025 03:34:00 -0700 (PDT)
Received: from [10.57.93.118] (unknown [10.57.93.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB4533F66E;
	Fri,  2 May 2025 03:34:05 -0700 (PDT)
Message-ID: <e9724525-21e2-4c38-a5da-0e45a84a4b58@arm.com>
Date: Fri, 2 May 2025 11:34:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binfmt_elf: Move brk for static PIE even if ASLR disabled
Content-Language: en-GB
To: Kees Cook <kees@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Ali Saidi <alisaidi@amazon.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250425224502.work.520-kees@kernel.org>
 <ad6b492c-cf5e-42ec-b772-52e74238483b@arm.com>
 <202504301207.BCE7A96@keescook>
 <a6696d0f-3c5a-46a8-8d38-321292dac83d@arm.com>
 <202505011633.82A962A7@keescook>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <202505011633.82A962A7@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/05/2025 00:49, Kees Cook wrote:
> On Thu, May 01, 2025 at 12:03:32PM +0100, Ryan Roberts wrote:
>> I agree, as long as COMPAT_BRK is not set (which is the common case IFAICT).
>> When COMPAT_BRK is enabled, I think you are breaking the purpose of that
>> Kconfig? Perhaps it's not a real-world problem though...
> 
> When you turned off ASLR, what mechanism did you use? Personality or
> randomize_va_space=0?

randomize_va_space=0

> 
>>> It's possible it could break running the loader directly against some
>>> libc5-based binaries. If this turns out to be a real-world issue, we can
>>> find a better solution (perhaps pre-allocating a large brk).
>>
>> But how large is large enough...
> 
> Right -- Chrome has a 500MB brk on my laptop. :P Or with randomization
> off, it could allocate to the top of the mmap space just to keep
> "future" mmap allocations from landing in any holes...
> 
>> Perhaps it is safer to only move the brk if !IS_ENABLED(CONFIG_COMPAT_BRK) ?
>> Then wait to see if there are any real-world COMPAT_BRK users that hit the issue?
> 
> Yeah, that might be the best middle-ground.
> 


