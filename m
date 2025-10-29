Return-Path: <linux-fsdevel+bounces-66211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAEBC19B93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 11:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73671466A47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 10:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44F730E0FB;
	Wed, 29 Oct 2025 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="QvtZDDQW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eEIX6CxS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5044026F2BF;
	Wed, 29 Oct 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733393; cv=none; b=nrWMY/5WHLxuDwds7Kghf16HR+TdFjNUkEZIBFJn+i/3LZ33oK2SfIXa6kjWrh1+eGoMlGtTvWDXLmUGxA5M9hyC4TZQxtDMxkHaaxvcAUPD9K84kYfOw/e2TVVaGYJ2WnLD0Qa6X2R7w9rSWQJd+tGjTqZT4OMMBbHjgUAkl+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733393; c=relaxed/simple;
	bh=kjNmqzCdBdjVNLBIsEuwWffdtMn4lIO1+Kr2vft1cBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLtAbvhKckSDlcTDxLCxSnDau7Islkg1gAUecLuB1vJ8KdktmRF+ShBAaO3aZvhCM5HmxDn84AlM80K5NrSsoMwKju6fAPdWLbpKSEoRUIExj/SUpa0uI6jEayOWgUw+VUa0KEAyVFqJ8ZQQGdpFAw1GswF8CF+pC7nkI7jnKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=QvtZDDQW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eEIX6CxS; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id EE62313800EC;
	Wed, 29 Oct 2025 06:23:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 29 Oct 2025 06:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761733389; x=
	1761740589; bh=+FDSli0Ph+bdYBu+TscfPXcdJYFYx/LYMRlry+8ZbcE=; b=Q
	vtZDDQW9pEdBAuAXgxnvLXFet8BhgvMj64eAfEieZJsGSKfdggXQ7Lu8rUVMZ9ED
	xxh8p3vftnb1d+RKtJ00wNKNNQ0uxcodP8zZjkA1FuoOJZ0M3rL1HOQ/oiO21WBX
	ORLwZuW8xKFdHsXX0nj/jYSMyGICCpPIkYYJW/lNSdzMvQB7BLQ8YOSLQVV8I0jl
	HOxp+ZhIXHdEFparR6fH9KHl0dCRSM+KLFA9dC2OUFEgeXLENp1dO1tBnKFc78+n
	XKGy8zr5F5VF00EkYSl8KqApFNKvO3iPZIaJAIXPhQp8L0K4AZoSYCLxk/TXrJ7y
	3GTTFfONQZloJiUj33tmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761733389; x=1761740589; bh=+FDSli0Ph+bdYBu+TscfPXcdJYFYx/LYMRl
	ry+8ZbcE=; b=eEIX6CxSlpYir8DMLvaYZs9klDBDvzZvWOTeqamZTjxt84uch//
	Sigb37GvtiqfVsapAg630PZZtxhnFR9ePvo18FrUeCdqf+dKxiH/+kCHYFcvxxjD
	oOiUTNdsFZHex8hu+ik65LxyAmayASorUBnvDC/iEA4kazibr9TKIsSGcqu/EAlz
	gqkf+1GrCeLQnBFk86AEy08TU3a63O4eB9bWl62b/Sii27aTiF2fpiCLRvuGg3VE
	w6tVBKSwtCFqIEeT5eVlq9v6yVBMEh+phG5KqFbMw1+iB2EexD70HeINaPDhpGqI
	onMpfg4RIRdsl1MltbyIVF9aUjUS4sVchrg==
X-ME-Sender: <xms:DesBafCIr96SHdLVEP-ppkZ3zTrNQkKQKZ_xZNORbigQMXDEqOk3pg>
    <xme:DesBadMEptUA5BbMaWv_gNgntmKBdjc7ZIjQHe3-4yKcLOqMwRzJfVzMDKz_SqpO5
    kKVJp9Xb293Aviz96fkaNq_rVnG3d-lomT6aBpjPHBGH1ZYVBLGGYA>
X-ME-Received: <xmr:DesBacyvN--A9IoQ57sFmqxDSjn4H-0uH_c6qjNoY1cw_qGlb4Z7_amF8iwGMw>
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
X-ME-Proxy: <xmx:DesBaQenYKO6Awlcf2f2OqlDhXwNlTwpYzafHsuzytn6ICrcPt-i-g>
    <xmx:DesBaX3RSp8lRmYJbORMxetuIv3d2yE2gpXvSv-IIGHRthCf5-Wgrg>
    <xmx:DesBaZk1Jcbo1zuURKahglAfAx4dFiFC6ySlby_1BDGjODtKhSMWrw>
    <xmx:DesBaeoiWzHVKzLEnt3Da9gb5QZDUceAejk8QwX9E27L_5PJs24VPg>
    <xmx:DesBaZs429W1TDgPTtOCx6BEsoyjQs5VmQv18QKCZj6li8Y3JSHbml6->
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 06:23:08 -0400 (EDT)
Date: Wed, 29 Oct 2025 10:23:06 +0000
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
Subject: Re: [PATCHv3 1/2] mm/memory: Do not populate page table entries
 beyond i_size
Message-ID: <l264zv6qfnvzhfdiwe3nzjydqz7w4t3ddumntopdq6qmyx4ktk@svdhieca6abe>
References: <20251027115636.82382-1-kirill@shutemov.name>
 <20251027115636.82382-2-kirill@shutemov.name>
 <20251027153323.5eb2d97a791112f730e74a21@linux-foundation.org>
 <hw5hjbmt65aefgfz5cqsodpduvlkc6fmlbmwemvoknuehhgml2@orbho2mz52sv>
 <9e2750bf-7945-cc71-b9b3-632f03d89a55@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e2750bf-7945-cc71-b9b3-632f03d89a55@google.com>

On Wed, Oct 29, 2025 at 02:45:52AM -0700, Hugh Dickins wrote:
> On Tue, 28 Oct 2025, Kiryl Shutsemau wrote:
> > 
> > > Also, is [2/2] to be backported?  The changelog makes it sound that way,
> > > but no Fixes: was identified?
> > 
> > Looking at split-on-truncate history, looks like this is the right
> > commit to point to:
> > 
> > Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
> 
> I agree that's the right Fixee for 2/2: the one which introduced
> splitting a large folio to non-shmem filesystems in 5.17.
> 
> But you're giving yourself too hard a time of backporting with your
> 5.10 Fixee 01c70267053d for 1/2: the only filesystem which set the
> flag then was tmpfs, which you're now excepting.  The flag got
> renamed later (in 5.16) and then in 5.17 at last there was another
> filesystem to set it.  So, this 1/2 would be
> 
> Fixes: 6795801366da ("xfs: Support large folios")

Good point.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

