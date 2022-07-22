Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC83457DB62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 09:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiGVHgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 03:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiGVHgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:36:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7558A6A9D0;
        Fri, 22 Jul 2022 00:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36225B8279F;
        Fri, 22 Jul 2022 07:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C531C341C6;
        Fri, 22 Jul 2022 07:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658475364;
        bh=BrCgpt0Y+dGL8BYfbBvR+y7L5n2fAW8NcR8pieDKD18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/NH+cmLNQIwfEFjtjRYn1a5b/fq6FC3ELJVLP5mAZ41Pv84RCVNKXKFHfUQMMUb7
         r5hrDbmE5wiwdbyE8Ikp6940ukRBCVHcV5qPcSGWsmfUd/g9MQgP3MXLPPFMkATnUZ
         ALhh0GKhcScoLYjenTtfVaUmj19j248Q0m71xq6OBL9AvNA+C7adrlQkO5zuSsuu9a
         HIrBcHjiuQy6Sd3patwXjrqrAU+dy+Zo4A4hsJJlJSwck1ERcFHwJfsk+yfH57tLqx
         o86yzRcdTYuazw+fEEMiLMtSkIHoDgIEwIgFidSygWrVDda8J/V0KyaRS4Isb2NoGA
         EpC1Z7Cb2NF7g==
Date:   Fri, 22 Jul 2022 00:36:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@fb.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <YtpTYSNUCwPelNgL@sol.localdomain>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-12-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610195830.3574005-12-kbusch@fb.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+f2fs list and maintainers]

On Fri, Jun 10, 2022 at 12:58:30PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Use the address alignment requirements from the block_device for direct
> io instead of requiring addresses be aligned to the block size.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 370c3241618a..5d098adba443 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -242,7 +242,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	struct inode *inode = iter->inode;
>  	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
>  	unsigned int fs_block_size = i_blocksize(inode), pad;
> -	unsigned int align = iov_iter_alignment(dio->submit.iter);
>  	loff_t length = iomap_length(iter);
>  	loff_t pos = iter->pos;
>  	unsigned int bio_opf;
> @@ -253,7 +252,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	size_t copied = 0;
>  	size_t orig_count;
>  
> -	if ((pos | length | align) & ((1 << blkbits) - 1))
> +	if ((pos | length) & ((1 << blkbits) - 1) ||
> +	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>  		return -EINVAL;
>  
>  	if (iomap->type == IOMAP_UNWRITTEN) {

I noticed that this patch is going to break the following logic in
f2fs_should_use_dio() in fs/f2fs/file.c:

	/*
	 * Direct I/O not aligned to the disk's logical_block_size will be
	 * attempted, but will fail with -EINVAL.
	 *
	 * f2fs additionally requires that direct I/O be aligned to the
	 * filesystem block size, which is often a stricter requirement.
	 * However, f2fs traditionally falls back to buffered I/O on requests
	 * that are logical_block_size-aligned but not fs-block aligned.
	 *
	 * The below logic implements this behavior.
	 */
	align = iocb->ki_pos | iov_iter_alignment(iter);
	if (!IS_ALIGNED(align, i_blocksize(inode)) &&
	    IS_ALIGNED(align, bdev_logical_block_size(inode->i_sb->s_bdev)))
		return false;

	return true;

So, f2fs assumes that __iomap_dio_rw() returns an error if the I/O isn't logical
block aligned.  This patch changes that.  The result is that DIO will sometimes
proceed in cases where the I/O doesn't have the fs block alignment required by
f2fs for all DIO.

Does anyone have any thoughts about what f2fs should be doing here?  I think
it's weird that f2fs has different behaviors for different degrees of
misalignment: fail with EINVAL if not logical block aligned, else fallback to
buffered I/O if not fs block aligned.  I think it should be one convention or
the other.  Any opinions about which one it should be?

(Note: if you blame the above code, it was written by me.  But I was just
preserving the existing behavior; I don't know the original motivation.)

- Eric
