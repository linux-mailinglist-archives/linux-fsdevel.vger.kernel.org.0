Return-Path: <linux-fsdevel+bounces-20761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEDF8D7955
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 02:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A14B20CCC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 00:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5110F10E6;
	Mon,  3 Jun 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJekQGHw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D75625
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717374632; cv=none; b=giVVIy4LxguDbCeAJlEG2WEskrn7ny7VnOTuo5wqRwbDtocSlC6pthi4ljyyoVtZ3K4R3PlcyEzQa+BYfqGnjNRHlSOAnbnmA2vw/bZ+Og2Q645pRxmgGXDoy1I+cHy7lmvyiHPd98ZOjlBk9H51/t0ZyGAIl4gz51UwN8lm3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717374632; c=relaxed/simple;
	bh=RAggnMUrVO5BBpQOO1v9g/misTf4on1cIogrVX+3rTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WypxtFzathYU0L/eT1s2sYNH4VMUuDNF5A8M0pWDEuh16aZ/oesKoEsbIhDhAE2RnFklwtlig3ZjFxl8HLy6Mo/x98kwfvJJHSARjQo5AyfNwwbXUILZrGAGTWQh+0bCuJSl3GMqgN66sqzoT5grpIw23PX6hMmhVTkLv821/tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJekQGHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9670BC2BBFC;
	Mon,  3 Jun 2024 00:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717374632;
	bh=RAggnMUrVO5BBpQOO1v9g/misTf4on1cIogrVX+3rTs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oJekQGHw8UL+KNpsmNJ+b0dMuiMB7EIaymV5/3JcoLI3b6l7twD9oyPPuEVwc2bGO
	 pYgr3fZN3F2+WXRlxTWxOoLuSklN+89JEHlf59+TA0s31H5CWWdnih4RwuKsQ3/ded
	 hBGu7hacNFQIl5MunjQxuDdQeDbSO6hmiUuBo0Q6CRDwnjImJCDhGPZdf5QWFKSt8/
	 oRkErk6sblrRPPNt42Z15dp6MYtgOhf5oHX4x4U2mgpj0mGVD/7MjzWRbR7OoiMqS1
	 rk+9Ip5Fl5UwMo+ySO1Y0B6DgAGtsHWGHrjtkfU6Odv1BbX/161Pg0L/XnsqLq7KRl
	 YS1SDCqC+OgWg==
Message-ID: <e14e2e96-3d72-4b99-afe0-e44db839e396@kernel.org>
Date: Mon, 3 Jun 2024 09:30:30 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: move super block reading from page to folio
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Johannes Thumshirn
 <jth@kernel.org>, linux-fsdevel@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240514152208.26935-1-jth@kernel.org>
 <Zk6e30EMxz_8LbW6@casper.infradead.org>
 <20240531011616.GA52973@frogsfrogsfrogs>
 <5eedc500-5d85-4e41-87b5-61901ca59847@kernel.org>
 <ZltfsUjv9RaVWCtd@casper.infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZltfsUjv9RaVWCtd@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/24 02:51, Matthew Wilcox wrote:
> On Fri, May 31, 2024 at 10:28:50AM +0900, Damien Le Moal wrote:
>>>> This will stop working at some point.  It'll return NULL once we get
>>>> to the memdesc future (because the memdesc will be a slab, not a folio).
>>>
>>> Hmmm, xfs_buf.c plays a similar trick here for sub-page buffers.  I'm
>>> assuming that will get ported to ... whatever the memdesc future holds?
> 
> I don't think it does, exactly?  Are you referring to kmem_to_page()?
> That will continue to work.  You're not trying to get a folio from a
> slab allocation; that will start to fail.
> 
>>>> I think the right way to handle this is to call read_mapping_folio().
>>>> That will allocate a folio in the page cache for you (obeying the
>>>> minimum folio size).  Then you can examine the contents.  It should
>>>> actually remove code from zonefs.  Don't forget to call folio_put()
>>>> when you're done with it (either at unmount or at the end of mount if
>>>> you copy what you need elsewhere).
>>>
>>> The downside of using bd_mapping is that userspace can scribble all over
>>> the folio contents.  For zonefs that's less of a big deal because it
>>> only reads it once, but for everyone else (e.g. ext4) it's been a huge
>>
>> Yes, and zonefs super block is read-only, we never update it after formatting.
>>
>>> problem.  I guess you could always do max(ZONEFS_SUPER_SIZE,
>>> block_size(sb->s_bdev)) if you don't want to use the pagecache.
>>
>> Good point. ZONEFS_SUPER_SIZE is 4K and given that I only know of 512e and 4K
>> zoned block devices, this is not an issue yet. But better safe than sorry, so
>> doing the max() thing you propose is better. Will patch that.
> 
> I think you should use read_mapping_folio() for now instead of
> complicating zonefs.  Once there's a grand new buffer cache, switch to
> that, but I don't think you're introducing a significant vulnerability
> by using the block device's page cache.

I was not really thinking about vulnerability here, but rather compatibility
with devices having a block size larger than 4K... But given that these are rare
(at best), a fix for a more intelligent ZONEFS_SUPER_SIZE is not urgent, and not
hard at all anyway.

-- 
Damien Le Moal
Western Digital Research


