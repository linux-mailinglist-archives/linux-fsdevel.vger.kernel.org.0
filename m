Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A172FDAEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 21:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbhATUfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 15:35:01 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:22466 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388216AbhATU3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:29:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611174524; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=DUldyVZxMpgIEQjSwc3NKK614yX0lFh0/8+DOhlGEf8=; b=rluRFsSTswvQEkiOC6gRJVI4G+q6ohrawrQscOGOE2xq7rpm1QLUEdheUXWKeNAhJKcPNsqy
 M5imUBQ/YMGVNjZN8y8zTkyNL7Lf5burg3adUJY0DfebatKYQOaLLNbAuviPVTR2/fCMXiJo
 kqZmXdp+Bk8XGpm2z1I3ukXaFpA=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60089254beacd1a2525b5af1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Jan 2021 20:28:04
 GMT
Sender: sidgup=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8536BC433ED; Wed, 20 Jan 2021 20:28:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.10] (cpe-75-83-25-192.socal.res.rr.com [75.83.25.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB868C43463;
        Wed, 20 Jan 2021 20:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB868C43463
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sidgup@codeaurora.org
Subject: Re: PROBLEM: Firmware loader fallback mechanism no longer works with
 sendfile
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>
References: <7e6f44b1-a0d2-d1d1-9c11-dcea163f8f03@codeaurora.org>
 <20210120091033.GA3683647@infradead.org>
From:   Siddharth Gupta <sidgup@codeaurora.org>
Message-ID: <c6205eac-582d-6f0b-4ea0-7aa560af2527@codeaurora.org>
Date:   Wed, 20 Jan 2021 12:28:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120091033.GA3683647@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/20/2021 1:10 AM, Christoph Hellwig wrote:
> Can you give this patch a spin?
Thanks! This patch fixed the fallback mechanism for me. Attaching logs:

[   84.410162][  T244] qcom_q6v5_pas xxxxxxxx.remoteproc-cdsp: Direct 
firmware load for cdsp.bX failed with error -2
[   84.418276][  T244] qcom_q6v5_pas xxxxxxxx.remoteproc-cdsp: Falling 
back to sysfs fallback for: cdsp.bX
[   84.471558][  T393] ueventd: firmware: loading 'cdsp.bX' for 
'/devices/platform/soc/xxxxxxxx.remoteproc-cdsp/firmware/cdsp.bX'
[   84.491936][  T393] ueventd: loading 
/devices/platform/soc/xxxxxxxx.remoteproc-cdsp/firmware/cdsp.bX took 22ms
[  103.331486][  T244] remoteproc remoteproc1: remote processor 
xxxxxxxx.remoteproc-cdsp is now up


- Sid
>
>
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index f277d023ebcd14..4b5833b3059f9c 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -14,6 +14,7 @@
>   #include <linux/pagemap.h>
>   #include <linux/sched/mm.h>
>   #include <linux/fsnotify.h>
> +#include <linux/uio.h>
>   
>   #include "kernfs-internal.h"
>   
> @@ -180,11 +181,10 @@ static const struct seq_operations kernfs_seq_ops = {
>    * it difficult to use seq_file.  Implement simplistic custom buffering for
>    * bin files.
>    */
> -static ssize_t kernfs_file_direct_read(struct kernfs_open_file *of,
> -				       char __user *user_buf, size_t count,
> -				       loff_t *ppos)
> +static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>   {
> -	ssize_t len = min_t(size_t, count, PAGE_SIZE);
> +	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
> +	ssize_t len = min_t(size_t, iov_iter_count(iter), PAGE_SIZE);
>   	const struct kernfs_ops *ops;
>   	char *buf;
>   
> @@ -210,7 +210,7 @@ static ssize_t kernfs_file_direct_read(struct kernfs_open_file *of,
>   	of->event = atomic_read(&of->kn->attr.open->event);
>   	ops = kernfs_ops(of->kn);
>   	if (ops->read)
> -		len = ops->read(of, buf, len, *ppos);
> +		len = ops->read(of, buf, len, iocb->ki_pos);
>   	else
>   		len = -EINVAL;
>   
> @@ -220,12 +220,12 @@ static ssize_t kernfs_file_direct_read(struct kernfs_open_file *of,
>   	if (len < 0)
>   		goto out_free;
>   
> -	if (copy_to_user(user_buf, buf, len)) {
> +	if (copy_to_iter(buf, len, iter) != len) {
>   		len = -EFAULT;
>   		goto out_free;
>   	}
>   
> -	*ppos += len;
> +	iocb->ki_pos += len;
>   
>    out_free:
>   	if (buf == of->prealloc_buf)
> @@ -235,31 +235,14 @@ static ssize_t kernfs_file_direct_read(struct kernfs_open_file *of,
>   	return len;
>   }
>   
> -/**
> - * kernfs_fop_read - kernfs vfs read callback
> - * @file: file pointer
> - * @user_buf: data to write
> - * @count: number of bytes
> - * @ppos: starting offset
> - */
> -static ssize_t kernfs_fop_read(struct file *file, char __user *user_buf,
> -			       size_t count, loff_t *ppos)
> +static ssize_t kernfs_fop_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>   {
> -	struct kernfs_open_file *of = kernfs_of(file);
> -
> -	if (of->kn->flags & KERNFS_HAS_SEQ_SHOW)
> -		return seq_read(file, user_buf, count, ppos);
> -	else
> -		return kernfs_file_direct_read(of, user_buf, count, ppos);
> +	if (kernfs_of(iocb->ki_filp)->kn->flags & KERNFS_HAS_SEQ_SHOW)
> +		return seq_read_iter(iocb, iter);
> +	return kernfs_file_read_iter(iocb, iter);
>   }
>   
> -/**
> - * kernfs_fop_write - kernfs vfs write callback
> - * @file: file pointer
> - * @user_buf: data to write
> - * @count: number of bytes
> - * @ppos: starting offset
> - *
> +/*
>    * Copy data in from userland and pass it to the matching kernfs write
>    * operation.
>    *
> @@ -269,20 +252,18 @@ static ssize_t kernfs_fop_read(struct file *file, char __user *user_buf,
>    * modify only the the value you're changing, then write entire buffer
>    * back.
>    */
> -static ssize_t kernfs_fop_write(struct file *file, const char __user *user_buf,
> -				size_t count, loff_t *ppos)
> +static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>   {
> -	struct kernfs_open_file *of = kernfs_of(file);
> +	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
> +	ssize_t len = iov_iter_count(iter);
>   	const struct kernfs_ops *ops;
> -	ssize_t len;
>   	char *buf;
>   
>   	if (of->atomic_write_len) {
> -		len = count;
>   		if (len > of->atomic_write_len)
>   			return -E2BIG;
>   	} else {
> -		len = min_t(size_t, count, PAGE_SIZE);
> +		len = min_t(size_t, len, PAGE_SIZE);
>   	}
>   
>   	buf = of->prealloc_buf;
> @@ -293,7 +274,7 @@ static ssize_t kernfs_fop_write(struct file *file, const char __user *user_buf,
>   	if (!buf)
>   		return -ENOMEM;
>   
> -	if (copy_from_user(buf, user_buf, len)) {
> +	if (copy_from_iter(buf, len, iter) != len) {
>   		len = -EFAULT;
>   		goto out_free;
>   	}
> @@ -312,7 +293,7 @@ static ssize_t kernfs_fop_write(struct file *file, const char __user *user_buf,
>   
>   	ops = kernfs_ops(of->kn);
>   	if (ops->write)
> -		len = ops->write(of, buf, len, *ppos);
> +		len = ops->write(of, buf, len, iocb->ki_pos);
>   	else
>   		len = -EINVAL;
>   
> @@ -320,7 +301,7 @@ static ssize_t kernfs_fop_write(struct file *file, const char __user *user_buf,
>   	mutex_unlock(&of->mutex);
>   
>   	if (len > 0)
> -		*ppos += len;
> +		iocb->ki_pos += len;
>   
>   out_free:
>   	if (buf == of->prealloc_buf)
> @@ -960,14 +941,16 @@ void kernfs_notify(struct kernfs_node *kn)
>   EXPORT_SYMBOL_GPL(kernfs_notify);
>   
>   const struct file_operations kernfs_file_fops = {
> -	.read		= kernfs_fop_read,
> -	.write		= kernfs_fop_write,
> +	.read_iter	= kernfs_fop_read_iter,
> +	.write_iter	= kernfs_fop_write_iter,
>   	.llseek		= generic_file_llseek,
>   	.mmap		= kernfs_fop_mmap,
>   	.open		= kernfs_fop_open,
>   	.release	= kernfs_fop_release,
>   	.poll		= kernfs_fop_poll,
>   	.fsync		= noop_fsync,
> +	.splice_read	= generic_file_splice_read,
> +	.splice_write	= iter_file_splice_write,
>   };
>   
>   /**
