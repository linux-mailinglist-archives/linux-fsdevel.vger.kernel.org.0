Return-Path: <linux-fsdevel+bounces-39392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72373A13767
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 11:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251CF3A3CC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA001DDA14;
	Thu, 16 Jan 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="CoQX2n/3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bXDHPm5z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1FE139566;
	Thu, 16 Jan 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022016; cv=none; b=JI6ANWUCC/2ySNOVOBp/aozKzcWJ7PQGo97COU+JVP5I87cS1uka3YDS7a7ZPEYd6r6nOdewb1AIIJiR8W4ceN65o7ocZLk7Zlm1Mhemrgf+1PJMaExqhJDZOIM7EoXqHtA/bFScjUbp2Ovb7en189h6+5pK6HDW6Z8fPQScMec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022016; c=relaxed/simple;
	bh=ONZeRXWc/Nx1tVZLhzzRuMw+B4S9+XF017oOd3rmmp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJt1R8C6iupNMOb5hq4noC08lSvAkYqPr4tE8mEwQkTpQWhYPvAwSqI37s49Ph5RFNhpbAsUznWCVdlTCGA/8ulFMsiCrnGPY1sAIq01PC/DPkCnms44ze2fESMy/m2VzkC6dhJgeLvzoADWCS5Ag0GJ5X+yaIlsRPi7jpU1Bds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=CoQX2n/3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bXDHPm5z; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AD2701380214;
	Thu, 16 Jan 2025 05:06:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 16 Jan 2025 05:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737022012; x=
	1737108412; bh=0tT892uhiL7QMNNvHnCjlXYfFshAz5dRIry0POq56XE=; b=C
	oQX2n/32pWnZz50MDzqam/VZMacQY/NiecHDd2xQ3fAUso7LfHAoZh7VC6aq7sjv
	GS0oVSjpiX4MH+hPUMyvMcAJ7ks71F7px/6pCPkYs6fuWA5PYSmVPTO0NktYcljP
	DPxcFWYTBbC8+Mk5zmj+Vf4UDnuT4wB4uNSl4RodfxQ3kaIu3lLLOvr2ke8cY67x
	DsM2E/4m/yJ4dtM7i+0yHYyKmUS1NRHdYwfci5F/fWrH5BYkvFrkY3owV4zobeUd
	jrm6yB0/rtbA64sPpFByQN8+Z6eVsr2Im4jIZUGq5zF7ZwrNDGEhliUqGjA2/E2F
	UvWcDyu8yeJ3R5YlJZrKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737022012; x=1737108412; bh=0tT892uhiL7QMNNvHnCjlXYfFshAz5dRIry
	0POq56XE=; b=bXDHPm5zajtaACaH3zDfKyXxpn1+WLfJymO5MTZmkb/pVzEch9i
	TogC6FjcsCNk2VJTk9Sx4n4k2oc50KURarwUf4Ktj184raWF6pJ6S8oTBnvK41J3
	rV489Ih9f/LSxb/YLSM0wfbebDUNhA+0YZBWgDlXCfAPIvTgdP5I+qbqzM2pj70K
	mvu/56VL3Sgwccr3AImrpMDNKA+I8EEdmgbenBKaQhmdYVx3voMe3jjc0Lstbq7D
	tutDt2UYUrncC5UWPI4ei33cTRD0xZCyTx3Sbfxw5fP0F/K+8ggxwa5KFAMY9bGQ
	rlzwuxzuqkp0HmRQ45n6+Lpp4pCdvWAZA9A==
X-ME-Sender: <xms:O9qIZwxpFDfKgUZu488kcFkGeQChyP8k6ZB9nWlrAn_lPJPXWNWnpw>
    <xme:O9qIZ0SeF1FiyrYtivlA8833n6HPWfDxSVXeMiY0p9X549GWNUtAy0qJ5bkH_Bsq2
    3H1vIVT14i_5aep_Wg>
X-ME-Received: <xmr:O9qIZyXTT5WT0jYMFhwetp9aFrJJpa9o3lu8FHqF3ZUUuW7GgnYDBNnQFxuxxLEPsA6TxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthho
    pegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtoheplhhinhhugidqmhhmsehkvh
    grtghkrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehhrghnnhgvshestghmphigtghhghdrohhrgh
    dprhgtphhtthhopegtlhhmsehmvghtrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhihse
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepsghfohhsthgvrhesrhgvughhrght
    rdgtohhm
X-ME-Proxy: <xmx:O9qIZ-iQr0u37Mqhiv9rZVHLdAJcOwaf_j9N4ywR0z5M7TM27ILOLQ>
    <xmx:O9qIZyDnFPhucWWeh9RAedMvIxzz7r38wy-8Hpk3PLvMNyp8RsVNuw>
    <xmx:O9qIZ_LE87pXg5_dI8u4L1cSXObB8_1mWcymnv4OkTFKrFi3fQSIeg>
    <xmx:O9qIZ5DYcXoP6N18kTJTrKz3TOAI9fQ5TmdWJjA8-li1giN3d2-cBA>
    <xmx:PNqIZ6u76lx4RBEHPr7Zkg8jyJ3Za8RiTKoy6bUgE6_uHzfOotOL2GFm>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 05:06:48 -0500 (EST)
Date: Thu, 16 Jan 2025 12:06:45 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org, 
	willy@infradead.org, bfoster@redhat.com
Subject: Re: [PATCHSET v8 0/12] Uncached buffered IO
Message-ID: <y77zzxdd523ozv2awanakiemd7m2fb4ktpsmlp2evpohnllusw@gcmleh7vpjkr>
References: <20241220154831.1086649-1-axboe@kernel.dk>
 <20250107193532.f8518eb71a469b023b6a9220@linux-foundation.org>
 <3cba2c9e-4136-4199-84a6-ddd6ad302875@kernel.dk>
 <20250113164650.5dfbc4f77c4b294bb004804c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113164650.5dfbc4f77c4b294bb004804c@linux-foundation.org>

On Mon, Jan 13, 2025 at 04:46:50PM -0800, Andrew Morton wrote:
> > > Also, consuming a new page flag isn't a minor thing.  It would be nice
> > > to see some justification around this, and some decription of how many
> > > we have left.
> > 
> > For sure, though various discussions on this already occurred and Kirill
> > posted patches for unifying some of this already. It's not something I
> > wanted to tackle, as I think that should be left to people more familiar
> > with the page/folio flags and they (sometimes odd) interactions.
> 
> Matthew & Kirill: are you OK with merging this as-is and then
> revisiting the page-flag consumption at a later time?

I have tried to find a way to avoid adding a new flag bit, but I have not
found one. I am okay with merging it as it is.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

