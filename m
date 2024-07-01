Return-Path: <linux-fsdevel+bounces-22899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B6F91EB1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 00:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA7C2834EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 22:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452F5172BA6;
	Mon,  1 Jul 2024 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnsIb0uN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9617BA1;
	Mon,  1 Jul 2024 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719874182; cv=none; b=u8aARWDsdSmta65FJP7jdRsONCSILIPbhNjoNxNDjna5/8HN2sbvjeLrz+82mZwHRyKdxvJCY0ZSkJllQcPkN4FStsa0Y5nq1Yu7+gMlraODZoSmdYt5s+I6PuSVtZYpiYq5XAwy8UcfrUyNgn5oVQiFx/fLhWqSo2SXbgTaAzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719874182; c=relaxed/simple;
	bh=bXoWDyduCGsJU7lhbujiLjxLA54PjQmw5SMTkVT0vNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOY/q+lHQEjFSLMAP6FTF6ABlk/W+rHq8cstR2cufqvdkpcyY/bheoWssnzP60UyzgRJFBPw+qorbB2GSZA7fj6Owf8L3dXNhiZXduxAxULjxBJE+RmmlYTs6vFRRCuWxNb9QS4L33p2fJGXz9Lqt92y46LzwYMpI9EXaClcxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnsIb0uN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F84C116B1;
	Mon,  1 Jul 2024 22:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719874182;
	bh=bXoWDyduCGsJU7lhbujiLjxLA54PjQmw5SMTkVT0vNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MnsIb0uNSwAHfqytxz2YxarQKag9GysdcNIBeUK8dH1tzYMDJUfwlKcSo9NyetHFj
	 4gRTea8CYRA/mwIDw8oQW65xy5aeE/FMx8dHovVUqnwGBQ4AMIi7TwrfpiY//28W68
	 GrtBUsMP/EL1H25z91QNWBL63F7TRQUhp19y5VK0+7ldauGeatdJextRuf2x+nFj+D
	 iToBZrGCa+a2CZZd1KHEMQIfFgam7OVr+YJ9P0s1scV4VsWOy36sQp+RFpToV/BKr+
	 x2PWAcV1CMKmDKqSRrQjQTblzn4M2tyZE92FrpeA94E7MCwdHtrYNE606nDiRjp05o
	 7pAp5zCFIgkUg==
Date: Mon, 1 Jul 2024 15:49:41 -0700
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
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 01/10] fs: turn inode ctime fields into a single ktime_t
Message-ID: <20240701224941.GE612460@frogsfrogsfrogs>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
 <20240626-mgtime-v1-1-a189352d0f8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-mgtime-v1-1-a189352d0f8f@kernel.org>

On Wed, Jun 26, 2024 at 09:00:21PM -0400, Jeff Layton wrote:
> The ctime is not settable to arbitrary values. It always comes from the
> system clock, so we'll never stamp an inode with a value that can't be
> represented there. If we disregard people setting their system clock
> past the year 2262, there is no reason we can't replace the ctime fields
> with a ktime_t.
> 
> Switch the ctime fields to a single ktime_t. Move the i_generation down
> above i_fsnotify_mask and then move the i_version into the resulting 8
> byte hole. This shrinks struct inode by 8 bytes total, and should
> improve the cache footprint as the i_version and ctime are usually
> updated together.
> 
> The one downside I can see to switching to a ktime_t is that if someone
> has a filesystem with files on it that has ctimes outside the ktime_t
> range (before ~1678 AD or after ~2262 AD), we won't be able to display
> them properly in stat() without some special treatment in the
> filesystem. The operating assumption here is that that is not a
> practical problem.

What happens if a filesystem with the ability to store ctimes beyond
whatever ktime_t supports (AFAICT 2^63-1 nanonseconds on either side of
the Unix epoch)?  I think the behavior with your patch is that ktime_set
clamps the ctime on iget because the kernel can't handle it?

It's a little surprising that the ctime will suddenly jump back in time
to 2262, but maybe you're right that nobody will notice or care? ;)

--D

> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/fs.h | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 5ff362277834..5139dec085f2 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -662,11 +662,10 @@ struct inode {
>  	loff_t			i_size;
>  	time64_t		i_atime_sec;
>  	time64_t		i_mtime_sec;
> -	time64_t		i_ctime_sec;
>  	u32			i_atime_nsec;
>  	u32			i_mtime_nsec;
> -	u32			i_ctime_nsec;
> -	u32			i_generation;
> +	ktime_t			__i_ctime;
> +	atomic64_t		i_version;
>  	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
>  	unsigned short          i_bytes;
>  	u8			i_blkbits;
> @@ -701,7 +700,6 @@ struct inode {
>  		struct hlist_head	i_dentry;
>  		struct rcu_head		i_rcu;
>  	};
> -	atomic64_t		i_version;
>  	atomic64_t		i_sequence; /* see futex */
>  	atomic_t		i_count;
>  	atomic_t		i_dio_count;
> @@ -724,6 +722,8 @@ struct inode {
>  	};
>  
>  
> +	u32			i_generation;
> +
>  #ifdef CONFIG_FSNOTIFY
>  	__u32			i_fsnotify_mask; /* all events this inode cares about */
>  	/* 32-bit hole reserved for expanding i_fsnotify_mask */
> @@ -1608,29 +1608,25 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
>  	return inode_set_mtime_to_ts(inode, ts);
>  }
>  
> -static inline time64_t inode_get_ctime_sec(const struct inode *inode)
> +static inline struct timespec64 inode_get_ctime(const struct inode *inode)
>  {
> -	return inode->i_ctime_sec;
> +	return ktime_to_timespec64(inode->__i_ctime);
>  }
>  
> -static inline long inode_get_ctime_nsec(const struct inode *inode)
> +static inline time64_t inode_get_ctime_sec(const struct inode *inode)
>  {
> -	return inode->i_ctime_nsec;
> +	return inode_get_ctime(inode).tv_sec;
>  }
>  
> -static inline struct timespec64 inode_get_ctime(const struct inode *inode)
> +static inline long inode_get_ctime_nsec(const struct inode *inode)
>  {
> -	struct timespec64 ts = { .tv_sec  = inode_get_ctime_sec(inode),
> -				 .tv_nsec = inode_get_ctime_nsec(inode) };
> -
> -	return ts;
> +	return inode_get_ctime(inode).tv_nsec;
>  }
>  
>  static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
>  						      struct timespec64 ts)
>  {
> -	inode->i_ctime_sec = ts.tv_sec;
> -	inode->i_ctime_nsec = ts.tv_nsec;
> +	inode->__i_ctime = ktime_set(ts.tv_sec, ts.tv_nsec);
>  	return ts;
>  }
>  
> 
> -- 
> 2.45.2
> 
> 

