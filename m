Return-Path: <linux-fsdevel+bounces-28216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D07F96826E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 10:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333881F2243D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D98518732B;
	Mon,  2 Sep 2024 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hjuz4cMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D7E16BE20
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267179; cv=none; b=r+eadSVAnvUaROaVNkTP56Mu7Xrbm0grSHPYV/i1krNKgcJVbM+/nYkZmfpWzwCr9Wwb96vFxYGlN8mHvyXCC8pWjrq0xxql6qk8c//t44ijWC4ReeKdrKKgUuIDt1Dsf5ePa0vV1nUshYLezy64KLp1lhO7x4mCGp7N33ev8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267179; c=relaxed/simple;
	bh=iQvkUn2Nhr1UXo9usbJRjDLExq1ujEiflVlc38Ctw78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTYfTnMiYbcvQ3jdJdIrZrdmei/4QbN7r1dM+ilbOcMqshii1CkYoZWpJ0nDCG/FmCqc3i3Y638n1tcxad48393JaM5xpFP2U+PFNN/MHKjBVy9fc8EaMMsBP7i/JRozTMVXs/blWEMpeCoKQN7HN1DoDYKyYuFcDeEpBAG7PGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hjuz4cMy; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Sep 2024 04:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725267175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d/FrV6PursYjofC+mwM2z5mlo6l3AN755IMJVDkbYFA=;
	b=hjuz4cMyIyyjAYdtheod8ofxwcBo9WxTFhWMfgcs2kqFegQQ+xz/8VwQ9bAYgTopPnIuwx
	yrD2CsSuUehbY5mpOe4cqCx+7IHIH95VxkXtjlwWzc2rqVta46V68CYe/3or7Xz4IsToG3
	1kiqUMmEomibDJqL0MhByGz12PbfyqI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Dave Chinner <david@fromorbit.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
References: <20240826085347.1152675-2-mhocko@kernel.org>
 <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
 <ZtV6OwlFRu4ZEuSG@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtV6OwlFRu4ZEuSG@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
> On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
> [...]
> > But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
> > in the case of bugs, because that's going to be an improvement w.r.t.
> > system robustness, in exactly the same way we don't use BUG_ON() if it's
> > something that we can't guarantee won't happen in the wild - we WARN()
> > and try to handle the error as best we can.
> 
> We have discussed that in a different email thread. And I have to say
> that I am not convinced that returning NULL makes a broken code much
> better. Why? Because we can expect that broken NOFAIL users will not have a
> error checking path. Even valid NOFAIL users will not have one because
> they _know_ they do not have a different than retry for ever recovery
> path. 

You mean where I asked you for a link to the discussion and rationale
you claimed had happened? Still waiting on that

> That means that an unexpected NULL return either means OOPS or a subtle
> silent error - e.g. memory corruption. The former is a actually a saner
> recovery model because the execution is stopped before more harm can be
> done. I suspect most of those buggy users will simply OOPS but
> systematically checking for latter is a lot of work and needs to be
> constantly because code evolves...
> 
> I have tried to argue that if allocator cannot or refuse to satisfy
> GFP_NOFAIL request because it is trying to use unsupported allocation
> mode or size then we should terminate the allocation context. That would
> make the API more predictable and therefore safer to use.

You're arguing that we treat it like an oops?

Yeah, enough of this insanity.

