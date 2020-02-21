Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C46C16882D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 21:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgBUUSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 15:18:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36164 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726483AbgBUUSJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 15:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582316288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zY/Z8TsLgbtng5kAwEfMEqxDzlskZr1LWc4KnWx4tb8=;
        b=a/8G+KySqjaOxzazykfVSEO2buZK273lFmAnSF7DHHa9bmUz+iVr7JF60LpqPNwwQgpSH+
        m+slsxGskn6XHIqfRgK/quDNEoH1qSpe8qncxdu+EUHnjbBeIjevYCKt7dSNK4rZtuHJux
        0TxLEiPLPQekmkXab6B4Yvx4sZ9Ep4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-HiTKLC89O265FEYHCpbOpQ-1; Fri, 21 Feb 2020 15:18:04 -0500
X-MC-Unique: HiTKLC89O265FEYHCpbOpQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C443107ACC5;
        Fri, 21 Feb 2020 20:18:03 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63A819077F;
        Fri, 21 Feb 2020 20:18:00 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 078AA220A24; Fri, 21 Feb 2020 15:17:59 -0500 (EST)
Date:   Fri, 21 Feb 2020 15:17:59 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, dm-devel@redhat.com
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
Message-ID: <20200221201759.GF25974@redhat.com>
References: <20200218214841.10076-1-vgoyal@redhat.com>
 <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
 <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 01:32:48PM -0500, Jeff Moyer wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > On Thu, Feb 20, 2020 at 04:35:17PM -0500, Jeff Moyer wrote:
> >> Vivek Goyal <vgoyal@redhat.com> writes:
> >> 
> >> > Currently pmem_clear_poison() expects offset and len to be sector aligned.
> >> > Atleast that seems to be the assumption with which code has been written.
> >> > It is called only from pmem_do_bvec() which is called only from pmem_rw_page()
> >> > and pmem_make_request() which will only passe sector aligned offset and len.
> >> >
> >> > Soon we want use this function from dax_zero_page_range() code path which
> >> > can try to zero arbitrary range of memory with-in a page. So update this
> >> > function to assume that offset and length can be arbitrary and do the
> >> > necessary alignments as needed.
> >> 
> >> What caller will try to zero a range that is smaller than a sector?
> >
> > Hi Jeff,
> >
> > New dax zeroing interface (dax_zero_page_range()) can technically pass
> > a range which is less than a sector. Or which is bigger than a sector
> > but start and end are not aligned on sector boundaries.
> 
> Sure, but who will call it with misaligned ranges?

create a file foo.txt of size 4K and then truncate it.

"truncate -s 23 foo.txt". Filesystems try to zero the bytes from 24 to
4095.

I have also written a test for this.

https://github.com/rhvgoyal/misc/blob/master/pmem-tests/iomap-range-test.sh#L102

> 
> > At this point of time, all I care about is that case of an arbitrary
> > range is handeled well. So if a caller passes a range in, we figure
> > out subrange which is sector aligned in terms of start and end, and
> > clear poison on those sectors and ignore rest of the range. And
> > this itself will be an improvement over current behavior where 
> > nothing is cleared if I/O is not sector aligned.
> 
> I don't think this makes sense.  The caller needs to know about the
> blast radius of errors.  This is why I asked for a concrete example.
> It might make more sense, for example, to return an error if not all of
> the errors could be cleared.
> 
> >> > nvdimm_clear_poison() seems to assume offset and len to be aligned to
> >> > clear_err_unit boundary. But this is currently internal detail and is
> >> > not exported for others to use. So for now, continue to align offset and
> >> > length to SECTOR_SIZE boundary. Improving it further and to align it
> >> > to clear_err_unit boundary is a TODO item for future.
> >> 
> >> When there is a poisoned range of persistent memory, it is recorded by
> >> the badblocks infrastructure, which currently operates on sectors.  So,
> >> no matter what the error unit is for the hardware, we currently can't
> >> record/report to userspace anything smaller than a sector, and so that
> >> is what we expect when clearing errors.
> >> 
> >> Continuing on for completeness, we will currently not map a page with
> >> badblocks into a process' address space.  So, let's say you have 256
> >> bytes of bad pmem, we will tell you we've lost 512 bytes, and even if
> >> you access a valid mmap()d address in the same page as the poisoned
> >> memory, you will get a segfault.
> >> 
> >> Userspace can fix up the error by calling write(2) and friends to
> >> provide new data, or by punching a hole and writing new data to the hole
> >> (which may result in getting a new block, or reallocating the old block
> >> and zeroing it, which will clear the error).
> >
> > Fair enough. I do not need poison clearing at finer granularity. It might
> > be needed once dev_dax path wants to clear poison. Not sure how exactly
> > that works.
> 
> It doesn't.  :)
> 
> >> > +	/*
> >> > +	 * Callers can pass arbitrary offset and len. But nvdimm_clear_poison()
> >> > +	 * expects memory offset and length to meet certain alignment
> >> > +	 * restrction (clear_err_unit). Currently nvdimm does not export
> >>                                                   ^^^^^^^^^^^^^^^^^^^^^^
> >> > +	 * required alignment. So align offset and length to sector boundary
> >> 
> >> What is "nvdimm" in that sentence?  Because the nvdimm most certainly
> >> does export the required alignment.  Perhaps you meant libnvdimm?
> >
> > I meant nvdimm_clear_poison() function in drivers/nvdimm/bus.c. Whatever
> > it is called. It first queries alignement required (clear_err_unit) and
> > then makes sure range passed in meets that alignment requirement.
> 
> My point was your comment is misleading.
> 
> >> We could potentially support clearing less than a sector, but I'd have
> >> to understand the use cases better before offerring implementation
> >> suggestions.
> >
> > I don't need clearing less than a secotr. Once somebody needs it they
> > can implement it. All I am doing is making sure current logic is not
> > broken when dax_zero_page_range() starts using this logic and passes
> > an arbitrary range. We need to make sure we internally align I/O 
> 
> An arbitrary range is the same thing as less than a sector.  :)  Do you
> know of an instance where the range will not be sector-aligned and sized?
> 
> > and carve out an aligned sub-range and pass that subrange to
> > nvdimm_clear_poison().
> 
> And what happens to the rest?  The caller is left to trip over the
> errors?  That sounds pretty terrible.  I really think there needs to be
> an explicit contract here.

Ok, I think is is the contentious bit. Current interface
(__dax_zero_page_range()) either clears the poison (if I/O is aligned to
sector) or expects page to be free of poison.

So in above example, of "truncate -s 23 foo.txt", currently I get an error
because range being zeroed is not sector aligned. So
__dax_zero_page_range() falls back to calling direct_access(). Which
fails because there are poisoned sectors in the page.

With my patches, dax_zero_page_range(), clears the poison from sector 1 to
7 but leaves sector 0 untouched and just writes zeroes from byte 0 to 511
and returns success.

So question is, is this better behavior or worse behavior. If sector 0
was poisoned, it will continue to remain poisoned and caller will come
to know about it on next read and then it should try to truncate file
to length 0 or unlink file or restore that file to get rid of poison.

IOW, if a partial block is being zeroed and if it is poisoned, caller
will not be return an error and poison will not be cleared and memory
will be zeroed. What do we expect in such cases.

Do we expect an interface where if there are any bad blocks in the range
being zeroed, then they all should be cleared (and hence all I/O should
be aligned) otherwise error is returned. If yes, I could make that
change.

Downside of current interface is that it will clear as many blocks as
possible in the given range and leave starting and end blocks poisoned
(if it is unaligned) and not return error. That means a reader will
get error on these blocks again and they will have to try to clear it
again.

Thanks
Vivek

