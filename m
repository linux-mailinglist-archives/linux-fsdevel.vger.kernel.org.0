Return-Path: <linux-fsdevel+bounces-37100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DC89ED836
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 22:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B208160FFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 21:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B1C1DA0FE;
	Wed, 11 Dec 2024 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eQugjS6r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C669259498
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951514; cv=none; b=Yt9+c0woxDcbUobV8Ij2NE/fC00kDwzOjc2ZNCuwy0gnEB08IU8q6Sq8QdZewMUn8ItBkGWINuZbhHJ2uGLOq4W4+7bXn4KDSMte8v6FaUqcsijArJ9OcZdFXWjWNYyFBawbAeppwtT18Dre2ms2PJnuib1YgLAn1XlreBmjiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951514; c=relaxed/simple;
	bh=56a0hxf/sbPW9GEMYGG9e1eZ7XI/XpMK6FkrLkuZZzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Km4GLPgVIIvw+sFayTxZBBuoE41RRAaJasTKEy3go+6O8tKBLVwaVg2nXWJbYbPneFFEu7k3wLTJoZFw4ozsvQA92g7z2wms2gPtVnJy9azaxuvXXugbI34o1wRq78oe8LmqXc6YRHMEhIk8FS8uvTy5uT3XmVyjxRUr9eqVB7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eQugjS6r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=gdsPTCupbgOEWLACzNfCxSkC4dLmLrOQ7de/78UB66k=; b=eQugjS6r9kMIolNkbQJmWUTFwt
	tsPoKWnYX1Zv7EehbNstRUd5ZcNpQJXuovzwUZrnUAxpcsxjmHh34knQGTHkgT7qlcoMwc8PPLcnk
	zlLrhwCJ4KxQfgd9AgNVMhwQbja5Y7IMyMijYHcUXIFz2rUMJ3I9lXbgrYwjsXHFXD18KMtCmJJt0
	UuYYVlvhhcsg0s3kt/80TwVEELf/6Mlx0mK7h/PmdhoCVesed6yPBVCbK9CTQk8s3yDj9k5cl6KSq
	+AiYL6C427ckbA4KmZI1Zv1pMCVmZ4dL/IsM5mNG2SBX0G6s8XygdJX627mz0AZKkS4LqBe7txJIH
	0zv1RqfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLTzm-00000000wLU-3cpp;
	Wed, 11 Dec 2024 21:11:46 +0000
Date: Wed, 11 Dec 2024 21:11:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com, shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH v2 10/12] fuse: support large folios for direct io
Message-ID: <Z1oAEr6WFh6cSerU@casper.infradead.org>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
 <20241125220537.3663725-11-joannelkoong@gmail.com>
 <20241209155042.GB2843669@perftesting>
 <Z1cSy1OUxPZ2kzYT@casper.infradead.org>
 <CAJnrk1YYeYcUxwrojuDFKsYKG5yK-p_Z9MkYBuHTavNrRfR-PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YYeYcUxwrojuDFKsYKG5yK-p_Z9MkYBuHTavNrRfR-PQ@mail.gmail.com>

On Wed, Dec 11, 2024 at 01:04:45PM -0800, Joanne Koong wrote:
> On Mon, Dec 9, 2024 at 7:54 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Dec 09, 2024 at 10:50:42AM -0500, Josef Bacik wrote:
> > > As we've noticed in the upstream bug report for your initial work here, this
> > > isn't quite correct, as we could have gotten a large folio in from userspace.  I
> > > think the better thing here is to do the page extraction, and then keep track of
> > > the last folio we saw, and simply skip any folios that are the same for the
> > > pages we have.  This way we can handle large folios correctly.  Thanks,
> >
> > Some people have in the past thought that they could skip subsequent
> > page lookup if the folio they get back is large.  This is an incorrect
> > optimisation.  Userspace may mmap() a file PROT_WRITE, MAP_PRIVATE.
> > If they store to the middle of a large folio (the file that is mmaped
> > may be on a filesystem that does support large folios, rather than
> > fuse), then we'll have, eg:
> >
> > folio A page 0
> > folio A page 1
> > folio B page 0
> > folio A page 3
> >
> > where folio A belongs to the file and folio B is an anonymous COW page.
> 
> Sounds good, I'll fix this up in v3. Thanks.

Hm?  I didn't notice this bug in your code, just mentioning something
I've seen other people do and wanted to make suree you didn't.  Did I
miss a bug in your code?

