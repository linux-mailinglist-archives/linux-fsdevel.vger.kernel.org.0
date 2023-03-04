Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B606AABF4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 19:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCDSyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 13:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCDSyJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 13:54:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCACEC43;
        Sat,  4 Mar 2023 10:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=984jR9dtStLaR+Q4kubSGdxGmWkaN30VLd4vb6GjFxo=; b=PYJir0+ov/KzFoDCR1jzLGMTnm
        W/fl5KsmclZ4qatDVpdCuBXzF+lw9GiezEloMyKZdirGAIEmy0FvPT8clvIC7PVmg4ofjYDiUWa6t
        HwYqzzmZqGebXE7Pb/JnNI9MWVgC69zL4CxdxCvAK2pJcz3JHN+e34ZHv1o5owilwJ9WPaBEF86fg
        YczLJI/TnT0oAt3PzwS9C8Cjl9NdFBZM1VjGPHemR7o7jBSlCXh9UY4iRqhCHYt8ihGq2n9PEPgCD
        XROTsKd3/2Q2IdYkJZEzD4C+hqvcl6bf3UjoBovKQYdvC61u0U4LooNSbTQPJhuqXfM+g6mK8ogoK
        9cIFkF/A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYX0t-009QS7-Sy; Sat, 04 Mar 2023 18:53:47 +0000
Date:   Sat, 4 Mar 2023 10:53:47 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Klaus Jensen <its@irrelevant.dk>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAOTu5qk+ax88+d9@bombadil.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
 <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
 <ZAN2HYXDI+hIsf6W@casper.infradead.org>
 <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
 <ZAOF3p+vqA6pd7px@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAOF3p+vqA6pd7px@casper.infradead.org>
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

On Sat, Mar 04, 2023 at 05:54:38PM +0000, Matthew Wilcox wrote:
> On Sat, Mar 04, 2023 at 06:17:35PM +0100, Hannes Reinecke wrote:
> > On 3/4/23 17:47, Matthew Wilcox wrote:
> > > On Sat, Mar 04, 2023 at 12:08:36PM +0100, Hannes Reinecke wrote:
> > > > We could implement a (virtual) zoned device, and expose each zone as a
> > > > block. That gives us the required large block characteristics, and with
> > > > a bit of luck we might be able to dial up to really large block sizes
> > > > like the 256M sizes on current SMR drives.
> > > > ublk might be a good starting point.
> > > 
> > > Ummmm.  Is supporting 256MB block sizes really a desired goal?  I suggest
> > > that is far past the knee of the curve; if we can only write 256MB chunks
> > > as a single entity, we're looking more at a filesystem redesign than we
> > > are at making filesystems and the MM support 256MB size blocks.
> > > 
> > Naa, not really. It _would_ be cool as we could get rid of all the cludges
> > which have nowadays re sequential writes.
> > And, remember, 256M is just a number someone thought to be a good
> > compromise. If we end up with a lower number (16M?) we might be able
> > to convince the powers that be to change their zone size.
> > Heck, with 16M block size there wouldn't be a _need_ for zones in
> > the first place.
> > 
> > But yeah, 256M is excessive. Initially I would shoot for something
> > like 2M.
> 
> I think we're talking about different things (probably different storage
> vendors want different things, or even different people at the same
> storage vendor want different things).
> 
> Luis and I are talking about larger LBA sizes.  That is, the minimum
> read/write size from the block device is 16kB or 64kB or whatever.
> In this scenario, the minimum amount of space occupied by a file goes
> up from 512 bytes or 4kB to 64kB.  That's doable, even if somewhat
> suboptimal.

Yes.

> Your concern seems to be more around shingled devices (or their equivalent
> in SSD terms) where there are large zones which are append-only, but
> you can still random-read 512 byte LBAs.  I think there are different
> solutions to these problems, and people are working on both of these
> problems.
> 
> But if storage vendors are really pushing for 256MB LBAs, then that's
> going to need a third kind of solution, and I'm not aware of anyone
> working on that.

Hannes had replied to my suggestion about a way to *virtualize* *optimally*
a real storage controller with larger LBA, in that thread I was hinting to 
avoid using on the hypervisor cache=passthrough and instead use something
like cache=writeback or even cache=unsafe for experimentation for
virtio-blk-pci. For a more elaborate description of these see [0] but the
skinny is cache=writeback uses the host stroage controller while the
other rely on the host page cache.

The overhead of latencies incurred by anything to replicate larger LBAs
should be mitigated, so I don't think using a zone storage zone for it
would be good.

I was asking whether or not experimenting with a different host page cache
PAGE_SIZE might help replicate things more a bit realistically, even if
if was suboptimal for the host for the reasons previously noted as stupid.

If sticking to PAGE_SIZE on the host another idea may be to use tmpfs +
huge pages so to at least mitigate TLB lookups.

[0] https://github.com/linux-kdevops/kdevops/commit/94844c4684a51997cb327d2fb0ce491fe4429dfc

  Luis
