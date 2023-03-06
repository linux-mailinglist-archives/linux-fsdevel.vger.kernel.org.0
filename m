Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750856AB823
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 09:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCFIXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 03:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCFIXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:23:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22886976D;
        Mon,  6 Mar 2023 00:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=De7UoAg6L10EIApbR8j9lQJmaBA4wNwgXFUakJ10PZM=; b=o9lm7UJZKoGq2QDs2J0BgyJo60
        qStPvdSQvgqFd3M2doU48cXMWoMaqUkc/4KyMHX+IbL2OlgQ/hLM/gWWkNAh3Jywn8QdlNMImTGK2
        kaA5qf0tybsarAnhtqUwNDDz0WoIhyP66MKZOlniWauNzOKYZWnmFQb48cn6+oz9JNMl53I3cY022
        zVmQLlueeHNOXPplS/4ph23nGo9acTbaVnHdvGTnWz8Ky001pwvfXnltp72eI2TE/bhPRfz7soAPN
        AFfkBfnvkEFIBc1EPSiSSLNuQcN9fgJyYfj8h7excWAVMi08xqzkK8/ghq70NG/zOFHMof5jj5u6a
        mfu0uI0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZ67Y-005AKn-9z; Mon, 06 Mar 2023 08:23:00 +0000
Date:   Mon, 6 Mar 2023 08:23:00 +0000
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
Message-ID: <ZAWi5KwrsYL+0Uru@casper.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
 <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
 <ZAN2HYXDI+hIsf6W@casper.infradead.org>
 <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
 <ZAOF3p+vqA6pd7px@casper.infradead.org>
 <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 05, 2023 at 12:22:15PM +0100, Hannes Reinecke wrote:
> On 3/4/23 18:54, Matthew Wilcox wrote:
> > I think we're talking about different things (probably different storage
> > vendors want different things, or even different people at the same
> > storage vendor want different things).
> > 
> > Luis and I are talking about larger LBA sizes.  That is, the minimum
> > read/write size from the block device is 16kB or 64kB or whatever.
> > In this scenario, the minimum amount of space occupied by a file goes
> > up from 512 bytes or 4kB to 64kB.  That's doable, even if somewhat
> > suboptimal.
> > 
> And so do I. One can view zones as really large LBAs.
> 
> Indeed it might be suboptimal from the OS point of view.
> But from the device point of view it won't.
> And, in fact, with devices becoming faster and faster the question is
> whether sticking with relatively small sectors won't become a limiting
> factor eventually.
> 
> > Your concern seems to be more around shingled devices (or their equivalent
> > in SSD terms) where there are large zones which are append-only, but
> > you can still random-read 512 byte LBAs.  I think there are different
> > solutions to these problems, and people are working on both of these
> > problems.
> > 
> My point being that zones are just there because the I/O stack can only deal
> with sectors up to 4k. If the I/O stack would be capable of dealing
> with larger LBAs one could identify a zone with an LBA, and the entire issue
> of append-only and sequential writes would be moot.
> Even the entire concept of zones becomes irrelevant as the OS would
> trivially only write entire zones.

All current filesystems that I'm aware of require their fs block size
to be >= LBA size.  That is, you can't take a 512-byte blocksize ext2
filesystem and put it on a 4kB LBA storage device.

That means that files can only grow/shrink in 256MB increments.  I
don't think that amount of wasted space is going to be acceptable.
So if we're serious about going down this path, we need to tell
filesystem people to start working out how to support fs block
size < LBA size.

That's a big ask, so let's be sure storage vendors actually want
this.  Both supporting zoned devices & suporting 16k/64k block
sizes are easier asks.
