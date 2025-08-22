Return-Path: <linux-fsdevel+bounces-58781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D825BB316DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2A3B01638
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C284D28AB1E;
	Fri, 22 Aug 2025 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="6P8oBcT2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="El9pqWkU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9494A17B402
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864200; cv=none; b=uTwVr2of+xkiPBZ3dtjP19EWWCF7YilLj5p32XO7jTP7APvKh6qsjmpFYDKW6KzaoThnt87Vmc0W5JT5DwgPOrjZa1rwKpkA009uYUd9TGOO8y753RVq/VBrixhVFP2dUMX8jgVKjBGAHP0KhmHsOUWH+KjX8dRY/rukHPWrdS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864200; c=relaxed/simple;
	bh=8lgAd5vyyWTcwHr7084ZIO+LBkWU2qgpnRjFcZD7Gco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4s1WDHGBivEKo8rM0plbuXxXSF660reaZVA+5As8+7yPXduL8cSYWgVYJkeg/kDhzFBrfB0TYC9h6xwM4ID3K3ZuY2tY25MzsjSTWcoQw2bWUEn+4cXt/j6ZqogDmp5I87dY2ZRrwxSAIApo8RXy5H6JAmWreCyHE2QLClD2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=6P8oBcT2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=El9pqWkU; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 82C287A0092;
	Fri, 22 Aug 2025 08:03:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 22 Aug 2025 08:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755864196;
	 x=1755950596; bh=cEEPRIBWy9/8u3eeW7uLIZrfX/pjIbJxcEgs6t8llQI=; b=
	6P8oBcT2tyKD6NoheNsrhCv/PLjwRNNHgynwlLt3a/tW7eDV6FGNwwm8vIm/yqsc
	tPO9DM7HNXfLKDRYtFstXefz2mCIawifCk4/3feKfSCgf87yRQPeul6usjTyS2lj
	wxu8RdRxZg25gBd3NAeJfGap4k1rSbGPQ4teGC6RdHxciSsSpAn+06YyDN58VGWC
	Vhd6jHiwqimy/Cw3vhs98VKiM2zKKL87mzv7fJsX1bA0Y42cz4ztHWRgeYPhIF7u
	Y0Ydw/h2OFM/qF1Qb1+m4+X4n8sY4FMzS0HA1B+aJKN4VVosFGWimHDiPWUayfha
	2XxtkZdbpJx15pblNhwd7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755864196; x=
	1755950596; bh=cEEPRIBWy9/8u3eeW7uLIZrfX/pjIbJxcEgs6t8llQI=; b=E
	l9pqWkUgLBKuwY3x57OIc0ODDKvXDBUHdfZdQqohRQBqsTaaEF3d4TrsThLaY0p0
	j0hgwlPGqItxA9rXGND9fxriBbGKurjy8JhJot0D6RI0cHQh4cFGds4Ed1voy8wI
	T1R/WDhSVHpvzs6hSkMlZpOFZfyf20ZpSiP6uCJGoQi9v8AgDx6kh44bv0rrmtbo
	0OK+mPGnakHPQPKdvNAVusE+6ywkiP9zISyCGGL30FfBkfdwrRkfC4APrlekYpGA
	AS9aIxw5qdsgw0gJoVZa43FnByAZWRA8QHD3+mdGD7YGwdEP6PRUOZzCAiWRENn+
	OLdPUYg2HNPJBmDQ3Loug==
X-ME-Sender: <xms:hFyoaMWmXn8bcksfRCTDDKyETy0mT4aqWX5vfuq7Y4k7PYr2wcJeGw>
    <xme:hFyoaNfU21-hT1TWsYHznjjyDY4mh98KKk6TtBR0WjNo2qrmMOLBTsE9iRCZ7Bmqa
    8vGs4-oIDh0_A>
X-ME-Received: <xmr:hFyoaAJ_kwfA_DstAP57AnDHmzYog-FU9RJkGchzEpOW0uiTEPwVuWhhcNgBiZ9fDXAw-q66ZbCgWuz9qnOJiL4Y8ueOWq4QP-a09A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelheehud
    duueeggeejgfehueduffehveeukefgkeeufeeltdejteeiuedtkeekleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhgrmhgvshdrsghothhtohhmlhgvhieshhgrnhhsvghnphgrrhhtnhgvrhhshhhiph
    drtghomhdprhgtphhtthhopehthihtshhosehmihhtrdgvughupdhrtghpthhtohepkhhs
    uhhmmhhitheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqd
    hfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hFyoaKwPQRFLZpYBk0kOfBnaZIy88qvVSIVVe7yNedSGppn0MDk-SQ>
    <xmx:hFyoaGvq-XglLXIEirGk1Sx1fxXmrUzpxwIEmgfAQq2_MitYiC8iHg>
    <xmx:hFyoaNDtr7h6cMu7bxNb07ZNLU2uujR3xixxzFxuFlYZJH4fIJmluA>
    <xmx:hFyoaIEIHcbUlSUKB4cc8aUC23VM_qN4V_aaJQiIVj_7zFLwzfv27Q>
    <xmx:hFyoaLQiCrkLNPR0J2FcY3yuHh1IJSnUqklEUOlV70zQuwilPvCL5Mq3>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 08:03:15 -0400 (EDT)
Date: Fri, 22 Aug 2025 14:03:13 +0200
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Theodore Ts'o <tytso@mit.edu>, ksummit@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINER SUMMIT] Adding more formality around feature
 inclusion and ejection
Message-ID: <2025082202-lankiness-talisman-3803@gregkh>
References: <fc0994de40776609928e8e438355a24a54f1ad10.camel@HansenPartnership.com>
 <20250821203407.GA1284215@mit.edu>
 <940ac5ad8a6b1daa239d748e8f77479a140b050d.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <940ac5ad8a6b1daa239d748e8f77479a140b050d.camel@HansenPartnership.com>

On Fri, Aug 22, 2025 at 09:09:04AM +0100, James Bottomley wrote:
> So what I saw is that as developers exercised this and effectively
> disengaged unless directly attacked, it pretty much became all on Linus
> because no-one was left in the chain. This is precisely where I think
> we could do with an alternative mechanism.

You are implying here that we all just "ran away" and left Linus to hold
the bag here, which is NOT the case at all.  This specific issue has
been discussed to death in a lot of different threads, public and
private with lots of people involved and none of that would have been
any different had we had some sort of "process document" ahead of time.

So I don't think that attempting to codify the very rare occurances like
this is going to really help out much, given that they are all unique to
their time/place/subsystem based on our past history like this.

> > Now, the above is inherently very messy.  But fortunately, it's only
> > happened once in thirty five years, and before we propose to put some
> > kind of mechanism in place, we need to make sure that the side
> > effects of that mechanism don't end up making things worse off.
> 
> Well, what we ended up with is one person in the chain (Linus), no
> actual decision except a failed pull request and nothing actually said
> which has lead to a raft of internet speculation.

It's not our job to quell "internet speculation", sorry.  Just because
we normally work in public for almost everything, doesn't mean that some
things can't be done in private as well.  And again, just because you
haven't seen a public decision doesn't mean that there hasn't been one
made :)

sorry,

greg k-h

