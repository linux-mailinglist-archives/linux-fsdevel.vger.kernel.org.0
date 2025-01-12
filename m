Return-Path: <linux-fsdevel+bounces-38980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C362A0A805
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 10:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161E53A747F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379A1197A8F;
	Sun, 12 Jan 2025 09:38:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B03A1898F2
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736674736; cv=none; b=BnY15+5azyG1av4gvfDRqzGxKUvTodwPe0DlFlvlPL3h1DY6NoFr7jt5DwE1zxSUF4u7hVyd4mdNywrUUS1ZRXg18BvxrAfDooN/dE73WuHmJ5+X/iivKSQTX3smgnev5N5c733urtEwxZa/RemHZ7VGnt2a1v2RoKGO9xV2P8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736674736; c=relaxed/simple;
	bh=h4pkRBdBFZkE7vC2dwdk5c5UI5N5/4yfwbYzG11G7H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWRpBYSS+pAwPXCupB8t0HIp/fY8xuh+VADEtCTy7hqcToPSMqdnXXKQIQ9+FpJ7kAX+g0PA03a/zkc7xyM96mwlSYxy0Bc01Okjvyrtb2y9MsWZmAJf0Ei8hJimztwEEWbK1hU9tcC6Me1mbyZNS6lekpscShE4gjuZ2nM5kDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CBD6106F;
	Sun, 12 Jan 2025 01:39:21 -0800 (PST)
Received: from [10.57.94.123] (unknown [10.57.94.123])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 723793F673;
	Sun, 12 Jan 2025 01:38:52 -0800 (PST)
Message-ID: <417ba32c-6e34-44d1-98ef-caa75bbb4e32@arm.com>
Date: Sun, 12 Jan 2025 09:38:50 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] squashfs: Fix "convert squashfs_fill_page() to take a
 folio"
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
 squashfs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
References: <20250110163300.3346321-1-willy@infradead.org>
 <20250110163300.3346321-2-willy@infradead.org>
 <b9ce358d-4f67-48be-94b3-b65a17ef56f9@arm.com>
 <Z4KxSBcKpwwr-WF2@casper.infradead.org>
 <20250111175641.5bbfdc297e85c7a6ef185327@linux-foundation.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250111175641.5bbfdc297e85c7a6ef185327@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/01/2025 01:56, Andrew Morton wrote:
> On Sat, 11 Jan 2025 17:58:32 +0000 Matthew Wilcox <willy@infradead.org> wrote:
> 
>> On Sat, Jan 11, 2025 at 01:21:31PM +0000, Ryan Roberts wrote:
>>> On 10/01/2025 16:32, Matthew Wilcox (Oracle) wrote:
>>>> I got the polarity of "uptodate" wrong.  Rename it.  Thanks to
>>>> Ryan for testing; please fold into above named patch, and he'd like
>>>> you to add
>>>>
>>>> Tested-by: Ryan Roberts <ryan.roberts@arm.com>
>>>
>>> This is missing the change to folio_end_read() and the change for IS_ERR() that
>>> was in the version of the patch I tested. Just checking that those were handled
>>> separately in a thread I'm not CCed on?
>>
>> https://lore.kernel.org/mm-commits/20250109043130.F38E0C4CED2@smtp.kernel.org/
> 
> I have this as a fix against a different patch: "squashfs: convert
> squashfs_copy_cache() to take a folio"
> 
>> https://lore.kernel.org/mm-commits/20250110232601.CBE47C4CED6@smtp.kernel.org/
> 
> I queued this separately as a hotfix, without cc:stable.  I guess it
> didn't really need that urgency, but wrong code is wrong.
> 
>> Shouldn't be anything missing; I applied the first one to my tree,
>> then wrote the second one and the third one you're replying to.  Then
>> I did a git diff HEAD~3 and sent the result to you to test.
>>
>> Has anything gone wrong in this process?
> 
> I don't think so.

Agreed - thanks!

