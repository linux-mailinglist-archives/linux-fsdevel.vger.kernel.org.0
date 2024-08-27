Return-Path: <linux-fsdevel+bounces-27457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4242C961965
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC441B21CB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09261D1F59;
	Tue, 27 Aug 2024 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iUucECIa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA612C475
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795225; cv=none; b=a+wmW6zAq7B90Ix0/B2xVM6qsDAVXzSAZA4Qh4W0TInqSs3O7OptfCYWoVnHiTb4SrNFhNQ5V+C5WZDnXadNsjv4RpW0h03QNka4z0n/iS7EDqUn92outzhkqNrHeClx2a1U8kpFZGV57KWvC8FsdIvgvhAfbLvSrgiYqxkjvnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795225; c=relaxed/simple;
	bh=Ax1pDMOiKvuV8NOcRhuYiYudA83dxs1GKx/MJKX/WZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wi5ruFqo541j4owPC1hbAVuWMEYlLJQpKavqLJ6Y5G8dNJ+8ZIk53RlLuuOM6luGjbOvDKDvXcS8jyodvFesy9vNAwm1Dx9iyTRd3WDb3tXftSPzHzKDFzunIx+mz3hITGH9WIIuJIM+6qkO2nAxeAZrSzvCU3oB/7OzHMKWwbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iUucECIa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d7o1HafLFiMPj88i30XYJxwy5qlx30t76sXgEMzduBM=; b=iUucECIaV5ulEHrKuqTKceRVHN
	EGMljxtCOmQhkz0zLMLAaqK9XttOgrWXrkhQY6edgoox5tiS4dUG3rQq3IYRXoDoeSD2JG/Do6B5L
	RoZpgRq1xul22QFOi4rSlFsR6Z+lVdq9LAnc7hsKIDg5aZGwckFbwj0DQE53M0xmLh9pgjhlcKvWA
	nLIG1ik6V00bC0Z6+JlIxZBM2Ao/VJjUo5Ur+6HQPUUsQJETsHVr5U2CvseZlGcKeI3nQYZwM+1rN
	fuUoW+Sih0M1yIRHVbsYY53XefeOy7F8zD/T8WIsLbk1rYVnBJ1P1SlKtUqZgP17dRTi/a91oBw/x
	6a5kwuRA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sj41h-0000000HK5r-4BBb;
	Tue, 27 Aug 2024 21:46:58 +0000
Date: Tue, 27 Aug 2024 22:46:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
	joannelkoong@gmail.com, bschubert@ddn.com
Subject: Re: [PATCH 01/11] fuse: convert readahead to use folios
Message-ID: <Zs5JUcQlI13LG8i4@casper.infradead.org>
References: <cover.1724791233.git.josef@toxicpanda.com>
 <aa88eb029f768dddef5c7ef94bb1fde007b4bee0.1724791233.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa88eb029f768dddef5c7ef94bb1fde007b4bee0.1724791233.git.josef@toxicpanda.com>

On Tue, Aug 27, 2024 at 04:45:14PM -0400, Josef Bacik wrote:
>  
> +/*
> + * Wait for page writeback in the range to be completed.  This will work for
> + * folio_size() > PAGE_SIZE, even tho we don't currently allow that.
> + */
> +static void fuse_wait_on_folio_writeback(struct inode *inode,
> +					 struct folio *folio)
> +{
> +	for (pgoff_t index = folio_index(folio);
> +	     index < folio_next_index(folio); index++)
> +		fuse_wait_on_page_writeback(inode, index);
> +}

Would it be better to write this as:

	struct fuse_inode *fi = get_fuse_inode(inode);
	pgoff_t last = folio_next_index(folio) - 1;

	wait_event(fi->page_waitq, !fuse_range_is_writeback(inode,
				folio->index, last));

> @@ -1015,13 +1036,14 @@ static void fuse_readahead(struct readahead_control *rac)
>  		if (!ia)
>  			return;
>  		ap = &ia->ap;
> -		nr_pages = __readahead_batch(rac, ap->pages, nr_pages);
> -		for (i = 0; i < nr_pages; i++) {
> -			fuse_wait_on_page_writeback(inode,
> -						    readahead_index(rac) + i);
> -			ap->descs[i].length = PAGE_SIZE;
> +
> +		while (nr_folios < nr_pages &&
> +		       (folio = readahead_folio(rac)) != NULL) {
> +			fuse_wait_on_folio_writeback(inode, folio);

Oh.  Even easier, we should hoist the whole thing to here.  Before
this loop,

		pgoff_t first = readahead_index(rac);
		pgoff_t last = first + readahead_count(rac) - 1;
		wait_event(fi->page_waitq, !fuse_range_is_writeback(inode,
				first, last);

(I'm not quite sure how we might have pending writeback still when we're
doing readahead, but fuse is a funny creature and if somebody explains
why to me, I'll probably forget again)

> +			ap->pages[i] = &folio->page;
> +			ap->descs[i].length = folio_size(folio);
> +			ap->num_pages++;

I do want to turn __readahead_batch into working on folios, but that
involves working on fuse & squashfs at the same time ... I see you
got rid of the readahead_page_batch() in btrfs recently; that'll help.

