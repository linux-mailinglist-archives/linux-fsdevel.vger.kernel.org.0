Return-Path: <linux-fsdevel+bounces-12417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6079185EFF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 04:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8741F231C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 03:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451AC1755A;
	Thu, 22 Feb 2024 03:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W01/NdEz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBD7134CD
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573037; cv=none; b=qiqqN1MsRzNbezaWFZWHiPqU7m9kNX9BwX7w0F6rKureg1p3rQ92Lz68l3nuNEvk2Wu7RFL0t+qecl1kMWczgtZK3MzUd/ESMgRnAs2cgwojqMG1gFcipohkYf+J7r8sxnD7qWhD5PMLB1/KuZlmHZIDRpxO9BVaXU2jM87hW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573037; c=relaxed/simple;
	bh=AClHY/wTOZgy1rmmOfdnQgC33nR4hv+88+JaIN/OiYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+Rd2qapb1QBf8Iq3I2HJenLHPpNROBN1NiW1yGdO/XnwhvYzr0JzoNr/3fEV9hLgfPjgDF+g8H22C+jC30632yVV2LOe8/vLd0RfQiStPxHpCFzp2Bs+72C799TziixD9BZIJnPpgN4V6Hx2hbye1S3J9U2tRyRSPP/HlFlDFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W01/NdEz; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Feb 2024 22:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708573030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ojk1fz89JpUi8jWPvmW8PS+rQwDOSQZnMT7LCgNuLDc=;
	b=W01/NdEzw/an3GwPrdLCVmxzEx5UTibBxE3aqwho4wrssQyQY7HyggVyHUFRg2QyTK+/zV
	20AgxZfLu2Lh4jK6lCL79R8lFtkdwFUQoX+CvDUpoZHmVZwq8tAINCzoIbG6e/gyj3Dyt0
	EHKjiTsEv4ULDmpH0eguayAfV2kh1AE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org, Christian Brauner <christian@brauner.io>, 
	=?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
Message-ID: <giojfztuhxc5ilv24htcyhlerc6otajpa32cjtze4gghevg2jr@vwykmx7526ae>
References: <tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
 <141b4c7ecda2a8c064586d064b8d1476d8de3617.camel@HansenPartnership.com>
 <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>
 <bfbb1e9b521811b234f4f603c2616a9840da9ece.camel@HansenPartnership.com>
 <4ub23tni5bwxthqzsn2uvfs5hwr6gd3oitbckd5xwxdbgci4lj@xddn3dh6y23x>
 <c0d77327b15e84df19a019300347063a0b74e1a5.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0d77327b15e84df19a019300347063a0b74e1a5.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 22, 2024 at 01:33:14AM +0100, James Bottomley wrote:
> On Wed, 2024-02-21 at 18:01 -0500, Kent Overstreet wrote:
> > Strings are just arrays of integers, and anyways this stuff would be
> > within helpers.
> 
> Length limits and comparisons are the problem

We'd be using qstrs for this, not c strings, so they really are
equivalent to arrays for this purpose.

> 
> > 
> > But what you're not seeing is the beauty and simplicity of killing
> > the mapping layer.
> 
> Well, that's the problem: you don't for certain use cases.  That's what
> I've been trying to explain.  For the fully unprivileged use case,
> sure, it all works (as does the upper 32 bits proposal or the integer
> array ... equally well.
> 
> Once you're representing to the userns contained entity they have a
> privileged admin that can write to the fsimage as an apparently
> privileged user then the problems begin.

In what sense?

If they're in a userns and all their mounts are username mapped, that's
completely fine from a userns POV; they can put a suid root binary into
the fs image but when they mount that suid root will be suid to the root
user of their userns.

> 
> > When usernames are strings all the way into the kernel, creating and
> > switching to a new user is a single syscall. You can't do that if
> > users are small integer identifiers to the kernel; you have to create
> > a new entry in /etc/passwd or some equivalent, and that is strictly
> > required in order to avoid collisions. Users also can't be ephemeral.
> > 
> > To sketch out an example of how this would work, say we've got a new
> > set_subuser() syscall and the username equivalent of chown().
> > 
> > Now if we want to run firefox as a subuser, giving it access only
> > .local/state/firefox, we'd do the following sequence of syscalls
> > within the start of the new firefox process:
> > 
> > mkdir(".local/state/firefox");
> > chown_subuser(".local/state/firefox", "firefox"); /* now owned by
> > $USER.firefox */
> > set_subuser("firefox");
> > 
> > If we want to guarantee uniqueness, we'd append a UUID to the
> > subusername for the chown_subuser() call, and then for subsequent
> > invocations read it with statx() (or subuser enabled equivalent) for
> > the set_subuser() call.
> > 
> > Now firefox is running in a sandbox, where it has no access to the
> > rest of your home directory - unless explicitly granted with normal
> > ACLs. And the sandbox requires no system configuration; rm -rfing the
> > .local/state/firefox directory cleans everything up.
> > 
> > And these trivially nest: Firefox itself wants to sandbox individual
> > tabs from each other, so firefox could run each sub-process as a
> > different subuser.
> > 
> > This is dead easy compared to what we've been doing.
> 
> The above is the unprivileged use case.  It works, but it's not all we
> have to support.

There is only one root user, in the sense of _actual_ root -
CAP_SYS_ADMIN and all that.
> 
> > > > > However, neither proposal would get us out of the problem of
> > > > > mount mapping because we'd have to keep the filesystem
> > > > > permission check on the owning uid unless told otherwise.
> > > > 
> > > > Not sure I follow?
> > > 
> > > Mounting a filesystem inside a userns can cause huge security
> > > problems if we map fs root to inner root without the admin blessing
> > > it.  Think of binding /bin into the userns and then altering one of
> > > the root owned binaries as inner root: if the permission check
> > > passes, the change appears in system /bin.
> > 
> > So with this proposal mount mapping becomes "map all users on this
> > filesystem to subusers of username x". That's a much simpler mapping
> > than mapping integer ranges to integer ranges, much easier to verify
> > that there aren't accidental root escpes.
> 
> That doesn't work for the privileged container run in unprivileged
> userns containment use case because we need a mapping from inner to
> outer root.

I can't parse this. "Privileged container in an unprivileged
containment"? Do you just mean a container that has root user (which is
only root over that container, not the rest of the system, of course).

Any user is root over its subusers - so that works perfectly.

Or do you mean something else by "privileged container"? Do you mean a
container that actually has CAP_SYS_ADMIN?

> > > > And it wouldn't have to be administrator assigned. Some
> > > > administrator assignment might be required for the username <->
> > > > 16 bit uid mapping, but if those mappings are ephemeral (i.e. if
> > > > we get filesystems persistently storing usernames, which is easy
> > > > enough with xattrs) then that just becomes "reserve x range of
> > > > the 16 bit uid space for ephemeral translations".
> > > 
> > > *if* the user names you're dealing with are all unprivileged.  When
> > > we have a mix of privileged and unprivileged users owning the
> > > files, the problems begin.
> > 
> > Yes, all subusers are unprivilidged - only one username, the empty
> > username (which we'd probably map to root) maps to existing uid 0.
> 
> But, as I said above, that's only a subset of the use cases.  The
> equally big use case is figuring out how to run privileged containers
> in a deprivileged mode and yet still allow them to update images (and
> other things).

If you're running in a userns, all your mounts get the same user mapping
as your userns - where that usermapping is just prepending the username
of the userns. That part is easy.

The big difficulty with letting them update images is that our current
filesystems really aren't ready for the mounting of untrusted images -
they're ~100k loc codebases each and the amount of hardening required is
significant. I would hazard to guess that XFS is the furthest along is
this respect (from all the screaming I hear from Darrick about syzkaller
it sounds like they're taking this the most seriously) - but I would
hesitate to depend on any of our filesystems to be secure in this
respect, even my own - not until we get them rewritten in Rust...

