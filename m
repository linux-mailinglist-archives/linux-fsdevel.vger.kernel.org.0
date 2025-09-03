Return-Path: <linux-fsdevel+bounces-60219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2AFB42CFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 00:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E372189FB40
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 22:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AA72ECD39;
	Wed,  3 Sep 2025 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tj6yAb73"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450FD266B56;
	Wed,  3 Sep 2025 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756939847; cv=none; b=jD2F108eRENNEtV9aEu5R7nbrWE2kBLgEF1cR/8b/LpC2jMaKr/09uOUxwm9VR8cJLZIK1pqfn4SgoAT4n3SpDhUUjfugHSqy3JHSuCUHTlcE4gkmCgY0spD2Aw6JI8gB/m3i/v19KyRogKXj/SRMwAoBPl0vXQi370dhZ237cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756939847; c=relaxed/simple;
	bh=pbdquukSnGS+wF5QF8MilgjIYNJenjTo1pFIRO4nz7w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sG+c5Qk+QzOBRBtd4LjWGyj0hf2VYh3ROGSF0GNZvbsP3N6jRAFlMrpbQvyQQdvkfj3qxt4aBDrNzSi7APPPpUWKXHV0vzFSDBfRHR54sQ6eTGGUrYM6MmisUYpF93PvJIUpeat2vkfwzqgD0w/P4FKfKyevneZjj7Tmrk7ULio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tj6yAb73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBCFC4CEE7;
	Wed,  3 Sep 2025 22:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756939846;
	bh=pbdquukSnGS+wF5QF8MilgjIYNJenjTo1pFIRO4nz7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tj6yAb73B0+cXYAia7kJ0XU6KHNEqIRkke4BZtr7R8O3us7SWoXS68AcMqQ5L0hpG
	 BmXM1jzeqpYF1icn0sEmvoQNczqPpgLGcyzhDPUPeLtnMlScyq5/FqV42gRzdDgUrV
	 ENGoguY3Pv2qLi4Nn8AB7DOzFJn1HN7+BvDWtq7o=
Date: Wed, 3 Sep 2025 15:50:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Youling Tang <youling.tang@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, chizhiling@163.com, Youling Tang
 <tangyouling@kylinos.cn>, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] mm/filemap: Align last_index to folio size
Message-Id: <20250903155046.bd82ae87ab9d30fe32ace2a6@linux-foundation.org>
In-Reply-To: <afff8170-eed3-4c5c-8cc7-1595ccd32052@linux.dev>
References: <20250711055509.91587-1-youling.tang@linux.dev>
	<jk3sbqrkfmtvrzgant74jfm2n3yn6hzd7tefjhjys42yt2trnp@avx5stdnkfsc>
	<afff8170-eed3-4c5c-8cc7-1595ccd32052@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 17:08:53 +0800 Youling Tang <youling.tang@linux.dev> wrote:

> Hi, Jan
> On 2025/7/14 17:33, Jan Kara wrote:
> > On Fri 11-07-25 13:55:09, Youling Tang wrote:
> >> From: Youling Tang <tangyouling@kylinos.cn>
>
> ...
>
> >> --- a/mm/filemap.c
> >> +++ b/mm/filemap.c
> >> @@ -2584,8 +2584,9 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
> >>   	unsigned int flags;
> >>   	int err = 0;
> >>   
> >> -	/* "last_index" is the index of the page beyond the end of the read */
> >> -	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
> >> +	/* "last_index" is the index of the folio beyond the end of the read */
> >> +	last_index = round_up(iocb->ki_pos + count, mapping_min_folio_nrbytes(mapping));
> >> +	last_index >>= PAGE_SHIFT;
> > I think that filemap_get_pages() shouldn't be really trying to guess what
> > readahead code needs and round last_index based on min folio order. After
> > all the situation isn't special for LBS filesystems. It can also happen
> > that the readahead mark ends up in the middle of large folio for other
> > reasons. In fact, we already do have code in page_cache_ra_order() ->
> > ra_alloc_folio() that handles rounding of index where mark should be placed
> > so your changes essentially try to outsmart that code which is not good. I
> > think the solution should really be placed in page_cache_ra_order() +
> > ra_alloc_folio() instead.
> >
> > In fact the problem you are trying to solve was kind of introduced (or at
> > least made more visible) by my commit ab4443fe3ca62 ("readahead: avoid
> > multiple marked readahead pages"). There I've changed the code to round the
> > index down because I've convinced myself it doesn't matter and rounding
> > down is easier to handle in that place. But your example shows there are
> > cases where rounding down has weird consequences and rounding up would have
> > been better. So I think we need to come up with a method how to round up
> > the index of marked folio to fix your case without reintroducing problems
> > mentioned in commit ab4443fe3ca62.
> Yes, I simply replaced round_up() in ra_alloc_folio() with round_down()
> to avoid this phenomenon before submitting this patch.
> 
> But at present, I haven't found a suitable way to solve both of these 
> problems
> simultaneously. Do you have a better solution on your side?
> 

fyi, this patch remains stuck in mm.git awaiting resolution.

Do we have any information regarding its importance?  Which means do we
have any measurement of its effect upon any real-world workload?

Thanks.


