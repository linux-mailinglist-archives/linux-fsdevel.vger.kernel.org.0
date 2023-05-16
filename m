Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098197050E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjEPOgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 10:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjEPOga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 10:36:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6460410FE;
        Tue, 16 May 2023 07:36:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA23B63A1C;
        Tue, 16 May 2023 14:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F00C433D2;
        Tue, 16 May 2023 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684247787;
        bh=NbAYA5uVLLGOJWQJLPZTaFRC8mTWkQpGj37nw/WtjrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WV3cox9MdBLTEQsgQ01yaiFqdmMAINbBUfb/X2PE4HUD4Dq6F9BeUIObDNx/Bhigf
         ZKbfhRKHP9pHaYnuQtbpOf/2EP6eIX8GRNNKjpqOZHOVdl2uGePgbm3Wfu4TYGvQ6f
         lEdOmYxBmZRZIsGT2CnQOuJslc+Nv4eS7KTAcftmGjhQqtZgnb1pHcEDxZAoiKKcbD
         5b5nPegOv3lWd/GN1qUwDjVzleaVPW2MlUJdZDDILIOK7VgmDqawyil874wW5xgUbH
         OQOTl2UQuq2bP0FtQbBTmp+COfrS9VlHfgrlV18vWEaGEJ7vrrzgvr93DboNR0WI6l
         eCJ4smGBqsQnA==
Date:   Tue, 16 May 2023 07:36:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <20230516143626.GO858815@frogsfrogsfrogs>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-6-hch@lst.de>
 <ZGNixzo3WShiInI1@ovpn-8-19.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGNixzo3WShiInI1@ovpn-8-19.pek2.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 07:02:31PM +0800, Ming Lei wrote:
> On Fri, May 05, 2023 at 01:51:28PM -0400, Christoph Hellwig wrote:
> > Add a new blk_holder_ops structure, which is passed to blkdev_get_by_* and
> > installed in the block_device for exclusive claims.  It will be used to
> > allow the block layer to call back into the user of the block device for
> > thing like notification of a removed device or a device resize.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> 
> ...
> 
> > @@ -542,7 +543,8 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
> >   * Finish exclusive open of a block device. Mark the device as exlusively
> >   * open by the holder and wake up all waiters for exclusive open to finish.
> >   */
> > -static void bd_finish_claiming(struct block_device *bdev, void *holder)
> > +static void bd_finish_claiming(struct block_device *bdev, void *holder,
> > +		const struct blk_holder_ops *hops)
> >  {
> >  	struct block_device *whole = bdev_whole(bdev);
> >  
> > @@ -555,7 +557,10 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
> >  	whole->bd_holders++;
> >  	whole->bd_holder = bd_may_claim;
> >  	bdev->bd_holders++;
> > +	mutex_lock(&bdev->bd_holder_lock);
> >  	bdev->bd_holder = holder;
> > +	bdev->bd_holder_ops = hops;
> > +	mutex_unlock(&bdev->bd_holder_lock);
> >  	bd_clear_claiming(whole, holder);
> >  	mutex_unlock(&bdev_lock);
> >  }
> 
> I guess the holder ops may be override in case of multiple claim, can
> this be one problem from the holder ops user viewpoint? Or
> warn_on_once(bdev->bd_holder_ops && bdev->bd_holder_ops != hops) is needed here?

<shrug> I'd have thought bd_may_claim would suffice for detecting
multiple claims based on its "bd_holder != NULL" test?

Though I suppose an explicit test for bd_holder_ops != NULL would
prevent multiple claims if all the claims had NULL holders.

--D

> 
> Thanks,
> Ming
> 
