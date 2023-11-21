Return-Path: <linux-fsdevel+bounces-3317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7146C7F3264
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 16:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F9E1C208FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78C15810B;
	Tue, 21 Nov 2023 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMJRhxWR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FF15677C
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 15:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A91CC433CC;
	Tue, 21 Nov 2023 15:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700580860;
	bh=7rYmzI7IJ6hyZNa8SfZjeT9gPlU7StkC0iMs2Q9XN7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMJRhxWRBGZWPL/z8J7IYM+anWTwstpEbWyzd8FhiBPtvCtk5qV5YccC3XP8YdmrZ
	 u1LeT7OURUzjgF4F7z7+mw9Jgkxvasv/zb5MEh10y0+7mksq7oSyU+NJBh2H1B6baR
	 kM9ueonYF4wvWQkkBNWGAs+4L+8GwtqCQUiG2eqJYS9pVINyFDNp+saZqXTX9KJrgo
	 XZe3t8lZ8rByrRwH3LuvFT9pfj0RKKTNf/evsdhM/wQ1NpCQSIGq6q6uYrkUlo7B3J
	 rji9PsZ9G5gN5w5QKWbWJeOzu8hgnRJMyNcaTBzEFd6OlORgr2L2VPFh6xK4/cmICq
	 Vwed95NgmPgig==
Date: Tue, 21 Nov 2023 16:34:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/15] fs: move permission hook out of do_iter_write()
Message-ID: <20231121-morgig-chipkarte-97884b133371@brauner>
References: <20231114153321.1716028-1-amir73il@gmail.com>
 <20231114153321.1716028-11-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231114153321.1716028-11-amir73il@gmail.com>

On Tue, Nov 14, 2023 at 05:33:16PM +0200, Amir Goldstein wrote:
> In many of the vfs helpers, the rw_verity_area() checks are called before
> taking sb_start_write(), making them "start-write-safe".
> do_iter_write() is an exception to this rule.
> 
> do_iter_write() has two callers - vfs_iter_write() and vfs_writev().
> Move rw_verify_area() and other checks from do_iter_write() out to
> its callers to make them "start-write-safe".
> 
> Move also the fsnotify_modify() hook to align with similar pattern
> used in vfs_write() and other vfs helpers.
> 
> This is needed for fanotify "pre content" events.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/read_write.c | 76 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 46 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 8cdc6e6a9639..d4891346d42e 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -848,28 +848,10 @@ EXPORT_SYMBOL(vfs_iter_read);
>  static ssize_t do_iter_write(struct file *file, struct iov_iter *iter,
>  			     loff_t *pos, rwf_t flags)
>  {
> -	size_t tot_len;
> -	ssize_t ret = 0;
> -
> -	if (!(file->f_mode & FMODE_WRITE))
> -		return -EBADF;
> -	if (!(file->f_mode & FMODE_CAN_WRITE))
> -		return -EINVAL;
> -
> -	tot_len = iov_iter_count(iter);
> -	if (!tot_len)
> -		return 0;
> -	ret = rw_verify_area(WRITE, file, pos, tot_len);
> -	if (ret < 0)
> -		return ret;
> -
>  	if (file->f_op->write_iter)
> -		ret = do_iter_readv_writev(file, iter, pos, WRITE, flags);
> +		return do_iter_readv_writev(file, iter, pos, WRITE, flags);
>  	else
> -		ret = do_loop_readv_writev(file, iter, pos, WRITE, flags);
> -	if (ret > 0)
> -		fsnotify_modify(file);
> -	return ret;
> +		return do_loop_readv_writev(file, iter, pos, WRITE, flags);

Nit, this will end up being:

static ssize_t do_iter_write(struct file *file, struct iov_iter *iter,
                             loff_t *pos, rwf_t flags)
{
        if (file->f_op->write_iter)
                return do_iter_readv_writev(file, iter, pos, WRITE, flags);
        else
                return do_loop_readv_writev(file, iter, pos, WRITE, flags);
}

which is probably best written as:

static ssize_t do_iter_write(struct file *file, struct iov_iter *iter,
                             loff_t *pos, rwf_t flags)
{
        if (file->f_op->write_iter)
                return do_iter_readv_writev(file, iter, pos, WRITE, flags);

        return do_loop_readv_writev(file, iter, pos, WRITE, flags);
}

