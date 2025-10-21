Return-Path: <linux-fsdevel+bounces-64915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E59BF672D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5763E18893BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B512FB637;
	Tue, 21 Oct 2025 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="NkdawpGa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vfABFsS/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147535502D;
	Tue, 21 Oct 2025 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049711; cv=none; b=iL6F84160IT1F+ckFW6HwJrXmPOE9cr67eBl3dfzmAgg0FDqZR9zXa0EiHxXU5dUMsws1iB7lCIupDyvKiKSLaa65R24RcmNv9bS/jY/XZOtzYLnA8MTSDmLCfb/vQnA4Lpgh7sFysVumRPQwZCfgA9H1zuy9YXgCNl1q5yQccY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049711; c=relaxed/simple;
	bh=Hg+5HNqCADCJdoRHEh2O2qpjtgGgYV5VpFfgAZ3FcEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvtwstZgOl+5kEIr/kWI+DpF9VgRHoqbMRO7jYBeW/f51NGGjyQaTc3xJdAFGIwfl8FGFVBf5sS+7IZ4eRJfrw0XjeQL3qyD2RVbPGJviuxucWmxB0/gqsbNmCsMediBC+LYO/sR0moyeE3UTHZFuhenhcqTBNlf2ivFL2LyXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=NkdawpGa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vfABFsS/; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 3A3D71300A45;
	Tue, 21 Oct 2025 08:28:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 21 Oct 2025 08:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761049708; x=
	1761056908; bh=VwJV6k7KAy5PyI+RrheQP6UoFSX5NksO95Gumi0SSf4=; b=N
	kdawpGarW9mlGtlWvGFIharRVGnVhfcQVPTqQN6DxNcGoah6JyH45a5+dBj2Cozm
	dX3EUU7ZQ3qgzNtH94TnFQxGavpK1YxP1T7UsS3ffMfZplynyGEkT0LGpFmIlvQ+
	hyZG1xlkDru8fGi/YgsAbbHFuWwxAcAqKCZcLbKLwE+y/PQtmbpFSI0seGqiabY4
	RMYp63IfYvGyoSF8B1dR2vDm6JgJrdB5B0iW2erf0bs7anLmO70l9BplG2QJGNnj
	Zq0whnamzEVGgfQJjlXLYowOwWHBgRXjSrBeuhWNU/z5CaJ7AJyX+lMVA9o/BXXd
	vYtGKtuJq6nUg1DNgeYyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761049708; x=1761056908; bh=VwJV6k7KAy5PyI+RrheQP6UoFSX5NksO95G
	umi0SSf4=; b=vfABFsS/HHAWcMErFRnvQF5oA5FLojAadKCcRRDx3VQPw1YdmAW
	TXhvAVC+NvRFevUPeV0aPnW65ohgmqaBjkO3BCfqlJYytS4rlSTKRx1zisjU6q9d
	X5bINWQUDvDugE/emiCU1+kHd40jMReBb6cgXOjg0AVzsRcYYA/pc/sRysWuTk0b
	c5NXvLN+lNU6GAhc8vrpcwq2b6VO5U8sHhxkammKbHWkoQB0ZfIZLm1OLyTt+vfl
	QuJsQl6t+Uts71FLaIJ8We5R/dV7jWdcTR5DTuLFpcsTnGBhrmVX956Iq/x4AY7V
	uVl0e1KW1QApkbCahMVEuuoQXAue14mvuhA==
X-ME-Sender: <xms:a3z3aGN0srF7acnD0h97O8_3FXDVwcuaDB_cUCLUqnW69AHOfhoqcw>
    <xme:a3z3aBIsdQVGY50Ppx6nKnLD-8d7p1zEQiWpN35nRXsClcu8CRhkX6X8MJio3yn0h
    t_M6rQhj3ZQiBbnHHJOmeQFkLGaFG2q_kSo-G1iPRv_SqxjGp__m2ta>
X-ME-Received: <xmr:a3z3aEZW5Nla8tBAIu5ZyDfXtmBmVTJAwlCeZz4sB74fmbfmbeHk5LzigdbItg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeg
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrd
    gtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:a3z3aCQCzxYNVjBVDx8Z2rH2suuu5qxBLjs7h9T3g7fBT3ZCXKLQbw>
    <xmx:a3z3aPzgs8QGIGF0VdO9pJZKtSIr4lv-BNedlzmZF03OYzzIMbbmRA>
    <xmx:a3z3aAcJxn58t_mVWYCY-9Y23U1h-AT52j7CEPF1gTJ7sE8Re7Gqpg>
    <xmx:a3z3aNlUz-dat0UHVi5BADrS-vP-M9UjR9-NiCS28tiCkwpEBsQ9Nw>
    <xmx:bHz3aImgp9TZtPbdaxirqYGnhMuVOwvujC0eW9ojJNvpy3H2VX6x218o>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 08:28:26 -0400 (EDT)
Date: Tue, 21 Oct 2025 13:28:24 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/memory: Do not populate page table entries beyond
 i_size.
Message-ID: <esiue5bbvksdlopvt4wvzs24cvhh45xtf2jfyhqxi44w2r5f65@xw2ufks6rjdt>
References: <20251021063509.1101728-1-kirill@shutemov.name>
 <8379d8cb-aec5-44f7-a5f0-2356b8aaaf00@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8379d8cb-aec5-44f7-a5f0-2356b8aaaf00@redhat.com>

On Tue, Oct 21, 2025 at 02:08:44PM +0200, David Hildenbrand wrote:
> On 21.10.25 08:35, Kiryl Shutsemau wrote:
> > From: Kiryl Shutsemau <kas@kernel.org>
> 
> Subject: I'd drop the trailing "."

Ack.

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
> 
> Right, there are some legacy oddities with shmem in that area (e.g.,
> "within_size" vs. "always" THP allocation control).
> 
> Let me CC Hugh: the behavior for shmem seems to date back to 2016.

Yes, it is my huge tmpfs implementation that introduced this.

And Hugh is on CC.

> > 
> > Fix filemap_map_pages() and finish_fault() to not install:
> >    - PTEs beyond i_size;
> >    - PMD mappings across i_size;
> 
> Makes sense to me.
> 
> 
> [...]
> 
> > +++ b/mm/memory.c
> > @@ -5480,6 +5480,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >   	int type, nr_pages;
> >   	unsigned long addr;
> >   	bool needs_fallback = false;
> > +	pgoff_t file_end = -1UL;
> >   fallback:
> >   	addr = vmf->address;
> > @@ -5501,8 +5502,14 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >   			return ret;
> >   	}
> > +	if (vma->vm_file) {
> > +		struct inode *inode = vma->vm_file->f_mapping->host;
> 
> empty line pleae

Ack.

> 
> > +		file_end = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > +	}
> > +
> >   	if (pmd_none(*vmf->pmd)) {
> > -		if (folio_test_pmd_mappable(folio)) {
> > +		if (folio_test_pmd_mappable(folio) &&
> > +		    file_end >= folio_next_index(folio)) {
> >   			ret = do_set_pmd(vmf, folio, page);
> >   			if (ret != VM_FAULT_FALLBACK)
> >   				return ret;
> > @@ -5533,7 +5540,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >   		if (unlikely(vma_off < idx ||
> >   			    vma_off + (nr_pages - idx) > vma_pages(vma) ||
> >   			    pte_off < idx ||
> > -			    pte_off + (nr_pages - idx)  > PTRS_PER_PTE)) {
> > +			    pte_off + (nr_pages - idx)  > PTRS_PER_PTE ||
> 
> While at it you could fix the double space before the ">".

Okay.


> > +			    file_end < folio_next_index(folio))) {
> >   			nr_pages = 1;
> >   		} else {
> >   			/* Now we can set mappings for the whole large folio. */
> 
> Nothing else jumped at me.
> 
> -- 
> Cheers
> 
> David / dhildenb
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

