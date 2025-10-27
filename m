Return-Path: <linux-fsdevel+bounces-65693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF872C0CFCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 11:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F5C189401D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 10:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8B12F6910;
	Mon, 27 Oct 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="PCJzgJtt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xiqxl8wy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C8D26F29C;
	Mon, 27 Oct 2025 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761561612; cv=none; b=q1gAI/NI1yFXbf/Mrx9OgiUzMqTjSndiw83jyagvNFESrwxH+BdDnxC8G+BWVVp2L3bPlmaAsYYaH4yqZrlBETQqIsqaoOdNsLZboN0QNf7eKVHW5vBarakMELt7zucBZ/yr56L/WXC1lkJBcGqCeEuOGYeOya99IgiBbCIJxJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761561612; c=relaxed/simple;
	bh=++3D0Tc5JJ23J7PCYVAyZZZSGI4YrMqiGvKnariS0bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxhlFvKMwyyZdMJd83ter1XBHPs74Jg0YNMDLy7YllcN9ffjaU59/TOm7xFqMxOwOhGRDYM2ej3DCXhgCnKtuM7ktkVBZCZYRgguHG+Vga8NTg6wPVlVmSiZm+oo09cUTpqiMGcG1Koll4sM0uGdeKJ7VnYV2NjG+1I49fo02LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=PCJzgJtt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xiqxl8wy; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id 35CFB1380262;
	Mon, 27 Oct 2025 06:40:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 27 Oct 2025 06:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761561609; x=
	1761568809; bh=J5CcOF0C2/ovI9Kf7WL/hZcJiwTY902lhGxvmOPQI6g=; b=P
	CJzgJtt5dAoV8zeL8X0lxYn2Qo4veQXJvbY8jGok+uZzilSpisKjhoGQJfzWoWG8
	e4xIs3PJ2lcAGSzXqsi8E5h1bI+cxfwzInHcUwxzavFeTte8tvLPR/JIIsyxnNve
	ohQZ0QEWn7OseFVwoYa+9MWbUD0+oMl0WRIAghIChFDyAMiVSEQMvPVKWiYUy6Ap
	XVC+MbXgPZMhX/FaMvooF0C+Fuxictkz9jFqIWwLKRKke3nX+x8QfSZEtblxnWb3
	6eCE0mY2sqeFfff4voAKEbkXzo2AQI7ogO425Q61OXg6+w8RgaeEazgTDosUzJMG
	f3aZkyCDdDnZ56RJklf8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761561609; x=1761568809; bh=J5CcOF0C2/ovI9Kf7WL/hZcJiwTY902lhGx
	vmOPQI6g=; b=Xiqxl8wy2eezShYtWPExGsK3jlkuwh5n8AQWQss9+0ok+f+VP41
	UxLy3eaCrWpNHotHsebHtvKgXQgq3OfYSuKcT3BHUR9OwH5nmQ8YkMFuWKMKwtO8
	UqumRJ0dnM7UaWvN2O8FNeUdZPF3Qbue9SDOp7az5Il0pEIVGA5eQHChXvRFzVhu
	eAWaAwIu4y019yhILqjttlQ9U2iltbhok2QlEUQBWn93mGrTds683rekZZbRAev8
	8GPSUV8F85I7Pik9etBXlqldlTd7ZNv9pdfsd93GMOiP1t+bpFn2VU91ZFkfX9or
	jyZZ2BCbXiDTcuYt0NpRnvJc2uzV5/CYQdw==
X-ME-Sender: <xms:B0z_aABhHTXyAc9gywNkg40h5ypJplx0CY0QJx4wrb2xkr7HuebJVQ>
    <xme:B0z_aLliGpToF8gtI04iMoqF2kWSLtUeDvvkn_KHPW8Xy2n2MPFXwOcFLWI9UNMGA
    GB3sTCkq0OQCMgxE-3N-oGTkjPnp6bH4pZYcTIYfmc3Sn9-GOA7KUJs>
X-ME-Received: <xmr:B0z_aGhVGydf4aIWEc5HGCw6Xu9AoTNMwFLQxR1XzhXS37ErkSS1wBKvDK050Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejjeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:B0z_aD3d7IOpUEH6nfto9rwvKaqbSf02e0QrfL9xl2oaJgtlaI6n0g>
    <xmx:B0z_aCSGhJ3s1q9UrX279aQu7CavvQoSgMNRwLGVVk7lHG3ibPADNg>
    <xmx:B0z_aNbewC8p69Y3STPH3qX6-wLiUX3bimrPjz2qIfrI9Vug-cZuMg>
    <xmx:B0z_aH7actSeoaL6p0LQO9TS_jYBqkikxndFchvqrE14-dndwt-3-g>
    <xmx:CUz_aCh2oiJbFTOucV9lLdCMUcF4Q5ZcIK9KeA9H8wm8Eo4MRa1m6UK2>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 06:40:06 -0400 (EDT)
Date: Mon, 27 Oct 2025 10:40:04 +0000
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
Message-ID: <qte6322kbhn3xydiukyitgn73lbepaqlhqq43mdwhyycgdeuho@5b6wty5mcclt>
References: <20251023093251.54146-1-kirill@shutemov.name>
 <20251023093251.54146-3-kirill@shutemov.name>
 <9c7ae4c5-cc63-f11f-c5b0-5d539df153e1@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c7ae4c5-cc63-f11f-c5b0-5d539df153e1@google.com>

On Mon, Oct 27, 2025 at 03:10:29AM -0700, Hugh Dickins wrote:
> On Thu, 23 Oct 2025, Kiryl Shutsemau wrote:
> 
> > From: Kiryl Shutsemau <kas@kernel.org>
> > 
> > Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> > supposed to generate SIGBUS.
> > 
> > This behavior might not be respected on truncation.
> > 
> > During truncation, the kernel splits a large folio in order to reclaim
> > memory. As a side effect, it unmaps the folio and destroys PMD mappings
> > of the folio. The folio will be refaulted as PTEs and SIGBUS semantics
> > are preserved.
> > 
> > However, if the split fails, PMD mappings are preserved and the user
> > will not receive SIGBUS on any accesses within the PMD.
> > 
> > Unmap the folio on split failure. It will lead to refault as PTEs and
> > preserve SIGBUS semantics.
> > 
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> 
> It's taking me too long to understand what truncate_inode_partial_folio()
> had become before your changes, to be very sure of your changes to it.
> 
> But if your commit does indeed achieve what's intended, then I have
> no objection to it applying to shmem/tmpfs as well as other filesystems:
> we always hope that a split will succeed, so I don't mind you tightening
> up what is done when it fails.
> 
> However, a few points that have occurred to me...
> 
> If 1/2's exception for shmem/tmpfs huge=always does the simple thing,
> of just judging by whether a huge page is already there in the file
> (without reference to mount option), which I think is okay: then
> this 2/2 will not be doing anything useful on shmem/tmpfs, because
> when the split fails, the huge page will remain, and after 2/2's
> unmap it will just get remapped by PMD again afterwards, so why
> bother to unmap at all in the shmem/tmpfs case?.
> 
> But it's arguable whether it would then be worth making an
> exception for shmem/tmpfs here in 2/2 - how much do we care about
> optimizing failed splits?  At least a comment I guess, but you
> might prefer to do it quite differently.

It is easy enough to skip unmap for shmem.

> Aside from shmem/tmpfs, it does seem to me that this patch is
> doing more work than it needs to (but how many lines of source
> do we want to add to avoid doing work in the failed split case?):
> 
> The intent is to enable SIGBUS beyond EOF: but the changes are
> being applied unnecessarily to hole-punch in addition to truncation.

I am not sure much it should apply to hole-punch. Filesystem folks talk
about writing to a folio beyond round_up(i_size, PAGE_SIZE) being
problematic for correctness. I have no clue if the same applies to
writing to hole-punched parts of the folio.

Dave, any comments?

Hm. But if it is problematic it has be caught on fault. We don't do
this. It will be silently mapped.

> Does the folio2 part actually need to unmap again?  And if it does,
> then what about when its trylock failed?  But it's hole-punch anyway.

I don't think we can do much for !trylock case, unless we a willing to
upgrade it to folio_lock(). try_to_unmap() requires the folio to be
locked or we will race with fault.

Maybe folio_lock() is not too bad here for freshly split folio.

> And a final nit: I'd delete that WARN_ON(folio_mapped(folio)) myself,
> all it could ever achieve is perhaps a very rare syzbot report which
> nobody would want to spend time on.

David asked for it. I am fine either way.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

