Return-Path: <linux-fsdevel+bounces-19729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E6E8C9796
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 02:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E209CB20DF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 00:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11087610B;
	Mon, 20 May 2024 00:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="klpf68pR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eSww0ioe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wflow3-smtp.messagingengine.com (wflow3-smtp.messagingengine.com [64.147.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F544431;
	Mon, 20 May 2024 00:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716166174; cv=none; b=cIKujs99xzhrh3EBUvYH0EOHVeXo6uEUQC9eVDXRX2fg8pQ7OvipksMqarb/YTkhWewhSGk4WmpGcXlPDXas6QnPsgWgnAg593L5H2Jjs6XkyjARDAfM6PAokrinilIZBgqQDxGkYHJLaZ926GYfdWKiD99lpAGdR96poghMNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716166174; c=relaxed/simple;
	bh=CyRV9ILozf4Lntq5G/bNlTgHb6HrAA/zKXB/WqFeBT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBf6yj8lCYIfx7dvWnNFqGWvS9XIa2VwnU8F4fGDkizLR54li8rm4GwM1M9Y+nQ5g31LGEnPivuA4Pm1uGi2tsldyEWwehs/a0oGX0rOQ5j5C0+1kHT0ibwwOvtqE25HxkAhOzEo6463EDZZrx64Tvee1G6MlYC8dCwxthD/6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=klpf68pR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eSww0ioe; arc=none smtp.client-ip=64.147.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.west.internal (Postfix) with ESMTP id B54C52CC015A;
	Sun, 19 May 2024 20:49:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 19 May 2024 20:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716166170; x=1716169770; bh=CyRV9ILozf
	4Lntq5G/bNlTgHb6HrAA/zKXB/WqFeBT4=; b=klpf68pR983Umz/iMgT4y+ak04
	n8kwlI8xnnbrnJaKaPnN8jzHHCo870IYXfQdY5ovbS5nfN8+SoAyY1omj9fYWYxy
	9h9hZGEUAWUNMpao+N0biLGN9dU7EiGBneK0jiTywGV0Td0bREhUOpNmsYWCabOD
	KgLdZgCbLsgq9pbhd+cfZYVkecyFKBqAv1NxWcrxpYiAFyhJ2MIxpCX3MFWD4hFG
	leq5CoxnGSkT1yVtIiALfsBK14Bz6uRkvoFCEW/ZIeuoWpOw48FyS28BWCnWN+Zp
	ykXXRqXE2kFJSHpFwfhRAmo8mmxSL3q6OZOFNt7IhKLWnughIBAmhqJtX+1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	i76614979.fm1; t=1716166170; x=1716169770; bh=CyRV9ILozf4Lntq5G/
	bNlTgHb6HrAA/zKXB/WqFeBT4=; b=eSww0ioeIWbQ0Sk25DnYNgGXUAyXLvIvxl
	KsVsfen8yaGLUrUGKnsSVL9xuDZ8WH3zrh+L9Oh+3oCouC/+/GyrltOWzFQSr9VN
	+FzrjWTZU4FzaNNNtaPLsX5sOLezJMQ3nEIkPaQkj+QHjJnQGvcBtvZL44ADt8N/
	e93HP14LmO5DN8yIlOr0bbD4IdQu9Q8QFtzCAUATUsjayWibc+mF6c0au/88nmm4
	u1IC/k7OIXYQnw71EsRdiOCgw2Ze+UpI/lgIW9F8w/3FvXPIoBZCJo4TwXi7PzWj
	xRq3z5k3k9ND/dZ0AcRDdhRQV7ZbN9Bge4W08KhAtCt8lrojJmzQ==
X-ME-Sender: <xms:GJ5KZqRwF-Hmrd_yns_Mk6Mx7Xd4pz1klZb8lQd5YR1_KVDVtqzWVA>
    <xme:GJ5KZvxpVD0vBJtI6bIvKlzINXnQlBMjfmffdDJ3fjqPTv539QfgCn6-l3CfL49Kg
    PniH2dcBJXyVAHmQNc>
X-ME-Received: <xmr:GJ5KZn3g2SePJsmPjv_lL1o9JiTGL3jepRa2FNBvw3l_7BFIYW9-HBms3Mv9trDWGvoA22v28letiaQsofVjBk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehledgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtjeenucfhrhhomheplfhonhgr
    thhhrghnucevrghlmhgvlhhsuceojhgtrghlmhgvlhhsseefgiigtddrnhgvtheqnecugg
    ftrfgrthhtvghrnhepkeekteegfefgvdefgfefffeufeffjedvudeijeehjeehffekjeek
    leffueelgffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhgtrghlmhgvlhhsseefgiigtddrnhgvth
X-ME-Proxy: <xmx:GJ5KZmBPlFW2A-8gZTo0fZw_4OAm5z68khPRoHSXKN0PpurrtTYZbQ>
    <xmx:GJ5KZjjQOVhrXpqMIu3qX8sA9OHU9wc-gzKYThConkTcb7Hv3agYMA>
    <xmx:GJ5KZiqUNoZd9eA-_Koz0muherzhe6-eI1CqTzfbj729hJJ64GC9BQ>
    <xmx:GJ5KZmhjsKPJdXKBIG_jz_nLPQfr4LYRx_iGFZJREt9FKM_xhsv3zg>
    <xmx:Gp5KZuQ8e6YZc8xP1W7wHecBEsVSVBdrx2L-LybB3XCoxVjdDmmvGXj_>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 20:49:27 -0400 (EDT)
Date: Sun, 19 May 2024 17:54:29 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Serge Hallyn <serge@hallyn.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	brauner@kernel.org, ebiederm@xmission.com, Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Joel Granados <j.granados@samsung.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, containers@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
Message-ID: <r44h5pcqg7rh6sbd2yohjrqz2lwaakth7bshmu6qnut3mju6tl@tb5hsz5cdc42>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <2804dd75-50fd-481c-8867-bc6cea7ab986@schaufler-ca.com>
 <D1BBFWKGIA94.JP53QNURY3J4@kernel.org>
 <D1BBI1LX2FMW.3MTQAHW0MA1IH@kernel.org>
 <D1BC3VWXKTNC.2DB9JIIDOFIOQ@kernel.org>
 <jvy3npdptyro3m2q2junvnokbq2fjlffljxeqitd55ff37cydc@b7mwtquys6im>
 <df3c9e5c-b0e7-4502-8c36-c5cb775152c0@schaufler-ca.com>
 <ZkidDlJwTrUXsYi9@serge-l-PF3DENS3>
 <799f3963-1f24-47a1-9e19-8d0ad3a49e45@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <799f3963-1f24-47a1-9e19-8d0ad3a49e45@schaufler-ca.com>

On Sun, May 19, 2024 at 10:03:29AM GMT, Casey Schaufler wrote:
> I do understand that. My objection is not to the intent, but to the approach.
> Adding a capability set to the general mechanism in support of a limited, specific
> use case seems wrong to me. I would rather see a mechanism in userns to limit
> the capabilities in a user namespace than a mechanism in capabilities that is
> specific to user namespaces.

> An option to clone() then, to limit the capabilities available?
> I honestly can't recall if that has been suggested elsewhere, and
> apologize if it's already been dismissed as a stoopid idea.

No and you're right, this would also make sense. This was considered as
well as things like ioctl_ns() (basically introducing the concept of
capabilities in the user_namespace struct). I also considered reusing
the existing sets with various schemes to no avail.

The main issue with this approach is that you've to consider how this is
going to be used. This ties into the other thread we've had with John
and Eric.
Basically, we're coming from a model where things are wide open and
we're trying to tighten things down.

Quoting John here:

> We are starting from a different posture here. Where applications have
> assumed that user namespaces where safe and no measures were needed.
> Tools like unshare and bwrap if set to allow user namespaces in their
> fcaps will allow exploits a trivial by-pass.

We can't really expect userspace to patch every single userns callsite
and opt-in this new security mechanism.
You said it well yourself:

> Capabilities are already more complicated than modern developers
> want to deal with.

Moreover, policies are not necessarily enforced at said callsites. Take
for example a service like systemd-machined, or a PAM session. Those
need to be able to place restrictions on any processes spawned under
them.

If we do this in clone() (or similar), we'll also need to come up with
inheritance rules, being able to query capabilities, etc.
At this point we're just reinventing capability sets.

Finally the nice thing about having it as a capability set, is that we
can easily define rules between them. Patch 2 is a good example of this.
It constrains the userns set to the bounding set of a task. Thus,
requiring minimal/no change to userspace, and helping with adoption.

> Yes, I understand. I would rather see a change to userns in support of a userns
> specific need than a change to capabilities for a userns specific need.

Valid point, but at the end of the day, those are really just tasks'
capabilities. The unshare() just happens to trigger specific rules when it
comes to the tasks' creds. This isn't so different than the other sets
and their specific rules for execve() or UID 0.

This could also be reframed as:

Why would setting capabilities on taks in a userns be so different than
tasks outside of it?

