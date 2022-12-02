Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4ED6408D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 15:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiLBO6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 09:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbiLBO6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:58:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C496010E4;
        Fri,  2 Dec 2022 06:58:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AFBC622DB;
        Fri,  2 Dec 2022 14:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85441C433D6;
        Fri,  2 Dec 2022 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669993101;
        bh=/n5CLN7ON3ycvsyEi1YxKOhSSwA+7yJQAUZB1mnM43M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLW0hD+C9SLzRYcnnlslZYKphSt6MEcrihJeqdPpaJqTSgTHwpwCUV+1K4ySL51iI
         zwZnFsZstRt/oSuTBO2XFUPYkY64e0lrv2BoJFAwCHsrL3Sghpaqm2jkhbusu2UmvU
         L/pTsacxpT1DBAz36cESjdsRiQHtomfdRR9TEe707Cnv0BpwVQaQ4fFgOoGRPrwjoR
         p+0Zc73/Pw/hXzl+y8PuQrVRHcfZhA+DjhmKa1k+0sj8qD7jELK8hHYqoVBkWygG7V
         f1UQYT8rEc62M9Q/BTjYXZIsFJC7aXrqJX8DY/uv65a0YnMRw0fryjCHbkDqWgEb4n
         7P7XZYU+Tn6Mg==
Date:   Fri, 2 Dec 2022 07:58:16 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
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
Message-ID: <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
 <d14fe396-b39b-6b3e-ae74-eb6a8b64e379@nvidia.com>
 <Y4kC9NIXevPlji+j@casper.infradead.org>
 <72a51a83-c25a-ef52-55fb-2b73aec70305@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72a51a83-c25a-ef52-55fb-2b73aec70305@suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 02, 2022 at 08:16:30AM +0100, Hannes Reinecke wrote:
> On 12/1/22 20:39, Matthew Wilcox wrote:
> > On Thu, Dec 01, 2022 at 06:12:46PM +0000, Chaitanya Kulkarni wrote:
> > > So nobody can get away with a lie.
> > 
> > And yet devices do exist which lie.  I'm not surprised that vendors
> > vehemently claim that they don't, or "nobody would get away with it".
> > But, of course, they do.  And there's no way for us to find out if
> > they're lying!
> > 
> But we'll never be able to figure that out unless we try.
> 
> Once we've tried we will have proof either way.

As long as the protocols don't provide proof-of-work, trying this
doesn't really prove anything with respect to this concern.
