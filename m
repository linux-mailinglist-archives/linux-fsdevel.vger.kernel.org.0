Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9B2573632
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 14:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbiGMMSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 08:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGMMSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:18:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1886DA238F;
        Wed, 13 Jul 2022 05:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WgehCo4EWz54AyF2jDUuG0Xj0H/FjQtWvzeLouBbzy8=; b=hiFqFuAZ+D4oDZkdGrk3mNwzMD
        RIy2FWRD01ImOMohxZ8m+oSnAnrZugKZCrbRbuLAfgfm93CUmmSdIq/4hwbRAbDr0ukKJWTnGpHXR
        iQ1Tr4QcsDokLiSOoXImkKWeQz3d51T3UJX1Uhw8xWnu1KOCxOaCG3ndxI3FniFiEWESfF1YjfWv0
        xpqgBJ67IfhYi0ILfNdc7DxI3lJNsEeE75sm/g4LS9TGlCHw3D9nhrwHl1znFQNqekPD1rNs6qWMf
        +YTEq1Cvs1rFBavrhFCxNokpBT1AY4DDVYumygqVZ6vgUL/WHbSkJ6TWJqHGUr13Wu+sIJDCDql6d
        ZbukAvMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBbJU-008AhI-St; Wed, 13 Jul 2022 12:17:56 +0000
Date:   Wed, 13 Jul 2022 13:17:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Message-ID: <Ys639LsjBUGPNErd@casper.infradead.org>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
 <5ffe57d3-354c-eabe-ea38-9c4201c13970@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ffe57d3-354c-eabe-ea38-9c4201c13970@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 13, 2022 at 09:14:42AM +0000, Chaitanya Kulkarni wrote:
> On 7/6/22 10:42, Matthew Wilcox wrote:
> > On Thu, Jun 30, 2022 at 02:14:00AM -0700, Chaitanya Kulkarni wrote:
> >> This adds support for the REQ_OP_VERIFY. In this version we add
> > 
> > IMO, VERIFY is a useless command.  The history of storage is full of
> > devices which simply lie.  Since there's no way for the host to check if
> > the device did any work, cheap devices may simply implement it as a NOOP.
> 
> Thanks for sharing your feedback regarding cheap devices.
> 
> This falls outside of the scope of the work, as scope of this work is
> not to analyze different vendor implementations of the verify command.

The work is pointless.  As a customer, I can't ever use the VERIFY
command because I have no reason for trusting the outcome.  And there's
no way for a vendor to convince me that I should trust the result.

> > Even expensive devices where there's an ironclad legal contract between
> > the vendor and customer may have bugs that result in only some of the
> > bytes being VERIFYed.  We shouldn't support it.
> This is not true with enterprise SSDs, I've been involved with product
> qualification of the high end enterprise SSDs since 2012 including good
> old non-nvme devices with e.g. skd driver on linux/windows/vmware.

Oh, I'm sure there's good faith at the high end.  But bugs happen in
firmware, and everybody knows it.

> > Now, everything you say about its value (not consuming bus bandwidth)
> > is true, but the device should provide the host with proof-of-work.
> 
> Yes that seems to be missing but it is not a blocker in this work since
> protocol needs to provide this information.

There's no point in providing access to a feature when that feature is
not useful.

> We can update the respective specification to add a log page which
> shows proof of work for verify command e.g.
> A log page consist of the information such as :-
> 
> 1. How many LBAs were verified ? How long it took.
> 2. What kind of errors were detected ?
> 3. How many blocks were moved to safe location ?
> 4. How much data (LBAs) been moved successfully ?
> 5. How much data we lost permanently with uncorrectible errors?
> 6. What is the impact on the overall size of the storage, in
>     case of flash reduction in the over provisioning due to
>     uncorrectible errors.

That's not proof of work.  That's claim of work.

> > I'd suggest calculating some kind of checksum, even something like a
> > SHA-1 of the contents would be worth having.  It doesn't need to be
> > crypto-secure; just something the host can verify the device didn't spoof.
> 
> I did not understand exactly what you mean here.

The firmware needs to prove to me that it *did something*.  That it
actually read those bytes that it claims to have verified.  The simplest
way to do so is to calculate a hash over the blocks which were read
(maybe the host needs to provide a nonce as part of the VERIFY command
so the drive can't "remember" the checksum).
