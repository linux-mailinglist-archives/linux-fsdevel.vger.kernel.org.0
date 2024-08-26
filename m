Return-Path: <linux-fsdevel+bounces-27209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7D695F886
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A5F1C22691
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 17:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A40198E90;
	Mon, 26 Aug 2024 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lv5whbQa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A783B189514;
	Mon, 26 Aug 2024 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694574; cv=none; b=KBkJ7URuMxwup7m6ZkM5h1ZXXr34SLdXXLFB8VzPqDTIOofMgdYNlGMI2NT1ygtxao2vDKC6wcbQ/dFftFIKh+ZyOcrYHdWEQej97m0EpZmbtn4X8ULhlsTwttp3i+2LtC3BY6GHTn8/v7cLbto4xowWZJ5g6ZaBQNH5ju/q85Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694574; c=relaxed/simple;
	bh=/fvHumsZRk/iQRklCYhfM+dnrHnoK56xzQNPOdXJCqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NacqAG2PWk3mUpl0i7YK9vvcFykqE6bRidChGtvkVQSxuC+587Gzk5cC6sTTuhy6X2vCwuQcRLnpztDm9kt/PzfTdG4L8tFjx5eMvtL85R2yapEPlL0ct0D2DvN+SdKCxYxlw/3ybxbFaaMEAGX7ILAEhevfPpl3pLiSZ+t+Ryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lv5whbQa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7xddByF+J259CfYZChb9DiOYTiqHH+VZ+4O/gx155pM=; b=Lv5whbQaKS5ynYmO3e+1slhM9I
	8JO8hXToy/OoACu0csu+2YFyGLla4Q1sT3y3FQYtgMEMLgGIQnhiSGUkkKFzOTfGXCSy8kNP5NCo9
	Y499QZUW2oNdniKK/d1MSSsAtmfFcI+ZZhxUUQpRsLoJpaLMRsxEt8iW1FT0DkOcS8Hl6y7ItK8ee
	V3i4cNl7KcykQXodCJwQubaKoAIsG6ZLX3txCTN1SKM+tSskDpuOljPPcZyLGv/Enfp5Nh87Witu/
	S7iSSk1TQQ5RN9WNOzfkltDo7lp2Lh98YgBEU9cna16scOeqk3bFkPpeHuyDBphlMckSbGoRg67H5
	vFiXn/pw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sidqG-0000000FhWF-0URm;
	Mon, 26 Aug 2024 17:49:24 +0000
Date: Mon, 26 Aug 2024 18:49:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: drop PF_MEMALLOC_NORECLAIM
Message-ID: <ZszAI7oYsh7FvGgg@casper.infradead.org>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-3-mhocko@kernel.org>
 <ZsyKQSesqc5rDFmg@casper.infradead.org>
 <ZsyyqxSv3-IbaAAO@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsyyqxSv3-IbaAAO@tiehlicka>

On Mon, Aug 26, 2024 at 06:51:55PM +0200, Michal Hocko wrote:
> On Mon 26-08-24 14:59:29, Matthew Wilcox wrote:
> > On Mon, Aug 26, 2024 at 10:47:13AM +0200, Michal Hocko wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > There is no existing user of the flag and the flag is dangerous because
> > > a nested allocation context can use GFP_NOFAIL which could cause
> > > unexpected failure. Such a code would be hard to maintain because it
> > > could be deeper in the call chain.
> > > 
> > > PF_MEMALLOC_NORECLAIM has been added even when it was pointed out [1]
> > > that such a allocation contex is inherently unsafe if the context
> > > doesn't fully control all allocations called from this context.
> > 
> > Wouldn't a straight-up revert of eab0af905bfc be cleaner?  Or is there
> > a reason to keep PF_MEMALLOC_NOWARN?
> 
> I wanted to make it PF_MEMALLOC_NORECLAIM specific. I do not have a
> strong case against PF_MEMALLOC_NOWARN TBH. It is a hack because the
> scope is claiming something about all allocations within the scope
> without necessarily knowing all of them (including potential future
> changes). But NOWARN is not really harmful so I do not care strongly.
> 
> If a plan revert is preferably, I will go with it.

There aren't any other users of PF_MEMALLOC_NOWARN and it definitely
seems like something you want at a callsite rather than blanket for every
allocation below this point.  We don't seem to have many PF_ flags left,
so let's not keep it around if there's no immediate plans for it.

