Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C0170E90F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 00:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjEWW1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 18:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjEWW1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 18:27:19 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3425783
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 15:27:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d57cd373fso40595b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684880837; x=1687472837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+Mu9QUDJUPxCQ+nxaGfODHItInO1Mx21+1cY8P0+ko=;
        b=myd4lDfvuaaTHVDxIZueGM+k5E70olrh5Bi4kawJ2EqxlzdG3jx2hNsJKzBv1ExQrZ
         aZIqungadEPCy/hk+arz6SCHAhumLQ2exHtv9ezxiuWyl92MWzYKy8HK8quRSz97EAMo
         8HDOmtAd6fKra/CsSjrI/dK+pfZCIsI+1uCq1qHYsi0xHo3WYArXZwYWudExTIr6Fj27
         3dDJ033Vg+M4TLAaJI5DgBCEbpaEmjNrP7x2LDAEYwxTkMPe/qI246iat844prVielH/
         N1rZ8XOfFOa41MmZaZKsz9PVPHf7hGTl1NypGa83NrTRXoIwS26AGhLJnHwQKKez3ITY
         DvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684880837; x=1687472837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+Mu9QUDJUPxCQ+nxaGfODHItInO1Mx21+1cY8P0+ko=;
        b=a0llcwUnsWY3zs6GiRkOXCzJbk8h1BO3LhUI+2der4VzaekPcRPhiDzBA6q/4ve/r3
         WJ0L6cAPJbYsPvz+ofH7hEBG25VPTKL8es1WtoQZe0Kwg2L7p0TK3QRTgm1jxtSvpxBh
         y9mj118WfRYfIzcEE48AuAPVJnEgVevaWJpJ+ylGOiCgLH3p+s4LAahVJZHUozIm7s9Y
         FTFgqo0ODkVfbkhMs0KdX15t4NfC6GF0FKriJSVJqD18SEydWZxWOuEc1LiJOQCEkb3N
         8A8zuV7jiPvnHdhBpjk8Sy6qtBVs4NUjd915X4ROYvWNGEEJ1RCkC2A7ZFpUdIPX2Sjg
         A9Xg==
X-Gm-Message-State: AC+VfDzqj6gf0EkQzNa3/EcfsSQudsBeSIwqtJl4B2zn7Pq9no7PxX/Q
        TfHJVbe0hbxerPF8rHOCBx7mlA==
X-Google-Smtp-Source: ACHHUZ5+wDLkzWl5hqADeJv/K/pEdU5ftVoYvaXjN5yUsSSnEKzwjNvqAoa0WrZdkbq9aiPARCtcUw==
X-Received: by 2002:a05:6a20:3c8d:b0:10c:d5dd:c223 with SMTP id b13-20020a056a203c8d00b0010cd5ddc223mr1532145pzj.15.1684880837655;
        Tue, 23 May 2023 15:27:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id d11-20020a63fd0b000000b005308b255502sm6443395pgh.68.2023.05.23.15.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 15:27:16 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q1aTJ-0036Bu-2Z;
        Wed, 24 May 2023 08:27:13 +1000
Date:   Wed, 24 May 2023 08:27:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/17] block: use iomap for writes to block devices
Message-ID: <ZG09wR4WOI8zDxJK@dread.disaster.area>
References: <20230424054926.26927-1-hch@lst.de>
 <20230424054926.26927-17-hch@lst.de>
 <b96b397e-2f5e-7910-3bb3-7405d0e293a7@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b96b397e-2f5e-7910-3bb3-7405d0e293a7@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 04:22:01PM +0200, Hannes Reinecke wrote:
> On 4/24/23 07:49, Christoph Hellwig wrote:
> > Use iomap in buffer_head compat mode to write to block devices.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   block/Kconfig |  1 +
> >   block/fops.c  | 33 +++++++++++++++++++++++++++++----
> >   2 files changed, 30 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/Kconfig b/block/Kconfig
> > index 941b2dca70db73..672b08f0096ab4 100644
> > --- a/block/Kconfig
> > +++ b/block/Kconfig
> > @@ -5,6 +5,7 @@
> >   menuconfig BLOCK
> >          bool "Enable the block layer" if EXPERT
> >          default y
> > +       select IOMAP
> >          select SBITMAP
> >          help
> >   	 Provide block layer support for the kernel.
> > diff --git a/block/fops.c b/block/fops.c
> > index 318247832a7bcf..7910636f8df33b 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -15,6 +15,7 @@
> >   #include <linux/falloc.h>
> >   #include <linux/suspend.h>
> >   #include <linux/fs.h>
> > +#include <linux/iomap.h>
> >   #include <linux/module.h>
> >   #include "blk.h"
> > @@ -386,6 +387,27 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> >   	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
> >   }
> > +static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > +		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> > +{
> > +	struct block_device *bdev = I_BDEV(inode);
> > +	loff_t isize = i_size_read(inode);
> > +
> > +	iomap->bdev = bdev;
> > +	iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
> > +	if (WARN_ON_ONCE(iomap->offset >= isize))
> > +		return -EIO;
> 
> I'm hitting this during booting:
> [    5.016324]  <TASK>
> [    5.030256]  iomap_iter+0x11a/0x350
> [    5.030264]  iomap_readahead+0x1eb/0x2c0
> [    5.030272]  read_pages+0x5d/0x220
> [    5.030279]  page_cache_ra_unbounded+0x131/0x180
> [    5.030284]  filemap_get_pages+0xff/0x5a0

Why is filemap_get_pages() using unbounded readahead? Surely
readahead should be limited to reading within EOF....

> [    5.030292]  filemap_read+0xca/0x320
> [    5.030296]  ? aa_file_perm+0x126/0x500
> [    5.040216]  ? touch_atime+0xc8/0x150
> [    5.040224]  blkdev_read_iter+0xb0/0x150
> [    5.040228]  vfs_read+0x226/0x2d0
> [    5.040234]  ksys_read+0xa5/0xe0
> [    5.040238]  do_syscall_64+0x5b/0x80
> 
> Maybe we should consider this patch:
> 
> diff --git a/block/fops.c b/block/fops.c
> index 524b8a828aad..d202fb663f25 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -386,10 +386,13 @@ static int blkdev_iomap_begin(struct inode *inode,
> loff_t offset, loff_t length,
> 
>         iomap->bdev = bdev;
>         iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
> -       if (WARN_ON_ONCE(iomap->offset >= isize))
> -               return -EIO;
> -       iomap->type = IOMAP_MAPPED;
> -       iomap->addr = iomap->offset;
> +       if (WARN_ON_ONCE(iomap->offset >= isize)) {
> +               iomap->type = IOMAP_HOLE;
> +               iomap->addr = IOMAP_NULL_ADDR;
> +       } else {
> +               iomap->type = IOMAP_MAPPED;
> +               iomap->addr = iomap->offset;
> +       }

I think Christoph's code is correct. IMO, any attempt to read beyond
the end of the device should throw out a warning and return an
error, not silently return zeros.

If readahead is trying to read beyond the end of the device, then it
really seems to me like the problem here is readahead, not the iomap
code detecting the OOB read request....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
