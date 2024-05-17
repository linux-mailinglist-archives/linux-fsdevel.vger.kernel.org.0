Return-Path: <linux-fsdevel+bounces-19660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8454C8C85BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 13:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77021C223D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669693EA96;
	Fri, 17 May 2024 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="RP7soohG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yow8Rti0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wflow6-smtp.messagingengine.com (wflow6-smtp.messagingengine.com [64.147.123.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB1839FE0;
	Fri, 17 May 2024 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945827; cv=none; b=t+vWUCRdghkev4ovXSn/1xnV2Q5UZBRO/VK1/Uy7SahJb7+t8FDu/jQ6ikCbmQ6quHGVzyISu6OqVsAFY2VTFagALK5Ez2Ve2Xl2O5gRk/xV0h8yyrPu1Xno0FP2DmCB6USQUIiMerQ0Czx3myPF3Ziyam9miBqb/CkXpq60Ros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945827; c=relaxed/simple;
	bh=9iwRhGote2VDlqpW9jTKlkdZQA3B+wPYMKRzpfbwwc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhlqbkfybwvGlawJDVKcDhgl6rybsr7+Oo+6ykvvWM02/s7UvAdBUkbJAUNe1QGsCKL3TKI6MFz4AUWAzQ32YILq2OwMzLNo2Y9aqtMbmK1ceKdlwtglq+MX1DbwOBcVjlGPo4zKZFjAu70neG2Q405v5oS5UI3iY9OjrkVRVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=RP7soohG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yow8Rti0; arc=none smtp.client-ip=64.147.123.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailflow.west.internal (Postfix) with ESMTP id 2DF562CC0146;
	Fri, 17 May 2024 07:37:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 17 May 2024 07:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1715945823; x=1715949423; bh=nI3D7dv9ma
	mdu0MSJ/mg14u62h/nEOjeznANWab6vVU=; b=RP7soohGfwMt3AO8dys3F2agT+
	EJoeH1j6f/glE00+8FdBTfi+nIkvSiQsJMzL/hwQkn6uCE7KSJ0MweWaxzFCqNwW
	fXwyJ79qcIdGeKWlLv4vqx00QPKZhsWdADHQedVow+sRy/e1diFo8xN80ELcvNky
	qmzZSLWm4YeI0+DjQyq+HmWje9eYdAYqAds1DOZ08EAD5QixDFhhAIgDddApmflC
	+CYyEy0ds6LRlAFGR1R9lScGMaFlskvtMmkIhvGG0d3NC/UbhvHNUbxvF/qpvm8N
	j0Hg9ElKIZK+FIDMZNmV9kLkSWFBTp2HeLsHtytIYrZQ631cSuphJnhldEEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	i76614979.fm3; t=1715945823; x=1715949423; bh=nI3D7dv9mamdu0MSJ/
	mg14u62h/nEOjeznANWab6vVU=; b=Yow8Rti0jLSufYdeUU+Zt81/T5g8I0tDeQ
	H2YLccyc78jDer7JXkdBBWemJsc82/oINbcPb+RPjtK1mFaqouIQp3FfmHAHeaz2
	B64dlAPJKZ0KUNzIq6n++6YqAetFzWU8JrEda4OShudEjGcN9TCJe48+wSOF5c4B
	JPVzNH9niYpxlYXlfO2rXcOsbSP0LC37UUP6/TBM2DF/myvLFq6FfjHZT4DHW+fs
	gqgQE1pPvvyfxfRy5pm8ezvWLfph39KPiajmY6RivnFhTygiTdWn96ixaVqlFKOx
	5mg4G2THALUdw49d167R5iA9jU29zZQStpwCw/4YQaUAsbewWODg==
X-ME-Sender: <xms:XkFHZjSrjq3gJjFRQ-zy8HR8UI7rwwlFKBM-Ws8oxv3eCQ0b6FQ5gA>
    <xme:XkFHZky5dUePLN8kWq176cfCL68UTmt5tUnMjKmRlfSil2-frNexvUrqNOYo5qqEM
    jk5yNAyGlZAQmChRYc>
X-ME-Received: <xmr:XkFHZo2FCuO7bgyYcWm-UpRb3IsT9F2xl-BKUT-u0EAmCkHmCSNfGq-41Faer11c2_tRZgcN-KQyeVvH_f-6OYU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtjeenucfhrhhomheplfhonhgr
    thhhrghnucevrghlmhgvlhhsuceojhgtrghlmhgvlhhsseefgiigtddrnhgvtheqnecugg
    ftrfgrthhtvghrnhepjeeigefhffdtledukeekueekffdulefhteejhfelvdeftdelteet
    gedufeeukedunecuffhomhgrihhnpehprghmpggtrghprdhsohenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjtggrlhhmvghlshesfeiggidt
    rdhnvght
X-ME-Proxy: <xmx:XkFHZjD3Vsg4c-nwEQfCfbyUM7a4K81Dw6ZJXL75JWdnBvTOAmEpuQ>
    <xmx:XkFHZsgjoCt2yTlXrwRaXyskCggR7o9rgcp5ZiyeqPk4Dn70_Eminw>
    <xmx:XkFHZnqIm2Clp1qofP8p9NvhEdc1uNfSweCQx7l3o7CRSV33mw8yPA>
    <xmx:XkFHZnhJ7O2DiUDDmbLaP5QR3DGLYGU7rlD8kvvfcLaE5RORjdyl7w>
    <xmx:X0FHZrRlLRs8g3Q5avKRvrUgDEsPG-rYELie3h_iV6JUXA6uI-noNukQ>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 07:37:00 -0400 (EDT)
Date: Fri, 17 May 2024 04:42:02 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, brauner@kernel.org, 
	ebiederm@xmission.com, Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Joel Granados <j.granados@samsung.com>, 
	Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, containers@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
Message-ID: <jvy3npdptyro3m2q2junvnokbq2fjlffljxeqitd55ff37cydc@b7mwtquys6im>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <2804dd75-50fd-481c-8867-bc6cea7ab986@schaufler-ca.com>
 <D1BBFWKGIA94.JP53QNURY3J4@kernel.org>
 <D1BBI1LX2FMW.3MTQAHW0MA1IH@kernel.org>
 <D1BC3VWXKTNC.2DB9JIIDOFIOQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D1BC3VWXKTNC.2DB9JIIDOFIOQ@kernel.org>

> > > On Thu May 16, 2024 at 10:07 PM EEST, Casey Schaufler wrote:
> > > > I suggest that adding a capability set for user namespaces is a bad idea:
> > > > 	- It is in no way obvious what problem it solves
> > > > 	- It is not obvious how it solves any problem
> > > > 	- The capability mechanism has not been popular, and relying on a
> > > > 	  community (e.g. container developers) to embrace it based on this
> > > > 	  enhancement is a recipe for failure
> > > > 	- Capabilities are already more complicated than modern developers
> > > > 	  want to deal with. Adding another, special purpose set, is going
> > > > 	  to make them even more difficult to use.

Sorry if the commit wasn't clear enough. Basically:

- Today user namespaces grant full capabilities.
  This behavior is often abused to attack various kernel subsystems.
  Only option is to disable them altogether which breaks a lot of
  userspace stuff.
  This goes against the least privilege principle.

- It adds a new capability set.
  This set dictates what capabilities are granted in namespaces (instead
  of always getting full caps).
  This brings namespaces in line with the rest of the system, user
  namespaces are no more "special".
  They now work the same way as say a transition to root does with
  inheritable caps.

- This isn't intended to be used by end users per se (although they could).
  This would be used at the same places where existing capabalities are
  used today (e.g. init system, pam, container runtime, browser
  sandbox), or by system administrators.

To give you some ideas of things you could do:

# E.g. prevent alice from getting CAP_NET_ADMIN in user namespaces under SSH
echo "auth optional pam_cap.so" >> /etc/pam.d/sshd
echo "!cap_net_admin alice" >> /etc/security/capability.conf.

# E.g. prevent any Docker container from ever getting CAP_DAC_OVERRIDE
systemd-run -p CapabilityBoundingSet=~CAP_DAC_OVERRIDE \
            -p SecureBits=userns-strict-caps \
            /usr/bin/dockerd

# E.g. kernel could be vulnerable to CAP_SYS_RAWIO exploits
# Prevent users from ever gaining it
sysctl -w cap_bound_userns_mask=0x1fffffdffff

