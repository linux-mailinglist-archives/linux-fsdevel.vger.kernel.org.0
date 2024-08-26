Return-Path: <linux-fsdevel+bounces-27219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B3895F9E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7CECB22A43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F0F1993AD;
	Mon, 26 Aug 2024 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dc1AOO/q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEA5199229
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701387; cv=none; b=QDba86/Tl0M207uf4uCMNJjuQiMhikepE5qQl6OBP0m9cCAOJugTmF38RIZpXQIQJ5sWKgMpwH2h/2ukPeevOR2ozUjKjydAt5HisX3aMfvQecCxcdscfsb0Ni/GSRMOew/PnBC1ouQJQeXxjJQfuvQ0U6V6ufzS0gV1ohsecHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701387; c=relaxed/simple;
	bh=j0XA0dwEhOG2x7CuCx33e8PmSFEXJYbNGaWVBiSjOu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmK1jfwTwTcmPMkk593CImF4fFgOunPvqfH5h6qJkBL3TJNO4WzST8argtOz+Eu0TcYBAPSGidjrn4n5liNbp5ud/dGtyuITQD7Osammjb9JI+CP9xCKmTXYBo6hpQNknDDk6sWyuwIhyFja4wTzZrpX32HU2U2nFgfG+l97nz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dc1AOO/q; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Aug 2024 15:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724701383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZkPXD2IYKOfAOOldbpX3VURfwiKgu7CQydh9Ux0uo8=;
	b=Dc1AOO/qri2M8aPstAypVWRa+KJNmbPOTYol3+KKZhRV/wbhP6yTLSnGSpij/VarO3cI8P
	WIB78ZPkpJV2r3XMn4fhNj0JXkqjdV9xZQCW7GogWWDs1lM9E34n0Y1ubTtI8PeVLInCxj
	B24jIisCjGpZFYA+w0YUTrIaALfKue0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <rwqusvtkwzbr2pc2hwmt2lkpffzivrlaw3xfrnrqxze6wmpsex@s3eavvieveld>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
 <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
 <Zszado75SnObVKG5@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zszado75SnObVKG5@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 26, 2024 at 08:41:42PM GMT, Matthew Wilcox wrote:
> On Mon, Aug 26, 2024 at 03:39:47PM -0400, Kent Overstreet wrote:
> > Given the amount of plumbing required here, it's clear that passing gfp
> > flags is the less safe way of doing it, and this really does belong in
> > the allocation context.
> > 
> > Failure to pass gfp flags correctly (which we know is something that
> > happens today, e.g. vmalloc -> pte allocation) means you're introducing
> > a deadlock.
> 
> The problem with vmalloc is that the page table allocation _doesn't_
> take a GFP parameter.

yeah, I know. I posted patches to plumb it through, which were nacked by
Linus.

And we're trying to get away from passing gfp flags directly, are we
not? I just don't buy the GFP_NOFAIL unsafety argument.

