Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC26AC784
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 17:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjCFQSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 11:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjCFQRw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:17:52 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F741B57
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 08:14:47 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 326GCEQa019871
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 11:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678119138; bh=xNCYCjbNcx4GryX+Nljoml3TBmyYXYge/KdLA85oJbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=BT3xMq1wn8LiY2rpGYSEmAn7d5Mym1ZiyMWPanTegjuE2fVi0AAUvwPIB9SEl18N5
         9U795pn6zor9z/uGM4+uLahEXJXrNYgmDPKFh7ciOodnhNlPH75Gfafe+IwQjFH3sL
         jX6ODjLybKgwuXonsqQqZJylsmLv4E0ApI4wncgk9ReFFqAMeEW0xVjQHxHSZYUY5k
         nCbjCKjpEFmp9AJc7Z1h5sLNjojsYNTlDhjnfJHn9pNBDeCu8bTqdC8toB+WSCMSJT
         Lw32wb+kA02nUc/y/xhb2vXeszGwcL7VCsauWTl+o++ji+DuCxG5pABUX5FrcSHe8J
         j2CN6SWFRWMKw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3A83015C33A8; Mon,  6 Mar 2023 11:12:14 -0500 (EST)
Date:   Mon, 6 Mar 2023 11:12:14 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <20230306161214.GB959362@mit.edu>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
 <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
 <ZAN2HYXDI+hIsf6W@casper.infradead.org>
 <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
 <ZAOF3p+vqA6pd7px@casper.infradead.org>
 <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
 <ZAWi5KwrsYL+0Uru@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAWi5KwrsYL+0Uru@casper.infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 06, 2023 at 08:23:00AM +0000, Matthew Wilcox wrote:
> 
> All current filesystems that I'm aware of require their fs block size
> to be >= LBA size.  That is, you can't take a 512-byte blocksize ext2
> filesystem and put it on a 4kB LBA storage device.
> 
> That means that files can only grow/shrink in 256MB increments.  I
> don't think that amount of wasted space is going to be acceptable.
> So if we're serious about going down this path, we need to tell
> filesystem people to start working out how to support fs block
> size < LBA size.
> 
> That's a big ask, so let's be sure storage vendors actually want
> this.  Both supporting zoned devices & suporting 16k/64k block
> sizes are easier asks.

What HDD vendors want is to be able to have 32k or even 64k *physical*
sector sizes.  This allows for much more efficient erasure codes, so
it will increase their byte capacity now that it's no longer easier to
get capacity boosts by squeezing the tracks closer and closer, and
their have been various engineering tradeoffs with SMR, HAMR, and
MAMR.  HDD vendors have been asking for this at LSF/MM, and in other
venues for ***years***.

This doesn't necessarily mean that the *logical* sector size needs to
be larger.  What I could imagine that HDD vendors could do is to
create HDD disks with, say, a 4k logical block size and a 32k physical
sector size.  This means that 4k random writes will require
read/modify/write cycles, which isn't great from a performance
performance.  However, for those customers who are using raw block
devices for their cluster file system, and for those customers who are
willing to, say, use ext4 with a 4k block size and a 32k cluster size
(using the bigalloc feature), all of the data blocks would be 32k
aligned, and this would work without any modifications.

I suspect that if these drives were made available, this would allow
for a gradual transition to support larger block sizes.  The file
system level changes aren't *that* hard.  There is a chicken and egg
situation here; until these drives are generally available, the
incentive to do the work is minimal.  But with a 4k logical, 32k or
64k physical sector size, we can gradually improve our support for
these file systems with block size > page size, with cluster size >
page size being an intermediate step that would work today.

Cheers,

					- Ted
