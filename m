Return-Path: <linux-fsdevel+bounces-37942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C2F9F951A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FE1168277
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06380218E8E;
	Fri, 20 Dec 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="o3ZOJkLn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJid2iDx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7638721883F;
	Fri, 20 Dec 2024 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707568; cv=none; b=symHYKORX7Xkq2eSeJRAsrlgcl2Uv2eAyTPtr+0ZGl9/SWUm5a4kGXXYDbRilAqXPt4DpjrrfNx85sBFmxvYx/5xfU8R6IR85W1tXjTKy7biPhjDF2kdcWdFSavi3sV4cOoxWGElyEhYCJx2I/a/9tWq8lH8GYHm1cwfqrr9FSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707568; c=relaxed/simple;
	bh=MFfM2z8344b1lYTieYFdaWyIcUB9bSzlj9QA9cgwpAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+NOm+oa5XmBZ5ryNiuhAFxDXBJ7dBP4iQv/ewwRKvVm22zLxZ/mKEpK9OEhEEzzASflep1xHmr3oMKDhtp56ZkoJVqDqPfsyEc9i5p0gjdI4Y/gSvymeFsAS8z4pscQYsgjdlO9AQV+anKKMKkpk2iEYhRONovGoZ1mTW1lppM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=o3ZOJkLn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GJid2iDx; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 4BC2111400BD;
	Fri, 20 Dec 2024 10:12:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 20 Dec 2024 10:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734707565; x=
	1734793965; bh=Ln3KfBUbf5aYkKoWzArBVrIUsq/MxGqwEATiIdv6HOA=; b=o
	3ZOJkLnZizQ2v3imWxCDM94Q3FxSPlg+Gr6A+aXK0yBXICkLt1L3QaQJHw520FT8
	UzSpc9bQOiZcHu3YWvKnpdPtf4CWrKKQigO/rkfTuN0+/VVQJnvLTnD/cQLvFfe2
	btB5AAyDmCfsPGz7s3w9fNFQF4VT22ICEjHoGbNLmdhwOM2eV3GvRu6DJG9sVqCc
	/D1zBaRGvuMUGxWD8kOt8f3Uy6F0MomBPKO3FFKnr8rFXIpy/Yfh0DjdzfyLq/XP
	XZ/jBugl2X11RPt6rjK7Jb0tJnGsgHsFZAFAy3hOXkgz932/48S7hDX9KR3nme0Z
	wm7Z3uiaunAT51SHZHo9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734707565; x=1734793965; bh=Ln3KfBUbf5aYkKoWzArBVrIUsq/MxGqwEAT
	iIdv6HOA=; b=GJid2iDxLUeS3Ib2md2cqahP/0PePS7D6Pkw4azASn18dPjQeGJ
	WtcZ3aIKZZeW+4j7WLX0LdD+SIPpRJMlSfBrGu8aV5+a7m6e2C/qeSP5Luk1wKFj
	SkcHNUd5RJIIzBkhAzP+lqKy0Gb7R3mZT51J86JWAYHmpVgUYHr4q5FRoOXMeMs9
	y6hIon9Tc8W1YOUD8LRieshI+aQ9xd21djrK3rNAcPDsx2TxZr9NRzfUPMKH7TJP
	7Gbva3krTHYkgsrjuH+162njWEL36NWVTuM/WIDaMegX8vqJMwlYv6PfFqaA0HM6
	4bVBL4D18OyDjVPD3f2E/cGYFBUYBnhFJSQ==
X-ME-Sender: <xms:bIllZ-bi402loCIy2-8xcwz0jMWoaA6zjFQhU5hyCM6yyXmAFVCvFQ>
    <xme:bIllZxZc4M-lN5sX7tY5vVOWqKsE9VC-WAWsfnCW5oUMTuhTAT1dNealJnBOaIBnQ
    1eFspqe-WhH3zcIHTk>
X-ME-Received: <xmr:bIllZ49R6wT1Wvyco8NEhq4qrL40UcW0UVmqpXJNyYiORkveLbAIeqLUw4vSsjrUMLMT8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopegrgigsohgvsehk
    vghrnhgvlhdrughkpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehhrghnnhgvshestghmphigtghhghdrohhrghdprhgtphhtthhope
    gtlhhmsehmvghtrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrg
    gurdhorhhgpdhrtghpthhtohepsghfohhsthgvrhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:bIllZwqgL_oK8fklfNx8-xFdhvF8HbuC5IsA00gkvNmzD35bTmQwUw>
    <xmx:bIllZ5rki8H6OY1w9l0ZG9y4bZbOg23vzdDq-npt9Hg8bg9UjARyOg>
    <xmx:bIllZ-RN0eIcyNzRzqLuCrbeFv5kBNF_lVb0qtgYsIKlKvOm6mmaxg>
    <xmx:bIllZ5qT5pccgVaAGHhXkOJXNz9TujyVnQo2uMGaba5S1eaESj5Afw>
    <xmx:bYllZ6ShpkMe_3b0yXz1FNB3iGE-eeOK6jngh0bCjTtom3T8euRulLS9>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 10:12:41 -0500 (EST)
Date: Fri, 20 Dec 2024 17:12:38 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org, 
	willy@infradead.org, bfoster@redhat.com, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 04/11] mm: add PG_dropbehind folio flag
Message-ID: <o4muibdbkbbgwpxgepzc2cwmtavovjathzn5zonxcjjkajyv57@xkfbtkef73ss>
References: <20241213155557.105419-1-axboe@kernel.dk>
 <20241213155557.105419-5-axboe@kernel.dk>
 <wi3n3k26uizgm3hhbz4qxi6k342e5gxprtvqpzdqftekutfy65@3usaz63baobt>
 <042d3631-e3ab-437a-b628-4004ca3ddb45@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <042d3631-e3ab-437a-b628-4004ca3ddb45@redhat.com>

On Fri, Dec 20, 2024 at 04:03:44PM +0100, David Hildenbrand wrote:
> On 20.12.24 12:08, Kirill A. Shutemov wrote:
> > On Fri, Dec 13, 2024 at 08:55:18AM -0700, Jens Axboe wrote:
> > > Add a folio flag that file IO can use to indicate that the cached IO
> > > being done should be dropped from the page cache upon completion.
> > > 
> > > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > 
> > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > 
> > + David, Vlastimil.
> > 
> > I think we should consider converting existing folio_set_reclaim() /
> > SetPageReclaim() users to the new flag. From a quick scan, all of them
> > would benefit from dropping the page after writeback is complete instead
> > of leaving the folio on the LRU.
> 
> I wonder of there are some use cases where we write a lot of data to then
> only consume it read-only from that point on (databases? fancy AI stuff? no
> idea :) ).

Do we use PG_reclaim for such cases?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

