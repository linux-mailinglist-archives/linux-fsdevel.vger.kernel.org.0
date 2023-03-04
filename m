Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDCD6AABB8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 18:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCDRyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 12:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCDRyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 12:54:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2342412BD1;
        Sat,  4 Mar 2023 09:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AHMBefZAR0nuTytT2m/j2q5aYMqyv8mfg9wTvKpbSsY=; b=p3DDdOtc7ikjBWHog0cMJ9VmJw
        U9UDn0f5o2SxCxUbasMiIlD790WazQJEXKj02kXSBESFTF6fsOQuHYqLk19u15VeFjXB3cTnXpRg5
        6xMCRdErxuQJyhqVrvjz4P2/lVoBF+mWWRXkRGqbrKrWEzDB2i6Z5dh208EMleV8mXu4T0NGbIZWp
        LyqFki2uQca5NINNj1qBfYLT56igzY2nEPnkxhAAZw+Fu0D1N8WVjwaCmz6r3SYCizTb0xU7biwfY
        WKlyI1RGtYoXFv4bQeJyH3Th3WPuviigHy1nGOlDzhhwcOjXjflRNHYw0OOQbd8aK9MHlkJNCwWab
        jA3v7g0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYW5e-003xvk-1x; Sat, 04 Mar 2023 17:54:38 +0000
Date:   Sat, 4 Mar 2023 17:54:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAOF3p+vqA6pd7px@casper.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
 <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
 <ZAN2HYXDI+hIsf6W@casper.infradead.org>
 <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 04, 2023 at 06:17:35PM +0100, Hannes Reinecke wrote:
> On 3/4/23 17:47, Matthew Wilcox wrote:
> > On Sat, Mar 04, 2023 at 12:08:36PM +0100, Hannes Reinecke wrote:
> > > We could implement a (virtual) zoned device, and expose each zone as a
> > > block. That gives us the required large block characteristics, and with
> > > a bit of luck we might be able to dial up to really large block sizes
> > > like the 256M sizes on current SMR drives.
> > > ublk might be a good starting point.
> > 
> > Ummmm.  Is supporting 256MB block sizes really a desired goal?  I suggest
> > that is far past the knee of the curve; if we can only write 256MB chunks
> > as a single entity, we're looking more at a filesystem redesign than we
> > are at making filesystems and the MM support 256MB size blocks.
> > 
> Naa, not really. It _would_ be cool as we could get rid of all the cludges
> which have nowadays re sequential writes.
> And, remember, 256M is just a number someone thought to be a good
> compromise. If we end up with a lower number (16M?) we might be able
> to convince the powers that be to change their zone size.
> Heck, with 16M block size there wouldn't be a _need_ for zones in
> the first place.
> 
> But yeah, 256M is excessive. Initially I would shoot for something
> like 2M.

I think we're talking about different things (probably different storage
vendors want different things, or even different people at the same
storage vendor want different things).

Luis and I are talking about larger LBA sizes.  That is, the minimum
read/write size from the block device is 16kB or 64kB or whatever.
In this scenario, the minimum amount of space occupied by a file goes
up from 512 bytes or 4kB to 64kB.  That's doable, even if somewhat
suboptimal.

Your concern seems to be more around shingled devices (or their equivalent
in SSD terms) where there are large zones which are append-only, but
you can still random-read 512 byte LBAs.  I think there are different
solutions to these problems, and people are working on both of these
problems.

But if storage vendors are really pushing for 256MB LBAs, then that's
going to need a third kind of solution, and I'm not aware of anyone
working on that.
