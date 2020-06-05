Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C6A1EEF75
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 04:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgFECY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 22:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFECYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 22:24:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2210C08C5C0;
        Thu,  4 Jun 2020 19:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=stJtg0wxxcvkO2KnmFzvC8cjE/GKPMguH7eI3OkCIjE=; b=dlsw39Lq+8x+7Fsa+OMvugjnLW
        5PhSYwe7QfPCTwih92cnLlHdsGCAevjOpC+oH+MQFVSMzNosQ060m5FkUY7/wvsYACpZgsADgpzXA
        ZqeoPyDk33Ckc++5paPfznuVMa3exc7J+D+KjPIhejJmuV9wYPtTNADysH2NQBKRKOFhoTIwj+mtP
        wNe7UtGqQ41NJdOW7hNvDQLCkEBHyWNJqSSy/EwkoJdvIbiUw9Tq80orwM5nTMVKO3GoO5McrGrZG
        83ppFGuAx/Do7vdAip99r4CDNxrEhmoxHyjRmQCiCJLYl9j4APZGMv6RDZadFRr41kKNH8Cuv0Uad
        EfSmYszA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jh22N-0001gw-4v; Fri, 05 Jun 2020 02:24:51 +0000
Date:   Thu, 4 Jun 2020 19:24:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Handle I/O errors gracefully in page_mkwrite
Message-ID: <20200605022451.GZ19604@bombadil.infradead.org>
References: <20200604202340.29170-1-willy@infradead.org>
 <20200604225726.GU2040@dread.disaster.area>
 <20200604230519.GW19604@bombadil.infradead.org>
 <20200604233053.GW2040@dread.disaster.area>
 <20200604235050.GX19604@bombadil.infradead.org>
 <20200605003159.GX2040@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605003159.GX2040@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 10:31:59AM +1000, Dave Chinner wrote:
> On Thu, Jun 04, 2020 at 04:50:50PM -0700, Matthew Wilcox wrote:
> > > Sure, but that's not really what I was asking: why isn't this
> > > !uptodate state caught before the page fault code calls
> > > ->page_mkwrite? The page fault code has a reference to the page,
> > > after all, and in a couple of paths it even has the page locked.
> > 
> > If there's already a PTE present, then the page fault code doesn't
> > check the uptodate bit.  Here's the path I'm looking at:
> > 
> > do_wp_page()
> >  -> vm_normal_page()
> >  -> wp_page_shared()
> >      -> do_page_mkwrite()
> > 
> > I don't see anything in there that checked Uptodate.
> 
> Yup, exactly the code I was looking at when I asked this question.
> The kernel has invalidated the contents of a page, yet we still have
> it mapped into userspace as containing valid contents, and we don't
> check it at all when userspace generates a protection fault on the
> page?

Right.  The iomap error path only clears PageUptodate.  It doesn't go
to the effort of unmapping the page from userspace, so userspace has a
read-only view of a !Uptodate page.

> > I think the iomap code is the only filesystem which clears PageUptodate
> > on errors. 
> 
> I don't think you looked very hard. A quick scan shows at least
> btrfs, f2fs, hostfs, jffs2, reiserfs, vboxfs and anything using the
> iomap path will call ClearPageUptodate() on a write IO error.

I'll give you btrfs and jffs2, but I don't think it's true for f2fs.
The only other filesystem using the iomap bufferd IO paths today
is zonefs, afaik.

