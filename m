Return-Path: <linux-fsdevel+bounces-66729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D74C2B32A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F98F3ACA23
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305063002B7;
	Mon,  3 Nov 2025 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Q2knTnHJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lVlBNiwT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E680C2D7803;
	Mon,  3 Nov 2025 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167551; cv=none; b=dUJ2GIZNIlbKPuvoCs0BOqmqvEaWvkjY1E7gsV6E7QbkVuBQ7ZbBfSwbDIOImpNr9RTAtrFTlEB8yLVg8hIDHgOxxVFg7sb52DRfzsDpCE/WhSYKpIYdJy3zst0eA8965uomcLbQ13mwCahFmdDaSFH2/TijtaH7dtpATuFpdtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167551; c=relaxed/simple;
	bh=ZBiwW+vApNaplywZ7BP26hNvG6P9w7aXkORucKrcHV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJDMs1ZGBrU5inZ6RlmaDrAWsjAHmed/L5Jzm4cIIrv8oEFzXhKLVsRZYB0ETpYxpJyb4Zv4joVF/AfHHNvl0F9qHMy4833VS+CHE2aW3T2MR6YUn9iHzCzYcr1SbEfeTrHI71jCOd8pfa9OZ+w9Z4vhFAQHVFYj+IDkmm9KDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Q2knTnHJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lVlBNiwT; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id C602513003AD;
	Mon,  3 Nov 2025 05:59:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 05:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762167545; x=
	1762174745; bh=+4NQ+5V5v/JGdSry3DxICjbmhUscqySQtyw/XKVp7C8=; b=Q
	2knTnHJpCxm/V+t/6L2eXw8ev9sqJ4+v8FOdLFzCmXayS841G+ajjojZc3mVGWo1
	R/rFK56aHJkZ1jBIx0YT8KWoMPrdvg5RguHvKvlK9bEknZ64YZBSbfq/tH4L3oP6
	jvetTJXEFdx1+IcFzhY3jQ3CEr8JzNmsV5Q9XmZPmWWZOzKWjXKM5nI7tlPPWEAl
	NE8/tnEEZUGs32nXtTnC9VhfN1PaBSjvoFFG7kEhd6BZnqFopGoRkp6S/bTJgctA
	I6UVrx/JYJ9vvjkOiHQAXLhyvF5SXfflFOuv7ksbPP5vBXeq2ironAjhr0h4LhPZ
	I8vaa/XNOBLCecDBwkefA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762167545; x=1762174745; bh=+4NQ+5V5v/JGdSry3DxICjbmhUscqySQtyw
	/XKVp7C8=; b=lVlBNiwTkjN8wsYrqTh12ENcFZ1ihIQHs9QDHRYujxGBg4EaMby
	yKdjdrdnFNHVTvRGMx+qJdHXDvjOm16nbBy+e3I5HCiOC3dwLajHn6CAbokwlUyW
	TrIsXspuYJC5CLWz05By8CNnsjCjQCMzTKazQ45ewTPwY/0OJFEWaf0VWpKaIzzZ
	ELZ3pSfmOZ7zlJChYfSOVzFWWFTCoyFjGqdqFt84f2N8Sh/6TL8iGS8MIU5xBXvB
	vMPd9jTsdFhRKU/oQ5OkX9mAOmgLyBPaK24v5lnfyfrzHcX2X1ohuhitfc406b2r
	kNsdhdnEfaxw30A7qh35vEc9H6ke5IiGpXQ==
X-ME-Sender: <xms:9ooIaWdpcp6jmTbiN5aIhEsQsac_oYPEgtSv2-xYRFY9MkQd2V3ZWg>
    <xme:9ooIadB6CyFhmtFnVz7JCCojqBEyBUF_R0NcTtzlyPxEhFJ9VdHrzMJhlup6_KTDv
    BwBDgB5fyQsKOQvQLBh7ZuAPczjwPK4ZGFm5dAd2H20XRSKb3b-gg>
X-ME-Received: <xmr:9ooIabuvo8IgbLOqK2r44-zrQF4cMwEzGLbSXlPBMuFogAHLsR_QO_ZnSwwhGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeg
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvg
    grugdrohhrghdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphht
    thhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    epuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:94oIaSE-l0bqLj1DMOX4Xt-klS_pL6IlF9w2BfNKAtsbuHytbb07vw>
    <xmx:94oIaW3Pegr5WO_ZGDTy_3Yfxoe2V1tZ8Iz6p2ivYvN2J4-07Cn9OA>
    <xmx:94oIaS4actkpP1P69yNXCMCeDC7HHElOHKLN46hnyVxhUuP1JNg5sw>
    <xmx:94oIaaV2RfNWnQLiVkbvvW6DXvGpS1sywTYvjz1dGfeZycLOU-xu2A>
    <xmx:-YoIaVNuEwv4ZFAuSeU1Yd4rcsmlBos7lni2xBITnXmInUmd7XxEezEG>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 05:59:02 -0500 (EST)
Date: Mon, 3 Nov 2025 10:59:00 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] mm/memory: Do not populate page table entries
 beyond i_size
Message-ID: <xadc6rbs7fkk2mb5b4reobqwue2kveo736r3wpa5zwted4daua@rgasjiwwot3g>
References: <20251027115636.82382-1-kirill@shutemov.name>
 <20251027115636.82382-2-kirill@shutemov.name>
 <20251027153323.5eb2d97a791112f730e74a21@linux-foundation.org>
 <hw5hjbmt65aefgfz5cqsodpduvlkc6fmlbmwemvoknuehhgml2@orbho2mz52sv>
 <9e2750bf-7945-cc71-b9b3-632f03d89a55@google.com>
 <aQWT_6cXWAcjZYON@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQWT_6cXWAcjZYON@casper.infradead.org>

On Sat, Nov 01, 2025 at 05:00:47AM +0000, Matthew Wilcox wrote:
> On Wed, Oct 29, 2025 at 02:45:52AM -0700, Hugh Dickins wrote:
> > But you're giving yourself too hard a time of backporting with your
> > 5.10 Fixee 01c70267053d for 1/2: the only filesystem which set the
> > flag then was tmpfs, which you're now excepting.  The flag got
> > renamed later (in 5.16) and then in 5.17 at last there was another
> > filesystem to set it.  So, this 1/2 would be
> > 
> > Fixes: 6795801366da ("xfs: Support large folios")
> 
> I haven't been able to keep up with this patchset -- sorry.
> 
> But this problem didn't exist until bs>PS support was added because we
> would never add a folio to the page cache which extended beyond i_size
> before.  We'd shrink the folio order allocated in do_page_cache_ra()
> (actually, we still do, but page_cache_ra_unbounded() rounds it up
> again).  So it doesn't fix that commit at all, but something far more
> recent.

What about truncate path? We could allocate within i_size at first, then
truncate, if truncation failed to split the folio the mapping stays
beyond i_size.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

