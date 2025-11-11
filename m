Return-Path: <linux-fsdevel+bounces-67890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D636C4CEF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394244272F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6166B32AAAF;
	Tue, 11 Nov 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQEDW3Fl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B261E2FF149
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855190; cv=none; b=oI2eNmYrCmyCq5s0E39pJ0IRRdIUULrGoLtkC3hCtT/r37nKPrQ+XevGVtdBybh0TsWo3riDD8LK2qrlH2LZEBwb2oSCVcqA0WO/3xN14ixL1VcIa6hr2teBrKhfXLWEyVW+wxWVQHDtCicwBNmgRAaBbLE0maOYqeG+GsS04ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855190; c=relaxed/simple;
	bh=8N8GqKjKVmCcW3FPmEMuf6YYiwxcbop3EKSwjq5wsII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHhOx/uDr88QePjdUjDRfh0MXwxTqbbs9ko6ZEbW8M8MyKzMC4hOe2sFEthSQQQYFTv3Dyx/9XwgCm2Cn4SNAW5wVK6IV9dnCzCm6ZkEYPjvi44ca6lHoF5BCIuBaKo2o1ze3GRhOihGMZlOpgJJiw8o0ANDfbQkMhZ4nls2ttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQEDW3Fl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05460C19422;
	Tue, 11 Nov 2025 09:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762855190;
	bh=8N8GqKjKVmCcW3FPmEMuf6YYiwxcbop3EKSwjq5wsII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQEDW3Fl5K0Dvr5C3P/+Eri/nAbohVDuKI4XtVOkvLaGSgP/SbgOWEsbGFspy5nQu
	 nFSoIgCeKhZ8/np8jueh2RXyHgwigbhdfUHpUnrBccm5ghZqyZs/wLCKTMgp0+U0CU
	 UPKoeJ2L54ClBnB/Rj1h93V3TjtFJZw8KljZ0eIEGh+5dWcujLT8jdVHCWGOleCi6z
	 GNs67YgdA6V5htKQOI+51a5LLw3fXAW8w8KEgYkck12568Nm42KYxcDgcTA6wDqp5e
	 8LAJFtg1p55l16dKnc2Umtnzf4Ozu7FTOrIv9JwSGA1EJ5rJFAOmtJMYh7ssZ40DCV
	 k3xHyxAhkViyQ==
Date: Tue, 11 Nov 2025 10:59:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 10/10] mm: Use folio_next_pos()
Message-ID: <20251111-droht-oasen-449486f7248f@brauner>
References: <20251024170822.1427218-1-willy@infradead.org>
 <20251024170822.1427218-11-willy@infradead.org>
 <aQ7ObHvd8FXb8Taz@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQ7ObHvd8FXb8Taz@casper.infradead.org>

On Sat, Nov 08, 2025 at 05:00:28AM +0000, Matthew Wilcox wrote:
> On Fri, Oct 24, 2025 at 06:08:18PM +0100, Matthew Wilcox (Oracle) wrote:
> > +++ b/mm/truncate.c
> > @@ -387,7 +387,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
> >  	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
> >  	folio = __filemap_get_folio(mapping, lstart >> PAGE_SHIFT, FGP_LOCK, 0);
> >  	if (!IS_ERR(folio)) {
> > -		same_folio = lend < folio_pos(folio) + folio_size(folio);
> > +		same_folio = lend < folio_next_pos(folio);
> 
> This causes an intermittent failure with XFS.  Two reports here:
> https://lore.kernel.org/linux-xfs/aQohjfEFmU8lef6M@casper.infradead.org/
> 
> This is a fun one.  The "fix" I'm running with right now is:
> 
> -               same_folio = lend < folio_next_pos(folio);
> +               same_folio = lend < (u64)folio_next_pos(folio);
> 
> folio_pos() and folio_next_pos() return an loff_t.  folio_size() returns
> a size_t.  So folio_pos() + folio_size() is unsigned (by the usual C
> promotion rules).  Before this patch, this was an unsigned comparison
> against lend, and with the patch it's now a signed comparison.  Since
> lend can be -1 (to mean 'end of file'), same_folio will now be 'true'
> when it used to be 'false'.
> 
> Funnily, on 32-bit systems, size_t is u32 and loff_t is s64, so their
> addition is also s64.  That means this has been wrong on 32-bit systems
> for ... a while.  And nobody noticed, so I guess nobody's testing 32-bit
> all that hard.

death by slow degradation...

> Anyway, what's the *right* way to fix this?  Cast to (unsigned long

Naively, I would think it should be an unsigned comparison for u64.

> long)?  There's an ssize_t, but I really want the opposite, a uloff_t.

Fwiw, I don't think anything is stopping us from defining uloff_t in the
kernel if it's helpful.

> (now i'm going to go back through all the other patches in this series
> and see if I've made the same mistake anywhere else)

