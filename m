Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3F0713095
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 May 2023 01:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242720AbjEZXqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 19:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242143AbjEZXqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 19:46:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306FB189
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 16:45:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d2ca9ef0cso1092760b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 16:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685144706; x=1687736706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWzxmQ8QxCg8O8dff9yLq2U6+xkvzRDR890XcXfK3mg=;
        b=qNuMbPXmTsHLzrS9s68EhswAAzoxtilaQGWKnCRgcVZwgN8OI10caCromsS5yYFv2R
         H+874/2Gj6go+XQifmTf5kewkn7i7zvKifQzI3km3f265IqOyDa5gd9FHfoFuAjSyJKf
         yp3Cu3MsWTcnXTi9viqZ4k5krjQN5vXKA82k2fOXEqn8d2vffoDkxV23GTnBw+SHldDg
         BKOE/PD8nm9+R387W92lR63+tYy0KUg7uB0gL32cR+2Vdg9xe1KAHkV5Hxgrp36Ol5Dq
         mPB6awaqPs/XRgHujtk3dzFuZEXXJDEl3MYeGn/kMUMu3PuoffhICO1ogYG8CxUAsQyb
         9Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685144706; x=1687736706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWzxmQ8QxCg8O8dff9yLq2U6+xkvzRDR890XcXfK3mg=;
        b=FNXbjWN1lZFQI9d9Ly/FJ57yLqy423rwlohbAVzV/7d8fbH8vz5n85llFI2VJlpP1W
         dox67HyUP8Jlfhj3Hy3j6VwsAYLnu0MUKD0W1Jnp5aXDoEV7FS9lto4HHlA+CgtKWmw5
         3ivy0L4K6/bl0JoHp7xi4k+pO3GlKXUy4RhL/KXyBzPf9GcH7NYsGod31SQpc4qlRLKI
         V+14PSJJkmS4FYTxwBPDr+IsQHUcct8mrot5XBfL2fmKpeTzS7QVZcbIL4LTHXO0N2Ak
         1xsBrpnq3PV274asXDC0SxTruOt+8h+BgI8N7P4OLDeBtCBuAflHzOQUld4GRP17Cdp1
         AUVw==
X-Gm-Message-State: AC+VfDwlMu4FOk/+N1nt7rpWLm1IJNfxdo6KHBxzZz/CXA7qfBsgwWB2
        QTNXcTlfa9KXzVK43OnnGpWr1Q==
X-Google-Smtp-Source: ACHHUZ4K3iebgteK6vCXrRpRxz8VUX6r/9jfq7BcWqxhVfO6CgyxLnisMFr2+io1W37C8mIwj9ZXTw==
X-Received: by 2002:a05:6a00:2d88:b0:64c:ecf7:f49a with SMTP id fb8-20020a056a002d8800b0064cecf7f49amr5438139pfb.21.1685144706285;
        Fri, 26 May 2023 16:45:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id l11-20020a62be0b000000b0064f46570bb7sm3100448pff.167.2023.05.26.16.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 16:45:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q2h7G-004Jsa-2r;
        Sat, 27 May 2023 09:45:02 +1000
Date:   Sat, 27 May 2023 09:45:02 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Joe Thornber <thornber@redhat.com>
Cc:     Brian Foster <bfoster@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        dm-devel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Joe Thornber <ejt@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZHFEfngPyUOqlthr@dread.disaster.area>
References: <ZGb2Xi6O3i2pLam8@infradead.org>
 <ZGeKm+jcBxzkMXQs@redhat.com>
 <ZGgBQhsbU9b0RiT1@dread.disaster.area>
 <ZGu0LaQfREvOQO4h@redhat.com>
 <ZGzIJlCE2pcqQRFJ@bfoster>
 <ZGzbGg35SqMrWfpr@redhat.com>
 <ZG1dAtHmbQ53aOhA@dread.disaster.area>
 <ZG+KoxDMeyogq4J0@bfoster>
 <ZHB954zGG1ag0E/t@dread.disaster.area>
 <CAJ0trDbspRaDKzTzTjFdPHdB9n0Q9unfu1cEk8giTWoNu3jP8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ0trDbspRaDKzTzTjFdPHdB9n0Q9unfu1cEk8giTWoNu3jP8g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 12:04:02PM +0100, Joe Thornber wrote:
> Here's my take:
> 
> I don't see why the filesystem cares if thinp is doing a reservation or
> provisioning under the hood.  All that matters is that a future write
> to that region will be honoured (barring device failure etc.).
> 
> I agree that the reservation/force mapped status needs to be inherited
> by snapshots.
> 
> 
> One of the few strengths of thinp is the performance of taking a snapshot.
> Most snapshots created are never activated.  Many other snapshots are
> only alive for a brief period, and used read-only.  eg, blk-archive
> (https://github.com/jthornber/blk-archive) uses snapshots to do very
> fast incremental backups.  As such I'm strongly against any scheme that
> requires provisioning as part of the snapshot operation.
> 
> Hank and I are in the middle of the range tree work which requires a
> metadata
> change.  So now is a convenient time to piggyback other metadata changes to
> support reservations.
> 
> 
> Given the above this is what I suggest:
> 
> 1) We have an api (ioctl, bio flag, whatever) that lets you
> reserve/guarantee a region:
> 
>   int reserve_region(dev, sector_t begin, sector_t end);

A C-based interface is not sufficient because the layer that must do
provsioning is not guaranteed to be directly under the filesystem.
We must be able to propagate the request down to the layers that
need to provision storage, and that includes hardware devices.

e.g. dm-thin would have to issue REQ_PROVISION on the LBA ranges it
allocates in it's backing device to guarantee that the provisioned
LBA range it allocates is also fully provisioned by the storage
below it....

>   This api should be used minimally, eg, critical FS metadata only.

Keep in mind that "critical FS metadata" in this context is any
metadata which could cause the filesystem to hang or enter a global
error state if an unexpected ENOSPC error occurs during a metadata
write IO.

Which, in pretty much every journalling filesystem, equates to all
metadata in the filesystem. For a typical root filesystem, that
might be a in the range of a 1-200MB (depending on journal size).
For larger filesytems with lots of files in them, it will be in the
range of GBs of space.

Plan for having to support tens of GBs of provisioned space in
filesystems, not tens of MBs....

[snip]

> Now this is a lot of work.  As well as the kernel changes we'll need to
> update the userland tools: thin_check, thin_ls, thin_metadata_unpack,
> thin_rmap, thin_delta, thin_metadata_pack, thin_repair, thin_trim,
> thin_dump, thin_metadata_size, thin_restore.  Are we confident that we
> have buy in from the FS teams that this will be widely adopted?  Are users
> asking for this?  I really don't want to do 6 months of work for nothing.

I think there's a 2-3 solid days of coding to fully implement
REQ_PROVISION support in XFS, including userspace tool support.
Maybe a couple of weeks more to flush the bugs out before it's
largely ready to go.

So if there's buy in from the block layer and DM people for
REQ_PROVISION as described, then I'll definitely have XFS support
ready for you to test whenever dm-thinp is ready to go.

I can't speak for other filesystems, I suspect the only one we care
about is ext4.  btrfs and f2fs don't need dm-thinp and there aren't
any other filesystems that are used in production on top of
dm-thinp, so I think only XFS and ext4 matter at this point in time.

I suspect that ext4 would be fairly easy to add support for as well.
ext4 has a lot more fixed-place metadata than XFS has so much more
of it's metadata is covered by mkfs-time provisioning. Limiting
dynamic metadata to specific fully provisioned block groups and
provisioning new block groups for metadata when they are near full
would be equivalent to how I plan to provision metadata space in
XFS. Hence the implementation for ext4 looks to be broadly similar
in scope and complexity as XFS....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
