Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58432EE99B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 00:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbhAGXJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 18:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbhAGXJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:09:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153CDC0612F5
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 15:08:44 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id iq13so2604066pjb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jan 2021 15:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3iyas93Xd3n71dYLej+fNpSNMU2nnrmKXbg8DDh2m6I=;
        b=MuqTzTgO8erYRwjZdS8746g8JXjtOqAXaegqafRnww/2qDkdrh5R6PdFhNwMWvrcEV
         IFBCbTe8sWpUsWoc109YTf95HgR92mg8ajHAChZ0ZyTy66KRFrpQc+gALbQ5ZOvH3LFx
         ZWhGrhw2eZyuFi3Jq/MYGejc+KWaHIXYXLTVCC1+pa0pdAc/B+k3j506PN1zvjxUQwMe
         zMt9wBoV+dsMcUjvtMa5DUpF8Jpdv3L+sScJKnY0vbf9DT32d9hFcdUo+TMeu5Xc/7FD
         rCE3VmrTFhCZg+pRWfXztHpYviu0XfD37WGVNjOh57m6CO+5JPNO/ZWANmrI3gJT7qlC
         /Zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3iyas93Xd3n71dYLej+fNpSNMU2nnrmKXbg8DDh2m6I=;
        b=X+zWu8+iGAtXq40DYOuWycNM/QKlBawyZU9P5liKSTZi5jjoi4XZOI1B4UGNLe3GIH
         6NIl3twuTyj1vCVrfqr+DHZpteNpQxw6b+h/cU3+Z/8tEbWbjZJLNGpF6L1L16in1Kaa
         dK2tDW6P39Ztro/wVtqOTEi6ZziDx6+nKTQal8QryioUCmfEk/CL6VGYT+UAv+WgiPd/
         go+9+SqhGICbVYcF5DyvubxSmIZjYXsVYG+//su4l7LPdS8u03hUmd0BeuJVl41mZ5WQ
         qA8okL/A7jZZ6rp5dC8koIsggW88r6lMsBa3B7yj6J+e0/9jYM5E3jOyCGmmTeHpdfvq
         aZ1Q==
X-Gm-Message-State: AOAM53382DATEjieJo7lWyx9E/Q5gN07n+Y8aWv+6LT92Ix75qXRTNRs
        Dh1oZFqSX8UZfMjET0OCyuonJF2tl51/ZQ==
X-Google-Smtp-Source: ABdhPJxLf0Zskg8/tIDC+zofRN5Y5UXl0HGvKfDv7mJbtuMomwEGSZE/BJd2ls8u/kCopsLKxCmaWg==
X-Received: by 2002:a17:902:67:b029:dc:3cdb:6e50 with SMTP id 94-20020a1709020067b02900dc3cdb6e50mr1028679pla.61.1610060924147;
        Thu, 07 Jan 2021 15:08:44 -0800 (PST)
Received: from google.com (139.60.82.34.bc.googleusercontent.com. [34.82.60.139])
        by smtp.gmail.com with ESMTPSA id y5sm7176228pfp.45.2021.01.07.15.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 15:08:43 -0800 (PST)
Date:   Thu, 7 Jan 2021 23:08:39 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fs: Fix freeze_bdev()/thaw_bdev() accounting of
 bd_fsfreeze_sb
Message-ID: <X/eUd4iLxnl2nYRF@google.com>
References: <20201224044954.1349459-1-satyat@google.com>
 <20210107162000.GA2693@lst.de>
 <1137375419.42956970.1610036857271.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137375419.42956970.1610036857271.JavaMail.zimbra@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 11:27:37AM -0500, Bob Peterson wrote:
> ----- Original Message -----
> > Can someone pick this up?  Maybe through Jens' block tree as that is
> > where my commit this is fixing up came from.
> Christoph and Al,
> 
> Here is my version:
> 
> Bob Peterson
> 
> fs: fix freeze count problem in freeze_bdev
> 
> Before this patch, if you tried to freeze a device (function freeze_bdev)
> while it was being unmounted, it would get NULL back from get_active_super
> and correctly bypass the freeze calls. Unfortunately, it forgot to decrement
> its bd_fsfreeze_count. Subsequent calls to device thaw (thaw_bdev) would
> see the non-zero bd_fsfreeze_count and assume the bd_fsfreeze_sb value was
> still valid. That's not a safe assumption and resulted in use-after-free,
> which often caused fatal kernel errors like: "unable to handle page fault
> for address."
> 
> This patch adds the necessary decrement of bd_fsfreeze_count for that
> error path. It also adds code to set the bd_fsfreeze_sb to NULL when the
> last reference is reached in thaw_bdev.
> 
> Reviewed-by: Bob Peterson <rpeterso@redhat.com>
> ---
>  fs/block_dev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 9e56ee1f2652..c6daf7d12546 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -555,8 +555,10 @@ int freeze_bdev(struct block_device *bdev)
>  		goto done;
>  
>  	sb = get_active_super(bdev);
> -	if (!sb)
> +	if (!sb) {
> +		bdev->bd_fsfreeze_count--;
>  		goto sync;
> +	}
>  	if (sb->s_op->freeze_super)
>  		error = sb->s_op->freeze_super(sb);
>  	else
> @@ -600,6 +602,7 @@ int thaw_bdev(struct block_device *bdev)
>  	if (!sb)
>  		goto out;
>  
> +	bdev->bd_fsfreeze_sb = NULL;
This causes bdev->bd_fsfreeze_sb to be set to NULL even if the call to
thaw_super right after this line fail. So if a caller tries to call
thaw_bdev() again after receiving such an error, that next call won't even
try to call thaw_super(). Is that what we want here?  (I don't know much
about this code, but from a cursory glance I think this difference is
visible to emergency_thaw_bdev() in fs/buffer.c)

In my version of the patch, I set bdev->bd_fsfreeze_sb to NULL only
*after* we check that the call to thaw_super() succeeded to avoid this.
>  	if (sb->s_op->thaw_super)
>  		error = sb->s_op->thaw_super(sb);
>  	else
>
In another mail, you mentioned
> I wrote this patch to fix the freeze/thaw device problem before I saw
> the patch "fs: Fix freeze_bdev()/thaw_bdev() accounting of bd_fsfreeze_sb"
> from Satya Tangirala. That one, however, does not fix the bd_freeze_count
> problem and this patch does.
Thanks a lot for investigating the bug and the patch I sent :)
Was there actually an issue with that patch I sent? As you said, the bug
is very reproduceable on master with generic/085. But with my patch, I
don't see any issues even after having run the test many, many times
(admittedly, I tested it on f2fs and ext4 rather than gfs2, but I don't
think that should cause much differences). Did you have a test case that
actually causes a failure with my patch?

The only two differences between the patch I sent and this patch are

1) The point at which the bd_fsfreeze_bd is set to NULL in thaw_bdev(), as
I mentioned above already.

2) Whether or not to decrement bd_fsfreeze_count when we get a NULL from
get_active_super() in freeze_bdev() - I don't do this in my patch.

I think setting bd_fsfreeze_sb to NULL in thaw_bdev (in either the place
your patch does it or my patch does it) is enough to fix the bug w.r.t the
use-after-free. Fwiw, I do think it should be set to NULL after we check for
all the errors though.

I think the second difference (decrementing bd_fsfreeze_count when
get_active_super() returns NULL) doesn't change anything w.r.t the
use-after-free. It does however, change the behaviour of the function
slightly, and it might be caller visible (because from a cursory glance, it
looks like we're reading the bd_fsfreeze_count from some other places like
fs/super.c). Even before 040f04bd2e82, the code wouldn't decrement
bd_fsfreeze_count when get_active_super() returned NULL - so is this change
in behaviour intentional? And if so, maybe it should go in a separate
patch?
