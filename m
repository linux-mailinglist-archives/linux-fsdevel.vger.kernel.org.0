Return-Path: <linux-fsdevel+bounces-47701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6A8AA447A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 09:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2243B7BC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 07:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D6520FA96;
	Wed, 30 Apr 2025 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FpsNl4Hv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X/9qozxk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FpsNl4Hv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X/9qozxk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C8204583
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999662; cv=none; b=c9bjW/qgnVP4WpVIeH4z9dJGLaZMr4bLxSuZopsPU2kCaz62AkD6WGEw8gKVkrJqY/kjwWVYrgkZTWouIGW1njIIm2nooq70S8ZHTY1FbJ0yIDfmbJB3xrm06lIZS6XwKxuPgl+Ou94aLclpGLE0Rs1CS5PIDWnZ2f737+r05wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999662; c=relaxed/simple;
	bh=lkmp1gopiljWqXM8zx23hwHt43lpCIZsPpke4UsDnoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xn79d4iwy0wJrvmKDFycFpL2GtCIXGk6I7L/3viwrLvw1q8qRPyNq+BqVIaM5ZtJgn5RCZvUsaz63WKn4DSq9G/usv99hakp7/QAX4wmlTH/DUsuHiS9/djD6uqm6Vcftf2nn/IkFT12Ax8WTasF2Aul3e3YD66pjQ2P4cDXgWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FpsNl4Hv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X/9qozxk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FpsNl4Hv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X/9qozxk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ACAEB1F7BF;
	Wed, 30 Apr 2025 07:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745999658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RNr8x1DmKFr7aGM74nmp7nPuXSgKl6Y+jZaCLlXBIx8=;
	b=FpsNl4HvdvKk29ubrZ54mGcEcmvKxf9cvCVx90a3ADGdsMlX+BDEAk+ebFuRqCsJH9BGjS
	saZBjIvqql3eD8DYRul6jD2egV5NJWm8mlv4iDmX4WOlauI/3tOQIY1sgZNB0IHzusySnp
	uBP5v8jFS+OSHlxkJVYHAt/wjGDEMFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745999658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RNr8x1DmKFr7aGM74nmp7nPuXSgKl6Y+jZaCLlXBIx8=;
	b=X/9qozxkxwlRZybnVbltYdBy8ogom7eS2cM+xlyWA9lR6wGRo+V8EGEynWSna288C7p+Pg
	ISOxnstljxMAk5Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FpsNl4Hv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="X/9qozxk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745999658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RNr8x1DmKFr7aGM74nmp7nPuXSgKl6Y+jZaCLlXBIx8=;
	b=FpsNl4HvdvKk29ubrZ54mGcEcmvKxf9cvCVx90a3ADGdsMlX+BDEAk+ebFuRqCsJH9BGjS
	saZBjIvqql3eD8DYRul6jD2egV5NJWm8mlv4iDmX4WOlauI/3tOQIY1sgZNB0IHzusySnp
	uBP5v8jFS+OSHlxkJVYHAt/wjGDEMFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745999658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RNr8x1DmKFr7aGM74nmp7nPuXSgKl6Y+jZaCLlXBIx8=;
	b=X/9qozxkxwlRZybnVbltYdBy8ogom7eS2cM+xlyWA9lR6wGRo+V8EGEynWSna288C7p+Pg
	ISOxnstljxMAk5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0D0A139E7;
	Wed, 30 Apr 2025 07:54:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tZwoJyrXEWiZBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Apr 2025 07:54:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 523B2A0AF0; Wed, 30 Apr 2025 09:54:14 +0200 (CEST)
Date: Wed, 30 Apr 2025 09:54:14 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	wanghaichi0403@gmail.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH 2/4] ext4: fix incorrect punch max_end
Message-ID: <6jdhsvt6c77z7ta22okumhs7hzcwchrlsbg3xax2umgo4m3pyf@nte2kcbmbb7b>
References: <20250430011301.1106457-1-yi.zhang@huaweicloud.com>
 <20250430011301.1106457-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430011301.1106457-2-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: ACAEB1F7BF
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huawei.com:email,suse.cz:dkim,suse.cz:email];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 30-04-25 09:12:59, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> For the extents inodes, the maxbytes should be sb->s_maxbytes instead of
> sbi->s_bitmap_maxbytes. Correct the maxbytes value to correct the
> behavior of punch hole.
> 
> Fixes: 2da376228a24 ("ext4: limit length to bitmap_maxbytes - blocksize in punch_hole")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4ec4a80b6879..f9725e6347c7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4006,7 +4006,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	struct inode *inode = file_inode(file);
>  	struct super_block *sb = inode->i_sb;
>  	ext4_lblk_t start_lblk, end_lblk;
> -	loff_t max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
> +	loff_t max_end;
>  	loff_t end = offset + length;
>  	handle_t *handle;
>  	unsigned int credits;
> @@ -4015,6 +4015,12 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	trace_ext4_punch_hole(inode, offset, length, 0);
>  	WARN_ON_ONCE(!inode_is_locked(inode));
>  
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		max_end = sb->s_maxbytes;
> +	else
> +		max_end = EXT4_SB(sb)->s_bitmap_maxbytes;
> +	max_end -= sb->s_blocksize;
> +
>  	/* No need to punch hole beyond i_size */
>  	if (offset >= inode->i_size || offset >= max_end)
>  		return 0;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

