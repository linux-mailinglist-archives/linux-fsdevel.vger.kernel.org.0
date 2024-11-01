Return-Path: <linux-fsdevel+bounces-33480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C3A9B9417
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 16:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB301C20FF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7444A1BBBD0;
	Fri,  1 Nov 2024 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXjwbnlx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16DF1AC884;
	Fri,  1 Nov 2024 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473979; cv=none; b=a6aeOVVkIKWLT///ohXil00O049rMj1HFy0Sry5S/ryveK4fc8olpCpXTIZACNypvM6XqY8jglt/WGKLiTMDuYVsIMnJDmf+9HTRTbLUWOLYWrcIJaI3evHIcJA+NnTM2fIRw62NZXoB6/p03PypXR41GQabZDiYqy5ArTP8nKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473979; c=relaxed/simple;
	bh=ekg2hMYbznCWaygXXUdGZ3n+I2d1nv9q5j+6mo/Z790=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm+GgRcIVFVqNfMaR5azITrWh75RVse95wWVlS2YXFjBOWQHcdNC+0jxm2vRMoNlfNcRQEWrqLdjfRgkRMJQFbJgs2Q6kOQzzAGDFcyt18JTIhbD4lI+GBXysDgXAAKchDuuzdoCmW68Q+3x8gwBmvZWl2fR24Vpf/r9OI0S/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXjwbnlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3BDC4CECD;
	Fri,  1 Nov 2024 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730473979;
	bh=ekg2hMYbznCWaygXXUdGZ3n+I2d1nv9q5j+6mo/Z790=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXjwbnlxiTg55GSnTO31Ut03qEys8JTLEYgutdQfLcHxxyuP7PO2gsr6scoeuZdPx
	 TDa/kIFuLE3jEQdz32QVirg3VkJmK5iAHtoeylhbaqsmoeOvg0kzKrlLTEIWLeUJls
	 4D+/+Qj9NQxYu6LE5Nb3g6iUd/nCBoWspM1y2olcEk0FValyyE3RUgPgjkfm+4jJkx
	 G8cOsnzk6fqRAjO/AvjNVnwYxNVBnFAkqePhIUiRjJzgGrHAhJdYQx2fhqBZ6wXyoi
	 vgNJMRA4PMmj80oq7QR7R++/pGnva1GcfHEBh6MnJpVKBS4EDMf2B4w8IzmCi1RvcP
	 XIlKkeRGxWBYA==
Date: Fri, 1 Nov 2024 08:12:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] ext4: Add statx support for atomic writes
Message-ID: <20241101151258.GG2386201@frogsfrogsfrogs>
References: <cover.1730437365.git.ritesh.list@gmail.com>
 <0517cef1682fc1f344343c494ac769b963f94199.1730437365.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0517cef1682fc1f344343c494ac769b963f94199.1730437365.git.ritesh.list@gmail.com>

On Fri, Nov 01, 2024 at 12:20:51PM +0530, Ritesh Harjani (IBM) wrote:
> This patch adds base support for atomic writes via statx getattr.
> On bs < ps systems, we can create FS with say bs of 16k. That means
> both atomic write min and max unit can be set to 16k for supporting
> atomic writes.
> 
> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/ext4/ext4.h  | 10 ++++++++++
>  fs/ext4/inode.c | 12 ++++++++++++
>  fs/ext4/super.c | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 44b0d418143c..494d443e9fc9 100644
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
> @@ -3855,6 +3859,12 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>  	return buffer_uptodate(bh);
>  }
>  
> +static inline bool ext4_inode_can_atomic_write(struct inode *inode)
> +{
> +
> +	return S_ISREG(inode->i_mode) && EXT4_SB(inode->i_sb)->s_awu_min > 0;
> +}
> +
>  extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>  				  loff_t pos, unsigned len,
>  				  get_block_t *get_block);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 54bdd4884fe6..3e827cfa762e 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5578,6 +5578,18 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
>  		}
>  	}
>  
> +	if ((request_mask & STATX_WRITE_ATOMIC) && S_ISREG(inode->i_mode)) {
> +		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +		unsigned int awu_min = 0, awu_max = 0;
> +
> +		if (ext4_inode_can_atomic_write(inode)) {
> +			awu_min = sbi->s_awu_min;
> +			awu_max = sbi->s_awu_max;
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

