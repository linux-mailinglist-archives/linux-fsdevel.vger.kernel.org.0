Return-Path: <linux-fsdevel+bounces-116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BE57C5D30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 20:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908891C209DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D7A3A29A;
	Wed, 11 Oct 2023 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcuM66+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D883A290;
	Wed, 11 Oct 2023 18:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35ADC433C7;
	Wed, 11 Oct 2023 18:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697050558;
	bh=u0EndV4NYu611LWlp13gB4hlDEaiWMH0QwLaJqf+W5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcuM66+o/UaBA0lTMKNgFhpcgWUEZ0BD0Sre1L2WDi0snGzS07jOQ6jGDigN0CXnP
	 TknOxsGkhEdqNzLGveOUZprKdp88ElyfDb56QZgIV36Hnv6CSNWifnntwgo7aZKNRd
	 dm7/6+UrYoqR8qj8dcAaWd1QX81sA/pa9UijSN0bBbGNj9NYpllNI7UDdKc0xtDI4F
	 H4a598BgE15IqCcT59IQROTZia3glWLTpiuuSSxgYbxmgx7RyPC+ABXekoYMzpaUix
	 8YA6mwsfxzsvziTbGfhZmZCoUGYvkFUs57KBiI6OWmeJOuc8PHuDBkqUDG+tSI7D7s
	 YHR86TgXJ3Qtg==
Date: Wed, 11 Oct 2023 11:55:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, ebiggers@kernel.org, david@fromorbit.com,
	dchinner@redhat.com
Subject: Re: [PATCH v3 15/28] xfs: introduce workqueue for post read IO work
Message-ID: <20231011185558.GS21298@frogsfrogsfrogs>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-16-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-16-aalbersh@redhat.com>

On Fri, Oct 06, 2023 at 08:49:09PM +0200, Andrey Albershteyn wrote:
> As noted by Dave there are two problems with using fs-verity's
> workqueue in XFS:
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
> work.

If we ever want to implement compression and/or fscrypt, can we use this
pread workqueue for that too?

Sounds good to me...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/xfs_mount.h | 1 +
>  fs/xfs/xfs_super.c | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index d19cca099bc3..3d77844b255e 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -109,6 +109,7 @@ typedef struct xfs_mount {
>  	struct xfs_mru_cache	*m_filestream;  /* per-mount filestream data */
>  	struct workqueue_struct *m_buf_workqueue;
>  	struct workqueue_struct	*m_unwritten_workqueue;
> +	struct workqueue_struct	*m_postread_workqueue;
>  	struct workqueue_struct	*m_reclaim_workqueue;
>  	struct workqueue_struct	*m_sync_workqueue;
>  	struct workqueue_struct *m_blockgc_wq;
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 819a3568b28f..5e1ec5978176 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -554,6 +554,12 @@ xfs_init_mount_workqueues(
>  	if (!mp->m_unwritten_workqueue)
>  		goto out_destroy_buf;
>  
> +	mp->m_postread_workqueue = alloc_workqueue("xfs-pread/%s",
> +			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
> +			0, mp->m_super->s_id);
> +	if (!mp->m_postread_workqueue)
> +		goto out_destroy_postread;
> +
>  	mp->m_reclaim_workqueue = alloc_workqueue("xfs-reclaim/%s",
>  			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
>  			0, mp->m_super->s_id);
> @@ -587,6 +593,8 @@ xfs_init_mount_workqueues(
>  	destroy_workqueue(mp->m_reclaim_workqueue);
>  out_destroy_unwritten:
>  	destroy_workqueue(mp->m_unwritten_workqueue);
> +out_destroy_postread:
> +	destroy_workqueue(mp->m_postread_workqueue);
>  out_destroy_buf:
>  	destroy_workqueue(mp->m_buf_workqueue);
>  out:
> @@ -602,6 +610,7 @@ xfs_destroy_mount_workqueues(
>  	destroy_workqueue(mp->m_inodegc_wq);
>  	destroy_workqueue(mp->m_reclaim_workqueue);
>  	destroy_workqueue(mp->m_unwritten_workqueue);
> +	destroy_workqueue(mp->m_postread_workqueue);
>  	destroy_workqueue(mp->m_buf_workqueue);
>  }
>  
> -- 
> 2.40.1
> 

