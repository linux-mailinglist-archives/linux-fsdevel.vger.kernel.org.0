Return-Path: <linux-fsdevel+bounces-58389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFE5B2DF72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 16:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3796AA067DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 14:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB3227A127;
	Wed, 20 Aug 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9BloTVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2142276054;
	Wed, 20 Aug 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699935; cv=none; b=Vuuj9IAXWGntIBwCO3W6DyLATpqnsg+ACjaNCPrSM8alKutsPy0JHc7XXvqMR/k6DEg8R4RbEE3xyPp/7W9jBdKcnufpJYxvXRRsKlj6XBKdWJovgrMP33mFbb3OwbBdhljZ2Vq5Rogqx3vA2XdXwh2Dq/t0H19wNqYfaX42+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699935; c=relaxed/simple;
	bh=dBCS/W99xS1CBfO/oJzWpXrvThDGHSoZlpVsvBG7teA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/fsYULDvAEJa/BmvilWS6ZqovIE5UXtpEG/P1ATysHKJQneXLAZdcDNQGixaklCtBogBdmE67ST7LcNxWDCBwAJ7HZBU13UmCN4yabUiPTTjKefEeOPIFYTePdQzL4LnWhPCxE66/CfTQ1TDjxqjNYWnUFzvZY04JCjyNvFwS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9BloTVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC56CC4CEE7;
	Wed, 20 Aug 2025 14:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755699935;
	bh=dBCS/W99xS1CBfO/oJzWpXrvThDGHSoZlpVsvBG7teA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9BloTVbExdn2v73bBTBBnoUCmF/9KScjt9Uw+GMnHILOd3apbbGmhxwZ8SfmFR1h
	 kgX9lsCf5Q/FfXHeEZYqEsZVk36KOJhGBeWBqP5WWtkGYhEJjs3HKHZQoSFDX0El4J
	 N/icTBNHgfKaMZa0DsXbxYeviP8mqPxL/w089Fx4QwRrVGYLa4Q1mHLzrGe8vUDyT4
	 Ww/oN25kdFLdAZRb0fwnRLQ6YUrmLrHMHbotw/ypb18zjFwoDWUAQuFA6ZC7evah6z
	 vgT3s04X2WXs4Es0Dow3aLZ8XeCCNV/iRU54kpa5YkAAQHOIyTmRODXWZ0CuoZKZXb
	 ziIGM7Kaj7nrw==
Date: Wed, 20 Aug 2025 08:25:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org, hch@lst.de, martin.petersen@oracle.com,
	djwong@kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCHv3 1/8] block: check for valid bio while splitting
Message-ID: <aKXa3Nwn_Mz09MPW@kbusch-mbp>
References: <20250819164922.640964-1-kbusch@meta.com>
 <20250819164922.640964-2-kbusch@meta.com>
 <d07a4397-1648-4264-8a30-74a2ea3da165@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d07a4397-1648-4264-8a30-74a2ea3da165@kernel.org>

On Wed, Aug 20, 2025 at 04:02:31PM +0900, Damien Le Moal wrote:
> On 8/20/25 1:49 AM, Keith Busch wrote:
> >  {
> >  	struct bio_vec bv, bvprv, *bvprvp = NULL;
> >  	struct bvec_iter iter;
> >  	unsigned nsegs = 0, bytes = 0;
> >  
> >  	bio_for_each_bvec(bv, bio, iter) {
> > +		if (bv.bv_offset & lim->dma_alignment || bv.bv_len & len_align)
> 
> Shouldn't this be:
> 
> 		if (bv.bv_offset & len_align || bv.bv_len & len_align)
> 
> ?

No, we alwqys need to validate the address offset against the dma
alignment. The length is not validated for passthrough commands though,
so different masks for each so they can be independently set.

