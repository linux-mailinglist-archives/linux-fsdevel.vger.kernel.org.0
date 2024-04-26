Return-Path: <linux-fsdevel+bounces-17938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749A28B4014
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 21:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96960B24271
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E68182AE;
	Fri, 26 Apr 2024 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r4HaL18d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481FC381B1;
	Fri, 26 Apr 2024 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159191; cv=none; b=QRPWIIqJWwvSAvUeLtmZDcfmtXdLIjIZL/o7AwNEkjRxNMADeK6PIcBIEnXVY+D4Sa1PL81zMu4i+BeWrd05ED2zgTQfLQuD9CvbvPjxat9F8pXwMHcwghyEbZIrlAT5BNsa/ez/YdMtKvB1pgSII827Nx5nJZjNO3USSR+CjPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159191; c=relaxed/simple;
	bh=TC7LQlrCZB3uq+KXiSH49G5kN/E4xe/gRBFwdygPLX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8Wq91ZamYz2l5SUKOMJdWjcU8Ncg2HN9UI6bMdo8FRlP1W68bC03MElwmPWDzWxYFgYA1Gs77dWU9ltkgo+ZS4DiojxIM7H4IwYVFVZ/42+fXZlu7nggEPwfBxwKb8mkwGAVGyC9GB/W+GSttSHRb0I7GyHLv1ckueGdgd+vMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r4HaL18d; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B3nzzU3zrnIN/j3XnmTMNrndFTXY08gHY8Wi6J3W1B4=; b=r4HaL18d8TtYOoQLK75q8eFCGs
	hO7VC1e+GhgCqw0e8lFnF+a/X5ytoFZVfxhNwbtYBWC30z1fp2tbbHTpmPXydfyBWERbN1GKihEgx
	5jiMxyZVFrq05iUvg6694kgBL/+2TyZCpar74oW9QrIIwZYINpicdrhzh04kc5/D3OX46H73VS2Mk
	fYQ2UFeLXyViwgsKyA99N/lgY9upT/BJmGZrMjr6nQa/vDzV9orWFsX1xiKSjiNfOAjtD86OaYkZ/
	+BTLTfE5di9EgqtlHMPaTOUvEPcEtvXVcx7VPLzS9YohDoY0AdTkmg2Mt65N56oO+BYFeoR2RY+2Q
	oN65hFjA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0R6p-00000005qwN-3Hjn;
	Fri, 26 Apr 2024 19:19:47 +0000
Date: Fri, 26 Apr 2024 20:19:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 7/7] iomap: Optimize data access patterns for filesystems
 with indirect mappings
Message-ID: <Ziv-U8-Rt9md-Npv@casper.infradead.org>
References: <Zivu0gzb4aiazSNu@casper.infradead.org>
 <871q6symrz.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q6symrz.fsf@gmail.com>

On Sat, Apr 27, 2024 at 12:27:52AM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> > @@ -79,6 +79,7 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
> >  	if (ifs) {
> >  		spin_lock_irqsave(&ifs->state_lock, flags);
> >  		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
> > +		ifs->read_bytes_pending -= len;
> >  		spin_unlock_irqrestore(&ifs->state_lock, flags);
> >  	}
> 
> iomap_set_range_uptodate() gets called from ->write_begin() and
> ->write_end() too. So what we are saying is we are updating
> the state of read_bytes_pending even though we are not in
> ->read_folio() or ->readahead() call?

Exactly.

> >  
> > @@ -208,6 +209,8 @@ static struct iomap_folio_state *ifs_alloc(struct inode *inode,
> >  	spin_lock_init(&ifs->state_lock);
> >  	if (folio_test_uptodate(folio))
> >  		bitmap_set(ifs->state, 0, nr_blocks);
> > +	else
> > +		ifs->read_bytes_pending = folio_size(folio);
> 
> We might not come till here during ->read_folio -> ifs_alloc(). Since we
> might have a cached ifs which was allocated during write to this folio.
> 
> But unless you are saying that during writes, we would have set
> ifs->r_b_p to folio_size() and when the read call happens, we use
> the same value of the cached ifs.
> Ok, I see. I was mostly focusing on updating ifs->r_b_p value only when
> the reads bytes are actually pending during ->read_folio() or
> ->readahead() and not updating r_b_p during writes.

I see why you might want to think that way ... but this way is much less
complex, don't you think?  ;-)

> ...One small problem which I see with this approach is - we might have
> some non-zero value in ifs->r_b_p when ifs_free() gets called and it
> might give a warning of non-zero ifs->r_b_p, because we updated
> ifs->r_b_p during writes to a non-zero value, but the reads
> never happend. Then during a call to ->release_folio, it will complain
> of a non-zero ifs->r_b_p.

Yes, we'll have to remove that assertion.  I don't think that's a
problem, do you?


