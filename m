Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E6F40A469
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 05:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbhIND3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 23:29:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49238 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbhIND3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:29:04 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B3B32200C6;
        Tue, 14 Sep 2021 03:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631590058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJSGn6WA2R49IT1QsgaLiH/CWsOR41ePlSu1rtiMbCg=;
        b=lQFnJD3mRRl+MwXbo/AUs9pWRfh/FmxioTQrHr4TKGAwgXbBt7IwWVuOmR4BSPBTZzZaqp
        w7oH+cfEoeoh/BCy8UzcBgFXeEtx+W7qx0FQ6M+NbOVVuAIhMyIsve4VWEUbFxFVob5BId
        qXtJXoCmV+GsSqKzD5k9V9YpOjcWXGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631590058;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJSGn6WA2R49IT1QsgaLiH/CWsOR41ePlSu1rtiMbCg=;
        b=h8MhPWifJWR/qF5e6Qb4KbwDznco+h5XlQjsH1PBqKDA5cr1isS79/33q0rOE8x7LqNmO+
        dOn2OkKj5qqbJEAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 080A913B56;
        Tue, 14 Sep 2021 03:27:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cgviLKYWQGGuJgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 14 Sep 2021 03:27:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dave Chinner" <david@fromorbit.com>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Mel Gorman" <mgorman@suse.com>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] XFS: remove congestion_wait() loop from kmem_alloc()
In-reply-to: <20210914013117.GG2361455@dread.disaster.area>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>,
 <163157838439.13293.5032214643474179966.stgit@noble.brown>,
 <20210914013117.GG2361455@dread.disaster.area>
Date:   Tue, 14 Sep 2021 13:27:31 +1000
Message-id: <163159005180.3992.2350725240228509854@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 14 Sep 2021, Dave Chinner wrote:
> On Tue, Sep 14, 2021 at 10:13:04AM +1000, NeilBrown wrote:
> > Documentation commment in gfp.h discourages indefinite retry loops on
> > ENOMEM and says of __GFP_NOFAIL that it
> > 
> >     is definitely preferable to use the flag rather than opencode
> >     endless loop around allocator.
> > 
> > So remove the loop, instead specifying __GFP_NOFAIL if KM_MAYFAIL was
> > not given.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/xfs/kmem.c |   16 ++++------------
> >  1 file changed, 4 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
> > index 6f49bf39183c..f545f3633f88 100644
> > --- a/fs/xfs/kmem.c
> > +++ b/fs/xfs/kmem.c
> > @@ -13,19 +13,11 @@ kmem_alloc(size_t size, xfs_km_flags_t flags)
> >  {
> >  	int	retries = 0;
> >  	gfp_t	lflags = kmem_flags_convert(flags);
> > -	void	*ptr;
> >  
> >  	trace_kmem_alloc(size, flags, _RET_IP_);
> >  
> > -	do {
> > -		ptr = kmalloc(size, lflags);
> > -		if (ptr || (flags & KM_MAYFAIL))
> > -			return ptr;
> > -		if (!(++retries % 100))
> > -			xfs_err(NULL,
> > -	"%s(%u) possible memory allocation deadlock size %u in %s (mode:0x%x)",
> > -				current->comm, current->pid,
> > -				(unsigned int)size, __func__, lflags);
> > -		congestion_wait(BLK_RW_ASYNC, HZ/50);
> > -	} while (1);
> > +	if (!(flags & KM_MAYFAIL))
> > +		lflags |= __GFP_NOFAIL;
> > +
> > +	return kmalloc(size, lflags);
> >  }
> 
> Which means we no longer get warnings about memory allocation
> failing - kmem_flags_convert() sets __GFP_NOWARN for all allocations
> in this loop. Hence we'll now get silent deadlocks through this code
> instead of getting warnings that memory allocation is failing
> repeatedly.

Yes, that is a problem.  Could we just clear __GFP_NOWARN when setting
__GFP_NOFAIL?
Or is the 1-in-100 important? I think default warning is 1 every 10
seconds.

> 
> I also wonder about changing the backoff behaviour here (it's a 20ms
> wait right now because there are not early wakeups) will affect the
> behaviour, as __GFP_NOFAIL won't wait for that extra time between
> allocation attempts....

The internal backoff is 100ms if there is much pending writeout, and
there are 16 internal retries.  If there is not much pending writeout, I
think it just loops with cond_resched().
So adding 20ms can only be at all interesting when the only way to
reclaim memory is something other than writeout.  I don't know how to
think about that.

> 
> And, of course, how did you test this? Sometimes we see
> unpredicted behaviours as a result of "simple" changes like this
> under low memory conditions...

I suspect this is close to untestable.  While I accept that there might
be a scenario where the change might cause some macro effect, it would
most likely be some interplay with some other subsystem struggling with
memory.  Testing XFS by itself would be unlikely to find it.

Thanks,
NeilBrown


> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
> 
