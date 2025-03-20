Return-Path: <linux-fsdevel+bounces-44616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C1EA6AAE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801C118884DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCFB1EE035;
	Thu, 20 Mar 2025 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XBvEZsDD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139B414B08A;
	Thu, 20 Mar 2025 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487355; cv=none; b=LfTm4HYSCcgcorSS3fzh+uQC2ZIrOYJh17Z3929RNUuQTnFGBqJlvNUjraA7fm3yFlvr8tjQ1tEtSiNx2D/LEZc107OtU4+2/Crr5GcD22TWduoeybqKzwWHfPjxUdk88K/SmrS1ZCFuUrMtlfEBEbCUsAhMYQhY5ttS8OH58X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487355; c=relaxed/simple;
	bh=9miJroh+YHZM76GGNrCOF5bl++n/ajyT+7Aa8UyiS9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tr5rOkpRcmaZlFD4O2jfF/0VNYbzsBr4stjEfdpfsnHaXkc5V1aLLoAOOuvtF+pjSS/6lMvt9DI0QKXMHDakFKIIdCyT9ZbF7kUGGvFh9nQVU+em3R+pKsSAxAqtMQnPzCFx6vGD+ha79eZ/l7goPTI6SjFtCyd0nHOc3sCE0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XBvEZsDD; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZJW024HpYzm8wqx;
	Thu, 20 Mar 2025 16:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1742487343; x=1745079344; bh=sELPgkfZEb31IIOUe5XNcME2
	wtqz+qs2Wg584/tdRWM=; b=XBvEZsDDNuZbS5RCwHuXKX0S6bExwH7l+7a29qor
	sM0IHoLuIFoCihr8B5aUdrDfpl94j2EewnK0aYhoHgaUZkw1LptWTIVpq1eE3gk6
	TOaYCTAHDTmDumPZl/ZflXio2he7B6+j1xf2mQbJWZI/KVUWTLLDUfiaxgjA0yYU
	ES2UdDk6FftKkwk0tAnUXgmKeQNAQkRjQA8s+/EmnCOoh2TnaUZ70fxEfSeNpybB
	lM8xaJ5vtFouOSpe7ARtm2+wGL/OKTli9+0fMBMx+FZuqLHqkh45E0IXew2Tau0K
	3RQLcU/ozvE9IaY7Hk99z63NYMN1wL0tKAlmSbfLB6Nk8A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id t7sURusNiND5; Thu, 20 Mar 2025 16:15:43 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZJVzd1kXCzm8kvX;
	Thu, 20 Mar 2025 16:15:24 +0000 (UTC)
Message-ID: <c33c1dab-a0f6-4c36-8732-182f640eff52@acm.org>
Date: Thu, 20 Mar 2025 09:15:23 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/4] blkdev: lift BLK_MAX_BLOCK_SIZE to page cache limit
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, leon@kernel.org, hch@lst.de,
 kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, joro@8bytes.org,
 brauner@kernel.org, hare@suse.de, david@fromorbit.com, djwong@kernel.org,
 john.g.garry@oracle.com, ritesh.list@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
 da.gomez@samsung.com, kernel@pankajraghav.com
References: <20250320111328.2841690-1-mcgrof@kernel.org>
 <20250320111328.2841690-3-mcgrof@kernel.org>
 <5459e3e0-656c-4d94-82c7-3880608f9ac8@acm.org>
 <Z9w9FWG2hKCe7mhR@casper.infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Z9w9FWG2hKCe7mhR@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 9:06 AM, Matthew Wilcox wrote:
> On Thu, Mar 20, 2025 at 09:01:46AM -0700, Bart Van Assche wrote:
>> On 3/20/25 4:13 AM, Luis Chamberlain wrote:
>>> -/*
>>> - * We should strive for 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER)
>>> - * however we constrain this to what we can validate and test.
>>> - */
>>> -#define BLK_MAX_BLOCK_SIZE      SZ_64K
>>> +#define BLK_MAX_BLOCK_SIZE      1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER)
>>>    /* blk_validate_limits() validates bsize, so drivers don't usually need to */
>>>    static inline int blk_validate_block_size(unsigned long bsize)
>>
>> All logical block sizes above 4 KiB trigger write amplification if there
>> are applications that write 4 KiB at a time, isn't it? Isn't that issue
>> even worse for logical block sizes above 64 KiB?
> 
> I think everybody knows this Bart.  You've raised it before, we've
> talked about it, and you're not bringing anything new to the discussion
> this time.  Why bring it up again?

The patch description mentions what has been changed but does not
mention why. Shouldn't the description of this patch explain why this
change has been made? Shouldn't the description of this patch explain
for which applications this change is useful?

Thanks,

Bart.

