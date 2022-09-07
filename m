Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D885B0E33
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 22:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIGUdm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 16:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiIGUdk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:33:40 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2718DBD74D
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 13:33:38 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id q8so11600178qvr.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Sep 2022 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Xg9usTdk0o6C+zSe1YOKjC4WC1xdzLzB/PM0uNLkIkI=;
        b=5RGjXJezlOJDqW62jqniKE9nd0sCKFqd+pYdoNP/51fCNJDmLNWYBG9knRZwzwHqHQ
         UMgwSQii1aaCB6KLAlPZFNIJ9X/vHHJ2SAX/7GFNQCwNh+u8/uBj9hCY/wV8d1RXTd75
         6ApqvxuIfqn4TbiYSpOaXS/W0TBJsRsKZuEjdpecIjpOwmnYpHcpwTUv57XP4Ht7D78w
         mVm24HglVdIr/kcd3zYb4sOHP7EIN/ncTFd9vEdk35fP2PUet4blXGVuKQ9nM3mhGN8w
         ChIhwxcgGR3WwEBpuE9y88JfjhhwjBa4voxnTiCFoRM0oCAIe3eJ/ywhGfx3aYrNcQG0
         u9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Xg9usTdk0o6C+zSe1YOKjC4WC1xdzLzB/PM0uNLkIkI=;
        b=egJXbcSvAAJ5dAm9BNz7DPo6NrJ0sCxA0SYlqN34gsyh6wt18IyPiKsqyEh44tb6lp
         1t2MWBQIrey9huwaWAdTm2XqsbGQmyN4SE2GjiIETsNl9iEb1ZXbxxcp0Pk0RP3XVCl0
         2RgooR2vYWv4KLRJMQhU6weP+T95J6diXFFz5vawrGzPlngbIZFqkm69vDOv+OV7MDQj
         tYWyn+SUDqgGoJKQSS5PFlKzJS7HZ3lbsIl39cCEQx6SYGEYoZI1zmxoDczRB16A1foH
         yL+JNf9f0UO7MycpGPASNnbODp7px6JV8W63BRv9g3lG2Q9GkcxvfAfiCKtIgtr4xKCN
         hiJA==
X-Gm-Message-State: ACgBeo1aVGZLW/hZv5cTw2a5xw+TeGa+tU3H6F4kaIKkBj7zCznY86uw
        Mt6SU3Ijrw+ScROQH7sr9NB/sw==
X-Google-Smtp-Source: AA6agR6+PDEDIx9U94oK9gOGRgiesvdxSGyJ98dR/RxQZopxV5T9kYkTdfx7Z4YPCtjmyEfo8KkPFw==
X-Received: by 2002:a05:6214:230a:b0:46e:3890:afcb with SMTP id gc10-20020a056214230a00b0046e3890afcbmr4831985qvb.59.1662582817038;
        Wed, 07 Sep 2022 13:33:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id cd9-20020a05622a418900b00342fdc4004fsm13275230qtb.52.2022.09.07.13.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:33:36 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:33:35 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/17] btrfs: handle checksum generation in the storage
 layer
Message-ID: <YxkAHwUx8SsJzRYJ@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-6-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:04AM +0300, Christoph Hellwig wrote:
> Instead of letting the callers of btrfs_submit_bio deal with checksumming
> the (meta)data in the bio and making decisions on when to offload the
> checksumming to the bio, leave that to btrfs_submit_bio.  Do do so the
> existing btrfs_submit_bio function is split into an upper and a lower
> half, so that the lower half can be offloaded to a workqueue.
> 
> The driver-private REQ_DRV flag is used to indicate the special 'bio must
> be contained in a single ordered extent case' that is used by the
> compressed write case instead of passing a new flag all the way down the
> stack.
> 
> Note that this changes the behavior for direct writes to raid56 volumes so
> that async checksum offloading is not skipped when more I/O is expected.
> This runs counter to the argument explaining why it was done, although I
> can't measure any affects of the change.  Commits later in this series
> will make sure the entire direct writes is offloaded to the workqueue
> at once and thus make sure it is sent to the raid56 code from a single
> thread.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/compression.c |  13 +--
>  fs/btrfs/ctree.h       |   4 +-
>  fs/btrfs/disk-io.c     | 170 ++-------------------------------
>  fs/btrfs/disk-io.h     |   5 -
>  fs/btrfs/extent_io.h   |   3 -
>  fs/btrfs/file-item.c   |  25 ++---
>  fs/btrfs/inode.c       |  89 +-----------------
>  fs/btrfs/volumes.c     | 208 ++++++++++++++++++++++++++++++++++++-----
>  fs/btrfs/volumes.h     |   7 +-
>  9 files changed, 215 insertions(+), 309 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index f932415a4f1df..53f9e123712b0 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -351,9 +351,9 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  	u64 cur_disk_bytenr = disk_start;
>  	u64 next_stripe_start;
>  	blk_status_t ret = BLK_STS_OK;
> -	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
>  	const bool use_append = btrfs_use_zone_append(inode, disk_start);
> -	const enum req_op bio_op = use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;
> +	const enum req_op bio_op = REQ_BTRFS_ONE_ORDERED |
> +		(use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE);
>  

I'd rather see this as a separate change.  Keeping logical changes to themselves
makes it easier to figure out what was going on when we look back at the
history.  Other than that you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
