Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296CD6351DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 09:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbiKWIFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 03:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbiKWIFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:05:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ABAF887B
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 00:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669190681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RATXjSEMlvArFiAypct02J7pLW4b2IjGVBcHKkSxkmM=;
        b=jGlc/nVt6juCw7jCUifP+AHtPPiDppMI/dDpnlKJZMePmdY3pW5R2KXxEkPiHYQ1IslE4N
        IBaImX4HJtki3tEXXh1gYHLDqvvKic3oi4aKppS/oWQUdd9v7j6ZLMVxT/7g4BEQt0pJ3Z
        M4WfbkZDeNrdjTx+POa2OkJIyTMocFc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-0DCy3A1zNn-7l0VVIwmRXQ-1; Wed, 23 Nov 2022 03:04:38 -0500
X-MC-Unique: 0DCy3A1zNn-7l0VVIwmRXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FB54185A7A8;
        Wed, 23 Nov 2022 08:04:37 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F7852024CBE;
        Wed, 23 Nov 2022 08:04:23 +0000 (UTC)
Date:   Wed, 23 Nov 2022 16:04:18 +0800
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
Message-ID: <Y33UAp6ncSPO84XI@T590>
References: <20221123055827.26996-1-nj.shetty@samsung.com>
 <CGME20221123061017epcas5p246a589e20eac655ac340cfda6028ff35@epcas5p2.samsung.com>
 <20221123055827.26996-3-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123055827.26996-3-nj.shetty@samsung.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:28:19AM +0530, Nitesh Shetty wrote:
> Introduce blkdev_issue_copy which supports source and destination bdevs,
> and an array of (source, destination and copy length) tuples.
> Introduce REQ_COPY copy offload operation flag. Create a read-write
> bio pair with a token as payload and submitted to the device in order.
> Read request populates token with source specific information which
> is then passed with write request.
> This design is courtesy Mikulas Patocka's token based copy

I thought this patchset is just for enabling copy command which is
supported by hardware. But turns out it isn't, because blk_copy_offload()
still submits read/write bios for doing the copy.

I am just wondering why not let copy_file_range() cover this kind of copy,
and the framework has been there.

When I was researching pipe/splice code for supporting ublk zero copy[1], I
have got idea for async copy_file_range(), such as: io uring based
direct splice, user backed intermediate buffer, still zero copy, if these
ideas are finally implemented, we could get super-fast generic offload copy,
and bdev copy is really covered too.

[1] https://lore.kernel.org/linux-block/20221103085004.1029763-1-ming.lei@redhat.com/

thanks,
Ming

