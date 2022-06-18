Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9D355068E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 21:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiFRTIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 15:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiFRTIB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 15:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EA43BC33
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655579279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AM3UZHSpCJMXR+Y1qj47nKM43qykwqV0js2+NRaWe2M=;
        b=O3J3PTW+qVpk9q/g00UxfhKlP24yi95BqmVZKysweYvt68L3/kECj5LBKM2aiqjliwrqkW
        2WDd78BnVMDc9tnjXFmDjvhI14wG0W9MZ0vWMnVONkOatBEm+1xsAiJHzIAExyyCcXWO13
        pD1v6dmYEJUPiepjRSYzJZ2o+nV248g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-lw4NCot4N8SrdS_jy3wi_Q-1; Sat, 18 Jun 2022 15:07:53 -0400
X-MC-Unique: lw4NCot4N8SrdS_jy3wi_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 849BC185A79C;
        Sat, 18 Jun 2022 19:07:52 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E472E1415108;
        Sat, 18 Jun 2022 19:07:51 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A21A92209F9; Sat, 18 Jun 2022 15:07:51 -0400 (EDT)
Date:   Sat, 18 Jun 2022 15:07:51 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        bschubert@ddn.com, Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v5 1/1] Allow non-extending parallel direct writes on the
 same file.
Message-ID: <Yq4ih+PQWz6LnDnZ@redhat.com>
References: <20220617071027.6569-1-dharamhans87@gmail.com>
 <20220617071027.6569-2-dharamhans87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617071027.6569-2-dharamhans87@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 17, 2022 at 12:40:27PM +0530, Dharmendra Singh wrote:
> In general, as of now, in FUSE, direct writes on the same file are
> serialized over inode lock i.e we hold inode lock for the full duration
> of the write request. I could not find in fuse code and git history
> a comment which clearly explains why this exclusive lock is taken
> for direct writes.  Following might be the reasons for acquiring
> an exclusive lock but not be limited to
> 1) Our guess is some USER space fuse implementations might be relying
>    on this lock for seralization.
> 2) The lock protects against file read/write size races.
> 3) Ruling out any issues arising from partial write failures.
> 
> This patch relaxes the exclusive lock for direct non-extending writes
> only. File size extending writes might not need the lock either,
> but we are not entirely sure if there is a risk to introduce any
> kind of regression. Furthermore, benchmarking with fio does not
> show a difference between patch versions that take on file size
> extension a) an exclusive lock and b) a shared lock.
> 
> A possible example of an issue with i_size extending writes are write
> error cases. Some writes might succeed and others might fail for
> file system internal reasons - for example ENOSPACE. With parallel
> file size extending writes it _might_ be difficult to revert the action
> of the failing write, especially to restore the right i_size.
> 
> With these changes, we allow non-extending parallel direct writes
> on the same file with the help of a flag called
> FOPEN_PARALLEL_DIRECT_WRITES. If this flag is set on the file (flag is
> passed from libfuse to fuse kernel as part of file open/create),
> we do not take exclusive lock anymore, but instead use a shared lock
> that allows non-extending writes to run in parallel.
> FUSE implementations which rely on this inode lock for serialisation
> can continue to do so and serialized direct writes are still the
> default.  Implementations that do not do write serialization need to
> be updated and need to set the FOPEN_PARALLEL_DIRECT_WRITES flag in
> their file open/create reply.
> 
> On patch review there were concerns that network file systems (or
> vfs multiple mounts of the same file system) might have issues with
> parallel writes. We believe this is not the case, as this is just a
> local lock, which network file systems could not rely on anyway.
> I.e. this lock is just for local consistency.
> 
> Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/file.c            | 43 ++++++++++++++++++++++++++++++++++++---
>  include/uapi/linux/fuse.h |  2 ++
>  2 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 37eebfb90500..b3a5706f301d 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1565,14 +1565,47 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	return res;
>  }
>  
> +static bool fuse_direct_write_extending_i_size(struct kiocb *iocb,
> +					       struct iov_iter *iter)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
> +}
> +
>  static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct file *file = iocb->ki_filp;
> +	struct fuse_file *ff = file->private_data;
>  	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
>  	ssize_t res;
> +	bool exclusive_lock =
> +		!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES) ||
> +		iocb->ki_flags & IOCB_APPEND ||
> +		fuse_direct_write_extending_i_size(iocb, from);
> +
> +	/*
> +	 * Take exclusive lock if
> +	 * - Parallel direct writes are disabled - a user space decision
> +	 * - Parallel direct writes are enabled and i_size is being extended.
> +	 *   This might not be needed at all, but needs further investigation.
> +	 */
> +	if (exclusive_lock)
> +		inode_lock(inode);
> +	else {
> +		inode_lock_shared(inode);
> +
> +		/* A race with truncate might have come up as the decision for
> +		 * the lock type was done without holding the lock, check again.
> +		 */
> +		if (fuse_direct_write_extending_i_size(iocb, from)) {
> +			inode_unlock_shared(inode);
> +			inode_lock(inode);
> +			exclusive_lock = true;
> +		}
> +	}
>  
> -	/* Don't allow parallel writes to the same file */
> -	inode_lock(inode);
>  	res = generic_write_checks(iocb, from);
>  	if (res > 0) {
>  		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
> @@ -1583,7 +1616,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
> @@ -2925,6 +2961,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  
>  	if (iov_iter_rw(iter) == WRITE) {
>  		fuse_write_update_attr(inode, pos, ret);
> +		/* For extending writes we already hold exclusive lock */
>  		if (ret < 0 && offset + count > i_size)
>  			fuse_do_truncate(file);

I was curious about this truncation if ret < 0. I am assuming that this
means if some write failed, do a truncation. Looking at git history
I found following commit.

commit efb9fa9e911b23c7ea5330215bda778a7c69dba8
Author: Maxim Patlasov <mpatlasov@parallels.com>
Date:   Tue Dec 18 14:05:08 2012 +0400

    fuse: truncate file if async dio failed

    The patch improves error handling in fuse_direct_IO(): if we successfully
    submitted several fuse requests on behalf of synchronous direct write
    extending file and some of them failed, let's try to do our best to clean-up.

    Changed in v2: reuse fuse_do_setattr(). Thanks to Brian for suggestion.


What's interesting here is that looks like we already have code to
submit multiple FUSE file extending AIO + DIO requests and then we
wait for completion. So a single write can be be broken into multiple
smaller fuse write requests, IIUC.

I see following.

fuse_direct_IO()
{
        /*
         * We cannot asynchronously extend the size of a file.
         * In such case the aio will behave exactly like sync io.
         */
        if ((offset + count > i_size) && io->write)
                io->blocking = true;
}

This should force the IO to be blocking/synchronous. And looks like
if io->async is set, fuse_direct_io() can still submit multiple
file extending requests and we will wait for completion.

wait_for_completion(&wait);

And truncate the file if some I/O failed. This probably means undo
all the writes we did even if some of them succeeded.

                if (ret < 0 && offset + count > i_size)
                        fuse_do_truncate(file);
        }


Anyway, point I am trying to make is that for a single AIO + DIO file
extending write, looks like existing code might split it into multiple
AIO + DIO file extending writes and wait for their completion. And
if any one of the split requests fails, we need to truncate the file
and undo all the WRITEs. And for truncation we need exclusive lock.
And that leads to the conclusion that we can't hold shared lock
while extending the file otherwise current code will do truncation
with shared lock held and things will be broken somewhere.

Thanks
Vivek

