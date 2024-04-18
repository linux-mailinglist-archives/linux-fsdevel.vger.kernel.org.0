Return-Path: <linux-fsdevel+bounces-17221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A55C58A918D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 05:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584641F22266
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 03:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F040A52F95;
	Thu, 18 Apr 2024 03:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f5uJT8NK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9686A4F8B1;
	Thu, 18 Apr 2024 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411077; cv=none; b=q8sZ9SzIJtmUUGlB4IagWoiWhT9z83pXLq5yU4uxWFbpXRKiV9JGoXhsEO/oJO1FjQPYvDxRezgPnQo6dNjNx83X327Qy9NgmYiqyJf4ofp5ckYGtE15Q1/YDNN5XXYTifIa8QmxcHrr88tRbu7AuI1DZ8hMwYo+eInCfcO6MAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411077; c=relaxed/simple;
	bh=qXoQM5IGnLPtSUBvxTTfUhnR1RLIkkTfcm4G9mACIzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPaDTOUKxds5F87Kn4eHo0vGJYDG8aOfH3lK8t45MxAlNZYvN7IOi83hKMYSCupexzHihu9yYp+FBrnXlgHtUt8SiXCFIinWarYpwkI5Jtm6zpbvRikUSIJtv148hllYXrA/a/LgJtDW0mdrUyM9q4CeMlzxZ2ZZRdT9wKR3JKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f5uJT8NK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zy7IR3Gvl36ziw9sf2woAp5XWV/QSQ6BNNUf9k7Ge6g=; b=f5uJT8NKu3sNkh/Q0cLgqRlT1O
	nHg8ZE4rhHPBZv3pwx4O+QYR/31LKzoQkSYScFKaz3jCP2Ur1DlocSMHnCte+iJc3csQxO2sNFY48
	B/tr2ChVHbWEwQVGVj9vMsMZv00KnarOc0LAQnr+lnkVgryFI2PNK0/xkZbCGO47UP85T/m3YsKF2
	G4DRz3S4nluNFOWMCQnPENCEduyiKAq9gfQcAuiImfdutsxhxW6zFly7KBRR6gKQNlwhj75XKPo1c
	x42ra0Nyw3kSYLwx965aQP0JMvGZtEqVa7sqN9OJA4BeY9J8eoZDVLM7ty26WZql/8SEl8yclNwd1
	+AHw60TA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxIU2-00000004Q7V-43uq;
	Thu, 18 Apr 2024 03:30:47 +0000
Date: Thu, 18 Apr 2024 04:30:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] mm: drop page_index/page_file_offset and convert
 swap helpers to use folio
Message-ID: <ZiCT5rNr5oxdFsce@casper.infradead.org>
References: <20240417160842.76665-1-ryncsn@gmail.com>
 <20240417160842.76665-8-ryncsn@gmail.com>
 <CAGsJ_4xv8m-Xjih0PmKD1PcUSGVRsti8EH0cbStZOFmX+YhnFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xv8m-Xjih0PmKD1PcUSGVRsti8EH0cbStZOFmX+YhnFA@mail.gmail.com>

On Thu, Apr 18, 2024 at 01:55:28PM +1200, Barry Song wrote:
> I also find it rather odd that folio_file_page() is utilized for both
> swp and file.
> 
> mm/memory.c <<do_swap_page>>
>              page = folio_file_page(folio, swp_offset(entry));
> mm/swap_state.c <<swapin_readahead>>
>              return folio_file_page(folio, swp_offset(entry));
> mm/swapfile.c <<unuse_pte>>
>              page = folio_file_page(folio, swp_offset(entry));
> 
> Do you believe it's worthwhile to tidy up?

Why do you find it odd?  What would you propose instead?

