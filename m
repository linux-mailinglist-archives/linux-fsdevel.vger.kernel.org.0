Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8C178E84F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 10:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345683AbjHaIcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 04:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344815AbjHaIbx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:31:53 -0400
Received: from out-253.mta0.migadu.com (out-253.mta0.migadu.com [91.218.175.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6581981
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 01:31:06 -0700 (PDT)
Message-ID: <a7c2c7bf-f4ea-22cb-86a0-f24461c87fe7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693470652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQ6NeiZJ/qqcuBGIHVjY0QPJ3ZymN7XEekFE6LjqM9c=;
        b=U7akOY1NOW9+q/D7jhJsiRnDBzkPxaIRdOEahWBrRTLQaznxmnBbxhsVdQOWpMaLq5IC+G
        GptDRF0YBo5/sUzTouTU8Ue3kzOJj6CBKv6/McLqoZgBEq/1YwsF0NLI1In3o45GVIRRel
        pj4a86ds89u77F+MOvXkSPENsYaw0ZE=
Date:   Thu, 31 Aug 2023 16:30:38 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 3/6] fuse: Allow parallel direct writes for O_DIRECT
Content-Language: en-US
To:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org
Cc:     bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Hao Xu <howeyxu@tencent.com>
References: <20230829161116.2914040-1-bschubert@ddn.com>
 <20230829161116.2914040-4-bschubert@ddn.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
In-Reply-To: <20230829161116.2914040-4-bschubert@ddn.com>
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
> Take a shared lock in fuse_cache_write_iter. This was already
> done for FOPEN_DIRECT_IO in
> 
> commit 153524053bbb ("fuse: allow non-extending parallel direct
> writes on the same file")
> 
> but so far missing for plain O_DIRECT. Server side needs
> to set FOPEN_PARALLEL_DIRECT_WRITES in order to signal that
> it supports parallel dio writes.
> 
> Cc: Hao Xu <howeyxu@tencent.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>   fs/fuse/file.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 6b8b9512c336..a6b99bc80fe7 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1314,6 +1314,10 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
>   	struct file *file = iocb->ki_filp;
>   	struct fuse_file *ff = file->private_data;
>   
> +	/* this function is about direct IO only */
> +	if (!(iocb->ki_flags & IOCB_DIRECT))
> +		return false;

This means for buffered write in fuse_cache_write_iter(), we grab shared 
lock, looks not right.

> +
>   	/* server side has to advise that it supports parallel dio writes */
>   	if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
>   		return false;
> @@ -1337,6 +1341,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	struct inode *inode = mapping->host;
>   	ssize_t err;
>   	struct fuse_conn *fc = get_fuse_conn(inode);
> +	bool excl_lock = fuse_dio_wr_exclusive_lock(iocb, from);
>   
>   	if (fc->writeback_cache && !(iocb->ki_flags & IOCB_DIRECT)) {
>   		/* Update size (EOF optimization) and mode (SUID clearing) */
> @@ -1355,7 +1360,10 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	}
>   
>   writethrough:
> -	inode_lock(inode);
> +	if (excl_lock)
> +		inode_lock(inode);
> +	else
> +		inode_lock_shared(inode);
>   
>   	err = generic_write_checks(iocb, from);
>   	if (err <= 0)
> @@ -1370,6 +1378,9 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		goto out;
>   
>   	if (iocb->ki_flags & IOCB_DIRECT) {
> +		/* file extending writes will trigger i_size_write - exclusive
> +		 * lock is needed
> +		 */
>   		written = generic_file_direct_write(iocb, from);
>   		if (written < 0 || !iov_iter_count(from))
>   			goto out;
> @@ -1379,7 +1390,10 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		written = fuse_perform_write(iocb, from);
>   	}
>   out:
> -	inode_unlock(inode);
> +	if (excl_lock)
> +		inode_unlock(inode);
> +	else
> +		inode_unlock_shared(inode);
>   	if (written > 0)
>   		written = generic_write_sync(iocb, written);
>   

