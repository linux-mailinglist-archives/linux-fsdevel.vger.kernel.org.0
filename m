Return-Path: <linux-fsdevel+bounces-66209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360CCC199E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 11:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A79B426D8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 10:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CEB2E7F08;
	Wed, 29 Oct 2025 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="SVEKhXK5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S0QENVzD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B722E888A;
	Wed, 29 Oct 2025 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732720; cv=none; b=D13fHW8pk3MnAdu0nHF/sL1CJyBoniXyrPcjD27W5azdOqASuDCtIeAkVkLDPsOZvieN9t79NX2HvfwQvXCmXDncSYsZnnuHUAKHOF1iBB0KkHFWy1/v9Wtbz+XcTqZYSfrq/xAu/PNUhRDQdO33IMd2zoX3SfrOpBb+ZPynaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732720; c=relaxed/simple;
	bh=SM63apfLDACdH8j9XOGHvzLDTOFE7TRicfVmIm0MrFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svzGooxePu/xWhfbmoSh+ZtZUN66vRiyGWBadellSwNIwNIAGX1Vrjz0SfEv0Pe7YTGNXzd6eVCXTkbe0pH79HXbiK8e2kenhkMqDLM13c4LK7EPiuYLXbXZUcB9f6xD5SRMH9b+DbGrmHGYvN/ETSRV/VgNOOKVaZBBvuFETTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=SVEKhXK5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S0QENVzD; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id 526F513800B6;
	Wed, 29 Oct 2025 06:11:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 29 Oct 2025 06:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761732715; x=
	1761739915; bh=fQYcWk4qBSw8yxndIGua6DOrTN7MNNasIXpj5Zvlj0w=; b=S
	VEKhXK5c6LFW9isXMw+HLLHAP6fSPEuZFJ1c3CuDm3IWRZdx7UKkUW/2FObd3aSk
	YkNpuSYlpc2WNrQmCIJ03rjhhbcpH4lJbki6NtbS/BoF4z35Rp/4aFJVkYqlvQu7
	Jy3BFlvmFd3hB3AvsX8ZoaVOldapGwq/9XmOEmQhmR/xufDWr/WPvRle1QbrrW9D
	8IHygUMPp7le4hCtUHX15CINnO9O+t/9z6qWF/Evvhw5U3V6r7JoNp68ivlh5LUB
	MV48ezb05xLuxC+Ck7qf68TvsdtUO0kQe83jylJeCPNSNoF7GjqEvkycghBkLapm
	fR9Qr3iOa56ZNaEHUFr2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761732715; x=1761739915; bh=fQYcWk4qBSw8yxndIGua6DOrTN7MNNasIXp
	j5Zvlj0w=; b=S0QENVzDgUwMR7eY+vAnD4RBq9DFaSM92Vg8JhvLEuj6DeqqNYc
	7mnMCc4IyICjre7ZZ9kNtnoj+NKcM0j5Hog1tNRB15pYqn3u+vrppe9NdDMpGCEQ
	fuwlsp6Yryqw8RfP76mDLmrn9tjroIGdqGrJ+MiGNGbFr/40rNiUlT/nMequlBSG
	e6h24I9HVNdvL+TPlvqOQilJo3x5LBmSfh/+wXjcaKYPDoUizF/armm6Mc1nrjAa
	yVw41Um/blekjsLf8+kvKPhPIKecSQs2r6pn+XKbfQSnOl4Fc6/FZvFYxduwrJ+j
	0bygpEqU5pWqer62mXdmLbbJmcxykvvQsmQ==
X-ME-Sender: <xms:aegBafANSD1fuUWZ0v6m-SiRyvr65VzyAKdfiMWLGtP0VmPM3aUE3g>
    <xme:aegBaemk5fKBmypcCcDr_uej9CFIvBJmgMau7nAq7et4vFpq4HUPR_mlJPaiqbUrU
    27XFo8cRFf6G5GfZvy3uXfXRkFrPcXSGrSEwuXdhzcq1PnH6URLkZA>
X-ME-Received: <xmr:aegBadijXcXUgXxwzcVCpdvPt1gY0u4MuMOAaodUAlinen_6vi2YnOfXOkGe-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieefgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeg
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhhughhhugesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    rghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:aegBae3i4OeX1v2tI89vH399VXsdDV4ad3VFAvjh1eYo6IhVuJ8pvw>
    <xmx:aegBaRQSx0cI4StlFMzzFiLYEPM3MmBLWl9Kz8bTrO18w5d_hDqlXg>
    <xmx:aegBaQYUEJm8bRLRcx1bxvxxkk81Fcw6tKwt7xZU7v5ZKMdcKxdjig>
    <xmx:aegBae6fNX0u1VrBUg_3J7s8MRXF_9-lZoqlxYCd3SE8XStTjnTzag>
    <xmx:a-gBaaeyvRdca66Ug_Q7G96lsSxaWl3YMxVQ5Z-ctmWd91aznQJ0s0eS>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 06:11:53 -0400 (EDT)
Date: Wed, 29 Oct 2025 10:11:50 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Hugh Dickins <hughd@google.com>
Cc: David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
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
Message-ID: <xtsartutnbe7uiyloqrus3b6ja7ik2xbop7sulrnbdyzxweyaj@4ow5jd2eq6z2>
References: <20251023093251.54146-1-kirill@shutemov.name>
 <20251023093251.54146-2-kirill@shutemov.name>
 <96102837-402d-c671-1b29-527f2b5361bf@google.com>
 <8fc01e1d-11b4-4f92-be43-ea21a06fcef1@redhat.com>
 <9646894c-01ef-90b9-0c55-4bdfe3aabffd@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9646894c-01ef-90b9-0c55-4bdfe3aabffd@google.com>

On Wed, Oct 29, 2025 at 01:31:45AM -0700, Hugh Dickins wrote:
> On Mon, 27 Oct 2025, David Hildenbrand wrote:
> ...
> > 
> > Just so we are on the same page: this is not about which folio sizes we
> > allocate (like what Baolin fixed) but what/how much to map.
> > 
> > I guess this patch here would imply the following changes
> > 
> > 1) A file with a size that is not PMD aligned will have the last (unaligned
> > part) not mapped by PMDs.
> > 
> > 2) Once growing a file, the previously-last-part would not be mapped by PMDs.
> 
> Yes, the v2 patch was so, and the v3 patch fixes it.
> 
> khugepaged might have fixed it up later on, I suppose.
> 
> Hmm, does hpage_collapse_scan_file() or collapse_pte_mapped_thp()
> want a modification, to prevent reinserting a PMD after a failed
> non-shmem truncation folio_split?  And collapse_file() after a
> successful non-shmem truncation folio_split?

I operated from an assumption that file collapse is still lazy as I
wrote it back it the days and doesn't install PMDs. It *seems* to be
true for khugepaged, but not MADV_COLLAPSE.

Hm...

> Conversely, shouldn't MADV_COLLAPSE be happy to give you a PMD
> if the map size permits, even when spanning EOF?

Filesystem folks say allowing the folio to be mapped beyond
round_up(i_size, PAGE_SIZE) is a correctness issue, not only POSIX
violation.

I consider dropping 'install_pmd' from collapse_pte_mapped_thp() so the
fault path is source of truth of whether PMD can be installed or not.

Objections?

> > Of course, we would have only mapped the last part of the file by PMDs if the
> > VMA would have been large enough in the first place. I'm curious, is that
> > something that is commonly done by applications with shmem files (map beyond
> > eof)?
> 
> Setting aside the very common case of mapping a fraction of PAGE_SIZE
> beyond EOF...
> 
> I do not know whether it's common to map a >= PAGE_SIZE fraction of
> HPAGE_PMD_SIZE beyond EOF, but it has often been sensible to do so.
> For example, imagine (using x86_64 numbers) a 4MiB map of a 3MiB
> file on huge tmpfs, requiring two TLB entries for the whole file.

I am all for ignoring POSIX here. But I am in minority.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

