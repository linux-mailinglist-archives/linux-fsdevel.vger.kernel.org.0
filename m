Return-Path: <linux-fsdevel+bounces-19695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCDE8C8C97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 21:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D0AB23C86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 19:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B19413E890;
	Fri, 17 May 2024 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="nk1YlmOw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GuOIWxak"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow4-smtp.messagingengine.com (flow4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAF56A005;
	Fri, 17 May 2024 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972817; cv=none; b=apw6ydUW7H+rScpL8+9/y/Gcl99LZ0wFPKxsnhXws7hURA630rv25HLuvXbQU2vdA5vOM5i12j6uEISyNbzfyIHVlKNWZ4dk07/GQxGcMe7a1SQu41w5CP0UlyGIM9HTqBi1TKYvj0xngOcj129zIsWu5NkDzLdTA+KssbwNI6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972817; c=relaxed/simple;
	bh=04rcN74LRVOgvg1Pgpl2S95I7nmZQRd+3n8EVCIHMLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUmc6/KnOxzFw93tdzTYRtvSYqpNZgomR5duxCioZ3vIvmdHsuLyySaVUadyO4vU9V9QgpSG0NrvUnPav6piN7cKwaUrI9KzhLWDhwQLBtzsoJtT+ztrxVYnYP6d5d5v50yM9VvCL8kZfaF5mTk4uhjtTsu1xfXs8S8sjRQ24co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=nk1YlmOw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GuOIWxak; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.nyi.internal (Postfix) with ESMTP id 406B520011D;
	Fri, 17 May 2024 15:06:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 17 May 2024 15:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1715972815; x=1715976415; bh=MolZk3aDwQ
	5AXPmBxbzqYEOhzXdd2allt5iM66ZHWGU=; b=nk1YlmOwRf47RW6Xl0ocg8hbPh
	vhEG6vO5uradKBG1r0JN72SiAT7soy6dE4iT37d72v42/tyPA/Ju8NEZIeW6vMi2
	lHNtPudTnfQrDUl1dsqt9+Sw3UeyAPiOMWguSjMv7jcD3UJLuZsGcirL8EOaJxUU
	lWHTk7rqcxM5rzVMK51IqjOHzWzh6aCw1lWXde2H9ZsAlbwAtzRVOHJRAqn3lgH3
	DDFXS5Pu8V6lfj1beydisMASxr+JqcmVmRf9H0i0xNdEssVvuCK8JiBW6zE/dROG
	ZSGlnM4Z0hdc2hw0caXycrppcFYniN44Z20nw3rrhl7rCUr1MHiDgdMySKPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	i76614979.fm3; t=1715972815; x=1715976415; bh=MolZk3aDwQ5AXPmBxb
	zqYEOhzXdd2allt5iM66ZHWGU=; b=GuOIWxakWky6eQrMiU9frb/EQ+8OXJvLTS
	jQeeA/nMKbaNfGCRm4Ga0A7jyDdpc3mkXngButmYaeKsELqqNBUZT1KpggexHykl
	Yxlt/7kLgTBFoRrEq35CmHN7m0XNvcn2j5ADurM66M4ZmJVXZK187q5ZnaeAfA6t
	z3fNq6hvufYtd3+S41FIRa6hMjn7eEGGWj4qaCZQ74eaK/MKdlB5kxNZLSkt2zqr
	+NDwBmERl/8PQExnYlDUCFFd+HKmkdif4t5FrmUelZD+02OWC18UTQbK3iiZH+31
	563Tt7QfsqEImoiAkhKYrRtlH3s2zzJI3pHtlv7tlQe8CM3XddDg==
X-ME-Sender: <xms:zapHZs3lYqgCs0EsLnDkWXwPs-8TF5Ovcf5Jtl9oUQS5YfAyX-NBoQ>
    <xme:zapHZnEihHPBIwfTw4V_eI-difhVnimEsF1wygWaTIFxdAcKvTWwOHPijwr9Na4iy
    gBGsuJytrbUE6ZCk6Q>
X-ME-Received: <xmr:zapHZk6IwJsdzwfa8H38LsSG5xchGVIVjy_fXAqGiXonmC4AJTLaLuOzzXoMvhymmSA3fZWX_EasQNCWs1y25ts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtjeenucfhrhhomheplfhonhgr
    thhhrghnucevrghlmhgvlhhsuceojhgtrghlmhgvlhhsseefgiigtddrnhgvtheqnecugg
    ftrfgrthhtvghrnhepkeekteegfefgvdefgfefffeufeffjedvudeijeehjeehffekjeek
    leffueelgffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhgtrghlmhgvlhhsseefgiigtddrnhgvth
X-ME-Proxy: <xmx:zapHZl2JO9xI6FAz3XkByw8qXGqXoU5jkK9sWhzRrlO5DZehXTNWRQ>
    <xmx:zapHZvHOwsbVuSoQreaaGgRSmXDIIT4TMhHqlc9jFIAiP1d27E23_w>
    <xmx:zapHZu8-8ev1Z5q5SruSKb4zjQrPU4FKFe4x7DODb-X3qw4P2VEVCQ>
    <xmx:zapHZkkXNO2jAFjPA4OrQ8YuxJKnBEP3Sztr6gtPlRruh64vvYVmAg>
    <xmx:z6pHZvHG42Nog5HimWwH-lSGc2XcplGXHnhwSBXRBQtB0QKYfr2Pmgtf>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 15:06:50 -0400 (EDT)
Date: Fri, 17 May 2024 12:11:52 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, brauner@kernel.org, 
	ebiederm@xmission.com, Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Joel Granados <j.granados@samsung.com>, 
	Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, containers@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
Message-ID: <vhpmew3kyay3xq4h3di3euauo43an22josvvz6assex4op3gzw@xeq63mqb2lmh>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df3c9e5c-b0e7-4502-8c36-c5cb775152c0@schaufler-ca.com>

On Fri, May 17, 2024 at 10:53:24AM GMT, Casey Schaufler wrote:
> Of course they do. I have been following the use of capabilities
> in Linux since before they were implemented. The uptake has been
> disappointing in all use cases.

Why "Of course"?
What if they should not get *all* privileges?

> Yes. The problems of a single, all powerful root privilege scheme are
> well documented.

That's my point, it doesn't have to be this way.

> Hardly.

Maybe I'm missing something, then.
How do I restrict my users from gaining say CAP_NET_ADMIN in their
userns today?

> If you're going to run userspace that *requires* privilege, you have
> to have a way to *allow* privilege. If the userspace insists on a root
> based privilege model, you're stuck supporting it. Regardless of your
> principles.

I want *some* privileges, not *all* of them.

> Which is a really, really bad idea. The equation for calculating effective
> privilege is already more complicated than userspace developers are generally
> willing to put up with.

This is generally true, but this set is way more straightforward than
the other sets, it's always:

pU = pP = pE = X

If you look at the patch, there is no transition logic or anything
complicated, it's just a set of caps behind inherited.

> I would not expect container developers to be eager to learn how to use
> this facility.

And they probably wouldn't.
For most use cases it's going to be enforced through system policies
(init, pam, etc). Other than that, usage won't change, you will run your
usual `docker run --cap-add ...` to get caps, except now it works in
userns.

> I'm sorry, but this makes no sense to me whatsoever. You want to introduce
> a capability set explicitly for namespaces in order to make them less
> special? Maybe I'm just old and cranky.
> 
> >   They now work the same way as say a transition to root does with
> >   inheritable caps.
> 
> That needs some explanation.

From man capabilities(7):

In  order  to  mirror traditional UNIX semantics, the kernel performs
special treatment of file capabilities when a process with UID 0 (root)
executes a program [...]

Thus,  when [...] a process whose real and effective UIDs are
zero execve(2)s a program, the calculation of the process's new
permitted capabilities simplifies to:

   P'(permitted)   = P(inheritable) | P(bounding)

   P'(effective)   = P'(permitted)


So, the same way a root process is bounded by its inheritable set when
it execs, a "rootless" process is bounded by its userns set when it
unshares.

