Return-Path: <linux-fsdevel+bounces-10252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C4D84970C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 10:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C07428D0B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 09:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13541134B2;
	Mon,  5 Feb 2024 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zm/eVhkT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7891134AA
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126841; cv=none; b=LadCb3jN8zBEJ79Piijlc4L280eXWw6PBZ8zzEVaXsjHBcxW5ZmciI7JKSaRpUJDgjWZRFw22MChYd72Bd/cEfE80cmK1HHuXFu5o3LW5XlS+itYup1vSoSfjC/s26N9CGZdmERgp07iFblKEUUqa9PXSXJQ/FringoLJxxxEh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126841; c=relaxed/simple;
	bh=9BTY2mhrviUVL/AYXjnpvkCacHDAz83bGYR0WxWH1B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+4vzjvc1fkMKXn9NOdC9LX5RzuT7UpKLTVuF4e2YvsSdnb8YWanLCTGDbDCFZHRqQL3OjjRzMPnPZHIJRD66Qz72KzrhoB6V2Ul2b8zj2x6HibTOrgE3LlTaiE06N4Blh32IWygYGZJl6AYKNUHrwfSb0o4O1tRsYwVlisjS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zm/eVhkT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707126838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L40x9EmC//Z/IURxbr1HiKYTbhCONWsaujp5SiZFte0=;
	b=Zm/eVhkTHO7fU14/sXBupnmtIWr4h1RhaHPPtPUYjtAkRmecQAvoo59oGxoMh3bYarTuof
	v8EI6/oKkpcq3eio84NEfTtyJuegNp1hFR34cvFHKyuDL4NHKqGSQCNmQkn5z7riqxF85P
	IIFM4uJ74MBkXE1Ws5yTrr41b3lhSSw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-JhF2NxylPlyvXTa0o4_Bkg-1; Mon, 05 Feb 2024 04:53:55 -0500
X-MC-Unique: JhF2NxylPlyvXTa0o4_Bkg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0897A1065221;
	Mon,  5 Feb 2024 09:53:55 +0000 (UTC)
Received: from fedora (unknown [10.72.116.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CE813C2E;
	Mon,  5 Feb 2024 09:53:49 +0000 (UTC)
Date: Mon, 5 Feb 2024 17:53:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Don Dutile <ddutile@redhat.com>, Rafael Aquini <raquini@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH] mm/madvise: set ra_pages as device max request size
 during ADV_POPULATE_READ
Message-ID: <ZcCwKc1k/W5xSsGK@fedora>
References: <20240202022029.1903629-1-ming.lei@redhat.com>
 <ZcAfF18OM2kqKsBe@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcAfF18OM2kqKsBe@dread.disaster.area>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Mon, Feb 05, 2024 at 10:34:47AM +1100, Dave Chinner wrote:
> On Fri, Feb 02, 2024 at 10:20:29AM +0800, Ming Lei wrote:
> > madvise(MADV_POPULATE_READ) tries to populate all page tables in the
> > specific range, so it is usually sequential IO if VMA is backed by
> > file.
> > 
> > Set ra_pages as device max request size for the involved readahead in
> > the ADV_POPULATE_READ, this way reduces latency of madvise(MADV_POPULATE_READ)
> > to 1/10 when running madvise(MADV_POPULATE_READ) over one 1GB file with
> > usual(default) 128KB of read_ahead_kb.
> > 
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Don Dutile <ddutile@redhat.com>
> > Cc: Rafael Aquini <raquini@redhat.com>
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: Mike Snitzer <snitzer@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  mm/madvise.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 51 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 912155a94ed5..db5452c8abdd 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -900,6 +900,37 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> >  		return -EINVAL;
> >  }
> >  
> > +static void madvise_restore_ra_win(struct file **file, unsigned int ra_pages)
> > +{
> > +	if (*file) {
> > +		struct file *f = *file;
> > +
> > +		f->f_ra.ra_pages = ra_pages;
> > +		fput(f);
> > +		*file = NULL;
> > +	}
> > +}
> > +
> > +static struct file *madvise_override_ra_win(struct file *f,
> > +		unsigned long start, unsigned long end,
> > +		unsigned int *old_ra_pages)
> > +{
> > +	unsigned int io_pages;
> > +
> > +	if (!f || !f->f_mapping || !f->f_mapping->host)
> > +		return NULL;
> > +
> > +	io_pages = inode_to_bdi(f->f_mapping->host)->io_pages;
> > +	if (((end - start) >> PAGE_SHIFT) < io_pages)
> > +		return NULL;
> > +
> > +	f = get_file(f);
> > +	*old_ra_pages = f->f_ra.ra_pages;
> > +	f->f_ra.ra_pages = io_pages;
> > +
> > +	return f;
> > +}
> 
> This won't do what you think if the file has been marked
> FMODE_RANDOM before this populate call.

Yeah.

But madvise(POPULATE_READ) is actually one action,
so userspace can call fadvise(POSIX_FADV_NORMAL) or fadvise(POSIX_FADV_SEQUENTIAL)
before madvise(POPULATE_READ), and set RANDOM advise back after
madvise(POPULATE_READ) returns, so looks not big issue in reality.

> 
> IOWs, I don't think madvise should be digging in the struct file
> readahead stuff here. It should call vfs_fadvise(FADV_SEQUENTIAL) to
> do the set the readahead mode, rather that try to duplicate
> FADV_SEQUENTIAL (badly).  We already do this for WILLNEED to make it
> do the right thing, we should be doing the same thing here.

FADV_SEQUENTIAL doubles current readahead window, which is far from
enough to get top performance, such as, latency of doubling (default) ra
window is still 2X of setting ra windows as bdi->io_pages.

If application sets small 'bdi/read_ahead_kb' just like this report, the
gap can be very big.

Or can we add one API/helper in fs code to set file readahead ra_pages for
this use case?

> 
> Also, AFAICT, there is no need for get_file()/fput() here - the vma
> already has a reference to the struct file, and the vma should not
> be going away whilst the madvise() operation is in progress.

You are right, get_file() is only needed in case of dropping mm lock.


Thanks,
Ming


