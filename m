Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476A324012B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 05:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHJDWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Aug 2020 23:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgHJDWv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Aug 2020 23:22:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82433C061756;
        Sun,  9 Aug 2020 20:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uOQ8yZ/DAL78l4x4TeTTcSfJ+LbD3rh0jqrIXRRd/r8=; b=ZDGM8QthpVFD4qWSRe65+sqilB
        Gzr7WqlbWraI/lCOwKi8OisjDJhUSnMGEF23kEjaH0BZEuas6jGi+3vgwaWgTu7YmG3OKm8wiNwCW
        7+lHUlabDqO9DHkbRsvrMgBKgs89KADLCTi1/j6suLVxHxb4Hbxm3BvEk/Qz9qbTtP3U848+d8Qqa
        NZn62WgONP8+195RJrCj9GS7zaRfksgFZgLchAErM+H0pMM7WSauq3d8haYcvchYSfDB3/xjhlnLK
        W+cLiCyHw1yCB6CXnLv4H9gbqmZdox2rVP0CEAuRsljKXP9t55MYUSWDETN12Cv9mOiaOWPbuw6Rz
        QAdaoCkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4yOd-00071L-Ua; Mon, 10 Aug 2020 03:22:48 +0000
Date:   Mon, 10 Aug 2020 04:22:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Very slow qemu device access
Message-ID: <20200810032247.GJ17456@casper.infradead.org>
References: <20200807174416.GF17456@casper.infradead.org>
 <20200809024005.GC2134904@T590>
 <20200809142522.GI17456@casper.infradead.org>
 <20200810031049.GA2202641@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810031049.GA2202641@T590>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:10:49AM +0800, Ming Lei wrote:
> On Sun, Aug 09, 2020 at 03:25:22PM +0100, Matthew Wilcox wrote:
> > On Sun, Aug 09, 2020 at 10:40:05AM +0800, Ming Lei wrote:
> > > Hello Matthew,
> > > 
> > > On Fri, Aug 07, 2020 at 06:44:16PM +0100, Matthew Wilcox wrote:
> > > > 
> > > > Everything starts going very slowly after this commit:
> > > > 
> > > > commit 37f4a24c2469a10a4c16c641671bd766e276cf9f (refs/bisect/bad)
> > > > Author: Ming Lei <ming.lei@redhat.com>
> > > > Date:   Tue Jun 30 22:03:57 2020 +0800
> > > > 
> > > >     blk-mq: centralise related handling into blk_mq_get_driver_tag
> > > 
> > > Yeah, the above is one known bad commit, which is reverted in
> > > 4e2f62e566b5 ("Revert "blk-mq: put driver tag when this request is completed")
> > > 
> > > Finally the fixed patch of 'blk-mq: centralise related handling into blk_mq_get_driver_tag'
> > > is merged as 568f27006577 ("blk-mq: centralise related handling into blk_mq_get_driver_tag").
> > > 
> > > So please test either 4e2f62e566b5 or 568f27006577 and see if there is
> > > such issue.
> > 
> > 4e2f62e566b5 is good
> > 568f27006577 is bad
> 
> Please try the following patch, and we shouldn't take flush request
> account into driver tag allocation, because it always shares the
> data request's tag:
> 
> >From d508415eee08940ff9c78efe0eddddf594afdb94 Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Mon, 10 Aug 2020 11:06:15 +0800
> Subject: [PATCH] block: don't double account of flush request's driver tag
> 
> In case of none scheduler, we share data request's driver tag for
> flush request, so have to mark the flush request as INFLIGHT for
> avoiding double account of this driver tag.

Yes, this fixes the problem.  Thanks!
