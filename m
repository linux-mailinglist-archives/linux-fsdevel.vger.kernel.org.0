Return-Path: <linux-fsdevel+bounces-19704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A608C8F85
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 05:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB74F281BAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 03:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88E39479;
	Sat, 18 May 2024 03:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="PfbwnRX1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XVmcKXT6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wflow5-smtp.messagingengine.com (wflow5-smtp.messagingengine.com [64.147.123.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BC13211;
	Sat, 18 May 2024 03:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716003950; cv=none; b=SXj4QSo2lWFgbOuj9L8GnX+fvMwPmjygZ12lAFs9VxdSqXOpsiV3vk/+mK760xGUqUCUOctaT9DGluhvEk1zyDWaJsmprjita4YbJzcIXi9Te50iN3MR+6j1483vUOM6tQ7dgIlMC1UdocAcOKkw4JvB318KlgMHUkgijUvKj2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716003950; c=relaxed/simple;
	bh=H1m1BdyUYMgwN+gwfrLcTxNjvn3olpd7tI3HsAPsK+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS7y5mr2ACtbU38SayLK6U/WGHzICjsUu++giDHk+9PlQ7R88cQRfq4M62fd86Ve7MrldQjESWOHWtdKrAGPzYBpBHRaFsY9NB5ZLqwlbnBS+cCycy5XCrjgljJ2uP6xX8JuuAdt2HvntSL0r+onGOkUwlQAIR6+3tHZBrRCXVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=PfbwnRX1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XVmcKXT6; arc=none smtp.client-ip=64.147.123.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.west.internal (Postfix) with ESMTP id 5A6EC2CC01C3;
	Fri, 17 May 2024 23:45:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 17 May 2024 23:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1716003945;
	 x=1716007545; bh=mN/nOIaCP/p4knGv1KO/mi3cVs62suSyg3pHjkgg3xs=; b=
	PfbwnRX1H7+B0eEZM5atZ3/BupSoiPRP2QN1Fzdl8460Zh+KtowYd6kx6xEHiMUd
	tGG4Z9Q8lYvH1SS9Vjh7mmocTg78KO9rU2Nn+L2eyabVn7waMpoEZHQAiXhgcU93
	tyudGA8LyQrtbAO4dy7WIyoYKE1tHn3bOfiGJqM/Oc2QSDeWIx3oZIjKMK9DjKAI
	sZqMbOe/Ewev3G8h8GONdtU8E2aJ/NlrW1NNo3AwrxT/6f/5jMdRVYVKT0u28KKB
	nm9EqDaoJK97qW+mHQEY90pg1INCGPIc5YLZx0/weFvne5tRVFEZ4ACU8zXHxbZJ
	09S3wHDkE1hHBpRjMJGAfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=i76614979.fm3; t=
	1716003945; x=1716007545; bh=mN/nOIaCP/p4knGv1KO/mi3cVs62suSyg3p
	Hjkgg3xs=; b=XVmcKXT6/Uqc/axLHs/Be2s4ob1FeombGH2tcHDZ4LoR4ubGMzU
	Nobhx7kyD7uJHoukOgow3HZP/Rgo3Ee1m3nCY0jxQOsm7e2+B6iTCH2iFfwu2OQ0
	60qzffYuMQQ50fgjpHmJGuMmHNkosMsTLlne8uxRJJP2aJWRADbRTz8zeec6Z2bR
	rtqwJ13Y2QFbWcsR8DJZFLBKNaIjToiK7bCgUcV/ai1uznq0RwHaiUr3VDiMKHJv
	NPALjmjTkBNi7rpO0M53C5lVoAAf5ZjssKMLwb2t9KsQPxSovb48Yr2zbqkrrTjC
	eeAffoxIq5K4388i8cAUJDDxXGycVKDYP5w==
X-ME-Sender: <xms:aCRIZkYjbS2FMAEw_56pJYTKqDblmgVDVmJJXAz-SzHrzSRE5uGwng>
    <xme:aCRIZvYEp-Wq5-1gwv2N33xPGI4PtHUHIWkZvIND1VLoajzOAKolQkiyezAPhpEGT
    L3PgvQwTWH8sI7bJUw>
X-ME-Received: <xmr:aCRIZu94urRFq1J7-RSFtqJUJmKlBjY8Z8Wxf5mPVNPmwBRiZaqlF4X8OT6zeKD8P_TfYpFI39vfj9f7YNIOIZ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehhedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeflohhn
    rghthhgrnhcuvegrlhhmvghlshcuoehjtggrlhhmvghlshesfeiggidtrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeehleehvedtuedvffffgeegvedvleeufefgheduleefueejtddt
    jeejffdujeeuffenucffohhmrghinhepphgrmhgptggrphdrshhonecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgtrghlmhgvlhhsseefgiig
    tddrnhgvth
X-ME-Proxy: <xmx:aCRIZuqjQ38gW3pwfIL1G8-7-rh6DFFJNQ9iuEiC3TZII5cVJtgRhg>
    <xmx:aCRIZvrKDDlaEws4P910ZoLdIVpRhU3oRK9ed-KWeyv2KAwWxZX-Xw>
    <xmx:aCRIZsSkLTSVZM8QhagW-Zyy_Md8NVSRbNCp28ZIBOB6qptmSabKNA>
    <xmx:aCRIZvrQxIi--iEzxtuhMKH8MZxAvqY7HCyQJuBytasQkSDkOS8UWA>
    <xmx:aSRIZo4u2r5-Hc0KR70eTsNpDM2lUCAZgHdSGbts-1zWNoxWBwlhf72a>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 23:45:42 -0400 (EDT)
Date: Fri, 17 May 2024 20:50:44 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: John Johansen <john.johansen@canonical.com>
Cc: brauner@kernel.org, ebiederm@xmission.com, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Joel Granados <j.granados@samsung.com>, Serge Hallyn <serge@hallyn.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, containers@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 1/3] capabilities: user namespace capabilities
Message-ID: <txmrzwf2kr6devb5iqghctgvtbccjaspf44entk4fopjbaet2j@zqdfxiy6y6ej>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-2-jcalmels@3xx0.net>
 <641a34bd-e702-4f02-968e-4f71e0957af1@canonical.com>
 <jwuknxmitht42ghsy6nkoegotte5kxi67fh6cbei7o5w3bv5jy@eyphufkqwaap>
 <be62b80f-2e86-4cbc-82ce-c9f62098ef60@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be62b80f-2e86-4cbc-82ce-c9f62098ef60@canonical.com>

On Fri, May 17, 2024 at 04:59:41AM GMT, John Johansen wrote:
> On 5/17/24 03:51, Jonathan Calmels wrote:
> > This new capability set would be a universal thing that could be
> > leveraged today without modification to userspace. Moreover, it’s a
> > simple framework that can be extended.
> 
> I would argue that is a problem. Userspace has to change for this to be
> secure. Is it an improvement over the current state yes.

Well, yes and no. With those patches, I can lock down things today on my
system and I don't need to change anything.

For example I can decide that none of my rootless containers started
under SSH will get CAP_NET_ADMIN:

# echo "auth optional pam_cap.so" >> /etc/pam.d/sshd
# echo "!cap_net_admin $USER"     >> /etc/security/capability.conf
# capsh --secbits=$((1 << 8)) -- -c /usr/sbin/sshd

$ ssh localhost 'unshare -r capsh --current'
Current: =ep cap_net_admin-ep
Current IAB: !cap_net_admin

Or I can decide than I don't ever want CAP_SYS_RAWIO in my namespaces:

# sysctl -w cap_bound_userns_mask=0x1fffffdffff

This doesn't require changes to userspace.
Now, granted if you want to have finer-grained controls, it will require
*some* changes in *some* places (e.g. adding new systemd property like
UserNSSet=).

> > Well that’s the thing, from past conversations, there is a lot of
> > disagreement about restricting namespaces. By restricting the
> > capabilities granted by namespaces instead, we’re actually treating the
> > root cause of most concerns.
> > 
> no disagreement there. This is actually Ubuntu's posture with user namespaces
> atm. Where the user namespace is allowed but the capabilities within it
> are denied.
> 
> It does however when not handled correctly result in some very odd failures
> and would be easier to debug if the use of user namespaces were just
> cleanly denied.

Yes but as we established it depends on the use case, both are not
mutually exclusive.

> its not so much the capabilities set as the inheritable part that is
> problematic. Yes I am well aware of where that is required but I question
> that capabilities provides the needed controls here.

Again, I'm not opposed to doing this with LSMs. I just think both could
work well together. We already do that with standard capabilities vs
LSMs, both have their strength and weaknesses.

It's always a tradeoff, do you want a setting that's universal and
coarse, or do you want one that's tailored to specific things but less
ubiquitous.

It's also a tradeoff on usability. If this doesn't get used in practice,
then there is no point.
I would argue that even though capabilities are complicated, they are
more widely understood than LSMs. Are capabilities insufficient in
certain scenarios, absolutely, and that's usually where LSMs come in.

> > This is possible with the security bit introduced in the second patch.
> > The idea of having those separate is that a service which has dropped
> > its capabilities can still create a fully privileged user namespace.
> 
> yes, which is the problem. Not that we don't do that with say setuid
> applications, but the difference is that they were known to be doing
> something dangerous and took measures around that.
> 
> We are starting from a different posture here. Where applications have
> assumed that user namespaces where safe and no measures were needed.
> Tools like unshare and bwrap if set to allow user namespaces in their
> fcaps will allow exploits a trivial by-pass.

Agreed, but we can't really walk back this decision unfortunately.
At least with this patch series system administrators have the ability
to limit such tools.

> What I was trying to get at is two points.
> 1. The written description wasn't clear enough, leaving room for
>    ambiguity.
> 2. That I quest that the behavior should be allowed given the
>    current set of tools that use user namespaces. It reduces exploit
>    codes ability to directly use unprivileged user namespaces but
>    makes it all to easy to by-pass the restriction because of the
>    behavior of the current tool set. ie. user space has to change.

> But again, I believe the fcaps behavior is wrong, because of the state of
> current software. If this had been a proposal where there was no existing
> software infrastructure I would be starting from a different stance.

As mentioned above, userspace doesn't necessarily have to change. I'm
also not sure what you mean by easy to by-pass? If I mask off some
capabilities system wide or in a given process tree, I know for a fact
that no namespace will ever get those capabilities.

