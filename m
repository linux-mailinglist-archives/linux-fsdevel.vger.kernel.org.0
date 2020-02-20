Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F61B166A14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 22:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgBTV5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 16:57:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25301 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726670AbgBTV5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582235837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KM6ABKd2tpz8kP31CQDO/5cFEUK72lQAq/0AyCLrpz4=;
        b=BzirWnC1E+bypiTxU6wzsU9+qzjau8N66CskbzQaOvDDe1Ehvon5rTsWOnCLLZmi+Ixcv4
        Kv/DY0D9DR6F6ySPQOSCFEVR7nvcBGo2o54DJ/cmijkvSqlD71QN5cXBS0HVIUljbd2Czg
        fmgVQgSQN4B4p1eWHEsANBH7U+nw4D4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-hV10MjEWOhC3izx9CnXW2Q-1; Thu, 20 Feb 2020 16:57:12 -0500
X-MC-Unique: hV10MjEWOhC3izx9CnXW2Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A759107ACC5;
        Thu, 20 Feb 2020 21:57:11 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90817619DB;
        Thu, 20 Feb 2020 21:57:08 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0C6C1220A24; Thu, 20 Feb 2020 16:57:08 -0500 (EST)
Date:   Thu, 20 Feb 2020 16:57:07 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, dm-devel@redhat.com
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
Message-ID: <20200220215707.GC10816@redhat.com>
References: <20200218214841.10076-1-vgoyal@redhat.com>
 <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 04:35:17PM -0500, Jeff Moyer wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > Currently pmem_clear_poison() expects offset and len to be sector aligned.
> > Atleast that seems to be the assumption with which code has been written.
> > It is called only from pmem_do_bvec() which is called only from pmem_rw_page()
> > and pmem_make_request() which will only passe sector aligned offset and len.
> >
> > Soon we want use this function from dax_zero_page_range() code path which
> > can try to zero arbitrary range of memory with-in a page. So update this
> > function to assume that offset and length can be arbitrary and do the
> > necessary alignments as needed.
> 
> What caller will try to zero a range that is smaller than a sector?

Hi Jeff,

New dax zeroing interface (dax_zero_page_range()) can technically pass
a range which is less than a sector. Or which is bigger than a sector
but start and end are not aligned on sector boundaries.

At this point of time, all I care about is that case of an arbitrary
range is handeled well. So if a caller passes a range in, we figure
out subrange which is sector aligned in terms of start and end, and
clear poison on those sectors and ignore rest of the range. And
this itself will be an improvement over current behavior where 
nothing is cleared if I/O is not sector aligned.

> 
> > nvdimm_clear_poison() seems to assume offset and len to be aligned to
> > clear_err_unit boundary. But this is currently internal detail and is
> > not exported for others to use. So for now, continue to align offset and
> > length to SECTOR_SIZE boundary. Improving it further and to align it
> > to clear_err_unit boundary is a TODO item for future.
> 
> When there is a poisoned range of persistent memory, it is recorded by
> the badblocks infrastructure, which currently operates on sectors.  So,
> no matter what the error unit is for the hardware, we currently can't
> record/report to userspace anything smaller than a sector, and so that
> is what we expect when clearing errors.
> 
> Continuing on for completeness, we will currently not map a page with
> badblocks into a process' address space.  So, let's say you have 256
> bytes of bad pmem, we will tell you we've lost 512 bytes, and even if
> you access a valid mmap()d address in the same page as the poisoned
> memory, you will get a segfault.
> 
> Userspace can fix up the error by calling write(2) and friends to
> provide new data, or by punching a hole and writing new data to the hole
> (which may result in getting a new block, or reallocating the old block
> and zeroing it, which will clear the error).

Fair enough. I do not need poison clearing at finer granularity. It might
be needed once dev_dax path wants to clear poison. Not sure how exactly
that works.

> 
> More comments below...
> 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  drivers/nvdimm/pmem.c | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > index 075b11682192..e72959203253 100644
> > --- a/drivers/nvdimm/pmem.c
> > +++ b/drivers/nvdimm/pmem.c
> > @@ -74,14 +74,28 @@ static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
> >  	sector_t sector;
> >  	long cleared;
> >  	blk_status_t rc = BLK_STS_OK;
> > +	phys_addr_t start_aligned, end_aligned;
> > +	unsigned int len_aligned;
> >  
> > -	sector = (offset - pmem->data_offset) / 512;
> > +	/*
> > +	 * Callers can pass arbitrary offset and len. But nvdimm_clear_poison()
> > +	 * expects memory offset and length to meet certain alignment
> > +	 * restrction (clear_err_unit). Currently nvdimm does not export
>                                                   ^^^^^^^^^^^^^^^^^^^^^^
> > +	 * required alignment. So align offset and length to sector boundary
> 
> What is "nvdimm" in that sentence?  Because the nvdimm most certainly
> does export the required alignment.  Perhaps you meant libnvdimm?

I meant nvdimm_clear_poison() function in drivers/nvdimm/bus.c. Whatever
it is called. It first queries alignement required (clear_err_unit) and
then makes sure range passed in meets that alignment requirement.

> 
> > +	 * before passing it to nvdimm_clear_poison().
> > +	 */
> > +	start_aligned = ALIGN(offset, SECTOR_SIZE);
> > +	end_aligned = ALIGN_DOWN((offset + len), SECTOR_SIZE) - 1;
> > +	len_aligned = end_aligned - start_aligned + 1;
> > +
> > +	sector = (start_aligned - pmem->data_offset) / 512;
> >  
> > -	cleared = nvdimm_clear_poison(dev, pmem->phys_addr + offset, len);
> > -	if (cleared < len)
> > +	cleared = nvdimm_clear_poison(dev, pmem->phys_addr + start_aligned,
> > +				      len_aligned);
> > +	if (cleared < len_aligned)
> >  		rc = BLK_STS_IOERR;
> >  	if (cleared > 0 && cleared / 512) {
> > -		hwpoison_clear(pmem, pmem->phys_addr + offset, cleared);
> > +		hwpoison_clear(pmem, pmem->phys_addr + start_aligned, cleared);
> >  		cleared /= 512;
> >  		dev_dbg(dev, "%#llx clear %ld sector%s\n",
> >  				(unsigned long long) sector, cleared,
> 
> We could potentially support clearing less than a sector, but I'd have
> to understand the use cases better before offerring implementation
> suggestions.

I don't need clearing less than a secotr. Once somebody needs it they
can implement it. All I am doing is making sure current logic is not
broken when dax_zero_page_range() starts using this logic and passes
an arbitrary range. We need to make sure we internally align I/O 
and carve out an aligned sub-range and pass that subrange to
nvdimm_clear_poison().

So if you can make sure I am not breaking things and new interface
will continue to clear poison on sector boundary, that will be great.

Thanks
Vivek

