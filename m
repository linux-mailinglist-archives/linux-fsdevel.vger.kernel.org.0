Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4476A52C98C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 04:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiESCCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 22:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiESCCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 22:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3253F522FB;
        Wed, 18 May 2022 19:02:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B324B61890;
        Thu, 19 May 2022 02:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42DBC385A5;
        Thu, 19 May 2022 02:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652925765;
        bh=+L5myMPlW2pROi0IVPs6XhjBqNjjCLpoW2H5RgOoykQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k70dT6+2fEhPxyG8Mklcb+3PuacnWD29FxsWQ8XoWqirHJ0NyMBaPldGTh3brJnC0
         Q5+M/JtLzAWCrq4UPj1Y4j6MQuqK6fADOJIebNDmU2xNNMswGHWqkQ0okOWBOy6y5O
         hUKjS8NmaWSUna7C490dcc/p20yMEaAqePKMVbm0ZSYpGgcuMyP2U1PNsFrhns4ZKj
         ZQEP6K1iL2E/MXw3+oZ9TACkmHkOvA16AdZz8oEENj2T7nrIyJ6ltiUio1YAdibzPm
         l536OIDnfNgVrfwd6wkbtTFOmOM1daqX6UiLXU651MT1CssbAvxCQaG3sgecFaEBB3
         xOt47XSfDenfg==
Date:   Wed, 18 May 2022 19:02:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Kernel Team <Kernel-team@fb.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCHv2 0/3] direct io alignment relax
Message-ID: <YoWlQxEjvlmACNRV@sol.localdomain>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <YoWAnDR/XOwegQNZ@gmail.com>
 <YoWUnTxag7TsCBwa@kbusch-mbp.dhcp.thefacebook.com>
 <f42c74b9-67fa-50fc-d97e-2a7f153f10e4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f42c74b9-67fa-50fc-d97e-2a7f153f10e4@nvidia.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 01:02:42AM +0000, Chaitanya Kulkarni wrote:
> On 5/18/22 17:51, Keith Busch wrote:
> > On Wed, May 18, 2022 at 11:26:20PM +0000, Eric Biggers wrote:
> >> On Wed, May 18, 2022 at 10:11:28AM -0700, Keith Busch wrote:
> >>> From: Keith Busch <kbusch@kernel.org>
> >>>
> >>> Including the fs list this time.
> >>>
> >>> I am still working on a better interface to report the dio alignment to
> >>> an application. The most recent suggestion of using statx is proving to
> >>> be less straight forward than I thought, but I don't want to hold this
> >>> series up for that.
> >>>
> >>
> >> Note that I already implemented the statx support and sent it out for review:
> >> https://lore.kernel.org/linux-fsdevel/20220211061158.227688-1-ebiggers@kernel.org/T/#u
> >> However, the patch series only received one comment.  I can send it out again if
> >> people have become interested in it again...
> > 
> > Thanks, I didn't see that the first time around, but I'll be sure to look at
> > your new version. It sounds like you encountered the same problem I did
> > regarding block device handles: the devtmpfs inodes for the raw block device
> > handles are not the bdev inodes. I do think it's useful the alignment
> > attributes are accessible through the block device files, though.
> 
> Irrespective of above problem, as per my review comment [1] on the
> initial version of Eric's series I really want to see the generic
> interface that can accommodate exposing optimal values for different
> operations REQ_OP_DISCARD/REQ_OP_WRITE_ZEROES/REQ_OP_VERIFY etc.
> and not only for read/write.
> 
> -ck
> 
> https://lore.kernel.org/linux-fsdevel/20220211061158.227688-1-ebiggers@kernel.org/T/#r3ffe9183c372fb97a9753e286f9cf6400e8ec272

Userspace doesn't know what REQ_OP_* are; they are internal implementation
details of the block layer.  What UAPIs, specifically, do you have in mind for
wanting to know the alignment requirements of?

If you're thinking about about BLKDISCARD and BLKZEROOUT, those are block device
ioctls, so statx() doesn't seem like a great fit for them.  There is already a
place to expose block device properties to userspace (/sys/block/$dev/).  Direct
I/O is different because direct I/O is not just a feature of block devices but
also of regular files, and it is affected by filesystem-level constraints.

- Eric
