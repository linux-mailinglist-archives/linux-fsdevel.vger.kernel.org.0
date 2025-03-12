Return-Path: <linux-fsdevel+bounces-43767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B505CA5D74D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61587189DD51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559361EA7E4;
	Wed, 12 Mar 2025 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aGDzSarI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58338384;
	Wed, 12 Mar 2025 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741764426; cv=none; b=oyTGwXMOWf6D41/9yqYT+9Kw+kAwwomMCVCWMHTUw57VgLCnpuMZ6f5ZbnTxG2azzeilsjVjeY+z87wlcFDfMVEAFQn3dCfRQ12GhkepcBkhaDmmDax3zTS7cn+wgWck9D0merIvq6VFFKSIpDAg9cJ7UoSY/R1mbEoZpIWQS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741764426; c=relaxed/simple;
	bh=EJWcZKl14sOGNK87BgWsbQmDdWUjTGsyLMZfs33dNy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSwC+Atf3Z0wdgbg7N89fqWk7cQzDaokcHWFoVorAc/E4enuTfYElItyLvb8QUBsGwdoZN8cCCAf/qA33L/t3FMYDUgsNUjAjuu5b2TiaJfB+dQw2ghRPsMraT+qiWqYe1iEhMEqtcrjn8UP15di5lpb7r+fWNLvZEWdCo0WXeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aGDzSarI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vvfcmR4pSSX2yPAtHod4c3BswObDKgvYGKNGYlizF1E=; b=aGDzSarI9YPsMKAkR8aC6OCGYp
	9uIQThO/OlR6d5S5AzzP3ZtsZbX/NdMgATAXzuTguzx8LQymeQQvqStwSUjuijrOvamOKSWwpeqSF
	kiJGuQJTeM23FNqn+E+wMrdfhUrMHzFnyL1ISTXZM5qE1iC6eM7h6cIdlFMnkEo0RzsO/6UVXwDdP
	GtUeGkQBMHEKuFJyGMgyDGaatVDmlRRrl9G/zwl0cafFjpX7blxSELJxpwpAfLl8AdDmdHz6QE3sZ
	V9jXlsVgfiZnPTcDzq1dzMKeBhc4vOouE+Gd7WaL1IwXHIiEvZ5Ys9du/Tg8KtSdbPfvETD21hgAS
	9fnUaQFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsGUb-00000007hQg-0cuX;
	Wed, 12 Mar 2025 07:27:05 +0000
Date: Wed, 12 Mar 2025 00:27:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH v5 04/10] xfs: Reflink CoW-based atomic write support
Message-ID: <Z9E3Sbh4AWm1C1IQ@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310183946.932054-5-john.g.garry@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 10, 2025 at 06:39:40PM +0000, John Garry wrote:
> Base SW-based atomic writes on CoW.
> 
> For SW-based atomic write support, always allocate a cow hole in
> xfs_reflink_allocate_cow() to write the new data.

What is a "COW hole"?

> The semantics is that if @atomic_sw is set, we will be passed a CoW fork
> extent mapping for no error returned.

This commit log feels extremely sparse for a brand new feature with
data integrity impact.  Can you expand on it a little?

> +	bool			atomic_sw = flags & XFS_REFLINK_ATOMIC_SW;

atomic_sw is not a very descriptive variable name.

>  
>  	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
>  		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
> @@ -466,7 +467,7 @@ xfs_reflink_fill_cow_hole(
>  	*lockmode = XFS_ILOCK_EXCL;
>  
>  	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
> -	if (error || !*shared)
> +	if (error || (!*shared && !atomic_sw))

And it's pnly used once.  Basically is is used to force COW, right?
Maybe use that fact as it describes the semantics at this level
instead of the very high level intent?

> @@ -10,6 +10,7 @@
>   * Flags for xfs_reflink_allocate_cow()
>   */
>  #define XFS_REFLINK_CONVERT	(1u << 0) /* convert unwritten extents now */
> +#define XFS_REFLINK_ATOMIC_SW	(1u << 1) /* alloc for SW-based atomic write */

Please expand what this actually means at the xfs_reflink_allocate_cow.
Of if it is just a force flag as I suspect speel that out.  And
move the comment up to avoid the overly long line as well as giving
you space to actually spell the semantics out.


