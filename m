Return-Path: <linux-fsdevel+bounces-20994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC8B8FBEF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 00:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0BE285485
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 22:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ACE142634;
	Tue,  4 Jun 2024 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBUQ/LPE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CCB28DC7
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540232; cv=none; b=EUrbw/eyWCpJBNX6BiC5oaEykgGC5NFvVk51WkxgXaj6gENY9wnd6ya5Yx1FDAi4AaPgdvb4FwfcQoPpWHZcE0uT7gLATSKYKzLZVJep0kUX9Hqkh5973wxHDlID2mhtx1rlzHXgX1JOjAXvtN6OT0CUEJjP9y2ssLbbwa/lkkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540232; c=relaxed/simple;
	bh=nTqgpADdVAarXxdcPdXAootOlqEQLAdC15d3/JwqbGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmBt88hwtJauXlMLVrhpLgPoChSFP8TqLWIE1uDCWbgyxXtjTh+KkOHM9p/x/f57cYHfCJooP6nnX/JXJu8u1v1WW7jw75VUF1gvwdW+ApqjOGVhSMXnJjme0b69r8wSx0t27uJWozsR4TpT0R101DBSoyvLJ0TnnZvfofTJ61Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBUQ/LPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AFDC2BBFC;
	Tue,  4 Jun 2024 22:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540231;
	bh=nTqgpADdVAarXxdcPdXAootOlqEQLAdC15d3/JwqbGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JBUQ/LPErOgggnDWG4GYY+VUmoJ4eGyijjMl+XXfUmkxOvXcDEf6uo8131vOlNDkB
	 mtQ1VX2Ay6yR82yNS9uOaOOosoRhlJcSV4lQ8IlL6TKpaJThXt98QMViuJtUyrTrJb
	 YY/3jbkW/l+VyqcfwUrqvZp44HAA/FI+ZZVbYvfrd2zQp5+zEMsEWk+X2kX9llojUo
	 fPEdBnVnd5+m21CqRW41lZUCrACifL7zF6vKEvvN94b+/hGcuPunUSJ9lJ6XejuxwM
	 OUl289xvDrjldcrehdYUft7CoT5E54jsDFzEpz3wJi4j0kYxj4uXDmsJGpT3IXUKx9
	 EUufPSbHeeH2A==
Message-ID: <492e475b-d829-42fe-a0ca-7f32f630a06a@kernel.org>
Date: Wed, 5 Jun 2024 07:30:29 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: move super block reading from page to folio
To: Christoph Hellwig <hch@infradead.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Johannes Thumshirn
 <jth@kernel.org>, linux-fsdevel@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240514152208.26935-1-jth@kernel.org>
 <Zk6e30EMxz_8LbW6@casper.infradead.org>
 <20240531011616.GA52973@frogsfrogsfrogs>
 <5eedc500-5d85-4e41-87b5-61901ca59847@kernel.org>
 <ZltfsUjv9RaVWCtd@casper.infradead.org> <Zl6nKsdp09Yrrpdh@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Zl6nKsdp09Yrrpdh@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/24 14:33, Christoph Hellwig wrote:
> On Sat, Jun 01, 2024 at 06:51:45PM +0100, Matthew Wilcox wrote:
>> On Fri, May 31, 2024 at 10:28:50AM +0900, Damien Le Moal wrote:
>>>>> This will stop working at some point.  It'll return NULL once we get
>>>>> to the memdesc future (because the memdesc will be a slab, not a folio).
>>>>
>>>> Hmmm, xfs_buf.c plays a similar trick here for sub-page buffers.  I'm
>>>> assuming that will get ported to ... whatever the memdesc future holds?
>>
>> I don't think it does, exactly?  Are you referring to kmem_to_page()?
>> That will continue to work.  You're not trying to get a folio from a
>> slab allocation; that will start to fail.
> 
> The point is that we doing block I/O on a slab allocation is heavily
> used, and zonefs does this.  If you dislike going through the folio
> we can just keep using pages in zonefs for now.
> 
> Eventually I'll get around lifting the logic to greedily build a bio
> from arbitrary kernel virtual addresses from various places in XFS
> into common code and we can convert to that.
> 
>> I think you should use read_mapping_folio() for now instead of
>> complicating zonefs.  Once there's a grand new buffer cache, switch to
>> that, but I don't think you're introducing a significant vulnerability
>> by using the block device's page cache.
> 
> Please don't add pointless uses of the bdev page cache for users that
> don't need caching.  This just creates more headaches later on to
> untangle it again.

OK. Will drop this patch then.

-- 
Damien Le Moal
Western Digital Research


