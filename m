Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7AB78B12E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 14:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjH1M6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 08:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjH1M6B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:58:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6611E11C;
        Mon, 28 Aug 2023 05:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C086063CAA;
        Mon, 28 Aug 2023 12:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDAFC433C7;
        Mon, 28 Aug 2023 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693227478;
        bh=8cU2djbQzQGZfvO5mEqYGDCcsbdwpnMr9ZdtXrnK8iI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Di9gvKRP6tzRgQDhTqATp2XbwNQeb8dy99esv13fW63/rgXjXWQG+5WS7+1/aKl3v
         Sw+bHJcHRz9BWLryOOctWfXsxJWVKRilMe5Mtx4rtvVccjhWiGHMb4ySFf9RMhDglT
         l9tfIQxANtO0A7kP+GDhdOGxRxgpTxZfUdfo/b11OU/Hv/pMKB+/CScPmkceGkKKzw
         U9bUCNbudcaU4h/VMVmdxRM+/dretupx+ZkwfPbLIZbU4xWvAZzjkqBj/DACK02hY+
         iGTQ7c7OLJ6jl1HmblzKELTBE0qBNE9o2eMHNwEsKTi1lOU/9QK4WRhjupU/nClEW9
         k2EQSuAekMJ/w==
Message-ID: <1388dd5e-8d66-6f88-25d1-f563d7c366d6@kernel.org>
Date:   Mon, 28 Aug 2023 20:57:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 23/29] f2fs: Convert to bdev_open_by_dev/path()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-23-jack@suse.cz>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230823104857.11437-23-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/8/23 18:48, Jan Kara wrote:
> Convert f2fs to use bdev_open_by_dev/path() and pass the handle around.

Hi Jan,

Seems it will confilct w/ below commit, could you please take a look?

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=51bf8d3c81992ae57beeaf22df78ed7c2782af9d

Thanks,

> 
> CC: Jaegeuk Kim <jaegeuk@kernel.org>
> CC: Chao Yu <chao@kernel.org>
> CC: linux-f2fs-devel@lists.sourceforge.net
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   fs/f2fs/f2fs.h  |  1 +
>   fs/f2fs/super.c | 17 +++++++++--------
>   2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e18272ae3119..2ec6c10df636 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1234,6 +1234,7 @@ struct f2fs_bio_info {
>   #define FDEV(i)				(sbi->devs[i])
>   #define RDEV(i)				(raw_super->devs[i])
>   struct f2fs_dev_info {
> +	struct bdev_handle *bdev_handle;
>   	struct block_device *bdev;
>   	char path[MAX_PATH_LEN];
>   	unsigned int total_segments;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index aa1f9a3a8037..885dcbd81859 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1561,7 +1561,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
>   	int i;
>   
>   	for (i = 0; i < sbi->s_ndevs; i++) {
> -		blkdev_put(FDEV(i).bdev, sbi->sb);
> +		bdev_release(FDEV(i).bdev_handle);
>   #ifdef CONFIG_BLK_DEV_ZONED
>   		kvfree(FDEV(i).blkz_seq);
>   #endif
> @@ -4196,9 +4196,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>   
>   		if (max_devices == 1) {
>   			/* Single zoned block device mount */
> -			FDEV(0).bdev =
> -				blkdev_get_by_dev(sbi->sb->s_bdev->bd_dev, mode,
> -						  sbi->sb, NULL);
> +			FDEV(0).bdev_handle = bdev_open_by_dev(
> +					sbi->sb->s_bdev->bd_dev, mode, sbi->sb,
> +					NULL);
>   		} else {
>   			/* Multi-device mount */
>   			memcpy(FDEV(i).path, RDEV(i).path, MAX_PATH_LEN);
> @@ -4216,12 +4216,13 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>   					(FDEV(i).total_segments <<
>   					sbi->log_blocks_per_seg) - 1;
>   			}
> -			FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path, mode,
> -							  sbi->sb, NULL);
> +			FDEV(i).bdev_handle = bdev_open_by_path(FDEV(i).path,
> +					mode, sbi->sb, NULL);
>   		}
> -		if (IS_ERR(FDEV(i).bdev))
> -			return PTR_ERR(FDEV(i).bdev);
> +		if (IS_ERR(FDEV(i).bdev_handle))
> +			return PTR_ERR(FDEV(i).bdev_handle);
>   
> +		FDEV(i).bdev = FDEV(i).bdev_handle->bdev;
>   		/* to release errored devices */
>   		sbi->s_ndevs = i + 1;
>   
