Return-Path: <linux-fsdevel+bounces-28723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F7096D81A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6058A28A277
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F56F198E93;
	Thu,  5 Sep 2024 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="09aTelCG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z2c5vrZL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bymb/dfm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="saJmVOAf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03C17A5BE
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538554; cv=none; b=DDmfRF1vzcL9pK+XQMb5rO0LmaWDMkOE3lTLduRXtlZGJaG1SRzjGfxtNM9Hg9xG21jxS/GPRlgStjI9i6lDkTuQxbTpiXnGhjmkJCqgufjtGKOEEi1xf7VzeyLXYJ0c/ZgR7HXzBjT76tni9BbJiJNSFNsLu75EM+OEM0xzwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538554; c=relaxed/simple;
	bh=lUvrAabktLXmMGLSKsj316NHBsxP6xGzmeIZf2/vgvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/+Dakl0XpYuW5IlUaFjEl3VA8JaL7YBm//2mCXbAvd9x2Mw6blJFb7LOyyYgQRAWqwteAPE35EtB7JokE98fqBgU1ZVd23UePzWfAbCBAhWuLblhlP+Sfr9f3n7WeUrBBsgRyPVTkjlS1L4D3P6wlYXMKzOuycV7ssNXQsioYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=09aTelCG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z2c5vrZL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bymb/dfm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=saJmVOAf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DBD5E21A8A;
	Thu,  5 Sep 2024 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725538551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29XkTPONY0eLQDtHM79iVrnphhTq5SCfJd2sFkTP3CI=;
	b=09aTelCGLvQWm6Kvy5aM4+7f9daAl0io2g8AO8riciRwP5K26yQUaCZKfyqI4NYtJKjxSa
	53c/1sMftgFDoLGfxsaUddwWViVjSIEG1KOGm4uRpMMX2TbVV9qvZW3WufqGHoTmji/914
	8wAY85nYOgb/U5c1AU2EcWRsl54Q+9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725538551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29XkTPONY0eLQDtHM79iVrnphhTq5SCfJd2sFkTP3CI=;
	b=z2c5vrZL/zZOWtzzK1zRM3AaQiX1+QvciqYApbNPHw/U533uthQXX3tC33uLeSCpnLSnKS
	x3PiIB0ZblsmheBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="bymb/dfm";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=saJmVOAf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725538549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29XkTPONY0eLQDtHM79iVrnphhTq5SCfJd2sFkTP3CI=;
	b=bymb/dfmmA0vYcB50P75AUn9SfFsvAoSfHA+LeWHTGoX2aUsdkCblC2VakbyYSFsdERQMQ
	Q/mE3AGBkkysmNbImG9m3L35hc/ilvbLEAh4qmTNs3/fQPuRgKcEvzqVZJGuRXTq4kSqUw
	MHJBQG1IFxFI8GwAbim9orSDGiL9Ub4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725538549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29XkTPONY0eLQDtHM79iVrnphhTq5SCfJd2sFkTP3CI=;
	b=saJmVOAfIXPq4LVgXzQAvOr6RQf+/scnNHqyx8mX01fr/9ll1nuEvpp2RHkdcoixkEHKdS
	zaUpzoZiu9hkdDCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC8221395F;
	Thu,  5 Sep 2024 12:15:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1OOjMfWg2WZNbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Sep 2024 12:15:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7E559A0968; Thu,  5 Sep 2024 14:15:45 +0200 (CEST)
Date: Thu, 5 Sep 2024 14:15:45 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
	viro@zeniv.linux.org.uk, djwong@kernel.org, david@fromorbit.com,
	hch@lst.de, syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] vfs: Fix implicit conversion problem when testing
 overflow case
Message-ID: <20240905121545.ma6zdnswn5s72byb@quack3>
References: <20240905102656.1107446-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905102656.1107446-1-sunjunchao2870@gmail.com>
X-Rspamd-Queue-Id: DBD5E21A8A
X-Spam-Score: -2.51
X-Rspamd-Action: no action
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
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[296b1c84b9cbf306e5a0];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 05-09-24 18:26:56, Julian Sun wrote:
> The overflow check in generic_copy_file_checks() and generic_remap_checks()
> is now broken because the result of the addition is implicitly converted to
> an unsigned type, which disrupts the comparison with signed numbers.
> This caused the kernel to not return EOVERFLOW in copy_file_range()
> call with len is set to 0xffffffffa003e45bul.
> 
> Use the check_add_overflow() macro to fix this issue.
> 
> Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
> Fixes: 1383a7ed6749 ("vfs: check file ranges before cloning files")
> Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
> Inspired-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/read_write.c  | 5 +++--
>  fs/remap_range.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 90e283b31ca1..349e4df5e0b0 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1416,7 +1416,7 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  	struct inode *inode_in = file_inode(file_in);
>  	struct inode *inode_out = file_inode(file_out);
>  	uint64_t count = *req_count;
> -	loff_t size_in;
> +	loff_t size_in, tmp;
>  	int ret;
>  
>  	ret = generic_file_rw_checks(file_in, file_out);
> @@ -1451,7 +1451,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  		return -ETXTBSY;
>  
>  	/* Ensure offsets don't wrap. */
> -	if (pos_in + count < pos_in || pos_out + count < pos_out)
> +	if (check_add_overflow(pos_in, count, &tmp) ||
> +	    check_add_overflow(pos_out, count, &tmp))
>  		return -EOVERFLOW;
>  
>  	/* Shorten the copy to EOF */
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 28246dfc8485..6fdeb3c8cb70 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -36,7 +36,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  	struct inode *inode_out = file_out->f_mapping->host;
>  	uint64_t count = *req_count;
>  	uint64_t bcount;
> -	loff_t size_in, size_out;
> +	loff_t size_in, size_out, tmp;
>  	loff_t bs = inode_out->i_sb->s_blocksize;
>  	int ret;
>  
> @@ -45,7 +45,8 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  		return -EINVAL;
>  
>  	/* Ensure offsets don't wrap. */
> -	if (pos_in + count < pos_in || pos_out + count < pos_out)
> +	if (check_add_overflow(pos_in, count, &tmp) ||
> +	    check_add_overflow(pos_out, count, &tmp))
>  		return -EINVAL;
>  
>  	size_in = i_size_read(inode_in);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

