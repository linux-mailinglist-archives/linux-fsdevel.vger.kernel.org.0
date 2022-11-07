Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C956203FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 00:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiKGXs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 18:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiKGXsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:48:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994B439E;
        Mon,  7 Nov 2022 15:48:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D77FB812A9;
        Mon,  7 Nov 2022 23:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15664C433C1;
        Mon,  7 Nov 2022 23:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667864900;
        bh=Bn93Wjrh2zycayiqURI1Y10qyELBkj4d6Msn3igpNvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzsMzu4Xh0bj6hUc1iQdzsBrK1etj+2IXxpnfT4lwndB0artCHDYHyY7zqnoyNLsX
         bxbqFl3mPH2mRogZSvc9o1DVoNpDcDDKdUwd2XkGFig+Y3bglMh3G/+cHtq3j6n32D
         nRnpoK7kxapEvQBd1etCf+WsnZ83AB9R0YO1yAPepb+C5lt+v9G4OtKn7WzwxCnrdI
         Zt5BsrToezGKL1cxTtB2DYAcY/+4peMaW4HMguq3H2ydddxcRBHcISEaKGY8ipjUvH
         TUWPgFvlh7c8xFGXmEtwwsc+0srh5T6olOZjNdvVlulE4krVAcgWY8YR6PXXEnn/38
         NV8aT2fcCe7xA==
Date:   Mon, 7 Nov 2022 15:48:19 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] xfs: buffered write failure should not truncate the
 page cache
Message-ID: <Y2mZQ6HC6TWfmDc8@magnolia>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-5-david@fromorbit.com>
 <Y2TIkvGMyjlXz7jp@infradead.org>
 <20221104231036.GM3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104231036.GM3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 05, 2022 at 10:10:36AM +1100, Dave Chinner wrote:
> On Fri, Nov 04, 2022 at 01:08:50AM -0700, Christoph Hellwig wrote:
> > So, the whole scan for delalloc logic seems pretty generic, I think
> > it can an should be lifted to iomap, with
> > xfs_buffered_write_delalloc_punch provided as a callback.
> 
> Maybe. When we get another filesystem that has the same problem with
> short writes needing to punch delalloc extents, we can look at
> lifting it into the generic code. But until then, it is exclusively
> an XFS issue...
> 
> > As for the reuse of the seek hole / data helpers, and I'm not sure
> > this actually helps all that much, and certainly is not super
> > efficient.  I don't want you to directly talk into rewriting this
> > once again, but a simple
> 
> [snip]
> 
> I started with the method you are suggesting, and it took me 4 weeks
> of fighting with boundary condition bugs before I realised there was
> a better way.
> 
> Searching for sub-folio discontiguities is highly inefficient
> however you look at it - we have to scan dirty folios block by block
> determine the uptodate state of each block. We can't do a range scan
> because is_partially_uptodate() will return false if any block
> within the range is not up to date.  Hence we have to iterate one
> block at a time to determine the state of each block, and that
> greatly complicates things.

This sounds like a neat optimization for seek hole/data, but that's an
optimization that can be deferred to another cleanup.  As it is, this
fix patchset already introduces plenty to think about.

--D

> i.e. we now have range boundarys at the edges of the write() op,
> range boundaries at the edges of filesysetm blocks, and range
> boundaries at unpredictable folio_size() edges. I couldn't keep all
> this straight in my head - I have to be able to maintain and debug
> this code, so if I can't track all the edge cases in my head, I sure
> as hell can't debug the code, nor expect to understand it when I
> next look at it in a few months time.

> Just because one person is smart enough to be able to write code
> that uses multiply-nested range iterations full of boundary
> conditions that have to be handled correctly, it doesn't mean that
> it is the best way to write slow-path/error handling code that *must
> be correct*. The best code is the code that anyone can understand
> and say "yes, that is correct".
> 
> So, yes, using the seek hole / data helpers might be a tiny bit more
> code, but compactness, efficiency and speed really don't matter.
> What matters is that the code is correct and that the people who
> need to track down the bugs and data corruptions in this code are
> able to understand and debug the code.  i.e. to make the code
> maintainable we need to break the complex problems down into
> algorithms and code that can be understood and debugged by anyone,
> not just the smartest person in the room.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
