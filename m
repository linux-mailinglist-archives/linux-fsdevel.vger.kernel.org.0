Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67B278E94A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 11:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243928AbjHaJUu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjHaJUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:20:48 -0400
Received: from out-252.mta0.migadu.com (out-252.mta0.migadu.com [IPv6:2001:41d0:1004:224b::fc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25E4E6B
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 02:20:24 -0700 (PDT)
Message-ID: <5eaa9d17-b27c-1fbe-2575-1c4bc57f024e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693473610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QhkOZPFF3tSQCfs07OnYEvmtLLmrH1YrzTqbRKlS/5o=;
        b=sCeWaX7LaKga6D/OfQhZJXTeM+KHElQ1TPwNIbO7MsOIZf8Rwvf9QyUxRW21z631xdgwdC
        mjn0x/+ig83e4W+A+3CUhDThI40dkkqnq8TwVPhG/75RwEOcg3IeOz/4t3fNbtykRkzWF3
        PZ6FlcwKeuHDcMFUNpv7+bbgo9Ju3tk=
Date:   Thu, 31 Aug 2023 17:19:57 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 5/6] fuse: Remove fuse_direct_write_iter code path / use
 IOCB_DIRECT
Content-Language: en-US
To:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Hao Xu <howeyxu@tencent.com>
References: <20230829161116.2914040-1-bschubert@ddn.com>
 <20230829161116.2914040-6-bschubert@ddn.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
In-Reply-To: <20230829161116.2914040-6-bschubert@ddn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/30/23 00:11, Bernd Schubert wrote:
> fuse_direct_write_iter is basically duplicating what is already
> in fuse_cache_write_iter/generic_file_direct_write. That can be
> avoided by setting IOCB_DIRECT in fuse_file_write_iter, after that
> fuse_cache_write_iter can be used for the FOPEN_DIRECT_IO code path
> and fuse_direct_write_iter can be removed.
> 
> Before it was using for FOPEN_DIRECT_IO
> 
> 1) async (!is_sync_kiocb(iocb)) && IOCB_DIRECT
> 
> fuse_file_write_iter
>      fuse_direct_write_iter
>          fuse_direct_IO
>              fuse_send_dio
> 
> 2) sync (is_sync_kiocb(iocb)) or IOCB_DIRECT not being set
> 
> fuse_file_write_iter
>      fuse_direct_write_iter
>          fuse_send_dio
> 
> 3) FOPEN_DIRECT_IO not set
> 
> Same as the consolidates path below
> 
> The new consolidated code path is always
> 
> fuse_file_write_iter
>      fuse_cache_write_iter
>          generic_file_write_iter
>               __generic_file_write_iter
>                   generic_file_direct_write
>                       mapping->a_ops->direct_IO / fuse_direct_IO
>                           fuse_send_dio
> 
> So in general for FOPEN_DIRECT_IO the code path gets longer. Additionally
> fuse_direct_IO does an allocation of struct fuse_io_priv - might be a bit
> slower in micro benchmarks.
> Also, the IOCB_DIRECT information gets lost (as we now set it outselves).
> But then IOCB_DIRECT is directly related to O_DIRECT set in
> struct file::f_flags.
> 
> An additional change is for condition 2 above, which might will now do
> async IO on the condition ff->fm->fc->async_dio. Given that async IO for
> FOPEN_DIRECT_IO was especially introduced in commit
> 'commit 23c94e1cdcbf ("fuse: Switch to using async direct IO for
>   FOPEN_DIRECT_IO")'
> it should not matter. Especially as fuse_direct_IO is blocking for
> is_sync_kiocb(), at worst it has another slight overhead.
> 
> Advantage is the removal of code paths and conditions and it is now also
> possible to remove FOPEN_DIRECT_IO conditions in fuse_send_dio
> (in a later patch).
> 
> Cc: Hao Xu <howeyxu@tencent.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>   fs/fuse/file.c | 54 ++++----------------------------------------------
>   1 file changed, 4 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f9d21804d313..0b3363eec435 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1602,52 +1602,6 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   	return res;
>   }
>   
> -static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
> -{
> -	struct inode *inode = file_inode(iocb->ki_filp);
> -	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
> -	ssize_t res;
> -	bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from);
> -
> -	/*
> -	 * Take exclusive lock if
> -	 * - Parallel direct writes are disabled - a user space decision
> -	 * - Parallel direct writes are enabled and i_size is being extended.
> -	 *   This might not be needed at all, but needs further investigation.
> -	 */
> -	if (exclusive_lock)
> -		inode_lock(inode);
> -	else {
> -		inode_lock_shared(inode);
> -
> -		/* A race with truncate might have come up as the decision for
> -		 * the lock type was done without holding the lock, check again.
> -		 */
> -		if (fuse_io_past_eof(iocb, from)) {
> -			inode_unlock_shared(inode);
> -			inode_lock(inode);
> -			exclusive_lock = true;
> -		}
> -	}
> -
> -	res = generic_write_checks(iocb, from);
> -	if (res > 0) {
> -		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
> -			res = fuse_direct_IO(iocb, from);
> -		} else {
> -			res = fuse_send_dio(&io, from, &iocb->ki_pos,
> -					    FUSE_DIO_WRITE);
> -			fuse_write_update_attr(inode, iocb->ki_pos, res);
> -		}
> -	}
> -	if (exclusive_lock)
> -		inode_unlock(inode);
> -	else
> -		inode_unlock_shared(inode);
> -
> -	return res;
> -}
> -
>   static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   {
>   	struct file *file = iocb->ki_filp;
> @@ -1678,10 +1632,10 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	if (FUSE_IS_DAX(inode))
>   		return fuse_dax_write_iter(iocb, from);
>   
> -	if (!(ff->open_flags & FOPEN_DIRECT_IO))
> -		return fuse_cache_write_iter(iocb, from);
> -	else
> -		return fuse_direct_write_iter(iocb, from);
> +	if (ff->open_flags & FOPEN_DIRECT_IO)
> +		iocb->ki_flags |= IOCB_DIRECT;

I think this affect the back-end behavior, changes a buffered IO to 
direct io. FOPEN_DIRECT_IO means no cache in front-end, but we should
respect the back-end semantics. We may need another way to indicate
"we need go the direct io code path while IOCB_DIRECT is not set though".

> +
> +	return fuse_cache_write_iter(iocb, from);
>   }
>   
>   static void fuse_writepage_free(struct fuse_writepage_args *wpa)

