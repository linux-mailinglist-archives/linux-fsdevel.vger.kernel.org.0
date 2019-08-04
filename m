Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38D180F70
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 01:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfHDXoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Aug 2019 19:44:34 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:43937 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbfHDXoe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Aug 2019 19:44:34 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E99D57E6E18;
        Mon,  5 Aug 2019 09:44:29 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1huQ9p-0004nq-Po; Mon, 05 Aug 2019 09:43:21 +1000
Date:   Mon, 5 Aug 2019 09:43:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, darrick.wong@oracle.com, ruansy.fnst@cn.fujitsu.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190804234321.GC7689@dread.disaster.area>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-11-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802220048.16142-11-rgoldwyn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=iox4zFpeAAAA:8 a=7-415B0cAAAA:8 a=rPsGVnoBL0T1KS3q8WIA:9
        a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 05:00:45PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This helps filesystems to perform tasks on the bio while
> submitting for I/O. Since btrfs requires the position
> we are working on, pass pos to iomap_dio_submit_bio()
> 
> The correct place for submit_io() is not page_ops. Would it
> better to rename the structure to something like iomap_io_ops
> or put it directly under struct iomap?
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/iomap/direct-io.c  | 16 +++++++++++-----
>  include/linux/iomap.h |  1 +
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 5279029c7a3c..a802e66bf11f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -59,7 +59,7 @@ int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
>  EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
>  
>  static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
> -		struct bio *bio)
> +		struct bio *bio, loff_t pos)
>  {
>  	atomic_inc(&dio->ref);
>  
> @@ -67,7 +67,13 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
>  		bio_set_polled(bio, dio->iocb);
>  
>  	dio->submit.last_queue = bdev_get_queue(iomap->bdev);
> -	dio->submit.cookie = submit_bio(bio);
> +	if (iomap->page_ops && iomap->page_ops->submit_io) {
> +		iomap->page_ops->submit_io(bio, file_inode(dio->iocb->ki_filp),
> +				pos);
> +		dio->submit.cookie = BLK_QC_T_NONE;
> +	} else {
> +		dio->submit.cookie = submit_bio(bio);
> +	}

I don't really like this at all. Apart from the fact it doesn't work
with block device polling (RWF_HIPRI), the iomap architecture is
supposed to resolve the file offset -> block device + LBA mapping
completely up front and so all that remains to be done is build and
submit the bio(s) to the block device.

What I see here is a hack to work around the fact that btrfs has
implemented both file data transformations and device mapping layer
functionality as a filesystem layer between file data bio building
and device bio submission. And as the btrfs file data mapping
(->iomap_begin) is completely unaware that there is further block
mapping to be done before block device bio submission, any generic
code that btrfs uses requires special IO submission hooks rather
than just calling submit_bio().

I'm not 100% sure what the solution here is, but the one thing we
must resist is turning the iomap code into a mess of custom hooks
that only one filesystem uses. We've been taught this lesson time
and time again - the iomap infrastructure exists because stuff like
bufferheads and the old direct IO code ended up so full of special
case code that it ossified and became unmodifiable and
unmaintainable.

We do not want to go down that path again. 

IMO, the iomap IO model needs to be restructured to support post-IO
and pre-IO data verification/calculation/transformation operations
so all the work that needs to be done at the inode/offset context
level can be done in the iomap path before bio submission/after
bio completion. This will allow infrastructure like fscrypt, data
compression, data checksums, etc to be suported generically, not
just by individual filesystems that provide a ->submit_io hook.

As for the btrfs needing to slice and dice bios for multiple
devices?  That should be done via a block device ->make_request
function, not a custom hook in the iomap code.

That's why I don't like this hook - I think hiding data operations
and/or custom bio manipulations in opaque filesystem callouts is
completely the wrong approach to be taking. We need to do these
things in a generic manner so that all filesystems (and block
devices!) that use the iomap infrastructure can take advantage of
them, not just one of them.

Quite frankly, I don't care if it takes more time and work up front,
I'm tired of expedient hacks to merge code quickly repeatedly biting
us on the arse and wasting far more time sorting out than we would
have spent getting it right in the first place.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
