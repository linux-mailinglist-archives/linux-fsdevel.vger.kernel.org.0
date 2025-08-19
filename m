Return-Path: <linux-fsdevel+bounces-58248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE0FB2B820
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 05:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5DE7189E06A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 03:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCD3261B9C;
	Tue, 19 Aug 2025 03:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="F96eFffC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OyUpNN6c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6D3C33;
	Tue, 19 Aug 2025 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575791; cv=none; b=qGrJ1LFZFbGyHKZI9wfn+EdncvA5tmSoWqC+nV/ZE5G2dP2qiOYTm80SZi1mFG6VTuWF68TbWFOJZcnmwsRMA0K1P0XJsHOn6HLwOEO7tGNIwjUdJmmn5hPp/u/P1iEjp9iQGjLbvhztWEhUrntyUuPtiP2UltYs/RaK1JeUtBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575791; c=relaxed/simple;
	bh=8Pu4St0BJexa2DE6N44WjaWOev6wOJ+/BGggZlH6j9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRrboxTbVUo8hNLh9YnkUFh7FjI1BxhJQ0XmrSICau7h8m08PRXfwNLpk5UnU9XMR+nhQl4ZIMQZtF4zko+UdQdtSJafu/0qKPXN3AP/P6BmC0vaEeTDa3RK3SmoTXtenwe1XVcW90PyPNe67HuBB6TAFDZNHzBsxiniNmapnAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=F96eFffC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OyUpNN6c; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EADEA14006F6;
	Mon, 18 Aug 2025 23:56:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 18 Aug 2025 23:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755575787; x=1755662187; bh=Sq6GkPmQrm
	6lLwWX2E78iMIaD4F38zFJ0qyBMJln7so=; b=F96eFffC2rSRSIncMc5tLJCbml
	pK8T1JcKzLiMtmNqxXHXqZrGcqWJGACucPZz2+BmSJlNx2Pb4jRsPQnnH4TfU4p2
	1gfpKcdz2d1sWyU/zamMYG+b1k9E14qAgSp2yfrNldialj4mRWQ2pq6On/vRNehz
	0YZJOJ9ubarkbI2n3uEgoj4XjKd3EGNWVcDRPhbaZ8mx1Q/Z6YtwjMNyMFaRKxDl
	aGDUHRRq3nBCpXwPVKKvY3xNkgWY9OcT6G6T/VY/6w55PkP+xY1rKwWj+fsPIbzX
	QtF7i8O/7DAQUbkmwFYtpmyyVDM035Ny+QxPMfwlTnurw5oey6Yrs6iCTong==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755575787; x=1755662187; bh=Sq6GkPmQrm6lLwWX2E78iMIaD4F38zFJ0qy
	BMJln7so=; b=OyUpNN6cAQgJc351sAYUZOLuG2GM+GKurO+RGICO31kEfVwsRXc
	EfhEDUkUlHuy28HlexLOffvylJKLcMOtHvDfuz9IIkCGDFjrLp3KuB+0v5CFFbFK
	LPmMApad5fUtm+XUBUNUqz69c3SLSbz5fqNrN91u9PUs1/acSC/9NBJg///blFxY
	FovHGzmZR8ENCjZqMqDoF2/qL9Hj/sPYk1GRAwYD3AF4L2xeJH4Je3+8NsnDc1Sl
	QSsWRxHLd3ATrzMNLA+2wYmxcmj36p6HnsgvFT6quKmBSDv65NKN6R2lvXeHz7/X
	XSlFMdl7wtkd8A1d7aWhdYerNbWNqFfbnBg==
X-ME-Sender: <xms:6vWjaHHi5R4GFAO1gja_PaoTuo-ksJc9tKs3pd9qMUbDCpAi4EKx7w>
    <xme:6vWjaJ2GCbZGE_QMuVx74eXtu4t45cvOTEuanOJ8bFkpS0THjHYUW1ln4IjHtXLVO
    FtfTWOHHCqGz8g6w6Q>
X-ME-Received: <xmr:6vWjaIMwunqUCLseJ2P3PMcHOKGRLymNASxVi6qSjOl8GDwlrjgvB4UiOB_3L64O4sSSBxE2_qhfuca8mo6Y0q3P7GI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeggeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeduvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthhtohepshhhrghkvggvlh
    drsghuthhtsehlihhnuhigrdguvghvpdhrtghpthhtohepfihquhesshhushgvrdgtohhm
    pdhrtghpthhtohepmhhhohgtkhhosehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6_WjaJZnOaU9FgovccDnrYK3V49BVD0Q6X4e-pPOqTGi6HMd5zLWdQ>
    <xmx:6_WjaGxdNNGZLbX9lWDqyGUR_wWGEz_s2tG1BHfsFEH3QFLMn-M-Sw>
    <xmx:6_WjaIPwumM39yT_zcevAO_eZsWTXEM9Bq-NioEdGaK2gyOS9tqSjA>
    <xmx:6_WjaFe53yLXVr5fjH8bpfFhEw8k7FMxsMA5g1cg41g_qtveEG7-9w>
    <xmx:6_WjaODwRtx7oOnv6B0m8XpMwlVq4bz-JD0cm41AZu7zcCcxjhV6OE_F>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 23:56:26 -0400 (EDT)
Date: Mon, 18 Aug 2025 20:57:01 -0700
From: Boris Burkov <boris@bur.io>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com, shakeel.butt@linux.dev, wqu@suse.com,
	mhocko@kernel.org, muchun.song@linux.dev, roman.gushchin@linux.dev,
	hannes@cmpxchg.org
Subject: Re: [PATCH v3 1/4] mm/filemap: add AS_UNCHARGED
Message-ID: <20250819035701.GA740459@zen.localdomain>
References: <cover.1755562487.git.boris@bur.io>
 <43fed53d45910cd4fa7a71d2e92913e53eb28774.1755562487.git.boris@bur.io>
 <aKPlkhXY9CON4x9v@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKPlkhXY9CON4x9v@casper.infradead.org>

On Tue, Aug 19, 2025 at 03:46:42AM +0100, Matthew Wilcox wrote:
> On Mon, Aug 18, 2025 at 05:36:53PM -0700, Boris Burkov wrote:
> > +++ b/mm/filemap.c
> > @@ -960,15 +960,19 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
> >  {
> >  	void *shadow = NULL;
> >  	int ret;
> > +	bool charge_mem_cgroup = !test_bit(AS_UNCHARGED, &mapping->flags);
> >  
> > -	ret = mem_cgroup_charge(folio, NULL, gfp);
> > -	if (ret)
> > -		return ret;
> > +	if (charge_mem_cgroup) {
> > +		ret = mem_cgroup_charge(folio, NULL, gfp);
> > +		if (ret)
> > +			return ret;
> > +	}
> >  
> >  	__folio_set_locked(folio);
> >  	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
> >  	if (unlikely(ret)) {
> > -		mem_cgroup_uncharge(folio);
> > +		if (charge_mem_cgroup)
> > +			mem_cgroup_uncharge(folio);
> >  		__folio_clear_locked(folio);
> 
> This is unnecessarily complex; mem_cgroup_uncharge() is a no-op if
> the folio is not charged.  Sure, it's a wasted function call, but
> this is a rare error path, so minimising size is more important than
> minimising time.

Makes sense, thanks.

> 
> So you can drop the 'bool' as well:
> 
> +	if (!test_bit(AS_UNCHARGED, &mapping->flags)) {

I do use it once more for the stats, so if we do ultimately decide those
are worthwhile, should I keep the bool?

I can also put the checking in the stats function, in which case we
could drop it after all.

