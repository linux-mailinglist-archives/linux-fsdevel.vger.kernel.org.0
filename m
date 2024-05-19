Return-Path: <linux-fsdevel+bounces-19719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8AB8C9346
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 03:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B3B1F214B7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 01:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003348BE8;
	Sun, 19 May 2024 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="LBQjTwYS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DWCOv+tG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow6-smtp.messagingengine.com (flow6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA839B;
	Sun, 19 May 2024 01:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716082121; cv=none; b=dhJXJtwRxX0PMqeehBIoikpEyygq6pUi+rRn3ztmsP6v/2swfBr8gY+IY60DN+YSgHUsC1m46ukzlPivoAi466YrqbpjEy7lghMt2Bi12egr7nZjrT3cjPZRwQVuQaIQAtDTK00t4DOIFMAeL45Os76czncyHsg8wZnVJpr5sk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716082121; c=relaxed/simple;
	bh=cx8p0aOrLv2aKH95V35JoNaCc3yz4DZ2hH/JWbzkDI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdaLxY9oY2AOek0aJ1swgEbuTDmHpr2tuN24hihKZEYYKP/tuq5jaqAl9Ttf6aTc4Xdll7yyc+mx3ag3Ss9HAuEpwyAtW52UbrP64bTlMMzhgDxLF6mu0PKEB3V8cloofrMOLFfJABYtRKc81HAJUAnO92/G0QxQAWCVA9RdYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=LBQjTwYS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DWCOv+tG; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailflow.nyi.internal (Postfix) with ESMTP id 9272720031D;
	Sat, 18 May 2024 21:28:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 18 May 2024 21:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716082118; x=1716085718; bh=okNdeP1Ev4
	hSO4ZAkeKtTmX/46s631+dJ7jzdCCcfBw=; b=LBQjTwYSdvWxEy5IFww/witrrq
	f2zthnzYB98kLozA7r0nGJJPOqFkmd8+O7xTujRohXJkGn4QHL0//h0jom2SHrlT
	kGS1fzNhTrNVEG6QKmHyxgYxFGkTRX4LKmVILsXNsFPLbYQ8oL8klyfVE51GxFwH
	91+VFOk8f8ChW5fgn1OCmRCnen6fzkCIWA3FMuGSCtOxpGNjL/nzDAmL7kM9eNCs
	lfwif7rtZayFkiEJbRUGwNdJU8vffhsUtYBG9wDUNVRA0t5kmRZmm7VhuD+LiUEt
	nvjA7AIKQ0qblHu/IHNcS1ui2BwYowDvaUVgJc3e/10jbXQTO8cer7m4Ls0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	i76614979.fm1; t=1716082118; x=1716085718; bh=okNdeP1Ev4hSO4ZAke
	KtTmX/46s631+dJ7jzdCCcfBw=; b=DWCOv+tGUkL/OxqC8+UmzU3Ust/5P3jJ5O
	pC2Umtldj+oCgfK+mqPhvZF7koo5yAVhfwcHI6rB/MFVMzrsEzR7ttp5uZh3TKSq
	mpbaLGIWQ1awSobD1os4Uq32YCMe0PoqQg3EvHuhGEL6svO6KRFgveyDWaOLVj1c
	a0isprNF7bEtsUG9MMe5GtJU6OmFveZhpa7andcVpohFezE/n1zdonoEz8D7Mddw
	zIJdXlNw44MNv+uKiQ4WTNQseY51GPtgK+K6YeqP8lrnof33THj+4PGF5VHYyYKH
	6sCw0w5s5l2PLeeNLkTXhiV7kSaWCUizJNr05LqHdJbEspxt7Njg==
X-ME-Sender: <xms:xVVJZv74evkjotdRBDX1zrz-PumOreh-i-IvvjVGffQkGOQu0y3ivA>
    <xme:xVVJZk5ULstTlD242G-3brBInrnxvME7tEwiaT6r_ypMywW5Y_5snCST5rVcPIPvz
    3Un7aRsqRHRbnWQV3M>
X-ME-Received: <xmr:xVVJZmdRwHVQfepxZ978pYHQ8-XIdewXzY0dL2xlZkxflW0hjQGNsKO6hhKlDtfvOJGXJrwAlGlplgRYOP7xoQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehjedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtjeenucfhrhhomheplfhonhgr
    thhhrghnucevrghlmhgvlhhsuceojhgtrghlmhgvlhhsseefgiigtddrnhgvtheqnecugg
    ftrfgrthhtvghrnhepkeekteegfefgvdefgfefffeufeffjedvudeijeehjeehffekjeek
    leffueelgffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhgtrghlmhgvlhhsseefgiigtddrnhgvth
X-ME-Proxy: <xmx:xVVJZgKf3I0H6Jn0qAQaigXjJvz3SfXRta1ugGWMqhPoFjHQfhyJcg>
    <xmx:xVVJZjJE5ytCRj7y5766qKnSNriYrsDxgpmPvST-0h76o_DwXkRB9w>
    <xmx:xVVJZpyRuzOf-lJ_Cjk8k6tbiWHDPj16hkdLYK642JjtZRLZoKFdNA>
    <xmx:xVVJZvK4HIJWvjuFlNfr6LvzXYoDnGwrJOGmkSH4anh1iVf_ktlGrw>
    <xmx:xlVJZiYZ_2usNuHhsJzmD3dcDmdtjx9hEZI9ANvSgQTZ82yq7TyvExAk>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 May 2024 21:28:35 -0400 (EDT)
Date: Sat, 18 May 2024 18:33:37 -0700
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
Message-ID: <aiqls6f5bte6ncoomz3etrzwtnq5tuznlaz66w7bvhrnmpgg6w@ahnsazch5gfo>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-2-jcalmels@3xx0.net>
 <641a34bd-e702-4f02-968e-4f71e0957af1@canonical.com>
 <jwuknxmitht42ghsy6nkoegotte5kxi67fh6cbei7o5w3bv5jy@eyphufkqwaap>
 <be62b80f-2e86-4cbc-82ce-c9f62098ef60@canonical.com>
 <txmrzwf2kr6devb5iqghctgvtbccjaspf44entk4fopjbaet2j@zqdfxiy6y6ej>
 <7f94cb03-d573-4cc5-b288-038e44bc1318@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f94cb03-d573-4cc5-b288-038e44bc1318@canonical.com>

On Sat, May 18, 2024 at 05:27:27AM GMT, John Johansen wrote:
> On 5/17/24 20:50, Jonathan Calmels wrote:
> > As mentioned above, userspace doesn't necessarily have to change. I'm
> > also not sure what you mean by easy to by-pass? If I mask off some
> > capabilities system wide or in a given process tree, I know for a fact
> > that no namespace will ever get those capabilities.
> 
> so by-pass will very much depend on the system but from a distro pov
> we pretty much have to have bwrap enabled if users want to use flatpaks
> (and they do), same story for several other tools. Since this basically
> means said tools need to be available by default, most systems the
> distro is installed on are vulnerable by default. The trivial by-pass
> then becomes the exploit running its payload through one of these tools,
> and yes I have tested it.
> 
> Could a distro disable these tools by default, and require the user/admin
> to enable them, yes though there would be a lot of friction, push back,
> and in the end most systems would still end up with them enabled.
> 
> With the capibilities approach can a user/admin make their system
> more secure than the current situation, absolutely.
> 
> Note, that regardless of what happens with patch 1, and 2. I think we
> either need the big sysctl toggle, or a version of your patch 3

Ah ok, I get you concerns. Unfortunately, I can't really speak for
distros or tooling about how this gets leveraged.
I've never claimed this was going to be bulletproof day 1.
All I'm saying is that they now have the option to do so.

As you pointed out, we're coming from a model where today it's open-bar.
Only now they can put a bouncer in front of it, so to speak :)

Regarding distros:

    Maybe they ship with an empty userns mask by default and admins have
    to tweak it, understanding full well the consequences of doing so.

    Maybe they ship with a conservative mask and use pam rules to
    adjust it.

    Maybe they introduce something like a wheel/sudo group that you need
    to be part of to gain extra privileges in your userns.

    Maybe only some system services (e.g. dockerd, lxd/incusd, machined)
    get confined.

    Maybe they need highly specific policies, and this is where you'll
    would want LSM support. Say an Apparmor profile targetting
    unshare(1) specifically.

Regarding tools:

    Maybe bwrap has its own group you need to be part of to get full
    caps.

    Maybe docker uses this set behind `--cap-add` `--cap-drop`.

    Maybe lxd/incusd imlement ACL restricting who can do what.

    Maybe steam always drops everything it doesn't need,

I'm sure this won't cover every single corner cases, but as stated in
the headline, this is a start, a simple framework we can always
extend if needed in the future.

