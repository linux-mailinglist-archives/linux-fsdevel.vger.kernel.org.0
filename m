Return-Path: <linux-fsdevel+bounces-37921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0FC9F90EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 12:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52912167FE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 11:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EB11C232D;
	Fri, 20 Dec 2024 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="prS3/2ez";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q16tZmpk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BE61BD9C1;
	Fri, 20 Dec 2024 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734692930; cv=none; b=MbLL3V9JXoWHgn4uRgTtUpGkZzLdAunlKDPklgDVxflD53hlTf4Db0gL1YagqcYMCd2IknDv3xhRP5uQnDEYBdzctUgj0hEbp5bhE3sqVVEos5pxG4bVpeaIW4SjrCGfILZ515KJuggOvK8JI7/owznMqpzQcgrPiIscVJTWqxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734692930; c=relaxed/simple;
	bh=tL3FadEvvM00OuFwPZXvFChzPFmbe44DkMQ9Oe5umI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tE8xvce5SeBpisr3MSNLESQ5y14cUIhy0YHGiO7ifCucX6+SPiuyp8UlMkkabIedE6p4g1aT2zuUPLFgLfBQkI3hQ/9t7B7Kx4xT97PNut7becqzh+t2hOS2jDAAHvTFusKJZj5cdvYoCUNltM2+DZQekwOWda93WIP8PjFyV6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=prS3/2ez; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q16tZmpk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2BA051140136;
	Fri, 20 Dec 2024 06:08:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 20 Dec 2024 06:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734692928; x=
	1734779328; bh=dBLiuAzHvMBEoc6ZDN/KN5+HvtxCsSX//Zw04k+D2ew=; b=p
	rS3/2ezvtBp4o1UCi3eQ5Jz422jTvmg825ZuwTDLJpK2PHNTxO56ILYo8YT4fN2G
	c/LQk8WaV+eL2bhmgD/NtcwkOAgJMOlEfi/pikEg1dAvBYj9jF5HDZW3yBcxcHgS
	/vI/Mx7/OgYj+X013h/Sf+dWOxLGx/IrR8HEiRLT6b5w7Igtgn4FFabMAEbfhiwo
	pIgeeXmGWPLE3aMe0Yj/77LlGIndcnaOHKACcRL2j5TrDxod/opdoFaF7eC4lFDY
	wTU/OJxfZEgZ2KWbGp42cnLHq1MtX8uRMjVo6Pi3l/cmlyO9hd9RsPP33yw6yBjg
	Sh0BsEhxi/oenqrZKjqug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734692928; x=1734779328; bh=dBLiuAzHvMBEoc6ZDN/KN5+HvtxCsSX//Zw
	04k+D2ew=; b=Q16tZmpkPHHgQl5iE4l8VV4TyiVg54Qz3CUD4PsTCFigqpMX6vN
	tPov+fq616x6Zazw315ZVnGDq1+5aEe+uxO7L355ZPWxa5l8myR2+0YadTi9OXQd
	CtsZs9vgSaONy8LiBRGoXbiqD/7W65O+3EFS835j/O0KEALoknRUPBT7mzdCAe1M
	WTxnNJSzZNmCd7qnEI34W+6mlqg5Q8zsFeaPN/WecycPlJeqoV8ivnbjxw3kXd5P
	7Uf9xy6dk8qm/pPBkwSxK4zGJpcx9ldWqu177+ar6OhLCDRCzxukMpDSyrC7VGtO
	Z/Z3tIGfVXVG982fYKzzdYW/SXC/gw5Yogg==
X-ME-Sender: <xms:P1BlZytxN8v5cs89SbMQLQsluR4N7ad80dt7VXui4gOP8V49oDJpXg>
    <xme:P1BlZ3ft4TtnnnnAAFGvJSvJGaAcd0tjhmKuen4pSZOX0G2rzZFAyG7TCMW2Qq6DZ
    vK00WKNUb2CYXHlzYo>
X-ME-Received: <xmr:P1BlZ9xdn41y4TR9dfEnftBcywOt6pf_1ivDmtrnJP7v2-WosFbecOQxPV6Mpc6liwaSaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtoheplhhinhhugidqmhhm
    sehkvhgrtghkrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghnnhgvshestghmphigtghhghdr
    ohhrghdprhgtphhtthhopegtlhhmsehmvghtrgdrtghomhdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhl
    lhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepsghfohhsthgvrhesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:P1BlZ9MK4g7gs2lmx0ewrua198cToSwyM7nbGAr0rX8klfI2W3ET1g>
    <xmx:P1BlZy_yv5zGwSmVVZFJEN963HhX_eAB9vJmJDUClEYPEPpPq7xtwA>
    <xmx:P1BlZ1X0irfqDndCig3-9bJBb9MX3DjWaoj61c8izefTYSGPDIiPYg>
    <xmx:P1BlZ7f3p2R8za2knRu0AKATJtH_GLt3vHnHw1pfhtXvzGANvLk8cg>
    <xmx:QFBlZz1uUzrxkfCCufK-bSi3S5hSdrOuGF5pg-r0Ox6ExIH4_Bidep3O>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 06:08:43 -0500 (EST)
Date: Fri, 20 Dec 2024 13:08:39 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
	bfoster@redhat.com, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 04/11] mm: add PG_dropbehind folio flag
Message-ID: <wi3n3k26uizgm3hhbz4qxi6k342e5gxprtvqpzdqftekutfy65@3usaz63baobt>
References: <20241213155557.105419-1-axboe@kernel.dk>
 <20241213155557.105419-5-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213155557.105419-5-axboe@kernel.dk>

On Fri, Dec 13, 2024 at 08:55:18AM -0700, Jens Axboe wrote:
> Add a folio flag that file IO can use to indicate that the cached IO
> being done should be dropped from the page cache upon completion.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

+ David, Vlastimil.

I think we should consider converting existing folio_set_reclaim() /
SetPageReclaim() users to the new flag. From a quick scan, all of them
would benefit from dropping the page after writeback is complete instead
of leaving the folio on the LRU.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

