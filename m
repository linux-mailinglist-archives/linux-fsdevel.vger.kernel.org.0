Return-Path: <linux-fsdevel+bounces-9985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6109846E57
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA85D1C266A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860C913E202;
	Fri,  2 Feb 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeTJN+64"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6AA13DB99
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871180; cv=none; b=fzqpiY3xG9GwMi0BSERk5MKBjOZUSOaHrFJpZL9ORdtO09gJNgHzGe2uTh+QFCz48yB4zRvwQaJs8obNiu/GqKa/H15Tav6TMTsQFnmlTI7oYulp8/uFd5lTDeWGo81X4ZeE6YHc+EzvTNBOIEyLEqvOJ1FbqckoiPF8jOyZC/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871180; c=relaxed/simple;
	bh=dqUxwBZX2kfI3B+P5TtoZCK0zVV9VHWfEdhugIz7LIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cD4w5D0THswePHx3EOyjQCn1eMfQi+n3vOsXpRykD120SHRMr5oWATiNxYoXb3K390oIg9Mg/9HkFkHzhI/+dgJR6t/KxEGDQ2x4uJCtKggSVPZGCOOdC6Hxc0kgqZXlE2aeNjTL+pGJ5Hln43xSlhRcW8w06dz14oM8zfRDFrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SeTJN+64; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706871177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZClaqx53ZJJu0ie6KUCf9aABm/H96wl0onIl5m7Has8=;
	b=SeTJN+64PCjm+xkaoqCNwhvFiFJDd3KAz+0ic49xX1UIThfvffXsSirlxNmXv3a5oje1ci
	A+zoWNeD7h4rahVeMaZFDh7NVsag0scwTE07XKxLl8ZcEowJz5Vv0VD36A5JhfUS7p16BT
	cEbBEL/7atCogNDeWLH4UzJTFX7oyLM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-iW2aeLZvPEy-2p72J5_cXA-1; Fri, 02 Feb 2024 05:52:52 -0500
X-MC-Unique: iW2aeLZvPEy-2p72J5_cXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71E5385A588;
	Fri,  2 Feb 2024 10:52:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D9E5640C95AD;
	Fri,  2 Feb 2024 10:52:45 +0000 (UTC)
Date: Fri, 2 Feb 2024 18:52:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Don Dutile <ddutile@redhat.com>, Rafael Aquini <raquini@redhat.com>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: mm/madvise: set ra_pages as device max request size during
 ADV_POPULATE_READ
Message-ID: <ZbzJZji95a1qmhcj@fedora>
References: <20240202022029.1903629-1-ming.lei@redhat.com>
 <Zbxy30POPE8rN_YN@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbxy30POPE8rN_YN@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Thu, Feb 01, 2024 at 11:43:11PM -0500, Mike Snitzer wrote:
> On Thu, Feb 01 2024 at  9:20P -0500,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
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
> > +
> 
> Does this override imply that madvise_populate resorts to calling
> filemap_fault() and here you're just arming it to use the larger
> ->io_pages for the duration of all associated faulting?

Yes.

> 
> Wouldn't it be better to avoid faulting and build up larger page

How can we avoid the fault handling? which is needed to build VA->PA mapping.

> vectors that get sent down to the block layer in one go and let the

filemap_fault() already tries to allocate folio in big size(max order
is MAX_PAGECACHE_ORDER), see page_cache_ra_order() and ra_alloc_folio().

> block layer split using the device's limits? (like happens with
> force_page_cache_ra)

Here filemap code won't deal with block directly because there is VFS &
FS and io mapping is required, and it just calls aops->readahead() or
aops->read_folio(), but block plug & readahead_control are applied for
handling everything in batch.

> 
> I'm concerned that madvise_populate isn't so efficient with filemap

That is why this patch increases readahead window, then
madvise_populate() performance can be improved by X10 in big file-backed
popluate read.

> due to excessive faulting (*BUT* I haven't traced to know, I'm just
> inferring that is why twiddling f->f_ra.ra_pages helps improve
> madvise_populate by having it issue larger IO. Apologies if I'm way
> off base)

As mentioned, fault handling can't be avoided, but we can improve
involved readahead IO perf.



Thanks,
Ming


