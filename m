Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 149A180F98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 02:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfHEAXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Aug 2019 20:23:34 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:59430 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbfHEAXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Aug 2019 20:23:34 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CA7A943C668;
        Mon,  5 Aug 2019 10:23:30 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1huQWU-0004yD-Oe; Mon, 05 Aug 2019 10:06:46 +1000
Date:   Mon, 5 Aug 2019 10:06:46 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, darrick.wong@oracle.com, ruansy.fnst@cn.fujitsu.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 01/13] iomap: Use a IOMAP_COW/srcmap for a
 read-modify-write I/O
Message-ID: <20190805000646.GE7689@dread.disaster.area>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802220048.16142-2-rgoldwyn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=iox4zFpeAAAA:8 a=7-415B0cAAAA:8 a=SFhizr9xAZVoVlNa-MkA:9
        a=7pQHo9rnygU7WqxJ:21 a=V4KWhuw05m0eOdV2:21 a=CjuIK1q_8ugA:10
        a=WzC6qhA0u3u7Ye7llzcV:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 05:00:36PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Introduces a new type IOMAP_COW, which means the data at offset
> must be read from a srcmap and copied before performing the
> write on the offset.
> 
> The srcmap is used to identify where the read is to be performed
> from. This is passed to iomap->begin() of the respective
> filesystem, which is supposed to put in the details for
> reading before performing the copy for CoW.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/dax.c               |  8 +++++---
>  fs/ext2/inode.c        |  2 +-
>  fs/ext4/inode.c        |  2 +-
>  fs/gfs2/bmap.c         |  3 ++-
>  fs/iomap/apply.c       |  5 +++--
>  fs/iomap/buffered-io.c | 14 +++++++-------
>  fs/iomap/direct-io.c   |  2 +-
>  fs/iomap/fiemap.c      |  4 ++--
>  fs/iomap/seek.c        |  4 ++--
>  fs/iomap/swapfile.c    |  3 ++-
>  fs/xfs/xfs_iomap.c     |  9 ++++++---
>  include/linux/iomap.h  |  6 ++++--
>  12 files changed, 36 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index a237141d8787..b21d9a9cde2b 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1090,7 +1090,7 @@ EXPORT_SYMBOL_GPL(__dax_zero_page_range);
>  
>  static loff_t
>  dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> -		struct iomap *iomap)
> +		struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct block_device *bdev = iomap->bdev;
>  	struct dax_device *dax_dev = iomap->dax_dev;
> @@ -1248,6 +1248,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	unsigned long vaddr = vmf->address;
>  	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
>  	struct iomap iomap = { 0 };
> +	struct iomap srcmap = { 0 };

I'm not found of defining multiple iomaps everywhere and passing
them explicitly to every function that might need them.  Perhaps
something like:

	DEFINE_IOMAP(iomap);

#define IOMAP_BASE_MAP		0
#define IOMAP_SOURCE_MAP	1
#define IOMAP_MAX_MAPS		2

#define DEFINE_IOMAP(name)	\
	(struct iomap #name[IOMAP_MAX_MAPS] = {{0}})

#define IOMAP_B(name)		((name)[IOMAP_BASE_MAP])
#define IOMAP_S(name)		((name)[IOMAP_SOURCE_MAP])

And now we only have to pass a single iomap parameter to each
function as "struct iomap **iomap". This makes the code somewhat
simpler, and we only ever need to use IOMAP_S(iomap) when
IOMAP_B(iomap)->type == IOMAP_COW.

The other advantage of this is that if we even need new
functionality that requires 2 (or more) iomaps, we don't have to
change APIs again....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
