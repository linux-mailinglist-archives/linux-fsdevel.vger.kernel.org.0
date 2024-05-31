Return-Path: <linux-fsdevel+bounces-20596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0498D57C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 03:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40C61F24AD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 01:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569B3848D;
	Fri, 31 May 2024 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmggfaMs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3086139
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717118932; cv=none; b=SHXA394zURCTid8P/VcLYvw9T8a//YsEe9RxS/XmmK0Hb1L/LgUpysVmzNF+zpzPv7iJBUh+bbu+3oAl4If/EDFwT2KZf6oETDdp8MDpq2KeiqV8BBd2S6OVLDazxlStPW5t0PMaEDIsgpP3Htli0tFFBpUGm9Cs+olAKAnK6TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717118932; c=relaxed/simple;
	bh=VVvG8C8Z4fqJ2NKOQ7AfKk4ayzpVa/wlTVATHOfu0FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+rkwSllwE+jwBEiiDH36dB0vHf6G8TJ27LtTIoND2dWswUyHjcJNsabQTuZpHX/AmDOBhc0rRFqL32WTBEaN5UHs3VYMJjQqltGXkWV1PdtRPwXj3ZJ1vYnZ6SovTYG8m3wBa7WJPq08ZNpCmaBHUlRHwv+rZst827+mQNjuIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmggfaMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B34C2BBFC;
	Fri, 31 May 2024 01:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717118932;
	bh=VVvG8C8Z4fqJ2NKOQ7AfKk4ayzpVa/wlTVATHOfu0FM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MmggfaMsCqLLQNOyXJ60R9FnzIh9Xmsdlw/5hs0sKP7ewEZu936/GExMdAR8r0HoC
	 rnefND8FOc19QYv1etADCtanhapV0+d7ei+965K516RwDVIW6DvxAddiZ1tFmMEKO9
	 9bU+z6X8LtYZRKkP/53aiDA0Su2LiTjHZwjnqeTtbOX+F+QY8ceLdktuA+J4DcvXNU
	 rpkmlydSD5euKU3PW+sjR7Zop8gPNRzfy1zwCNHZG8n06gtMHkH60dZ0ucttZSPh7F
	 yYPx4gF2T4wSG0PrQANto8lZ0z7Chg10iGwx5QTlUM5a4DyCELdpzA9chj39joTetG
	 IDbupB6WiF3sg==
Message-ID: <5eedc500-5d85-4e41-87b5-61901ca59847@kernel.org>
Date: Fri, 31 May 2024 10:28:50 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: move super block reading from page to folio
To: "Darrick J. Wong" <djwong@kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: Johannes Thumshirn <jth@kernel.org>, linux-fsdevel@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240514152208.26935-1-jth@kernel.org>
 <Zk6e30EMxz_8LbW6@casper.infradead.org>
 <20240531011616.GA52973@frogsfrogsfrogs>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240531011616.GA52973@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 10:16 AM, Darrick J. Wong wrote:
> On Thu, May 23, 2024 at 02:41:51AM +0100, Matthew Wilcox wrote:
>> On Tue, May 14, 2024 at 05:22:08PM +0200, Johannes Thumshirn wrote:
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> Move reading of the on-disk superblock from page to kmalloc()ed memory.
>>
>> No, this is wrong.
>>
>>> +	super = kzalloc(ZONEFS_SUPER_SIZE, GFP_KERNEL);
>>> +	if (!super)
>>>  		return -ENOMEM;
>>>  
>>> +	folio = virt_to_folio(super);
>>
>> This will stop working at some point.  It'll return NULL once we get
>> to the memdesc future (because the memdesc will be a slab, not a folio).
> 
> Hmmm, xfs_buf.c plays a similar trick here for sub-page buffers.  I'm
> assuming that will get ported to ... whatever the memdesc future holds?
> 
>>>  	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
>>>  	bio.bi_iter.bi_sector = 0;
>>> -	__bio_add_page(&bio, page, PAGE_SIZE, 0);
>>> +	bio_add_folio_nofail(&bio, folio, ZONEFS_SUPER_SIZE,
>>> +			     offset_in_folio(folio, super));
>>
>> It also doesn't solve the problem of trying to read 4KiB from a device
>> with 16KiB sectors.  We'll have to fail the bio because there isn't
>> enough memory in the bio to store one block.
>>
>> I think the right way to handle this is to call read_mapping_folio().
>> That will allocate a folio in the page cache for you (obeying the
>> minimum folio size).  Then you can examine the contents.  It should
>> actually remove code from zonefs.  Don't forget to call folio_put()
>> when you're done with it (either at unmount or at the end of mount if
>> you copy what you need elsewhere).
> 
> The downside of using bd_mapping is that userspace can scribble all over
> the folio contents.  For zonefs that's less of a big deal because it
> only reads it once, but for everyone else (e.g. ext4) it's been a huge

Yes, and zonefs super block is read-only, we never update it after formatting.

> problem.  I guess you could always do max(ZONEFS_SUPER_SIZE,
> block_size(sb->s_bdev)) if you don't want to use the pagecache.

Good point. ZONEFS_SUPER_SIZE is 4K and given that I only know of 512e and 4K
zoned block devices, this is not an issue yet. But better safe than sorry, so
doing the max() thing you propose is better. Will patch that.

-- 
Damien Le Moal
Western Digital Research


