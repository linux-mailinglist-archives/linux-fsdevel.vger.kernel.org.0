Return-Path: <linux-fsdevel+bounces-20563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9988D5208
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 21:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECC51F23244
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 19:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8155558AB;
	Thu, 30 May 2024 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0MLFPAB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4559D18756C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717095656; cv=none; b=Hnzv2QIH0AA+YkdWH4Z2Z+vz0q/qS8FssF6vUiFlkb2O0SOEZAEsTUafZC5OcQUiVg7KnVLXPebekvPBzNQV50IQENI0z6Fe7ninM7aHaooD8630gHR0qbCFtMZXmKQt1JzFn7TpJKu4oIhzL90bjxku7CDI5SACirUak5zO0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717095656; c=relaxed/simple;
	bh=coG0iSdStGRRkZOHoqIhp+sX+Ub/VXE/9UNIB0dzyP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCRS4WXzobNL+qborBmFO0DlmWy9zm1dixG5v6uXYd5arMTHkck5nIa1lufwZJreSJo2154S1AfdOCG/Dya79AtLdqXW+Fkx6RHKrvLqxll7fYo9w0UhTRFXAq8oncSP7jTyesXGIHlkRnV4quRqJPhkIbpvAftNnZoCjs7VtJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0MLFPAB+; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7e238fa7b10so51661239f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717095653; x=1717700453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VakqD08EEz8RYq848OzpHRbO3fabiRdOrW60Ka7AvQ=;
        b=0MLFPAB+zYUsDRyLnXtf9hBA6EjGSt5TJprLe9eK5E3DhEuWqsXtr/gXLx77+c5M6v
         yFOtQ3f5qhWWDgtcVD834TMNb5CJEOLel3XfaADLvbVQ68F/i5u6VaTVQOeH+8zJg3lZ
         OQRggQ7fxpWfPWvSQO1BDe3lkXg1+tZ6t91R+Kc5XupkzxOnwlIHYg8PJnVfjoksBlfb
         pxJxHhs3OAgppwE7DjZVfnBvPiLAxuR0bBxolB0zGAVNhZ6TYstpvZG5oPN8sV5ZrxWI
         1RjZvzGhQTSvJ9sJty7zNWjQsC7/XPsRqYUvyERCsqWMQmkst6wv1i6mxFIthSbUOaKh
         A7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717095653; x=1717700453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VakqD08EEz8RYq848OzpHRbO3fabiRdOrW60Ka7AvQ=;
        b=DnWfWK35ZDvJpv4yxNsLG2focW97wr8z4pzGwNHZMna/AcFQKEZd90HqnZ0m+GsDpw
         T0s1jiMbQ12xwTU+rvfInbHzp55vsJEN73ojYAsiET6qH21jgUyR0cPujh9tEu7qj4GH
         WQMbo3+jB8Xh+zrkiidz4rGqEh22uBJMR3s1PYGBAqv0BF7wtrl7Flt2gmw65OdHx8rK
         7eb882xPEQNGy8LHs+7jRsWyNdKS2pMueerPNIu9Yqb2i44S0SB7BIVPVMDsffZFf1kd
         zq8Ub3luDpAzXTl4zXr6NQSafQbADsmr8TFynzSgHaGOPpQvQfP9kI/d2IqXWoGPLPId
         JvTw==
X-Forwarded-Encrypted: i=1; AJvYcCWacoEXZkSY02EAHrCfYCL3miVnZOaQeBJidZFiKB9Sw36mTDehtpojYjFAsA4rEpR7NvtMH1BOidSmj5a1qRsSCuC8kR2S6HJw6igMRw==
X-Gm-Message-State: AOJu0YwxjLMIVIvKo/Lu1H6Iyq2ajUmLO0Ic1oPl6ZaMfXNhSEujhCC1
	6BY/R3+7cbdKjxsx61D6v3MkRYwXScpdpcKdRbeyjOj9ei8kIes9DiCBnJRB7O0=
X-Google-Smtp-Source: AGHT+IETmLoUKFWUUlWAXMEIL4ZUEwYLqHxhrSt4YV6s4OG4P9MgrqoG+/wxcSxz+9VEmFXblikORg==
X-Received: by 2002:a05:6e02:19cc:b0:374:4edd:1fd2 with SMTP id e9e14a558f8ab-3747dfbc8c0mr33137555ab.28.1717095651295;
        Thu, 30 May 2024 12:00:51 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f2f128ecsm6431585a.42.2024.05.30.12.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 12:00:50 -0700 (PDT)
Date: Thu, 30 May 2024 15:00:49 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm
Subject: Re: [PATCH RFC v2 09/19] fuse: {uring} Add a dev_release exception
 for fuse-over-io-uring
Message-ID: <20240530190049.GF2205585@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-9-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-9-d149476b1d65@ddn.com>

On Wed, May 29, 2024 at 08:00:44PM +0200, Bernd Schubert wrote:
> fuse-over-io-uring needs an implicit device clone, which is done per
> queue to avoid hanging "umount" when daemon side is already terminated.
> Reason is that fuse_dev_release() is not called when there are queued
> (waiting) io_uring commands.
> Solution is the implicit device clone and an exception in fuse_dev_release
> for uring devices to abort the connection when only uring device
> are left.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c         | 32 ++++++++++++++++++++++++++++++--
>  fs/fuse/dev_uring_i.h | 13 +++++++++++++
>  2 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 78c05516da7f..cd5dc6ae9272 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2257,6 +2257,8 @@ int fuse_dev_release(struct inode *inode, struct file *file)
>  		struct fuse_pqueue *fpq = &fud->pq;
>  		LIST_HEAD(to_end);
>  		unsigned int i;
> +		int dev_cnt;
> +		bool abort_conn = false;
>  
>  		spin_lock(&fpq->lock);
>  		WARN_ON(!list_empty(&fpq->io));
> @@ -2266,8 +2268,34 @@ int fuse_dev_release(struct inode *inode, struct file *file)
>  
>  		fuse_dev_end_requests(&to_end);
>  
> -		/* Are we the last open device? */
> -		if (atomic_dec_and_test(&fc->dev_count)) {
> +		/* Are we the last open device?  */
> +		dev_cnt = atomic_dec_return(&fc->dev_count);
> +		if (dev_cnt == 0)
> +			abort_conn = true;

You can just do

if (atomic_dec_and_test(&fc->dev_count))
	abort_conn = true;
else if (fuse_uring_configured(fc))
	abort_conn = fuse_uring_empty(fc);

and have fuse_uring_empty() do the work below to find if we're able to abort the
connection, so it's in it's own little helper.

> +
> +		/*
> +		 * Or is this with io_uring and only ring devices left?
> +		 * These devices will not receive a ->release() as long as
> +		 * there are io_uring_cmd's waiting and not completed
> +		 * with io_uring_cmd_done yet
> +		 */
> +		if (fuse_uring_configured(fc)) {
> +			struct fuse_dev *list_dev;
> +			bool all_uring = true;
> +
> +			spin_lock(&fc->lock);
> +			list_for_each_entry(list_dev, &fc->devices, entry) {
> +				if (list_dev == fud)
> +					continue;
> +				if (!list_dev->uring_dev)
> +					all_uring = false;
> +			}
> +			spin_unlock(&fc->lock);
> +			if (all_uring)
> +				abort_conn = true;
> +		}
> +
> +		if (abort_conn) {
>  			WARN_ON(fc->iq.fasync != NULL);
>  			fuse_abort_conn(fc);
>  		}
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 7a2f540d3ea5..114e9c008013 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -261,6 +261,14 @@ fuse_uring_get_queue(struct fuse_ring *ring, int qid)
>  	return (struct fuse_ring_queue *)(ptr + qid * ring->queue_size);
>  }
>  
> +static inline bool fuse_uring_configured(struct fuse_conn *fc)
> +{
> +	if (READ_ONCE(fc->ring) != NULL && fc->ring->configured)
> +		return true;

I see what you're trying to do here, and it is safe because you won't drop
fc->ring at this point, but it gives the illusion that it'll work if we race
with somebody who is freeing fc->ring, which isn't the case because you
immediately de-reference it again afterwards.

Using READ_ONCE/WRITE_ONCE for pointer access isn't actually safe unless you're
documenting it specifically, don't use it unless you really need lockless access
to the thing.

If we know that having fc means that fc->ring will be valid at all times then
the READ_ONCE is redundant and unnecessary, if we don't know that then this
needs more protection to make sure we don't suddenly lose fc->ring between the
two statements.

AFAICT if we have fc then ->ring will either be NULL or it won't be (once the
connection is established and running), so it's fine to just delete the
READ_ONCE/WRITE_ONCE things.  Thanks,

Josef

