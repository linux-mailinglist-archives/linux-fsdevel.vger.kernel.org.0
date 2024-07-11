Return-Path: <linux-fsdevel+bounces-23585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CB192ED1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 18:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7767D1F22B53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 16:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BAD16D9B5;
	Thu, 11 Jul 2024 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6jgLrTt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48663376E5;
	Thu, 11 Jul 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716703; cv=none; b=fB3gPlKmE4ef5BSqNjA06gTnYaX7kaZtuJz4X3R+ZOn1WctczqlTa9hStjFTvQnVwCoPWcpWF66MCgL0Ufod/jzzt6sMOD8g0wo0lYXuL9nDHYRqVzOkyCp9wtuOpikGchiiyeb2uRLSgRhyghWKuM6RmkXj42BGniiYUvo0P4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716703; c=relaxed/simple;
	bh=kmGbtXEsMjJy/wpU2hA6AuW+oaSd10dmF9hCafZ07GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mA90HvSnsn+MnFClJXV6JAEb2gUoDBuZiHZq2RJ7WbvFcmBrU4LxTP5FbfApaY0dZrt/apPf3RYh+AtJTFUJwRWk31LD5bDbBF0sqX9Ukk7D3vfBsedGUC+Fi5I6GnKHXRrnKcayQJzmVmw9VwmlHw9roOt5GwX0Oxq2Rs4AM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6jgLrTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F39C116B1;
	Thu, 11 Jul 2024 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720716702;
	bh=kmGbtXEsMjJy/wpU2hA6AuW+oaSd10dmF9hCafZ07GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6jgLrTtoFWdwMS9eTSIt8y+gfMtPQ6WtVeTi1Jm5Rq6rJCBtKhgBiX0lwnGPSYjz
	 POgkbYDJfaPdVrYeQQGmx4PJsSG4cOb1yCZtWnD3QLF1Tcu07O28a7iM3Ib8SCmAba
	 JCIqali4EF+aY3T9oeQZMZXdXI0fMkjynqP+7mzVM5WSTUgZj6kIvgwZVpG0cgcp+W
	 e8q6UrKbd27jWhCKkIc3AoSE6kxE8nUsGAsUBC1eSgA/xf4Xr5ZSYa6nPHeCw0XVqp
	 qdkcXBQXKoXs8bxCODrFuPDRFEVzsL979JH7tQAhIa9HLRl39RllYBG+c3j0n63EdM
	 pAgpLsnfPQNcQ==
Date: Thu, 11 Jul 2024 09:51:42 -0700
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
	Kent Overstreet <kent.overstreet@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 4/9] fs: have setattr_copy handle multigrain
 timestamps appropriately
Message-ID: <20240711165142.GP612460@frogsfrogsfrogs>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
 <20240711-mgtime-v5-4-37bb5b465feb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-mgtime-v5-4-37bb5b465feb@kernel.org>

On Thu, Jul 11, 2024 at 07:08:08AM -0400, Jeff Layton wrote:
> The setattr codepath is still using coarse-grained timestamps, even on
> multigrain filesystems. To fix this, we need to fetch the timestamp for
> ctime updates later, at the point where the assignment occurs in
> setattr_copy.
> 
> On a multigrain inode, ignore the ia_ctime in the attrs, and always
> update the ctime to the current clock value. Update the atime and mtime
> with the same value (if needed) unless they are being set to other
> specific values, a'la utimes().
> 
> Note that we don't want to do this universally however, as some
> filesystems (e.g. most networked fs) want to do an explicit update
> elsewhere before updating the local inode.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Makes sense to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/attr.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index 825007d5cda4..e03ea6951864 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -271,6 +271,42 @@ int inode_newsize_ok(const struct inode *inode, loff_t offset)
>  }
>  EXPORT_SYMBOL(inode_newsize_ok);
>  
> +/**
> + * setattr_copy_mgtime - update timestamps for mgtime inodes
> + * @inode: inode timestamps to be updated
> + * @attr: attrs for the update
> + *
> + * With multigrain timestamps, we need to take more care to prevent races
> + * when updating the ctime. Always update the ctime to the very latest
> + * using the standard mechanism, and use that to populate the atime and
> + * mtime appropriately (unless we're setting those to specific values).
> + */
> +static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
> +{
> +	unsigned int ia_valid = attr->ia_valid;
> +	struct timespec64 now;
> +
> +	/*
> +	 * If the ctime isn't being updated then nothing else should be
> +	 * either.
> +	 */
> +	if (!(ia_valid & ATTR_CTIME)) {
> +		WARN_ON_ONCE(ia_valid & (ATTR_ATIME|ATTR_MTIME));
> +		return;
> +	}
> +
> +	now = inode_set_ctime_current(inode);
> +	if (ia_valid & ATTR_ATIME_SET)
> +		inode_set_atime_to_ts(inode, attr->ia_atime);
> +	else if (ia_valid & ATTR_ATIME)
> +		inode_set_atime_to_ts(inode, now);
> +
> +	if (ia_valid & ATTR_MTIME_SET)
> +		inode_set_mtime_to_ts(inode, attr->ia_mtime);
> +	else if (ia_valid & ATTR_MTIME)
> +		inode_set_mtime_to_ts(inode, now);
> +}
> +
>  /**
>   * setattr_copy - copy simple metadata updates into the generic inode
>   * @idmap:	idmap of the mount the inode was found from
> @@ -303,12 +339,6 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
>  
>  	i_uid_update(idmap, attr, inode);
>  	i_gid_update(idmap, attr, inode);
> -	if (ia_valid & ATTR_ATIME)
> -		inode_set_atime_to_ts(inode, attr->ia_atime);
> -	if (ia_valid & ATTR_MTIME)
> -		inode_set_mtime_to_ts(inode, attr->ia_mtime);
> -	if (ia_valid & ATTR_CTIME)
> -		inode_set_ctime_to_ts(inode, attr->ia_ctime);
>  	if (ia_valid & ATTR_MODE) {
>  		umode_t mode = attr->ia_mode;
>  		if (!in_group_or_capable(idmap, inode,
> @@ -316,6 +346,16 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
>  			mode &= ~S_ISGID;
>  		inode->i_mode = mode;
>  	}
> +
> +	if (is_mgtime(inode))
> +		return setattr_copy_mgtime(inode, attr);
> +
> +	if (ia_valid & ATTR_ATIME)
> +		inode_set_atime_to_ts(inode, attr->ia_atime);
> +	if (ia_valid & ATTR_MTIME)
> +		inode_set_mtime_to_ts(inode, attr->ia_mtime);
> +	if (ia_valid & ATTR_CTIME)
> +		inode_set_ctime_to_ts(inode, attr->ia_ctime);
>  }
>  EXPORT_SYMBOL(setattr_copy);
>  
> 
> -- 
> 2.45.2
> 
> 

