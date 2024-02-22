Return-Path: <linux-fsdevel+bounces-12410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F78C85EE0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 01:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA211C21B93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 00:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B02EAE7;
	Thu, 22 Feb 2024 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="R8NtB1qP";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="R8NtB1qP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4A829A5;
	Thu, 22 Feb 2024 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562016; cv=none; b=m1sv6m0VBM3TSCIuYMpdAr4c67VqEpcpSMJKASdzfnglUTp2XC5bDX8KiN1/0zALjh7T25bmHWUEHHKk2VQy5DiHQdY8nCht8g4cfd7/WOsmgTJGLqKZeIB36tlo9ZqKlXNRJblptFn+CtzpjCa0vmGacNINaySYVAd4jeHkGrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562016; c=relaxed/simple;
	bh=sbYSDMaKDJMAgkeV6YzwswiENnj+k7G1IKJgab3P01Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U4eDir7uqPk8SN795WO0XgApwsLIlZqK3x0o56FMmeAcAd5ip9HsspR1UDJNGAH5LaSZyKnwDRJ85I8haaqIxinj0a/a0IvpgWVyYqB0l1pcWDSmKfrLOhJm6NFiDQtaXwxRZ806s2kdv7iwrJHtOT/8+NeA1svvZ+xFZvHpOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=R8NtB1qP; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=R8NtB1qP; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708562013;
	bh=sbYSDMaKDJMAgkeV6YzwswiENnj+k7G1IKJgab3P01Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=R8NtB1qP8AKOTw78i0aSLbxdISit0VEEHFyFNq5HVw5IbQUnoQE3LzP5Tf7ftYZDf
	 FNKFgt3SMpYUQOdo1VHXrnQZz6CY5v/sHy20p+tHQ0ptvxL1jd+fmT6Qt9strFVIv6
	 V2/9iHBaiqd7p42BTUnBBBzusczZoFEVD3ZI7ljs=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id A28971286E23;
	Wed, 21 Feb 2024 19:33:33 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id TglyaRdIsidr; Wed, 21 Feb 2024 19:33:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708562013;
	bh=sbYSDMaKDJMAgkeV6YzwswiENnj+k7G1IKJgab3P01Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=R8NtB1qP8AKOTw78i0aSLbxdISit0VEEHFyFNq5HVw5IbQUnoQE3LzP5Tf7ftYZDf
	 FNKFgt3SMpYUQOdo1VHXrnQZz6CY5v/sHy20p+tHQ0ptvxL1jd+fmT6Qt9strFVIv6
	 V2/9iHBaiqd7p42BTUnBBBzusczZoFEVD3ZI7ljs=
Received: from [172.19.248.55] (unknown [80.149.170.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 561001286E22;
	Wed, 21 Feb 2024 19:33:23 -0500 (EST)
Message-ID: <c0d77327b15e84df19a019300347063a0b74e1a5.camel@HansenPartnership.com>
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lsf-pc@lists.linux-foundation.org, Christian Brauner
 <christian@brauner.io>,  =?ISO-8859-1?Q?St=E9phane?= Graber
 <stgraber@stgraber.org>
Date: Thu, 22 Feb 2024 01:33:14 +0100
In-Reply-To: <4ub23tni5bwxthqzsn2uvfs5hwr6gd3oitbckd5xwxdbgci4lj@xddn3dh6y23x>
References: 
	<tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
	 <141b4c7ecda2a8c064586d064b8d1476d8de3617.camel@HansenPartnership.com>
	 <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>
	 <bfbb1e9b521811b234f4f603c2616a9840da9ece.camel@HansenPartnership.com>
	 <4ub23tni5bwxthqzsn2uvfs5hwr6gd3oitbckd5xwxdbgci4lj@xddn3dh6y23x>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-02-21 at 18:01 -0500, Kent Overstreet wrote:
> On Tue, Feb 20, 2024 at 10:53:58PM -0500, James Bottomley wrote:
> > On Tue, 2024-02-20 at 19:25 -0500, Kent Overstreet wrote:
> > > On Mon, Feb 19, 2024 at 09:26:25AM -0500, James Bottomley wrote:
> > > > I would have to say that changing kuid for a string doesn't
> > > > really
> > > > buy us anything except a load of complexity for no very real
> > > > gain. 
> > > > However, since the current kuid is u32 and exposed uid is u16
> > > > and
> > > > there is already a proposal to make use of this somewhat in the
> > > > way
> > > > you envision,
> > > 
> > > Got a link to that proposal?
> > 
> > I think this is the latest presentation on it:
> > 
> > https://fosdem.org/2024/schedule/event/fosdem-2024-3217-converting-filesystems-to-support-idmapped-mounts/
> > 
> > > 
> > > > there might be a possibility to re-express kuid as an array
> > > > of u16s without much disruption.  Each adjacent pair could
> > > > represent the owner at the top and the userns assigned uid
> > > > underneath.  That would neatly solve the nesting problem the
> > > > current upper 16 bits proposal has.
> > > 
> > > At a high level, there's no real difference between a variable
> > > length
> > > integer, or a variable length array of integers, or a string.
> > 
> > Right, so the advantage is the kernel already does an integer
> > comparison all over the place.
> > 
> > > But there's real advantages to getting rid of the string <->
> > > integer
> > > identifier mapping and plumbing strings all the way through:
> > > 
> > >  - creating a new sub-user can be done with nothing more than the
> > > new
> > >    username version of setuid(); IOW, we can start a new named
> > > subuser
> > >    for e.g. firefox without mucking with _any_ system state or
> > > tables
> > > 
> > >  - sharing filesystems between machines is always a pita because
> > >    usernames might be the same but uids never are - let's kill
> > > that
> > > off,
> > >    please
> > > 
> > > Doing anything as big as an array of integers is going to be a
> > > major
> > > compatibiltiy break anyways, so we might as well do it right.
> > 
> > I'm not really convinced it's right.  Strings are trickier to
> > handle and compare than integer arrays and all of the above can be
> > done by either.
> 
> Strings are just arrays of integers, and anyways this stuff would be
> within helpers.

Length limits and comparisons are the problem

> 
> But what you're not seeing is the beauty and simplicity of killing
> the mapping layer.

Well, that's the problem: you don't for certain use cases.  That's what
I've been trying to explain.  For the fully unprivileged use case,
sure, it all works (as does the upper 32 bits proposal or the integer
array ... equally well.

Once you're representing to the userns contained entity they have a
privileged admin that can write to the fsimage as an apparently
privileged user then the problems begin.

> When usernames are strings all the way into the kernel, creating and
> switching to a new user is a single syscall. You can't do that if
> users are small integer identifiers to the kernel; you have to create
> a new entry in /etc/passwd or some equivalent, and that is strictly
> required in order to avoid collisions. Users also can't be ephemeral.
> 
> To sketch out an example of how this would work, say we've got a new
> set_subuser() syscall and the username equivalent of chown().
> 
> Now if we want to run firefox as a subuser, giving it access only
> .local/state/firefox, we'd do the following sequence of syscalls
> within the start of the new firefox process:
> 
> mkdir(".local/state/firefox");
> chown_subuser(".local/state/firefox", "firefox"); /* now owned by
> $USER.firefox */
> set_subuser("firefox");
> 
> If we want to guarantee uniqueness, we'd append a UUID to the
> subusername for the chown_subuser() call, and then for subsequent
> invocations read it with statx() (or subuser enabled equivalent) for
> the set_subuser() call.
> 
> Now firefox is running in a sandbox, where it has no access to the
> rest of your home directory - unless explicitly granted with normal
> ACLs. And the sandbox requires no system configuration; rm -rfing the
> .local/state/firefox directory cleans everything up.
> 
> And these trivially nest: Firefox itself wants to sandbox individual
> tabs from each other, so firefox could run each sub-process as a
> different subuser.
> 
> This is dead easy compared to what we've been doing.

The above is the unprivileged use case.  It works, but it's not all we
have to support.

> > > > However, neither proposal would get us out of the problem of
> > > > mount mapping because we'd have to keep the filesystem
> > > > permission check on the owning uid unless told otherwise.
> > > 
> > > Not sure I follow?
> > 
> > Mounting a filesystem inside a userns can cause huge security
> > problems if we map fs root to inner root without the admin blessing
> > it.  Think of binding /bin into the userns and then altering one of
> > the root owned binaries as inner root: if the permission check
> > passes, the change appears in system /bin.
> 
> So with this proposal mount mapping becomes "map all users on this
> filesystem to subusers of username x". That's a much simpler mapping
> than mapping integer ranges to integer ranges, much easier to verify
> that there aren't accidental root escpes.

That doesn't work for the privileged container run in unprivileged
userns containment use case because we need a mapping from inner to
outer root.

> > > And it wouldn't have to be administrator assigned. Some
> > > administrator assignment might be required for the username <->
> > > 16 bit uid mapping, but if those mappings are ephemeral (i.e. if
> > > we get filesystems persistently storing usernames, which is easy
> > > enough with xattrs) then that just becomes "reserve x range of
> > > the 16 bit uid space for ephemeral translations".
> > 
> > *if* the user names you're dealing with are all unprivileged.  When
> > we have a mix of privileged and unprivileged users owning the
> > files, the problems begin.
> 
> Yes, all subusers are unprivilidged - only one username, the empty
> username (which we'd probably map to root) maps to existing uid 0.

But, as I said above, that's only a subset of the use cases.  The
equally big use case is figuring out how to run privileged containers
in a deprivileged mode and yet still allow them to update images (and
other things).

The unprivileged case is also solved by the proposal I referred you to,
so it's unclear what the advantage of strings (or even int arrays) adds
to this unless we can get a better handle on the privileged container
use case with them.

James


