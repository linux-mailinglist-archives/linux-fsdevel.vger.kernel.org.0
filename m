Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762174B0A2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 11:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbiBJKCY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 05:02:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiBJKCY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:02:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB28BE0;
        Thu, 10 Feb 2022 02:02:25 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 775E721115;
        Thu, 10 Feb 2022 10:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644487344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lcBtRTov0U4scR5M2Iy2myhqZeOwAIyV54RcClAbhV4=;
        b=UVJHxaJMKmE/DO/JZe3iVbVw3GQe2kQmip1zYFYiRYyI1pZTASyk8ODPUH85ZCuqzCIWsi
        rV6USU5SNQRHNVVtN7czjs/tg9jgYBrlYPUuVDHO/aShUUH/4xIgSIpkWiWmMUD14J4lqn
        gHBmV7fgdq0Mk5zS8kvpWhMAHojnEdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644487344;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lcBtRTov0U4scR5M2Iy2myhqZeOwAIyV54RcClAbhV4=;
        b=3uOBgMN4Wr+d5mCyhO6cp6IQhYZtOH8ULuhOgZdIotrLORbzqWHkWV4veZpJWP42oTgmJG
        NOB6bjhLKtWqFVCQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0BE01A3B97;
        Thu, 10 Feb 2022 10:02:23 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BEB02A05BC; Thu, 10 Feb 2022 11:02:22 +0100 (CET)
Date:   Thu, 10 Feb 2022 11:02:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 10/11] block/bfq-iosched.c: use "false" rather than
 "BLK_RW_ASYNC"
Message-ID: <20220210100222.f2nmwwb5pcfmejvw@quack3.lan>
References: <164447124918.23354.17858831070003318849.stgit@noble.brown>
 <164447147264.23354.2763356897218946255.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164447147264.23354.2763356897218946255.stgit@noble.brown>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-02-22 16:37:52, NeilBrown wrote:
> bfq_get_queue() expects a "bool" for the third arg, so pass "false"
> rather than "BLK_RW_ASYNC" which will soon be removed.
> 
> Acked-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: NeilBrown <neilb@suse.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0c612a911696..4e645ae1e066 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5448,7 +5448,7 @@ static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
>  	bfqq = bic_to_bfqq(bic, false);
>  	if (bfqq) {
>  		bfq_release_process_ref(bfqd, bfqq);
> -		bfqq = bfq_get_queue(bfqd, bio, BLK_RW_ASYNC, bic, true);
> +		bfqq = bfq_get_queue(bfqd, bio, false, bic, true);
>  		bic_set_bfqq(bic, bfqq, false);
>  	}
>  
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
