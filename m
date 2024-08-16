Return-Path: <linux-fsdevel+bounces-26126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 724D9954C55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 16:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61451C236B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 14:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CAF1BCA0A;
	Fri, 16 Aug 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZGVbDCMJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA611E520
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723818374; cv=none; b=i6N6+t1FrMAiPKvBiJIrtlQTXJFAjkGaMcS9uP7RWHq0VfEnhhZhVv46nkuKKb/tXM9Bn/aP1pq3XLMx4KDvqTQKG0g3/gjei8Jx4RAYxuDzHW3y1rDJrIqbBnky3xvC+FqyEcjHypqS+HrZLTl/6H+eLESWWL9xfrVOefR1rtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723818374; c=relaxed/simple;
	bh=YlriYsXOqwiTgS6I2KpCXQbTpQsu2jOM4HwsURrgwvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KphRAVUjyQ/P6tDOgsgdVhJTROjLsYZgsfII3VOmGCzuR8GkbDSEvd3UROZSc1uvu85Heu6rhPjqxwr7gXKj+169x5gKULV/T4MGvMeo0S8V7R8RsfOCgMRJbLwrksPbLoR3Z9q0lA/mbSb1JRVwVsV2NNjb000dDJsaXrPf9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZGVbDCMJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YlriYsXOqwiTgS6I2KpCXQbTpQsu2jOM4HwsURrgwvk=; b=ZGVbDCMJ5EQ7fDp/OW1w/N7NOw
	4t+UGUuzMVqEK9/1UpIg5LVG+0GmLRIQrnvLOOjD2AxfnJdrrhEqzr5VehqR6c/WWe4Q3PHQqzsHj
	f/x9rq1sXJN0QvuLCMVJSch8/gBas02AEufR03nbqbnPUGKg8d5QmzW0Te/lIzEkacXUNISSGeKwU
	60rG7hv9cp+sos/3IXW0eY+GOTuZOuouu62pxF8Y4uz51gooHNqk2g/493D12BrNKUHv7fJxLTERT
	qF+qjvvfjj3EuugholQ1ggNpllxtTJBAjHQ6fmhY6AXsTS+bJztsBU3yi8o67zBw3RyA/LqexGukV
	WnT3W9JQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sexu2-0000000DCiv-3kjF;
	Fri, 16 Aug 2024 14:26:06 +0000
Date: Fri, 16 Aug 2024 07:26:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, david@fromorbit.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] mm: document risk of PF_MEMALLOC_NORECLAIM
Message-ID: <Zr9hfsZDfLohgj0m@infradead.org>
References: <Zrxfy-F1ZkvQdhNR@tiehlicka>
 <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
 <ZrymePQHzTHaUIch@tiehlicka>
 <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>
 <Zr2eiFOT--CV5YsR@tiehlicka>
 <CALOAHbCnWDPnErCDOWaPo6vc__G56wzmX-j=bGrwAx6J26DgJg@mail.gmail.com>
 <Zr2liCOFDqPiNk6_@tiehlicka>
 <Zr8LMv89fkfpmBlO@tiehlicka>
 <Zr8MTWiz6ULsZ-tD@infradead.org>
 <Zr8TzTJc-0lDOIWF@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr8TzTJc-0lDOIWF@tiehlicka>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 16, 2024 at 10:54:37AM +0200, Michal Hocko wrote:
> Yes, I think we should kill it before it spreads even more but I would
> not like to make the existing user just broken. I have zero visibility
> and understanding of the bcachefs code but from a quick look at __bch2_new_inode
> it shouldn't be really terribly hard to push GFP_NOWAIT flag there
> directly. It would require inode_init_always_gfp variant as well (to not
> touch all existing callers that do not have any locking requirements but
> I do not see any other nested allocations.

I'll probably have to go down into security_inode_alloc as well.
That being said there is no explanation for the behavior here in the
commit logs or the code itself, so who knows.


