Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE476B24FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 14:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjCINLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 08:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCINLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:11:43 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F0DD5A7F;
        Thu,  9 Mar 2023 05:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1678367499;
        bh=ximSBdqm11LjZkXc+6xN4CESZDhw1BYjj+9qJ8MzVUs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=IaAgulVrKnAlPv2g9YUwPeVG3kjLr4zTCuiYcy4FOtAtni2DimLGPdtR5RKQ9dKJK
         jYPtl3sQ54MRWe5LuLgedYJOWoh8PnMxRyEoRuEdiDNZs8xiVmfq2xM9oQWduYvOuk
         2HNPfKw28Nm1Hj/0zE+k90F3BQrzSdg3BZIx7kB0=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 116DE1281446;
        Thu,  9 Mar 2023 08:11:39 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pc7NiKohuf7s; Thu,  9 Mar 2023 08:11:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1678367498;
        bh=ximSBdqm11LjZkXc+6xN4CESZDhw1BYjj+9qJ8MzVUs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=jiXbls0PZ6UqDt36GCwKW7X7dFmjNQ5w5Y5aFASfef4wv740Q7UiikJquC3oRPPlm
         LrOWzL7n3TLXBe75VMf8TYwT6F6RrzxfKFsPSNN0tg3gksXItN2iGbgw+vKtBjOVIi
         TA/XaSmNmd0qIi6NBPgovbKdkKMpB8ASv+nZPbZc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B73771280885;
        Thu,  9 Mar 2023 08:11:37 -0500 (EST)
Message-ID: <260064c68b61f4a7bc49f09499e1c107e2a28f31.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Javier =?ISO-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Hannes Reinecke <hare@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Date:   Thu, 09 Mar 2023 08:11:35 -0500
In-Reply-To: <20230309080434.tnr33rhzh3a5yc5q@ArmHalley.local>
References: <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
         <ZAN2HYXDI+hIsf6W@casper.infradead.org>
         <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
         <ZAOF3p+vqA6pd7px@casper.infradead.org>
         <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
         <ZAWi5KwrsYL+0Uru@casper.infradead.org> <20230306161214.GB959362@mit.edu>
         <ZAjLhkfRqwQ+vkHI@casper.infradead.org>
         <CGME20230308181355eucas1p1c94ffee59e210fb762540c888e8eae8a@eucas1p1.samsung.com>
         <1367983d4fa09dcb63e29db2e8be3030ae6f6e8c.camel@HansenPartnership.com>
         <20230309080434.tnr33rhzh3a5yc5q@ArmHalley.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-03-09 at 09:04 +0100, Javier González wrote:
> On 08.03.2023 13:13, James Bottomley wrote:
> > On Wed, 2023-03-08 at 17:53 +0000, Matthew Wilcox wrote:
> > > On Mon, Mar 06, 2023 at 11:12:14AM -0500, Theodore Ts'o wrote:
> > > > What HDD vendors want is to be able to have 32k or even 64k
> > > > *physical* sector sizes.  This allows for much more efficient
> > > > erasure codes, so it will increase their byte capacity now that
> > > > it's no longer easier to get capacity boosts by squeezing the
> > > > tracks closer and closer, and their have been various
> > > > engineering tradeoffs with SMR, HAMR, and MAMR.  HDD vendors
> > > > have been asking for this at LSF/MM, and in othervenues for
> > > > ***years***.
> > > 
> > > I've been reminded by a friend who works on the drive side that a
> > > motivation for the SSD vendors is (essentially) the size of
> > > sector_t. Once the drive needs to support more than 2/4 billion
> > > sectors, they need to move to a 64-bit sector size, so the amount
> > > of memory consumed by the FTL doubles, the CPU data cache becomes
> > > half as effective, etc. That significantly increases the BOM for
> > > the drive, and so they have to charge more.  With a 512-byte LBA,
> > > that's 2TB; with a 4096-byte LBA, it's at 16TB and with a 64k
> > > LBA, they can keep using 32-bit LBA numbers all the way up to
> > > 256TB.
> > 
> > I thought the FTL operated on physical sectors and the logical to
> > physical was done as a RMW through the FTL?  In which case sector_t
> > shouldn't matter to the SSD vendors for FTL management because they
> > can keep the logical sector size while increasing the physical one.
> > Obviously if physical size goes above the FS block size, the drives
> > will behave suboptimally with RMWs, which is why 4k physical is the
> > max currently.
> > 
> 
> FTL designs are complex. We have ways to maintain sector sizes under
> 64 bits, but this is a common industry problem.
> 
> The media itself does not normally oeprate at 4K. Page siges can be
> 16K, 32K, etc.

Right, and we've always said if we knew what this size was we could
make better block write decisions.  However, today if you look what
most NVMe devices are reporting, it's a bit sub-optimal:

jejb@lingrow:/sys/block/nvme1n1/queue> cat logical_block_size 
512
jejb@lingrow:/sys/block/nvme1n1/queue> cat physical_block_size 
512
jejb@lingrow:/sys/block/nvme1n1/queue> cat optimal_io_size 
0

If we do get Linux to support large block sizes, are we actually going
to get better information out of the devices?

>  Increasing the block size would allow for better host/device
> cooperation. As Ted mentions, this has been a requirement for HDD and
> SSD vendor for years. It seems to us that the time is right now and
> that we have mechanisms in Linux to do the plumbing. Folios is
> ovbiously a big part of this.

Well a decade ago we did a lot of work to support 4k sector devices.
Ultimately the industry went with 512 logical/4k physical devices
because of problems with non-Linux proprietary OSs but you could still
use 4k today if you wanted (I've actually still got a working 4k SCSI
drive), so why is no NVMe device doing that?

This is not to say I think larger block sizes is in any way a bad idea
... I just think that given the history, it will be driven by
application needs rather than what the manufacturers tell us.

James

