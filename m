Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE4B4E36CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 03:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiCVCqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 22:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiCVCqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:46:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D475427CF3;
        Mon, 21 Mar 2022 19:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+1iWuuW4msg7gbZ7IqMnEqBPIAfDW+AtEN2NJEICtn4=; b=C1qnUgDpTREF71PrnGK9xLw8TK
        GVjeqRZ4g1vf4b2xcsY4oYBe4ThLu1QCJLsxc3qw7KAOHNo6EdK+4ukg52QH0Eq0kirnfacB4qilW
        CgOF1PVEA4KiGrcV86gIzABnvJaa9efpIXfcaILL/vaTsC+YBXItjb8MXsdiaU4RS4KrQCDvCPsb0
        6nQQALDM+Cl8Lk2dTuu0hlI1/Jbppb9SKq+Jx6zofT8tQthPsL1ym76N5iQ7bJtCtHi+BQPJ6lOcN
        a4wDtnDgg5XMMpg4UbdXEQ1WxVGADbYwO6mYwUwtKO8iRpjAwGfVapSIwXxv0xpoA4yIuTj/HWH4H
        Kev4RerQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWUW4-00BC0e-L9; Tue, 22 Mar 2022 02:45:00 +0000
Date:   Tue, 22 Mar 2022 02:45:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: remove kiocb.ki_hint
Message-ID: <Yjk4LNtLLYOCswC3@casper.infradead.org>
References: <20220308060529.736277-1-hch@lst.de>
 <20220308060529.736277-2-hch@lst.de>
 <164678732353.405180.15951772868993926898.b4-ty@kernel.dk>
 <d28979ca-2433-01b0-a764-1288e5909421@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28979ca-2433-01b0-a764-1288e5909421@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 21, 2022 at 08:13:10PM -0600, Jens Axboe wrote:
> On 3/8/22 5:55 PM, Jens Axboe wrote:
> > On Tue, 8 Mar 2022 07:05:28 +0100, Christoph Hellwig wrote:
> >> This field is entirely unused now except for a tracepoint in f2fs, so
> >> remove it.
> >>
> >>
> > 
> > Applied, thanks!
> > 
> > [1/2] fs: remove kiocb.ki_hint
> >       commit: 41d36a9f3e5336f5b48c3adba0777b8e217020d7
> > [2/2] fs: remove fs.f_write_hint
> >       commit: 7b12e49669c99f63bc12351c57e581f1f14d4adf
> 
> Upon thinking about the EINVAL solution a bit more, I do have a one
> worry - if you're currently using write_hints in your application,
> nobody should expect upgrading the kernel to break it. It's a fine
> solution for anything else, but that particular point does annoy me.

But if your application is run on an earlier kernel, it'll get -EINVAL.
So it must already be prepared to deal with that?
