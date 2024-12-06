Return-Path: <linux-fsdevel+bounces-36652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EC09E751C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8638F285C34
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E1E20CCD7;
	Fri,  6 Dec 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UlDmBN5j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7361BA20
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501201; cv=none; b=EHoOaAMn68vWxZ1zHw4zUmnQMDO6cWvmljFoDp+uMHiuFDGVMerqHKap7RhuHiYu4qDEhJekbXaaYYenFF+UujxTtwO6P4KJ/HDSJtBRgukdpf3FCHtlBoRim+mi/VLD+LDTqiGOtzu5dhYG+6fLWa5MD9iLyAXIy0R6+Hy7qDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501201; c=relaxed/simple;
	bh=4NcCbeqb5jyMH0/dwiB+RG0oOX9qBxdg5IafsyXSKjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9eZ5eqKbu7oEz67Bh3PR4hjn86rM3UMBvXNDPlT2FUAZ+JgCg5DdIqOCj8UhLFB0YxPr0swj7IvPD6jYy/Cv1pQU/I4z9gYwHC8NxNkMyM/AZbV5d/x6SVcNT4LFmT2I52tCZJQDA+KCx4dZDOYpTVrvMG9/PFTvYghNISUwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UlDmBN5j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0BQcxMjRnFnt/Z8nXkR+biRrobCnTo8ZVZNZonxaHJk=; b=UlDmBN5jfLSz+YcwpNMSxrZDoG
	3PGyn1Bok0bANtOIxqjB9fEE9bUzUhMeZE8OrCoMjeEL2GjQhuHN4ZDV43No6DjKZ9Oz94lMU0tYb
	U6GspEqajOQJIQnCtfr8doc/51GgA5uZ3YnQ635F336LcyoPWLcJNs8X1sajqrbAeq3aGvzHLQEQ0
	7i6cXtQrRLqjxAnAcHtjtx0wfjxu/CUML4fTe9u8fvtA3poLCdREYy7j3amOppGXsQacSohhTF+mX
	krzV3qZDKxalniLU4/aNQFZ4KJJLgJpvdVlzLUpmSmjvx8NlQCM4ryyUWTHf7nlqAZS5/GEIf+vXO
	Yyvpe0dg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJaqj-0000000EhzF-2ntX;
	Fri, 06 Dec 2024 16:06:37 +0000
Date: Fri, 6 Dec 2024 16:06:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC] pidfs: use maple tree
Message-ID: <Z1MhDcijeMwrP9fu@casper.infradead.org>
References: <20241206-work-pidfs-maple_tree-v1-1-1cca6731b67f@kernel.org>
 <Z1McXVVPJf4HztHU@casper.infradead.org>
 <20241206-experiment-ablegen-c88218942355@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-experiment-ablegen-c88218942355@brauner>

On Fri, Dec 06, 2024 at 05:03:03PM +0100, Christian Brauner wrote:
> On Fri, Dec 06, 2024 at 03:46:37PM +0000, Matthew Wilcox wrote:
> > On Fri, Dec 06, 2024 at 04:25:13PM +0100, Christian Brauner wrote:
> > > For the pidfs inode maple tree we use an external lock for add and
> > 
> > Please don't.  We want to get rid of it.  That's a hack that only exists
> > for the VMA tree.
> 
> Hm, ok. Then I'll stick with idr for now because we can simply use
> pidmap_lock. Otherwise we'd have to introduce more locking.

Why can you not delete pidmap_lock and use the maple tree lock
everywhere that you currently use pidmap_lock?  That's the intended
way to use it.

