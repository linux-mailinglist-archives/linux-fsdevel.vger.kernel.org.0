Return-Path: <linux-fsdevel+bounces-26364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB48958847
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 15:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8991B1F232E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E9E19067C;
	Tue, 20 Aug 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tOq3EcsU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87E5189F3F
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161820; cv=none; b=lcepcZsKucXs5uVFfmwxiGf/ddWSm/6/2L/+lyYhODQzdK9JXHDQS+35VPCmiuF/YfoA9YN3PyZARp6Cx+5eD8IUA+rnkl8SgCewYki/uybjTsuD7CxguEzDFDPTGThO3+aOglYKNI3kUZ0PLnC0c07PtY0tkTsRrdy+rnMiElw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161820; c=relaxed/simple;
	bh=BmJI0ihrATcZBG/xGV8HR3d77bY4c1n+Tz8GO0R3ECc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFhHlwYd/XxDh9Vu126dM+K6Bxev3UnpJ94CsP7pbJFcaBsW/D5zGCsqsW0fh45QLS6hPcN2WrggZIrNuJSzdzHklQWJzo1AwotIR1WRADcq3XqQMrttZn+D3W3SMQA79kj+U6u50NbnDs3FGCN7X+OejW1THYVD1ye2e/u84V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tOq3EcsU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=sCMNHk2dTBjpEvWplin63ue82CfVNSbfcs62x6ULyn8=; b=tOq3EcsU0uBXovmAL3iwWOFxYM
	lWPbN/exaFhBn8UaSliqqUgN/OebVVPkqlhmmeg4ThSCNF6cW/MPzExAZS9szrS+//5x6lIgxYiaW
	VAGP8dYRIqiBFbd2+Z0TvPTRlTNuVnumlVb8EoqahRW9xNMlYn0/J0UUnbxzJWdc1ZBx1wsx2aEBW
	t3oDY3zShQUhOIcN5vo0Ie/kqooLGfpquzAY0N0VNG07MIdeuae7H4Ua62oxJqENuKK1d0Ugz2Zzw
	AiyqPQEztgcd3nkolN9JHl1OywjRCnLLuJ9Il+4YYpqeRp6++BQcyJkOiCc69+tf9IwlPNaQi0nkF
	ZtzNfPXA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgPFQ-0000000819u-43uO;
	Tue, 20 Aug 2024 13:50:09 +0000
Date: Tue, 20 Aug 2024 14:50:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] fuse: use folio_end_read
Message-ID: <ZsSfEJA5omArfbQV@casper.infradead.org>
References: <ZrY97Pq9xM-fFhU2@casper.infradead.org>
 <20240809162221.2582364-3-willy@infradead.org>
 <d0844e7465a12eef0e2998b5f44b350ee9e185be.camel@bitron.ch>
 <2aeca29ce9b17f67e1fac32b49c3c6ec19fdb035.camel@bitron.ch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2aeca29ce9b17f67e1fac32b49c3c6ec19fdb035.camel@bitron.ch>

On Tue, Aug 20, 2024 at 02:57:04PM +0200, Jürg Billeter wrote:
> On Sat, 2024-08-10 at 14:24 +0200, Jürg Billeter wrote:
> > On Fri, 2024-08-09 at 17:22 +0100, Matthew Wilcox (Oracle) wrote:
> > > part three
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  fs/fuse/file.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index 2b5533e41a62..f39456c65ed7 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -937,9 +937,7 @@ static void fuse_readpages_end(struct
> > > fuse_mount
> > > *fm, struct fuse_args *args,
> > >  	for (i = 0; i < ap->num_pages; i++) {
> > >  		struct folio *folio = page_folio(ap->pages[i]);
> > >  
> > > -		if (!err)
> > > -			folio_mark_uptodate(folio);
> > > -		folio_unlock(folio);
> > > +		folio_end_read(folio, !err);
> > >  		folio_put(folio);
> > >  	}
> > >  	if (ia->ff)
> > 
> > Reverting this part is sufficient to fix the issue for me.
> 
> Would it make sense to get a revert of this part (or a full revert of
> commit 413e8f014c8b) into mainline and also 6.10 stable if a proper fix
> will take more time?

As far as I'm concerned, I've found the fix.  It's just that Miklos
isn't responding.  On holiday, perhaps?

