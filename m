Return-Path: <linux-fsdevel+bounces-71763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 766FFCD1019
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 17:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D75830EC2C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785FA33F8B4;
	Fri, 19 Dec 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qBo3BTCF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2DgyCcC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qBo3BTCF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2DgyCcC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2AF33C53B
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766162551; cv=none; b=LMf8xaav5N25HwDYYvl3GzWh8PYNCdBNVwfZAKwQ5MthpsxYMGZ3smaGiWeNN0iejVaiRyuV4x4OSUW2CpeMuEvcRtnM2W/meswoqQl4PA/PwxjZA/Njf/KhuROkuR570eOoilFGAsjAavQtYB1R1aFJDdKBe/ISB1drPuI5b9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766162551; c=relaxed/simple;
	bh=MXi/Vix8LUD4ENpmkwFO532DoOZJlagkX7Fb2eTHGKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6dAyerxSELdXw82gLCIPdT6XqPfU++Y3vLtYMeo1XNxMdfb3bi77SpNGRygkL0+DvfvUs6Eu5qtjr4ngEQ7IRO/sSqvShlLaJMQtlO6eJsT3tzC02Vu7OndE3OSQslTKkenmkJIxAaU7Id4JWu31TBkh1byMlmTLVwp7DV4S9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qBo3BTCF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2DgyCcC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qBo3BTCF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2DgyCcC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E6E45BD17;
	Fri, 19 Dec 2025 16:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766162548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9REAt4JVEKw3zUGWx9R7qcA4TpPzxPYqTV2KAY48us=;
	b=qBo3BTCFeB/+d8VJTq+QjgjRdFj+NqDEjSr2LU3fYV00roqe92ByPWmH/zfHXDt/MtVnH9
	j+fUK/G36hYPuTGBz8iFcCO3yge1eL9KOiuJmcCcI/1yAzTGDJVKeF1/+xWbX9TLwvyfj4
	/Wy0nfl/XE1xb3hEPA06sITBUJvivOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766162548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9REAt4JVEKw3zUGWx9R7qcA4TpPzxPYqTV2KAY48us=;
	b=B2DgyCcC2q3hlNuzxhV0Lj/Ya1et5zz+n3d/alCKmNwl3Xb662j7On7+nJPIZxq5vF/vLO
	D0ZcSb5F8jM/IdCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qBo3BTCF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B2DgyCcC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766162548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9REAt4JVEKw3zUGWx9R7qcA4TpPzxPYqTV2KAY48us=;
	b=qBo3BTCFeB/+d8VJTq+QjgjRdFj+NqDEjSr2LU3fYV00roqe92ByPWmH/zfHXDt/MtVnH9
	j+fUK/G36hYPuTGBz8iFcCO3yge1eL9KOiuJmcCcI/1yAzTGDJVKeF1/+xWbX9TLwvyfj4
	/Wy0nfl/XE1xb3hEPA06sITBUJvivOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766162548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9REAt4JVEKw3zUGWx9R7qcA4TpPzxPYqTV2KAY48us=;
	b=B2DgyCcC2q3hlNuzxhV0Lj/Ya1et5zz+n3d/alCKmNwl3Xb662j7On7+nJPIZxq5vF/vLO
	D0ZcSb5F8jM/IdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AD913EA63;
	Fri, 19 Dec 2025 16:42:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ppIqFnSARWlDVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Dec 2025 16:42:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 12C9AA090B; Fri, 19 Dec 2025 17:42:20 +0100 (CET)
Date: Fri, 19 Dec 2025 17:42:20 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, yi.zhang@huawei.com, yizhang089@gmail.com, 
	libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com
Subject: Re: [PATCH -next 5/7] ext4: remove unused unwritten parameter in
 ext4_dio_write_iter()
Message-ID: <o3rtwmpwb3jmzp3zyfizyiohylvt72j3ssmtvenesygl3vltri@subp7ujvzyfq>
References: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
 <20251213022008.1766912-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213022008.1766912-6-yi.zhang@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 6E6E45BD17
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,huawei.com,fnnas.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,huawei.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Sat 13-12-25 10:20:06, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The parameter unwritten in ext4_dio_write_iter() is no longer needed,
> simply remove it.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/file.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 6b4b68f830d5..fa22fc0e45f3 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -424,14 +424,14 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>   */
>  static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  				     bool *ilock_shared, bool *extend,
> -				     bool *unwritten, int *dio_flags)
> +				     int *dio_flags)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file_inode(file);
>  	loff_t offset;
>  	size_t count;
>  	ssize_t ret;
> -	bool overwrite, unaligned_io;
> +	bool overwrite, unaligned_io, unwritten;
>  
>  restart:
>  	ret = ext4_generic_write_checks(iocb, from);
> @@ -443,7 +443,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  
>  	unaligned_io = ext4_unaligned_io(inode, from, offset);
>  	*extend = ext4_extending_io(inode, offset, count);
> -	overwrite = ext4_overwrite_io(inode, offset, count, unwritten);
> +	overwrite = ext4_overwrite_io(inode, offset, count, &unwritten);
>  
>  	/*
>  	 * Determine whether we need to upgrade to an exclusive lock. This is
> @@ -458,7 +458,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  	 */
>  	if (*ilock_shared &&
>  	    ((!IS_NOSEC(inode) || *extend || !overwrite ||
> -	     (unaligned_io && *unwritten)))) {
> +	     (unaligned_io && unwritten)))) {
>  		if (iocb->ki_flags & IOCB_NOWAIT) {
>  			ret = -EAGAIN;
>  			goto out;
> @@ -481,7 +481,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  			ret = -EAGAIN;
>  			goto out;
>  		}
> -		if (unaligned_io && (!overwrite || *unwritten))
> +		if (unaligned_io && (!overwrite || unwritten))
>  			inode_dio_wait(inode);
>  		*dio_flags = IOMAP_DIO_FORCE_WAIT;
>  	}
> @@ -506,7 +506,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	loff_t offset = iocb->ki_pos;
>  	size_t count = iov_iter_count(from);
> -	bool extend = false, unwritten = false;
> +	bool extend = false;
>  	bool ilock_shared = true;
>  	int dio_flags = 0;
>  
> @@ -552,7 +552,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>  
>  	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend,
> -				    &unwritten, &dio_flags);
> +				    &dio_flags);
>  	if (ret <= 0)
>  		return ret;
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

