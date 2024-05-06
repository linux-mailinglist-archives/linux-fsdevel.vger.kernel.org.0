Return-Path: <linux-fsdevel+bounces-18806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C268BC6A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 07:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7452815B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 05:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5670E4594E;
	Mon,  6 May 2024 05:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="atOpKp47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019C61EEE9
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 05:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714972511; cv=none; b=uC37lg4QpnXXNA6szun7CPFY18oUqzb3izgK18EGwXAHMy0hPXRPQc1Uusr/lq2I6DEZE2BmVVkP+4tl7ecFducJ3oXRnHPc66eHl5bbKG01XTf+JGDYfkgcad+B/G33h+62A2lOd96fFHNvWMc6mb8I0yK9kZSY5oeaVSKw2hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714972511; c=relaxed/simple;
	bh=Gofq2CBL6idKc8API8CBphzOlstaemh4KeoiJMfMw4I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fjRfYJUzGo5BGgwcp8F83XKc+Agwk7cHgbcOHcMZ2w94EeLOE9N228DbHiN0H8EsQeAxApHsBPMHA36LYkcLMiUwAULSzCVTk+hna7jt6C//DWH0ZyPXX3ioRadooJFSf+Z3O76OgBHwxogXPRd73APYNV5JKa3lWmctpx6zalU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=atOpKp47; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aktIhWgcbAvXeD69g7I04AeTrO2X7tTBMN64YXO5bP8=;
  b=atOpKp47TM16T3O77it6O0zIyihp28tiESgh+YjRnr3zlld4WPdp59RV
   6ZQ5LNb/ri+U3yy0xOuHBxt6P+bMGxzY0v3v6M6e51WSxRzeTcL+yqv7b
   QrSSwQ4blS5ApGtNXbsghNdXmHP4SEiP0oG7uJztJV6cDGF98LxrczG/N
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,257,1708383600"; 
   d="scan'208";a="164584211"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:15:04 +0200
Date: Mon, 6 May 2024 07:15:04 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Ira Weiny <ira.weiny@intel.com>
cc: Julia Lawall <julia.lawall@inria.fr>, Matthew Wilcox <willy@infradead.org>, 
    Dan Carpenter <dan.carpenter@oracle.com>, 
    "Fabio M. De Francesco" <fmdefrancesco@gmail.com>, 
    Viacheslav Dubeyko <slava@dubeyko.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Bart Van Assche <bvanassche@acm.org>, Kees Cook <keescook@chromium.org>, 
    linux-fsdevel@vger.kernel.org
Subject: Re: kmap + memmove
In-Reply-To: <6638512f36503_25842129471@iweiny-mobl.notmuch>
Message-ID: <alpine.DEB.2.22.394.2405060714480.3799@hadrien>
References: <Zjd61vTCQoDN9tUJ@casper.infradead.org> <alpine.DEB.2.22.394.2405051500030.3397@hadrien> <6638512f36503_25842129471@iweiny-mobl.notmuch>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 5 May 2024, Ira Weiny wrote:

> Julia Lawall wrote:
> >
> >
> > On Sun, 5 May 2024, Matthew Wilcox wrote:
> >
> > > Here's a fun bug that's not obvious:
> > >
> > > hfs_bnode_move:
> > >                                 dst_ptr = kmap_local_page(*dst_page);
> > >                                 src_ptr = kmap_local_page(*src_page);
> > >                                 memmove(dst_ptr, src_ptr, src);
> > >
> > > If both of the pointers are guaranteed to come from diffeerent calls to
> > > kmap_local(), memmove() is probably not going to do what you want.
> > > Worth a smatch or coccinelle rule?
> > >
> > > The only time that memmove() is going to do something different from
> > > memcpy() is when src and dst overlap.  But if src and dst both come
> > > from kmap_local(), they're guaranteed to not overlap.  Even if dst_page
> > > and src_page were the same.
> > >
> > > Which means the conversion in 6c3014a67a44 was buggy.  Calling kmap()
> > > for the same page twice gives you the same address.  Calling kmap_local()
> > > for the same page twice gives you two different addresses.
> > >
> > > Fabio, how many other times did you create this same bug?  Ira, I'm
> > > surprised you didn't catch this one; you created the same bug in
> > > memmove_page() which I got Fabio to delete in 9384d79249d0.
> > >
> >
> > I tried the following rule:
> >
> > @@
> > expression dst_ptr, src_ptr, dst_page, src_page, src;
> > @@
> >
> > *                                dst_ptr = kmap_local_page(dst_page);
> > 				... when any
> > *                                src_ptr = kmap_local_page(src_page);
> > 				... when any
> > *                                memmove(dst_ptr, src_ptr, src);
> >
> > That is, basically what you wrote, but with anything in between the lines,
> > and the various variables being any expression.
> >
> > I only got the following results, which I guess are what you are already
> > looking at:
> >
> > @@ -193,9 +193,6 @@ void hfs_bnode_move(struct hfs_bnode *no
> >
> >  		if (src == dst) {
> >  			while (src < len) {
> > -				dst_ptr = kmap_local_page(*dst_page);
> > -				src_ptr = kmap_local_page(*src_page);
> > -				memmove(dst_ptr, src_ptr, src);
> >  				kunmap_local(src_ptr);
> >  				set_page_dirty(*dst_page);
> >  				kunmap_local(dst_ptr);
> >
>
> I'm no expert but this did not catch all theplaces there might be a
> problem.
>
> hfsplus/bnode.c: hfs_bnode_move() also does:
>
> 216                                 dst_ptr = kmap_local_page(*dst_page) + dst;
> 217                                 src_ptr = kmap_local_page(*src_page) + src;
> ...
> 228                                 memmove(dst_ptr - l, src_ptr - l, l);
>
> ...
>
> 247                         dst_ptr = kmap_local_page(*dst_page) + src;
> 248                         src_ptr = kmap_local_page(*src_page) + src;
> 249                         memmove(dst_ptr, src_ptr, l);
>
> ...
>
> 265                                 dst_ptr = kmap_local_page(*dst_page) + dst;
> 266                                 src_ptr = kmap_local_page(*src_page) + src;
>
> ...
>
> 278                                 memmove(dst_ptr, src_ptr, l);
>
> Can you wildcard the pointer arithmetic?

Yes.  Will try it.

julia

>
> Ira
>
>
> > @@ -253,9 +250,6 @@ void hfs_bnode_move(struct hfs_bnode *no
> >
> >  			while ((len -= l) != 0) {
> >  				l = min_t(int, len, PAGE_SIZE);
> > -				dst_ptr = kmap_local_page(*++dst_page);
> > -				src_ptr = kmap_local_page(*++src_page);
> > -				memmove(dst_ptr, src_ptr, l);
> >  				kunmap_local(src_ptr);
> >  				set_page_dirty(*dst_page);
> >  				kunmap_local(dst_ptr);
> >
> > julia
>
>
>

