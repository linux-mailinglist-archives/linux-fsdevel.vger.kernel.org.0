Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E443A172E55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 02:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgB1BbA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 20:31:00 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:40333 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730155AbgB1BbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 20:31:00 -0500
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D65E57EAC9F;
        Fri, 28 Feb 2020 12:30:56 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j7UUQ-0005gj-Iv; Fri, 28 Feb 2020 12:30:54 +1100
Date:   Fri, 28 Feb 2020 12:30:54 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
Message-ID: <20200228013054.GO10737@dread.disaster.area>
References: <20200218214841.10076-1-vgoyal@redhat.com>
 <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
 <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
 <20200221201759.GF25974@redhat.com>
 <20200223230330.GE10737@dread.disaster.area>
 <20200224153844.GB14651@redhat.com>
 <20200227030248.GG10737@dread.disaster.area>
 <CAPcyv4gTSb-xZ2k938HxQeAXATvGg1aSkEGPfrzeQAz9idkgzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gTSb-xZ2k938HxQeAXATvGg1aSkEGPfrzeQAz9idkgzQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=7-415B0cAAAA:8 a=NxkpfW6PSC3fqcVbgWsA:9 a=iOAVfZH_XQw0H41z:21
        a=2HYxUNSYbguoUMYx:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 08:19:37PM -0800, Dan Williams wrote:
> On Wed, Feb 26, 2020 at 7:03 PM Dave Chinner <david@fromorbit.com> wrote:
> > On Mon, Feb 24, 2020 at 10:38:44AM -0500, Vivek Goyal wrote:
> > > Anyway, partial page truncate can't ensure that data in rest of the page can
> > > be read back successfully. Memory can get poison after the write and
> > > hence read after truncate will still fail.
> >
> > Which is where the notification requirement comes in. Yes, we may
> > still get errors on read or write, but if memory at rest goes bad,
> > we want to handle that and correct it ASAP, not wait days or months
> > for something to trip over the poisoned page before we find out
> > about it.
> >
> > > Hence, all we are trying to ensure is that if a poison is known at the
> > > time of writing partial page, then we should return error to user space.
> >
> > I think within FS-DAX infrastructure, any access to the data (read
> > or write) within a poisoned page or a page marked with PageError()
> > should return EIO to the caller, unless it's the specific command to
> > clear the error/poison state on the page. What happens with that
> > error state is then up to the caller.
> >
> 
> I agree with most of the above if you replace "device-dax error
> handling" with "System RAM error handling". It's typical memory error
> handling that injects the page->index and page->mappping dependency.

I disagree, but that's beside the point and not worth arguing.

> So you want the FS to have error handling for just pmem errors or all
> memory errors?

Just pmem errors in the specific range the filesystem manages - we
really only care storage errors because those are the only errors
the filesystem is responsible for handling correctly.

Somebody else can worry about errors that hit page cache pages -
page cache pages require mapping/index pointers on each page anyway,
so a generic mechanism for handling those errors can be built into
the page cache. And if the error is in general kernel memory, then
it's game over for the entire kernel at that point, not just the
filesystem.

> And you want this to be done without the mm core using
> page->index to identify what to unmap when the error happens?

Isn't that exactly what I just said? We get the page address that
failed, the daxdev can turn that into a sector address and call into
the filesystem with a {sector, len, errno} tuple. We then do a
reverse mapping lookup on {sector, len} to find all the owners of
that range in the filesystem. If it's file data, that owner record
gives us the inode and the offset into the file, which then gives us
a {mapping, index} tuple.

Further, the filesytem reverse map is aware that it's blocks can be
shared by multiple owners, so it will have a record for every inode
and file offset that maps to that page. Hence we can simply iterate
the reverse map and do that whacky collect_procs/kill_procs dance
for every {mapping, index} pair that references the the bad range.

Nothing ever needs to be stored on the struct page...

> Memory
> error scanning is not universally available on all pmem
> implementations, so FS will need to subscribe for memory-error
> handling events.

No. Filesystems interact with the underlying device abstraction, not
the physical storage that lies behind that device abstraction.  The
filesystem should not interface with pmem directly in any way (all
direct accesses are hidden inside fs/dax.c!), nor should it care
about the quirks of the pmem implementation it is sitting on. That's
what the daxdev abstraction is supposed to hide from the users of
the pmem.

IOWs, the daxdev infrastructure subscribes to memory-error event
subsystem, calls out to the filesystem when an error in a page in
the daxdev is reported. The filesystem only needs to know the
{sector, len, errno} tuple related to the error; it is the device's
responsibility to handle the physical mechanics of listening,
filtering and translating MCEs to a format the filesystem
understands....

Another reason it should be provided by the daxdev as a {sector,
len, errno} tuple is that it also allows non-dax block devices to
implement the similar error notifications and provide filesystems
with exactly the same information so the filesystem can start
auto-recovery processes....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
