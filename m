Return-Path: <linux-fsdevel+bounces-65686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD740C0C9BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 10:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABBD18876C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 09:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3D62367B5;
	Mon, 27 Oct 2025 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Wpyy6kjb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9/9wrY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5629F26B777;
	Mon, 27 Oct 2025 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556487; cv=none; b=gjmNUEsqK/oB7JA2bD0F3T00Gz98G/Wl84SldjwPEEUZvH6bzUU+IpcTU7SQbAxe/pwL/1h34uZXAuxx0Bvgn3r2yMjtLY1HeRMjvHwC39wMtWhmNq5ijEd8MjGFcwrDMHhbnKA3zivb7WIlYskXIJnlMX0PbEDmz6I/qNiZNjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556487; c=relaxed/simple;
	bh=q3GOMSfU5CP70Rt+I//1v3Z34/N3e4cGZm370GirGiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bemN+OPvfpSbx9VkjBHJ1sDxHjZw9uqUn/HGtXE41guO1gUwTcu1S91yHa5JnbLdHmC0XaRvJe0wRdpxysXz5D3G8KrMIhDYEi3C/SRM35+inYK+s0OmBK10EiZ98Rr3ZR4mdKBZw5uEuEGKE/k/XihHASo1xJFhZKrWM2S2oeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Wpyy6kjb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9/9wrY/; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 3AE2E138037D;
	Mon, 27 Oct 2025 05:14:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 27 Oct 2025 05:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761556484; x=
	1761563684; bh=ib3gQpzJ+dspAAgN4VDq9O7p0OnCeMLRAxqGQCUWjEk=; b=W
	pyy6kjbYZIpMNvsn6u8lWrvAgvG7AlrJ2FU/9CxigvrmTZ31s77EK1xWt+PLSSXX
	QI795DCVU/ll0ieqdqGhKVmVe+ZFD02N6xabxRowpwNWKX59XNkxTBp0XIHS7SLQ
	jP9Zs/1SUUQS2NDNg26lWETO8ENCwc1HY5xDOIokF1rBYMrhdRG4T0WZVWKXsvxG
	EC85Tx+VJTAKghTlJuIWVCja6NmFiGwFPqbqXuKfk1YfP9O0zuDRUl5KvNsj04Dw
	0xn2N1UnFhSj4GqmtOLiYROQ5wnkX6vFwj0rZWxKhzKRyoptDdjXKXkwFLsc/ozx
	1xquqnUs52ULyFer19YQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761556484; x=1761563684; bh=ib3gQpzJ+dspAAgN4VDq9O7p0OnCeMLRAxq
	GQCUWjEk=; b=l9/9wrY/4m6ICv1BZWsV1B8U8iuzjGoDhnacN2D7lZlqMo3YGh6
	0dxBonLjSShWUmMVrVZMhLjcvhw4dkmGxhrVtJc1+uQ359X1S4xikGK4/HBtFdwi
	dtDxLd/nbT4qt7fmS5jOyVk63WracO8WKf6GHRW1wQdtdyEG2kbZARHvHpKsHSUb
	NaCbOUvDPXBHZEbAqO0pKxtIJaeSWNQmCpDu47XRTFNWx+w3poZQpA3MaoV6pgCy
	HkMp+V4C0hAXGi2k9kSDAQd6ZswsNvZnWeCt5j2FiobOurKIzAyw3/tixAEk6OGr
	csIvaI2COCp+3qXuVNT62UMMgggyg+MJv0w==
X-ME-Sender: <xms:Ajj_aLAd4AjVLn68RIa5dKxZOS2fwdx1RhoJznr51abL8fGa_wDFrA>
    <xme:Ajj_aKnZykUeegM_rXiJusTi1rwrYye9zHzwpN3VKeCS4cHQviuoS4vXRAeZS_B2k
    Ny0c0Z-F5w0TwxWxQX70akou3pmoUQy_W0s3fJ6PByUIY-EiLm7jds>
X-ME-Received: <xmr:Ajj_aJiZWR8aRThPAADi3GInkvQkAazdCu378TuUW4GBMI-5fk539MdqzRDohA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejheekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Ajj_aK0F86OvsqKUuDmWYa16LQ3o-ZC5BZyx3yG0pFU_4B6j9XcVMg>
    <xmx:Ajj_aNRduC-zzQpaZiuPIkIN9-XuLgLGvxnho_tK99J_X0MfH-I7kA>
    <xmx:Ajj_aMbU23mxVz9IT9OZnusHvqvI8nnOss5kkS07yko1uufhkWArbw>
    <xmx:Ajj_aK4xI3Sbk46VwdtUNMgal6bd9PnChr_3OyYCnYa5ST2NlI3eIQ>
    <xmx:BDj_aGcNSJgQIduzTcOhuub8dUJubkX2r4cmqkFgLr8LLKpFmtr-r-3_>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 05:14:41 -0400 (EDT)
Date: Mon, 27 Oct 2025 09:14:39 +0000
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
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries
 beyond i_size
Message-ID: <rn5mz62oyfxn4awnylebnsfwp7ixhe5mgvcmnjt3eydglzv5av@eshh4ipljc3l>
References: <20251023093251.54146-1-kirill@shutemov.name>
 <20251023093251.54146-2-kirill@shutemov.name>
 <96102837-402d-c671-1b29-527f2b5361bf@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96102837-402d-c671-1b29-527f2b5361bf@google.com>

On Mon, Oct 27, 2025 at 01:20:42AM -0700, Hugh Dickins wrote:
> On Thu, 23 Oct 2025, Kiryl Shutsemau wrote:
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
> 
> Sorry for coming in late as usual, and complicating matters.
> 
> > 
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Fixes: 19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
> > Fixes: 357b92761d94 ("mm/filemap: map entire large folio faultaround")
> 
> ACK to restoring the correct POSIX behaviour to those filesystems
> which are being given large folios beyond EOF transparently,
> without any huge= mount option to permit it.
> 
> > Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> 
> But NAK to regressing the intentional behaviour of huge=always
> on shmem/tmpfs: the page size, whenever possible, is PMD-sized.  In
> 6.18-rc huge=always is currently (thanks to Baolin) behaving correctly
> again, as it had done for nine years: I insist we do not re-break it.
> 
> Andrew, please drop this version (and no need to worry about backports).
> 
> I'm guessing that yet another ugly shmem_file() or shmem_mapping()
> exception should be good enough - I doubt you need to consider the
> huge= option, just go by whether there is a huge folio already there -
> though that would have an implication for the following patch.
> 
> (But what do I mean by "huge folio" above?  Do I mean large or do
> I mean pmd_mappable?  It's the huge=always pmd_mappable folios I
> care not to break, the mTHPy ones can be argued either way.)

I assume you want the same exception for the second patch as well?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

