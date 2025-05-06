Return-Path: <linux-fsdevel+bounces-48227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AF9AAC2B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 13:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803921C227E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BC927B4EE;
	Tue,  6 May 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xrBK+tDi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uOguJXW3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xrBK+tDi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uOguJXW3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F2278E5D
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531034; cv=none; b=Z8XMUOh+3RbOxMQf2XK1Q8rTsH4PFRzcyLg3Rg0nj/l3vvN4V4PGplc/l4/AHyaioSri80+62/Ynibi+yM+FW089PXcKJhKogOAu6nXEx7P0mwtG8DguGfAIEO8zR0RNDyWklcT4VmT/GyxtnQoHzas2iCWEmN3exyVyOvnWWds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531034; c=relaxed/simple;
	bh=4nOPsplIo0HRm+rc/wKow8IH+hJnslEzdHWl70rPsZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoRqzenQZpt/y3dHQ0ER5D3+kEBk+9b+Qwn7rvCVnjDz41Zjyj0VvmvzoovfxWyrDlOODOcII4czPJ5yZrMZ6pueE+pQDD/FUlof/fRktcpfpWcGpckpk9iIHST7KMMn0gjol+mKsHWQlTDoiQNii5v4KgmzwIr6CBIjMhu3HgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xrBK+tDi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uOguJXW3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xrBK+tDi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uOguJXW3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75B522120B;
	Tue,  6 May 2025 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746531030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUQayq6zhQx2B6zZ54uV6kGLYbK2gmDppDAX2AkQtUg=;
	b=xrBK+tDi3WVRY0GaHXCbpot46mX8Gloz8sRQIq0BnKsrFH6+VqUnAiGQSYnddTgdODxOvo
	bXDCMv7b1SAKINmiDUs1AtbJwb5tOUHFBLrPrBCkluQM7gsFhYI1gTxJN0Tv2Fr2ppsvJz
	T3sM6tE8rT3IXtIu0djFbOzsilVPDWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746531030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUQayq6zhQx2B6zZ54uV6kGLYbK2gmDppDAX2AkQtUg=;
	b=uOguJXW3aw2PxIy8TpLJdaEjTzpfVCNk92VdcRe5rnIfxbMYDUKYiL3vu/x3XPduFzrs2o
	ClWuUI2qbph08FDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xrBK+tDi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uOguJXW3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746531030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUQayq6zhQx2B6zZ54uV6kGLYbK2gmDppDAX2AkQtUg=;
	b=xrBK+tDi3WVRY0GaHXCbpot46mX8Gloz8sRQIq0BnKsrFH6+VqUnAiGQSYnddTgdODxOvo
	bXDCMv7b1SAKINmiDUs1AtbJwb5tOUHFBLrPrBCkluQM7gsFhYI1gTxJN0Tv2Fr2ppsvJz
	T3sM6tE8rT3IXtIu0djFbOzsilVPDWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746531030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUQayq6zhQx2B6zZ54uV6kGLYbK2gmDppDAX2AkQtUg=;
	b=uOguJXW3aw2PxIy8TpLJdaEjTzpfVCNk92VdcRe5rnIfxbMYDUKYiL3vu/x3XPduFzrs2o
	ClWuUI2qbph08FDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66664137CF;
	Tue,  6 May 2025 11:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jH73GNbyGWjGFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 May 2025 11:30:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1FC04A09BE; Tue,  6 May 2025 13:30:26 +0200 (CEST)
Date: Tue, 6 May 2025 13:30:26 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	wanghaichi0403@gmail.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH v2 2/4] ext4: fix incorrect punch max_end
Message-ID: <54ofseazhzubiefimevkqmgslu5dugnambtg5xqqmzcltzooeo@nt7vbsryn42g>
References: <20250506012009.3896990-1-yi.zhang@huaweicloud.com>
 <20250506012009.3896990-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506012009.3896990-2-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 75B522120B
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 06-05-25 09:20:07, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> For the extents based inodes, the maxbytes should be sb->s_maxbytes
> instead of sbi->s_bitmap_maxbytes. Additionally, for the calculation of
> max_end, the -sb->s_blocksize operation is necessary only for
> indirect-block based inodes. Correct the maxbytes and max_end value to
> correct the behavior of punch hole.
> 
> Fixes: 2da376228a24 ("ext4: limit length to bitmap_maxbytes - blocksize in punch_hole")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4ec4a80b6879..5691966a19e1 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4006,7 +4006,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	struct inode *inode = file_inode(file);
>  	struct super_block *sb = inode->i_sb;
>  	ext4_lblk_t start_lblk, end_lblk;
> -	loff_t max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
> +	loff_t max_end = sb->s_maxbytes;
>  	loff_t end = offset + length;
>  	handle_t *handle;
>  	unsigned int credits;
> @@ -4015,14 +4015,20 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	trace_ext4_punch_hole(inode, offset, length, 0);
>  	WARN_ON_ONCE(!inode_is_locked(inode));
>  
> +	/*
> +	 * For indirect-block based inodes, make sure that the hole within
> +	 * one block before last range.
> +	 */
> +	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
> +
>  	/* No need to punch hole beyond i_size */
>  	if (offset >= inode->i_size || offset >= max_end)
>  		return 0;
>  
>  	/*
>  	 * If the hole extends beyond i_size, set the hole to end after
> -	 * the page that contains i_size, and also make sure that the hole
> -	 * within one block before last range.
> +	 * the page that contains i_size.
>  	 */
>  	if (end > inode->i_size)
>  		end = round_up(inode->i_size, PAGE_SIZE);
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

