Return-Path: <linux-fsdevel+bounces-41899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5607A38E64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 22:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676AE171044
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 21:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CA91A9B29;
	Mon, 17 Feb 2025 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uWsw9uPd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B134224F0;
	Mon, 17 Feb 2025 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739829509; cv=none; b=DQN6HmBFUl2tlV3M+DEYyqIXlK4sqcdcdKG8Pe+MIOvkim4slGoNR6963tHl0d4MKQ8OlVY19KOGb9DKHleDa9cQIFZ2lZHR7wCnlluS3N7xaYOz4mDPRSf2STBcJra+sGxsEJIMxD40D5rv2bI0qDI6IBl2aLebvZIHOL40xgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739829509; c=relaxed/simple;
	bh=/WSngJPox1XkgT8EdlxpXrhOPRtqrMyIHprdE4glyv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbFvczaTCrwpNWwh/Mfd2+PZ3AtISkZz3k65nA5OJnnjfo4VZCqEgQYvg6FUL1OFhsoQk1FpgcM4tPSOCDUaQZHyvd9sSWdgLrRmbMnRYnP57fOcxIv8gTy/0slz5jbZQdt2l1gxqlY68LHPMvGwCbBOi0VN2ZJU/PTfaWv2chk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uWsw9uPd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PrNDBC1sbGLUzqSwtEbYk6pr/8n6DX4iFAB7GbUfDO8=; b=uWsw9uPdM3QWIN9LS4bX0w4JCZ
	BJGLajT/fgExjSDJrZtHPhg9XnwavdGL/b5gpXXVqvgJbgDHu4/91eP5RJ8HzvQMrWJ3EtXim8T3l
	AmATyXTylbF0TdHVuHAqXU4LJRI5ruCZywn3GqAGedNsQ7g3qnBPKKYAS2Z64T9fxTe5AxAogFJHe
	7wj4hOvHrsLCUH4dsJr4NUzzhWAERQY6qNjYwGq2X8imb5hg/Q8O9OIQRuCw4LcmQYa1lgzBRwZRU
	QjxvjYfk+/etzf3FI0I9WSH3416+NllDKtNt/o2k5uQhOaEhYCsBE2I5syapka6S8u6JSWKCptJBl
	N715YWRg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk98A-00000001zyK-2Xqn;
	Mon, 17 Feb 2025 21:58:22 +0000
Date: Mon, 17 Feb 2025 21:58:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hare@suse.de, dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v2 4/8] fs/mpage: use blocks_per_folio instead of
 blocks_per_page
Message-ID: <Z7Ow_ib2GDobCXdP@casper.infradead.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-5-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204231209.429356-5-mcgrof@kernel.org>

On Tue, Feb 04, 2025 at 03:12:05PM -0800, Luis Chamberlain wrote:
> @@ -182,7 +182,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  		goto confused;
>  
>  	block_in_file = folio_pos(folio) >> blkbits;
> -	last_block = block_in_file + args->nr_pages * blocks_per_page;
> +	last_block = block_in_file + args->nr_pages * blocks_per_folio;

In mpage_readahead(), we set args->nr_pages to the nunber of pages (not
folios) being requested.  In mpage_read_folio() we currently set it to
1.  So this is going to read too far ahead for readahead if using large
folios.

I think we need to make nr_pages continue to mean nr_pages.  Or we pass
in nr_bytes or nr_blocks.


