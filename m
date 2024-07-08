Return-Path: <linux-fsdevel+bounces-23318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD7892A930
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 20:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E587C1F22004
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 18:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F714BF8A;
	Mon,  8 Jul 2024 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVrSYqr+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9D217C9E;
	Mon,  8 Jul 2024 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464460; cv=none; b=Uq1BzwHNUnaSdAKp+cMNtEuY15aq9gkhCbwRxiPXwjsGCHwFY3aNBwIfhi24Btf/jG+dVzy5GgXoEF3yHo8sQJeTcFvsvauCBfQhuGDx/cwPgTODfGtnl3LdOVk4c7OYwkVF4bPTp32UTCOcrUZ6R1fDXIY5bg4QqHs0gc+pt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464460; c=relaxed/simple;
	bh=v31gl1I9OIcRmv77OmqWlCzEeZq6WOtR9ckY+p4HFoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4kSiqDr7FGEaiHWtwehsyRVqumNAcIQJFxt7LFR8y9Y2oQZYSpDQyHzyIERrCbZfp5yhfhXbrvwYCPcdkH5WcEmlNGqIivefAIKDMaTkwG7pRr51o0MGvX0CmjJhsvASzRV+nEuYPHbgVa5opM9/yazMFeupJPyHYWlUNu0NyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVrSYqr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19259C116B1;
	Mon,  8 Jul 2024 18:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720464460;
	bh=v31gl1I9OIcRmv77OmqWlCzEeZq6WOtR9ckY+p4HFoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVrSYqr+1qSVnArfid1TPu00dGCFcKaSnisHbXvjsY9S6ELI7mwnhSKVTbSd2oQpI
	 mRMITfr0ATkLE8+3WFFLhRaOsjMh2U3HT1wc7kdVE5G+1r9YXbqUCkzoTGU6vdco14
	 m9iGJSXziOeQ8FbKTrhds3sZ9Kbgjd8zwExhR8BIwDJGbCvtcamUor/gq5w0cTu2nc
	 6Vjkj4JpcUvaYO/BLLD/MwxH+tESDtfmSUkViWJASao1Z9NnIijNm0UwV12PCDc3jx
	 CT/vD0y+ltf0G366leHHF0oi9NKV3tK9D3C3B1DMzxoyd8gFJuKjgOn7HIyM6ymeoi
	 ebz1/5YzFOetA==
Date: Mon, 8 Jul 2024 11:47:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 6/9] xfs: switch to multigrain timestamps
Message-ID: <20240708184739.GP612460@frogsfrogsfrogs>
References: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
 <20240708-mgtime-v4-6-a0f3c6fb57f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708-mgtime-v4-6-a0f3c6fb57f3@kernel.org>

On Mon, Jul 08, 2024 at 11:53:39AM -0400, Jeff Layton wrote:
> Enable multigrain timestamps, which should ensure that there is an
> apparent change to the timestamp whenever it has been written after
> being actively observed via getattr.
> 
> Also, anytime the mtime changes, the ctime must also change, and those
> are now the only two options for xfs_trans_ichgtime. Have that function
> unconditionally bump the ctime, and ASSERT that XFS_ICHGTIME_CHG is
> always set.
> 
> Finally, stop setting STATX_CHANGE_COOKIE in getattr, since the ctime
> should give us better semantics now.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_trans_inode.c |  6 +++---
>  fs/xfs/xfs_iops.c               | 10 +++-------
>  fs/xfs/xfs_super.c              |  2 +-
>  3 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
> index 69fc5b981352..1f3639bbf5f0 100644
> --- a/fs/xfs/libxfs/xfs_trans_inode.c
> +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> @@ -62,12 +62,12 @@ xfs_trans_ichgtime(
>  	ASSERT(tp);
>  	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  
> -	tv = current_time(inode);
> +	/* If the mtime changes, then ctime must also change */
> +	ASSERT(flags & XFS_ICHGTIME_CHG);
>  
> +	tv = inode_set_ctime_current(inode);
>  	if (flags & XFS_ICHGTIME_MOD)
>  		inode_set_mtime_to_ts(inode, tv);
> -	if (flags & XFS_ICHGTIME_CHG)
> -		inode_set_ctime_to_ts(inode, tv);
>  	if (flags & XFS_ICHGTIME_CREATE)
>  		ip->i_crtime = tv;
>  }
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index a00dcbc77e12..d25872f818fa 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -592,8 +592,9 @@ xfs_vn_getattr(
>  	stat->gid = vfsgid_into_kgid(vfsgid);
>  	stat->ino = ip->i_ino;
>  	stat->atime = inode_get_atime(inode);
> -	stat->mtime = inode_get_mtime(inode);
> -	stat->ctime = inode_get_ctime(inode);
> +
> +	fill_mg_cmtime(stat, request_mask, inode);

Sooo... for setting up a commit-range operation[1], XFS_IOC_START_COMMIT
could populate its freshness data by calling:

	struct kstat dummy;

	fill_mg_ctime(&dummy, STATX_CTIME | STATX_MTIME, inode);

and then using dummy.[cm]time to populate the freshness data that it
gives to userspace, right?  Having set QUERIED, a write to the file
immediately afterwards will cause a (tiny) increase in ctime_nsec which
will cause the XFS_IOC_COMMIT_RANGE to reject the commit[2].  Right?

--D

[1] https://lore.kernel.org/linux-xfs/20240227174649.GL6184@frogsfrogsfrogs/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=atomic-file-commits&id=0520d89c2698874c1f56ddf52ec4b8a3595baa14

> +
>  	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
>  
>  	if (xfs_has_v3inodes(mp)) {
> @@ -603,11 +604,6 @@ xfs_vn_getattr(
>  		}
>  	}
>  
> -	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
> -		stat->change_cookie = inode_query_iversion(inode);
> -		stat->result_mask |= STATX_CHANGE_COOKIE;
> -	}
> -
>  	/*
>  	 * Note: If you add another clause to set an attribute flag, please
>  	 * update attributes_mask below.
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 27e9f749c4c7..210481b03fdb 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -2052,7 +2052,7 @@ static struct file_system_type xfs_fs_type = {
>  	.init_fs_context	= xfs_init_fs_context,
>  	.parameters		= xfs_fs_parameters,
>  	.kill_sb		= xfs_kill_sb,
> -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
>  };
>  MODULE_ALIAS_FS("xfs");
>  
> 
> -- 
> 2.45.2
> 
> 

