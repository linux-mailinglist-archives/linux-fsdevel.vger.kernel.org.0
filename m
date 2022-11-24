Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0E9636EAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 01:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiKXAFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 19:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXAFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:05:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F90A1095B1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 16:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669248262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Swuw4Srtq7ILJ+Sr28sVCP8NRm0onxfQ8iNTcMfZrZ0=;
        b=XNHHclPtfi72KQDweZaRIGtA7374nibcudaelapbxDquOh71aJeCwrVD9BbYEida3WeW8U
        AsMhcySKe86vHtReRgNS2b2XcMOyfJ3Fq/DT8dwn1l7J+XIHIAnZXFsqx9vRYjCpLnSV0O
        TI7nui1rkiv4gpJs1qRhbfbFtgjosk4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-eMnJ2nuQPZ63mU3GdK9XLA-1; Wed, 23 Nov 2022 19:04:21 -0500
X-MC-Unique: eMnJ2nuQPZ63mU3GdK9XLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3935F29AB3E1;
        Thu, 24 Nov 2022 00:04:20 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DF81C15BB1;
        Thu, 24 Nov 2022 00:04:03 +0000 (UTC)
Date:   Thu, 24 Nov 2022 08:03:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com, ming.lei@redhat.com
Subject: Re: [PATCH v5 02/10] block: Add copy offload support infrastructure
Message-ID: <Y3607N6lDRK6WU7/@T590>
References: <20221123055827.26996-1-nj.shetty@samsung.com>
 <CGME20221123061017epcas5p246a589e20eac655ac340cfda6028ff35@epcas5p2.samsung.com>
 <20221123055827.26996-3-nj.shetty@samsung.com>
 <Y33UAp6ncSPO84XI@T590>
 <20221123100712.GA26377@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123100712.GA26377@test-zns>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 23, 2022 at 03:37:12PM +0530, Nitesh Shetty wrote:
> On Wed, Nov 23, 2022 at 04:04:18PM +0800, Ming Lei wrote:
> > On Wed, Nov 23, 2022 at 11:28:19AM +0530, Nitesh Shetty wrote:
> > > Introduce blkdev_issue_copy which supports source and destination bdevs,
> > > and an array of (source, destination and copy length) tuples.
> > > Introduce REQ_COPY copy offload operation flag. Create a read-write
> > > bio pair with a token as payload and submitted to the device in order.
> > > Read request populates token with source specific information which
> > > is then passed with write request.
> > > This design is courtesy Mikulas Patocka's token based copy
> > 
> > I thought this patchset is just for enabling copy command which is
> > supported by hardware. But turns out it isn't, because blk_copy_offload()
> > still submits read/write bios for doing the copy.
> > 
> > I am just wondering why not let copy_file_range() cover this kind of copy,
> > and the framework has been there.
> > 
> 
> Main goal was to enable copy command, but community suggested to add
> copy emulation as well.
> 
> blk_copy_offload - actually issues copy command in driver layer.
> The way read/write BIOs are percieved is different for copy offload.
> In copy offload we check REQ_COPY flag in NVMe driver layer to issue
> copy command. But we did missed it to add in other driver's, where they
> might be treated as normal READ/WRITE.
> 
> blk_copy_emulate - is used if we fail or if device doesn't support native
> copy offload command. Here we do READ/WRITE. Using copy_file_range for
> emulation might be possible, but we see 2 issues here.
> 1. We explored possibility of pulling dm-kcopyd to block layer so that we 
> can readily use it. But we found it had many dependecies from dm-layer.
> So later dropped that idea.

Is it just because dm-kcopyd supports async copy? If yes, I believe we
can reply on io_uring for implementing async copy_file_range, which will
be generic interface for async copy, and could get better perf.

> 2. copy_file_range, for block device atleast we saw few check's which fail
> it for raw block device. At this point I dont know much about the history of
> why such check is present.

Got it, but IMO the check in generic_copy_file_checks() can be
relaxed to cover blkdev cause splice does support blkdev.

Then your bdev offload copy work can be simplified into:

1) implement .copy_file_range for def_blk_fops, suppose it is
blkdev_copy_file_range()

2) inside blkdev_copy_file_range()

- if the bdev supports offload copy, just submit one bio to the device,
and this will be converted to one pt req to device

- otherwise, fallback to generic_copy_file_range()

> 
> > When I was researching pipe/splice code for supporting ublk zero copy[1], I
> > have got idea for async copy_file_range(), such as: io uring based
> > direct splice, user backed intermediate buffer, still zero copy, if these
> > ideas are finally implemented, we could get super-fast generic offload copy,
> > and bdev copy is really covered too.
> > 
> > [1] https://lore.kernel.org/linux-block/20221103085004.1029763-1-ming.lei@redhat.com/
> > 
> 
> Seems interesting, We will take a look into this.

BTW, that is probably one direction of ublk's async zero copy IO too.


Thanks, 
Ming

