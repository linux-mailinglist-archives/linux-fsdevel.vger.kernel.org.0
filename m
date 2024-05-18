Return-Path: <linux-fsdevel+bounces-19712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E34A8C90CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 14:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B4B1C2124C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 12:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE3B39FEF;
	Sat, 18 May 2024 12:26:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3602CCD0;
	Sat, 18 May 2024 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716035165; cv=none; b=d9yKua4XiH7ZdL/v7XQMMr8dFHbVeQ9w8Dbhv3RFjprnSegPfG/7x0jPV+OF1f3wFTtCozLxM9HSdqLFsXKH9qdCIVbBMbvvXw12aJIAObFLQu1nb0sjZ+8HWpSjPYqIUsbGx6L8L9Sn1h6mBLkiJsLkDeWGx0ScSTg1UCZsL8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716035165; c=relaxed/simple;
	bh=QcYD3TRVoSjH3YeusMUss8nu1WzsktIMJpe9lyI3rFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVDEfMhYMV/TTd950VVeZ59+7c6kLTKonAZQjzSdiKllzQujxD7IWm65AjId/UZX7UFUISQnzxrBO/e5sPbvYeW6wh9dp+Krj2X+DvjMmZEGzlZEVz8XT4m7q03giXNxLch2VTGSQNPHnxJ2QNkpUDU+roCP+EYwfFa2t2EZeV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Received: from serge-l-PF3DENS3 (216-177-171-48.block0.gvtc.com [216.177.171.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: serge)
	by mail.hallyn.com (Postfix) with ESMTPSA id CCF6C356;
	Sat, 18 May 2024 07:20:32 -0500 (CDT)
Date: Sat, 18 May 2024 07:20:30 -0500
From: Serge Hallyn <serge@hallyn.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jonathan Calmels <jcalmels@3xx0.net>,
	Jarkko Sakkinen <jarkko@kernel.org>, brauner@kernel.org,
	ebiederm@xmission.com, Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>, containers@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
	serge@hallyn.com
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
Message-ID: <ZkidDlJwTrUXsYi9@serge-l-PF3DENS3>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <2804dd75-50fd-481c-8867-bc6cea7ab986@schaufler-ca.com>
 <D1BBFWKGIA94.JP53QNURY3J4@kernel.org>
 <D1BBI1LX2FMW.3MTQAHW0MA1IH@kernel.org>
 <D1BC3VWXKTNC.2DB9JIIDOFIOQ@kernel.org>
 <jvy3npdptyro3m2q2junvnokbq2fjlffljxeqitd55ff37cydc@b7mwtquys6im>
 <df3c9e5c-b0e7-4502-8c36-c5cb775152c0@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df3c9e5c-b0e7-4502-8c36-c5cb775152c0@schaufler-ca.com>

On Fri, May 17, 2024 at 10:53:24AM -0700, Casey Schaufler wrote:
> On 5/17/2024 4:42 AM, Jonathan Calmels wrote:
> >>>> On Thu May 16, 2024 at 10:07 PM EEST, Casey Schaufler wrote:
> >>>>> I suggest that adding a capability set for user namespaces is a bad idea:
> >>>>> 	- It is in no way obvious what problem it solves
> >>>>> 	- It is not obvious how it solves any problem
> >>>>> 	- The capability mechanism has not been popular, and relying on a
> >>>>> 	  community (e.g. container developers) to embrace it based on this
> >>>>> 	  enhancement is a recipe for failure
> >>>>> 	- Capabilities are already more complicated than modern developers
> >>>>> 	  want to deal with. Adding another, special purpose set, is going
> >>>>> 	  to make them even more difficult to use.
> > Sorry if the commit wasn't clear enough.
> 
> While, as others have pointed out, the commit description left
> much to be desired, that isn't the biggest problem with the change
> you're proposing.
> 
> >  Basically:
> >
> > - Today user namespaces grant full capabilities.
> 
> Of course they do. I have been following the use of capabilities
> in Linux since before they were implemented. The uptake has been
> disappointing in all use cases.
> 
> >   This behavior is often abused to attack various kernel subsystems.
> 
> Yes. The problems of a single, all powerful root privilege scheme are
> well documented.
> 
> >   Only option
> 
> Hardly.
> 
> >  is to disable them altogether which breaks a lot of
> >   userspace stuff.
> 
> Updating userspace components to behave properly in a capabilities
> environment has never been a popular activity, but is the right way
> to address this issue. And before you start on the "no one can do that,
> it's too hard", I'll point out that multiple UNIX systems supported
> rootless, all capabilities based systems back in the day. 
> 
> >   This goes against the least privilege principle.
> 
> If you're going to run userspace that *requires* privilege, you have
> to have a way to *allow* privilege. If the userspace insists on a root
> based privilege model, you're stuck supporting it. Regardless of your
> principles.

Casey,

I might be wrong, but I think you're misreading this patchset.  It is not
about limiting capabilities in the init user ns at all.  It's about limiting
the capabilities which a process in a child userns can get.

Any unprivileged task can create a new userns, and get a process with
all capabilities in that namespace.  Always.  User namespaces were a
great success in that we can do this without any resulting privilege
against host owned resources.  The unaddressed issue is the expanded
kernel code surface area.

You say, above, (quoting out of place here)

> Updating userspace components to behave properly in a capabilities
> environment has never been a popular activity, but is the right way
> to address this issue. And before you start on the "no one can do that,
> it's too hard", I'll point out that multiple UNIX systems supported

He's not saying no one can do that.  He's saying, correctly, that the
kernel currently offers no way for userspace to do this limiting.  His
patchset offers two ways: one system wide capability mask (which applies
only to non-initial user namespaces) and on per-process inherited one
which - yay - userspace can use to limit what its children will be
able to get if they unshare a user namespace.

> > - It adds a new capability set.
> 
> Which is a really, really bad idea. The equation for calculating effective
> privilege is already more complicated than userspace developers are generally
> willing to put up with.

This is somewhat true, but I think the semantics of what is proposed here are
about as straightforward as you could hope for, and you can basically reason
about them completely independently of the other sets.  Only when reasoning
about the correctness of this code do you need to consider the other sets.  Not
when administering a system.

If you want root in a child user namespace to not have CAP_MAC_ADMIN, you drop
it from your pU.  Simple as that.

> >   This set dictates what capabilities are granted in namespaces (instead
> >   of always getting full caps).
> 
> I would not expect container developers to be eager to learn how to use
> this facility.

I'm a container developer, and I'm excited about it :)

> >   This brings namespaces in line with the rest of the system, user
> >   namespaces are no more "special".
> 
> I'm sorry, but this makes no sense to me whatsoever. You want to introduce
> a capability set explicitly for namespaces in order to make them less
> special?

Yes, exactly.

> Maybe I'm just old and cranky.

That's fine.

> >   They now work the same way as say a transition to root does with
> >   inheritable caps.
> 
> That needs some explanation.
> 
> >
> > - This isn't intended to be used by end users per se (although they could).
> >   This would be used at the same places where existing capabalities are
> >   used today (e.g. init system, pam, container runtime, browser
> >   sandbox), or by system administrators.
> 
> I understand that. It is for containers. Containers are not kernel entities.

User namespaces are.

This patch set provides userspace a way of limiting the kernel code exposed
to untrusted children, which currently does not exist.

> > To give you some ideas of things you could do:
> >
> > # E.g. prevent alice from getting CAP_NET_ADMIN in user namespaces under SSH
> > echo "auth optional pam_cap.so" >> /etc/pam.d/sshd
> > echo "!cap_net_admin alice" >> /etc/security/capability.conf.
> >
> > # E.g. prevent any Docker container from ever getting CAP_DAC_OVERRIDE
> > systemd-run -p CapabilityBoundingSet=~CAP_DAC_OVERRIDE \
> >             -p SecureBits=userns-strict-caps \
> >             /usr/bin/dockerd
> >
> > # E.g. kernel could be vulnerable to CAP_SYS_RAWIO exploits
> > # Prevent users from ever gaining it
> > sysctl -w cap_bound_userns_mask=0x1fffffdffff

