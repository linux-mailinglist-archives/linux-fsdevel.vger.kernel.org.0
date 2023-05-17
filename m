Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71081706124
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 09:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjEQHag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 03:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjEQH3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 03:29:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469E74C2C;
        Wed, 17 May 2023 00:29:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8B52168C4E; Wed, 17 May 2023 09:29:33 +0200 (CEST)
Date:   Wed, 17 May 2023 09:29:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <20230517072933.GE27026@lst.de>
References: <20230505175132.2236632-1-hch@lst.de> <20230505175132.2236632-6-hch@lst.de> <ZGNixzo3WShiInI1@ovpn-8-19.pek2.redhat.com> <20230516143626.GO858815@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516143626.GO858815@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 07:36:26AM -0700, Darrick J. Wong wrote:
> > > +	mutex_lock(&bdev->bd_holder_lock);
> > >  	bdev->bd_holder = holder;
> > > +	bdev->bd_holder_ops = hops;
> > > +	mutex_unlock(&bdev->bd_holder_lock);
> > >  	bd_clear_claiming(whole, holder);
> > >  	mutex_unlock(&bdev_lock);
> > >  }
> > 
> > I guess the holder ops may be override in case of multiple claim, can
> > this be one problem from the holder ops user viewpoint? Or
> > warn_on_once(bdev->bd_holder_ops && bdev->bd_holder_ops != hops) is needed here?
> 
> <shrug> I'd have thought bd_may_claim would suffice for detecting
> multiple claims based on its "bd_holder != NULL" test?
> 
> Though I suppose an explicit test for bd_holder_ops != NULL would
> prevent multiple claims if all the claims had NULL holders.

bd_may_claim allows re-claims as long as the same holder is set.
I think we'll want to add an extra check that the holder_ops don't
change for this case.  They aren't with the current holders, but this
is a place where a belt and suspenders might be a good idea..

> 
> --D
> 
> > 
> > Thanks,
> > Ming
> > 
---end quoted text---
