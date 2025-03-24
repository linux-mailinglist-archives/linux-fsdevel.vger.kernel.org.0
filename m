Return-Path: <linux-fsdevel+bounces-44862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 587CDA6D8BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 11:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0480188859A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D3A25DD00;
	Mon, 24 Mar 2025 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="weSd2VmF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8653C10F9;
	Mon, 24 Mar 2025 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813931; cv=none; b=LUsIuuUXv15I7Fwe0YJQBW8aM1n9uPpaWXcKlyBnOE5LVDbUfuAHBBImsSrRXYpmqXZ9JOwJ9RKl8Q+rgrjGp1vfESdjPzTRwpIu7GMwQyeM0HUEjsePaPx21fymakadhpURNgnSpmN6uzXRIKP5Kex9zBbJn2/A7C90CrILFA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813931; c=relaxed/simple;
	bh=4yVXdodDIfdUdrQgYWR7r1IWVSW9cP+OijHo91EXgFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKmKd5WxTSd/QgDIjOSqSGFKiXNqvY0UFAEq/EGapSBMHIScv6ivUu8H4EVQRTnKJdhpfNHo4j4SIX8ywHJ3Wo5ba2aoNktVppcYfExuhKPL9qkoCRBBsC4g52Cevikifi17HR7djV4XZW6nC4IJ90qXiAU0BMYMh15RCT+Nni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=weSd2VmF; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZLqmS1qwtzm0R3r;
	Mon, 24 Mar 2025 10:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1742813925; x=1745405926; bh=qHWnXl7QzKO/pXeMQIokr+0r
	ghD0nnpt18hbCu3fEWw=; b=weSd2VmF2OMTqgTjsbIuZtT/MRyOanBpLKlCYj7Y
	RECtUB+Sy5QO2wOxdv3LKADHEGtWXwKh9BgTTcIdEPWpmq1hnjgaVYglOlMuEiHM
	rglZrP3CiALvb8X6xbDD5JP79/PEJy+FJBe48GnZD1OUviyCzJS/PZ/mM+njGDZN
	wyGOu5/MXIoVAJq6CwUoMhcnSDqKaJikeS6tIDLrSoYyH/LXYvx1voganLX+kicj
	s1HLfdYTI0f/Ad0TTSbExUfHlxa2hYLVK96RxJFZfAezOkLM9777is2jiVjJu0Aj
	leJOwJNiSqlPs8lOTj4CEj2fZ7SgWdv6wBvYk/OjbipFyw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fx8_Kpnf0S6p; Mon, 24 Mar 2025 10:58:45 +0000 (UTC)
Received: from [172.22.32.156] (unknown [99.209.85.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZLqm46VPpzm8kw7;
	Mon, 24 Mar 2025 10:58:27 +0000 (UTC)
Message-ID: <e399689b-c0e9-4499-b200-3d7e110a359f@acm.org>
Date: Mon, 24 Mar 2025 06:58:26 -0400
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
 <c33c1dab-a0f6-4c36-8732-182f640eff52@acm.org>
 <Z9xB4kZiZfSdFJfV@casper.infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Z9xB4kZiZfSdFJfV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 12:27 PM, Matthew Wilcox wrote:
> On Thu, Mar 20, 2025 at 09:15:23AM -0700, Bart Van Assche wrote:
>> The patch description mentions what has been changed but does not
>> mention why. Shouldn't the description of this patch explain why this
>> change has been made? Shouldn't the description of this patch explain
>> for which applications this change is useful?
> 
> The manufacturer chooses the block size.  If they've made a bad decision,
> their device will presumably not sell well.  We don't need to justify
> their decision in the commit message.

 From a 2023 presentation by Luis 
(https://lpc.events/event/17/contributions/1508/attachments/1298/2608/LBS_LPC2023.pdf):
- SSD manufacturers want to increase the indirection unit (IU) size.
- Increasing the IU size reduces SSD DRAM costs.
- LBS is not suitable for all workloads because smaller IOs with LBS can
   cause write amplification (WAF) due to read modify writes.
- Some database software benefits of a 16 KiB logical block size.

If the goal is to reduce DRAM costs then I recommend SSD manufacturers
to implement zoned storage (ZNS) instead of only increasing the logical
block size. A big advantage of zoned storage is that the DRAM cost is
reduced significantly even if the block size is not increased.

Are there any applications that benefit from a block size larger than
64 KiB? If not, why to increase BLK_MAX_BLOCK_SIZE further? Do you agree
that this question should be answered in the patch description?

Thanks,

Bart.

