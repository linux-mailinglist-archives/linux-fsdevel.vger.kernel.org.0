Return-Path: <linux-fsdevel+bounces-12823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC5E867A05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 16:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7358AB287A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 15:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF5312C81E;
	Mon, 26 Feb 2024 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gx/LvP7E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7889A12C804;
	Mon, 26 Feb 2024 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958948; cv=none; b=ZB6XWj+Az0JU8jFOrkyNYv1QMxhamOGXuXAhh1O9rlnWeivbW7mnPoVSCh0i5qrhjUCL2DbMIEphnQB7reXAnb4CaK0Q6xGJscdqqIwmPWpMTEOq7GSaARzEdxvDZrIU2e4+RekI0uGrueFY3OsFU3P7APZcNdhL+ccENutUJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958948; c=relaxed/simple;
	bh=iexwL/htgFG+8RrlWlvApOzkhPjXDjcxRVDjmf2Hkos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r38T+qhgBs2CfMBVzV17f0on9tD1O0jM8SOsdfZFhGquIMzYanU/1SEEiFhlKbvjST+KsMrGc94DFt5HmyzH7BIeIxZgbBpGNBRg2jfr3hM13GuGZ9dGhxKd9JeM1gP4C5BsQj7biAe+wrw4saIFgOfUCpnaWZ2jMrnog93bJJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gx/LvP7E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c3UKkTKYCLN0pQgtkmF5pW4a1ghAwfGWMKL7VSuA/Bs=; b=Gx/LvP7E9EXUucEHgU+fzRNAZL
	igMHh+WhwMi1IZrFWTebwuVbrmsubNVoNB52Nq/mM/Gs/B+zwQSPn+0aaYo+tVc7ytsTJ415EG9Z+
	ozcwirimTHULZHZz17ru0C/ShAe1F89BhUFoB8F07HRrZqAHi4MvxnhHF0LX0mrlp66dorftyV95R
	rExz9aL8iQBVltDD6d5BaSfCj6oSj/wUHJCHcuugD9xdbULnY1EuJ5zI0gtQwfAFFkpEZaFR2Nj3z
	mTdmW6gwowyJZ9ukP9jM/MczICkkTgPl2XnUQSGDA+jx+XDr6p5QH15fyRON+2iPV3LbflLpQjLjT
	IxGOUHhw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1recHw-0000000HQQ4-2qeY;
	Mon, 26 Feb 2024 14:49:04 +0000
Date: Mon, 26 Feb 2024 14:49:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	mcgrof@kernel.org, ziy@nvidia.com, hare@suse.de, djwong@kernel.org,
	gost.dev@samsung.com, linux-mm@kvack.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 05/13] readahead: set file_ra_state->ra_pages to be at
 least mapping_min_order
Message-ID: <Zdyk4ErGQHc1q-1W@casper.infradead.org>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-6-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226094936.2677493-6-kernel@pankajraghav.com>

On Mon, Feb 26, 2024 at 10:49:28AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Set the file_ra_state->ra_pages in file_ra_state_init() to be at least
> mapping_min_order of pages if the bdi->ra_pages is less than that.

Don't we rather want to round up to a multiple of mapping_min_nrpages?

>  file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
>  {
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
> +
>  	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
> +	if (ra->ra_pages < min_nrpages)
> +		ra->ra_pages = min_nrpages;
>  	ra->prev_pos = -1;

