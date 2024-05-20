Return-Path: <linux-fsdevel+bounces-19838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537308CA3B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 23:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18181F21DB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 21:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786A5139D13;
	Mon, 20 May 2024 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="Z46utTAB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ql3G1jPi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1569313959D;
	Mon, 20 May 2024 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716239615; cv=none; b=pQaho4Xzm3ZZ0GDtK3cm3MIpElvyoa5n0mbqipaggUP504fUlGpVg8unO9liOHE4gjBM80R/kHVGaOi+h4WrdoLfd/vNCp0hvxKmXCeN5J+jalyN9SFo43N2nYETvAxHB4PZJJ7WZ5Rn9Rn6C7dIB+mA8y/PO0l1ivEniahGdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716239615; c=relaxed/simple;
	bh=Bx+sj8t9HNxybi1oDttghAMxvT+D/0RgxzOubry0jmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBu1BUiGV8YaaJN7mLmbIIlk/9EDntc7n/FJmqIO6VGMCnKpUy8mW+y14Hu8KsJ7PCOXlRWi3gX7su7ycTL4+OJQF+KwMcQbh8qF4AeEn28fdVEmMiCyqUIQpJt/eYkr/GhrX0YeOZkvlE9aqmHHzcPglUJmAxzqBN0/uCq45qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=Z46utTAB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ql3G1jPi; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 4F0C51C000FB;
	Mon, 20 May 2024 17:13:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 20 May 2024 17:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716239611; x=1716326011; bh=07dLT5mWE9
	IVMfZYh0BeXqhtBVnvUCmQKUtwX9bMrAY=; b=Z46utTABbFWDgQmbCaMIfWNGWU
	Muz0cl/JbRhW/QLp3km+gIKTXsOCzbpzFD+SWjP+BMcX+49S1YmH/5wAB9L/SqxA
	prw9Eaw7tJ7QJ2YZkfDbqFyiT8c37stsX4sWRY7ls5aXJF1kC+W0OL7j3qBysVa4
	wbPIJ+IXPVjBCwHQQE5Htjn5/Ec4t3vye967rgbuI1ppFaIHh4MMWeCIUEYoz6Aw
	L3kba1Nf1q3u4K5Z2zWBfojaZiBSpuJvM3PrjU0p1IA/kTXsanZM+PWqdYmRDiJL
	Pws//zBG0gqzAsk2g2NeirpzkjNKPSz4+URusHvpr33eyBbDURr4radZcinQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716239611; x=1716326011; bh=07dLT5mWE9IVMfZYh0BeXqhtBVnv
	UCmQKUtwX9bMrAY=; b=Ql3G1jPiI4SktfG12x4b39mgwqhaF/2ra9OY8hIfZ369
	FgawflV1v7+BWhjQbVHfdWzJujUpRUBR1wd/eNVLmcjKthUuKauaNTanGkrei1OE
	vCHyQzo2fgEOmMwNdWdEO93L45bV/6DDDryOA6S2bNvboieP6p+T6bnvSnLTQc3Q
	d6uh9vG9oU63V1LhrUfYgnD+7Gf3SR7Ldj454noVyRKmpuc/wKqh27WoGIVfK3iT
	v8dg9HmTLoFgm+oB0P6HA5i8O60FG79VYpe5tvxl+DxRudDMmz/yGvDNVsNhI1eM
	NraLVmhZMP3dtqOB5vFB+XIb1tYkGYcJG2afGPVvsg==
X-ME-Sender: <xms:-rxLZuwi3fdH7B4nQz3r5YrvCyUdiHW6DN68Rpq5ANnGpkuG-yZssg>
    <xme:-rxLZqQCDli3I3S3ptJXThrp5l2QCMbMYP1JB_TLF7IqaaSLAE4LLrUn721L9v-tW
    j-Jo1jAj5dk1QYmlMc>
X-ME-Received: <xmr:-rxLZgXQ5rLZsDf3SKZFGnUJtqixF8cJZE7ukHZu6xzzNH1XE1EtfLpXgE0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeitddgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteek
    lefhleelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:-rxLZkh8quqXExI6E37pQD-9ivdWceVTcKAAyeit9eZKMLJDYVZavA>
    <xmx:-rxLZgBf41SAm_EiNoHj__AfvIVtkjYm86BiN0mmYSdB4gc9D7Vxeg>
    <xmx:-rxLZlIPEIHv2BFBgwAJGweaR8HGEKY3tHZG_VMtK-9pH-0WaCWniA>
    <xmx:-rxLZnDDzw-CeTIZPgvIe0_J4_Sb8kwVOV2WVmASCXmq1AIjtFhviA>
    <xmx:-7xLZqz6yYdr3UaxUMhGusn9Mc5lvvpyBcGCs33ZjVXNMyTtDP0H9ZBz>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 May 2024 17:13:27 -0400 (EDT)
Date: Mon, 20 May 2024 15:13:23 -0600
From: Tycho Andersen <tycho@tycho.pizza>
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: brauner@kernel.org, ebiederm@xmission.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, containers@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 3/3] capabilities: add cap userns sysctl mask
Message-ID: <Zku8839xgFRAEcl+@tycho.pizza>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-4-jcalmels@3xx0.net>
 <ZktQZi5iCwxcU0qs@tycho.pizza>
 <ptixqmplbovxmqy3obybwphsie2xaybfj46xyafdnol7bme4z4@4kwdljmrkdpn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ptixqmplbovxmqy3obybwphsie2xaybfj46xyafdnol7bme4z4@4kwdljmrkdpn>

On Mon, May 20, 2024 at 12:25:27PM -0700, Jonathan Calmels wrote:
> On Mon, May 20, 2024 at 07:30:14AM GMT, Tycho Andersen wrote:
> > there is an ongoing effort (started at [0]) to constify the first arg
> > here, since you're not supposed to write to it. Your usage looks
> > correct to me, so I think all it needs is a literal "const" here.
> 
> Will do, along with the suggestions from Jarkko
> 
> > > +	struct ctl_table t;
> > > +	unsigned long mask_array[2];
> > > +	kernel_cap_t new_mask, *mask;
> > > +	int err;
> > > +
> > > +	if (write && (!capable(CAP_SETPCAP) ||
> > > +		      !capable(CAP_SYS_ADMIN)))
> > > +		return -EPERM;
> > 
> > ...why CAP_SYS_ADMIN? You mention it in the changelog, but don't
> > explain why.
> 
> No reason really, I was hoping we could decide what we want here.
> UMH uses CAP_SYS_MODULE, Serge mentioned adding a new cap maybe.

I don't have a strong preference between SETPCAP and a new capability,
but I do think it should be just one. SYS_ADMIN is already god mode
enough, IMO.

Tycho

