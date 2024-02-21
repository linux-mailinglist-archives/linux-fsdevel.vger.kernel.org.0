Return-Path: <linux-fsdevel+bounces-12202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD4985CDB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 03:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737C11F25AAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 02:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6E5567F;
	Wed, 21 Feb 2024 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nH8DR9bV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80E4C7E
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 02:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481245; cv=none; b=OYB1y1TvWDhZ8xkw0RrhICeTfsOYXqM5O29wKE/icvCdPQXkEt8BQj49iIHuHedIi/w50yVcSW3pYLBOqQDiWIKKlALj+OjTmgeIRimuE3M5OmIErofUl0eQm5gKx6KaJ9KQvvgWr26rCyxVO6NoifNdErPjCTOb/RqwVZ1pF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481245; c=relaxed/simple;
	bh=wiLIzz9b6fvfPP/ovAxFvs4rByk7v8jvd4J20JaFkP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUilGRJUMK9df9qu/M4xZQ9iHGXnkHozD8EpZQtkfEkecc9S2RQ8awbwONaU/J67TqA0gX/miy/w2HF5qyAYC1V6dnU93dW4fsvnSfXpjKmleQRLZBT5Mn/8pZZw0+lLdvSxprcCDu0ixB2INpyITFTRX8EnnFUc9t8OL9st9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nH8DR9bV; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Feb 2024 21:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708481240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nHAjgIxxF99L+18lXUoxzVJeuzKS1vqZwDmj0f/fcQQ=;
	b=nH8DR9bV3AuPMisdGIBXqEoeJt67exbo2MxvdXPO4qielG09B9lvQFo/ER7ZSLrZXsmrkS
	5G7YxC4HeCasV/idemoUrZf5rXezUxAMtNDIUCTrYG3ewxuYHZ/X8laMHxRc8p2mRdaWHG
	KpuzE+0P2NiOUn2BPlN9WZdXzMQUm1c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	Christian Brauner <christian@brauner.io>, =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
Message-ID: <iezqitjpucc7x7dt46rjolr2zui7vw2sci4z7bzixvkzmpxfbn@naqhp3qwnkak>
References: <tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
 <141b4c7ecda2a8c064586d064b8d1476d8de3617.camel@HansenPartnership.com>
 <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>
 <ZdVQb9KoVqKJlsbD@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdVQb9KoVqKJlsbD@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 21, 2024 at 01:22:55AM +0000, Matthew Wilcox wrote:
> On Tue, Feb 20, 2024 at 07:25:58PM -0500, Kent Overstreet wrote:
> > But there's real advantages to getting rid of the string <-> integer
> > identifier mapping and plumbing strings all the way through:
> > 
> >  - creating a new sub-user can be done with nothing more than the new
> >    username version of setuid(); IOW, we can start a new named subuser
> >    for e.g. firefox without mucking with _any_ system state or tables
> > 
> >  - sharing filesystems between machines is always a pita because
> >    usernames might be the same but uids never are - let's kill that off,
> >    please
> 
> I feel like we need a bit of a survey of filesystems to see what is
> already supported and what are desirable properties.  Block filesystems
> are one thing, but network filesystems have been dealing with crap like
> this for decades.  I don't have a good handle on who supports what at
> this point.

I'm not sure it's critical. 9p supports it already. The big one is NFS,
but if this takes off getting it into the next version of NFS or as an
extension is going to be the easy part.

The critical part is going to be coming up with the new syscall
interface, and figuring out the compatibility shims so that the minimum
amount of userspace has to be modified to take advantage of it, and
figuring out what the compatibility code so that non username aware code
does something sensible.

But with filesystem support, so that we're persisting usernames and
those are the source of truth and old style UIDs are just ephermeral,
that part looks tractable.

I'm glad the container people are looking at this are already, and I
hope they're up for something even more ambitious :) I'd love to kill
off the problems with integer identifiers once and for all.

One of my professors way way back, who was a big influence on me, made
the point that the purpose of the operating system is to virtualize the
hardware, so that every program can pretend it has the whole machine to
itself. Hence things like virtual memory, and filesystems that let you
recursively divide your storage.

But that job isn't complete until the operating system lets you
recursively subdivide every resource it provides, physical or virtual:
hence containers and namespaces.

Hence - 64 bit identifiers aren't enough, if we're going to solve this
once and for all it's got to be a variable length path.

> As far as usernames being the same ... well, maybe.  I've been willy,
> mrw103, wilma (twice!), mawilc01 and probably a bunch of others I don't
> remember.  I don't think we'll ever get away from having a mapping
> between different naming authorities.

*nod* There will still be situations where remapping is needed, but name
<-> name mapping is way easier for users to deal with than integer <->
integer.

Also - I'd like to get some security model people involved with this, if
anyone knows the right people to loop in. That's the part that's the
most interesting to me (and what motivated me to post this the other day
was Al bitching about apparmor on IRC).

I think, in hindsight, that we grew a lot of this strange security model
stuff that doesn't at all fit with the Unix security model for the
simple reason that creating new permissions domains is just not
something you do on an as needed basis, as a normal user.

The next natural thing to do with permissions is to extend the
permissions model with rwx bits for
 - parent of current user
 - subusers of current user

...and probably various acl variants of these.

There's some interesting territory to be explored there for sure.

