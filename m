Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C931E4E36FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 03:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbiCVC6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 22:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiCVC6w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:58:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B65A1066E4;
        Mon, 21 Mar 2022 19:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44B396104A;
        Tue, 22 Mar 2022 02:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4748BC340E8;
        Tue, 22 Mar 2022 02:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647917844;
        bh=cih2Zq+PuDnKgb0m9EuW5FNpwndOTDfiblgM91SQZ9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DFkM1JiyR7TIbQbFKeZKEOTVbwnpdJUZctamvADeBxZYFSaYXswULZCgaFDHAZSAW
         SmWpUbcKZJlgDchgfrRXlDCo5yQztoDWaYSxZcAt0+YFCBKNGNbWg5LvC/LEI/owGy
         QYH4+f6VpoXF2NeFJj5p9uzaJVdKODykGRx9pvw2p6Kk96lW4nZDtphyMyJJbkMFHd
         h3T2kEIw6XYX69HvF3CpJRWTjmCJrpY5XquQOP+isOdiyeewY4TPOlYfx3IBDlGprd
         e4dZE/NhWckNYVhZJyS1wly1fGy1YaKdUUxIkZg4Z/6eNgrPWh9wFyVgXlKG1FF0KB
         5MJ4VZ9bVr+Fw==
Date:   Mon, 21 Mar 2022 20:57:21 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: remove kiocb.ki_hint
Message-ID: <Yjk7EWuODBnkFiz6@kbusch-mbp.dhcp.thefacebook.com>
References: <20220308060529.736277-1-hch@lst.de>
 <20220308060529.736277-2-hch@lst.de>
 <164678732353.405180.15951772868993926898.b4-ty@kernel.dk>
 <d28979ca-2433-01b0-a764-1288e5909421@kernel.dk>
 <Yjk4LNtLLYOCswC3@casper.infradead.org>
 <d4fe91bf-5285-862d-4c2c-219161daec26@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4fe91bf-5285-862d-4c2c-219161daec26@kernel.dk>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 21, 2022 at 08:50:10PM -0600, Jens Axboe wrote:
> On 3/21/22 8:45 PM, Matthew Wilcox wrote:
> > On Mon, Mar 21, 2022 at 08:13:10PM -0600, Jens Axboe wrote:
> >> On 3/8/22 5:55 PM, Jens Axboe wrote:
> >>> On Tue, 8 Mar 2022 07:05:28 +0100, Christoph Hellwig wrote:
> >>>> This field is entirely unused now except for a tracepoint in f2fs, so
> >>>> remove it.
> >>>>
> >>>>
> >>>
> >>> Applied, thanks!
> >>>
> >>> [1/2] fs: remove kiocb.ki_hint
> >>>       commit: 41d36a9f3e5336f5b48c3adba0777b8e217020d7
> >>> [2/2] fs: remove fs.f_write_hint
> >>>       commit: 7b12e49669c99f63bc12351c57e581f1f14d4adf
> >>
> >> Upon thinking about the EINVAL solution a bit more, I do have a one
> >> worry - if you're currently using write_hints in your application,
> >> nobody should expect upgrading the kernel to break it. It's a fine
> >> solution for anything else, but that particular point does annoy me.
> > 
> > But if your application is run on an earlier kernel, it'll get
> > -EINVAL. So it must already be prepared to deal with that?
> 
> Since support wasn't there, it's not unreasonable to expect that an
> application was written on a newer kernel. Might just be an in-house or
> application thing, who knows? But the point is that upgrading from 5.x
> to 5.x+1, nobody should expect their application to break. And it will
> with this change. If you downgrade a kernel and a feature didn't exist
> back then, it's reasonable to expect that things may break.
> 
> Maybe this is being overly cautious, but... As a matter of principle,
> it's unquestionably wrong.
> 
> We can just let Linus make the decision here, arming him with the info
> he needs to make it in terms of hardware support. I'll write that up in
> the pull request.

It's really just an advisory hint at the hardware level anyway, so
returning success without actually doing anything with it technically
satisfies the requirement.
