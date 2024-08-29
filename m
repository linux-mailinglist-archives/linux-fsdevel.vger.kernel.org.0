Return-Path: <linux-fsdevel+bounces-27790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D271C9640D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC8D1C22314
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 10:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A92718E026;
	Thu, 29 Aug 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dBfg8s78"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683EC18C90F
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925763; cv=none; b=u9wyy7W3tMerzrxFKpSeG50kz1k7+CgNbtdLGVSuZdWFhAByVoOVTS8XtkLBXq0icZWH39lx2feDa6AZlPD/9Vsmi0FLLTBf//NqqJfcKf6RI/xs11iloxh3EM1c/jYsry+FkMdpowLlJ7IRz6LfB2MczgqhI5p7fDGh9N7BTds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925763; c=relaxed/simple;
	bh=n5jwzTlQBzJwUMoT60JpIvPeggiARsC0Q1xJHRBuss4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uO59PrITudqjfUcpfPZKbB09V6pCfPqi0JOcwrv/okid/YQVr8yxUp0CjF5bU3II3Tpeqm3Oy6uzyiHVVhVE1Q9HSwDIqwHsdGCeHu5YlWESBjZUYOTlW7J+NDC/Oqk7siooX7qIc1/hLYjIiGWwBeI4/Fep+VrZigTDPgNKVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dBfg8s78; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 06:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724925759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vCHet4RZcs0kzetPKYvg5pHpi0wGxVpQFJgUua5GPMM=;
	b=dBfg8s78XD0nKKh3fhBzSsLjvpxP0HZmNBFpY8rQfHhOjWt9wcWxj5eRjCuMaRb4l/mbX1
	fOrnuwxhjP1j+pTPiTiS684piwt/S1W69rAJ7g5aESrwkXPWBZrRaeO1AIPwJs0mFQAAlr
	brODC8Os+KdfdyG0h5OGTXWwEUS07JQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
References: <20240826085347.1152675-2-mhocko@kernel.org>
 <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs6jFb953AR2Raec@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 28, 2024 at 02:09:57PM GMT, Dave Chinner wrote:
> On Tue, Aug 27, 2024 at 08:15:43AM +0200, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
> > inode to achieve GFP_NOWAIT semantic while holding locks. If this
> > allocation fails it will drop locks and use GFP_NOFS allocation context.
> > 
> > We would like to drop PF_MEMALLOC_NORECLAIM because it is really
> > dangerous to use if the caller doesn't control the full call chain with
> > this flag set. E.g. if any of the function down the chain needed
> > GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
> > cause unexpected failure.
> > 
> > While this is not the case in this particular case using the scoped gfp
> > semantic is not really needed bacause we can easily pus the allocation
> > context down the chain without too much clutter.
> > 
> > Acked-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> Looks good to me.
> 
> Reviewed-by: Dave Chinner <dchinner@redhat.com>

Reposting what I wrote in the other thread:

This series is based on a fundamental misunderstanding of what a safe
API is: a safe API is not one that doesn't return errors, it's one that
never invokes undefined behaviour.

It was decided years ago that the scoped APIs were the better
replacement for the gfp APIs, and they need to exist.

This "GFP_NOFAIL exists therefore we can't tell the memory allocator
about situations wehre it would have to fail" is utter insanity - it's
the exact opposite of defining a safe API.

A safe API would be one where we /did/ always tell the memory allocator
when we're in non-sleepable context, and the allocator always returned
failure instead of context switching.

This is utter brain damage; rule #1 of kernel programming is that _you
check for errors_. If you don't know that your GFP_NOFAIL usage is in a
safe context (and that's not just memory reclaim context, it's also the
size of your alloction) then you have to check for errors.

