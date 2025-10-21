Return-Path: <linux-fsdevel+bounces-64810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D2EBF4B12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 08:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A60554EB528
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 06:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CC925B2E7;
	Tue, 21 Oct 2025 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="jBkDXb9F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SwGlFmQy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45650282EB;
	Tue, 21 Oct 2025 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761027439; cv=none; b=BZZNTSklASCsS4iLwPhtmdvc3JstSVWds9yx3Incsl/2NhsFqsEQss/JGn4rlFMHeVV9cIbKBw/B/AHqKAyyPkNyfvLdh2Xgvl0wibWvrEeej1FPivQK7BIL8EGB8DNVYZZtGpZV82mS9r5/QEK15te8+/Z/WfvkSgZs/DTi4MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761027439; c=relaxed/simple;
	bh=F7uqWGDgVNfGLCmA9wNOF3IKuzda97s6QrCWLFxW7pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODViFudKiYBD4wCn/TOhzGLvemxkwazoacq/fEY5NMCESwmVSQsTjrjHPHrOudo5SVYS/6vGP+tfwJbdmgkVyUNwQmbBv6JdmZXnxWh5XjpBHW3PA07HF/XFrNkV1bQJ8el0rS4bwj8PxQwe+nV6RSemqRagrbWkxc8nTMn2nOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=jBkDXb9F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SwGlFmQy; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 0887A1300ACC;
	Tue, 21 Oct 2025 02:17:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 21 Oct 2025 02:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761027434; x=
	1761034634; bh=ThkdY/C21GPPtmJaBNezXHfzXuqV664YAK8ByLyyrfs=; b=j
	BkDXb9FTfW5u1Pbb6r2Zr3VIG72LKLw9nP9YQOlOupyXBz0s755d9Um35dkpZN63
	I0Uef+OM6YOOlLsIcEoJtikl3xyLapw96UV1ssVhuz5QXCPo2hIR3HHuq7tMDGY2
	58mQjV9AmE9WkO5v87YTKv3WvXTH0Mzuv6GrHXpLrn5wVp+uHl9G/UtGuSCPnuZw
	vwEQaWyTRz1KV5apsZKdY+Fq3glU/Km7NFtk1WlTD7H88AOGfKkXC/iENwUf2PPx
	jtjeK0o5qqx8Kh9PGTS744xDLujWknV2MNIOIHRFXPn3GPDa9C4CFI1NHQ1lvMBt
	CSb12LPEGkaw74oFKuCyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761027434; x=1761034634; bh=ThkdY/C21GPPtmJaBNezXHfzXuqV664YAK8
	ByLyyrfs=; b=SwGlFmQyJV/PUgWB9SDj8yguYqU6M02H/iwHNvXmSHlFlJWSi3H
	kIShHsNjDTPJvlQR1G0NkOXLVQQnarKseCczRENjeW4f2/jTVqqrDnx99y1xAXwD
	7aH71MEqkok1ZR86ML/9a7+bnbqZxsxDD4Xbuf7+uJ3iNt30RCnrRiFrixypWMZJ
	7hn4PFxDdp3x9LU/kfyTjNnUxVFPdp5+uxLLuMNV+oqpqgVqdelQ8yCOFQoMS+Bx
	tQVgcSObMnUNEKS/RRs639uYCuVsXuAy8goq318P6gQSvQsVxv6C6Ev8BEbF13qc
	QtR7z9k+yFXihMGqPAq3DbMQTPF9AoL+qhg==
X-ME-Sender: <xms:aiX3aKJUQ4w9jII6ojRPfsoLw8bmWwE-vMOPiDCVSmdCc_Ma17RgmQ>
    <xme:aiX3aDqx03n7NVDXm4A-71ZXHDANSiXBKGt83n_YX-1pOKqaX2_bd89uKQH9X5lqa
    8rTARffDzmTe9-t-m3BrYAlGNlLG-N5AIfFDyslM2xEczBFctud>
X-ME-Received: <xmr:aiX3aDUg7XIAOg7-dyN3dlAFXSuQfRptLP4PiBaTif9kcg3A516IjBkhKedgew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeg
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopegurghvihgusehfrhhomhhorhgsihhtrdgtohhmpdhrtghp
    thhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtth
    hopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehhuhhghhgusehgohho
    ghhlvgdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphht
    thhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhrvghnii
    hordhsthhorghkvghssehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:aiX3aBZnG-ZV_4luYvFZpInhDnYtfDRG7P0tDbPX9MWlT8uXaFOc-w>
    <xmx:aiX3aEviEPwclsfWJ_0iXO_8_Aa55qLyoEWI7vz1M23KTlSqCEu7zw>
    <xmx:aiX3aIoBf-j0YZ_FDUN6TmK2qmANbmPNVQmdG3dyGIdOKBUNaBAt2w>
    <xmx:aiX3aEKaDNlUXOJmV5ONHKDtWHioydnBD5JTyYQJOwskcyh9ar4HbA>
    <xmx:aiX3aOz0zFfSTrsVWO04AryR85bzqMmoIOXlNHl2tcwU4ZwddTs2TMLq>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 02:17:13 -0400 (EDT)
Date: Tue, 21 Oct 2025 07:17:11 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH 0/2] Large folios vs. SIGBUS semantics
Message-ID: <cas6g5sw6bffqo5e634tmyivdamcagoynztic7s53634mv2kwk@6a552oryikew>
References: <20251020163054.1063646-1-kirill@shutemov.name>
 <aPbFgnW1ewPzpBGz@dread.disaster.area>
 <aPckWHAGfH2i3ssV@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPckWHAGfH2i3ssV@infradead.org>

On Mon, Oct 20, 2025 at 11:12:40PM -0700, Christoph Hellwig wrote:
> On Tue, Oct 21, 2025 at 10:28:02AM +1100, Dave Chinner wrote:
> > Fundamentally, we really don't care about the mapping/tlb
> > performance of the PTE fragments at EOF. Anyone using files large
> > enough to notice the TLB overhead improvements from mapping large
> > folios is not going to notice that the EOF mapping has a slightly
> > higher TLB miss overhead than everywhere else in the file.
> > 
> > Please jsut fix the regression.
> 
> Yeah.  I'm not even sure why we're having this discussion.  The
> behavior is mandated, we have test cases for it and there is
> literally no practical upside in changing the behavior from what
> we've done forever and what is mandated in Posix.

Okay, will fix.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

