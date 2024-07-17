Return-Path: <linux-fsdevel+bounces-23837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBB8933F95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7E81F212E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAE7181BA8;
	Wed, 17 Jul 2024 15:26:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABEA381DE;
	Wed, 17 Jul 2024 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229983; cv=none; b=btc9P/ihob0zOPeV33gLiF0Kjx35GbsmukDIzfIyIZRqY5M+7rNiWIuwXPe7v6fFzDrbpPkmyRrJHJIARGWKG3dBs8G1LqITOa4/Y4ZL7FYbyIRg9aR15V/dg4pl5AAC8lh5AbgtnJi0bCkx9szkI7tJFvFBhuTYMTYkZ9wrG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229983; c=relaxed/simple;
	bh=IOcRkh89Ks8cunm4tMzKBSVeuDt4oSZNweCxq2oSKBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZoNHfbSYeeAuR7sbLCOcY9vGwgHlT1enUxQ38qzYHjZcTRORzFnHCqZlzgDg3Po4JYiyVdxIB0Ed2lEMyMZI6KiUfDqJ8qpkjcvTlUd5tKMIvGsPljDu16IgnNlY0XPjzRGq6jAyqSBjL39YH3CUt0NUNjUMNub5V9CfYZii2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA402106F;
	Wed, 17 Jul 2024 08:26:44 -0700 (PDT)
Received: from [10.57.77.222] (unknown [10.57.77.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9ABCE3F766;
	Wed, 17 Jul 2024 08:26:16 -0700 (PDT)
Message-ID: <bf9ffac5-11ff-4a1a-b31a-b9940558fe2c@arm.com>
Date: Wed, 17 Jul 2024 16:26:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/10] fs: Allow fine-grained control of folio sizes
Content-Language: en-GB
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Matthew Wilcox <willy@infradead.org>, david@fromorbit.com,
 chandan.babu@oracle.com, djwong@kernel.org, brauner@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 yang@os.amperecomputing.com, linux-mm@kvack.org, john.g.garry@oracle.com,
 linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
 mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
 linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <ziy@nvidia.com>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
 <20240715094457.452836-2-kernel@pankajraghav.com>
 <ZpaRElX0HyikQ1ER@casper.infradead.org>
 <20240717094621.fdobfk7coyirg5e5@quentin>
 <61806152-3450-4a4f-b81f-acc6c6aeed29@arm.com>
 <20240717151251.x7vkwajb57pefs6m@quentin>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240717151251.x7vkwajb57pefs6m@quentin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/07/2024 16:12, Pankaj Raghav (Samsung) wrote:
>>>>
>>>> This is really too much.  It's something that will never happen.  Just
>>>> delete the message.
>>>>
>>>>> +	if (max > MAX_PAGECACHE_ORDER) {
>>>>> +		VM_WARN_ONCE(1,
>>>>> +	"max order > MAX_PAGECACHE_ORDER. Setting max_order to MAX_PAGECACHE_ORDER");
>>>>> +		max = MAX_PAGECACHE_ORDER;
>>>>
>>>> Absolutely not.  If the filesystem declares it can support a block size
>>>> of 4TB, then good for it.  We just silently clamp it.
>>>
>>> Hmm, but you raised the point about clamping in the previous patches[1]
>>> after Ryan pointed out that we should not silently clamp the order.
>>>
>>> ```
>>>> It seems strange to silently clamp these? Presumably for the bs>ps usecase,
>>>> whatever values are passed in are a hard requirement? So wouldn't want them to
>>>> be silently reduced. (Especially given the recent change to reduce the size of
>>>> MAX_PAGECACHE_ORDER to less then PMD size in some cases).
>>>
>>> Hm, yes.  We should probably make this return an errno.  Including
>>> returning an errno for !IS_ENABLED() and min > 0.
>>> ```
>>>
>>> It was not clear from the conversation in the previous patches that we
>>> decided to just clamp the order (like it was done before).
>>>
>>> So let's just stick with how it was done before where we clamp the
>>> values if min and max > MAX_PAGECACHE_ORDER?
>>>
>>> [1] https://lore.kernel.org/linux-fsdevel/Zoa9rQbEUam467-q@casper.infradead.org/
>>
>> The way I see it, there are 2 approaches we could take:
>>
>> 1. Implement mapping_max_folio_size_supported(), write a headerdoc for
>> mapping_set_folio_order_range() that says min must be lte max, max must be lte
>> mapping_max_folio_size_supported(). Then emit VM_WARN() in
>> mapping_set_folio_order_range() if the constraints are violated, and clamp to
>> make it safe (from page cache's perspective). The VM_WARN()s can just be inline
> 
> Inlining with the `if` is not possible since:
> 91241681c62a ("include/linux/mmdebug.h: make VM_WARN* non-rvals")

Ahh my bad. Could use WARN_ON()?

> 
>> in the if statements to keep them clean. The FS is responsible for checking
>> mapping_max_folio_size_supported() and ensuring min and max meet requirements.
> 
> This is sort of what is done here but IIUC willy's reply to the patch,
> he prefers silent clamping over having WARNINGS. I think because we check
> the constraints during the mount time, so it should be safe to call
> this I guess?

I don't want to put words in his mouth, but I thought he was complaining about
the verbosity of the warnings, not their presence.

> 
>>
>> 2. Return an error from mapping_set_folio_order_range() (and the other functions
>> that set min/max). No need for warning. No state changed if error is returned.
>> FS can emit warning on error if it wants.
> 
> I think Chinner was not happy with this approach because this is done
> per inode and basically we would just shutdown the filesystem in the
> first inode allocation instead of refusing the mount as we know about
> the MAX_PAGECACHE_ORDER even during the mount phase anyway.

Ahh that makes sense. Understood.

> 
> --
> Pankaj


