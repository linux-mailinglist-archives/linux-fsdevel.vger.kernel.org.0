Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A377B274400
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 16:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgIVOSB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 10:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgIVOSB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:18:01 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6D6C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 07:18:01 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d20so19162904qka.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 07:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TP7WW6V2WlFkm4YOA5DbswwIEfm2T1k9LUW/JDxwHMQ=;
        b=uYxUaJAKyvKzep/JhSZloI/JGiE4oOVwDCau09odI07DaCQ0ZzDErcAsx+YXnlOPB/
         eeKTV84vItuUjkMMEirrL4j9v5v8udgxPVm9wk/8lLIwk7b/YK0JMBoL2YIONWrVq43n
         UBmaMQclonkzYOd2SR8U3ZMOvtcBjBfgtERfPM2fq0Z6+qo5vbVUfRCwXpaSomDIrkut
         TA84lM5AgEjgQqVAGZwQfI7kr3/+FOBGLhIKKAgVVdxBItrwE4K29oe24Auws6mYlj+C
         dydTpRDmF+9K3xoUh2Wsylasd3mc9TpznXeTp3wcOBqCXbaxif5ANtjRkz5A6cJKHIOz
         M0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TP7WW6V2WlFkm4YOA5DbswwIEfm2T1k9LUW/JDxwHMQ=;
        b=d3uDHkR+x2hu45+AJyVhapn6dUgHgj9RINz6U2ehUgdYYkAKDj1A1yEnqs5n7cBuhW
         r04bcKwvHlMmmfGxU/gV/ORpKXEt/BafmpgvLs0fjW+CpN71g75Wo3eIMSnqBH6Uh7q4
         6A5YpDK9gEBRGDsOKETpJDhEpXNe/JDWiWUOWgGJmF0EvIyemt77HdC40VVv52cqeK/8
         rJOri5e+N/FEWLx8NkIe8rG4t9XnMdIty3Na8W/FsrHc+zSjTwQWwDpHZvx71U8iN33d
         fhPXK/nQTC1qElrIp3aJYYFMQzloDGBRPaVIOH+F5Aj7uRTpuYWMfRWT9raAf0PWYnUs
         6isQ==
X-Gm-Message-State: AOAM533/W6R7n10j9ogMkfqh/m2QxqM3hTm3vDYwo+I92+Z3alCAS0Pe
        9BOf5FkkoReijTdNw07Ar4KuZRT0DO0+GxIrsq0=
X-Google-Smtp-Source: ABdhPJwCKv3NhKucIaQsvV3pi1VTtlsX+eWxacLzj4qpCyOh/I7DAmgLV+kv2yB/i0ZTAR2EDS7+dg==
X-Received: by 2002:a37:d44:: with SMTP id 65mr4964199qkn.399.1600784280197;
        Tue, 22 Sep 2020 07:18:00 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z7sm2725764qtc.10.2020.09.22.07.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 07:17:59 -0700 (PDT)
Subject: Re: [PATCH 03/15] iomap: Allow filesystem to call iomap_dio_complete
 without i_rwsem
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-4-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9c669220-a5d9-48fe-8e0e-e2c3d3de5695@toxicpanda.com>
Date:   Tue, 22 Sep 2020 10:17:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921144353.31319-4-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> This is to avoid the deadlock caused in btrfs because of O_DIRECT |
> O_DSYNC.
> 
> Filesystems such as btrfs require i_rwsem while performing sync on a
> file. iomap_dio_rw() is called under i_rw_sem. This leads to a
> deadlock because of:
> 
> iomap_dio_complete()
>    generic_write_sync()
>      btrfs_sync_file()
> 
> Separate out iomap_dio_complete() from iomap_dio_rw(), so filesystems
> can call iomap_dio_complete() after unlocking i_rwsem.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>   fs/iomap/direct-io.c  | 34 +++++++++++++++++++++++++---------
>   include/linux/iomap.h |  5 +++++
>   2 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index c1aafb2ab990..d970c6bbbe11 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -76,7 +76,7 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
>   		dio->submit.cookie = submit_bio(bio);
>   }
>   
> -static ssize_t iomap_dio_complete(struct iomap_dio *dio)
> +ssize_t iomap_dio_complete(struct iomap_dio *dio)
>   {
>   	const struct iomap_dio_ops *dops = dio->dops;
>   	struct kiocb *iocb = dio->iocb;
> @@ -130,6 +130,7 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
>   
>   	return ret;
>   }
> +EXPORT_SYMBOL_GPL(iomap_dio_complete);
>   
>   static void iomap_dio_complete_work(struct work_struct *work)
>   {
> @@ -406,8 +407,8 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>    * Returns -ENOTBLK In case of a page invalidation invalidation failure for
>    * writes.  The callers needs to fall back to buffered I/O in this case.
>    */
> -ssize_t
> -iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> +struct iomap_dio *
> +__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>   		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>   		bool wait_for_completion)
>   {
> @@ -421,14 +422,14 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>   	struct iomap_dio *dio;
>   
>   	if (!count)
> -		return 0;
> +		return NULL;
>   
>   	if (WARN_ON(is_sync_kiocb(iocb) && !wait_for_completion))
> -		return -EIO;
> +		return ERR_PTR(-EIO);
>   
>   	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
>   	if (!dio)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>   
>   	dio->iocb = iocb;
>   	atomic_set(&dio->ref, 1);
> @@ -558,7 +559,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>   	dio->wait_for_completion = wait_for_completion;
>   	if (!atomic_dec_and_test(&dio->ref)) {
>   		if (!wait_for_completion)
> -			return -EIOCBQUEUED;
> +			return ERR_PTR(-EIOCBQUEUED);
>   
>   		for (;;) {
>   			set_current_state(TASK_UNINTERRUPTIBLE);
> @@ -574,10 +575,25 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>   		__set_current_state(TASK_RUNNING);
>   	}
>   
> -	return iomap_dio_complete(dio);
> +	return dio;
>   
>   out_free_dio:
>   	kfree(dio);
> -	return ret;
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(__iomap_dio_rw);
> +
> +ssize_t
> +iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> +		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> +		bool wait_for_completion)
> +{
> +	struct iomap_dio *dio;
> +
> +	dio = __iomap_dio_rw(iocb, iter, ops, dops, wait_for_completion);
> +	if (IS_ERR_OR_NULL(dio))
> +		return PTR_ERR_OR_ZERO(dio);
> +	return iomap_dio_complete(dio);
>   }
>   EXPORT_SYMBOL_GPL(iomap_dio_rw);
> +

Got an extra + here for some reason.  Otherwise

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
