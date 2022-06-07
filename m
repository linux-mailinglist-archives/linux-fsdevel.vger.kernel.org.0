Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E95354201C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 02:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356875AbiFHAQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 20:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457191AbiFGXV3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 869293E3435
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654637161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0P4w0tinrYTQC91laIMkql8G3HbFfeIlttNGpjJORzM=;
        b=Fm5aj7aKh8ekTNI68lmNxB8WhcjJVE9g45iPAZsDDJkd0O+WYnxN2PCdcdVcESjVAn3Axe
        rTRWi1g39e8U+fTALQ1DWXOaray2yEinmkl2hrW1f2lehwANGYuTwvRyhSrshJoYbhmQoc
        SPOXItmjc3LQBAQKGrI/eVAG9xCQiwE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-cRJ2HjKNPoiAfZBNuWqXSA-1; Tue, 07 Jun 2022 17:25:56 -0400
X-MC-Unique: cRJ2HjKNPoiAfZBNuWqXSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A49C0811E76;
        Tue,  7 Jun 2022 21:25:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F36994010E32;
        Tue,  7 Jun 2022 21:25:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AF713220882; Tue,  7 Jun 2022 17:25:54 -0400 (EDT)
Date:   Tue, 7 Jun 2022 17:25:54 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        bschubert@ddn.com, Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v4 1/1] Allow non-extending parallel direct writes on the
 same file.
Message-ID: <Yp/CYjONZHoekSVA@redhat.com>
References: <20220605072201.9237-1-dharamhans87@gmail.com>
 <20220605072201.9237-2-dharamhans87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605072201.9237-2-dharamhans87@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 05, 2022 at 12:52:00PM +0530, Dharmendra Singh wrote:
> From: Dharmendra Singh <dsingh@ddn.com>
> 
> In general, as of now, in FUSE, direct writes on the same file are
> serialized over inode lock i.e we hold inode lock for the full duration
> of the write request. I could not found in fuse code a comment which
> clearly explains why this exclusive lock is taken for direct writes.
> 
> Following might be the reasons for acquiring exclusive lock but not
> limited to
> 1) Our guess is some USER space fuse implementations might be relying
>    on this lock for seralization.

Hi Dharmendra,

I will just try to be devil's advocate. So if this is server side
limitation, then it is possible that fuse client's isize data in
cache is stale. For example, filesystem is shared between two 
clients.

- File size is 4G as seen by client A.
- Client B truncates the file to 2G.
- Two processes in client A, try to do parallel direct writes and will
  be able to proceed and server will get two parallel writes both
  extending file size.

I can see that this can happen with virtiofs with cache=auto policy.

IOW, if this is a fuse server side limitation, then how do you ensure
that fuse kernel's i_size definition is not stale.

> 2) This lock protects for the issues arising due to file size
>    assumptions.
> 3) Ruling out any issues arising due to multiple writes where some 
>    writes succeeded and some failed.
> 
> This patch relaxes this exclusive lock for non-extending direct writes.
> 
> With these changes, we allows non-extending parallel direct writes
> on the same file with the help of a flag called FOPEN_PARALLEL_WRITES.
> If this flag is set on the file (flag is passed from libfuse to fuse
> kernel as part of file open/create), we do not take exclusive lock
> instead use shared lock so that all non-extending writes can run in 
> parallel.
> 
> Best practise would be to enable parallel direct writes of all kinds
> including extending writes as well but we see some issues such as
> 1) When one write completes on one server and other fails on another
> server, how we should truncate(if needed) the file if underlying file 
> system does not support holes (For file systems which supports holes,
> there might be a possibility of enabling parallel writes for all cases).
> 
> FUSE implementations which rely on this inode lock for serialisation
> can continue to do so and this is default behaviour i.e no parallel
> direct writes.
> 
> Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/file.c            | 46 ++++++++++++++++++++++++++++++++++++---
>  include/uapi/linux/fuse.h |  2 ++
>  2 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 829094451774..72524612bd5c 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1541,14 +1541,50 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
> +	bool exclusive_lock = !(ff->open_flags & FOPEN_PARALLEL_WRITES ||
> +			       fuse_direct_write_extending_i_size(iocb, from));
> +
> +	/*
> +	 * Take exclusive lock if
> +	 * - parallel writes are disabled.
> +	 * - parallel writes are enabled and i_size is being extended
> +	 * Take shared lock if
> +	 * - parallel writes are enabled but i_size does not extend.
> +	 */
> +retry:
> +	if (exclusive_lock)
> +		inode_lock(inode);
> +	else {
> +		inode_lock_shared(inode);
> +
> +		/*
> +		 * Its possible that truncate reduced the file size after the check
> +		 * but before acquiring shared lock. If its so than drop shared lock and
> +		 * acquire exclusive lock.
> +		 */
> +		if (fuse_direct_write_extending_i_size(iocb, from)) {
> +			inode_unlock_shared(inode);
> +			exclusive_lock = true;
> +			goto retry;
> +		}
> +	}
>  
> -	/* Don't allow parallel writes to the same file */
> -	inode_lock(inode);
>  	res = generic_write_checks(iocb, from);
>  	if (res > 0) {
>  		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
> @@ -1559,7 +1595,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
> @@ -2901,6 +2940,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
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

Given you are relaxing this only for DIRECT writes (and not other kind of
writes), should we call it say "FOPEN_PARALLEL_DIRECT_WRITES" instead?

Thanks
Vivek

>  
>  /**
>   * INIT request/reply flags
> -- 
> 2.17.1
> 

