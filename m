Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A8F5454D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 21:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245256AbiFITWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 15:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244349AbiFITWQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:22:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63401F1BE7
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 12:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6zNNz9dHtD4cWtle0UDVZNgQLDCyZjFlezWMv9j9PaI=; b=o9kS/GrDF2/SW4FXuiKSgUxBHt
        1s7IZBR2J3MemINllh07eodIJGbin54iBJtvX4moUaPYtGgIruqYJYpV0kWQ9hbZeHj0EUKFwS3+l
        fgkWayYpkUPShznKCDMJtEJea21FeyESpsn0eqzyB0YCQLof6UO81AujWb7ZGrMcgafFd41MWZ101
        I+c900d7B05B1b2BEF2JYo0BeP7fKnaqiAAaa3vRQPtOXX1U2r+4ZiyQjhOpjh0C0Mj7JqR5wMLNX
        BUvWcMK0a8Ayu/E9q90vjzV3UYCNHyZAjHZZCDgvV7kiz2FpmqGspn1gNmkWIxBZjBPKGRssFz8WG
        b4sOuaLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzNjN-00Dn8I-Es; Thu, 09 Jun 2022 19:22:09 +0000
Date:   Thu, 9 Jun 2022 20:22:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC][PATCHES] iov_iter stuff
Message-ID: <YqJIYd65XeA8Aj6C@casper.infradead.org>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
 <CA+icZUV_kJcwtFK2aACAfKAkx6EdW62u46Qa7kkPXtRhMYCcsw@mail.gmail.com>
 <YqEJEWWfxbNA6AcC@zeniv-ca.linux.org.uk>
 <CA+icZUU_Lzo918raOtEXvMtEoUhZp9e+8Xd0_bxA=1_aZ=ZBTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUU_Lzo918raOtEXvMtEoUhZp9e+8Xd0_bxA=1_aZ=ZBTQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 09, 2022 at 09:10:04PM +0200, Sedat Dilek wrote:
> On Wed, Jun 8, 2022 at 10:39 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Jun 08, 2022 at 09:28:18PM +0200, Sedat Dilek wrote:
> >
> > > I have pulled this on top of Linux v5.19-rc1... plus assorted patches
> > > to fix issues with LLVM/Clang version 14.
> > > No (new) warnings in my build-log.
> > > Boots fine on bare metal on my Debian/unstable AMD64 system.
> > >
> > > Any hints for testing - to see improvements?
> >
> > Profiling, basically...  A somewhat artificial microbenchmark would be
> > to remove read_null()/write_null()/read_zero()/write_zero(), along with
> > the corresponding .read and .write initializers in drivers/char/mem.c
> > and see how dd to/from /dev/zero and friends behaves.  On the mainline
> > it gives a noticable regression, due to overhead in new_sync_{read,write}().
> > With this series it should get better; pipe reads/writes also should see
> > reduction of overhead.
> >
> >         There'd been a thread regarding /dev/random stuff; look for
> > "random: convert to using iters" and things nearby...
> 
> Hmm, I did not find it...
> 
> I bookmarked Ingo's reply on Boris x86-usercopy patch.
> There is a vague description without (for me at least) concrete instructions.

It's not really that.  This is more about per-IO overhead, so you'd want
to do a lot of 1-byte writes to maximise your chance of seeing a
difference.

