Return-Path: <linux-fsdevel+bounces-12391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D074885EC6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 00:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDC32820FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 23:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981EE85280;
	Wed, 21 Feb 2024 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FXEM6FUC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8DA35
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556480; cv=none; b=C3+yKwaFAUZGh24F+dpfu0ZVBEU4JUAGjmU3UEIZIVh4OCpWyOmz/hhwuCxaWBWp0Jv9v2ObHPr2mghU6Zhd+pGEFE79QIbqEiKIfszjNDwQbXFyxomZl2qeOm9X2WnCGNbK8f1P3PQRuIVCf4C8RV96ZGyu/bG8tN9qrdxPdb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556480; c=relaxed/simple;
	bh=xY/Q2mBkbBKa5CFOxirwIa5WmSu4fXaq9GtG7v3jCm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4VwykwUheG6vwwdfbShSqi8AM4TGUWaYP1AUU0FmlECRgWKPSz2oQ+3WyVsEh4Z8pbGaY63mCyRJJPu5UvAB2SxweDTcbMS9P5t46pYGorNCh+MoLBSGwz8j1X1Bcr/C04/IaNqYpTYR7poFGL2h+gwU2Qu5lviVwMd6lwLTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FXEM6FUC; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Feb 2024 18:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708556475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgSWjNCOfSwz9+ic8rJ5Yj/J6D6jiLMFHSWfS1V2Z0w=;
	b=FXEM6FUCVqr88KFZwmGnu8MiSzSNbOnTkBvM29waR72pV4J3yvR7GcZudiXuVALk6egEyA
	TeGc2wIhqlKhXx5a7x/AYsOtMhA3S+KtOMw24AS4k89Zr2v8DRar5IZ5tjnCrzIqp2Tfpb
	ML6uT79tsLl0K5hYkjJgscVoFG1czmA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org, Christian Brauner <christian@brauner.io>, 
	=?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
Message-ID: <4ub23tni5bwxthqzsn2uvfs5hwr6gd3oitbckd5xwxdbgci4lj@xddn3dh6y23x>
References: <tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
 <141b4c7ecda2a8c064586d064b8d1476d8de3617.camel@HansenPartnership.com>
 <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>
 <bfbb1e9b521811b234f4f603c2616a9840da9ece.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfbb1e9b521811b234f4f603c2616a9840da9ece.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 20, 2024 at 10:53:58PM -0500, James Bottomley wrote:
> On Tue, 2024-02-20 at 19:25 -0500, Kent Overstreet wrote:
> > On Mon, Feb 19, 2024 at 09:26:25AM -0500, James Bottomley wrote:
> > > I would have to say that changing kuid for a string doesn't really
> > > buy us anything except a load of complexity for no very real gain. 
> > > However, since the current kuid is u32 and exposed uid is u16 and
> > > there is already a proposal to make use of this somewhat in the way
> > > you envision,
> > 
> > Got a link to that proposal?
> 
> I think this is the latest presentation on it:
> 
> https://fosdem.org/2024/schedule/event/fosdem-2024-3217-converting-filesystems-to-support-idmapped-mounts/
> 
> > 
> > > there might be a possibility to re-express kuid as an array
> > > of u16s without much disruption.  Each adjacent pair could
> > > represent the owner at the top and the userns assigned uid
> > > underneath.  That would neatly solve the nesting problem the
> > > current upper 16 bits proposal has.
> > 
> > At a high level, there's no real difference between a variable length
> > integer, or a variable length array of integers, or a string.
> 
> Right, so the advantage is the kernel already does an integer
> comparison all over the place.
> 
> > But there's real advantages to getting rid of the string <-> integer
> > identifier mapping and plumbing strings all the way through:
> > 
> >  - creating a new sub-user can be done with nothing more than the new
> >    username version of setuid(); IOW, we can start a new named
> > subuser
> >    for e.g. firefox without mucking with _any_ system state or tables
> > 
> >  - sharing filesystems between machines is always a pita because
> >    usernames might be the same but uids never are - let's kill that
> > off,
> >    please
> > 
> > Doing anything as big as an array of integers is going to be a major
> > compatibiltiy break anyways, so we might as well do it right.
> 
> I'm not really convinced it's right.  Strings are trickier to handle
> and compare than integer arrays and all of the above can be done by
> either.

Strings are just arrays of integers, and anyways this stuff would be
within helpers.

But what you're not seeing is the beauty and simplicity of killing the
mapping layer.

When usernames are strings all the way into the kernel, creating and
switching to a new user is a single syscall. You can't do that if users
are small integer identifiers to the kernel; you have to create a new
entry in /etc/passwd or some equivalent, and that is strictly required
in order to avoid collisions. Users also can't be ephemeral.

To sketch out an example of how this would work, say we've got a new
set_subuser() syscall and the username equivalent of chown().

Now if we want to run firefox as a subuser, giving it access only
.local/state/firefox, we'd do the following sequence of syscalls within
the start of the new firefox process:

mkdir(".local/state/firefox");
chown_subuser(".local/state/firefox", "firefox"); /* now owned by $USER.firefox */
set_subuser("firefox");

If we want to guarantee uniqueness, we'd append a UUID to the
subusername for the chown_subuser() call, and then for subsequent
invocations read it with statx() (or subuser enabled equivalent) for the
set_subuser() call.

Now firefox is running in a sandbox, where it has no access to the rest
of your home directory - unless explicitly granted with normal ACLs. And
the sandbox requires no system configuration; rm -rfing the
.local/state/firefox directory cleans everything up.

And these trivially nest: Firefox itself wants to sandbox individual
tabs from each other, so firefox could run each sub-process as a
different subuser.

This is dead easy compared to what we've been doing.

> > > However, neither proposal would get us out of the problem of mount
> > > mapping because we'd have to keep the filesystem permission check
> > > on the owning uid unless told otherwise.
> > 
> > Not sure I follow?
> 
> Mounting a filesystem inside a userns can cause huge security problems
> if we map fs root to inner root without the admin blessing it.  Think
> of binding /bin into the userns and then altering one of the root owned
> binaries as inner root: if the permission check passes, the change
> appears in system /bin.

So with this proposal mount mapping becomes "map all users on this
filesystem to subusers of username x". That's a much simpler mapping
than mapping integer ranges to integer ranges, much easier to verify
that there aren't accidental root escpes.

> > And it wouldn't have to be administrator assigned. Some administrator
> > assignment might be required for the username <-> 16 bit uid mapping,
> > but if those mappings are ephemeral (i.e. if we get filesystems
> > persistently storing usernames, which is easy enough with xattrs)
> > then that just becomes "reserve x range of the 16 bit uid space for
> > ephemeral translations".
> 
> *if* the user names you're dealing with are all unprivileged.  When we
> have a mix of privileged and unprivileged users owning the files, the
> problems begin.

Yes, all subusers are unprivilidged - only one username, the empty
username (which we'd probably map to root) maps to existing uid 0.

