Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF3153BB9C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 17:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiFBPcg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 11:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiFBPce (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:32:34 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178E3D9A
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jun 2022 08:32:33 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id y15so3628338qtx.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jun 2022 08:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=351BGscnFb6fOiSLJ8JRSm8+B6M5wCDRVtIhnHMhJP0=;
        b=hN/tjVY+vS8gRaKCyfDLet9tX+ccqWSz7FSvrN9o4G0JF0LRx4SaplIHjrNRAtRnAV
         XTgvcJENORSj515U6SWsAm6BKmGLRL/98BmbY/BV0zfRaaH/PMa+DJ3e5bJrBZ8JH6gA
         jcKiXmE0bv5b5QirnX5CfMNvCLfjLCp2D85HmeEgmFxojGfQ1kKZrPhRQJAtrOd9QMWk
         KMrQryV0ZM6HAI0X4zuRGpeRc2877gof9dTDxwi9meLwqdnncTb2ULZcxEZrg9kCY7bg
         A9/rMxYrPTnhLt1zMTrxrI+tKS48rtbdYEWnOLp+zWR6I0es3MtranvilRvDEMvOjafp
         nQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=351BGscnFb6fOiSLJ8JRSm8+B6M5wCDRVtIhnHMhJP0=;
        b=fI1UkSj8oZ/QdHQ9vY5rC/sk1501Fwh/uvd0b0L5B56EgG7afGxSoDWciFnJ7+JCn/
         1blycTJmMWxmkliHdPdXjqb2kWakPimxjvxVVfcZBM0cmlKE0JPPpnj8NeGwlBpoUSB4
         CEvIhsKD86YgycUqLro3/cfvX+yVOSkg4FhcAxw3gM79BPnjKWZdo98Iz2lav61gu2yk
         wBad3nVSPzPW32+4WjmCw6V1pZG3KK3bgxsKSCZK+WIHNxjqi4NTfaH7vk1r7OxakE6Z
         GIEG6YXA04gQicCDQKtlALfnoMfT3Z1SfOnj78pZ+HHvc3y6ESB2fQp2tUgUGIARyEaw
         dYaw==
X-Gm-Message-State: AOAM530d2xA5KWP2UT9l7pBVZ3abO7H+0r7QV6PFm7Hx2b6aml9/Mqet
        homCJzvFLs7urMWJbKRHWV2Oww==
X-Google-Smtp-Source: ABdhPJwedKuk4vx7HanWkPD1ZPpgqYUWMWMFu0Q3HbQ4Dh8q+n8oK1SAymC0DbBh+5Hf7BB2gVgQEw==
X-Received: by 2002:ac8:5b84:0:b0:2f3:cba9:242d with SMTP id a4-20020ac85b84000000b002f3cba9242dmr4079685qta.260.1654183952165;
        Thu, 02 Jun 2022 08:32:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:1d66])
        by smtp.gmail.com with ESMTPSA id k4-20020a378804000000b006a5d2eb58b2sm3407092qkd.33.2022.06.02.08.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 08:32:31 -0700 (PDT)
Date:   Thu, 2 Jun 2022 11:32:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Chris Mason <clm@fb.com>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>
Subject: Re: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Message-ID: <YpjYDjeR2Wpx3ImB@cmpxchg.org>
References: <20220601011116.495988-1-clm@fb.com>
 <YpdZKbrtXJJ9mWL7@infradead.org>
 <BB5F778F-BFE5-4CC9-94DE-3118C60E13B6@fb.com>
 <20220602065252.GD1098723@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220602065252.GD1098723@dread.disaster.area>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 02, 2022 at 04:52:52PM +1000, Dave Chinner wrote:
> On Wed, Jun 01, 2022 at 02:13:42PM +0000, Chris Mason wrote:
> > In prod, bpftrace showed looping on a single inode inside a mysql
> > cgroup.  That inode was usually in the middle of being deleted,
> > i_size set to zero, but it still had 40-90 pages sitting in the
> > xarray waiting for truncation.  We’d loop through the whole call
> > path above over and over again, mostly because writepages() was
> > returning progress had been made on this one inode.  The
> > redirty_page_for_writepage() path does drop wbc->nr_to_write, so
> > the rest of the writepages machinery believes real work is being
> > done.  nr_to_write is LONG_MAX, so we’ve got a while to loop.
> 
> Yup, this code relies on truncate making progress to avoid looping
> forever. Truncate should only block on the page while it locks it
> and waits for writeback to complete, then it gets forcibly
> invalidated and removed from the page cache.

It's not looping forever, truncate can just take a relatively long
time during which the flusher is busy-spinning full bore on a
relatively small number of unflushable pages (range_cyclic).

But you raise a good point asking "why is truncate stuck?". I first
thought they might be cannibalizing each other over the page locks,
but that wasn't it (and wouldn't explain the clear asymmetry between
truncate and flusher). That leaves the waiting for writeback. I just
confirmed with tracing that that's exactly where truncate sits while
the flusher goes bananas on the same inode. So the race must be this:

truncate:                flusher
                         put a subset of pages under writeback
i_size_write(0)
wait_on_page_writeback()
                         loop with range_cyclic over remaining dirty >EOF pages

> Hence I think we can remove the redirtying completely - it's not
> needed and hasn't been for some time.
> 
> Further, I don't think we need to invalidate the folio, either. If
> it's beyond EOF, then it is because a truncate is in progress that
> means it is somebody else's problem to clean up. Hence we should
> leave it to the truncate to deal with, just like the pre-2013 code
> did....

Perfect, that works.
