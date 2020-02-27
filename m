Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 477E3170ECC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 04:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgB0DC6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 22:02:58 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:48093 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728206AbgB0DC6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 22:02:58 -0500
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 6CEFB7E8BF1;
        Thu, 27 Feb 2020 14:02:50 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j79Rp-00068S-3M; Thu, 27 Feb 2020 14:02:49 +1100
Date:   Thu, 27 Feb 2020 14:02:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, hch@infradead.org,
        dan.j.williams@intel.com, dm-devel@redhat.com
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
Message-ID: <20200227030248.GG10737@dread.disaster.area>
References: <20200218214841.10076-1-vgoyal@redhat.com>
 <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
 <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
 <20200221201759.GF25974@redhat.com>
 <20200223230330.GE10737@dread.disaster.area>
 <20200224153844.GB14651@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224153844.GB14651@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=7-415B0cAAAA:8 a=3Uponxbm9rQKfJszS7gA:9 a=Ka0kt8yWCJBL3DhL:21
        a=hsboJL87aekKxaTp:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 10:38:44AM -0500, Vivek Goyal wrote:
> On Mon, Feb 24, 2020 at 10:03:30AM +1100, Dave Chinner wrote:
> 
> [..]
> > > > > Hi Jeff,
> > > > >
> > > > > New dax zeroing interface (dax_zero_page_range()) can technically pass
> > > > > a range which is less than a sector. Or which is bigger than a sector
> > > > > but start and end are not aligned on sector boundaries.
> > > > 
> > > > Sure, but who will call it with misaligned ranges?
> > > 
> > > create a file foo.txt of size 4K and then truncate it.
> > > 
> > > "truncate -s 23 foo.txt". Filesystems try to zero the bytes from 24 to
> > > 4095.
> > 
> > This should fail with EIO. Only full page writes should clear the
> > bad page state, and partial writes should therefore fail because
> > they do not guarantee the data in the filesystem block is all good.
> > 
> > If this zeroing was a buffered write to an address with a bad
> > sector, then the writeback will fail and the user will (eventually)
> > get an EIO on the file.
> > 
> > DAX should do the same thing, except because the zeroing is
> > synchronous (i.e. done directly by the truncate syscall) we can -
> > and should - return EIO immediately.
> > 
> > Indeed, with your code, if we then extend the file by truncating up
> > back to 4k, then the range between 23 and 512 is still bad, even
> > though we've successfully zeroed it and the user knows it. An
> > attempt to read anywhere in this range (e.g. 10 bytes at offset 100)
> > will fail with EIO, but reading 10 bytes at offset 2000 will
> > succeed.
> 
> Hi Dave,
> 
> What is expected if I do "truncate -s 512 foo.txt". Say first sector (0 to
> 511) is poisoned and rest don't have poison. Should this fail with -EIO.

Yes - the filesystem block still contains bad data.

> In current implementation it does not.

I'm not surprised - the whole hardware error handling architecture
for FS-DAX is fundamentally broken. It was designed for device-dax,
and it just doesn't work for FS-DAX.

For example, to get the hardware error handling to be able to kill
userspace applications, a 1:1 physical-to-logical association
constraint was added to fs/dax.c:

/*
 * TODO: for reflink+dax we need a way to associate a single page with
 * multiple address_space instances at different linear_page_index()
 * offsets.
 */
static void dax_associate_entry(void *entry, struct address_space *mapping,
                struct vm_area_struct *vma, unsigned long address)

because device-dax only has *linear mappings* and so has a fixed
reverse mapping architecture.

i.e. the whole hardware error handling infrastructure was designed
around the constraints of device-dax. device-dax does not having any
structure to serialise access to the physical storage, so locking
was added to the mapping tree. THe mapping tree locking is accessed
on hardware error via the reverse mappingi association in the struct
page and that's how device-dax serialises direct physical storage
access against hardware error processing.  And while the page index
is locked in the mapping tree, it can walk the process vmas that
have the page mapped to kill them so that they don't try to access
the bad page.

That bad physical storage state is carried in a volatile struct page
flag, hence requiring some mechanism to make it persistent (the
device bad blocks register) and some other mechanism to clear the
poison state (direct IO, IIRC).

It's also a big, nasty, solid roadblock to implementing shared
data extents in FS-DAX. We basically have to completely re-architect
the hardware error handling for FS-DAX so that such errors are
reported to the filesystem first and then the filesystem does what
is needed to handle the error.

None of this works for filesystems because they need to perform
different operations depending on what the page that went bad
contains. FS-DAX should never trip over an unexpected poisoned page;
we do so now because such physical storage errors are completely
hidden form the fielsystem.

What you are trying to do is slap a band-aid over what to do when we
hit an unexpected page containing bad data. Filesystems expect to
find out about bad data in storage when they marshall the data into
or out of memory. They make the assumption that once it is in memory
it remains valid on the physical storage. Hence if an in-memory
error occurs, we can just toss it away and re-read it from storage,
and all is good.

FS-DAX changes that - we are no longer marshalling data into and out
of memory so we don't have a mechanism to get EIO when reading the
page into the page cache or writing it back to disk. We also don't
have an in-memory copy of the data - the physical storage is the
in-memory copy, and so we can't just toss it away when an error
occurs.

What we actually require is instantaneous notification of physical
storage errors so we can handle the error immediately. And that, in
turn, means we should never poison or see poisoned pages during
direct access operations because the filesystem doesn't need to
poison pages to prevent user access - it controls how the storage is
accessed directly.

e.g. if this error is in filesystem metadata, we might be able to
recover from it as that metadata might have a full copy in memory
(metadata is buffered in both XFS and ext4) or we might be able to
reconstruct it from other sources. Worst case, we have shut the
filesystem down completely so the admin can repair the damage the
lost page has caused.

e.g. The physical page may be located in free space, in which case
we don't care and can just zero it so all the bad hardware state is
cleared. The page never goes bad or gets poisoned in that case.

e.g. The physical page may be user data, in which case it may be
buffered in the page cache (non-dax) and so can easily be recovered.
It may not be recoverable, in which case we need to issue log
messages indicating that data has been lost (path, offset, length),
and do the VMA walk and kill processes that map that page. Then we
can zero the page to clear the bad state.

If, at any point we can't clear the bad state (e.g. the zeroing or
the read-back verification fails), then we need to make sure that
filesystem block is marked as allocated in the free space map, then
tell the reverse map that it's owner is now "bad storage" so it
never gets used again. i.e. this is the persistent bad block
storage, but doing it this way results in the rest of the filesystem
code never, ever seeing a poisoned page. And users never see it
either, because it will never be returned to the free space pool.

Of course, this relies of the filesystem having reverse mapping
capability. XFS already has this funcitonality available as a mkfs
option (mkfs.xfs -m rmapbt=1 ...), and we really need this so we can
get rid of the association of a physical page with a mapping and
file offset that device-dax requires for hardware page error
handling.  This means we don't need the physical storage to try to
hold filesystem layer reverse mapping information for us, and this
also removes the roadblock that the hardware error handling has
placed on implementing reflink w/ FS-DAX.

IOWs, the problem you are trying to solve is a direct result of
filesysetms not being informed when a physical pmem page goes bad
and the current error handling being implemented at entirely the
wrong layer for FS-DAX. It may work for device-dax, but it's most
definitely insufficient for correct error handling for filesystems.

> Anyway, partial page truncate can't ensure that data in rest of the page can
> be read back successfully. Memory can get poison after the write and
> hence read after truncate will still fail.

Which is where the notification requirement comes in. Yes, we may
still get errors on read or write, but if memory at rest goes bad,
we want to handle that and correct it ASAP, not wait days or months
for something to trip over the poisoned page before we find out
about it.

> Hence, all we are trying to ensure is that if a poison is known at the
> time of writing partial page, then we should return error to user space.

I think within FS-DAX infrastructure, any access to the data (read
or write) within a poisoned page or a page marked with PageError()
should return EIO to the caller, unless it's the specific command to
clear the error/poison state on the page. What happens with that
error state is then up to the caller.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
