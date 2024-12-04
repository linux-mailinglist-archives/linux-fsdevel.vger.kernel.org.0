Return-Path: <linux-fsdevel+bounces-36393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605319E3351
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 06:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBA1166BA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 05:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92EB185B68;
	Wed,  4 Dec 2024 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vR9rT1kO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F51DA5F;
	Wed,  4 Dec 2024 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733291563; cv=none; b=OyLDdmMSJ/txYmGf9KDVLmrmp+SRmYpUdwpNKAX1MBuuacYA4i0y9yXCwdjTkDEkkGKIPu9GB8t/G6FKgkUNoJxT8jOI9Sh50IaASEDApf2BjNzpUYdbBSeV1W4TVtMukFAkFZE+UAyFlGnjl4pa5JbzpJD4uBpIcNk6Zg6YgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733291563; c=relaxed/simple;
	bh=6PH4CBuizRBwQhle5LobHoTfnjtbvPyw5NCKz/3TYD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geWmMO+xIEVMh99LLd36Vv79zPqPTCL9seNNIcOpZAM9ZevkYyzFGQb8hF9xfiA7EJGlsBL2qZ5g5baEDTmryxf2I1Ak8RtBaG0opYLz2/v2Im8dHDS2QOS/3s1FBQN2fIyhjcAc2CCIW5Z89dTSoBYiEj8hYgpZfwi7708hxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vR9rT1kO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAA1C4CED1;
	Wed,  4 Dec 2024 05:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733291562;
	bh=6PH4CBuizRBwQhle5LobHoTfnjtbvPyw5NCKz/3TYD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vR9rT1kOjE0K0HJVhuntdO9rLvhDl4El72OFHK2KZrcXjKiVQkw3IZ8ebT26t/qjo
	 hvBbw9lKOKXzvz6m2vrG7q5nmnRCq3g7wSGlU18VmvN6jlGZo3Va+6XBJOoYqg+7Gr
	 9be/SMlV5+sgkXmwqt0uiuzGQZtMHIGCCOI8S9EDS0Wl/3eoCo84cfmcff9XrZ4oRy
	 VtCqvpPMCObkL+yeSRKXKXOFzUHdwEGg3Kz+xnbHe3/8pbAyiBKPmkMCdHS6jTDXhx
	 ZR0o+vhl9909R9IK5489QgjldCAMcoetjFe20D7eAXNVHlabBLgdcGHTHmPH7b6zz+
	 7f5nxVwi7kqcQ==
Date: Tue, 3 Dec 2024 21:52:41 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, bfoster@redhat.com
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
Message-ID: <20241204055241.GA7820@frogsfrogsfrogs>
References: <20241203153232.92224-2-axboe@kernel.dk>
 <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
 <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
 <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
 <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>

On Tue, Dec 03, 2024 at 03:41:53PM -0700, Jens Axboe wrote:
> On 12/3/24 3:16 PM, Christoph Lameter (Ampere) wrote:
> > On Tue, 3 Dec 2024, Jens Axboe wrote:
> > 
> >> I actually did consider using some form of temporal, as it's the only
> >> other name I liked. But I do think cached_uncached becomes pretty
> >> unwieldy. Which is why I just stuck with uncached. Yes I know it means
> >> different things in different circles, but probably mostly an overlap
> >> with deeper technical things like that. An honestly almost impossible to
> >> avoid overlap these days, everything has been used already :-)
> >>
> >> IOW, I think uncached is probably still the most descriptive thing out
> >> there, even if I'm certainly open to entertaining other names. Just not
> >> anything yet that has really resonated with me.
> > 
> > How about calling this a "transitory" page? It means fleeting, not
> > persistent and I think we have not used that term with a page/folio yet.
> 
> I also hit the thesaurus ;-)
> 
> I'm honestly not too worried about the internal name, as developers can
> figure that out. It's more about presenting an external name that sys
> developers will not need a lot of explaining to know what it's about.
> And something that isn't too long. BRIEFLY_CACHED? TRANSIENT_CACHE?
> 
> Dunno, I keep going back to uncached as it's pretty easy to grok!

<shrug> RWF_DONTCACHE, to match {I,DCACHE}_DONTCACHE ? ;)

They sound pretty similar ("load this so I can do something with it,
evict it immediately if possible") though I wouldn't rely on people
outside the kernel being familiar with the existing dontcaches.

--D

> -- 
> Jens Axboe
> 
> 

