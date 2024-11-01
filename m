Return-Path: <linux-fsdevel+bounces-33458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F18B9B9022
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 12:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFDF281259
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 11:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A387619AA41;
	Fri,  1 Nov 2024 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="feicTscu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vVkXrLSV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZIGdCRj4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TvSPqzBX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D445E17C222;
	Fri,  1 Nov 2024 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459872; cv=none; b=n1Orf6eOuGsuYNvZoCzCTIy0A2QTfUzbtS1+mIS3yuzjfMjeDg3AviAwJXTVmUTn7I0tmp8zJIbFS1HiXhDbxBJ/RKcxIbABr+gpT9yP9xvx1JQAcxmcTCj9hhP+ASEuL38h+puOKw+h+G1oDu/SAqEp49FWbKbmy1NOjR8mpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459872; c=relaxed/simple;
	bh=drAABlD3F2WfMZcB5fy38tONmnd3QjfRCR/f80uzqU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6tvFV8cnYz/jGQ/cAtYL6wlbD3JvyZME7lKDMUl7DZTEM6129MMgmgvQgYXJt7rrOTcVvdAbvFwJZB4ZJ6rmS0l7UE2yfJuh1UQBbhDBjulX2kqJSQMtYb28ezjJdmWkf16NZ4eAQy9AuQTbLrKXUWwvyGi4eUrIWa5r89W6xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=feicTscu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vVkXrLSV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZIGdCRj4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TvSPqzBX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D27F221BD3;
	Fri,  1 Nov 2024 11:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730459868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RwB1kDOyJmQDs6UUGingIm2Zh6PHwAW5AGSktCdS67U=;
	b=feicTscupTT6aPk7yK/zYdjJKH5hWSZmAL4AE30/CBLZBC/1datPrV11txttHTqass3B2j
	nMMHJbFnZKwjRyC1wSDWeI4xsMq95I1eoa7FKWOEziRfpDb4ex1cmtsSaq4zNN4pGqS0sX
	t6WC1YpPSOgzQ6csrXldNpacWQbA4VQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730459868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RwB1kDOyJmQDs6UUGingIm2Zh6PHwAW5AGSktCdS67U=;
	b=vVkXrLSV7NcBqRUBGgKBlA3AH4gn0UH7osdQZtnub1nbuTFtQMkvnF14jdFYPv+f+1vKwq
	luQI0f6BEf0XJCAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730459867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RwB1kDOyJmQDs6UUGingIm2Zh6PHwAW5AGSktCdS67U=;
	b=ZIGdCRj4GDHLV1TJ9X/QUpXJwxw6Ua8hPEau3uuhk29A2YTUwU9xasFqEC+lc8r1tVzxl2
	OKs61q7FmRFzkcSKPiG4ros5c503fgyZdqj7ljbqW+HJIIgl0GhkgZLKrc409pKjkW7iC8
	kGYKcraQB7NqtKPnMhp+Uy2YdepH7xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730459867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RwB1kDOyJmQDs6UUGingIm2Zh6PHwAW5AGSktCdS67U=;
	b=TvSPqzBXVkFdo+eDbVBo7qv0IWyMqQ4WVj3TERMl7JteSkPgsRfEfxphr39D4nR9Ygd7XF
	t4XmN2NdX3ob5BBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C82A8136D9;
	Fri,  1 Nov 2024 11:17:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +B3aMNu4JGdlWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 01 Nov 2024 11:17:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 72F39A0AF4; Fri,  1 Nov 2024 12:17:32 +0100 (CET)
Date: Fri, 1 Nov 2024 12:17:32 +0100
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] ext4: Add statx support for atomic writes
Message-ID: <20241101111732.wgv4x3q7umkz3sox@quack3>
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
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 01-11-24 12:20:51, Ritesh Harjani (IBM) wrote:
> This patch adds base support for atomic writes via statx getattr.
> On bs < ps systems, we can create FS with say bs of 16k. That means
> both atomic write min and max unit can be set to 16k for supporting
> atomic writes.
> 
> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

I guess this is a good start. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

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
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

