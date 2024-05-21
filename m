Return-Path: <linux-fsdevel+bounces-19900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9748CB07E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247F3285C68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048E913048E;
	Tue, 21 May 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="Z0k2WDlB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l/CTsexC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171612F392;
	Tue, 21 May 2024 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301785; cv=none; b=utmNFzOnQwMzOWEVWSFxgJRNJb8WmwT4rZns/S4TdqiqBlPIkr/jwwBB96iD7Cn1IC5/gQdeds004zaWTh/kjQ0xJdttXHr+cL4i2JMTMdhl7qWo4qWqwyoDXAFqFmCnvFPfYo+0C0otTLVqAQZ1TgwJb3uowHmDIvMf0IHY+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301785; c=relaxed/simple;
	bh=WeOEdQcoOh5D+TLCdjzZgp7upsvhmMlHiaHH2f4LL0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tp/6iYJnDtiLhrtMqZGutj4z6AM424YDdQvIxDdpolSAIzaaOIsrtnGMz5MAwzk+iKq9fZ4IgMJ16oIpZhPrsh3pjzawkKg0KjFQLCTtTJNLoJUzV2HHS2S9l5vUuPmvu/skleZcngjFm+ta/JLQFEpTPdrV9OxaK/nREabt9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=Z0k2WDlB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l/CTsexC; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1B42713823A7;
	Tue, 21 May 2024 10:29:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 21 May 2024 10:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716301782; x=1716388182; bh=WJ35C0s9XR
	fN9d5AhSx5pIlmDJ+UA3xXuY4ZoQb5kZo=; b=Z0k2WDlBPJtbEv8GPwr8FfsyP4
	pJIeCQNKqQIjkDgQKPtUeaot8Pa9gvdxffAqSAkli+e3b01EzrsLWuI6PMyKiE4c
	u6ZiQUJCiNs8hAOEcNYTGOMw3oy1T3bHaXKPjLpyb936Rw+p/9Kc4XB4MnM3QEcP
	xCTajLQP3xzzgNFnPQwbwDRe74eLaYuPnOCQFAeWl7sPH3MOFsiYcL6Kqgp0fVnO
	HxOIVt6Il7I85Md8cCWoIu3BbCmhVwcMZTGsFfaXecEmyHloVLAuU9P72nf8IviP
	aDXgTyShVvSa8nl7X2EjgZKUkkMkpXu6oBWFzEmWc0fNe/nNqBRnilIp/ELw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716301782; x=1716388182; bh=WJ35C0s9XRfN9d5AhSx5pIlmDJ+U
	A3xXuY4ZoQb5kZo=; b=l/CTsexCnzGBBlebi1q7RXHziELQNQRDxqaLaNkSB8OZ
	B1baizheqyfBAnopypCbi3ckVVoqwA89iczj1AruP+JzU7dhtJEq1wP0Ms85aUjp
	uswnR6O4y4CpEK1MYjM4z2GtAz9fFKAFBSw695RPLS0ZwEP52I48DxnbmZYxEWs3
	cT3MbpiAB7y7F4DGYrURp8Und9+PRCTO7i/HDhZ7f8R74oTEB+9kqStV4EwExeJt
	wNe3vVja8pi2dLUfGEH4CUHOhIJpSy/bV9vzVd3+Io2PPnR/wjxNCbWb/5k0oeJW
	OFNO70BB8+8XfZN9Rm37KlcZisyjD6yoFzR26XD1Hg==
X-ME-Sender: <xms:1a9MZiNsgGjrDfCMxfBDrw6nSfmX-QIMHhGgL3K247l8R5mUi6_ZwA>
    <xme:1a9MZg-ZDzLSFLZzi8tI3UMToKyCR9ZRhfxtJaJtb_RAZKqehDgAtqGU7TGU7AGFe
    UQhKIjOfs0VlAG2xPs>
X-ME-Received: <xmr:1a9MZpT9W2diIVdzR2Sv2TAKnkE-Y2hXlWXdeRn9TW9gasbBaFM4mYoiKRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeivddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:1a9MZitcUQnNB3M_IrtoDN8gDR1y1Nfy0EpUn1Aspl-U4K7hoAhGyw>
    <xmx:1a9MZqekWo7gkGiEkZed-8sCNf9dEGcL577bFKbmgv_-Wi0LtEsLMg>
    <xmx:1a9MZm3BYCnCSWWYMp5mVZNIVsPIUwkeljr-F4kHaJ6JfyuYxY-vhQ>
    <xmx:1a9MZu_aE9XQsdxTzs6Z1eTPNqfiB1GbBjGoFzsyaHssupudRQWTVg>
    <xmx:1q9MZtuk9PJLI2PmPy-tjTOwp4g-7oCs77FEYQyR5lnd37v3IGhJoP0g>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 10:29:38 -0400 (EDT)
Date: Tue, 21 May 2024 08:29:35 -0600
From: Tycho Andersen <tycho@tycho.pizza>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan Calmels <jcalmels@3xx0.net>, brauner@kernel.org,
	ebiederm@xmission.com, Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>, containers@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 3/3] capabilities: add cap userns sysctl mask
Message-ID: <Zkyvz122pigJGgEw@tycho.pizza>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-4-jcalmels@3xx0.net>
 <ZktQZi5iCwxcU0qs@tycho.pizza>
 <ptixqmplbovxmqy3obybwphsie2xaybfj46xyafdnol7bme4z4@4kwdljmrkdpn>
 <Zku8839xgFRAEcl+@tycho.pizza>
 <D1ETFJFE9Y48.1T8I7SIPGFMQ2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1ETFJFE9Y48.1T8I7SIPGFMQ2@kernel.org>

On Tue, May 21, 2024 at 01:12:57AM +0300, Jarkko Sakkinen wrote:
> On Tue May 21, 2024 at 12:13 AM EEST, Tycho Andersen wrote:
> > On Mon, May 20, 2024 at 12:25:27PM -0700, Jonathan Calmels wrote:
> > > On Mon, May 20, 2024 at 07:30:14AM GMT, Tycho Andersen wrote:
> > > > there is an ongoing effort (started at [0]) to constify the first arg
> > > > here, since you're not supposed to write to it. Your usage looks
> > > > correct to me, so I think all it needs is a literal "const" here.
> > > 
> > > Will do, along with the suggestions from Jarkko
> > > 
> > > > > +	struct ctl_table t;
> > > > > +	unsigned long mask_array[2];
> > > > > +	kernel_cap_t new_mask, *mask;
> > > > > +	int err;
> > > > > +
> > > > > +	if (write && (!capable(CAP_SETPCAP) ||
> > > > > +		      !capable(CAP_SYS_ADMIN)))
> > > > > +		return -EPERM;
> > > > 
> > > > ...why CAP_SYS_ADMIN? You mention it in the changelog, but don't
> > > > explain why.
> > > 
> > > No reason really, I was hoping we could decide what we want here.
> > > UMH uses CAP_SYS_MODULE, Serge mentioned adding a new cap maybe.
> >
> > I don't have a strong preference between SETPCAP and a new capability,
> > but I do think it should be just one. SYS_ADMIN is already god mode
> > enough, IMO.
> 
> Sometimes I think would it make more sense to invent something
> completely new like capabilities but more modern and robust, instead of
> increasing complexity of a broken mechanism (especially thanks to
> CAP_MAC_ADMIN).
> 
> I kind of liked the idea of privilege tokens both in Symbian and Maemo
> (have been involved professionally in both). Emphasis on the idea not
> necessarily on implementation.
> 
> Not an LSM but like something that you could use in the place of POSIX
> caps. Probably quite tedious effort tho because you would need to pull
> the whole industry with the new thing...

And then we have LSM hooks, (ns_)capable(), __secure_computing() plus
a new set of hooks for this new thing sprinkled around. I guess
kernel developers wouldn't be excited about it, let alone the rest of
the industry :)

Thinking out loud: I wonder if fixing the seccomp TOCTOU against
pointers would help here. I guess you'd still have issues where your
policy engine resolves a path arg to open() and that inode changes
between the decision and the actual vfs access, you have just changed
the TOCTOU.

Or even scarier: what if you could change the return value at any
kprobe? :)

Tycho

