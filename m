Return-Path: <linux-fsdevel+bounces-18808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB24C8BC724
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 07:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F00DCB20C4D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 05:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60C5481A6;
	Mon,  6 May 2024 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="jE8jroP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6577045944
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714974625; cv=none; b=Ivn2+UGvrRdmudyGuoWaem2cr6Lg6c1jP7mvYKn/A86m1zKoNXE+dSQtio71iwpG29t0e1bFx/Z4MLiPDdP7r0zGp69lE2wOJnC4xhJlS6ZxYdFVeD6yU3iESpaWh1qSqYhujChVkhIYwcWw8eAD6uAEaoav8dOkriYaCizCzUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714974625; c=relaxed/simple;
	bh=BB7co7ncyQ4BhlMg9tKl4Et+kHmn0HJm2qFWrKOdGF0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J2NGUEtR+KXVGILaxFLfophYlD16jveAgcFndwphe+fzTDCS1J1jg8HJnWDnRzrl7LOkTAbqCywBydq9m67x9Gz3JQzXWcjVAVAt2Af2+y9VPb9Xk7v3GeejjGLeD3rWxJvt90tdTCXSMoANYO7TTOSCytDJbkfJdRbpHf700R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=jE8jroP0; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/vXkPLi19ca/nmLj0tv7Xq8j1z1MGgLZDcmMq5cucBM=;
  b=jE8jroP04jxmbtwiEVtR+OGlJkwDR/fqOZM/OIYcGQ4j3yvMNXvqFPzR
   nzxhQGEcuRFCwDxIIt1vGc4SL/QE4+xWL+J55iNaVDLPq6h2+A8/lcBRA
   /IzR5CUejcKOciN1MgJby2bT03lmOql59nB0VvVenUclYGC9RUOo73+oj
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,257,1708383600"; 
   d="scan'208";a="164587377"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 07:50:19 +0200
Date: Mon, 6 May 2024 07:50:18 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Julia Lawall <julia.lawall@inria.fr>
cc: Ira Weiny <ira.weiny@intel.com>, Matthew Wilcox <willy@infradead.org>, 
    "Fabio M. De Francesco" <fmdefrancesco@gmail.com>, 
    Dan Carpenter <dan.carpenter@linaro.org>, 
    Viacheslav Dubeyko <slava@dubeyko.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Bart Van Assche <bvanassche@acm.org>, Kees Cook <keescook@chromium.org>, 
    linux-fsdevel@vger.kernel.org
Subject: Re: kmap + memmove
In-Reply-To: <alpine.DEB.2.22.394.2405060743420.3799@hadrien>
Message-ID: <alpine.DEB.2.22.394.2405060749120.3799@hadrien>
References: <Zjd61vTCQoDN9tUJ@casper.infradead.org> <alpine.DEB.2.22.394.2405051500030.3397@hadrien> <6638512f36503_25842129471@iweiny-mobl.notmuch> <alpine.DEB.2.22.394.2405060743420.3799@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

[Fixed a typo at the end of the message and added Dan's proper email
address]

On Mon, 6 May 2024, Julia Lawall wrote:

>
>
> On Sun, 5 May 2024, Ira Weiny wrote:
>
> > Julia Lawall wrote:
> > >
> > >
> > > On Sun, 5 May 2024, Matthew Wilcox wrote:
> > >
> > > > Here's a fun bug that's not obvious:
> > > >
> > > > hfs_bnode_move:
> > > >                                 dst_ptr = kmap_local_page(*dst_page);
> > > >                                 src_ptr = kmap_local_page(*src_page);
> > > >                                 memmove(dst_ptr, src_ptr, src);
> > > >
> > > > If both of the pointers are guaranteed to come from diffeerent calls to
> > > > kmap_local(), memmove() is probably not going to do what you want.
> > > > Worth a smatch or coccinelle rule?
> > > >
> > > > The only time that memmove() is going to do something different from
> > > > memcpy() is when src and dst overlap.  But if src and dst both come
> > > > from kmap_local(), they're guaranteed to not overlap.  Even if dst_page
> > > > and src_page were the same.
> > > >
> > > > Which means the conversion in 6c3014a67a44 was buggy.  Calling kmap()
> > > > for the same page twice gives you the same address.  Calling kmap_local()
> > > > for the same page twice gives you two different addresses.
> > > >
> > > > Fabio, how many other times did you create this same bug?  Ira, I'm
> > > > surprised you didn't catch this one; you created the same bug in
> > > > memmove_page() which I got Fabio to delete in 9384d79249d0.
> > > >
> > >
> > > I tried the following rule:
> > >
> > > @@
> > > expression dst_ptr, src_ptr, dst_page, src_page, src;
> > > @@
> > >
> > > *                                dst_ptr = kmap_local_page(dst_page);
> > > 				... when any
> > > *                                src_ptr = kmap_local_page(src_page);
> > > 				... when any
> > > *                                memmove(dst_ptr, src_ptr, src);
> > >
> > > That is, basically what you wrote, but with anything in between the lines,
> > > and the various variables being any expression.
> > >
> > > I only got the following results, which I guess are what you are already
> > > looking at:
> > >
> > > @@ -193,9 +193,6 @@ void hfs_bnode_move(struct hfs_bnode *no
> > >
> > >  		if (src == dst) {
> > >  			while (src < len) {
> > > -				dst_ptr = kmap_local_page(*dst_page);
> > > -				src_ptr = kmap_local_page(*src_page);
> > > -				memmove(dst_ptr, src_ptr, src);
> > >  				kunmap_local(src_ptr);
> > >  				set_page_dirty(*dst_page);
> > >  				kunmap_local(dst_ptr);
> > >
> >
> > I'm no expert but this did not catch all theplaces there might be a
> > problem.
> >
> > hfsplus/bnode.c: hfs_bnode_move() also does:
> >
> > 216                                 dst_ptr = kmap_local_page(*dst_page) + dst;
> > 217                                 src_ptr = kmap_local_page(*src_page) + src;
> > ...
> > 228                                 memmove(dst_ptr - l, src_ptr - l, l);
> >
> > ...
> >
> > 247                         dst_ptr = kmap_local_page(*dst_page) + src;
> > 248                         src_ptr = kmap_local_page(*src_page) + src;
> > 249                         memmove(dst_ptr, src_ptr, l);
> >
> > ...
> >
> > 265                                 dst_ptr = kmap_local_page(*dst_page) + dst;
> > 266                                 src_ptr = kmap_local_page(*src_page) + src;
> >
> > ...
> >
> > 278                                 memmove(dst_ptr, src_ptr, l);
> >
> > Can you wildcard the pointer arithmetic?
>
> I tried the following, which allows the kmap_local_page to be a
> subexpression of the right side of the assignment.  It also allows either
> order or the ptr initializations.  And it allows the pointer
> initializations to be part of some larger statement, such as an if test.
>
> @@
> expression dst_ptr, src_ptr, dst_page, src_page, src;
> @@
>
> *                                dst_ptr = <+...kmap_local_page(dst_page)...+>
>                               ... when any
> *                                src_ptr = <+...kmap_local_page(src_page)...+>
>                               ... when any
> *                                memmove(dst_ptr, src_ptr, src)
>
> @@
> expression dst_ptr, src_ptr, dst_page, src_page, src;
> @@
>
> *                                src_ptr = <+...kmap_local_page(src_page)...+>
>                               ... when any
> *                                dst_ptr = <+...kmap_local_page(dst_page)...+>
>                               ... when any
> *                                memmove(dst_ptr, src_ptr, src)
>
> I only found the occurrences in fs/hfsplus/bnode.c.
>
> Coccinelle furthermore focuses only on the files that contain both memmove
> and kmap_local_page.  These are:
>
> HANDLING: /home/julia/linux/drivers/block/zram/zram_drv.c
> HANDLING: /home/julia/linux/drivers/infiniband/hw/hfi1/sdma.c
> HANDLING: /home/julia/linux/net/sunrpc/xdr.c
> HANDLING: /home/julia/linux/kernel/crash_core.c
> HANDLING: /home/julia/linux/fs/hfs/bnode.c
> HANDLING: /home/julia/linux/fs/udf/inode.c
> HANDLING: /home/julia/linux/net/core/skbuff.c
> HANDLING: /home/julia/linux/fs/hfsplus/bnode.c
> HANDLING: /home/julia/linux/fs/erofs/decompressor.c
>
> One could check them manually to see if memmove and kmap_local_page are
> linked in some more direct way.

This was supposed to be "in some more indirect way".

julia

>
> julia
>
> >
> > Ira
> >
> >
> > > @@ -253,9 +250,6 @@ void hfs_bnode_move(struct hfs_bnode *no
> > >
> > >  			while ((len -= l) != 0) {
> > >  				l = min_t(int, len, PAGE_SIZE);
> > > -				dst_ptr = kmap_local_page(*++dst_page);
> > > -				src_ptr = kmap_local_page(*++src_page);
> > > -				memmove(dst_ptr, src_ptr, l);
> > >  				kunmap_local(src_ptr);
> > >  				set_page_dirty(*dst_page);
> > >  				kunmap_local(dst_ptr);
> > >
> > > julia
> >
> >
> >
>

