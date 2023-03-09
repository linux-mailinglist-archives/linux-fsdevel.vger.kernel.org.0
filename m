Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506A36B2645
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 15:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjCIOH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 09:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjCIOGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:06:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77CB18A86;
        Thu,  9 Mar 2023 06:05:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 700F5B81EED;
        Thu,  9 Mar 2023 14:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD33C433D2;
        Thu,  9 Mar 2023 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678370738;
        bh=xJ7YPrTfTthbYoyo8UtH2onMzmwtgbsrsuyUa9lXPAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dmztQVg5CIS8T690ZZtBtC6IlnrcP7PqLeuT8DjrijPjpNg2SxZAeYmM5PzoNc/H7
         er5fix33obktnrmBYc0X7CA59basYJ3ltJEGA2F9wjpLFMSHBpI6UMGjKnwvbHUTGd
         FTkFktQ8RRAfqly2xui9EyDGPOQO6oUnUl3MJL+sDEvOmA42HcAk8Ph7PxFqXQXnwF
         9381JT3MVOZOc8GalYXITxcLggI5BOSU6t/DLTQOnaUWTzuJhNJBFSutu+mtQ3rd9/
         EkCczClEm5xdnnfmLqC1Sfp8FcJtsSgB5i+d+JwRU6vtDg7lkb2Bkd+YItg3+d6c4r
         VwqmtL+h0w4fg==
Date:   Thu, 9 Mar 2023 07:05:34 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Hannes Reinecke <hare@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAnnrhUG1B+r1nd0@kbusch-mbp.dhcp.thefacebook.com>
References: <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
 <ZAOF3p+vqA6pd7px@casper.infradead.org>
 <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
 <ZAWi5KwrsYL+0Uru@casper.infradead.org>
 <20230306161214.GB959362@mit.edu>
 <ZAjLhkfRqwQ+vkHI@casper.infradead.org>
 <CGME20230308181355eucas1p1c94ffee59e210fb762540c888e8eae8a@eucas1p1.samsung.com>
 <1367983d4fa09dcb63e29db2e8be3030ae6f6e8c.camel@HansenPartnership.com>
 <20230309080434.tnr33rhzh3a5yc5q@ArmHalley.local>
 <260064c68b61f4a7bc49f09499e1c107e2a28f31.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <260064c68b61f4a7bc49f09499e1c107e2a28f31.camel@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 08:11:35AM -0500, James Bottomley wrote:
> On Thu, 2023-03-09 at 09:04 +0100, Javier González wrote:
> > FTL designs are complex. We have ways to maintain sector sizes under
> > 64 bits, but this is a common industry problem.
> > 
> > The media itself does not normally oeprate at 4K. Page siges can be
> > 16K, 32K, etc.
> 
> Right, and we've always said if we knew what this size was we could
> make better block write decisions.  However, today if you look what
> most NVMe devices are reporting, it's a bit sub-optimal:

Your sample size may be off if your impression is that "most" NVMe drives
report themselves this way. :)
 
> jejb@lingrow:/sys/block/nvme1n1/queue> cat logical_block_size 
> 512
> jejb@lingrow:/sys/block/nvme1n1/queue> cat physical_block_size 
> 512
> jejb@lingrow:/sys/block/nvme1n1/queue> cat optimal_io_size 
> 0
> 
> If we do get Linux to support large block sizes, are we actually going
> to get better information out of the devices?
> 
> >  Increasing the block size would allow for better host/device
> > cooperation. As Ted mentions, this has been a requirement for HDD and
> > SSD vendor for years. It seems to us that the time is right now and
> > that we have mechanisms in Linux to do the plumbing. Folios is
> > ovbiously a big part of this.
> 
> Well a decade ago we did a lot of work to support 4k sector devices.
> Ultimately the industry went with 512 logical/4k physical devices
> because of problems with non-Linux proprietary OSs but you could still
> use 4k today if you wanted (I've actually still got a working 4k SCSI
> drive), so why is no NVMe device doing that?

In my experience, all but the cheapest consumer grade nvme devices report 4k
logical. They all support an option to emulate 512b if you really wanted it to,
but the more optimal 4k is the most common default for server grade nvme.
