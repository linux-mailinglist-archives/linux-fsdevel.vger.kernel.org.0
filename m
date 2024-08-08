Return-Path: <linux-fsdevel+bounces-25477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7157494C624
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 23:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F80287EC8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 21:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8E915820F;
	Thu,  8 Aug 2024 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tFUB62D+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A015AD9B
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150960; cv=none; b=NC0/KIxI+ZB5N0ABJguKRRzYGQFUww2ult4QDDfE+Q2ScvF/kg7BNxkKMfKiV53/0lBY8Hm5QxfY0lQ+PC6vYOEsYdAfcDl4Q0xFIe6AordZh4m5B7z7y4ZFaUGJTQNZ8DCYev11nHfxW3iHsNmBJ2gV5sPHNoiqEyWbU0hA1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150960; c=relaxed/simple;
	bh=u9abRvxrZCTSqn4hqmI5SPzD4nwME8imhe/bqOjBPls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1uPadoPaJSg1l5oVQhb7avW6J1rYtLoQ7BEVecQ6dvKtHVofORTuMKr8n42j0weifvA8ABroomcUtzaJPNtH2LETXC6UzpjXbpaUIherwBg/JrRknn055Wb6EKlA7SFI1m+Zz4kYSOuNREB0EMTK58i9EVEid+BEyemdRZNc+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tFUB62D+; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 8 Aug 2024 14:02:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723150955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbAPo9z8CAdum7Nxf7shmVZRkLoHtXDBnE81/6BCoLU=;
	b=tFUB62D+e4lq8dxNzUOPrno/cMFWL+pHnwIsSkKnGRZp4TS82cUe2MP+t8uMxSK44rpFco
	eWJxwwA+nZQuoEYGyuLByl2JtYnFPuFn/XrZe4FcoKPK5W2qPp56L6WdEIfsucLYecO85p
	J5Q5miMXAQ33kdvorfHR3VIK6HuiPEU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	jannh@google.com, linux-fsdevel@vger.kernel.org, willy@infradead.org, 
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v4 bpf-next 06/10] lib/buildid: implement sleepable
 build_id_parse() API
Message-ID: <tmty3p7rduxdcixm2yprinndgabwzkdbvt6h2ksn6ezbc3hbaa@ta7t5r6btwsu>
References: <20240807234029.456316-1-andrii@kernel.org>
 <20240807234029.456316-7-andrii@kernel.org>
 <f3iayd76egugsgmk3evwrzn4bcko5ax2nohatgcdyxss2ilwup@pmrkbledcpc3>
 <CAEf4BzZ-EB9mV8A+pqcVj4HeZvjJummhK4XK0NHRs0C8WahK0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ-EB9mV8A+pqcVj4HeZvjJummhK4XK0NHRs0C8WahK0Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 08, 2024 at 01:15:52PM GMT, Andrii Nakryiko wrote:
> On Thu, Aug 8, 2024 at 11:40 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Wed, Aug 07, 2024 at 04:40:25PM GMT, Andrii Nakryiko wrote:
> > > Extend freader with a flag specifying whether it's OK to cause page
> > > fault to fetch file data that is not already physically present in
> > > memory. With this, it's now easy to wait for data if the caller is
> > > running in sleepable (faultable) context.
> > >
> > > We utilize read_cache_folio() to bring the desired folio into page
> > > cache, after which the rest of the logic works just the same at folio level.
> > >
> > > Suggested-by: Omar Sandoval <osandov@fb.com>
> > > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  lib/buildid.c | 44 ++++++++++++++++++++++++++++----------------
> > >  1 file changed, 28 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/lib/buildid.c b/lib/buildid.c
> > > index 5e6f842f56f0..e1c01b23efd8 100644
> > > --- a/lib/buildid.c
> > > +++ b/lib/buildid.c
> > > @@ -20,6 +20,7 @@ struct freader {
> > >                       struct folio *folio;
> > >                       void *addr;
> > >                       loff_t folio_off;
> > > +                     bool may_fault;
> > >               };
> > >               struct {
> > >                       const char *data;
> > > @@ -29,12 +30,13 @@ struct freader {
> > >  };
> > >
> > >  static void freader_init_from_file(struct freader *r, void *buf, u32 buf_sz,
> > > -                                struct address_space *mapping)
> > > +                                struct address_space *mapping, bool may_fault)
> > >  {
> > >       memset(r, 0, sizeof(*r));
> > >       r->buf = buf;
> > >       r->buf_sz = buf_sz;
> > >       r->mapping = mapping;
> > > +     r->may_fault = may_fault;
> > >  }
> > >
> > >  static void freader_init_from_mem(struct freader *r, const char *data, u64 data_sz)
> > > @@ -63,6 +65,11 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
> > >       freader_put_folio(r);
> > >
> > >       r->folio = filemap_get_folio(r->mapping, file_off >> PAGE_SHIFT);
> > > +
> > > +     /* if sleeping is allowed, wait for the page, if necessary */
> > > +     if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)))
> > > +             r->folio = read_cache_folio(r->mapping, file_off >> PAGE_SHIFT, NULL, NULL);
> >
> > Willy's network fs comment is bugging me. If we pass NULL for filler,
> > the kernel will going to use fs's read_folio() callback. I have checked
> > read_folio() for fuse and nfs and it seems like for at least these two
> > filesystems the callback is accessing file->private_data. So, if the elf
> > file is on these filesystems, we might see null accesses.
> >
> 
> Isn't that just a huge problem with the read_cache_folio() interface
> then? That file is optional, in general, but for some specific FS
> types it's not. How generic code is supposed to know this?
> 
> Or maybe it's a bug with the nfs_read_folio() and fuse_read_folio()
> implementation that they can't handle NULL file argument?
> netfs_read_folio(), for example, seems to be working with file == NULL
> just fine.

If you go a bit down in netfs_alloc_request() there is the following
code:

        if (rreq->netfs_ops->init_request) {
		ret = rreq->netfs_ops->init_request(rreq, file);
		...
	...

I think this init_request is pointing to nfs_netfs_init_request which
calls nfs_file_open_context(file) and access filp->private_data.

> 
> Matthew, can you please advise what's the right approach here? I can,
> of course, always get file refcount, but most of the time it will be
> just an unnecessary overhead, so ideally I'd like to avoid that. But
> if I have to check each read_folio callback implementation to know
> whether it's required or not, then that's not great...

I don't think we will need file refcnt. We have mmap lock in read mode
in this context because we are accessing vma and this vma has reference
to the file. So, this file can not go away under us here.

