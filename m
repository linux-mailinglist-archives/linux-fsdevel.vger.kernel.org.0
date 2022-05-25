Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1985344DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 22:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbiEYUbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 16:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiEYUbL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 16:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F58419037
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653510668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k75N5FnswqlCl0SNogf2hWCSCyCFZTMJDJby5tTX8OQ=;
        b=KRGUaLhOEvSxD4oeyIS11zJt3tsdlsEw5SZ40zgl5rl5h4mIILkz5lqfFFafr1XvAKG2oq
        1XrAUErpV3VNxzJCKDfRnfY8GCNNLGiPBEokE3obcHnHRzloyT1g94lI/l63wauPAMIAo2
        I1fEG6G/t9ezT9WS/avtxFH0CUtmbYw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-3TD89sbSPQW-xVX83NHdhw-1; Wed, 25 May 2022 16:31:03 -0400
X-MC-Unique: 3TD89sbSPQW-xVX83NHdhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACBA3858EFE;
        Wed, 25 May 2022 20:31:02 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95B2740C128B;
        Wed, 25 May 2022 20:31:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 51A912208FA; Wed, 25 May 2022 16:31:02 -0400 (EDT)
Date:   Wed, 25 May 2022 16:31:02 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        bschubert@ddn.com, Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v3 1/1] FUSE: Allow non-extending parallel direct writes
 on the same file.
Message-ID: <Yo6SBoEgGgnNQv8W@redhat.com>
References: <20220520043443.17439-1-dharamhans87@gmail.com>
 <20220520043443.17439-2-dharamhans87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520043443.17439-2-dharamhans87@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 20, 2022 at 10:04:43AM +0530, Dharmendra Singh wrote:
> From: Dharmendra Singh <dsingh@ddn.com>
> 
> In general, as of now, in FUSE, direct writes on the same file are
> serialized over inode lock i.e we hold inode lock for the full duration
> of the write request. I could not found in fuse code a comment which
> clearly explains why this exclusive lock is taken for direct writes.
> Our guess is some USER space fuse implementations might be relying
> on this lock for seralization and also it protects for the issues
> arising due to file size assumption or write failures.  This patch
> relaxes this exclusive lock in some cases of direct writes.

I have this question as well. My understanding was that in general,
reads can do shared lock while writes have to take exclusive lock.
And I assumed that extends to both buffered as well as direct
writes.

I would also like to understand what's the fundamental restriction
and why O_DIRECT is special that this restriction does not apply.

Is any other file system doing this as well?

If fuse server dir is shared with other fuse clients, it is possible
that i_size in this client is stale. Will that be a problem. I guess
if that's the problem then, even a single write will be a problem
because two fuse clients might be trying to write.

Just trying to make sure that it is safe to allow parallel direct
writes.

Thanks
Vivek

> 
> With these changes, we allows non-extending parallel direct writes
> on the same file with the help of a flag called FOPEN_PARALLEL_WRITES.
> If this flag is set on the file (flag is passed from libfuse to fuse
> kernel as part of file open/create), we do not take exclusive lock instead
> use shared lock so that all non-extending writes can run in parallel.
> 
> Best practise would be to enable parallel direct writes of all kinds
> including extending writes as well but we see some issues such as
> when one write completes and other fails, how we should truncate(if
> needed) the file if underlying file system does not support holes
> (For file systems which supports holes, there might be a possibility
> of enabling parallel writes for all cases).
> 
> FUSE implementations which rely on this inode lock for serialisation
> can continue to do so and this is default behaviour i.e no parallel
> direct writes.
> 
> Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/file.c            | 33 ++++++++++++++++++++++++++++++---
>  include/uapi/linux/fuse.h |  2 ++
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 829094451774..1a93fd80a6ce 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1541,14 +1541,37 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	return res;
>  }
>  
> +static bool fuse_direct_write_extending_i_size(struct kiocb *iocb,
> +					       struct iov_iter *iter)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	return (iocb->ki_flags & IOCB_APPEND ||
> +		iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode));
> +}
> +
>  static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct file *file = iocb->ki_filp;
> +	struct fuse_file *ff = file->private_data;
>  	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
>  	ssize_t res;
> +	bool exclusive_lock = !(ff->open_flags & FOPEN_PARALLEL_WRITES) ||
> +			       fuse_direct_write_extending_i_size(iocb, from);
> +
> +	/*
> +	 * Take exclusive lock if
> +	 * - parallel writes are disabled.
> +	 * - parallel writes are enabled and i_size is being extended
> +	 * Take shared lock if
> +	 * - parallel writes are enabled but i_size does not extend.
> +	 */
> +	if (exclusive_lock)
> +		inode_lock(inode);
> +	else
> +		inode_lock_shared(inode);
>  
> -	/* Don't allow parallel writes to the same file */
> -	inode_lock(inode);
>  	res = generic_write_checks(iocb, from);
>  	if (res > 0) {
>  		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
> @@ -1559,7 +1582,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			fuse_write_update_attr(inode, iocb->ki_pos, res);
>  		}
>  	}
> -	inode_unlock(inode);
> +	if (exclusive_lock)
> +		inode_unlock(inode);
> +	else
> +		inode_unlock_shared(inode);
>  
>  	return res;
>  }
> @@ -2901,6 +2927,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  
>  	if (iov_iter_rw(iter) == WRITE) {
>  		fuse_write_update_attr(inode, pos, ret);
> +		/* For extending writes we already hold exclusive lock */
>  		if (ret < 0 && offset + count > i_size)
>  			fuse_do_truncate(file);
>  	}
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index d6ccee961891..ee5379d41906 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -301,6 +301,7 @@ struct fuse_file_lock {
>   * FOPEN_CACHE_DIR: allow caching this directory
>   * FOPEN_STREAM: the file is stream-like (no file position at all)
>   * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
> + * FOPEN_PARALLEL_WRITES: Allow concurrent writes on the same inode
>   */
>  #define FOPEN_DIRECT_IO		(1 << 0)
>  #define FOPEN_KEEP_CACHE	(1 << 1)
> @@ -308,6 +309,7 @@ struct fuse_file_lock {
>  #define FOPEN_CACHE_DIR		(1 << 3)
>  #define FOPEN_STREAM		(1 << 4)
>  #define FOPEN_NOFLUSH		(1 << 5)
> +#define FOPEN_PARALLEL_WRITES	(1 << 6)
>  
>  /**
>   * INIT request/reply flags
> -- 
> 2.17.1
> 

