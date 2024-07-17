Return-Path: <linux-fsdevel+bounces-23810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BD0933A85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 11:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E0ADB21F6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 09:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458C417E906;
	Wed, 17 Jul 2024 09:59:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF2719A;
	Wed, 17 Jul 2024 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210376; cv=none; b=GvP1hGsF/uz87FCm4Suu+4Q0bm4R+aYwwpHgXwzZUI3OufRT/DKWUVq+NcxtJtJ8i2Kll1Bo4CEtDNrDP8uN7tI7LaGpKD7JJk01t+FxPjCQbVHuu50HdUd7VHSqe2+cT23jTnRXt7k8vbIHznexPY+XeOKfsyVqfrifoj24RSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210376; c=relaxed/simple;
	bh=OMc0681OodzRyuBATwyzchVTnV9Bh1GaBTsOg5XlF1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTxvFFnFgM77dScHbmukQvkouIk56kPDJW9GbbF2iMkQ9WROlFqWJ+IOfyvxHx0OC60XPncqkMCuSfnVrvvEWKI6ZbabsiS3uSFV8g+fFg5Am+unb8SdMIutsa4oFKG6df7nDcNdPp0RJFVFxvCzfL8LnPjOSxOfSMRzX/pdV3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4301C1063;
	Wed, 17 Jul 2024 02:59:59 -0700 (PDT)
Received: from [10.57.77.222] (unknown [10.57.77.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D19213F73F;
	Wed, 17 Jul 2024 02:59:29 -0700 (PDT)
Message-ID: <61806152-3450-4a4f-b81f-acc6c6aeed29@arm.com>
Date: Wed, 17 Jul 2024 10:59:27 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/10] fs: Allow fine-grained control of folio sizes
Content-Language: en-GB
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: david@fromorbit.com, chandan.babu@oracle.com, djwong@kernel.org,
 brauner@kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 yang@os.amperecomputing.com, linux-mm@kvack.org, john.g.garry@oracle.com,
 linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
 mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
 linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <ziy@nvidia.com>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
 <20240715094457.452836-2-kernel@pankajraghav.com>
 <ZpaRElX0HyikQ1ER@casper.infradead.org>
 <20240717094621.fdobfk7coyirg5e5@quentin>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240717094621.fdobfk7coyirg5e5@quentin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/07/2024 10:46, Pankaj Raghav (Samsung) wrote:
> On Tue, Jul 16, 2024 at 04:26:10PM +0100, Matthew Wilcox wrote:
>> On Mon, Jul 15, 2024 at 11:44:48AM +0200, Pankaj Raghav (Samsung) wrote:
>>> +/*
>>> + * mapping_max_folio_size_supported() - Check the max folio size supported
>>> + *
>>> + * The filesystem should call this function at mount time if there is a
>>> + * requirement on the folio mapping size in the page cache.
>>> + */
>>> +static inline size_t mapping_max_folio_size_supported(void)
>>> +{
>>> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>>> +		return 1U << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
>>> +	return PAGE_SIZE;
>>> +}
>>
>> There's no need for this to be part of this patch.  I've removed stuff
>> from this patch before that's not needed, please stop adding unnecessary
>> functions.  This would logically be part of patch 10.
> 
> That makes sense. I will move it to the last patch.
> 
>>
>>> +static inline void mapping_set_folio_order_range(struct address_space *mapping,
>>> +						 unsigned int min,
>>> +						 unsigned int max)
>>> +{
>>> +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>>> +		return;
>>> +
>>> +	if (min > MAX_PAGECACHE_ORDER) {
>>> +		VM_WARN_ONCE(1,
>>> +	"min order > MAX_PAGECACHE_ORDER. Setting min_order to MAX_PAGECACHE_ORDER");
>>> +		min = MAX_PAGECACHE_ORDER;
>>> +	}
>>
>> This is really too much.  It's something that will never happen.  Just
>> delete the message.
>>
>>> +	if (max > MAX_PAGECACHE_ORDER) {
>>> +		VM_WARN_ONCE(1,
>>> +	"max order > MAX_PAGECACHE_ORDER. Setting max_order to MAX_PAGECACHE_ORDER");
>>> +		max = MAX_PAGECACHE_ORDER;
>>
>> Absolutely not.  If the filesystem declares it can support a block size
>> of 4TB, then good for it.  We just silently clamp it.
> 
> Hmm, but you raised the point about clamping in the previous patches[1]
> after Ryan pointed out that we should not silently clamp the order.
> 
> ```
>> It seems strange to silently clamp these? Presumably for the bs>ps usecase,
>> whatever values are passed in are a hard requirement? So wouldn't want them to
>> be silently reduced. (Especially given the recent change to reduce the size of
>> MAX_PAGECACHE_ORDER to less then PMD size in some cases).
> 
> Hm, yes.  We should probably make this return an errno.  Including
> returning an errno for !IS_ENABLED() and min > 0.
> ```
> 
> It was not clear from the conversation in the previous patches that we
> decided to just clamp the order (like it was done before).
> 
> So let's just stick with how it was done before where we clamp the
> values if min and max > MAX_PAGECACHE_ORDER?
> 
> [1] https://lore.kernel.org/linux-fsdevel/Zoa9rQbEUam467-q@casper.infradead.org/

The way I see it, there are 2 approaches we could take:

1. Implement mapping_max_folio_size_supported(), write a headerdoc for
mapping_set_folio_order_range() that says min must be lte max, max must be lte
mapping_max_folio_size_supported(). Then emit VM_WARN() in
mapping_set_folio_order_range() if the constraints are violated, and clamp to
make it safe (from page cache's perspective). The VM_WARN()s can just be inline
in the if statements to keep them clean. The FS is responsible for checking
mapping_max_folio_size_supported() and ensuring min and max meet requirements.

2. Return an error from mapping_set_folio_order_range() (and the other functions
that set min/max). No need for warning. No state changed if error is returned.
FS can emit warning on error if it wants.

Personally I prefer option 2, but 1 is definitely less churn.

Thanks,
Ryan


