Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C285652DB0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 19:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbiESRT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 13:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiESRT4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 13:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7175A4AE29;
        Thu, 19 May 2022 10:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09C49616F1;
        Thu, 19 May 2022 17:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18909C385AA;
        Thu, 19 May 2022 17:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652980794;
        bh=Lc53lww+3O+GJa9QMYIrd8fsL2jCL3Emz8g6WWJukzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g3TT1IRNODOWz3lgflLkBetECoOvEdmWAWf8QqFnX1W7Gtr1AXdBSkydfKOpZjzAJ
         Osc+Gxpoe2yPCkljEp/9R6RRXKBdSM3uSt2sA/3qZPEBTtO5wsotIp+JPKk3VFTxu6
         7NK43JLbHqLlt+w/HehnhKZFnGGOv4ERYxQTYE2hQyJJF8w4Wa9wsu+zeSjxpE0EQb
         nOZs64uR1xQk1MzfGpXRIvrQLUaCzIolKKTvVrk1zyFy0oULFTWrc3mxj8ObvZGzEf
         GPfocsfZIbAa3lEP7zDnOqTSTRXlkS17gdWbVgF1TlQ8U7dGpSu13SXMK9kGY8hJho
         MGkhWNFd5XI7Q==
Date:   Thu, 19 May 2022 10:19:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <YoZ8OKDXZBiNd9XB@sol.localdomain>
References: <20220518171131.3525293-4-kbusch@fb.com>
 <YoWL+T8JiIO5Ln3h@sol.localdomain>
 <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
 <YoWjBxmKDQC1mCIz@sol.localdomain>
 <YoWkiCdduzyQxHR+@kbusch-mbp.dhcp.thefacebook.com>
 <YoWmi0mvoIk3CfQN@sol.localdomain>
 <YoWqlqIzBcYGkcnu@kbusch-mbp.dhcp.thefacebook.com>
 <YoW5Iy+Vbk4Rv3zT@sol.localdomain>
 <YoXN5CpSGGe7+OJs@kbusch-mbp.dhcp.thefacebook.com>
 <283d37e8-868a-990b-e953-4b7bb940135c@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <283d37e8-868a-990b-e953-4b7bb940135c@opensource.wdc.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 08:45:55AM +0200, Damien Le Moal wrote:
> On 2022/05/19 6:56, Keith Busch wrote:
> > On Wed, May 18, 2022 at 08:27:31PM -0700, Eric Biggers wrote:
> >>
> >> So the bio ends up with a total length that is a multiple of the logical block
> >> size, but the lengths of the individual bvecs in the bio are *not* necessarily
> >> multiples of the logical block size.  That's the problem.
> > 
> > I'm surely missing something here. I know the bvecs are not necessarily lbs
> > aligned, but why does that matter? Is there some driver that can only take
> > exactly 1 bvec, but allows it to be unaligned? If so, we could take the segment
> > queue limit into account, but I am not sure that we need to.
> 
> For direct IO, the first bvec will always be aligned to a logical block size.
> See __blkdev_direct_IO() and __blkdev_direct_IO_simple():
> 
>         if ((pos | iov_iter_alignment(iter)) &
>             (bdev_logical_block_size(bdev) - 1))
>                 return -EINVAL;
> 
> And given that, all bvecs should also be LBA aligned since the LBA size is
> always a divisor of the page size. Since splitting is always done on an LBA
> boundary, I do not see how we can ever get bvecs that are not LBA aligned.
> Or I am missing something too...
> 

You're looking at the current upstream code.  This patch changes that to:

	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
		return -EINVAL;
	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
		return -EINVAL;

So, if this patch is accepted, then the file position and total I/O length will
need to be logical block aligned (as before), but the memory address and length
of each individual iovec will no longer need to be logical block aligned.  How
the iovecs get turned into bios (and thus bvecs) is a little complicated, but
the result is that logical blocks will be able to span bvecs.

- Eric
