Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0C952CB55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 06:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiESE4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 00:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiESE4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 00:56:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3D53DDC8;
        Wed, 18 May 2022 21:56:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0D1F619C5;
        Thu, 19 May 2022 04:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AC2C385B8;
        Thu, 19 May 2022 04:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652936168;
        bh=Mlu435KOBZN9YaaP2njYDaCi7dTqDX12su/oOqTE3TA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TA3uT4S1inQrAp/hoFhxBBckcMayyyl3WrP1LsbSNRxxHqGz+Qh70ZJH6wbZ6n5E1
         I5mKLj6+Yyaz4H+vrXbfoOPkq6XMoVFdFoPw6AWl7G8S9Pifcv1ioX41gu/wJahPbq
         bre4/Ty4BEl6HUsKtOxuXzQ0LXr3b1s86vCMJGDqZiR9IBOosiLWFdLg22vRdkQAk6
         6Z9Ui0xPmfQwB+92RUyG+qboCoxC1L6zlXzl3NdMq2bk89UjZhfPHj0gqOE2Gx+HxG
         iG0Qye2Tw7iVXOwuKaRcb6YLPgTTshmFDR+oDNc3agFRscwOWa5HVW70GXIpHDiBBe
         VZ5KFXAZnasIA==
Date:   Wed, 18 May 2022 22:56:04 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <YoXN5CpSGGe7+OJs@kbusch-mbp.dhcp.thefacebook.com>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <20220518171131.3525293-4-kbusch@fb.com>
 <YoWL+T8JiIO5Ln3h@sol.localdomain>
 <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
 <YoWjBxmKDQC1mCIz@sol.localdomain>
 <YoWkiCdduzyQxHR+@kbusch-mbp.dhcp.thefacebook.com>
 <YoWmi0mvoIk3CfQN@sol.localdomain>
 <YoWqlqIzBcYGkcnu@kbusch-mbp.dhcp.thefacebook.com>
 <YoW5Iy+Vbk4Rv3zT@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoW5Iy+Vbk4Rv3zT@sol.localdomain>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 08:27:31PM -0700, Eric Biggers wrote:
> 
> So the bio ends up with a total length that is a multiple of the logical block
> size, but the lengths of the individual bvecs in the bio are *not* necessarily
> multiples of the logical block size.  That's the problem.

I'm surely missing something here. I know the bvecs are not necessarily lbs
aligned, but why does that matter? Is there some driver that can only take
exactly 1 bvec, but allows it to be unaligned? If so, we could take the segment
queue limit into account, but I am not sure that we need to.
 
> Note, there's also lots of code that assumes that bio_vec::bv_len is a multiple
> of 512.  

Could you point me to some examples?

> That was implied by it being a multiple of the logical block size.  But
> the DMA alignment can be much lower, like 8 bytes (see nvme_set_queue_limits()).

That's the driver this was tested on, though I just changed it to 4 bytes for
5.19.
