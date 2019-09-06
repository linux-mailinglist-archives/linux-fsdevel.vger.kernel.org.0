Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 854FBAC1D6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 23:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbfIFVHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 17:07:23 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:51580 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731772AbfIFVHX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 17:07:23 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C591D43F238;
        Sat,  7 Sep 2019 07:07:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i6LRt-0003t3-RC; Sat, 07 Sep 2019 07:07:17 +1000
Date:   Sat, 7 Sep 2019 07:07:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: add ioctl for directly writing compressed data
Message-ID: <20190906210717.GN7777@dread.disaster.area>
References: <cover.1567623877.git.osandov@fb.com>
 <8eae56abb90c0fe87c350322485ce8674e135074.1567623877.git.osandov@fb.com>
 <20190905021012.GL7777@dread.disaster.area>
 <20190906181949.GG7452@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906181949.GG7452@vader>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=FOH2dFAWAAAA:8 a=7-415B0cAAAA:8 a=-T9zkcI7Zi95uE-noD8A:9
        a=CjuIK1q_8ugA:10 a=i3VuKzQdj-NEYjvDI-p3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 11:19:49AM -0700, Omar Sandoval wrote:
> On Thu, Sep 05, 2019 at 12:10:12PM +1000, Dave Chinner wrote:
> > On Wed, Sep 04, 2019 at 12:13:26PM -0700, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > This adds an API for writing compressed data directly to the filesystem.
> > > The use case that I have in mind is send/receive: currently, when
> > > sending data from one compressed filesystem to another, the sending side
> > > decompresses the data and the receiving side recompresses it before
> > > writing it out. This is wasteful and can be avoided if we can just send
> > > and write compressed extents. The send part will be implemented in a
> > > separate series, as this ioctl can stand alone.
> > > 
> > > The interface is essentially pwrite(2) with some extra information:
> > > 
> > > - The input buffer contains the compressed data.
> > > - Both the compressed and decompressed sizes of the data are given.
> > > - The compression type (zlib, lzo, or zstd) is given.
> 
> Hi, Dave,
> 
> > So why can't you do this with pwritev2()? Heaps of flags, and
> > use a second iovec to hold the decompressed size of the previous
> > iovec. i.e.
> > 
> > 	iov[0].iov_base = compressed_data;
> > 	iov[0].iov_len = compressed_size;
> > 	iov[1].iov_base = NULL;
> > 	iov[1].iov_len = uncompressed_size;
> > 	pwritev2(fd, iov, 2, offset, RWF_COMPRESSED_ZLIB);
> > 
> > And you don't need to reinvent pwritev() with some whacky ioctl that
> > is bound to be completely screwed up is ways not noticed until
> > someone else tries to use it...
> 
> This is a good suggestion, thanks. I hadn't considered (ab?)using iovecs
> in this way.

Yeah, it is a bit of API abuse to pass per-iovec context in the next
iovec, but ISTR it being proposed in past times for other
mechanisms. I think it's far better than a whole new filesystem
private ioctl interface and structure to do what is effectively
direct IO...

> One modification I'd make would be to put the encoding into the second
> iovec and use a single RWF_ENCODED flag so that we don't have to keep
> stealing from RWF_* every time we add a new compression
> algorithm/encryption type/whatever:
> 
>  	iov[0].iov_base = compressed_data;
>  	iov[0].iov_len = compressed_size;
>  	iov[1].iov_base = (void *)IOV_ENCODING_ZLIB;
>  	iov[1].iov_len = uncompressed_size;
>  	pwritev2(fd, iov, 2, offset, RWF_ENCODED);
> 
> Making every other iovec a metadata iovec in this way would be a major
> pain to plumb through the iov_iter and VFS code, though. Instead, we
> could put the metadata in iov[0] and the encoded data in iov[1..iovcnt -
> 1]:
> 
> 	iov[0].iov_base = (void *)IOV_ENCODING_ZLIB;
> 	iov[0].iov_len = unencoded_len;
> 	iov[1].iov_base = encoded_data1;
> 	iov[1].iov_len = encoded_size1;
> 	iov[2].iov_base = encoded_data2;
> 	iov[2].iov_len = encoded_size2;
>  	pwritev2(fd, iov, 3, offset, RWF_ENCODED);
> 
> In my opinion, these are both reasonable interfaces. The former allows
> the user to write multiple encoded "extents" at once, while the latter
> allows writing a single encoded extent from scattered buffers. The
> latter is much simpler to implement ;) Thoughts?

Both reasonable, and I have no real concern about how it is done as
long as the format is well documented and works for both read and
write.

The only other thing I think we need to be careful of is that
interface works with AIO (via the RWF flag) and the new uioring async
interface  - I think thw RWF flag is all that is needed there). I
think that's another good reason for taking the preadv2/pwritev2
path, as that should all largely just work with the right iocb
frobbing in the syscall context...

> > > The implementation is similar to direct I/O: we have to flush any
> > > ordered extents, invalidate the page cache, and do the io
> > > tree/delalloc/extent map/ordered extent dance.
> > 
> > Which, to me, says that this should be a small bit of extra code
> > in the direct IO path that skips the compression/decompression code
> > and sets a few extra flags in the iocb that is passed down to the
> > direct IO code.
> > 
> > We don't need a whole new IO path just to skip a data transformation
> > step in the direct IO path....
> 
> Eh, at least for Btrfs, it's much hairier to retrofit this onto the mess
> of callbacks that is __blockdev_direct_IO() than it is to have a
> separate path. But that doesn't affect the interface, and other
> filesystems may be able to share more code with the direct IO path.

Ah, yeah, btrfs still uses that old mess. It should be much easier
when btrfs is converted to use the iomap DIO path - all the internal
compressed extent setup work for btrfs will likely be in the
->iomap_begin callout and then the rest of the DIO code treats it
like a normal data extent to do the IO...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
