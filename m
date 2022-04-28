Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C127513793
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 17:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiD1PDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 11:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiD1PDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:03:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7EF12AA5
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 08:00:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 089BE1F745;
        Thu, 28 Apr 2022 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651158022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=teYgutLvQw0h6xvINcC2dz3O1o7WSyedRKXKjvCmVyc=;
        b=hFCBbQT2LzlNKApSxMOMOxHd+utwKhqDgjtP5qNVg3s/j+PUFVEiof2YE/KlfEXQsf+LVr
        EJ0XGjzJgnmqfxy54GbEZ9cvEZ9SQ5YRiCwi/TwqciOgdGN6cBc0clqEJ4pnM4j2/8dIIS
        uS/Mb2ja5qbML2+Yv+vPzXW2Qb9NvXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651158022;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=teYgutLvQw0h6xvINcC2dz3O1o7WSyedRKXKjvCmVyc=;
        b=y0VrIKHCu5FD1ZP+9euLLUl3KaybCyLc+3IPp1rPr7/rKGcr2udW5v31Ml5ApqW7wKMXEG
        0rt7D4R+3H22umBg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E7CBC2C145;
        Thu, 28 Apr 2022 15:00:21 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5C395A061A; Thu, 28 Apr 2022 17:00:21 +0200 (CEST)
Date:   Thu, 28 Apr 2022 17:00:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] direct-io: prevent possible race condition on bio_list
Message-ID: <20220428150021.h7s62zeta2xsbg6z@quack3.lan>
References: <20220226221748.197800-1-dossche.niels@gmail.com>
 <Yhqo9/695SJbMCBb@casper.infradead.org>
 <9f5f8241-f3c4-f3ad-a5c1-c7b4637467bd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f5f8241-f3c4-f3ad-a5c1-c7b4637467bd@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 26-02-22 23:29:03, Niels Dossche wrote:
> On 2/26/22 23:25, Matthew Wilcox wrote:
> > On Sat, Feb 26, 2022 at 11:17:48PM +0100, Niels Dossche wrote:
> >> Prevent bio_list from changing in the while loop condition such that the
> >> body of the loop won't execute with a potentially NULL pointer for
> >> bio_list, which causes a NULL dereference later on.
> > 
> > Is this something you've seen happen, or something you think might
> > happen?
> > 
> 
> This is something that I think might happen, not something I've seen.

I can see this didn't get merged. I agree the code looks fishy but AFAICT
it is safe. The reason is that the only code that can currently remove bio
from bio_list is under dio_await_completion() which cannot run concurrently
with dio_bio_reap() on the same bio... It might deserve a comment though.

								Honza

> 
> >> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> >> ---
> >>  fs/direct-io.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/direct-io.c b/fs/direct-io.c
> >> index 654443558047..806f05407019 100644
> >> --- a/fs/direct-io.c
> >> +++ b/fs/direct-io.c
> >> @@ -545,19 +545,22 @@ static inline int dio_bio_reap(struct dio *dio, struct dio_submit *sdio)
> >>  	int ret = 0;
> >>  
> >>  	if (sdio->reap_counter++ >= 64) {
> >> +		unsigned long flags;
> >> +
> >> +		spin_lock_irqsave(&dio->bio_lock, flags);
> >>  		while (dio->bio_list) {
> >> -			unsigned long flags;
> >>  			struct bio *bio;
> >>  			int ret2;
> >>  
> >> -			spin_lock_irqsave(&dio->bio_lock, flags);
> >>  			bio = dio->bio_list;
> >>  			dio->bio_list = bio->bi_private;
> >>  			spin_unlock_irqrestore(&dio->bio_lock, flags);
> >>  			ret2 = blk_status_to_errno(dio_bio_complete(dio, bio));
> >>  			if (ret == 0)
> >>  				ret = ret2;
> >> +			spin_lock_irqsave(&dio->bio_lock, flags);
> >>  		}
> >> +		spin_unlock_irqrestore(&dio->bio_lock, flags);
> >>  		sdio->reap_counter = 0;
> >>  	}
> >>  	return ret;
> >> -- 
> >> 2.35.1
> >>
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
