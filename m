Return-Path: <linux-fsdevel+bounces-65904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669B4C14180
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 11:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C513B8133
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 10:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC974302152;
	Tue, 28 Oct 2025 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Oyq2398e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aeNQs7Ux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B19261B99;
	Tue, 28 Oct 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647018; cv=none; b=NYPa5EJIOfEVk37TBH44Af9UTqTQDeT+jXbu8WC8xReguQ9CJVpwFUI5AvgbDMvstsb0N6exRfTnfWk4Vph7L8zCqL4/Y8zkacmg1F0MTHWAPf32KhPCZJoeKBz327ees7dyC2WPrwZaXOOs51LSZSWu4s/5HHMlRCE05wtr9pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647018; c=relaxed/simple;
	bh=iHr+wXNAAxfv22cyt5B+ZttetoXR/mfD1KA0k8+kkzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hi0yKQfRG83t6rDD9WEUMI0+EbF20zAHWWK5zH6nRDaOP+WIL912WTYSmNiJUg/mMOM+qiOGOE4a8yvhMmNFiR2LE0F3yNsC6TEnAHk/TmdVVnPIUPjUduMhimTRWGujjUY1wbSO8yAyAy6rolN3w8Xaw0bmaVBGIXKLpaTewZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Oyq2398e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aeNQs7Ux; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id 5AD1C13804E9;
	Tue, 28 Oct 2025 06:23:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 28 Oct 2025 06:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761647015; x=
	1761654215; bh=UK17jhjkP7w/Yhqq+kaU6aiIJY1JQ7Cu6uzfy7TYG8U=; b=O
	yq2398ecmmEuY3UtO8v4pVZOsMw+yhMLoegZU4hLWk11TkY/gqsHOQ88s2w0IfZJ
	tTlo/xf7YkKlurbMt1ddus4f6CtbmZPrVSTbpazCNqoQzH0RCawN5E6OBmJSdc4K
	SvlQeYYqqhkBbG24J6jGiAf3El4r5Gj5ltbwsS6vNUyYt9tRJ2poCTlRPnc+wpTw
	S8mqE8i1nk5e2F5yvLQZZ5v41eDvZVXl9aBmRgEb2hTlHQoMYSeMlEiLDeW9PR2A
	NVotO2dDnjvDMAa39/IQPwHL2AxThZ8rkVfgO1kOj9sBJ7mwFSVo7BgoxmNJl9Ly
	2FHpMtpLP332NCe5/0l9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761647015; x=1761654215; bh=UK17jhjkP7w/Yhqq+kaU6aiIJY1JQ7Cu6uz
	fy7TYG8U=; b=aeNQs7Uxdv25R8tKlW04ilnqa5rPAHwr4fcUjxCwJvVP1ad8qj2
	1z85/e4syV2HzFJK+ALQ/aUegRZviRFaoEPNjJZw5TVbx7yr6X8mhMaZKe+uHJCy
	Sdcoy8ZcbwSBDYMz9i8Mh/aB3FsRtPg/luWgu5otcE2PnmNifIJYraFHdleMXHiW
	v29Rrp+xy3+W8xRoT//lGNQPWv2btp3ZxMPBcCiA7HHe/i7Q7PULVXn2llfMc4Ad
	n1Vl0qFLKkkltWiwGyI7iKLELxhhzPL6vin42vmiXTknkQhntvyH4NT7Mjg9ry20
	OqEzOy/UFaFLGPx00wvfPdrs7VPIETQp02g==
X-ME-Sender: <xms:pZkAafIf2z9PVZDiPFfpzMGBxMOfTPNX51G3oFci-vv5Ey9b5N6uFg>
    <xme:pZkAacMbioO9zVqztgLKA3TFWp99m5nzxX951njeqyGQNrDUTUOyfn7EyBPFtJimY
    eGw0c-kIqZFeAR1RZ8bkh30YgYbjWaN-9pVZ0WSNsL30yff3baP2Es>
X-ME-Received: <xmr:pZkAaaoaJLt-OhH12Rhvmumgke5P8QJd0NMn2tsHV0YrOXnzbjOoAaKTdm3PEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeg
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:pZkAaVcmuoFOvpGn3Uz-xLEZc1b_jDMyz64KfQDHAR1DXH-3MKRbLQ>
    <xmx:pZkAaTYCkg2qKMGZ2THGUM8vd79QZcQ0YzJ8J6Bd6MDHRD1e-6il5g>
    <xmx:pZkAaYDejv_qtoU15rmab71AbT-j3eES7oTYbfrSLWotLGLj1yHZtg>
    <xmx:pZkAaeBxk3_GzD-n6Gd3d__P3Y6pW2xbGQf4bWFXxOH3ng6K2eIaVQ>
    <xmx:p5kAaVDfUtv4zhKA7dAX3VaSUQU0e1M0bHcFyALgEp1w2qPlYhc91wix>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 06:23:33 -0400 (EDT)
Date: Tue, 28 Oct 2025 10:23:31 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] mm/memory: Do not populate page table entries
 beyond i_size
Message-ID: <hw5hjbmt65aefgfz5cqsodpduvlkc6fmlbmwemvoknuehhgml2@orbho2mz52sv>
References: <20251027115636.82382-1-kirill@shutemov.name>
 <20251027115636.82382-2-kirill@shutemov.name>
 <20251027153323.5eb2d97a791112f730e74a21@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027153323.5eb2d97a791112f730e74a21@linux-foundation.org>

On Mon, Oct 27, 2025 at 03:33:23PM -0700, Andrew Morton wrote:
> On Mon, 27 Oct 2025 11:56:35 +0000 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> 
> > From: Kiryl Shutsemau <kas@kernel.org>
> > 
> > Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> > supposed to generate SIGBUS.
> > 
> > Recent changes attempted to fault in full folio where possible. They did
> > not respect i_size, which led to populating PTEs beyond i_size and
> > breaking SIGBUS semantics.
> > 
> > Darrick reported generic/749 breakage because of this.
> > 
> > However, the problem existed before the recent changes. With huge=always
> > tmpfs, any write to a file leads to PMD-size allocation. Following the
> > fault-in of the folio will install PMD mapping regardless of i_size.
> > 
> > Fix filemap_map_pages() and finish_fault() to not install:
> >   - PTEs beyond i_size;
> >   - PMD mappings across i_size;
> > 
> > Make an exception for shmem/tmpfs that for long time intentionally
> > mapped with PMDs across i_size.
> > 
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Fixes: 19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
> > Fixes: 357b92761d94 ("mm/filemap: map entire large folio faultaround")
> > Fixes: 01c70267053d ("fs: add a filesystem flag for THPs")
> 
> Multiple Fixes: are confusing.
> 
> We have two 6.18-rcX targets and one from 2020.  Are we asking people
> to backport this all the way back to 2020?  If so I'd suggest the
> removal of the more recent Fixes: targets.

Okay, fair enough.

> Also, is [2/2] to be backported?  The changelog makes it sound that way,
> but no Fixes: was identified?

Looking at split-on-truncate history, looks like this is the right
commit to point to:

Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")

It moves split logic from shmem-specific to generic truncate.

As with the first patch, it will not be a trivial backport, but I am
around to help with this.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

