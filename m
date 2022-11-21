Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2AB632A62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 18:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiKURHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 12:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiKURHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:07:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE3FCB9FB;
        Mon, 21 Nov 2022 09:07:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF9FCB811CF;
        Mon, 21 Nov 2022 17:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70374C43147;
        Mon, 21 Nov 2022 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669050438;
        bh=cvbAIL8ABqguUdYNOpewAXmrRYY5b+E1vamA4+6bEfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rRB1S4S5SxF4ImnqIXzJ3lqGi0vtoNBwxqmc4GX4ehBYFQfIbyUEzkA2GeQ9TU3mk
         Ao5HqFem8FOe6PJajkpnIjO+5Ri8ck2ah9hCV7FLxgg4zDf4Wk3eHtO5r+bCE0gB4/
         GXX9vCPbfE0sZUYdFtXQFaf/73KSl5HbEIbOcRR70Fg0Yx+7a2nLmoSJ/BKhpIUBvJ
         FwvBj0x/wiUlQVIctlErQ3ABwhkYgRHdwfDXo2N+KNmKLJ+EFcV+MxrMGNEWhzRBGJ
         p3BP5SsFp5hSINV5gxyfjg5w8qqHweuA6Wdwjq/uaDlx9nzAm3bqs0NtUgalByCsBC
         C3KcoojzkACAA==
Date:   Mon, 21 Nov 2022 09:07:18 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 19/19] iomap: remove IOMAP_F_ZONE_APPEND
Message-ID: <Y3uwRr9XQSKzBp1g@magnolia>
References: <20221120124734.18634-1-hch@lst.de>
 <20221120124734.18634-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120124734.18634-20-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 20, 2022 at 01:47:34PM +0100, Christoph Hellwig wrote:
> No users left now that btrfs takes REQ_OP_WRITE bios from iomap and
> splits and converts them to REQ_OP_ZONE_APPEND internally.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

I suspect the flags definition changes will collide with Dave's write
race fix, but otherwise this looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c  | 10 ++--------
>  include/linux/iomap.h |  1 -
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 4eb559a16c9ed..9e883a9f80388 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -217,16 +217,10 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>  {
>  	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
>  
> -	if (!(dio->flags & IOMAP_DIO_WRITE)) {
> -		WARN_ON_ONCE(iomap->flags & IOMAP_F_ZONE_APPEND);
> +	if (!(dio->flags & IOMAP_DIO_WRITE))
>  		return REQ_OP_READ;
> -	}
> -
> -	if (iomap->flags & IOMAP_F_ZONE_APPEND)
> -		opflags |= REQ_OP_ZONE_APPEND;
> -	else
> -		opflags |= REQ_OP_WRITE;
>  
> +	opflags |= REQ_OP_WRITE;
>  	if (use_fua)
>  		opflags |= REQ_FUA;
>  	else
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 238a03087e17e..ee6d511ef29dd 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -55,7 +55,6 @@ struct vm_fault;
>  #define IOMAP_F_SHARED		0x04
>  #define IOMAP_F_MERGED		0x08
>  #define IOMAP_F_BUFFER_HEAD	0x10
> -#define IOMAP_F_ZONE_APPEND	0x20
>  
>  /*
>   * Flags set by the core iomap code during operations:
> -- 
> 2.30.2
> 
