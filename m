Return-Path: <linux-fsdevel+bounces-13571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9215871236
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 02:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268351C221D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 01:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDE011718;
	Tue,  5 Mar 2024 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAt9nOnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3226D28F1;
	Tue,  5 Mar 2024 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709600887; cv=none; b=YQzXErHG84WVBwYH27QKxEmew5xPahPIK1fCx9Zd4c27p6P8X+fvAaxjrhCyZqr4kYheH5R7fdQc0ZyAf3u2xc9OM/hOjnUHO031SlCF841XDiySLotiBJjhuaj6fItds6spVLb40Acsoav+a3xOoMtJZDVez6YwmjhaWbD088E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709600887; c=relaxed/simple;
	bh=jdjo5rKYG4ZK3OODkKBuqmFXqRUFZ7x80BI7gRk+kAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=livEFFgCSKZcFLcJsQyV+l/jBJIhjxfIIE4M0aOBerYiCXYSwXvZvHhH3akUw0OyZ4KJ2dCFbtGnZpgVC4ihIBxvfpftqLaf4sYORYFJgBdqteCfcqjwejE21M9Ob1LGQdJyO22DVxYu6F+lDV0exwkT8H8pLu2rb1FqlZ+X3po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAt9nOnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11B9C433F1;
	Tue,  5 Mar 2024 01:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709600887;
	bh=jdjo5rKYG4ZK3OODkKBuqmFXqRUFZ7x80BI7gRk+kAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAt9nOnCGZn1AB9GlC9o3THgO6pMf/c7Qk4kP0u2kc9idoUBcGnsqR7c6udRGKPvY
	 x12ZchO8e75B0TCMV6QYrhZ2IAKP295rMTPknSVRtXSdIt0MO5Aq4A3TGp0FdwDjeG
	 mi1U/qX6ar31MRHceIrDQ3CxniYNp3YTojcV0R+SawacxlbKLmYw5UspcK0WbpjfAl
	 iiYGLkMfh/1PUvseFhrDw3AgcccLaG9oCRXpDQ2M+yS/fNyH+nGgU11Ch932a0s2rb
	 fy+TRP2L6JwnO8kG8KQQHf5hyGo57suM9Wy6mE1KdcdwQkH5zDa4xPA2z8pnTRUPY2
	 1GSwlvOGgv0pQ==
Date: Mon, 4 Mar 2024 17:08:05 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org
Subject: Re: [PATCH v5 08/24] fsverity: add per-sb workqueue for post read
 processing
Message-ID: <20240305010805.GF17145@sol.localdomain>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-10-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304191046.157464-10-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 08:10:31PM +0100, Andrey Albershteyn wrote:
> For XFS, fsverity's global workqueue is not really suitable due to:
> 
> 1. High priority workqueues are used within XFS to ensure that data
>    IO completion cannot stall processing of journal IO completions.
>    Hence using a WQ_HIGHPRI workqueue directly in the user data IO
>    path is a potential filesystem livelock/deadlock vector.
> 
> 2. The fsverity workqueue is global - it creates a cross-filesystem
>    contention point.
> 
> This patch adds per-filesystem, per-cpu workqueue for fsverity
> work. This allows iomap to add verification work in the read path on
> BIO completion.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>

Should ext4 and f2fs switch over to this by converting
fsverity_enqueue_verify_work() to use it?  I'd prefer not to have to maintain
two separate workqueue strategies as part of the fs/verity/ infrastructure.

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 1fbc72c5f112..5863519ffd51 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1223,6 +1223,8 @@ struct super_block {
>  #endif
>  #ifdef CONFIG_FS_VERITY
>  	const struct fsverity_operations *s_vop;
> +	/* Completion queue for post read verification */
> +	struct workqueue_struct *s_read_done_wq;
>  #endif

Maybe s_verity_wq?  Or do you anticipate this being used for other purposes too,
such as fscrypt?  Note that it's behind CONFIG_FS_VERITY and is allocated by an
fsverity_* function, so at least at the moment it doesn't feel very generic.

> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 0973b521ac5a..45b7c613148a 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -241,6 +241,22 @@ void fsverity_enqueue_verify_work(struct work_struct *work);
>  void fsverity_invalidate_block(struct inode *inode,
>  		struct fsverity_blockbuf *block);
>  
> +static inline int fsverity_set_ops(struct super_block *sb,
> +				   const struct fsverity_operations *ops)

This doesn't just set the ops, but also allocates a workqueue too.  A better
name for this function might be fsverity_init_sb.

Also this shouldn't really be an inline function.

> +{
> +	sb->s_vop = ops;
> +
> +	/* Create per-sb workqueue for post read bio verification */
> +	struct workqueue_struct *wq = alloc_workqueue(
> +		"pread/%s", (WQ_FREEZABLE | WQ_MEM_RECLAIM), 0, sb->s_id);

"pread" is short for "post read", I guess?  Should it really be this generic?

> +static inline int fsverity_set_ops(struct super_block *sb,
> +				   const struct fsverity_operations *ops)
> +{
> +	return -EOPNOTSUPP;
> +}

I think it would be better to just not have a !CONFIG_FS_VERITY stub for this.

You *could* make it work like fscrypt_set_ops(), which the ubifs folks added,
where it can be called unconditionally if the filesystem has a declaration for
the operations (but not necessarily a definition).  In that case it would need
to return 0, rather than an error.  But I think I prefer just omitting the stub
and having filesystems guard the call to this by CONFIG_FS_VERITY, as you've
already done in XFS.

- Eric

