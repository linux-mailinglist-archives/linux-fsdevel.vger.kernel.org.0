Return-Path: <linux-fsdevel+bounces-33373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE8C9B857F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 22:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DB31C20BDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 21:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E71CDFC5;
	Thu, 31 Oct 2024 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko3j0mQG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB641CB521;
	Thu, 31 Oct 2024 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410925; cv=none; b=R4avg85MWjwDuAaYeQRXBdq2svaFhYyVbBjjm6hQhL0g1344WpYNjoDHXE/oAOLgpWCeh4t9xy0mlqbBd7bB39ZsRIQnRqIm4j/ugRZFqZNDYs3oSo1CSPbhcLj+jN2zYVMTyvGOd/eJMoFc4xn4Uj4OalsFdTdf+YV8qsBKDkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410925; c=relaxed/simple;
	bh=xPaVv6JIODJAUn/wUuTMDDqfdPE30RFmKl6O7ZIMa1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD+5Zo40OKVm+JDf28RiO1E8mwwrUf7WUqwqSyNdBspunCjvJdC6IYyCzF+jcummMRFm6bW0VxQjllFxMdrxSsTPVpYURnBiKGieRzLMsWj3W/1MMmPeKMpUs5ZPRCSwy8ulILj1U7S2zKGUuFeK90lk747HP404IfJONEi8LCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko3j0mQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0798C4CEC3;
	Thu, 31 Oct 2024 21:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730410924;
	bh=xPaVv6JIODJAUn/wUuTMDDqfdPE30RFmKl6O7ZIMa1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ko3j0mQG1w/fJpo+cnilEW1TFHTK2wdO1RdFf1CQolWNAD8o4QwknTBHEcEISazG2
	 NeMVY4nwV3Vr4EfQDFTom0PORq8r3PpzAZuXsWhyl17anc5N/oeBXPt0xs87uFnn0l
	 SeO3K6/bCctugEFmWUI3npcOBSmxh5f1pdlMGdUv/GN+Gwu2H3LdXTki9xzbx695Y7
	 8TdKReGYM7sthqxUyQAg8VoDSF7hXOyIv13Vgbuj2QgXlDy7+q7NURvNijMM60Mi1O
	 7RvAKB8IU6nnDLbiq6cqTihgBo1NypFdsEWQV0TVkaTsf1RGbbz+1gemFBUTNHzDjm
	 YLKIsE4BZcOUg==
Date: Thu, 31 Oct 2024 14:42:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ext4: Add statx support for atomic writes
Message-ID: <20241031214204.GC21832@frogsfrogsfrogs>
References: <cover.1730286164.git.ritesh.list@gmail.com>
 <3338514d98370498d49ebc297a9b6d48a55282b8.1730286164.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3338514d98370498d49ebc297a9b6d48a55282b8.1730286164.git.ritesh.list@gmail.com>

On Wed, Oct 30, 2024 at 09:27:38PM +0530, Ritesh Harjani (IBM) wrote:
> This patch adds base support for atomic writes via statx getattr.
> On bs < ps systems, we can create FS with say bs of 16k. That means
> both atomic write min and max unit can be set to 16k for supporting
> atomic writes.
> 
> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/ext4.h  |  9 +++++++++
>  fs/ext4/inode.c | 14 ++++++++++++++
>  fs/ext4/super.c | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 44b0d418143c..6ee49aaacd2b 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1729,6 +1729,10 @@ struct ext4_sb_info {
>  	 */
>  	struct work_struct s_sb_upd_work;
>  
> +	/* Atomic write unit values in bytes */
> +	unsigned int s_awu_min;
> +	unsigned int s_awu_max;
> +
>  	/* Ext4 fast commit sub transaction ID */
>  	atomic_t s_fc_subtid;
>  
> @@ -3855,6 +3859,11 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>  	return buffer_uptodate(bh);
>  }
>  
> +static inline bool ext4_can_atomic_write(struct super_block *sb)
> +{
> +	return EXT4_SB(sb)->s_awu_min > 0;

Huh, I was expecting you to stick to passing in the struct inode,
and then you end up with:

static inline bool ext4_can_atomic_write(struct inode *inode)
{
	return S_ISREG(inode->i_mode) &&
	       EXT4_SB(inode->i_sb)->s_awu_min > 0);
}

> +}
> +
>  extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>  				  loff_t pos, unsigned len,
>  				  get_block_t *get_block);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 54bdd4884fe6..fcdee27b9aa2 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5578,6 +5578,20 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
>  		}
>  	}
>  
> +	if (S_ISREG(inode->i_mode) && (request_mask & STATX_WRITE_ATOMIC)) {

...and then the callsites become:

	if (request_mask & STATX_WRITE_ATOMIC) {
		unsigned int awu_min = 0, awu_max = 0;

		if (ext4_can_atomic_write(inode)) {
			awu_min = sbi->s_awu_min;
			awu_max = sbi->s_awu_max;
		}

		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
	}

(I forget, is it bad if statx to a directory returns STATX_WRITE_ATOMIC
even with awu_{min,max} set to zero?)

Other than that nit, this looks good to me.

--D

> +		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +		unsigned int awu_min, awu_max;
> +
> +		if (ext4_can_atomic_write(inode->i_sb)) {
> +			awu_min = sbi->s_awu_min;
> +			awu_max = sbi->s_awu_max;
> +		} else {
> +			awu_min = awu_max = 0;
> +		}
> +
> +		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
> +	}
> +
>  	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
>  	if (flags & EXT4_APPEND_FL)
>  		stat->attributes |= STATX_ATTR_APPEND;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 16a4ce704460..ebe1660bd840 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4425,6 +4425,36 @@ static int ext4_handle_clustersize(struct super_block *sb)
>  	return 0;
>  }
>  
> +/*
> + * ext4_atomic_write_init: Initializes filesystem min & max atomic write units.
> + * @sb: super block
> + * TODO: Later add support for bigalloc
> + */
> +static void ext4_atomic_write_init(struct super_block *sb)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct block_device *bdev = sb->s_bdev;
> +
> +	if (!bdev_can_atomic_write(bdev))
> +		return;
> +
> +	if (!ext4_has_feature_extents(sb))
> +		return;
> +
> +	sbi->s_awu_min = max(sb->s_blocksize,
> +			      bdev_atomic_write_unit_min_bytes(bdev));
> +	sbi->s_awu_max = min(sb->s_blocksize,
> +			      bdev_atomic_write_unit_max_bytes(bdev));
> +	if (sbi->s_awu_min && sbi->s_awu_max &&
> +	    sbi->s_awu_min <= sbi->s_awu_max) {
> +		ext4_msg(sb, KERN_NOTICE, "Supports (experimental) DIO atomic writes awu_min: %u, awu_max: %u",
> +			 sbi->s_awu_min, sbi->s_awu_max);
> +	} else {
> +		sbi->s_awu_min = 0;
> +		sbi->s_awu_max = 0;
> +	}
> +}
> +
>  static void ext4_fast_commit_init(struct super_block *sb)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> @@ -5336,6 +5366,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  
>  	spin_lock_init(&sbi->s_bdev_wb_lock);
>  
> +	ext4_atomic_write_init(sb);
>  	ext4_fast_commit_init(sb);
>  
>  	sb->s_root = NULL;
> -- 
> 2.46.0
> 
> 

