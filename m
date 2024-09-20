Return-Path: <linux-fsdevel+bounces-29763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3839297D806
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 18:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB30D1F22E47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D1217DE16;
	Fri, 20 Sep 2024 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2KhzUCXF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+/UDBwsV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2KhzUCXF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+/UDBwsV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C72AE69;
	Fri, 20 Sep 2024 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726848287; cv=none; b=Uvuk7xoxlCWzMf7onoP6cge3aX+b64ghs6TyesxOJyLVNsp9kYmFdE53p03xEpU3VxTpgNrYdvF5e/t+G6jfr49+l8jPtipT+JPFj1x8PwOOvfIuBI6H/6g7h2TiVtunmMYC2dxzGO9sHZ0pRaQjn7zTqbJ2hk4sSYpH9X+GICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726848287; c=relaxed/simple;
	bh=41r70M6F7uYaG+TOVb0WDC0Ir3ygU6zSKEeeSHHqIdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVwNnNPS0qGYZs4nw+uTR6ut4rE1TIFSytX/hJ28axVqyTukIsq/cqwb+7wjPWhnvRyOrfnOhGY6LjIunREkPNsaCmzIJbOa1uSdXMvjHhtrIaN6+/bikTfckz4PohvQ6jdFEza5OtNsoR/iozoozFm58bK11bAfUOqI8SRsMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2KhzUCXF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+/UDBwsV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2KhzUCXF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+/UDBwsV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 13C8433A3A;
	Fri, 20 Sep 2024 16:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726848283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J2NLc4e6fHj5AhD1jSBYYzMciBqQt2iDPqp7r4EEsPE=;
	b=2KhzUCXFD0P5dRnXToJpvr8NSSgKNX/tuX6h+bUjN/wzKDpug5WSwQw1QDwygG/8udvedY
	xV05XnB4zBXu8oA0j2E+KfHDjKIQ8Q6CZC8mr8OkQrcapiUOYWFSaA52S19XDn7RdVnn03
	cJ33FewcF9yJ5BHmQLuahctuMGNurDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726848283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J2NLc4e6fHj5AhD1jSBYYzMciBqQt2iDPqp7r4EEsPE=;
	b=+/UDBwsVcxZa9DQB9FB9Ass7ekkPCV4frVguflR4P/9mQwCGO4UqJ85773cULudww+czHr
	8Mpu9rIoAYeq4RAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2KhzUCXF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="+/UDBwsV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726848283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J2NLc4e6fHj5AhD1jSBYYzMciBqQt2iDPqp7r4EEsPE=;
	b=2KhzUCXFD0P5dRnXToJpvr8NSSgKNX/tuX6h+bUjN/wzKDpug5WSwQw1QDwygG/8udvedY
	xV05XnB4zBXu8oA0j2E+KfHDjKIQ8Q6CZC8mr8OkQrcapiUOYWFSaA52S19XDn7RdVnn03
	cJ33FewcF9yJ5BHmQLuahctuMGNurDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726848283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J2NLc4e6fHj5AhD1jSBYYzMciBqQt2iDPqp7r4EEsPE=;
	b=+/UDBwsVcxZa9DQB9FB9Ass7ekkPCV4frVguflR4P/9mQwCGO4UqJ85773cULudww+czHr
	8Mpu9rIoAYeq4RAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AA4713AE1;
	Fri, 20 Sep 2024 16:04:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wFjpHRed7WYKaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Sep 2024 16:04:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1997FA08BD; Fri, 20 Sep 2024 18:04:05 +0200 (CEST)
Date: Fri, 20 Sep 2024 18:04:05 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 02/10] ext4: don't explicit update times in
 ext4_fallocate()
Message-ID: <20240920160405.ntt6l6rxup24o56n@quack3>
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904062925.716856-3-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 13C8433A3A
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Wed 04-09-24 14:29:17, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> After commit 'ad5cd4f4ee4d ("ext4: fix fallocate to use file_modified to
> update permissions consistently"), we can update mtime and ctime
> appropriately through file_modified() when doing zero range, collapse
> rage, insert range and punch hole, hence there is no need to explicit
> update times in those paths, just drop them.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Good point! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 4 ----
>  fs/ext4/inode.c   | 1 -
>  2 files changed, 5 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 7d5edfa2e630..19a9b14935b7 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4643,7 +4643,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  
>  		/* Now release the pages and zero block aligned part of pages */
>  		truncate_pagecache_range(inode, start, end - 1);
> -		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>  
>  		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
>  					     flags);
> @@ -4667,7 +4666,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  		goto out_invalidate_lock;
>  	}
>  
> -	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>  	if (new_size)
>  		ext4_update_inode_size(inode, new_size);
>  	ret = ext4_mark_inode_dirty(handle, inode);
> @@ -5393,7 +5391,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	up_write(&EXT4_I(inode)->i_data_sem);
>  	if (IS_SYNC(inode))
>  		ext4_handle_sync(handle);
> -	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>  	ret = ext4_mark_inode_dirty(handle, inode);
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
>  
> @@ -5503,7 +5500,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	/* Expand file to avoid data loss if there is error while shifting */
>  	inode->i_size += len;
>  	EXT4_I(inode)->i_disksize += len;
> -	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>  	ret = ext4_mark_inode_dirty(handle, inode);
>  	if (ret)
>  		goto out_stop;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index c3d7606a5315..8af25442d44d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4074,7 +4074,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	if (IS_SYNC(inode))
>  		ext4_handle_sync(handle);
>  
> -	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>  	ret2 = ext4_mark_inode_dirty(handle, inode);
>  	if (unlikely(ret2))
>  		ret = ret2;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

