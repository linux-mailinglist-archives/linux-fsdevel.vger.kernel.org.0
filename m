Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD11518DC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 22:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbiECUJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 16:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbiECUI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 16:08:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA032AE0;
        Tue,  3 May 2022 13:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40D856189A;
        Tue,  3 May 2022 20:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0282C385A4;
        Tue,  3 May 2022 20:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651608321;
        bh=2OQ31S8saJK84+b60Nks/1nuGKuObPzODZf658f3HMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3gmS/aw/5UbzdnldhQqOG3y2Htd54aWj3NdcFNjD/VuO6MUhIRAXm8gaqDMrbl7m
         0Yd/IIwkIht0j2PXb+Na0iGFxmmXo69g/ybxOPgh9SC99E//dv42kQFiRnnJINmj0G
         WQVouHUD07VcTCvD102p1MYo7k7OtdRH4nZKSxophQWU5wzuRrxx/mIrjlCvn7kjsq
         yDReBNF0aClXwfI3zXeCWlW3e+RBMWhcbp6h1csAmjw9TRrSIgu4j5wxKNCdKT+oKm
         M5ALQh3FJxRyG6IiOBdtF5JBS3VvY3anbsCRiV8IDHss/pgBG5U5QwG09lcuiCVlnW
         Bdy2Z6nmvE8yA==
Date:   Tue, 3 May 2022 13:05:19 -0700
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
Subject: Re: [PATCH 15/16] f2fs: ensure only power of 2 zone sizes are allowed
Message-ID: <YnGK/8lu2GW4gEY0@google.com>
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160312eucas1p279bcffd97ef83bd3617a38b80d979746@eucas1p2.samsung.com>
 <20220427160255.300418-16-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427160255.300418-16-p.raghav@samsung.com>
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
> F2FS zoned support has power of 2 zone size assumption in many places
> such as in __f2fs_issue_discard_zone, init_blkz_info. As the power of 2
> requirement has been removed from the block layer, explicitly add a
> condition in f2fs to allow only power of 2 zone size devices.
> 
> This condition will be relaxed once those calculation based on power of
> 2 is made generic.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/f2fs/super.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f64761a15df7..db79abf30002 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3685,6 +3685,10 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>  		return 0;
>  
>  	zone_sectors = bdev_zone_sectors(bdev);
> +	if (!is_power_of_2(zone_sectors)) {
> +		f2fs_err(sbi, "F2FS does not support non power of 2 zone sizes\n");
> +		return -EINVAL;
> +	}
>  
>  	if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=
>  				SECTOR_TO_BLOCK(zone_sectors))
> -- 
> 2.25.1
