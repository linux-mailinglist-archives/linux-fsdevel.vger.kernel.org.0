Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CDF6AA566
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 00:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjCCXJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 18:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjCCXJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:09:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB72DF74D;
        Fri,  3 Mar 2023 15:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=idhjeImW2x4WSmgXwGQh1eQ5mm6+wa13qu5LRlgfpnQ=; b=Xup5Yqvv5hPoglL9giPHFQRJ+X
        opxPYoziOD5gF3xKtZO2z60fGVLexvq/35K4GUmVl1zjLnl1VJNcyQCOAnEMCw2SPYRU8ztYQ1xBN
        Wd09yO9i0JBSsdkzoyFUhWFM7e8psQiZTrFVD0qQ2Szw8THXF2kbhYTbowyR7R0JwEbRK4JuURgXA
        U+a5rmLB3bxAc653/ez1Io2N/QTHnYLNDd54wz3ygwsscZxh3ACHarLbWwkmy+8IgMU7crmq6JFZa
        85Pi0ElDLwWYO/vnPVOkX+ckXlnltF1DDLdFuSmms3ADh+cT9dfT5KTy75DXOSapcMP94va4EkM9w
        Qetat49Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYEWV-007mVT-Hd; Fri, 03 Mar 2023 23:09:11 +0000
Date:   Fri, 3 Mar 2023 15:09:11 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAJ+Fy2wgcrI4tC6@bombadil.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
 <ZAJvu2hZrHu816gj@kbusch-mbp.dhcp.thefacebook.com>
 <ZAJxX2u4CbgVpNNN@bombadil.infradead.org>
 <ZAJ1aLWsir73bA1p@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAJ1aLWsir73bA1p@kbusch-mbp.dhcp.thefacebook.com>
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

On Fri, Mar 03, 2023 at 03:32:08PM -0700, Keith Busch wrote:
> On Fri, Mar 03, 2023 at 02:14:55PM -0800, Luis Chamberlain wrote:
> > On Fri, Mar 03, 2023 at 03:07:55PM -0700, Keith Busch wrote:
> > > On Fri, Mar 03, 2023 at 01:45:48PM -0800, Luis Chamberlain wrote:
> > > > 
> > > > You'd hope most of it is left to FS + MM, but I'm not yet sure that's
> > > > quite it yet. Initial experimentation shows just enabling > PAGE_SIZE
> > > > physical & logical block NVMe devices gets brought down to 512 bytes.
> > > > That seems odd to say the least. Would changing this be an issue now?
> > > 
> > > I think you're talking about removing this part:
> > > 
> > > ---
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index c2730b116dc68..2c528f56c2973 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -1828,17 +1828,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
> > >  	unsigned short bs = 1 << ns->lba_shift;
> > >  	u32 atomic_bs, phys_bs, io_opt = 0;
> > >  
> > > -	/*
> > > -	 * The block layer can't support LBA sizes larger than the page size
> > > -	 * yet, so catch this early and don't allow block I/O.
> > > -	 */
> > > -	if (ns->lba_shift > PAGE_SHIFT) {
> > > -		capacity = 0;
> > > -		bs = (1 << 9);
> > > -	}
> > > -
> > >  	blk_integrity_unregister(disk);
> > > -
> > >  	atomic_bs = phys_bs = bs;
> > 
> > Yes, clearly it says *yet* so that begs the question what would be
> > required?
> 
> Oh, gotcha. I'll work on a list of places it currently crashes.

Awesome that then is part of our dirty laundry TODO for NVMe for larger IO.

> > Also, going down to 512 seems a bit dramatic, so why not just match the
> > PAGE_SIZE so 4k? Would such a comprmise for now break some stuff?
> 
> The capacity set to zero ensures it can't be used through the block stack, so
> the logical block size limit is unused.

Oh OK so in effect we won't have compat issues if we decide later to
change this. So block devices just won't be cabable of working? That
save me tons of tests.

> 512 is just a default value. We only
> bring up the handle so you can administrate it with passthrough commands.

So we'd use 512 for passthrough, but otherwise it won't work ?

  Luis
