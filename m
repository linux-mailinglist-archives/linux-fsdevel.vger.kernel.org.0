Return-Path: <linux-fsdevel+bounces-24160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF8E93A983
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 00:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A0ABB22497
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 22:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642DD1494B9;
	Tue, 23 Jul 2024 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="serpAH42"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98D41474AF
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775270; cv=none; b=YuHltlFt+3VYe+YpRXPV+20ZQ5h86vTYfgSJoiueuMUHsqCEiTV6GnFw83sxwnUheUD+Jt3M2Y0pn0pAR8U2fNk61zQVlL9YGRbRsfcKq8qyKrotlUspvKxutLlEUU7JEZovLttTja1Le6VuaKAprs+zf14dY0oH/QsRmf+4eog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775270; c=relaxed/simple;
	bh=er4VwfZk7RZ0AYyhg/XBNRQg0PxBhW7nnZL4AeETzcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WL4oGPGN/fVzqQuhJxl5zViptBUOqx1Hw7EGZUhM7yfG6LAo216nnpusITx37crC7MrvNSYsoX9UH2QnlRzCb8ORoi7TAN3R/wIbme2LSswYl0WFrd1CmYprr5MWGQVd+Hl39uFCrDOCmpI+aCKGXhd4m4/vQ/NIdsJ2Vy2pgWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=serpAH42; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Dbh6OFDQBPrSWi5fvbfyypKOrEuh7eYjLex/rIejfJE=; b=serpAH423PRKaeY1rxovkaa/FI
	xQYjBOWRZ11drN70os6izErBkW0YGHTKThi2SW9S8FBH1AGTlpAQi+sZInPgkSBvB6c5LDD2POlk9
	jXJfa6SP5unEdpcBdYLZ2gKXjWB9/qcULeam7l33+yi0ZdqEYzbrlmBcmeNjQmfvevVuGh6MndRG0
	DHwRCa5MZYCJetcGkFlYC40ChiwKGFDpIan+TGVyoxTpZedmWfdDDakWKieE3D5nZqL1QQlC5Jl6L
	ltQBFRU072EYqXGy6+qZY6eY3Xy12V41M0odP8nPYsvvC5Sdsok6EomgTYYvpVXse5XB1WU9jNkDz
	Cy70jKYA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWOOn-00000007HC3-2yiL;
	Tue, 23 Jul 2024 22:54:25 +0000
Date: Tue, 23 Jul 2024 23:54:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/23] Convert write_begin / write_end to take a folio
Message-ID: <ZqA0oachCIQ1Uj6E@casper.infradead.org>
References: <20240717154716.237943-1-willy@infradead.org>
 <20240723-einfuhr-benachbarten-f1abb87dd181@brauner>
 <Zp-uLk9wCP5tIc6c@casper.infradead.org>
 <20240723-gelebt-teilen-58ffd6ae35ec@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723-gelebt-teilen-58ffd6ae35ec@brauner>

On Tue, Jul 23, 2024 at 03:41:37PM +0200, Christian Brauner wrote:
> On Tue, Jul 23, 2024 at 02:20:46PM GMT, Matthew Wilcox wrote:
> > On Tue, Jul 23, 2024 at 09:49:10AM +0200, Christian Brauner wrote:
> > > On Wed, Jul 17, 2024 at 04:46:50PM GMT, Matthew Wilcox wrote:
> > > > You can find the full branch at
> > > > http://git.infradead.org/?p=users/willy/pagecache.git;a=shortlog;h=refs/heads/write-end
> > > > aka
> > > > git://git.infradead.org/users/willy/pagecache.git write-end
> > > > 
> > > > On top of the ufs, minix, sysv and qnx6 directory handling patches, this
> > > > patch series converts us to using folios for write_begin and write_end.
> > > > That's the last mention of 'struct page' in several filesystems.
> > > > 
> > > > I'd like to get some version of these patches into the 6.12 merge
> > > > window.
> > > 
> > > Is it stable enough that I can already pull it from you?
> > > I'd like this to be based on v6.11-rc1.
> > 
> > It's stable in that it works, but it's still based on linux-next.  I think
> > it probably depends on a few fs git pulls that are still outstanding.
> > More awkwardly for merging is that it depends on the four directory
> > handling patch series, each of which you've put on a separate topic
> > branch.  So I'm not sure how you want to handle that.
> 
> I've put them there before this series here surfaced. But anyway,
> there's plenty of options. I can merge all separate topic branches
> together in a main branch or I can just pull it all in together. That
> depends how complex it turns out to be.

I've rebased to current-ish Linus, updated to commit f45c4246ab18 at
the above URL.  It all seems to work well enough, so I'm not relying on
any later commits.  I can rebase it onto -rc1 when it is tagged, or
you can pull it now if you'd rather.  It's missing the R-b/A-b tags
from Josef & Ryusuke Konishi.

