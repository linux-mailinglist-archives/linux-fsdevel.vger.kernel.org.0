Return-Path: <linux-fsdevel+bounces-15245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3C388AF65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 20:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903781C38E7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 19:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE5617C6B;
	Mon, 25 Mar 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UlQwFWfx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F999DDBC;
	Mon, 25 Mar 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393571; cv=none; b=CjCt3nC5ZkLv3cI+n6924dVRU/O5sctUyJgbloGqfUb74OTl1O/6DQqSEXtai7NmVQbajJwTzy4yOIYUdD5/LEoicpXLJeKgO/lwqAwVByEkn+kGYh+FM+dC21zBfxZREhsf02/Lz3e+iVOYZY7CZAjc2ZdUwYWYVCLCHnRthRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393571; c=relaxed/simple;
	bh=jwz4Guifdf4DVGICfDOmo/2GnJ02m5fob7+pPJ05kZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoL2qXDxy4EcjCe6EgRzKyTIh6IWOJ8nyJZEd+VXzF7orLNGt0qZK1+c8EMbq7muNQjsz6TAYeetMLAKeL1ekBs2+dLKTupB08bgneTxs1GOuKneAEU+AOzuZqXZ50LYnWtskuMMonvlKdxjHN86awJ2zTlAODO0u2ebPq9oMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UlQwFWfx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dcd40kK2ong+ZU27Mi0hJpX7j3R5bDGXjjZigB4ZdqM=; b=UlQwFWfxYxuB+qq4RNafJxY6nx
	v9V5gb7tQGvnSafmEpNobANBmUZNkhoDvWNEe4uF30p88zenNBQkDIUXWAM2qQLDYgM1MEIbHO3az
	gc2i1vF3SHtg+xktVxYrQ0AnStgkcWu2Ct1s3p3pgP769eoExsai1ZxSgmLDWyqw7+xb5EzNWaZRV
	brQEOj1oNz47JoR18Nn68dKx2gWghcnN7pgQe8XK2Dvnalzuvd7/BBR90gwu8kyG82oVZ2UiXDQPn
	dZU2Hcg/4rPiOPoipMij19WX3h1PruxZp5SoberAXaUES6UkcEimylBmEZg/ZRugJbYq84ny8dFJn
	GMZmOFuA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rope0-0000000H8IP-2NtX;
	Mon, 25 Mar 2024 19:06:04 +0000
Date: Mon, 25 Mar 2024 19:06:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com, chandan.babu@oracle.com, hare@suse.de,
	mcgrof@kernel.org, djwong@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, david@fromorbit.com,
	akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 07/11] mm: do not split a folio if it has minimum
 folio order requirement
Message-ID: <ZgHLHNYdK-kU3UAi@casper.infradead.org>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-8-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313170253.2324812-8-kernel@pankajraghav.com>

On Wed, Mar 13, 2024 at 06:02:49PM +0100, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> As we don't have a way to split a folio to a any given lower folio
> order yet, avoid splitting the folio in split_huge_page_to_list() if it
> has a minimum folio order requirement.

FYI, Zi Yan's patch to do that is now in Andrew's tree.
c010d47f107f609b9f4d6a103b6dfc53889049e9 in current linux-next (dated
Feb 26)

