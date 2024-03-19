Return-Path: <linux-fsdevel+bounces-14849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A0E880830
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 00:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A411F2212F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 23:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983F65FB90;
	Tue, 19 Mar 2024 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTqj8MB3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD1A40BF2;
	Tue, 19 Mar 2024 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710891013; cv=none; b=UdUf9NwQiHMsTh7EjTT9bPECI1I3nk3eXeYtvHWRdC1cffMW26fyuZZVI3ppxAVTbizdNbqiRI5oYt7yPcwTcqrHr2bANpoj17nArhvt520UrrlnW2aAl4OU7Kdp+Sf8cfe6vb9+q3pD9dVV77o/7M78bsEoRMFffkAz9FxdlBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710891013; c=relaxed/simple;
	bh=1NkfHaaq/qk9BWoinhAyqxBdU7ECkk6uQ94U6X/8YWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q09+VJm1hadI+4w4q20pMHKcdU+V1y0J66Nj5K6+JFRgEBbKZ+Bz9LCaGgw02PpEjN1EZzG0zTVIZsc/CXmYZgPx+BneR1a+rI0x3IivxNaHEBx6V5nxl46K4bhcBhQFhAj1vmKjHAPbeihD6ghCupLCmYUqalSQkyQpj4PrsBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTqj8MB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B34FC433C7;
	Tue, 19 Mar 2024 23:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710891011;
	bh=1NkfHaaq/qk9BWoinhAyqxBdU7ECkk6uQ94U6X/8YWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qTqj8MB3arjzjTNmEx40506ehQK3+7w3tN0D/N3mk0Y6ApwdHbUSI4qJszojWTakv
	 b9h92m41o0zV/CmooK/N4b/ALsK+P52UZ7WUlPyCf1JgnGCtCQicHcS6XObZlYVEQj
	 XHOky+KJzSS7ukFNJZY4Ip/MUNtVM9PYFPFI/meg/+qzHQZao4MTqlKVuz8YHMVWfJ
	 7CD/znlPW4aEpOPGQxC378K33/370BZdzV7PwhlY5xnCpcEo2C7+FIqY2it9DsIUPQ
	 76VVpuwIg/X0S8pCa7s78DCl1l0rMTS7/mwEAMFPkUmePQhllc4EjmKFnEElN7YSGG
	 nq++6PDEHGypg==
Date: Tue, 19 Mar 2024 16:30:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 08/29] fsverity: add per-sb workqueue for post read
 processing
Message-ID: <20240319233010.GV1927156@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
 <171035223488.2613863.7583467519759571221.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171035223488.2613863.7583467519759571221.stgit@frogsfrogsfrogs>

On Wed, Mar 13, 2024 at 10:54:39AM -0700, Darrick J. Wong wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
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
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/super.c               |    7 +++++++
>  include/linux/fs.h       |    2 ++
>  include/linux/fsverity.h |   22 ++++++++++++++++++++++
>  3 files changed, 31 insertions(+)
> 
> 
> diff --git a/fs/super.c b/fs/super.c
> index d35e85295489..338d86864200 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -642,6 +642,13 @@ void generic_shutdown_super(struct super_block *sb)
>  			sb->s_dio_done_wq = NULL;
>  		}
>  
> +#ifdef CONFIG_FS_VERITY
> +		if (sb->s_read_done_wq) {
> +			destroy_workqueue(sb->s_read_done_wq);
> +			sb->s_read_done_wq = NULL;
> +		}
> +#endif
> +
>  		if (sop->put_super)
>  			sop->put_super(sb);
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ed5966a70495..9db24a825d94 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1221,6 +1221,8 @@ struct super_block {
>  #endif
>  #ifdef CONFIG_FS_VERITY
>  	const struct fsverity_operations *s_vop;
> +	/* Completion queue for post read verification */
> +	struct workqueue_struct *s_read_done_wq;
>  #endif
>  #if IS_ENABLED(CONFIG_UNICODE)
>  	struct unicode_map *s_encoding;
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
> +{
> +	sb->s_vop = ops;
> +
> +	/* Create per-sb workqueue for post read bio verification */
> +	struct workqueue_struct *wq = alloc_workqueue(
> +		"pread/%s", (WQ_FREEZABLE | WQ_MEM_RECLAIM), 0, sb->s_id);

Looking at this more closely, why is it that the fsverity_read_queue
is unbound and tagged WQ_HIGHPRI, whereas this one is instead FREEZEABLE
and MEM_RECLAIM and bound?

If it's really feasible to use /one/ workqueue for all the read
post-processing then this ought to be a fs/super.c helper ala
sb_init_dio_done_wq.  That said, from Eric's comments on the v5 thread
about fsverity and fscrypt locking horns over workqueue stalls I'm not
convinced that's true.

--D

> +	if (!wq)
> +		return -ENOMEM;
> +
> +	sb->s_read_done_wq = wq;
> +
> +	return 0;
> +}
> +
>  #else /* !CONFIG_FS_VERITY */
>  
>  static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
> @@ -318,6 +334,12 @@ static inline void fsverity_enqueue_verify_work(struct work_struct *work)
>  	WARN_ON_ONCE(1);
>  }
>  
> +static inline int fsverity_set_ops(struct super_block *sb,
> +				   const struct fsverity_operations *ops)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif	/* !CONFIG_FS_VERITY */
>  
>  static inline bool fsverity_verify_folio(struct folio *folio)
> 
> 

