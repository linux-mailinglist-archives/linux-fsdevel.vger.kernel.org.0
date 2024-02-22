Return-Path: <linux-fsdevel+bounces-12450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478B285F78C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADD34B22CB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 11:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4019F47A5C;
	Thu, 22 Feb 2024 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="drqElOnw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E64646521
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602831; cv=none; b=tHHmTeNbcb/UgHvObwKKgQRAzErXw6FCiWKLyCvGnSiZOrDXDQLHNEY3USoB28rKRJdn807veuvesuPY2jgUf7VXN3d/1cUQnkixA56WB1de+NPUlF8P7LpPZj7cB4noKqBnB42iWrhlHqvKmNKSA2/IL5i+LwxHU3mDe4R8YMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602831; c=relaxed/simple;
	bh=/GZnl1bApZlEPKB/0OjNOdfWl1yXpoyVVjwgwuxpGQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+hXVyx+tW3Q0JFZGrtaLXhwzGpje3jfje3pkeuhUtDvMlO5SerWynHYl9INBUZfxLUtkFivyZx3uOUp+Fo9733pnpLX6yknCBlregXygz53bCoYo2LFAI9NVKS9KBRAwT/oFEFAHKH1mDw4eEc9kDRuiK0WA4Pa4EMyB2p6I/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=drqElOnw; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Feb 2024 06:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708602827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oV0lp1K4Ub7tESvDeFqVDjAAwFBAw9Dokd5x1fT4D0=;
	b=drqElOnwL3FwHj1AMzKxLETAoI5EamXZIjhfyV0ps8yqhsMnbw8hmnguls1XP3MXWFfwmP
	Hs/PZOSzbbZtnYkLWR4clg1W6XFaNomccWlPYLiIDu4gIbcbGQ+lA8+YclNzl4JrC9QnZU
	QPvkzbsPkVgeL1M06zYMpKhmhk8JnHg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org, Christian Brauner <christian@brauner.io>, 
	=?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
Message-ID: <lgsh46klnmhaqsgzguoces452gbuzpzpg6jqr3cndblhpq34ez@jm2kobculj2p>
References: <tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
 <141b4c7ecda2a8c064586d064b8d1476d8de3617.camel@HansenPartnership.com>
 <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>
 <bfbb1e9b521811b234f4f603c2616a9840da9ece.camel@HansenPartnership.com>
 <4ub23tni5bwxthqzsn2uvfs5hwr6gd3oitbckd5xwxdbgci4lj@xddn3dh6y23x>
 <c0d77327b15e84df19a019300347063a0b74e1a5.camel@HansenPartnership.com>
 <giojfztuhxc5ilv24htcyhlerc6otajpa32cjtze4gghevg2jr@vwykmx7526ae>
 <67a0b68946d39928502ce2d3e3ad834aa8d73d02.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67a0b68946d39928502ce2d3e3ad834aa8d73d02.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 22, 2024 at 09:45:32AM +0100, James Bottomley wrote:
> On Wed, 2024-02-21 at 22:37 -0500, Kent Overstreet wrote:
> > On Thu, Feb 22, 2024 at 01:33:14AM +0100, James Bottomley wrote:
> > > On Wed, 2024-02-21 at 18:01 -0500, Kent Overstreet wrote:
> > > > Strings are just arrays of integers, and anyways this stuff would
> > > > be within helpers.
> > > 
> > > Length limits and comparisons are the problem
> > 
> > We'd be using qstrs for this, not c strings, so they really are
> > equivalent to arrays for this purpose.
> > 
> > > 
> > > > 
> > > > But what you're not seeing is the beauty and simplicity of
> > > > killing
> > > > the mapping layer.
> > > 
> > > Well, that's the problem: you don't for certain use cases.  That's
> > > what I've been trying to explain.  For the fully unprivileged use
> > > case, sure, it all works (as does the upper 32 bits proposal or the
> > > integer array ... equally well.
> > > 
> > > Once you're representing to the userns contained entity they have a
> > > privileged admin that can write to the fsimage as an apparently
> > > privileged user then the problems begin.
> > 
> > In what sense?
> > 
> > If they're in a userns and all their mounts are username mapped,
> > that's completely fine from a userns POV; they can put a suid root
> > binary into the fs image but when they mount that suid root will be
> > suid to the root user of their userns.
> 
> if userns root can alter a suid root binary that's bind mounted from
> the root namespace then that's a security violation because a user in
> the root ns could use the altered binary to do a privilege escalation
> attack.

That's a completely different situation; now you're talking about suid
root, where root is _outside_ the userns, and if you're playing tricks
to make something from a user from outside the ns that is not
representable in the ns visible in that ns, and now you're making that
something suid, of course you're going to have trouble defining self
consistent behaviour.

So I'm not sure what point you were trying to make, but it does
illustrate some key points.

Any time you're creating a system where different agents can have
different but overlapping views of the world, you're going to have some
really fun corner cases and it's going to be hard to reason about.

(if you buy me a really nice scotch somitem I'll tell you about fsck for
a snapshotting filesystem, where for performance reasons fsck has to
process keys from all snapshots simultaneously).

So such things are best avoided, if we can. For another example, see if
you know anyone who's had to track down what's keeping a mount alive,
then the something was a systemd service running in a private namespace.

Systems where we can recursively enumerate the world are much nicer to
work with.

Now, back to user namespaces: they shouldn't exist.

And they wouldn't exist, if usernames had started out as a recursive
structure instead of a flat namespace. But since they started out as a
flat namespace, and only _later_ we realized they actually needed to be
a tree structure - but we have to preserve for compatibility the _view_
of the world as a flat namespace! - that's why we have user namespaces.

And you get all sorts of super weird corner cases like you just
described.

So let's take a step back from all that, and instead of reasoning from
"what weird corner cases from our current system do we have to support"
- instead, just seem what we can do with a cleaner model and get that
properly specified. A good model helps you make sense of the world even
in crazy situations.

With that in mind, back to your bind mount thing: if you chroot(), and
you try to access a symlink that points outside the chroot, what
happens?

