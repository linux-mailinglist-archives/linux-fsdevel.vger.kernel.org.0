Return-Path: <linux-fsdevel+bounces-36662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239119E777E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 18:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035C116BFF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92842206B2;
	Fri,  6 Dec 2024 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u779ivq5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43656220687;
	Fri,  6 Dec 2024 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506540; cv=none; b=Vp7bVDJChTUzNVrGaHwYuuWX2dUZg2FhnVQaFtsR78kEo4UWQ5m8bd1AnkIdjbmj9Vp7awkt3RXkttc2Syx3UHGclFMuQOHTUvaO63GTav3VBoobz4KMfVrQAO56oLhonTE9hGUZUhnZavBAWOkA879BTrNH7pdTxqWsugRDqnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506540; c=relaxed/simple;
	bh=ml4wCe8+4O3h3jjAznKlCNTzTZpIkv4tLb/kiCGnGE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9LzzWtwi6wIYZRcP6IvYEfFMWLKzSDpxP5TJ9u396ReYZLsRQK79TqVuY75vj+TjjwgTDaixY8+eSbwepcbomN+HVkcgRAtpFIxCx2l5nMgM9FVPqfRZBkc7jn58nrf3loRbWPZQYaNcgckdiR0Tw5l24eEdKv5y475ctUg04U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u779ivq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CD5C4CED1;
	Fri,  6 Dec 2024 17:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733506539;
	bh=ml4wCe8+4O3h3jjAznKlCNTzTZpIkv4tLb/kiCGnGE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u779ivq5sT3CNXg9/WIqZL8Dhfjqt8n2kva4qkAiMmn7IuEBySJ8LKx9GgjsF/lCe
	 ZMLQAaSaJETnegUlAVDhYuRE5qJlru62s6F7bPIwhlUCSKNJZssrehe+iicWOD2kGi
	 HkNEYYV3B+anG1hyIQ2QsqO8qeOecvKHDDlAWhdC/CSp0XzF30cSmmSoWZPaHX/SPY
	 QJIjiL8nCtqw0t1iKyM046Vhm6htmG9uTA7++pieHnxqGOGFEfRIzuZX2ag2iz279F
	 o9aeg3bC8vJkMx68pPGQGvRJCEOqNz4goovWwZc2pQT5Xe6anX4GOVPmMzwAPn/68l
	 XB0FlzqBOEgyg==
Date: Fri, 6 Dec 2024 09:35:39 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, bfoster@redhat.com
Subject: Re: [PATCH 07/12] fs: add RWF_UNCACHED iocb and FOP_UNCACHED
 file_operations flag
Message-ID: <20241206173539.GA7816@frogsfrogsfrogs>
References: <20241203153232.92224-2-axboe@kernel.dk>
 <20241203153232.92224-9-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203153232.92224-9-axboe@kernel.dk>

On Tue, Dec 03, 2024 at 08:31:43AM -0700, Jens Axboe wrote:
> If a file system supports uncached buffered IO, it may set FOP_UNCACHED
> and enable RWF_UNCACHED. If RWF_UNCACHED is attempted without the file
> system supporting it, it'll get errored with -EOPNOTSUPP.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  include/linux/fs.h      | 14 +++++++++++++-
>  include/uapi/linux/fs.h |  6 +++++-
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7e29433c5ecc..b64a78582f06 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -322,6 +322,7 @@ struct readahead_control;
>  #define IOCB_NOWAIT		(__force int) RWF_NOWAIT
>  #define IOCB_APPEND		(__force int) RWF_APPEND
>  #define IOCB_ATOMIC		(__force int) RWF_ATOMIC
> +#define IOCB_UNCACHED		(__force int) RWF_UNCACHED
>  
>  /* non-RWF related bits - start at 16 */
>  #define IOCB_EVENTFD		(1 << 16)
> @@ -356,7 +357,8 @@ struct readahead_control;
>  	{ IOCB_SYNC,		"SYNC" }, \
>  	{ IOCB_NOWAIT,		"NOWAIT" }, \
>  	{ IOCB_APPEND,		"APPEND" }, \
> -	{ IOCB_ATOMIC,		"ATOMIC"}, \
> +	{ IOCB_ATOMIC,		"ATOMIC" }, \
> +	{ IOCB_UNCACHED,	"UNCACHED" }, \
>  	{ IOCB_EVENTFD,		"EVENTFD"}, \
>  	{ IOCB_DIRECT,		"DIRECT" }, \
>  	{ IOCB_WRITE,		"WRITE" }, \
> @@ -2127,6 +2129,8 @@ struct file_operations {
>  #define FOP_UNSIGNED_OFFSET	((__force fop_flags_t)(1 << 5))
>  /* Supports asynchronous lock callbacks */
>  #define FOP_ASYNC_LOCK		((__force fop_flags_t)(1 << 6))
> +/* File system supports uncached read/write buffered IO */
> +#define FOP_UNCACHED		((__force fop_flags_t)(1 << 7))
>  
>  /* Wrap a directory iterator that needs exclusive inode access */
>  int wrap_directory_iterator(struct file *, struct dir_context *,
> @@ -3614,6 +3618,14 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
>  		if (!(ki->ki_filp->f_mode & FMODE_CAN_ATOMIC_WRITE))
>  			return -EOPNOTSUPP;
>  	}
> +	if (flags & RWF_UNCACHED) {

Should FMODE_NOREUSE imply RWF_UNCACHED?  I know, I'm dredging this up
again from v3:

https://lore.kernel.org/linux-fsdevel/ZzKn4OyHXq5r6eiI@dread.disaster.area/

but the manpage for fadvise says NOREUSE means "The specified data will
be accessed only once." and I think that fits what you're doing here.
And yeah, it's annoying that people keep asking for moar knobs to tweak
io operations: Let's have a mount option, and a fadvise mode, and a
fcntl mode, and finally per-io flags!  (mostly kidding)

Also, one of your replies referenced a poc to set UNCACHED on NOREUSE
involving willy and yu.  Where was that?  I've found this:

https://lore.kernel.org/linux-fsdevel/ZzI97bky3Rwzw18C@casper.infradead.org/

but that turned into a documentation discussion.

There were also a few unanswered questions (imo) from the last few
iterations of this patchset.

If someone issues a lot of small appending uncached writes to a file,
does that mean the writes and writeback will now be lockstepping each
other to write out the folio?  Or should programs simply not do that?

What if I wanted to do a bunch of small writes to adjacent bytes,
amortize writeback over a single disk io, and not wait for reclaim to
drop the folio?  Admittedly that doesn't really fit with "will be
accessed only once" so I think "don't do that" is an acceptable answer.

And, I guess if the application really wants fine-grained control then
it /can/ still pwrite, sync_file_range, and fadvise(WONTNEED).  Though
that's three syscalls/uring ops/whatever.  But that might be cheaper
than repeated rewrites.

--D

> +		/* file system must support it */
> +		if (!(ki->ki_filp->f_op->fop_flags & FOP_UNCACHED))
> +			return -EOPNOTSUPP;
> +		/* DAX mappings not supported */
> +		if (IS_DAX(ki->ki_filp->f_mapping->host))
> +			return -EOPNOTSUPP;
> +	}
>  	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
>  	if (flags & RWF_SYNC)
>  		kiocb_flags |= IOCB_DSYNC;
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 753971770733..dc77cd8ae1a3 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -332,9 +332,13 @@ typedef int __bitwise __kernel_rwf_t;
>  /* Atomic Write */
>  #define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000040)
>  
> +/* buffered IO that drops the cache after reading or writing data */
> +#define RWF_UNCACHED	((__force __kernel_rwf_t)0x00000080)
> +
>  /* mask of flags supported by the kernel */
>  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
> -			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC)
> +			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
> +			 RWF_UNCACHED)
>  
>  #define PROCFS_IOCTL_MAGIC 'f'
>  
> -- 
> 2.45.2
> 
> 

