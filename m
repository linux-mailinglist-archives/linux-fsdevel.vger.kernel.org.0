Return-Path: <linux-fsdevel+bounces-12428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D96185F35E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 09:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F8B1F240B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304672C1B1;
	Thu, 22 Feb 2024 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Mmvd2HVy";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Mmvd2HVy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96018AE8;
	Thu, 22 Feb 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591541; cv=none; b=n2fFGeEs71Dqkkj0sF5tofARH2wZCWbNkCbcGvW53JFZgAq9opm+4hTjdrgg+WUe6bwytemJcDxZr4zYvj74nV1R98ODx7J35YhyTscYJeauVpmZxhVnwateB80Z2pbZNb60mUbuYhvJ/akObK4rKMg+xYOPaUvZS72nBmKeHm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591541; c=relaxed/simple;
	bh=vU/yawKDjAzjVlhyldrckm3RWW0rGgSdIhZaf8HI6lc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kbjB6M+ZDSj6BXoT4+Vp63GVr9qkeuaq8I+tcED2Hi+eLI2kv+wy/jhIGxRgQ16a9SRzEqSakYH/cWaSO8Vs19BqoRItEVnzlnFq2EI1cowtM2/feMIqH1IUvbW4OWF0VaHrVzVKb2AYvw28i3qseJYSTD1iwqrLJ2Ej4Nnoo9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Mmvd2HVy; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Mmvd2HVy; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708591538;
	bh=vU/yawKDjAzjVlhyldrckm3RWW0rGgSdIhZaf8HI6lc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Mmvd2HVydc3hDW5jDIEPuABt3kKq+F1KFH3CLmoTlnSQJ7nkTI3TDi528A5dGjlfL
	 tmmHR9vE0bQp+txI4Yn7/EasJor67tD/+7pNZnZgoqcM9KRQRBWeNpRHvx4tEEhptS
	 Myg34h58on6l2Wubi6zYr5B3z+TBnXM6qoXRF1eQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 79ACA1281C36;
	Thu, 22 Feb 2024 03:45:38 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id dW361cjueL5n; Thu, 22 Feb 2024 03:45:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708591538;
	bh=vU/yawKDjAzjVlhyldrckm3RWW0rGgSdIhZaf8HI6lc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Mmvd2HVydc3hDW5jDIEPuABt3kKq+F1KFH3CLmoTlnSQJ7nkTI3TDi528A5dGjlfL
	 tmmHR9vE0bQp+txI4Yn7/EasJor67tD/+7pNZnZgoqcM9KRQRBWeNpRHvx4tEEhptS
	 Myg34h58on6l2Wubi6zYr5B3z+TBnXM6qoXRF1eQ=
Received: from [10.236.41.91] (unknown [88.128.88.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6EABD12819F3;
	Thu, 22 Feb 2024 03:45:36 -0500 (EST)
Message-ID: <67a0b68946d39928502ce2d3e3ad834aa8d73d02.camel@HansenPartnership.com>
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lsf-pc@lists.linux-foundation.org, Christian Brauner
 <christian@brauner.io>,  =?ISO-8859-1?Q?St=E9phane?= Graber
 <stgraber@stgraber.org>
Date: Thu, 22 Feb 2024 09:45:32 +0100
In-Reply-To: <giojfztuhxc5ilv24htcyhlerc6otajpa32cjtze4gghevg2jr@vwykmx7526ae>
References: 
	<tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
	 <141b4c7ecda2a8c064586d064b8d1476d8de3617.camel@HansenPartnership.com>
	 <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>
	 <bfbb1e9b521811b234f4f603c2616a9840da9ece.camel@HansenPartnership.com>
	 <4ub23tni5bwxthqzsn2uvfs5hwr6gd3oitbckd5xwxdbgci4lj@xddn3dh6y23x>
	 <c0d77327b15e84df19a019300347063a0b74e1a5.camel@HansenPartnership.com>
	 <giojfztuhxc5ilv24htcyhlerc6otajpa32cjtze4gghevg2jr@vwykmx7526ae>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-02-21 at 22:37 -0500, Kent Overstreet wrote:
> On Thu, Feb 22, 2024 at 01:33:14AM +0100, James Bottomley wrote:
> > On Wed, 2024-02-21 at 18:01 -0500, Kent Overstreet wrote:
> > > Strings are just arrays of integers, and anyways this stuff would
> > > be within helpers.
> > 
> > Length limits and comparisons are the problem
> 
> We'd be using qstrs for this, not c strings, so they really are
> equivalent to arrays for this purpose.
> 
> > 
> > > 
> > > But what you're not seeing is the beauty and simplicity of
> > > killing
> > > the mapping layer.
> > 
> > Well, that's the problem: you don't for certain use cases.  That's
> > what I've been trying to explain.  For the fully unprivileged use
> > case, sure, it all works (as does the upper 32 bits proposal or the
> > integer array ... equally well.
> > 
> > Once you're representing to the userns contained entity they have a
> > privileged admin that can write to the fsimage as an apparently
> > privileged user then the problems begin.
> 
> In what sense?
> 
> If they're in a userns and all their mounts are username mapped,
> that's completely fine from a userns POV; they can put a suid root
> binary into the fs image but when they mount that suid root will be
> suid to the root user of their userns.

if userns root can alter a suid root binary that's bind mounted from
the root namespace then that's a security violation because a user in
the root ns could use the altered binary to do a privilege escalation
attack.

> > > When usernames are strings all the way into the kernel, creating
> > > and switching to a new user is a single syscall. You can't do
> > > that if users are small integer identifiers to the kernel; you
> > > have to create a new entry in /etc/passwd or some equivalent, and
> > > that is strictly required in order to avoid collisions. Users
> > > also can't be ephemeral.
> > > 
> > > To sketch out an example of how this would work, say we've got a
> > > new set_subuser() syscall and the username equivalent of chown().
> > > 
> > > Now if we want to run firefox as a subuser, giving it access only
> > > .local/state/firefox, we'd do the following sequence of syscalls
> > > within the start of the new firefox process:
> > > 
> > > mkdir(".local/state/firefox");
> > > chown_subuser(".local/state/firefox", "firefox"); /* now owned by
> > > $USER.firefox */ set_subuser("firefox");
> > > 
> > > If we want to guarantee uniqueness, we'd append a UUID to the
> > > subusername for the chown_subuser() call, and then for subsequent
> > > invocations read it with statx() (or subuser enabled equivalent)
> > > for the set_subuser() call.
> > > 
> > > Now firefox is running in a sandbox, where it has no access to
> > > the rest of your home directory - unless explicitly granted with
> > > normal ACLs. And the sandbox requires no system configuration; rm
> > > -rfing the .local/state/firefox directory cleans everything up.
> > > 
> > > And these trivially nest: Firefox itself wants to sandbox
> > > individual tabs from each other, so firefox could run each sub-
> > > process as a different subuser.
> > > 
> > > This is dead easy compared to what we've been doing.
> > 
> > The above is the unprivileged use case.  It works, but it's not all
> > we have to support.
> 
> There is only one root user, in the sense of _actual_ root -
> CAP_SYS_ADMIN and all that.

No, that's not correct.  CAP_SYS_ADMIN is replaced by ns_capable() for
the user namespace.  The creating entity of the userns becomes the ID
for which ns_capable() returns true.  The whole goal of deprivileging
containers is to get the container root to seem like it has
CAP_SYS_ADMIN but in fact it's only ns_capable().  Certain features
which are allowed to the userns admin (like filesystem mappings of
inner root) are policy decisions the root namespace admin needs to
make.

> > 
> > > > > > However, neither proposal would get us out of the problem
> > > > > > of mount mapping because we'd have to keep the filesystem
> > > > > > permission check on the owning uid unless told otherwise.
> > > > > 
> > > > > Not sure I follow?
> > > > 
> > > > Mounting a filesystem inside a userns can cause huge security
> > > > problems if we map fs root to inner root without the admin
> > > > blessing it.  Think of binding /bin into the userns and then
> > > > altering one of the root owned binaries as inner root: if the
> > > > permission check passes, the change appears in system /bin.
> > > 
> > > So with this proposal mount mapping becomes "map all users on
> > > this filesystem to subusers of username x". That's a much simpler
> > > mapping than mapping integer ranges to integer ranges, much
> > > easier to verify that there aren't accidental root escpes.
> > 
> > That doesn't work for the privileged container run in unprivileged
> > userns containment use case because we need a mapping from inner to
> > outer root.
> 
> I can't parse this. "Privileged container in an unprivileged
> containment"? Do you just mean a container that has root user (which
> is only root over that container, not the rest of the system, of
> course).

A privileged container is one that has services that run as root, yes.

> Any user is root over its subusers - so that works perfectly.

That's only one aspect of what container root might need to be able to
do.

> Or do you mean something else by "privileged container"? Do you mean
> a container that actually has CAP_SYS_ADMIN?

That's what docker currently does when it creates a privileged
container, yes.  However, CAP_SYS_ADMIN is too powerful and can
trivially break containment meaning this isn't a workable solution for
container security.  What we need is a container that can bring up
privileged services without root namespace CAP_SYS_ADMIN.

> 
> > > > > And it wouldn't have to be administrator assigned. Some
> > > > > administrator assignment might be required for the username
> > > > > <-> 16 bit uid mapping, but if those mappings are ephemeral
> > > > > (i.e. if we get filesystems persistently storing usernames,
> > > > > which is easy enough with xattrs) then that just becomes
> > > > > "reserve x range of the 16 bit uid space for ephemeral
> > > > > translations".
> > > > 
> > > > *if* the user names you're dealing with are all unprivileged. 
> > > > When we have a mix of privileged and unprivileged users owning
> > > > the files, the problems begin.
> > > 
> > > Yes, all subusers are unprivilidged - only one username, the
> > > empty username (which we'd probably map to root) maps to existing
> > > uid 0.
> > 
> > But, as I said above, that's only a subset of the use cases.  The
> > equally big use case is figuring out how to run privileged
> > containers in a deprivileged mode and yet still allow them to
> > update images (and other things).
> 
> If you're running in a userns, all your mounts get the same user
> mapping as your userns - where that usermapping is just prepending
> the username of the userns. That part is easy.

No, it's not.  Any filesystem that's specific *only* to the container
can do an inner root to real root mapping.  Any bind mount visible from
outside can't be allowed to do this because of the suid security issue
above.  Determining this "visibility" is really hard, which is why it's
become a policy based mapping controlled by the root namespace admin.

> The big difficulty with letting them update images is that our
> current filesystems really aren't ready for the mounting of untrusted
> images - they're ~100k loc codebases each and the amount of hardening
> required is significant. I would hazard to guess that XFS is the
> furthest along is this respect (from all the screaming I hear from
> Darrick about syzkaller it sounds like they're taking this the most
> seriously) - but I would hesitate to depend on any of our filesystems
> to be secure in this respect, even my own - not until we get them
> rewritten in Rust...

This is a completely separate issue: whether we can allow an
unprivileged container to mount a fs image that might have been crafted
to attack the system.  Most FS developers believe we'll never achieve
the point where any specially crafted fs image is safe to mount  by an
unprivileged user so again whether the container is allowed to mount a
fs from a block or network device becomes a policy issue for the root
namespace admin rather than something we can globally allow.

James


