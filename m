Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B501757384E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 16:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbiGMOES (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 10:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbiGMOEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:04:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7500330F62;
        Wed, 13 Jul 2022 07:04:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 329CAB81FC6;
        Wed, 13 Jul 2022 14:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0153C34114;
        Wed, 13 Jul 2022 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657721049;
        bh=ZAU0L5kK4Sf9McbG926Hj/XUT0R01MpGmbcgsJYk0eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JfznMmDaQH8d32YdV1e+uqSCeYmXGCrB04FZaz89S34KHt+hYUNSByGZqfuyt8WaJ
         OXEs5vq9mIuJZVjZSfiO3VQGq17tu956YqCQYKrTviTMbGlc/FmaBatE1ij2Un8cJu
         ma92AqTrKLaKbwKsTf3ddF93RILXggb102oGrWXD7NNZjvJ0hxyvCPlaUMGd3Ubtz/
         P+fi5Q43yiUn4WjZ/LMf/PljTOCIuc0JYEQpQedQnEJpRE9jzeed85Y7qufijypS2/
         Q46HfTgC5K/9xlwN6PWBZk/CAVeoGTHOEELqfB+2XjR98j1PjCER8gYkAAQGulFCBe
         XpJ/yVKe1IYTA==
Date:   Wed, 13 Jul 2022 08:04:03 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>, "hch@lst.de" <hch@lst.de>,
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
Message-ID: <Ys7Q020ELE80OL+X@kbusch-mbp.dhcp.thefacebook.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
 <5ffe57d3-354c-eabe-ea38-9c4201c13970@nvidia.com>
 <Ys639LsjBUGPNErd@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys639LsjBUGPNErd@casper.infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 13, 2022 at 01:17:56PM +0100, Matthew Wilcox wrote:
> The firmware needs to prove to me that it *did something*.  That it
> actually read those bytes that it claims to have verified.  The simplest
> way to do so is to calculate a hash over the blocks which were read
> (maybe the host needs to provide a nonce as part of the VERIFY command
> so the drive can't "remember" the checksum).

From a protocol perspective, NVMe's verify command currently leaves 8-bytes in
the response unused, so this could be a reasonable way to return something like
a crc64 of the verified blocks. The verify command starts at an arbitrary block
and spans an arbitrary number of them, so I think a device "remembering" all
possible combinations as a way to cheat may be harder than just doing the work
:).

But this is just theoretical; it'd be some time before we'd see devices
supporting such a scheme, assuming there's support from the standards
committees.
