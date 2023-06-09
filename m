Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E9D72A3FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 22:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjFIUBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 16:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjFIUBG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:01:06 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2B8359C
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 13:00:27 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-3f9b2b7109dso16496351cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 13:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686340826; x=1688932826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFxNC6AwIefC8h+OVa9YMEjCXThkDxxKP8p9zX4LNFY=;
        b=U7Sl09wOPD0ux2AzA97S5RNCch2O+SUsb0k7cY6a14OqyFKY0YNNRhLkm2h44KqZT6
         vGagkgpuHp95G4EIdwwrzSlRqC9a3MTIRp7EIUV9OL8moA/lOmvHxYletgpaEa1CVm+G
         EHSMnX6VJoaY5p1nsVu7tuN2nenX3wZ1lIlL14uipIEeMNuHRLltUlQ3CeJ1ukjS1P58
         yOFTW656U75DY1dp1/l4nrzNjGLR3OIgNpOMe9l9Hpz5BLY5reaD++CewLI293MbudP8
         EeycrGeVf+9rMSTsWPrYf4Ju5wy8AfOPV8SHNbeGiSnnDzxwZUYhbjo3/GhdbdRG/ifq
         Y5ig==
X-Gm-Message-State: AC+VfDyR1hud/HQyz+NRfAg6nS4iWbM6031YKp+zgPp8H6VEU+wc11vT
        wVMR5cWwY9b8DxqpZnWhVEV+
X-Google-Smtp-Source: ACHHUZ6f5D0na1vDQSbLNkOIR7VVTt7ADDPvJzshNMQToGx2m/jPA4IIyjKZFD+hGnfTs+abIWzkWA==
X-Received: by 2002:ac8:7e88:0:b0:3f8:6c15:c3a5 with SMTP id w8-20020ac87e88000000b003f86c15c3a5mr3039832qtj.33.1686340826214;
        Fri, 09 Jun 2023 13:00:26 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id d3-20020ac85343000000b003f740336bb9sm1418338qto.9.2023.06.09.13.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:00:25 -0700 (PDT)
Date:   Fri, 9 Jun 2023 16:00:24 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v7 2/5] block: Introduce provisioning primitives
Message-ID: <ZIOE2ASeUAXxzpRO@redhat.com>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <20230518223326.18744-3-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518223326.18744-3-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18 2023 at  6:33P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> Introduce block request REQ_OP_PROVISION. The intent of this request
> is to request underlying storage to preallocate disk space for the given
> block range. Block devices that support this capability will export
> a provision limit within their request queues.
> 
> This patch also adds the capability to call fallocate() in mode 0
> on block devices, which will send REQ_OP_PROVISION to the block
> device for the specified range,
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
...
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 896b4654ab00..d303e6614c36 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -59,6 +59,7 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->zoned = BLK_ZONED_NONE;
>  	lim->zone_write_granularity = 0;
>  	lim->dma_alignment = 511;
> +	lim->max_provision_sectors = 0;
>  }
>  
>  /**
> @@ -82,6 +83,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>  	lim->max_dev_sectors = UINT_MAX;
>  	lim->max_write_zeroes_sectors = UINT_MAX;
>  	lim->max_zone_append_sectors = UINT_MAX;
> +	lim->max_provision_sectors = UINT_MAX;
>  }
>  EXPORT_SYMBOL(blk_set_stacking_limits);
>  
> @@ -578,6 +594,9 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  	t->max_segment_size = min_not_zero(t->max_segment_size,
>  					   b->max_segment_size);
>  
> +	t->max_provision_sectors = min_not_zero(t->max_provision_sectors,
> +						b->max_provision_sectors);
> +

This needs to use min() since max_provision_sectors also serves to
indicate if the device supports REQ_OP_PROVISION.  Otherwise, if I set
max_provision_sectors to 0 on a dm thin-pool the blk_stack_limits()
will ignore my having set it to 0 (to disable) and it'll remain as
UINT_MAX (thanks to blk_set_default_limits).

Mike
