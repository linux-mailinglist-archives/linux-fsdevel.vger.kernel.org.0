Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A71640E06
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 19:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiLBS61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 13:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiLBS6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:58:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07C69C637;
        Fri,  2 Dec 2022 10:58:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CB0B61CD9;
        Fri,  2 Dec 2022 18:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DC5C433D7;
        Fri,  2 Dec 2022 18:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670007501;
        bh=HOh3Cp0n7LazD+GQRWKmIbl4e99o0522H/+1Wb/zFpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jueI8u5WzpHJXBCeK/s4VvCOnYb+rztUFEYYWKB4165BfMWRW5GyhTygwbxjm2WX0
         Tx8XueKkLaPFVj+VRFYDOK3LRCtzyrpkwJzIkOr/sv/sOQtsjS3Ar1m+++x5tnsxCW
         kCUvTXgv909+I5LfeYCwXjff5eR6WT8Ipxpjy2kg1EnYL8tZSoOwqnP4Q5p//pzfuB
         O1aQIP2YphtTLJMj4IU/3JpUAfxOOISMMi9L2O6aWaJghElC+tyWIOxlKB1SY83zid
         MWFT3KMYEK0NF74IvZMbByMQ4JX+6x3gDGn7JQeV9V2rUZh9f8qCiuoIgJBXRcWBbK
         X2gsRBM/jCbrw==
Date:   Fri, 2 Dec 2022 11:58:17 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Clay Mayers <Clay.Mayers@kioxia.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <Y4pKySy9Wi2ULEOU@kbusch-mbp.dhcp.thefacebook.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
 <d14fe396-b39b-6b3e-ae74-eb6a8b64e379@nvidia.com>
 <Y4kC9NIXevPlji+j@casper.infradead.org>
 <72a51a83-c25a-ef52-55fb-2b73aec70305@suse.de>
 <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
 <f68009b7cc744c02ad69d68fd7e61751@kioxia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f68009b7cc744c02ad69d68fd7e61751@kioxia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 02, 2022 at 05:33:33PM +0000, Clay Mayers wrote:
> > 
> > As long as the protocols don't provide proof-of-work, trying this
> > doesn't really prove anything with respect to this concern.
> 
> I'm out of my depth here, but isn't VERIFY tightly related to PI and
> at the heart of detecting SAN bit-rot? The proof of work can be via
> end-to-end data protection. VERIFY has to actually read to detect bad
> host generated PI guard/tags.  I'm assuming the PI checks can be
> disabled for WRITE and enabled for VERIFY as the test.

I suppose if you happen to have a PI formatted drive, you could WRITE
garbage Guard tags with PRCHK disabled, then see if VERIFY with PRCHK
enabled returns the Guard Check Error; but PI is an optional format
feature orthogonal to the VERIFY command: we can't count on that format
being available in most implementations.
