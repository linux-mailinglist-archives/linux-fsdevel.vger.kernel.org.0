Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E2B412A09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 02:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhIUAsD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 20:48:03 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:37262 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230220AbhIUAqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 20:46:02 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 349331009BF2;
        Tue, 21 Sep 2021 10:44:32 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mSTtf-00Eqls-33; Tue, 21 Sep 2021 10:44:31 +1000
Date:   Tue, 21 Sep 2021 10:44:31 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
Message-ID: <20210921004431.GO1756565@dread.disaster.area>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192866125.417973.7293598039998376121.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163192866125.417973.7293598039998376121.stgit@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=jBJWxBCxkUIqe1ibMVcA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 06:31:01PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a new mode to fallocate to zero-initialize all the storage backing a
> file.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/open.c                   |    5 +++++
>  include/linux/falloc.h      |    1 +
>  include/uapi/linux/falloc.h |    9 +++++++++
>  3 files changed, 15 insertions(+)
> 
> 
> diff --git a/fs/open.c b/fs/open.c
> index daa324606a41..230220b8f67a 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -256,6 +256,11 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	    (mode & ~FALLOC_FL_INSERT_RANGE))
>  		return -EINVAL;
>  
> +	/* Zeroinit should only be used by itself and keep size must be set. */
> +	if ((mode & FALLOC_FL_ZEROINIT_RANGE) &&
> +	    (mode != (FALLOC_FL_ZEROINIT_RANGE | FALLOC_FL_KEEP_SIZE)))
> +		return -EINVAL;
> +
>  	/* Unshare range should only be used with allocate mode. */
>  	if ((mode & FALLOC_FL_UNSHARE_RANGE) &&
>  	    (mode & ~(FALLOC_FL_UNSHARE_RANGE | FALLOC_FL_KEEP_SIZE)))
> diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> index f3f0b97b1675..4597b416667b 100644
> --- a/include/linux/falloc.h
> +++ b/include/linux/falloc.h
> @@ -29,6 +29,7 @@ struct space_resv {
>  					 FALLOC_FL_PUNCH_HOLE |		\
>  					 FALLOC_FL_COLLAPSE_RANGE |	\
>  					 FALLOC_FL_ZERO_RANGE |		\
> +					 FALLOC_FL_ZEROINIT_RANGE |	\
>  					 FALLOC_FL_INSERT_RANGE |	\
>  					 FALLOC_FL_UNSHARE_RANGE)
>  
> diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> index 51398fa57f6c..8144403b6102 100644
> --- a/include/uapi/linux/falloc.h
> +++ b/include/uapi/linux/falloc.h
> @@ -77,4 +77,13 @@
>   */
>  #define FALLOC_FL_UNSHARE_RANGE		0x40
>  
> +/*
> + * FALLOC_FL_ZEROINIT_RANGE is used to reinitialize storage backing a file by
> + * writing zeros to it.  Subsequent read and writes should not fail due to any
> + * previous media errors.  Blocks must be not be shared or require copy on
> + * write.  Holes and unwritten extents are left untouched.  This mode must be
> + * used with FALLOC_FL_KEEP_SIZE.
> + */
> +#define FALLOC_FL_ZEROINIT_RANGE	0x80

Hmmmm.

I think this wants to be a behavioural modifier for existing
operations rather than an operation unto itself. i.e. similar to how
KEEP_SIZE modifies ALLOC behaviour but doesn't fundamentally alter
the guarantees ALLOC provides userspace.

In this case, the change of behaviour over ZERO_RANGE is that we
want physical zeros to be written instead of the filesystem
optimising away the physical zeros by manipulating the layout
of the file.

There's been requests in the past for a way to make ALLOC also
behave like this - in the case that users want fully allocated space
to be preallocated so their applications don't take unwritten extent
conversion penalties on first writes. Databases are an example here,
where setup of a new WAL file isn't performance critical, but writes
to the WAL are and the WAL files are write-once. Hence they always
take unwritten conversion penalties and the only way around that is
to physically zero the files before use...

So it seems to me what we actually need here is a "write zeroes"
modifier to fallocate() operations to tell the filesystem that the
application really wants it to write zeroes over that range, not
just guarantee space has been physically allocated....

Then we have and API that looks like:

	ALLOC		- allocate space efficiently
	ALLOC | INIT	- allocate space by writing zeros to it
	ZERO		- zero data and preallocate space efficiently
	ZERO | INIT	- zero range by writing zeros to it

Which seems to cater for all the cases I know of where physically
writing zeros instead of allocating unwritten extents is the
preferred behaviour of fallocate()....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
