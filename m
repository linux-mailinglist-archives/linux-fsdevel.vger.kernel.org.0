Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824026E29EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 20:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjDNSPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 14:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDNSPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:15:36 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A729005
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 11:14:51 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id ks30so2098524qvb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 11:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681496090; x=1684088090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nJQ/Y9J49ZegPKB8YDx6kUTeaR5VGKNsyTpo7amzJY=;
        b=KVkCocFF879gzUg1kucfr6zm8erROSo1fTl8gRt6w1bKJ69GJJ5eKdqPpbS0gi8sWs
         K9mBkfoiNZVvLwLk8GMwJOHOgF0nAiV83JgeDHmSt9pRowQize1m1SvXdlzSq3oKaSjj
         hBW94X7gj3YKXMEHcUduVP1RNVDnFN5Zm2vkdgU2pLE2LQuVq9Z0eoznKMHNPYve2f8I
         NYBdIvTJj/UcKrEtpZUYOJ5U8+Rf3UIAVHI8Gw/UpkQLXKkkgEtEe5KpeyvZeo0v86om
         qBilsbxXvdNUrAKsyxnbQ6zdAtWzpgkXQRF8g5ZNPXW1D0zjIykELPuuleQAeEzXgzUM
         QQfA==
X-Gm-Message-State: AAQBX9ezbTAWRhjTKSBU7HbLcUSlXqFyyNEuL+85IrZT+49k+Ak6r3yg
        sjvEmhHi45+Z68oO6fYhkSeq
X-Google-Smtp-Source: AKy350aBWPFHkYsTqcbjhT+BLekXSdnuSITWMCofPdO8r8eSxwXlme3SBrswbw26osXgHeiptCRusA==
X-Received: by 2002:ad4:5baf:0:b0:5ef:50ea:2914 with SMTP id 15-20020ad45baf000000b005ef50ea2914mr4886152qvq.22.1681496090079;
        Fri, 14 Apr 2023 11:14:50 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id fb9-20020ad44f09000000b005e9a1409458sm1277586qvb.71.2023.04.14.11.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:14:49 -0700 (PDT)
Date:   Fri, 14 Apr 2023 14:14:48 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Joe Thornber <thornber@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>, sarthakkukreti@google.com,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniil Lunev <dlunev@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v3 2/3] dm: Add support for block provisioning
Message-ID: <ZDmYGO7zPqu5y0HW@redhat.com>
References: <20221229071647.437095-1-sarthakkukreti@chromium.org>
 <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230414000219.92640-3-sarthakkukreti@chromium.org>
 <CAJ0trDbyqoKEDN4kzcdn+vWhx+hk6pTM4ndf-E02f3uT9YZ3Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ0trDbyqoKEDN4kzcdn+vWhx+hk6pTM4ndf-E02f3uT9YZ3Uw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14 2023 at  9:32P -0400,
Joe Thornber <thornber@redhat.com> wrote:

> On Fri, Apr 14, 2023 at 7:52 AM Sarthak Kukreti <sarthakkukreti@chromium.org>
> wrote:
> 
> > Add support to dm devices for REQ_OP_PROVISION. The default mode
> > is to passthrough the request to the underlying device, if it
> > supports it. dm-thinpool uses the provision request to provision
> > blocks for a dm-thin device. dm-thinpool currently does not
> > pass through REQ_OP_PROVISION to underlying devices.
> >
> > For shared blocks, provision requests will break sharing and copy the
> > contents of the entire block.
> >
> 
> I see two issue with this patch:
> 
> i) You use get_bio_block_range() to see which blocks the provision bio
> covers.  But this function only returns
> complete blocks that are covered (it was designed for discard).  Unlike
> discard, provision is not a hint so those
> partial blocks will need to be provisioned too.
> 
> ii) You are setting off multiple dm_thin_new_mapping operations in flight
> at once.  Each of these receives
> the same virt_cell and frees it  when it completes.  So I think we have
> multiple frees occuring?  In addition you also
> release the cell yourself in process_provision_cell().  Fixing this is not
> trivial, you'll need to reference count the cells,
> and aggregate the mapping operation results.
> 
> I think it would be far easier to restrict the size of the provision bio to
> be no bigger than one thinp block (as we do for normal io).  This way dm
> core can split the bios, chain the child bios rather than having to
> reference count mapping ops, and aggregate the results.

I happened to be looking at implementing WRITE_ZEROES support for DM
thinp yesterday and reached the same conclussion relative to it (both
of Joe's points above, for me "ii)" was: the dm-bio-prison-v1 range
locking we do for discards needs work for other types of IO).

We can work to make REQ_OP_PROVISION spanning multiple thinp blocks
possible as follow-on optimization; but in the near-term DM thinp
needs REQ_OP_PROVISION to be split on a thinp block boundary.

This splitting can be assisted by block core in terms of a new
'provision_granularity' (which for thinp, it'd be set to the thinp
blocksize).  But I don't know that we need to go that far (I'm
thinking its fine to have DM do the splitting it needs and only
elevate related code to block core if/when needed in the future).

DM core can take on conditionally imposing its max_io_len() to handle
splitting REQ_OP_PROVISION as needed on a per-target basis. This DM
core commit I've staged for 6.4 makes this quite a simple change:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.4&id=13f6facf3faeed34ca381aef4c9b153c7aed3972

So please rebase on linux-dm.git's dm-6.4 branch, and for
REQ_OP_PROVISION dm.c:__process_abnormal_io() you'd add this:

	case REQ_OP_PROVISION:
                num_bios = ti->num_provision_bios;
                if (ti->max_provision_granularity)
                        max_granularity = limits->max_provision_sectors;
                break;

I'll reply again later today (to patch 2's actual code changes),
because I caught at least one other thing worth mentioning.

Thanks,
Mike
