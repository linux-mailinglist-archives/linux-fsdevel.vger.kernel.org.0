Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2E6FD395
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 03:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjEJBiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 21:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjEJBiW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 21:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568CE2D5E;
        Tue,  9 May 2023 18:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E7F62DA7;
        Wed, 10 May 2023 01:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD98C433EF;
        Wed, 10 May 2023 01:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683682700;
        bh=8UGdS9GL0vGvJYHAS2fLEU9Z1+ii3pmqIijLsCfi86M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RFZVHM0j4liS/3aNZ826JrNLwC5otm2Q3bKJDr2dByo7MgFfLx8uQx6dpmF7IlLh+
         e/PhZ07UfRvl5v91w4GBwg/Sa8napD58+7USm34O40MTjmAv9SM7ksrym/amhpDlIm
         KaqvHGbSSQdDLLyTatrz/0jw82WwfmS6yIy9bFliri6+tE6Eq5v/sJk/OlDWeICrAK
         IbkOikf9AsftiTKYmSKdL27sm/d8kDwxI7t6PyslE7OwDvdY+cT1jsGosnNSS+hPgd
         sl4MlNwIIKZ/VeDTsEtQA0vnlgTIM6nrTuFCU1tbhBGLTnHK1b19ptHAMLFh4W3hOg
         MDBZgVRpsfKwg==
Date:   Tue, 9 May 2023 18:38:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <20230510013819.GC858799@frogsfrogsfrogs>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-6-hch@lst.de>
 <20230505185119.GI15394@frogsfrogsfrogs>
 <20230509133501.GD841@lst.de>
 <20230509221958.GV3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509221958.GV3223426@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 10, 2023 at 08:19:58AM +1000, Dave Chinner wrote:
> On Tue, May 09, 2023 at 03:35:01PM +0200, Christoph Hellwig wrote:
> > On Fri, May 05, 2023 at 11:51:19AM -0700, Darrick J. Wong wrote:
> > > Fun question: What happens when the swap disk falls off the bus?
> > 
> > Your system is toast.
> > 
> > > > -	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode | FMODE_EXCL, &bdev)))
> > > > +	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode | FMODE_EXCL, &bdev,
> > > > +			NULL)))
> > > >  		return -EBUSY;
> > > >  	ret = set_blocksize(bdev, n);
> > > >  	blkdev_put(bdev, mode | FMODE_EXCL);
> > > 
> > > Somewhat related question: Should we allow userspace to initiate a fs
> > > shutdown through the block device?  Let's say you're preparing to yank
> > > /dev/sda and want to kill anything attached to it or its partitions?
> > > Without having to walk through however many mount namespaces there are
> > > to find the mountpoints?
> > 
> > That's kinda what we're doing here.  Or do you mean even more advanced
> > notice by having another callout before stopping I/O so that we could
> > write out all log buffers?  It's probably doable, but I'm not convinced
> > that this use case is worth maintaining and testing the kernel code for
> > it.
> 
> The userspace shutdown code already does this by default - it
> actually calls freeze_bdev() to cause the filesystem to be made
> consistent on the block device before it executes the shutdown.
> So, in effect, we already have the "shutdown before turning off
> block device" paths in the filesystems and extremely well tested.
> 
> Indeed, if the device is being removed, why not call freeze_bdev()
> before doing anything else? It guarantees that applications will be
> quiesced and the filesystem will stabilise and not try to change
> anything until the shutdown occurs when the device is pulled...

I think I want everything -- I want freeze_bdev on a device /before/ we
pull it out so that we can try to flush dirty everything to the disk; I
want that to work for the log/rt devices; and I want a final shutdown
notification when the kernel drops the bdev so that we can offline the
fs and shortcut/start returning EIO.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
