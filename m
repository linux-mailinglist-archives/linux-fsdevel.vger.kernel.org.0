Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3681518DB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 22:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbiECUHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 16:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiECUHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 16:07:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93517403CC;
        Tue,  3 May 2022 13:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F6BCB82062;
        Tue,  3 May 2022 20:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F65C385A4;
        Tue,  3 May 2022 20:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651608251;
        bh=yEwIKUkYrUe+UB4k6sDSTOcJaUQFRLK0s3/p+P/axO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GI4PqtOAj9PMvq17VbxQwejZWyW9waSFBPKixzYGnlcgVZKbWRTtbDsNIZZwaqgJW
         oRbRzsBLXIeXqedBxITy5sBQxpsdE8I0dm3cEPiXGUZcnaeNIQ12WIBdr1DNLQll1t
         +pUS07koL10aaZ31K0ZVF/uLZ+EZZBoxW+DCQadgwgerGjiYcHn3UgSgB4OcJyJiYe
         i6tehN8h7cCda5ctDbs17t6pRzGracdobePQtcHkfSJEEz+G6rES43RSs+L4zfA7c4
         iHfsO8Ek/+4eQNxEj3/7v/WG9g0aL4gDw9K4vOzjBpm1V5OnkKQ8fUIpjm9PDrF8aA
         kouE3UjVHDJkQ==
Date:   Tue, 3 May 2022 13:04:08 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
        naohiro.aota@wdc.com, sagi@grimberg.me,
        damien.lemoal@opensource.wdc.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, clm@fb.com, gost.dev@samsung.com,
        chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        josef@toxicpanda.com, jonathan.derrick@linux.dev, agk@redhat.com,
        kbusch@kernel.org, kch@nvidia.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, bvanassche@acm.org, jiangbo.365@bytedance.com,
        linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 14/16] f2fs: call bdev_zone_sectors() only once on
 init_blkz_info()
Message-ID: <YnGKuET79JQ+ssPp@google.com>
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160311eucas1p151141fc73adc590b40ad6f935b1ac214@eucas1p1.samsung.com>
 <20220427160255.300418-15-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427160255.300418-15-p.raghav@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Applied to f2fs tree. Thanks,

On 04/27, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Instead of calling bdev_zone_sectors() multiple times, call
> it once and cache the value locally. This will make the
> subsequent change easier to read.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/f2fs/super.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ea939db18f88..f64761a15df7 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3678,22 +3678,25 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>  	struct block_device *bdev = FDEV(devi).bdev;
>  	sector_t nr_sectors = bdev_nr_sectors(bdev);
>  	struct f2fs_report_zones_args rep_zone_arg;
> +	u64 zone_sectors;
>  	int ret;
>  
>  	if (!f2fs_sb_has_blkzoned(sbi))
>  		return 0;
>  
> +	zone_sectors = bdev_zone_sectors(bdev);
> +
>  	if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=
> -				SECTOR_TO_BLOCK(bdev_zone_sectors(bdev)))
> +				SECTOR_TO_BLOCK(zone_sectors))
>  		return -EINVAL;
> -	sbi->blocks_per_blkz = SECTOR_TO_BLOCK(bdev_zone_sectors(bdev));
> +	sbi->blocks_per_blkz = SECTOR_TO_BLOCK(zone_sectors);
>  	if (sbi->log_blocks_per_blkz && sbi->log_blocks_per_blkz !=
>  				__ilog2_u32(sbi->blocks_per_blkz))
>  		return -EINVAL;
>  	sbi->log_blocks_per_blkz = __ilog2_u32(sbi->blocks_per_blkz);
>  	FDEV(devi).nr_blkz = SECTOR_TO_BLOCK(nr_sectors) >>
>  					sbi->log_blocks_per_blkz;
> -	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
> +	if (nr_sectors & (zone_sectors - 1))
>  		FDEV(devi).nr_blkz++;
>  
>  	FDEV(devi).blkz_seq = f2fs_kvzalloc(sbi,
> -- 
> 2.25.1
