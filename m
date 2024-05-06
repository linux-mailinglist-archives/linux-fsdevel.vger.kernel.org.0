Return-Path: <linux-fsdevel+bounces-18798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DE18BC64C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 05:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433A32815A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 03:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165804316B;
	Mon,  6 May 2024 03:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LYa3jz6e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176422D044
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714967297; cv=none; b=Ugf3ofkuA19JhA3TmQRP8sFv5/WRmZzhZt4RViks9wFoHrqtz76cz539gpWGYftS7qOQQ/2czZn39+6VTdxfx4aj1gjnWGlGUSc27MveTKNQ63j5p2DkKgHcNlYwP23HcAY2V0rlHYgyb4f1xT4X3yaa4Rp1oAu2kGWvI6uDXMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714967297; c=relaxed/simple;
	bh=ZIS6oZqV2b+/KX5wFyMwyyEZW0XdrrfioQ0sB8OTW/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEuQenq1g0YosW8Sg0OJsMGm7diz41BomH0sXSspJ8fOBaeIFgJ9wHXnAe1vqSCANrmnU0u7HrmMV3vlHg9AmvJRX/lCkHnbSDw2pKIM+bY8+nt1r16KAabi9ePXAItZWd1o41P9467TS8fsWAi9WDXylDAxNbwFslXiAlLCUEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LYa3jz6e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ojQO7z2TLG6k00vW5pht3+/QEn5pQrKjR+FNFF7h6O8=; b=LYa3jz6eJr4lWTceO/e0pYazL+
	t60yAKidJpAZJwELnak9xR+gIaQATECVg+vpsS8TYyoRGOARNxVjCj6ZMZEg4oANs9OXz4UTF6ciC
	3JQsb6dYjTnf+HgK089lDigWob+S+/6P7teG5dV8usnN2Ib/qn+MmgXlplNo52JWT8j9Lm3fUuR8j
	hzCEAnIWRRRz+OyfjUXEyTilOb9jsNMTIKwxa2VyTvPghXlJphMcSWyJi8ptSH6i9SAN4szLPGB8N
	/jQfZuJxt61p1JHcHwOmef1U0bjL8DPKXBJlsp4xeBWqXk5kM7wgwZFnIC7kyDjnJFRbxa5RPCTJB
	rpLKaVBg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3pKY-0000000A4WY-2G4U;
	Mon, 06 May 2024 03:47:58 +0000
Date: Mon, 6 May 2024 04:47:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org
Subject: Re: kmap + memmove
Message-ID: <ZjhS7sE8chokLFrP@casper.infradead.org>
References: <Zjd61vTCQoDN9tUJ@casper.infradead.org>
 <alpine.DEB.2.22.394.2405051500030.3397@hadrien>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2405051500030.3397@hadrien>

On Sun, May 05, 2024 at 03:01:56PM +0200, Julia Lawall wrote:
> On Sun, 5 May 2024, Matthew Wilcox wrote:
> > Here's a fun bug that's not obvious:
> >
> > hfs_bnode_move:
> >                                 dst_ptr = kmap_local_page(*dst_page);
> >                                 src_ptr = kmap_local_page(*src_page);
> >                                 memmove(dst_ptr, src_ptr, src);
> >
> > If both of the pointers are guaranteed to come from diffeerent calls to
> > kmap_local(), memmove() is probably not going to do what you want.
> > Worth a smatch or coccinelle rule?
> 
> I tried the following rule:
> 
> @@
> expression dst_ptr, src_ptr, dst_page, src_page, src;
> @@
> 
> *                                dst_ptr = kmap_local_page(dst_page);
> 				... when any
> *                                src_ptr = kmap_local_page(src_page);
> 				... when any
> *                                memmove(dst_ptr, src_ptr, src);
> 
> That is, basically what you wrote, but with anything in between the lines,
> and the various variables being any expression.
> 
> I only got the following results, which I guess are what you are already
> looking at:

Great, thanks!  I tried something a little more crude:

$ git grep -A10 kmap_local |grep memmove
fs/erofs/decompressor.c-				memmove(kin + rq->pageofs_out, kin + pi, cur);
fs/erofs/decompressor.c-				memmove(kin + po,
fs/hfs/bnode.c-	memmove(ptr + dst, ptr + src, len);
fs/hfsplus/bnode.c-				memmove(dst_ptr, src_ptr, src);
fs/hfsplus/bnode.c-			memmove(dst_ptr + src, src_ptr + src, len);
fs/hfsplus/bnode.c-			memmove(dst_ptr, src_ptr, l);
fs/hfsplus/bnode.c-				memmove(dst_ptr, src_ptr, l);

$ git grep -A10 kmap_atomic |grep memmove
net/sunrpc/xdr.c-			memmove(vto + pgto_base, vto + pgfrom_base, copy);
net/sunrpc/xdr.c-			memmove(vto + pgto_base, vto + pgfrom_base, copy);

All of these (other than hfsplus) are "false positives" in that you can
see the src/dst are from the same call to kmap_local/kmap_atomic.  Glad
to see there's nothing else.

