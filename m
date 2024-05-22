Return-Path: <linux-fsdevel+bounces-19944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C038CB6CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 02:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CCF8B23B28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 00:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BF14C62;
	Wed, 22 May 2024 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="YhB228Mc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SdbLII0G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wflow8-smtp.messagingengine.com (wflow8-smtp.messagingengine.com [64.147.123.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153A1FA1;
	Wed, 22 May 2024 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716338414; cv=none; b=Wm+0iaOlzc+MERH5Qf4cnycrYLJ5oKwpVvefUTeyHuu0lfBGxYfBnrx6pVtr9FslsyYtwczNVPFYpklEM3Xsv+Bwl0T7+rrkzjFxB93zeTlsKE5emQWU7E+nXFpF4xvWgo90rd+iyURNM94wamaPLLcCi76Jc4G5exFYHVrbt9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716338414; c=relaxed/simple;
	bh=8B0pyok8glyBoi2CMBAzxoUXPEO9Y2mHnaBCbVJXa9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdAxtaksL6VXT9/PfRffcFWLOmyCtRkOPro7uu9vrkYsvWQWN7bx6sRwmdJdA0D/8kuJs+9a4sN+rHE9SLFzRxtMnhW71jtX1w6YWT2aqZr3dASetGn7/Qr9EhtzCVwEwaDYIIfV0QP+KmCUFE2+KQb06MSBgxvVimyVERpE6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=YhB228Mc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SdbLII0G; arc=none smtp.client-ip=64.147.123.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.west.internal (Postfix) with ESMTP id 850A22CC01E9;
	Tue, 21 May 2024 20:40:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 21 May 2024 20:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716338410; x=1716342010; bh=wE/C8/1cu4
	wwG5XhDNZrp3sPxcam/hgaOM+3UxWxSUs=; b=YhB228Mcku29ocsPUmPJmLg9vF
	XeW7+tphU59T5T7cGn8/QXcCHE53htbcynBc4aCoqn7vGXJCIMHECrHP7eLx23nI
	XNLLGHHHCT2pigTnlz0ODOu+jNyCr8bcxMsAjDvey53IfkbmKsc2dP4Z+YioptXD
	bSg+YW2Zl8K795G7NiglmOUICkj82swIWC932d0OxoFnoOkQuxsX+q/UmUigXUKw
	zgR9ofJBCQjBJRhGp/uJ3yaQkr129Y+NUo8LT4Gl2JIwIbVSLtMBD/8TytsWwFwR
	eMQAuBKea6LdWqcKUPaNuedHb5Ed9XyOZsFBMqKuoS2+YQqBlL0hHlVr9dEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716338410; x=1716342010; bh=wE/C8/1cu4wwG5XhDNZrp3sPxcam
	/hgaOM+3UxWxSUs=; b=SdbLII0GpoeZf4KddZQYQrcPPYidHnoZdi6KNEL/pZHa
	be5aofGXMiVk6GpJ2AsG2ULTN8BIox7XKFHC0PiyfsL7JVAZIhU0evBh6aZhzbIF
	2A2RlNZRstJpAit5kxlkaIWH2YLHbX5ALzFlEZ+XKMvPxBbDM9zeudBVZSuDghC/
	8NXh35WtWQpwoBhxh1vxEA+VQfCufVrOQZ60r1+585MTxXTDhDs+9FO51NQQzUAJ
	1kcmz8No0WgBeum+rWGwRk2luvjAJ9aQCg3HFEHFS1ZxsrVxGimgV7BHYFtC/yEN
	tYe6GSL55G9owj0JSk1AJ1ma+lIKDrGbE9Cgq5VNlA==
X-ME-Sender: <xms:6T5NZhx3rpiM1DavGQ6oUv8KDfdUkEerMFTp3xRQfD_5tE2BBNfquA>
    <xme:6T5NZhT7ER-XROBTSVDqM4l0VBZ1slq3N-wnu0TuHosDDTQzvpMTjxFxL-BvqS7rZ
    523FuD2VUIN-D8HWwI>
X-ME-Received: <xmr:6T5NZrU3DCjTRvhUtKgGK0YGuCY-8mSgP5QzMYJ3RuC-QgVhuvNea4QABfbqWEDINpi35VM6jpQh7CpSoEtJjYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtjeenucfhrhhomheplfhonhgr
    thhhrghnucevrghlmhgvlhhsuceojhgtrghlmhgvlhhsseefgiigtddrnhgvtheqnecugg
    ftrfgrthhtvghrnhepkeekteegfefgvdefgfefffeufeffjedvudeijeehjeehffekjeek
    leffueelgffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhgtrghlmhgvlhhsseefgiigtddrnhgvth
X-ME-Proxy: <xmx:6T5NZjjC_5ygO2oCudKGq4Ly4ife-SK1kOEExJqOzI95Yf0WsleoPQ>
    <xmx:6T5NZjDGR3mnfpCzMoV3FpZP5lLBmhLkBLMSgM3KLtgPa3fxUZEGmA>
    <xmx:6T5NZsIexfSMHxg5n9cqGJwoKgMyFOiQS0oziWMn4DSjveI0nke13A>
    <xmx:6T5NZiD2BVvYhVoNaOapkIY5GvRKkk1NITZfUZCODC34MGf4eDJcrw>
    <xmx:6j5NZrbx9SZxUZBpnfDmq-nHMs8jjVUBo4dCv2Z-dKNO_Edb_KcWyTKt>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 20:40:06 -0400 (EDT)
Date: Tue, 21 May 2024 17:45:07 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: John Johansen <john.johansen@canonical.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, brauner@kernel.org, ebiederm@xmission.com, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Joel Granados <j.granados@samsung.com>, Serge Hallyn <serge@hallyn.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, containers@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
Message-ID: <7psuqchpr5njlcqb3koeyqz3y2jhuc44vfeockygdarqyc3eyu@qpmujctxfmak>
References: <D1BC3VWXKTNC.2DB9JIIDOFIOQ@kernel.org>
 <jvy3npdptyro3m2q2junvnokbq2fjlffljxeqitd55ff37cydc@b7mwtquys6im>
 <df3c9e5c-b0e7-4502-8c36-c5cb775152c0@schaufler-ca.com>
 <vhpmew3kyay3xq4h3di3euauo43an22josvvz6assex4op3gzw@xeq63mqb2lmh>
 <D1CQ1FZ72NIW.2U7ZH0GU6C5W5@kernel.org>
 <D1CQ8J60S7L4.1OVRIWBERNM5Y@kernel.org>
 <D1CQC0PTK1G0.124QCO3S041Q@kernel.org>
 <1b0d222a-b556-48b0-913f-cdd5c30f8d27@canonical.com>
 <D1FDU1C3W974.2BXBDS10OB8CB@kernel.org>
 <872c8eb0-894b-413a-8e35-130984a87bba@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <872c8eb0-894b-413a-8e35-130984a87bba@canonical.com>

On Tue, May 21, 2024 at 07:45:20AM GMT, John Johansen wrote:
> On 5/21/24 07:12, Jarkko Sakkinen wrote:
> > On Tue May 21, 2024 at 4:57 PM EEST, John Johansen wrote:
> > > > One tip: I think this is wrong forum to present namespace ideas in the
> > > > first place. It would be probably better to talk about this with e.g.
> > > > systemd or podman developers, and similar groups. There's zero evidence
> > > > of the usefulness. Then when you go that route and come back with actual
> > > > users, things click much more easily. Now this is all in the void.
> > > > 
> > > > BR, Jarkko
> > > 
> > > Jarkko,
> > > 
> > > this is very much the right forum. User namespaces exist today. This
> > > is a discussion around trying to reduce the exposed kernel surface
> > > that is being used to attack the kernel.
> > 
> > Agreed, that was harsh way to put it. What I mean is that if this
> > feature was included, would it be enabled by distributions?
> > 
> Enabled, maybe? It requires the debian distros to make sure their
> packaging supports xattrs correctly. It should be good but it isn't
> well exercised. It also requires the work to set these on multiple
> applications. From experience we are talking 100s.
> 
> It will break out of repo applications, and require an extra step for
> users to enable. Ubuntu is already breaking these but for many, of the
> more popular ones they are shipping profiles so the users don't have
> to take an extra step. Things like appimages remain broken and wil
> require an approach similar to the Mac with unverified software
> downloaded from the internet.
> 
> Nor does this fix the bwrap, unshare, ... use case. Which means the
> distro is going to have to continue shipping an alternate solution
> that covers those. For Ubuntu atm this is just an extra point of
> friction but I expect we would still end up enabling it to tick the
> checkbox at some point if it goes into the upstream kernel.

I'm not sure I understand your point here and how this relates to xattrs.
This patchset has nothing to do with file capabilities. The userns
capability set is purely a process based capability set and in no way
influenced by file attributes.

> > This user base part or potential user space part is not very well
> > described in the cover letter. I.e. "motivation" to put it short.
> > 
> yes the cover letter needs work

Yes, it's been mentioned several times already.
While not in the cover letter, the motivation is stated in the first
patch and provides several references to past discussions on the topic.

This is nothing new, this subject has been contentious for years now and
discussed over and over on these lists (Eric would know :)). As
mentioned in the patch also, this recently warranted the inclusion of
new LSM hooks.

But again, I wrongfully assumed that this problem was well understood
and still relatively fresh, that's my bad.

> > I mean the technical details are really in detail in this patch set but
> > it would help to digest them if there was some even rough description
> > how this would be deployed.
> > 
> yes

Yes, this was purposefully left out so as not to influence any specific
implementation. There is a mention of where this could be done (i.e.
init, pam), but at the end of the day, this is going to depend on each
use case.
Having said that, since it appears to be confusing, maybe we could add
some of the examples I sent out in this thread or the other ones.

I want to reiterate that this is a generic capability set, this is not
magic switch you turn on to secure the whole system.
Its implementation is going to vary across environments and it is going
to be dictated by your threat model.

For example, John's threat model of securing a multi-user Ubuntu Desktop
is going to be very different than say securing a server where all the
userspace is fixed and known.
The former might require additional integration with the LSM subsystem.
Thankfully, this patch should synergize well with it.

Fundamentally, and at its core, it's very simple. Serge put it nicely:

> If you want root in a child user namespace to not have CAP_MAC_ADMIN,
> you drop it from your pU.  Simple as that.

From there, you can imagine any integration you want in userspace and
ways to enforce your own policies.

TLDR, this is a first step towards empowering userspace with control
over capabilities granted by a userns. At present, the kernel does not
offer ways to do this. By itself, it is not a comprehensive solution
designed to thwart threat actors. However, it gives userspace the option
to do so.

