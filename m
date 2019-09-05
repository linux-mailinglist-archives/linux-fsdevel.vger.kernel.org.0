Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26AE6A983D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 04:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfIECKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 22:10:17 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:40588 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbfIECKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 22:10:17 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6FE0A361436;
        Thu,  5 Sep 2019 12:10:13 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i5hDw-0001DN-C6; Thu, 05 Sep 2019 12:10:12 +1000
Date:   Thu, 5 Sep 2019 12:10:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: add ioctl for directly writing compressed data
Message-ID: <20190905021012.GL7777@dread.disaster.area>
References: <cover.1567623877.git.osandov@fb.com>
 <8eae56abb90c0fe87c350322485ce8674e135074.1567623877.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eae56abb90c0fe87c350322485ce8674e135074.1567623877.git.osandov@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=FOH2dFAWAAAA:8 a=7-415B0cAAAA:8 a=GfyUhzXjdq-z9Q1-x_UA:9
        a=CjuIK1q_8ugA:10 a=i3VuKzQdj-NEYjvDI-p3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 04, 2019 at 12:13:26PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This adds an API for writing compressed data directly to the filesystem.
> The use case that I have in mind is send/receive: currently, when
> sending data from one compressed filesystem to another, the sending side
> decompresses the data and the receiving side recompresses it before
> writing it out. This is wasteful and can be avoided if we can just send
> and write compressed extents. The send part will be implemented in a
> separate series, as this ioctl can stand alone.
> 
> The interface is essentially pwrite(2) with some extra information:
> 
> - The input buffer contains the compressed data.
> - Both the compressed and decompressed sizes of the data are given.
> - The compression type (zlib, lzo, or zstd) is given.

So why can't you do this with pwritev2()? Heaps of flags, and
use a second iovec to hold the decompressed size of the previous
iovec. i.e.

	iov[0].iov_base = compressed_data;
	iov[0].iov_len = compressed_size;
	iov[1].iov_base = NULL;
	iov[1].iov_len = uncompressed_size;
	pwritev2(fd, iov, 2, offset, RWF_COMPRESSED_ZLIB);

And you don't need to reinvent pwritev() with some whacky ioctl that
is bound to be completely screwed up is ways not noticed until
someone else tries to use it...

I'd also suggest atht if we are going to be able to write compressed
data directly, then we should be able to read them as well directly
via preadv2()....

> The interface is general enough that it can be extended to encrypted or
> otherwise encoded extents in the future. A more detailed description,
> including restrictions and edge cases, is included in
> include/uapi/linux/btrfs.h.

No thanks, that bit us on the arse -hard- with the clone interfaces
we lifted to the VFS from btrfs. Let's do it through the existing IO
paths and write a bunch of fstests to exercise it and verify the
interface's utility and the filesystem implementation correctness
before anything is merged.

> The implementation is similar to direct I/O: we have to flush any
> ordered extents, invalidate the page cache, and do the io
> tree/delalloc/extent map/ordered extent dance.

Which, to me, says that this should be a small bit of extra code
in the direct IO path that skips the compression/decompression code
and sets a few extra flags in the iocb that is passed down to the
direct IO code.

We don't need a whole new IO path just to skip a data transformation
step in the direct IO path....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
