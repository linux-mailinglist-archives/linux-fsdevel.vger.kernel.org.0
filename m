Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3825C6FD290
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 00:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjEIWUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 18:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjEIWUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 18:20:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C9298
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 15:20:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaf706768cso49641985ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 May 2023 15:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683670802; x=1686262802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lpFfG6C/woeEh3xAVWVSW4QDIRY2LcuRr67NeZrYhZk=;
        b=x4wnhtf2e/5Ls0/pD9obIHjGGbGyC2TZ1yPp9j0M0gpWdvOKZY1vS0QUNfd3huTH3X
         D1WBE2UUfwRm6IRjV7rztd+1U8bjj+OJ6HetiHxsseo0wxuA7Mmu9FI4AuEL7mHRw0T7
         dYG/Ha1X6UyzBTojilPQeX5BBtQ/lwjbh952fhmGyoUxngQ/oumQjwc/7o4xGP/MmBf3
         6Vr7dzf4w5c34jwu0r1wN0a7NQ23j/p4A1KmmPehy4jqOvVU/3HATmsL8oo6QBnkazn6
         yRJtVSs+2vsQYPQs7TNtruZyFSrbUHe0bj8dK2YJlondW5w3OfJytTXrkk9VzdaUKLiq
         ltVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683670802; x=1686262802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpFfG6C/woeEh3xAVWVSW4QDIRY2LcuRr67NeZrYhZk=;
        b=bp3M8WAHc716vudsWrICPaeatEM84h4uTCrtvgQFINqNTo60ZHzwEauNP6brZ8Zrr7
         6+lF3kfHXhpGYF991UFjCsZ39dbq2zxOwf4RTZPnHWb2/6SsUca13Rkw9VsXeXiyIhYa
         GXyS9x8LHVnybOaOFR3GP3wJ/8FufecQfVFDSxYph2loNhaBw+MqpCLz8bvDZQDru8iJ
         etSFBO2Z7tyIGtIo/iIXfH46utEsYc0FNoRbUHRm6vkngM7kdhI7XVlAT/x66XtP08Xt
         aPbz0FqxoN0XOZPIznnVfqsbPUu2awVSWayGA0d+dI8BU/bbTuh2//PLB9VQLsvJlhnx
         bU+A==
X-Gm-Message-State: AC+VfDzQyH0xLyyzzM5VKSq5c5qVjova8L3Ms9ZYAFdE7ynhmG1pGWzc
        YwbcwEY1aStML+pXvI9rAOalOA==
X-Google-Smtp-Source: ACHHUZ45kM8YGiof/dP3yzhXFIIdPd9DEDG9hSY5vXQotAlNRS3qz0nIW+ex68IDbiRDaO4ei/A3bg==
X-Received: by 2002:a17:902:d504:b0:1a9:98ae:5970 with SMTP id b4-20020a170902d50400b001a998ae5970mr20929374plg.23.1683670802017;
        Tue, 09 May 2023 15:20:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id r9-20020a17090a690900b0024e06a71ef5sm12045144pjj.56.2023.05.09.15.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 15:20:01 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pwVgc-00DNjc-Ew; Wed, 10 May 2023 08:19:58 +1000
Date:   Wed, 10 May 2023 08:19:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <20230509221958.GV3223426@dread.disaster.area>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-6-hch@lst.de>
 <20230505185119.GI15394@frogsfrogsfrogs>
 <20230509133501.GD841@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509133501.GD841@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 03:35:01PM +0200, Christoph Hellwig wrote:
> On Fri, May 05, 2023 at 11:51:19AM -0700, Darrick J. Wong wrote:
> > Fun question: What happens when the swap disk falls off the bus?
> 
> Your system is toast.
> 
> > > -	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode | FMODE_EXCL, &bdev)))
> > > +	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode | FMODE_EXCL, &bdev,
> > > +			NULL)))
> > >  		return -EBUSY;
> > >  	ret = set_blocksize(bdev, n);
> > >  	blkdev_put(bdev, mode | FMODE_EXCL);
> > 
> > Somewhat related question: Should we allow userspace to initiate a fs
> > shutdown through the block device?  Let's say you're preparing to yank
> > /dev/sda and want to kill anything attached to it or its partitions?
> > Without having to walk through however many mount namespaces there are
> > to find the mountpoints?
> 
> That's kinda what we're doing here.  Or do you mean even more advanced
> notice by having another callout before stopping I/O so that we could
> write out all log buffers?  It's probably doable, but I'm not convinced
> that this use case is worth maintaining and testing the kernel code for
> it.

The userspace shutdown code already does this by default - it
actually calls freeze_bdev() to cause the filesystem to be made
consistent on the block device before it executes the shutdown.
So, in effect, we already have the "shutdown before turning off
block device" paths in the filesystems and extremely well tested.

Indeed, if the device is being removed, why not call freeze_bdev()
before doing anything else? It guarantees that applications will be
quiesced and the filesystem will stabilise and not try to change
anything until the shutdown occurs when the device is pulled...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
