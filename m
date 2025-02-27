Return-Path: <linux-fsdevel+bounces-42788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133B1A48A84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 22:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A73957A5B80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 21:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1627225A24;
	Thu, 27 Feb 2025 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyMxHtaY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F6270054
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691871; cv=none; b=dfyEPJsz5BO0EcRo7jih6TM767+Tpyz1Gat7UN1AP4nbd69LL8aDBv1qHArC7iMBLwu9Bzi49i1+p670f00IooqQAhIg/kwx/fxqOL/7oR76hOS7PRyVDW2e+hl6cOPc67kRp8eLIvLZUQM4qUrWMCxgnt224TrlFPcnneZFhqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691871; c=relaxed/simple;
	bh=Uex2exXxw8sF1aGanevdICvCrEBztUODkzUSVwWbgfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCjFahE7bOfYqLFlByNoB1d42ZAQe61I48z/91v6KKHiY7f0Z/PX1otps4LRQXF3eSAWBUgnXNnum3Jny9XrS6EZye0Lh1VWAue0vmTFC8PPhGwmirqpzQJl6HoEJWJ0h0F/VtSHPR5c6yYbJKTtC4LFuSx3b9NV4Cl3HnXR6WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyMxHtaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76740C4CEDD;
	Thu, 27 Feb 2025 21:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740691870;
	bh=Uex2exXxw8sF1aGanevdICvCrEBztUODkzUSVwWbgfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kyMxHtaYNfUw+Wnf7dmzPePMLnz/klDd+UjLGFIZKBumQ8CSYJL95PkR7wKyXyvav
	 k3XHNKLiSKrmoBxcsE9xjByQCkOVN6LgDy5FoRN+HyzzinURFusWOwQu3V6RaC75GB
	 /kafT7gSLJeEBtALaTcpr7PcIM+TY/8HyWxOzyhwFoyn0yk0Hpp+80PhOlbq45ykTD
	 hQfyR2ydu7IzOfiVUZnWkG2qqxLMnsau9mkua1IE3vPYl1tzXq4ITCnU9wbPm2HGLm
	 hlru3JMKACjnHtBQoDqUK9sJNYchjj0sr14L2V1b/9QgbCGgAs9Sp7g0P8Zl7bHJ8T
	 XNhyPU+35kUrg==
Date: Thu, 27 Feb 2025 21:31:08 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/27] f2fs: Add f2fs_folio_put()
Message-ID: <Z8DZnHBF_o8JSkPp@google.com>
References: <20250218055203.591403-1-willy@infradead.org>
 <20250218055203.591403-4-willy@infradead.org>
 <Z7gHNEBYx5XdfQw5@google.com>
 <Z7wdb8nnXaUnD0CJ@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7wdb8nnXaUnD0CJ@google.com>

On 02/24, Jaegeuk Kim wrote:
> Hi Matthew,
> 
> On 02/21, Jaegeuk Kim wrote:
> > On 02/18, Matthew Wilcox (Oracle) wrote:
> > > Convert f2fs_put_page() to f2fs_folio_put() and add a wrapper.
> > > Replaces three calls to compound_head() with one.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  fs/f2fs/f2fs.h | 15 ++++++++++-----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index b05653f196dd..5e01a08afbd7 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -2806,16 +2806,21 @@ static inline struct page *f2fs_pagecache_get_page(
> > >  	return pagecache_get_page(mapping, index, fgp_flags, gfp_mask);
> > >  }
> > >  
> > > -static inline void f2fs_put_page(struct page *page, int unlock)
> > > +static inline void f2fs_folio_put(struct folio *folio, bool unlock)
> > >  {
> > > -	if (!page)
> > > +	if (!folio)
> > >  		return;
> > >  
> > >  	if (unlock) {
> > > -		f2fs_bug_on(F2FS_P_SB(page), !PageLocked(page));
> > > -		unlock_page(page);
> > > +		f2fs_bug_on(F2FS_F_SB(folio), !folio_test_locked(folio));
> > > +		folio_unlock(folio);
> > >  	}
> > > -	put_page(page);
> > > +	folio_put(folio);
> > > +}
> > > +
> > > +static inline void f2fs_put_page(struct page *page, int unlock)
> > > +{
> > 
> > I got a kernel panic, since there are still several places to pass a null
> > page pointer, which feeds to page_folio() which doesn't expect the null.
> > 
> > Applying this can avoid the panic.
> > 
> > 	if (!page)
> > 		return;
> 
> Please let me know, if you want me to apply this to your patch directly, or post
> v2.

I applied the fix into your patch. Thanks.

> 
> Thanks,
> 
> > 
> > > +	f2fs_folio_put(page_folio(page), unlock);
> > >  }
> > >  
> > >  static inline void f2fs_put_dnode(struct dnode_of_data *dn)
> > > -- 
> > > 2.47.2
> > > 

