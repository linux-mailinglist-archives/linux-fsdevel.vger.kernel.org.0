Return-Path: <linux-fsdevel+bounces-43607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 629E7A59708
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 15:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B26E3A68EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 14:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3552522CBE9;
	Mon, 10 Mar 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5XGRvwZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBEF22B8AC;
	Mon, 10 Mar 2025 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615522; cv=none; b=uegwPaJ8O9JCB/w7EqD/8pNzUS3wW6Z5vHQyc1NYi/vDP7jusal+m+86WQcmJ70MkViSgrZb3FwRX88nDlvKm0RxHdj9qExPgoNLVug0sIT1W+WdUJAaFuqOoIeuktRQ+QeMMYQnoxxxHYFVqFn7BZ8OjlY3afuQ8p059TER8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615522; c=relaxed/simple;
	bh=F7wYKTOe6+jd+ruufV0X7KIuKLec2Uh/aLLg/kLZ+n8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=dgs3l0NQ7ndXAuqeWaQdKnALQCBT71XLYpU91DHxOEYFa1dqSVd5A2jErmN8k2SwNEQ4IY5Qt2jT/J+H6CwSZiNlp3Xf89TRRXiWywwSyuCY1U+gV4Kksxl9EwqutMjsT7vYJBd9qrRFeKgBd0n9s1cOQB4u4ekD9sj9qc1GnD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5XGRvwZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff087762bbso6227651a91.3;
        Mon, 10 Mar 2025 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741615520; x=1742220320; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MzKQ5kle7OYFD1lIvSHNDNNcDdRE5uJigG6WXMzqgno=;
        b=Z5XGRvwZF4JibEJge7MjHdDPKmcwHolFJoNOZwxpSQF0DdSr/ZUU1tE9KDTuO7Lv+t
         18tDa5cRCN+hQGBfwub3eeSgh7u9vrpjomM+MM9LlLMdXJf2XvJ34oSLkhpGLngk4pgk
         LcxjUFxGwYL45/jG49ObLQpeWSUUo0+bEEL93BDeKFQhqzZgwxWdbwk+wgmoR5e6meJA
         +EGyDzndGzW6JPclK/yAdHJQP5yxQq8Be9MFV/DhnL/m5jza+5SDA7v5NpgLm1DPWPwR
         HRHQiTdM7q9342jRQ0NtF9u2S1aY1Qt0kh1XZ+U6tHa8qSDuo5Zw4PbZi5GXUehiTJi3
         D97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741615520; x=1742220320;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzKQ5kle7OYFD1lIvSHNDNNcDdRE5uJigG6WXMzqgno=;
        b=vMDKu0wcZcq/zFnN+ALaDWaHt1urJhm2csq0BQQ9LsOzr/uxcGE9NFAKmiO4ZcAYIY
         LCacKZ+wR1cJlpiKb7iALw/OULFrQ/vXQBdL+JCBsM5+WOGZQJQUIcU0jAbuhR9z80GB
         6/QCu6t8LbFF3vbv/2cUIpt2b6Gv4PV56MYh8ugHYIZl1Znfw+eBRtQddymr9YkDgnou
         DrtdLeNk2/vU16NptH1d8XHVZFaBP5UjiNB1qAavww9RjLCoJjXSYOBTzsHFpVClH+RW
         yKmod819YkqBKOdMVlBb8l+IWXhK8ggaCi6iqM1Eo5erWBd9VuGmxzs0/7bg4Y7LCHLi
         sWrA==
X-Forwarded-Encrypted: i=1; AJvYcCVno0SKJz92wvh8NX1tmQmh61Mq57DcZyPGDhGaZvd01POkbSzjOz00Ltn567n9dT3Yw+TVM6CeGxfhEoCP4g==@vger.kernel.org, AJvYcCWDmh19Bzeuam9IOLdEv8v/DptGiFYVufo7Wb7ik/yaxlyn1h/U+YgS2mjSjvClDoGKNum8CDOB4oYfCcze@vger.kernel.org, AJvYcCXTzOqFMm5QoQ9cQ93E5LqTUMBHV5RtXsNgj6GeiN0na3fzgeYKkUYXxtm87zc+EM/s/venwBeyMAa/@vger.kernel.org
X-Gm-Message-State: AOJu0YwEG0gNlUhDlLlFzDsvdxhhGS8iBRAQgZlVuTn9gxFxf4eYaDnS
	wNvnxi40H+D9KHELQ1XMhGIEZN5W6MhBiSMmhEuEhNv8v0NuInOA
X-Gm-Gg: ASbGnctqKK8TqVRNU2VzzUmGzlfpa3vKXs7RxWnTbpwX22+Sg7Y4tYpwvVzKSoqJfMX
	1gkp3QZiXkA9B8iSqLFALW2IjszPN0p7D/l+BAI3Lytmg5mNnG2NsTrwcA7oLafcMigwq1/77z2
	nkavd7XjRdY8PUfitgu4e1yGyFi51ewKVN/idQfcLRNre5emCMsWbtnhn9OE15kkrubB8Tf97x9
	KAAHOYHxHCQYILMAJxWr9MCUkBLtm7/wdvIuUplKJo3HCYz1iObnP+T+gRZkrqp/8nqFnm287Gp
	DCMsA5MFFHR5D9PAZUXVlrheGNAoIm3b53o=
X-Google-Smtp-Source: AGHT+IHkPVP3yWj52JRmym2Q5nBKjLeeY2l9FLHJLbbJrCATuEzy8cc/oFaf5NGDUUJNpLk9J+huRA==
X-Received: by 2002:a17:90b:1d04:b0:2ff:698d:ef7c with SMTP id 98e67ed59e1d1-2ff7cf29cadmr21318903a91.29.1741615520110;
        Mon, 10 Mar 2025 07:05:20 -0700 (PDT)
Received: from dw-tp ([171.76.82.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dd51bsm77999595ad.49.2025.03.10.07.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:05:19 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 09/12] xfs: Add xfs_file_dio_write_atomic()
In-Reply-To: <20250303171120.2837067-10-john.g.garry@oracle.com>
Date: Mon, 10 Mar 2025 19:09:39 +0530
Message-ID: <877c4x57j8.fsf@gmail.com>
References: <20250303171120.2837067-1-john.g.garry@oracle.com> <20250303171120.2837067-10-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.
>
> In case of -EAGAIN being returned from iomap_dio_rw(), reissue the write
> in CoW-based atomic write mode.
>
> For CoW-based mode, ensure that we have no outstanding IOs which we
> may trample on.
>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 51b4a43d15f3..70eb6928cf63 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -619,6 +619,46 @@ xfs_file_dio_write_aligned(
>  	return ret;
>  }
>  
> +static noinline ssize_t
> +xfs_file_dio_write_atomic(
> +	struct xfs_inode	*ip,
> +	struct kiocb		*iocb,
> +	struct iov_iter		*from)
> +{
> +	unsigned int		iolock = XFS_IOLOCK_SHARED;
> +	unsigned int		dio_flags = 0;
> +	ssize_t			ret;
> +
> +retry:
> +	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
> +	if (ret)
> +		return ret;
> +
> +	ret = xfs_file_write_checks(iocb, from, &iolock);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (dio_flags & IOMAP_DIO_FORCE_WAIT)
> +		inode_dio_wait(VFS_I(ip));
> +
> +	trace_xfs_file_direct_write(iocb, from);
> +	ret = iomap_dio_rw(iocb, from, &xfs_atomic_write_iomap_ops,
> +			&xfs_dio_write_ops, dio_flags, NULL, 0);
> +
> +	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
> +	    !(dio_flags & IOMAP_DIO_ATOMIC_SW)) {
> +		xfs_iunlock(ip, iolock);
> +		dio_flags = IOMAP_DIO_ATOMIC_SW | IOMAP_DIO_FORCE_WAIT;
> +		iolock = XFS_IOLOCK_EXCL;
> +		goto retry;
> +	}

IIUC typically filesystems can now implement support for IOMAP_ATOMIC_SW
as a fallback mechanism, by returning -EAGAIN error during
IOMAP_ATOMIC_HW handling from their ->iomap_begin() routine.  They can
then retry the entire DIO operation of iomap_dio_rw() by passing
IOMAP_DIO_ATOMIC_SW flag in their dio_flags argument and handle
IOMAP_ATOMIC_SW fallback differently in their ->iomap_begin() routine.

However, -EAGAIN can also be returned when there is a race with mmap
writes for the same range. We return the same -EAGAIN error during page
cache invalidation failure for IOCB_ATOMIC writes too.  However, current
code does not differentiate between these two types of failures. Therefore,
we always retry by falling back to SW CoW based atomic write even for
page cache invalidation failures.

__iomap_dio_rw()
{
<...>
		/*
		 * Try to invalidate cache pages for the range we are writing.
		 * If this invalidation fails, let the caller fall back to
		 * buffered I/O.
		 */
		ret = kiocb_invalidate_pages(iocb, iomi.len);
		if (ret) {
			if (ret != -EAGAIN) {
				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
								iomi.len);
				if (iocb->ki_flags & IOCB_ATOMIC) {
					/*
					 * folio invalidation failed, maybe
					 * this is transient, unlock and see if
					 * the caller tries again.
					 */
					ret = -EAGAIN;
				} else {
					/* fall back to buffered write */
					ret = -ENOTBLK;
				}
			}
			goto out_free_dio;
		}
<...>
}

It's easy to miss such error handling conditions. If this is something
which was already discussed earlier, then perhaps it is better if
document this.  BTW - Is this something that we already know of and has
been kept as such intentionally?


-ritesh


> +
> +out_unlock:
> +	if (iolock)
> +		xfs_iunlock(ip, iolock);
> +	return ret;
> +}
> +
>  /*
>   * Handle block unaligned direct I/O writes
>   *
> @@ -723,6 +763,8 @@ xfs_file_dio_write(
>  		return -EINVAL;
>  	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
>  		return xfs_file_dio_write_unaligned(ip, iocb, from);
> +	if (iocb->ki_flags & IOCB_ATOMIC)
> +		return xfs_file_dio_write_atomic(ip, iocb, from);
>  	return xfs_file_dio_write_aligned(ip, iocb, from);
>  }
>  
> -- 
> 2.31.1

