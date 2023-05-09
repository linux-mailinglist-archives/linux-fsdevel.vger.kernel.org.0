Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08166FC7F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 15:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbjEINfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 09:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjEINfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 09:35:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F7430EF;
        Tue,  9 May 2023 06:35:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 517C56732A; Tue,  9 May 2023 15:35:02 +0200 (CEST)
Date:   Tue, 9 May 2023 15:35:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <20230509133501.GD841@lst.de>
References: <20230505175132.2236632-1-hch@lst.de> <20230505175132.2236632-6-hch@lst.de> <20230505185119.GI15394@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505185119.GI15394@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 11:51:19AM -0700, Darrick J. Wong wrote:
> Fun question: What happens when the swap disk falls off the bus?

Your system is toast.

> > -	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode | FMODE_EXCL, &bdev)))
> > +	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode | FMODE_EXCL, &bdev,
> > +			NULL)))
> >  		return -EBUSY;
> >  	ret = set_blocksize(bdev, n);
> >  	blkdev_put(bdev, mode | FMODE_EXCL);
> 
> Somewhat related question: Should we allow userspace to initiate a fs
> shutdown through the block device?  Let's say you're preparing to yank
> /dev/sda and want to kill anything attached to it or its partitions?
> Without having to walk through however many mount namespaces there are
> to find the mountpoints?

That's kinda what we're doing here.  Or do you mean even more advanced
notice by having another callout before stopping I/O so that we could
write out all log buffers?  It's probably doable, but I'm not convinced
that this use case is worth maintaining and testing the kernel code for
it.
