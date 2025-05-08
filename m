Return-Path: <linux-fsdevel+bounces-48486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65890AAFCB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 16:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C9E16FD4D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 14:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C70A25392C;
	Thu,  8 May 2025 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IQBFxRg6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CA22E3FD;
	Thu,  8 May 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713845; cv=none; b=rYt9bvtTPpI2tZlCjINagli90NaHoldHCfuB45n+1rsbXbFpFADVqJ9zKLaC6gbdTI1KHtjOCDXgVQRDbtq844Fzmh/ubsK3TSwBjNScYVG1gYC2p3gH7diIt8Iew+hx4R3hEjiJjNECbvJu1eDnuxjl753vj8xh071gpAOEWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713845; c=relaxed/simple;
	bh=JjiKChkJUIqBfQBORa0ELAcnC37RmyJHrP5GVrPLhmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOAXNpJ9eYKtyohECUzXx2oIsQSxylj/FauvK30J+BiFu0XwYv1gcPm3W6YRhZnF5QVyhFLnjrCW1U23a6ivpRHNt48g5uU41E8fOkuuBA03J7361sKgEeSdUmM0NadJI/S4RzoBtZudsQrZgMRhgeftPkDFQiFLLKEFDm5ZeaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IQBFxRg6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hwkyx4xrYciPWh+3Zv0QwHoHcoz2C7RuQft5YvvlV7o=; b=IQBFxRg6rPH1+RhqSA+HuB8gNb
	cwgomeN2QKmg/fh9sOEzkN76cARsmJ3Oy+8JnxkDDH51gut7+TYFIXbiZ2n0Fpz8+Kl//llkGwFnb
	QiMwHnx+aOuYsLaBA7T3covEz3iaU2mR9yNUBKlVaxtmR3LdfnC1ZzrrH3bop//Xbakba3Xk2008r
	HUOXYbQ1BzKkclLjKXwxoxVKnNjB4aGypcnwM8sTfTfbi5TIyjag8oO+76cNMkoQF5WxlwBLRAwO0
	Zi5gIiaYO08EZupdcNp3ZaPlP2DpyPlKmPjS8vN6EaCrUK6RVdzCiwRzOjfZuF115eKgK0cApPlNh
	HTrMUXQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD23s-00000000t3W-49Pn;
	Thu, 08 May 2025 14:17:20 +0000
Date: Thu, 8 May 2025 07:17:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [RFC] gfs2: Do not call iomap_zero_range beyond eof
Message-ID: <aBy88J4igluFUiNb@infradead.org>
References: <20250508133427.3799322-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508133427.3799322-1-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 08, 2025 at 03:34:27PM +0200, Andreas Gruenbacher wrote:
> As an alternative approach, we could also implicitly truncate the range
> inside iomap_zero_range() instead of issuing a warning.  Any thoughts?

I'd rather not magically change the range.

>  	BUG_ON(current->journal_info);
> +	if (from + length > inode->i_size)
> +		length = inode->i_size - from;

	length = min(length, inode->i_size - from);


