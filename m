Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD00E60E77C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 20:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbiJZSdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 14:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiJZSdL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB11B2A430;
        Wed, 26 Oct 2022 11:33:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E48461E9B;
        Wed, 26 Oct 2022 18:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DD0C433C1;
        Wed, 26 Oct 2022 18:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666809183;
        bh=UaCZwJl0cOPjTzVAHxPtB54pSd2kYRAZTsnNitiCjOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilo3ZGvLFldo8cQHPiXt7cvS3EqJYyk0npAWoDfQRuqQL27TimY4jgo8yvQsXRvyn
         hDpf/cG5LnQJ4ay9k0KbwFgbcfLIWTe0yd7W45/PyLomudCemKEek6HTZTyZqHYMqI
         cJq4bzBMOnR2NVW/EgEDTEtachPQvYZrfhND//V9FFPx23dFUD0K80rXdg8aievL0v
         dg3NW59Q00CT5sT06QSk8clKN7yAW3xCd1egrjszTZmYX7WOBAK5QKo+Y3yUn7dHId
         7SuRsGcpdxctotQpDAzc0LItOyNt26igb9WLl0gTaVCN4WWUCodKAN/Lz4UVtGGIjA
         fwY32NJhUpw2A==
Date:   Wed, 26 Oct 2022 11:33:03 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, bvanassche@acm.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] iomap: directly use logical block size
Message-ID: <Y1l9X543IuJPi0Jw@magnolia>
References: <20221026165133.2563946-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026165133.2563946-1-kbusch@meta.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 26, 2022 at 09:51:33AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Don't transform the logical block size to a bit shift only to shift it
> back to the original block size. Just use the size.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  fs/iomap/direct-io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 4eb559a16c9e..503b97e5a115 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -240,7 +240,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  {
>  	const struct iomap *iomap = &iter->iomap;
>  	struct inode *inode = iter->inode;
> -	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
> +	unsigned int blksz = bdev_logical_block_size(iomap->bdev);

/me looks at what blksize_bits does (assumes block size > 256) and rolls
his eyes.

Regardless, this looks correct to me, so

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


>  	unsigned int fs_block_size = i_blocksize(inode), pad;
>  	loff_t length = iomap_length(iter);
>  	loff_t pos = iter->pos;
> @@ -252,7 +252,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	size_t copied = 0;
>  	size_t orig_count;
>  
> -	if ((pos | length) & ((1 << blkbits) - 1) ||
> +	if ((pos | length) & (blksz - 1) ||
>  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>  		return -EINVAL;
>  
> -- 
> 2.30.2
> 
