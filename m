Return-Path: <linux-fsdevel+bounces-27221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E682F95F9ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C701F23D02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9CD1991D5;
	Mon, 26 Aug 2024 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n0VnPxq1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AB8130ADA;
	Mon, 26 Aug 2024 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701630; cv=none; b=IitgZV6IYpbm+e3HBq8Wj3KXdOc0xw2C8z0zB/ivkokkkCyavXMjH3B59WdcimyWkby4VLQMmrtUWc7g6dGQSP0hCWxWXHMicvTHqFInKITr+sVNQ7lRf8Omkh7vhTQDvvxaJUiH+e9VwKChyZ1nUgvAtKqRs/7x5WVgYSdGeEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701630; c=relaxed/simple;
	bh=1l+UcRRihFinCeQkAhh3WeCzdyaLBGa7D12uLhRQgvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLz3dAXviHMIGac6dkGZ9fne7qeXi6HHM2/8f6u1zk0GvF5OoLk6P/8qJeWveekoGfrweFy+HehN1DX8eWv+OegpeDQkfg5L/yX+kVwlzgNCXUgXQCXny14PR9TuOfAecMLRjz8VjvuO6PQ9Ct+N4VVmvfCqNlr4evhAa4G5ZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n0VnPxq1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hBFh3cA2kmH2dkDFxpJSjKEkaQyWfxc4ceQWYnieJHc=; b=n0VnPxq1/cHl3id8AuHRGWQFSz
	LfIfWHT4xoCyQ1o6oc5Ezn0NtdfxljghXB/BT2xy8DNoKM4K1iOSAACgo43JnBexawiQkax3ePXWs
	fWLn7C3ET0FeAqipbn3R5uUNKM1Z8sUDXRz8K6B2xi304aGgPDVRhmk3pVcLFWw6UNshrWE3Aq+bC
	zbELhyb7tZ0sLvIz8JKLR17ynZcG88rPjYM2+voXAPi+FzNbV833syhi/su7xlhy05Qrpt58+vFlT
	lJhObAZhGcns6yUUgH1dyBkIPgXICIgWwcCwuVaaijFDaaZP5o7bmt6zSBRZYjrV7VU3q3qpVxwGv
	7vWb5Jsg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sifg8-0000000Fw1N-097R;
	Mon, 26 Aug 2024 19:47:04 +0000
Date: Mon, 26 Aug 2024 20:47:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <Zszbt8M5mUPZjbFq@casper.infradead.org>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
 <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
 <Zszado75SnObVKG5@casper.infradead.org>
 <rwqusvtkwzbr2pc2hwmt2lkpffzivrlaw3xfrnrqxze6wmpsex@s3eavvieveld>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rwqusvtkwzbr2pc2hwmt2lkpffzivrlaw3xfrnrqxze6wmpsex@s3eavvieveld>

On Mon, Aug 26, 2024 at 03:42:59PM -0400, Kent Overstreet wrote:
> On Mon, Aug 26, 2024 at 08:41:42PM GMT, Matthew Wilcox wrote:
> > On Mon, Aug 26, 2024 at 03:39:47PM -0400, Kent Overstreet wrote:
> > > Given the amount of plumbing required here, it's clear that passing gfp
> > > flags is the less safe way of doing it, and this really does belong in
> > > the allocation context.
> > > 
> > > Failure to pass gfp flags correctly (which we know is something that
> > > happens today, e.g. vmalloc -> pte allocation) means you're introducing
> > > a deadlock.
> > 
> > The problem with vmalloc is that the page table allocation _doesn't_
> > take a GFP parameter.
> 
> yeah, I know. I posted patches to plumb it through, which were nacked by
> Linus.
> 
> And we're trying to get away from passing gfp flags directly, are we
> not? I just don't buy the GFP_NOFAIL unsafety argument.

The problem with the giant invasive change of "getting away from passing
GFP flags directly" is that you need to build consensus for what it
looks like and convince everyone that you have a solution that solves
all the problems, or at least doesn't make any of those problems worse.
You haven't done that, you've just committed code that the MM people hate
(indeed already rejected), and set back the idea.

Look, it's not your job to fix it, but if you want to do it, do it
properly.

