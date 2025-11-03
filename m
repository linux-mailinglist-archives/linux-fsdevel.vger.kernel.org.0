Return-Path: <linux-fsdevel+bounces-66818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A152C2CDF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CE3620763
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C231A815;
	Mon,  3 Nov 2025 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="GKVkfKCp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q9+n6eh6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B4C2FD68D;
	Mon,  3 Nov 2025 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183135; cv=none; b=P7Nxd1zcLbvhdhkHQxxtlfCPy2TERlDPmenZdyF8vwZGw5mBYGSjXlVLsjHbVi6P2uivz+a++fciouA0Z6I+GMjlE832nxR+AWW+wcCX59THSnwE7Zn+eKBx0Qzzw4vX4Ted0JJM0n6O68FfwsB9uXW15l3c1E1/Nl5cFshXFSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183135; c=relaxed/simple;
	bh=iszpCAy6sFYsfEAaqZCY831oj+qI9ozqOgjMqeWJfcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDnufqp4xYeJca8aYKNgd97P3P8qdfqwuyHF+sMCV/4Uj88yWn6WozT6R2Q1/qI8KGiFvHOGucmE3wN8EF6d9pZoxAJPNl/pFS8bPd5cmhX9j7zFeQoEaspbTr+ihYmK9T4WusHfZzR0g/titk6DdCk6VnjNYA5FB5rvTfkRWfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=GKVkfKCp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q9+n6eh6; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 8942613802AB;
	Mon,  3 Nov 2025 10:18:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 03 Nov 2025 10:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762183130; x=
	1762190330; bh=4J/yAIXHqePkPtS7iPxC2+IJeE7T8ALXXo4jnVmJ2eA=; b=G
	KVkfKCp3XUpsixALMrMjMXHL/XPGbl/tZhVvdyLsRrDIaeXlwzdSLgBIV9kln+xj
	w9euFJxbxx4kvirB0ZiS3oM0+Qy0ZPqCJV5lt7NqAcCUm2taV0lEIB6R3AOVFFcN
	/h4vSUlFnF8I1EhsRbgU4ZSagX7UcU01adXHKHYTFVcC4IIT32S6WVmbuGrSX0Ho
	OZEBdBORtda81bWO96DpEQPXPsDBGDU/H5YOzznpwfaFaOjLJl8dDwmPP3w2xiN3
	5BOLpw9amvOEA/byjWdsPqXLBC/l3M5ISk+/Wsk0/7QKm+8n/JPqiEOPXZLfYp6N
	6GVXO3SbtrHGmKuovwvAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762183130; x=1762190330; bh=4J/yAIXHqePkPtS7iPxC2+IJeE7T8ALXXo4
	jnVmJ2eA=; b=q9+n6eh6upRvk7AnE6iyQfhPbMJFpMjwznzPN6xvIgcBCntDMBK
	2Bwl4YnRNcJoJvwPixpcGbkml5GhwZOfa/cs8csnf3twevU7NspJN+BVOq1wzW0w
	cIJ0oBjFvXBsJn1wrmIROzTvx2d2k/G2l9fDBv5V3EfmanWFlgcrNYz2/BjT0jBh
	eIaMoQcBgI3wKxqE9rHDvD4pSDnbDcY5OjcfxFQcNIJ1mlZR1nmG59MS+8zp/Z51
	ELlEaG2bkL2eGZnLkqIzud4LzxFYNe0NQYDAQu7zBTHQ8RP3QsEwxfI9ozM5hct/
	UwB30L5cNfzCALvpqqT0tXCmADksAmJcIFA==
X-ME-Sender: <xms:2McIacop7ZLPyDZmZqCMPtVoMLvvifWq26Fs7qPGKqbkQanPkaTRnQ>
    <xme:2McIaaVdX0fp2WbXiCudCKi9wk5pvQqScGJNE9Ma-vKhXApPdZgdZcwCIhSwsfDgr
    HuWHDQJfDC-_ouNBYMIVJCzcuCjE3Orn8uRBeDFcZz_Hc1GiZwZi9I>
X-ME-Received: <xmr:2McIaTYth94jE5bZqanVXwDFhwBivA3ZJeZpHesE5x6WFVJF9mATT3etSJy5ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeekgeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:2McIaSlJnnzurptzxwq4E1GE_1O5XB-hA3ZQQs6OX1L2gyuSlBsZ7A>
    <xmx:2McIafdli3EKWC8nSTp5CKgjEanm2RACgHBv4GYs85PAwodb1nUi4w>
    <xmx:2McIaYsJgv0ZCZ5kJ8xFt8KmpI9G4LL8QZFjEGfAL140P2c7Eq2Xnw>
    <xmx:2McIafTMZGmCeJqp6FmoQ8Cc5fAraSPSJjuG-tkEDXcn_JoEPsgAFg>
    <xmx:2scIaf2rnwk2Pg9KZiL9pc_3dCGYTNdLWqgatSC77gINN-ED8YP1AsSv>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 10:18:48 -0500 (EST)
Date: Mon, 3 Nov 2025 15:18:45 +0000
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
Message-ID: <ctkrffqndi7tmw2d7vj5k7asotqe5z7ic4ux7wc3pqu6kyernk@sz34te5pkbmd>
References: <20251027115636.82382-1-kirill@shutemov.name>
 <20251027115636.82382-2-kirill@shutemov.name>
 <20251027153323.5eb2d97a791112f730e74a21@linux-foundation.org>
 <hw5hjbmt65aefgfz5cqsodpduvlkc6fmlbmwemvoknuehhgml2@orbho2mz52sv>
 <9e2750bf-7945-cc71-b9b3-632f03d89a55@google.com>
 <aQWT_6cXWAcjZYON@casper.infradead.org>
 <xadc6rbs7fkk2mb5b4reobqwue2kveo736r3wpa5zwted4daua@rgasjiwwot3g>
 <aQi9zaPxwLBTneF4@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQi9zaPxwLBTneF4@casper.infradead.org>

On Mon, Nov 03, 2025 at 02:35:57PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 03, 2025 at 10:59:00AM +0000, Kiryl Shutsemau wrote:
> > On Sat, Nov 01, 2025 at 05:00:47AM +0000, Matthew Wilcox wrote:
> > > On Wed, Oct 29, 2025 at 02:45:52AM -0700, Hugh Dickins wrote:
> > > > But you're giving yourself too hard a time of backporting with your
> > > > 5.10 Fixee 01c70267053d for 1/2: the only filesystem which set the
> > > > flag then was tmpfs, which you're now excepting.  The flag got
> > > > renamed later (in 5.16) and then in 5.17 at last there was another
> > > > filesystem to set it.  So, this 1/2 would be
> > > > 
> > > > Fixes: 6795801366da ("xfs: Support large folios")
> > > 
> > > I haven't been able to keep up with this patchset -- sorry.
> > > 
> > > But this problem didn't exist until bs>PS support was added because we
> > > would never add a folio to the page cache which extended beyond i_size
> > > before.  We'd shrink the folio order allocated in do_page_cache_ra()
> > > (actually, we still do, but page_cache_ra_unbounded() rounds it up
> > > again).  So it doesn't fix that commit at all, but something far more
> > > recent.
> > 
> > What about truncate path? We could allocate within i_size at first, then
> > truncate, if truncation failed to split the folio the mapping stays
> > beyond i_size.
> 
> Is it worth backporting all this way to solve this niche case?

Dave says it is correctness issue, so.. yes?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

