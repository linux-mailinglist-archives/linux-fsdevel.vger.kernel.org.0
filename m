Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAFA6169A94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 00:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgBWXDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 18:03:36 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:36173 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbgBWXDf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:03:35 -0500
Received: from dread.disaster.area (pa49-195-185-106.pa.nsw.optusnet.com.au [49.195.185.106])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id C92953A2160;
        Mon, 24 Feb 2020 10:03:31 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j60Ha-0004Lm-SA; Mon, 24 Feb 2020 10:03:30 +1100
Date:   Mon, 24 Feb 2020 10:03:30 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, hch@infradead.org,
        dan.j.williams@intel.com, dm-devel@redhat.com
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
Message-ID: <20200223230330.GE10737@dread.disaster.area>
References: <20200218214841.10076-1-vgoyal@redhat.com>
 <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
 <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
 <20200221201759.GF25974@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221201759.GF25974@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=bkRQb8bsQZKWSSj4M57YXw==:117 a=bkRQb8bsQZKWSSj4M57YXw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=Tiexoni3D8iDDdk-dk8A:9
        a=e9bV8kUA3kBD_Rgu:21 a=cgdUXTeVlpyUC10k:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 03:17:59PM -0500, Vivek Goyal wrote:
> On Fri, Feb 21, 2020 at 01:32:48PM -0500, Jeff Moyer wrote:
> > Vivek Goyal <vgoyal@redhat.com> writes:
> > 
> > > On Thu, Feb 20, 2020 at 04:35:17PM -0500, Jeff Moyer wrote:
> > >> Vivek Goyal <vgoyal@redhat.com> writes:
> > >> 
> > >> > Currently pmem_clear_poison() expects offset and len to be sector aligned.
> > >> > Atleast that seems to be the assumption with which code has been written.
> > >> > It is called only from pmem_do_bvec() which is called only from pmem_rw_page()
> > >> > and pmem_make_request() which will only passe sector aligned offset and len.
> > >> >
> > >> > Soon we want use this function from dax_zero_page_range() code path which
> > >> > can try to zero arbitrary range of memory with-in a page. So update this
> > >> > function to assume that offset and length can be arbitrary and do the
> > >> > necessary alignments as needed.
> > >> 
> > >> What caller will try to zero a range that is smaller than a sector?
> > >
> > > Hi Jeff,
> > >
> > > New dax zeroing interface (dax_zero_page_range()) can technically pass
> > > a range which is less than a sector. Or which is bigger than a sector
> > > but start and end are not aligned on sector boundaries.
> > 
> > Sure, but who will call it with misaligned ranges?
> 
> create a file foo.txt of size 4K and then truncate it.
> 
> "truncate -s 23 foo.txt". Filesystems try to zero the bytes from 24 to
> 4095.

This should fail with EIO. Only full page writes should clear the
bad page state, and partial writes should therefore fail because
they do not guarantee the data in the filesystem block is all good.

If this zeroing was a buffered write to an address with a bad
sector, then the writeback will fail and the user will (eventually)
get an EIO on the file.

DAX should do the same thing, except because the zeroing is
synchronous (i.e. done directly by the truncate syscall) we can -
and should - return EIO immediately.

Indeed, with your code, if we then extend the file by truncating up
back to 4k, then the range between 23 and 512 is still bad, even
though we've successfully zeroed it and the user knows it. An
attempt to read anywhere in this range (e.g. 10 bytes at offset 100)
will fail with EIO, but reading 10 bytes at offset 2000 will
succeed.

That's *awful* behaviour to expose to userspace, especially when
they look at the fs config and see that it's using both 4kB block
and sector sizes...

The only thing that makes sense from a filesystem perspective is
clearing bad page state when entire filesystem blocks are
overwritten. The data in a filesystem block is either good or bad,
and it doesn't matter how many internal (kernel or device) sectors
it has.

> > And what happens to the rest?  The caller is left to trip over the
> > errors?  That sounds pretty terrible.  I really think there needs to be
> > an explicit contract here.
> 
> Ok, I think is is the contentious bit. Current interface
> (__dax_zero_page_range()) either clears the poison (if I/O is aligned to
> sector) or expects page to be free of poison.
> 
> So in above example, of "truncate -s 23 foo.txt", currently I get an error
> because range being zeroed is not sector aligned. So
> __dax_zero_page_range() falls back to calling direct_access(). Which
> fails because there are poisoned sectors in the page.
> 
> With my patches, dax_zero_page_range(), clears the poison from sector 1 to
> 7 but leaves sector 0 untouched and just writes zeroes from byte 0 to 511
> and returns success.

Ok, kernel sectors are not the unit of granularity bad page state
should be managed at. They don't match page state granularity, and
they don't match filesystem block granularity, and the whacky
"partial writes silently succeed, reads fail unpredictably"
assymetry it leads to will just cause problems for users.

> So question is, is this better behavior or worse behavior. If sector 0
> was poisoned, it will continue to remain poisoned and caller will come
> to know about it on next read and then it should try to truncate file
> to length 0 or unlink file or restore that file to get rid of poison.

Worse, because the filesystem can't track what sub-parts of the
block are bad and that leads to inconsistent data integrity status
being exposed to userspace.


> IOW, if a partial block is being zeroed and if it is poisoned, caller
> will not be return an error and poison will not be cleared and memory
> will be zeroed. What do we expect in such cases.
> 
> Do we expect an interface where if there are any bad blocks in the range
> being zeroed, then they all should be cleared (and hence all I/O should
> be aligned) otherwise error is returned. If yes, I could make that
> change.
> 
> Downside of current interface is that it will clear as many blocks as
> possible in the given range and leave starting and end blocks poisoned
> (if it is unaligned) and not return error. That means a reader will
> get error on these blocks again and they will have to try to clear it
> again.

Which is solved by having partial page writes always EIO on poisoned
memory.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
