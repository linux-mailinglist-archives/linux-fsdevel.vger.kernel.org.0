Return-Path: <linux-fsdevel+bounces-42387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 047D7A4161E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 08:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83868188E0F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 07:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0171ACED3;
	Mon, 24 Feb 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKIFQ1qq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C4C4414
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740381553; cv=none; b=oYMBVsX3Rtl9QDUPHuRDPhpzkS+sgT1+Z7q/3t2yDf3iZidBlE2nVzbqnKQGb0BVQT4haDMp/ksuvuHPkmy/K4UQKOJ3RPLa1KqGSB7q6juxfymSWnwBTAtv1JmaFCaz04XjDhP1GWNIKwr4G1gzTebGIl0QSwQjPNtgM/MuQHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740381553; c=relaxed/simple;
	bh=pm757VnndsKaWsJyQVwBdHyJs9Kn9U/lES5NG0JMMAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfiTPu2FEa5aI3x+UMgLSXW1tawSvLVgCS4DE8Y/+Rc82HMQrf8Jly0QNaVIw/2ivOqaaZ8uFvMBT20amC8ALeohmuYboNrxRmPLTS+Zfv3kT/oXepZgsh6Tu5y69iTP2doz23zOQ/697kP7hiJhKXL4CjXib5nWyCc3O5mB6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKIFQ1qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E68C4CEEC;
	Mon, 24 Feb 2025 07:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740381553;
	bh=pm757VnndsKaWsJyQVwBdHyJs9Kn9U/lES5NG0JMMAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKIFQ1qqzO5kSI1T1XVUM2b9ycTWkuH6ZIOKwbo3jQ1OJ3VX63PnuH43ea39sBtfF
	 f08vopCAxXHpjnAWThUGs/e5Zy6NnktCgyGQoIjtMbA9CWWndKKuYQ5mUs6nGT7HU1
	 b71RWGeyvpeuNTvcKO4nqT6nPAYSgDiGeLvvr9gQ0xGk2mkRPvv77R+Qk2XJ3xJL8f
	 Mx03pqYIZmm7s7ljklnS+AsKA6gLk4xSyAGXdLwuggV/amRiGqygc+pwDTbXAppTV1
	 o4Dw6gKwPAv5wMCemc9C3CNfYEqLQwDAC5QAVTKOV5jDfsWeJ1p6SK4KyDlP1uv6Om
	 btL4Wdwr8ATeg==
Date: Mon, 24 Feb 2025 07:19:11 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/27] f2fs: Add f2fs_folio_put()
Message-ID: <Z7wdb8nnXaUnD0CJ@google.com>
References: <20250218055203.591403-1-willy@infradead.org>
 <20250218055203.591403-4-willy@infradead.org>
 <Z7gHNEBYx5XdfQw5@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7gHNEBYx5XdfQw5@google.com>

Hi Matthew,

On 02/21, Jaegeuk Kim wrote:
> On 02/18, Matthew Wilcox (Oracle) wrote:
> > Convert f2fs_put_page() to f2fs_folio_put() and add a wrapper.
> > Replaces three calls to compound_head() with one.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/f2fs/f2fs.h | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index b05653f196dd..5e01a08afbd7 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -2806,16 +2806,21 @@ static inline struct page *f2fs_pagecache_get_page(
> >  	return pagecache_get_page(mapping, index, fgp_flags, gfp_mask);
> >  }
> >  
> > -static inline void f2fs_put_page(struct page *page, int unlock)
> > +static inline void f2fs_folio_put(struct folio *folio, bool unlock)
> >  {
> > -	if (!page)
> > +	if (!folio)
> >  		return;
> >  
> >  	if (unlock) {
> > -		f2fs_bug_on(F2FS_P_SB(page), !PageLocked(page));
> > -		unlock_page(page);
> > +		f2fs_bug_on(F2FS_F_SB(folio), !folio_test_locked(folio));
> > +		folio_unlock(folio);
> >  	}
> > -	put_page(page);
> > +	folio_put(folio);
> > +}
> > +
> > +static inline void f2fs_put_page(struct page *page, int unlock)
> > +{
> 
> I got a kernel panic, since there are still several places to pass a null
> page pointer, which feeds to page_folio() which doesn't expect the null.
> 
> Applying this can avoid the panic.
> 
> 	if (!page)
> 		return;

Please let me know, if you want me to apply this to your patch directly, or post
v2.

Thanks,

> 
> > +	f2fs_folio_put(page_folio(page), unlock);
> >  }
> >  
> >  static inline void f2fs_put_dnode(struct dnode_of_data *dn)
> > -- 
> > 2.47.2
> > 

