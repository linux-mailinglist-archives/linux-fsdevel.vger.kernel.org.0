Return-Path: <linux-fsdevel+bounces-64912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4088ABF66F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77FFB4F8315
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558D92F8BC8;
	Tue, 21 Oct 2025 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="R81bSYbq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W1VeU2RJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BFE1624DF;
	Tue, 21 Oct 2025 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049568; cv=none; b=ub8uoSDtnemdzKkzC+wpvoayWe2E5ebMlRASVhV44bPy8hzpd561tyek4PLzjjEyu9V/JnYz75LPz04IXblchaTgdDVhu5gj6A+iBmfyaB9OEveyQ7f5fAuS9adkCWzPflBmG6Tgz5in9+1JnDjIq7LuucaN8Gh1VFUILkzhR5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049568; c=relaxed/simple;
	bh=0PEtsvloNmwQCDyMxARARoH+FEDIQRKqpEzKjf54O+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNEqi+/vimDqZI9JhHKVczA2IkaKHI8guufuYD6YSmBYjkugL18kPj5b7ZCL17SSsc9nsyLX9EI/4Djm/HTXTaqwJZG6fR+HhltshQ+iAmshnhxQ/FRq+hqoT+i5TGcpCcelOlVwX8ABoLWc3B3XNxxgZDKgZqROWD4PzgzwqHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=R81bSYbq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W1VeU2RJ; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 04BDB1301707;
	Tue, 21 Oct 2025 08:26:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 08:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761049563; x=
	1761056763; bh=djRtuDlRtAFjq4Z1PijNjMkRiGn4dBTVZ3HLF99zBu4=; b=R
	81bSYbq5YLRO7a8qq7Hyv5a2M1QDd0MnFcE4Gs7wABPPJrpuoU2qbb9qEQH7zupf
	Q9OxbnaJxto1soDyqtrMR13kKZ8Hu7KiZ1bNVxWC5OrMid1Pg/IA8REI0HJyBTyO
	yKnPgAzft+AF+Mk1QNQ4QlULhatHlquF5ieogG6IU3D+bYCLIhu4e96wBkc/V6k1
	2nhx+df2oXkS8TVz9W5Xv9oAPc1YMirfmjRzqLkVajtYiTOn6P0e5UM+ghdXjiaG
	46huiHduyXyLg5hJ7WcEQPR/z+28ut/H4PCod33YkVBjOeKsY1bnTsp9D/n923aC
	Ee7cwsA18MKsuJKaZ0Kwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761049563; x=1761056763; bh=djRtuDlRtAFjq4Z1PijNjMkRiGn4dBTVZ3H
	LF99zBu4=; b=W1VeU2RJ1O8RBpYsWOK3vn6dPtBvCHrpWDNp2ISn8DJWwmN0c1k
	3Hdj3Fw8z4JIPy9ijoI+/rryCwYRx/uT1gyQt9Gzka9QQYohFRVxNlWua1HJUnCq
	Ilqmt0lllyhvwcNGamjVqwYAVsFgd+2SqzBbQPRbEQZZLLrmHM10y1QvenA5U8Yu
	NI0jzcFdFlz9dL7bvAvluMMvORo6ATDuTJfE8fAjSYDXeeB/+hOOp00X8x6EtgGw
	jaB3LkFVZd9vJIFY8/Xsj6pWFmjpHxFWDytBYWeSKKcKCvm4/E5et0vOaidUUgBD
	EFrvup6vyxe3fPaW2v2/iY6YlFNaELtnjzQ==
X-ME-Sender: <xms:2nv3aC7g3KMh1zu9rIreypk69t2XA44UdZeDu1eaz3rwcVGVB9WwlQ>
    <xme:2nv3aIFzgacwgrZY7u7o5iOZYY-cfozdH_iUzqqD3wcK6BXTKGCifDa1OmRNJIJB6
    ybQBzYMB0HrfKU3DbLx8pwzmHtzhFdVmJ_KgqNVikzxk7SxuOH1Cox2>
X-ME-Received: <xmr:2nv3aIl6oP2krUWtNALHbluoU5q_J18FmMR40lo9EXB-5Eoi-QJGp2_fZIUXnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtjedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:2nv3aKukQt5za1Jz9rGs7ZcEADvoJuxotbX_8ZP18Gs8EdZOaojR9Q>
    <xmx:2nv3aHdeaXuINDxOlvFdClzcuOqU-2taodAuSvqV4w_yX0dQbaOElQ>
    <xmx:2nv3aGb4LLDOmP4OxuDcoUL2038i2PXStur6Kz2dADMxARiyfa-IwA>
    <xmx:2nv3aEyaRnk_Xin70yZojUWcBUueOqPe138Zjx8cOl38HmUCYM8pxg>
    <xmx:23v3aFjPnu04kFNHdIzLR4y5NizJgqd4xCMVi5ELzI5CfbB0M8QCfrGf>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 08:26:01 -0400 (EDT)
Date: Tue, 21 Oct 2025 13:25:59 +0100
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
Subject: Re: [PATCH 2/2] mm/truncate: Unmap large folio on split failure
Message-ID: <vuvjogn4ivkf52zcdhgmu3pe6lwjaqauljmsua2uyzefrfk7vg@gir5o6uomem5>
References: <20251021063509.1101728-1-kirill@shutemov.name>
 <20251021063509.1101728-2-kirill@shutemov.name>
 <a013f044-1dc6-4c2c-9d9a-99f223157c69@redhat.com>
 <37ceab54-c4b2-449e-aa46-ffaefe525737@redhat.com>
 <eokncpih37zm7ypt6gn5xyetx6jlemhvvfdzpmdlxleqlsqcr4@45h5w5ahwugs>
 <e4349d5a-33e8-4b8d-b1ad-6192ba00ff66@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4349d5a-33e8-4b8d-b1ad-6192ba00ff66@redhat.com>

On Tue, Oct 21, 2025 at 01:54:51PM +0200, David Hildenbrand wrote:
> On 21.10.25 13:31, Kiryl Shutsemau wrote:
> > On Tue, Oct 21, 2025 at 11:47:11AM +0200, David Hildenbrand wrote:
> > > On 21.10.25 11:44, David Hildenbrand wrote:
> > > > On 21.10.25 08:35, Kiryl Shutsemau wrote:
> > > > > From: Kiryl Shutsemau <kas@kernel.org>
> > > > > 
> > > > > Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> > > > > supposed to generate SIGBUS.
> > > > > 
> > > > > This behavior might not be respected on truncation.
> > > > > 
> > > > > During truncation, the kernel splits a large folio in order to reclaim
> > > > > memory. As a side effect, it unmaps the folio and destroys PMD mappings
> > > > > of the folio. The folio will be refaulted as PTEs and SIGBUS semantics
> > > > > are preserved.
> > > > > 
> > > > > However, if the split fails, PMD mappings are preserved and the user
> > > > > will not receive SIGBUS on any accesses within the PMD.
> > > > > 
> > > > > Unmap the folio on split failure. It will lead to refault as PTEs and
> > > > > preserve SIGBUS semantics.
> > > > 
> > > > Was the discussion on the old patch set already done? I can spot that
> > > > you send this series 20min after asking Dave
> > 
> > Based on feedback from Dave and Christoph on this patchset as well as
> > comments form Matthew and Darrick ont the report thread I see that my
> > idea to relax SIGBUS semantics for large folios will not fly :/
> 
> Then I was probably misreading the last email from you, likely the question
> you raised was independent of the progress of this series and more of
> general nature I assume.

Right.

> > 
> > But if you want to weigh in...
> 
> No, I think this makes sense. It's a regression that should be fixed.
> 
> > 
> > > Also, please send a proper patch series including cover letter that
> > > describes the changes since the last RFC.
> > 
> > There is no change besides Signed-off-bys.
> 
> Then point that out, please. It's common practice in MM to send cover
> letters for each new revision.
> 
> For example, Andrew will usually incorporate the cover letter into patch #1
> when merging.

Okay, will do.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

