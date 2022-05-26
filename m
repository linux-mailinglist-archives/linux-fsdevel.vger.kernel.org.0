Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F88953532D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 20:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243254AbiEZSN4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 14:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiEZSN4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 14:13:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964AFB2272;
        Thu, 26 May 2022 11:13:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C85AE61640;
        Thu, 26 May 2022 18:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B241AC385A9;
        Thu, 26 May 2022 18:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653588834;
        bh=e6S1wsx8dmsbh7szOOlugfAeR1nroErTcI2BgiOX/FU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QCgShyLY+H5CQf3JN8bBEE7latBQ1v5NiNG0GuvYaFefMGEm7yVcxpP4hoCJDaXX8
         AdYKSYAQCi5hQwepnCCNe+EQv1KxgaojqJ++ItqeJWr4cwJu41CUTPu6EMtgVGcFmX
         k/1bXzqgDJ+EcdV3d96001eIDoVwh5u6F+E4zrRE1UstKRPSKKOQuf0ej58ElEHKLQ
         +VxjNnU7TAeo4l+lfv9iuL/UOY8XWAu2qWDTxkMRkXSMGPpyv7xlrqbYT9Z2byd4uY
         7uJU3inaSu7Qf5z65rvHQ8ktq/MtGggMpPvRk0GB214PSWr+rtybLbMdqNFiP4aZv/
         Dm1Zu8FmwCNjg==
Date:   Thu, 26 May 2022 11:13:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com
Subject: Re: [PATCHv4 8/9] block: relax direct io memory alignment
Message-ID: <Yo/DYI17KWgXJNyB@sol.localdomain>
References: <20220526010613.4016118-1-kbusch@fb.com>
 <20220526010613.4016118-9-kbusch@fb.com>
 <Yo8sZWNNTKM2Kwqm@sol.localdomain>
 <Yo+FtQ8GlHtMT3pT@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo+FtQ8GlHtMT3pT@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 26, 2022 at 07:50:45AM -0600, Keith Busch wrote:
> On Thu, May 26, 2022 at 12:29:41AM -0700, Eric Biggers wrote:
> > On Wed, May 25, 2022 at 06:06:12PM -0700, Keith Busch wrote:
> > > +	/*
> > > +	 * Each segment in the iov is required to be a block size multiple.
> > 
> > Where is this enforced?
> 
> Right below the comment. If it isn't a block size multiple, then ALIGN_DOWN
> will eventually result in 0 and -EFAULT is returned. 

That's interesting, I would have expected it to be checked in
blkdev_dio_aligned().

EFAULT isn't the correct error code for this case; it should be EINVAL as is
normally the case for bad alignment.  See the man pages for read and write.

- Eric
