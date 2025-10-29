Return-Path: <linux-fsdevel+bounces-66210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E412C19AC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 11:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE3146603B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 10:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B33043D1;
	Wed, 29 Oct 2025 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="c55cm50o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i9JbQrZh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F42E6CB3;
	Wed, 29 Oct 2025 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733320; cv=none; b=V+8V3xA2kWCp2uJ2Om/BGIQGTisJRTmKZmoDe07fQPKR3MnWKkkMuyAT0rTgsKbx6n8pkXloiDZsx3XCFB6cHnDM05RW7sNC2G4bDFaLQ4yM/g0bceDG8ryGvPOoMc0D0hUQdyiPTixQ7hilvIIYCT8duN4lD3Z/fDBozZ59ASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733320; c=relaxed/simple;
	bh=g87PWdjnLiJj275M7ye5Aee00h8PJNzBRah4GOvxMb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG6OdnHbcKGSqZGktxocVrYrt8yfl9f/oxCL2RbJiUfr2oLjUZT1Kh5vDNORpUVTSK6yUT9+xjGba4z+MRLIw1TGq2UpD+kKvZOXr8kqNIUXAV4X5BrP4PUpsTfDMQBCzYLby50vpjLySyKnRFpnOcKBWAO0kXS+MHH6x1svnC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=c55cm50o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i9JbQrZh; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 4FB5C13800EC;
	Wed, 29 Oct 2025 06:21:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 29 Oct 2025 06:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761733317; x=
	1761740517; bh=IjPlh4vPDtY5DoDvg9FkkduZZQivHp+ZM+sz98NMyF4=; b=c
	55cm50oklPwOjk9DkdI/bM8yFEQbGwn/K/8ghiVrCZVJngXm1qK8CcMsuwP1veTB
	PX5EhQ694qIQH47nh8wpfFJZDXbPCbpGUyaK4HAKH6GSr2tCS7XGdBVra64X5wIV
	Pr2TCI4pswlJ0LUqK/pO73khpgiBq0mX0AugBqTHBrcWlCcB7rdSHsiDYGT6p7ZK
	+AeBonwr25hyCBiDj3We5HXoJYxPAJwbtJSdAwy/Eny49KZ08WDRclzFYEvCeScl
	r12wUGZ+52DghWuTDYFs2rUDaRqgj9mzKkO/aPAfvmbynyaWFT8dleE07v8pNLmj
	CNaUPh3K/8gLTW5aDEhMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761733317; x=1761740517; bh=IjPlh4vPDtY5DoDvg9FkkduZZQivHp+ZM+s
	z98NMyF4=; b=i9JbQrZhAzMnl2+U+McrmCMks9t7FgRB70Kdy0r6X3KlXI4pr01
	O7zS+zM8/l9xplrJRJvf+pH9MSCC5uL/LuyxSRfBrxcA+yhxQl74QkaUAS6i+Cad
	wtRkntu5imMfyfFQHfl+SpcAU35bXC1DJyUiDb27+eXI5G9U/KLSjFaNPTHeybVq
	BujZGcBkLzjBR0+FighbU2LNJ510AVfVlcyOHdvOiZt0Icug+hFZtXXKq8A966cU
	dny35j18vZPpvrLwXMyrxbamkvAxHX/lTd7sATOSMUrl59LSNTn1stgF824a+j3O
	wSfcbdExlXH5MbRULfFqsZbzev1B1MWoEjA==
X-ME-Sender: <xms:w-oBaV0vFJQXaGhtxf8pfyWicN2LNVegwRhMj0Mm7EZLUyzOIAmadg>
    <xme:w-oBaY7Ij-E7oY3rYUL5TyQsTVQRJ4ULEN2m-xDFgXmSn3qRWOGBiY6IkO6w5GHIf
    -mQ70XsF1MSNZlvCE6THy2CGBcdTsM2jkxflMNekaTd8H8cDjAx8E0>
X-ME-Received: <xmr:w-oBaaF9-QcR4Xxgik7Pld_HbkFReNnorRP-A4NpV8DyuYCmBj1B3CSA0tHgWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieefgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeg
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhhughhhugesghhoohhglhgvrd
    gtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:w-oBaQ-NJCdN2gljACnnW5K0wD9ePLkZYot84PFz5dPDHveZJD2b2w>
    <xmx:w-oBacM-98Jo0IefxgIP4l7EOAlOUB04h8ZRu569jq_iXc0ZTTnjFg>
    <xmx:w-oBaczFvGlwacveAMRFJg2OWwAZgnb6Kpuu3yda9ZJ7ogdHEIRG2Q>
    <xmx:w-oBaet86LLJKmh4LN_G65totUPRz7ivebBwXLJ9V56OogLp_gqo-Q>
    <xmx:xeoBaQF2PDgL6VeZdTV0YBCLE7XIIANhPP4wdjno2bJA118g8Ye95dMu>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 06:21:55 -0400 (EDT)
Date: Wed, 29 Oct 2025 10:21:53 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] mm/truncate: Unmap large folio on split failure
Message-ID: <xsjoxeleyacvqxmxmrw6dxzvo7ilfo7uuvlyli5kohfy4ay6uh@hsrz5jtkgpzp>
References: <20251023093251.54146-1-kirill@shutemov.name>
 <20251023093251.54146-3-kirill@shutemov.name>
 <9c7ae4c5-cc63-f11f-c5b0-5d539df153e1@google.com>
 <qte6322kbhn3xydiukyitgn73lbepaqlhqq43mdwhyycgdeuho@5b6wty5mcclt>
 <eaa8023f-f3e1-239d-a020-52f50df873e7@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaa8023f-f3e1-239d-a020-52f50df873e7@google.com>

On Wed, Oct 29, 2025 at 02:12:48AM -0700, Hugh Dickins wrote:
> On Mon, 27 Oct 2025, Kiryl Shutsemau wrote:
> > On Mon, Oct 27, 2025 at 03:10:29AM -0700, Hugh Dickins wrote:
> ...
> > 
> > > Aside from shmem/tmpfs, it does seem to me that this patch is
> > > doing more work than it needs to (but how many lines of source
> > > do we want to add to avoid doing work in the failed split case?):
> > > 
> > > The intent is to enable SIGBUS beyond EOF: but the changes are
> > > being applied unnecessarily to hole-punch in addition to truncation.
> > 
> > I am not sure much it should apply to hole-punch. Filesystem folks talk
> > about writing to a folio beyond round_up(i_size, PAGE_SIZE) being
> > problematic for correctness. I have no clue if the same applies to
> > writing to hole-punched parts of the folio.
> > 
> > Dave, any comments?
> > 
> > Hm. But if it is problematic it has be caught on fault. We don't do
> > this. It will be silently mapped.
> 
> There are strict rules about what happens beyond i_size, hence this
> patch.  But hole-punch has no persistent "i_size" to define it, and
> silently remapping in a fresh zeroed page is the correct behaviour.

I missed that we seems to be issuing vm_ops->page_mkwrite() on remaping
the page, so it is not completely silent for filesystem and can do its
thing to re-allocate metadata (or whatever) after hole-punch.

So, I see unmap on punch-hole being justified.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

