Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C77E6B1075
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 18:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCHRx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 12:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCHRx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:53:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AED422D;
        Wed,  8 Mar 2023 09:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r5HUmBD7uXqC5GBdmL5+Ug922V53os294l+QgA1lLLI=; b=dUylDDe8zVqohTKYCh+J7vZELc
        0Tst8j6/bW3q6vDnowkyQ2dqeeJqpSQc5KXZIGhh1uhS4d7pA4Lxm9KhSxTl5fAM6oSx/FpT+EDsc
        Nlbx4uL6QthZ8yZzm2jaknbhMHrbh8cJY3VN/LHAC1mTwkRMEIZVPFHWZKfgz2p/9oCXfar86d5Ou
        m0yzyOWD9Hcc/xCIAFTsm+5711/S9tJ5ZMpDhuwb9CvKU8L10umHdZ8371hH2Ov+S+tbVh566YcMs
        DNO23cIPiBMPsGaE3JZgcYR1FT85POjvJI4lb2/T5V8U4DNc5UisvzqPNu5a06iytSEizvFBcSJr1
        myp1iN9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZxyQ-007b7x-Gj; Wed, 08 Mar 2023 17:53:10 +0000
Date:   Wed, 8 Mar 2023 17:53:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Hannes Reinecke <hare@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAjLhkfRqwQ+vkHI@casper.infradead.org>
References: <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
 <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
 <ZAN2HYXDI+hIsf6W@casper.infradead.org>
 <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
 <ZAOF3p+vqA6pd7px@casper.infradead.org>
 <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
 <ZAWi5KwrsYL+0Uru@casper.infradead.org>
 <20230306161214.GB959362@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306161214.GB959362@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 06, 2023 at 11:12:14AM -0500, Theodore Ts'o wrote:
> What HDD vendors want is to be able to have 32k or even 64k *physical*
> sector sizes.  This allows for much more efficient erasure codes, so
> it will increase their byte capacity now that it's no longer easier to
> get capacity boosts by squeezing the tracks closer and closer, and
> their have been various engineering tradeoffs with SMR, HAMR, and
> MAMR.  HDD vendors have been asking for this at LSF/MM, and in other
> venues for ***years***.

I've been reminded by a friend who works on the drive side that a
motivation for the SSD vendors is (essentially) the size of sector_t.
Once the drive needs to support more than 2/4 billion sectors, they
need to move to a 64-bit sector size, so the amount of memory consumed
by the FTL doubles, the CPU data cache becomes half as effective, etc.
That significantly increases the BOM for the drive, and so they have
to charge more.  With a 512-byte LBA, that's 2TB; with a 4096-byte LBA,
it's at 16TB and with a 64k LBA, they can keep using 32-bit LBA numbers
all the way up to 256TB.
