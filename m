Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735396AA48B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 23:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjCCWgc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 17:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjCCWgG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:36:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20D8A5D2;
        Fri,  3 Mar 2023 14:33:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21D84618E2;
        Fri,  3 Mar 2023 22:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA80C4339C;
        Fri,  3 Mar 2023 22:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677882731;
        bh=YWDLkopnUT96f4fUWZwOykPl42+zKxklVApz3+htIkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E9Fdcjb2ICy24TPzMJ6/8cdDKEO/yOKZMa2yiGLxfswa9Rxe/8PR4dOdbKDmxnyvi
         CzgounENeQs4j6J20mPNsz75wJ2KnxiOaK4Ut/lNOAaM9FV7pRyxeLndY4bzkl9Qxz
         YCxXQFBxPwdOLzcU+Shgv97BopfIWbNRiOZFFgVO+UPp90ix2RGYg+rGlFaW91o2aG
         nB+26y6uCnKObwM31tFXO0++GK3np+tM64m+AqWkSkWRxPrqYyz6u+ayC4UBcPLxQU
         +fm2O6HAbEl48MAwzy3BlFekFagOMVgk7j+z5z+ZIdb+/yfsUBNN8kC9AYxj1gXtHo
         m0yfz8AD0Ju/A==
Date:   Fri, 3 Mar 2023 15:32:08 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAJ1aLWsir73bA1p@kbusch-mbp.dhcp.thefacebook.com>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
 <ZAJvu2hZrHu816gj@kbusch-mbp.dhcp.thefacebook.com>
 <ZAJxX2u4CbgVpNNN@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAJxX2u4CbgVpNNN@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 03, 2023 at 02:14:55PM -0800, Luis Chamberlain wrote:
> On Fri, Mar 03, 2023 at 03:07:55PM -0700, Keith Busch wrote:
> > On Fri, Mar 03, 2023 at 01:45:48PM -0800, Luis Chamberlain wrote:
> > > 
> > > You'd hope most of it is left to FS + MM, but I'm not yet sure that's
> > > quite it yet. Initial experimentation shows just enabling > PAGE_SIZE
> > > physical & logical block NVMe devices gets brought down to 512 bytes.
> > > That seems odd to say the least. Would changing this be an issue now?
> > 
> > I think you're talking about removing this part:
> > 
> > ---
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index c2730b116dc68..2c528f56c2973 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1828,17 +1828,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
> >  	unsigned short bs = 1 << ns->lba_shift;
> >  	u32 atomic_bs, phys_bs, io_opt = 0;
> >  
> > -	/*
> > -	 * The block layer can't support LBA sizes larger than the page size
> > -	 * yet, so catch this early and don't allow block I/O.
> > -	 */
> > -	if (ns->lba_shift > PAGE_SHIFT) {
> > -		capacity = 0;
> > -		bs = (1 << 9);
> > -	}
> > -
> >  	blk_integrity_unregister(disk);
> > -
> >  	atomic_bs = phys_bs = bs;
> 
> Yes, clearly it says *yet* so that begs the question what would be
> required?

Oh, gotcha. I'll work on a list of places it currently crashes.
 
> Also, going down to 512 seems a bit dramatic, so why not just match the
> PAGE_SIZE so 4k? Would such a comprmise for now break some stuff?

The capacity set to zero ensures it can't be used through the block stack, so
the logical block size limit is unused. 512 is just a default value. We only
bring up the handle so you can administrate it with passthrough commands.
