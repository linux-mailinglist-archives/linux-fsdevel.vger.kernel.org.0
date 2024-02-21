Return-Path: <linux-fsdevel+bounces-12193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CCD85CCB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 01:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021D71F24B85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 00:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E0A23B7;
	Wed, 21 Feb 2024 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n0/xKefv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402917C2
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708475168; cv=none; b=mF2HOY9upR98yYnfcxRWpNlStZFL5xV0kTG56BfNDTvYSL7DQ7NfAtwRikD/Eo04HtOnVksBZlXRXiouDvex1V7tceIgmH3xuqQU2zJsbB6JKJBznepAUDAeWDgQBlyPVMpB51Mu1jd1fFD7xcI8HuWg5a0FawVpvGUdOjdx1iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708475168; c=relaxed/simple;
	bh=y+F0OEcxWwQUQ1ZhY7Rep6BwGbLhr73vm/JNhPyovGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmnxX3AwJ6qUFBya1Ip9cZg2czCwf2D0O5lKa3XP1A0rvBwZnnGJDpG6yI/B3nIpYHZvILMdrty/4gz5XhYSU3KO6TPVqUM6m7cy8kJSIUxKgUBlD4EvQiSvO6c+XBEbq4PuHysrdn/5cT7DGcNZR3KxUDqpGnn5HFfph0t55vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n0/xKefv; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Feb 2024 19:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708475162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FoIIj8SxsFeDPwKkCX69iq7kD9qv6GOmLSsOBQ7BZ4I=;
	b=n0/xKefvii8Bo98Jg9PD+i9uI64iqtimR2i4JbAGhfzE9m/iLqCrtVLhwLWUp+7HDzgKHz
	28k95XiwQLJR5HqCVw/Cto5E+5xrVrN49XddKpvtD59nzp3+/KaTfgMHqnFP8XvvsCOYKe
	5og2zyYZZc9tAloYPn3kSoeu7Kdqs3w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org, Christian Brauner <christian@brauner.io>, 
	=?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
Message-ID: <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>
References: <tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
 <141b4c7ecda2a8c064586d064b8d1476d8de3617.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <141b4c7ecda2a8c064586d064b8d1476d8de3617.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 19, 2024 at 09:26:25AM -0500, James Bottomley wrote:
> On Sat, 2024-02-17 at 15:56 -0500, Kent Overstreet wrote:
> > AKA - integer identifiers considered harmful
> > 
> > Any time you've got a namespace that's just integers, if you ever end
> > up needing to subdivide it you're going to have a bad time.
> > 
> > This comes up all over the place - for another example, consider
> > ioctl numbering, where keeping them organized and collision free is a
> > major headache.
> > 
> > For UIDs, we need to be able to subdivide the UID namespace for e.g.
> > containers and mounting filesystems as an unprivileged user - but
> > since we just have an integer identifier, this requires complicated
> > remapping and updating and maintaining a global table.
> > 
> > Subdividing a UID to create new permissions domains should be a
> > cheap, easy operation, and it's not.
> > 
> > The solution (originally from plan9, of course) is - UIDs shouldn't
> > be numbers, they should be strings; and additionally, the strings
> > should be paths.
> > 
> > Then, if 'alice' is a user, 'alice.foo' and 'alice.bar' would be
> > subusers, created by alice without any privileged operations or
> > mucking with outside system state, and 'alice' would be superuser
> > w.r.t. 'alice.foo' and 'alice.bar'.
> > 
> > What's this get us?
> 
> I would have to say that changing kuid for a string doesn't really buy
> us anything except a load of complexity for no very real gain. 
> However, since the current kuid is u32 and exposed uid is u16 and there
> is already a proposal to make use of this somewhat in the way you
> envision,

Got a link to that proposal?

> there might be a possibility to re-express kuid as an array
> of u16s without much disruption.  Each adjacent pair could represent
> the owner at the top and the userns assigned uid underneath.  That
> would neatly solve the nesting problem the current upper 16 bits
> proposal has.

At a high level, there's no real difference between a variable length
integer, or a variable length array of integers, or a string.

But there's real advantages to getting rid of the string <-> integer
identifier mapping and plumbing strings all the way through:

 - creating a new sub-user can be done with nothing more than the new
   username version of setuid(); IOW, we can start a new named subuser
   for e.g. firefox without mucking with _any_ system state or tables

 - sharing filesystems between machines is always a pita because
   usernames might be the same but uids never are - let's kill that off,
   please

Doing anything as big as an array of integers is going to be a major
compatibiltiy break anyways, so we might as well do it right.

Either way we're going to need a mapping to 16 bit uids for
compatibility; doing this right gives userspace an incentive to get
_off_ that compatibility layer so we're not dealing with that impedence
mismatch forever.

> However, neither proposal would get us out of the problem of mount
> mapping because we'd have to keep the filesystem permission check on
> the owning uid unless told otherwise.

Not sure I follow?

We're always going to need mount mapping, but if the mount mapping is
just "usernames here get mapped to this subtree of the system username
namespace", then that potentially simplifies things quite a bit - the
mount mapping is no longer a _table_.

And it wouldn't have to be administrator assigned. Some administrator
assignment might be required for the username <-> 16 bit uid mapping,
but if those mappings are ephemeral (i.e. if we get filesystems
persistently storing usernames, which is easy enough with xattrs) then
that just becomes "reserve x range of the 16 bit uid space for ephemeral
translations".

