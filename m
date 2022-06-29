Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC94C5609F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 21:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiF2THh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 15:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiF2THh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:07:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8031120F4E;
        Wed, 29 Jun 2022 12:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38BC8B8269C;
        Wed, 29 Jun 2022 19:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEFDC34114;
        Wed, 29 Jun 2022 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656529653;
        bh=EVmLGcSOMyZbJn3lQsCEI4tWG6G9CP45lANhPiqexIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PN6IwkILdE9D4b5rfCd7+sPyp0Te5/snCHxkYWv+hJFmplxBfAX+PfE92bYs46yAQ
         gaoRaAvCpWV8JtAaKNZTZsNzq/k4jd8J6o3/4xo2ERaZ5l1PX+nkUHzCdblOBMVMDd
         c9RyY0gNeEwls191RJ+jrcetBkRZig8C5wePqwVqZWelDnx1ObJCeFiJGia/Yh6WeB
         mrQldL5FrKr3ObgBdQ6YifTxSXbOSx8+8ZOCF9Lha8uCT0d+GWYoqvKlktX5z+eXsX
         RYTHp0916zcCHIizfEVWz3KuDszxoEyteSHIgJ3P4J1qrvKtbnGxhblawsULLLD6Wp
         czhA15HzymxGw==
Date:   Wed, 29 Jun 2022 13:07:29 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, Keith Busch <kbusch@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <Yryi8VXTjDu1R1Zc@kbusch-mbp>
References: <YrS6/chZXbHsrAS8@kbusch-mbp>
 <e2b08a5c452d4b8322566cba4ed33b58080f03fa.camel@linux.ibm.com>
 <e0038866ac54176beeac944c9116f7a9bdec7019.camel@linux.ibm.com>
 <c5affe3096fd7b7996cb5fbcb0c41bbf3dde028e.camel@linux.ibm.com>
 <YrnOmOUPukGe8xCq@kbusch-mbp.dhcp.thefacebook.com>
 <20220628110024.01fcf84f.pasic@linux.ibm.com>
 <83e65083890a7ac9c581c5aee0361d1b49e6abd9.camel@linux.ibm.com>
 <a765fff67679155b749aafa90439b46ab1269a64.camel@linux.ibm.com>
 <YrvMY7oPnhIka4IF@kbusch-mbp.dhcp.thefacebook.com>
 <f723b1c013d78cae2f3236eba0d14129837dc7b0.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f723b1c013d78cae2f3236eba0d14129837dc7b0.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 02:04:47PM -0400, Eric Farman wrote:
> s390 dasd
> 
> This made me think to change my rootfs, and of course the problem goes
> away once on something like a SCSI volume.
> 
> So crawling through the dasd (instead of virtio) driver and I finally
> find the point where a change to dma_alignment (which you mentioned
> earlier) would actually fit.
> 
> Such a change fixes this for me, so I'll run it by our DASD guys.
> Thanks for your help and patience.

I'm assuming there's some driver or device requirement that's making this
necessary. Is the below driver change what you're looking for? If so, I think
you might want this regardless of this direct-io patch just because other
interfaces like blk_rq_map_user_iov() and blk_rq_aligned() align to it.

---
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 60be7f7bf2d1..5c79fb02cded 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -780,6 +780,7 @@ static void dasd_fba_setup_blk_queue(struct dasd_block *block)
 	/* With page sized segments each segment can be translated into one idaw/tidaw */
 	blk_queue_max_segment_size(q, PAGE_SIZE);
 	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
+	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
 
 	q->limits.discard_granularity = logical_block_size;
 
--
