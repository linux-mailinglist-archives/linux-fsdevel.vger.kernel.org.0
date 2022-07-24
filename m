Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FF257F2A1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Jul 2022 04:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbiGXCCG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Jul 2022 22:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGXCCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Jul 2022 22:02:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A717B11C19;
        Sat, 23 Jul 2022 19:02:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40D2DB80D3E;
        Sun, 24 Jul 2022 02:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C80C341C0;
        Sun, 24 Jul 2022 02:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658628121;
        bh=P7SNPqf+kK7Uv5jaRDdQvqwL+CiGRzt4kUYwRGuMwuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YJjZPL/MEDF7Q2m0BsBorqsKTC+7h5i+R/udBxD0IuxUYQvVrek2cohPL6C7rPK8C
         BOIHeWQ47tSvQSwI94gwdGleMtB23vMKEb3haUxSBCX5/JlAvuYeArRveRVG8+3QEo
         +6VFDKSDJMw9FFgBBLmQ+cLOLNGbS7+uaGXorNhz/GJCbEk9IrfBzoGFQqA3lvEqT/
         IubqfaoIUl1E/s1tqxFU+K/t7aGL7ohNdS7zbDj5qO6rB7Bo3don7Mrfl370ed4tyB
         ne38gcQUbi3ov4JkM1ULuc7Y1gl4VeaGWhJHpDSVd+ASvcC0gltl164iKK43cuILr1
         i1plHjvIsYaNg==
Date:   Sat, 23 Jul 2022 19:01:59 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 6/9] f2fs: don't allow DIO reads but not DIO writes
Message-ID: <YtyoF89iOg8gs7hj@google.com>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <20220722071228.146690-7-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722071228.146690-7-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/22, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Currently, if an f2fs filesystem is mounted with the mode=lfs and
> io_bits mount options, DIO reads are allowed but DIO writes are not.
> Allowing DIO reads but not DIO writes is an unusual restriction, which
> is likely to be surprising to applications, namely any application that
> both reads and writes from a file (using O_DIRECT).  This behavior is
> also incompatible with the proposed STATX_DIOALIGN extension to statx.
> Given this, let's drop the support for DIO reads in this configuration.

IIRC, we allowed DIO reads since applications complained a lower performance.
So, I'm afraid this change will make another confusion to users. Could
you please apply the new bahavior only for STATX_DIOALIGN?

> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/f2fs/file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 5e5c97fccfb4ee..ad0212848a1ab9 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -823,7 +823,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>  				struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -	int rw = iov_iter_rw(iter);
>  
>  	if (!fscrypt_dio_supported(inode))
>  		return true;
> @@ -841,7 +840,7 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>  	 */
>  	if (f2fs_sb_has_blkzoned(sbi))
>  		return true;
> -	if (f2fs_lfs_mode(sbi) && (rw == WRITE)) {
> +	if (f2fs_lfs_mode(sbi)) {
>  		if (block_unaligned_IO(inode, iocb, iter))
>  			return true;
>  		if (F2FS_IO_ALIGNED(sbi))
> -- 
> 2.37.0
