Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F76462DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Dec 2022 21:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiLGUxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Dec 2022 15:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiLGUww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:52:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D478139F;
        Wed,  7 Dec 2022 12:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UORhhcQqOaIvpRwHi0DMFterbhwvG2EXcBZ82YBwQMU=; b=HB0cbntyJzwuDFdxDCnp+Vlwhk
        tSONA7EaFAT9b+ZkRhi8SCpbuaWYeyV5dX92dXFFQy0XLTwjZ8b+qZwY47nxK7r2JS3AhDY/Y2q18
        YQWeVOWuZLc56HAj71ksdMyTmxK6OQToCGUwu1P6WxiBWym+wp+/POSm1HgoJ8F5etqzNTjvaY9bB
        oumvoTFfM93KB+IZtwPw2qExrWTiQawM9qjY/9m+jEcmlrXCaa4To5UgSUoi6LVA0YsHiwMLJcwMm
        Txs6DUb29cPIuy/ivStLtb5yUJUpwXE8cCLBgzfJaZSs2U6XAo+6S6gBoGM5zgOeszjBtmgcza8E+
        ms0w9KNw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p31Np-00CLcf-VD; Wed, 07 Dec 2022 20:51:14 +0000
Date:   Wed, 7 Dec 2022 12:51:13 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, fengnanchang@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        vishal.moola@gmail.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH] f2fs: Support enhanced hot/cold data separation for f2fs
Message-ID: <Y5D8wYGpp/95ShTV@bombadil.infradead.org>
References: <Y4ZaBd1r45waieQs@casper.infradead.org>
 <20221130124804.79845-1-frank.li@vivo.com>
 <Y4d0UReDb+EmUJOz@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4d0UReDb+EmUJOz@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 30, 2022 at 03:18:41PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 30, 2022 at 08:48:04PM +0800, Yangtao Li wrote:
> > Hi,
> > 
> > > Thanks for reviewing this.  I think the real solution to this is
> > > that f2fs should be using large folios.  That way, the page cache
> > > will keep track of dirtiness on a per-folio basis, and if your folios
> > > are at least as large as your cluster size, you won't need to do the
> > > f2fs_prepare_compress_overwrite() dance.  And you'll get at least fifteen
> > > dirty folios per call instead of fifteen dirty pages, so your costs will
> > > be much lower.
> > >
> > > Is anyone interested in doing the work to convert f2fs to support
> > > large folios?  I can help, or you can look at the work done for XFS,
> > > AFS and a few other filesystems.
> > 
> > Seems like an interesting job. Not sure if I can be of any help.
> > What needs to be done currently to support large folio?
> > 
> > Are there any roadmaps and reference documents.
> 
> >From a filesystem point of view, you need to ensure that you handle folios
> larger than PAGE_SIZE correctly.  The easiest way is to spread the use
> of folios throughout the filesystem.  For example, today the first thing
> we do in f2fs_read_data_folio() is convert the folio back into a page.
> That works because f2fs hasn't told the kernel that it supports large
> folios, so the VFS won't create large folios for it.
> 
> It's a lot of subtle things.  Here's an obvious one:
>                         zero_user_segment(page, 0, PAGE_SIZE);
> There's a folio equivalent that will zero an entire folio.
> 
> But then there is code which assumes the number of blocks per page (maybe
> not in f2fs?) and so on.  Every filesystem will have its own challenges.
> 
> One way to approach this is to just enable large folios (see commit
> 6795801366da or 8549a26308f9) and see what breaks when you run xfstests
> over it.  Probably quite a lot!

Me and Pankaj are very interested in helping on this front. And so we'll
start to organize and talk every week about this to see what is missing.
First order of business however will be testing so we'll have to
establish a public baseline to ensure we don't regress. For this we intend
on using kdevops so that'll be done first.

If folks have patches they want to test in consideration for folio /
iomap enhancements feel free to Cc us :)

After we establish a baseline we can move forward with taking on tasks
which will help with this conversion.

[0] https://github.com/linux-kdevops/kdevops

  Luis
