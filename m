Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C80F70F3AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 12:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjEXKDY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 06:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjEXKDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 06:03:09 -0400
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4B212E
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 03:03:07 -0700 (PDT)
Message-ID: <190f369a-3331-47a6-0202-16394401829e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684922585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AL5/JeQf1c09RfMijYyY8w7hVd1RvGa27M8KdQP2Hds=;
        b=Stko1XC94BtE4K328tqg2rtn4fYLbYc8uUo/7jKuY4cA5xFu4UPfc3DWz9ivXx7pgf+6oV
        5S07gIozAK9EHd69/LDNPPP7059oYAE6oQifr8ig0WbJmF9A77Yxglx4kx03iYLd3lTn+J
        TG2cp+4BFJlk+HlMhEtR4kw+cYIDdQE=
Date:   Wed, 24 May 2023 18:02:58 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH] fuse: invalidate page cache pages before direct write
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
To:     fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, bernd.schubert@fastmail.fm,
        linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        cgxu519@mykernel.net
References: <20230509080128.457489-1-hao.xu@linux.dev>
In-Reply-To: <20230509080128.457489-1-hao.xu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/9/23 16:01, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> In FOPEN_DIRECT_IO, page cache may still be there for a file, direct
> write should respect that and invalidate the corresponding pages so
> that page cache readers don't get stale data. Another thing this patch
> does is flush related pages to avoid its loss.
> 
> Signed-off-by: Hao Xu <howeyxu@tencent.com>
> ---
> 
> Reference:
> https://lore.kernel.org/linux-fsdevel/ee8380b3-683f-c526-5f10-1ce2ee6f79ad@linux.dev/#:~:text=I%20think%20this%20problem%20exists%20before%20this%20patchset
> 
>   fs/fuse/file.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 89d97f6188e0..edc84c1dfc5c 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1490,7 +1490,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>   	int write = flags & FUSE_DIO_WRITE;
>   	int cuse = flags & FUSE_DIO_CUSE;
>   	struct file *file = io->iocb->ki_filp;
> -	struct inode *inode = file->f_mapping->host;
> +	struct address_space *mapping = file->f_mapping;
> +	struct inode *inode = mapping->host;
>   	struct fuse_file *ff = file->private_data;
>   	struct fuse_conn *fc = ff->fm->fc;
>   	size_t nmax = write ? fc->max_write : fc->max_read;
> @@ -1516,6 +1517,17 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>   			inode_unlock(inode);
>   	}
>   
> +	res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);

Seems We don't need to flush dirty page if the page is only private 
mmaped, because the pages are always clean. I'll fix this in v2.

> +	if (res)
> +		return res;
> +
> +	if (write) {
> +		if (invalidate_inode_pages2_range(mapping,
> +				idx_from, idx_to)) {
> +			return -ENOTBLK;
> +		}
> +	}
> +
>   	io->should_dirty = !write && user_backed_iter(iter);
>   	while (count) {
>   		ssize_t nres;

