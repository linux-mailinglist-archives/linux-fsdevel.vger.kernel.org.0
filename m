Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08882D6ACA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 23:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405156AbgLJWa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 17:30:27 -0500
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:53836 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405153AbgLJWaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 17:30:19 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id DA06A101B8C;
        Fri, 11 Dec 2020 09:29:35 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1knURK-002dN6-Oc; Fri, 11 Dec 2020 09:29:34 +1100
Date:   Fri, 11 Dec 2020 09:29:34 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 2/2] fs: expose LOOKUP_NONBLOCK through openat2()
 RESOLVE_NONBLOCK
Message-ID: <20201210222934.GI4170059@dread.disaster.area>
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210200114.525026-3-axboe@kernel.dk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=drOt6m5kAAAA:8 a=7-415B0cAAAA:8
        a=uvNq2T7deLPmxCVeDx4A:9 a=CjuIK1q_8ugA:10 a=RMMjzBEyIzXRtoq5n5K6:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 01:01:14PM -0700, Jens Axboe wrote:
> Now that we support non-blocking path resolution internally, expose it
> via openat2() in the struct open_how ->resolve flags. This allows
> applications using openat2() to limit path resolution to the extent that
> it is already cached.
> 
> If the lookup cannot be satisfied in a non-blocking manner, openat2(2)
> will return -1/-EAGAIN.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/open.c                    | 2 ++
>  include/linux/fcntl.h        | 2 +-
>  include/uapi/linux/openat2.h | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 9af548fb841b..07dc9f3d1628 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1087,6 +1087,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>  		lookup_flags |= LOOKUP_BENEATH;
>  	if (how->resolve & RESOLVE_IN_ROOT)
>  		lookup_flags |= LOOKUP_IN_ROOT;
> +	if (how->resolve & RESOLVE_NONBLOCK)
> +		lookup_flags |= LOOKUP_NONBLOCK;
>  
>  	op->lookup_flags = lookup_flags;
>  	return 0;
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index 921e750843e6..919a13c9317c 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -19,7 +19,7 @@
>  /* List of all valid flags for the how->resolve argument: */
>  #define VALID_RESOLVE_FLAGS \
>  	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
> -	 RESOLVE_BENEATH | RESOLVE_IN_ROOT)
> +	 RESOLVE_BENEATH | RESOLVE_IN_ROOT | RESOLVE_NONBLOCK)
>  
>  /* List of all open_how "versions". */
>  #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
> diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
> index 58b1eb711360..ddbf0796841a 100644
> --- a/include/uapi/linux/openat2.h
> +++ b/include/uapi/linux/openat2.h
> @@ -35,5 +35,7 @@ struct open_how {
>  #define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
>  					be scoped inside the dirfd
>  					(similar to chroot(2)). */
> +#define RESOLVE_NONBLOCK	0x20 /* Only complete if resolution can be
> +					done without IO */

I don't think this describes the implementation correctly - it has
nothing to actually do with whether IO is needed, just whether the
lookup can be done without taking blocking locks. The slow path can
complete without doing IO - it might miss the dentry cache but hit
the filesystem buffer cache on lookup and the inode cache when
retrieving the inode. And it may not even block anywhere doing this.

So, really, this isn't avoiding IO at all - it's avoiding the
possibility of running a lookup path that might blocking on
something.

This also needs a openat2(2) man page update explaining exactly what
behaviour/semantics this flag provides and that userspace can rely
on when this flag is set...

We've been failing to define the behaviour of our interfaces clearly,
especially around non-blocking IO behaviour in recent times. We need
to fix that, not make matters worse by adding new, poorly defined
non-blocking behaviours...

I'd also like to know how we actually test this is working- a
reliable regression test for fstests would be very useful for
ensuring that the behaviour as defined by the man page is not broken
accidentally by future changes...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
