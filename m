Return-Path: <linux-fsdevel+bounces-28378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE35969F57
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D65CB22B19
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9223A8C07;
	Tue,  3 Sep 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A45174wu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tp0aBxxV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rbmA+bK5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dGJP8oUC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514151CA69A
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371123; cv=none; b=CseqtUAzBpgb8VuhO+QQXHwWyXFL6wNFOrpGKDeft6m8/ZKxJNJZX2i0ZajEzJKPU3+0bWk8tibtHSncaWIU2MMYSzzrYyq/qGcUYniG+sjXes/79c3P5MzUGB+XqGpAwQN0hU6htjKy2Ive/CapyGNe56nARkaJlm1y9Rbr9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371123; c=relaxed/simple;
	bh=x1maVx7H3bPAarPUIpXRTdQafZgxCPU6cRhXz4NGNIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSIafNNtekbPHQt5IY8WbPdtN5oylXI1Hnc1Vl4uTbN4A5PiwYc4KIr3ONwq4Gydox8nP+PhFWAe9PGAfx/W71YdP6U0sNmSo8rRh0DV+O+278bRdDqGUqeaSCr0H4GZonkNkEjSpGnHfSy/Yptfb7pKyQ0EbuUPs5p/YiB0nAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A45174wu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tp0aBxxV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rbmA+bK5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dGJP8oUC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4035F21BA3;
	Tue,  3 Sep 2024 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725371119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OpjUOzfPJqE8I5ucAeyzt9O45K13DBidqp93DYk0kqI=;
	b=A45174wucKS38sFGf52AtJID/RlT8lYnmWR0ZQXUanDsdboJWMgZWNKssAg2z6SabC9eeV
	h3Rf0wEA2DPOj2LsXmTeccha+07OGU6XzeqVrk3jZkkc4CHYI+Fonmlb0Csi9FYkFWLdN+
	4JmtBZTDa2dHlM6gvtOGMe2j3SP5TE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725371119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OpjUOzfPJqE8I5ucAeyzt9O45K13DBidqp93DYk0kqI=;
	b=tp0aBxxVKPNfw95os3RbVMZiKAptLVnj/UE2xuouYppP4zEIx0bH+0giQfrUbNxZfcTStB
	a4aCz4voL6k8IdCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725371118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OpjUOzfPJqE8I5ucAeyzt9O45K13DBidqp93DYk0kqI=;
	b=rbmA+bK5pJfkoLnqt75VUXvNeXlSm2ZJKj+ggZZWshuoB7v434AoV95iThVumbbJTti/Le
	5JF62ZahJmjLwnf+5qRKWGRvzW7W4jsSPMoxlgHt2TZ+WoLPt34vdRqe3Uii6d4N1/PFtq
	IA2bcKemRBo6Xu+5ER3eGXTPFr1uc8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725371118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OpjUOzfPJqE8I5ucAeyzt9O45K13DBidqp93DYk0kqI=;
	b=dGJP8oUCgYEnmG0FXa25KstM3BO1zQy4rEQiL2DS8sy5rV4wj3NLp4IUQ96nxNDEyJJxJD
	67Pj8uXq1/YsW/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33B8B13A52;
	Tue,  3 Sep 2024 13:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1U2aDO4S12b5TAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 13:45:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B9BF5A096C; Tue,  3 Sep 2024 15:45:17 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:45:17 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 20/20] fs: remove f_version
Message-ID: <20240903134517.23pzy7l4uvwfmzj2@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-20-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-20-6d3e4816aa7b@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 30-08-24 15:05:01, Christian Brauner wrote:
> Now that detecting concurrent seeks is done by the filesystems that
> require it we can remove f_version and free up 8 bytes for future
> extensions.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/read_write.c    | 9 ++++-----
>  include/linux/fs.h | 4 +---
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 47f7b4e32a53..981146f50568 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -62,7 +62,8 @@ static loff_t vfs_setpos_cookie(struct file *file, loff_t offset,
>  
>  	if (offset != file->f_pos) {
>  		file->f_pos = offset;
> -		*cookie = 0;
> +		if (cookie)
> +			*cookie = 0;
>  	}
>  	return offset;
>  }
> @@ -81,7 +82,7 @@ static loff_t vfs_setpos_cookie(struct file *file, loff_t offset,
>   */
>  loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize)
>  {
> -	return vfs_setpos_cookie(file, offset, maxsize, &file->f_version);
> +	return vfs_setpos_cookie(file, offset, maxsize, NULL);
>  }
>  EXPORT_SYMBOL(vfs_setpos);
>  
> @@ -362,10 +363,8 @@ loff_t default_llseek(struct file *file, loff_t offset, int whence)
>  	}
>  	retval = -EINVAL;
>  	if (offset >= 0 || unsigned_offsets(file)) {
> -		if (offset != file->f_pos) {
> +		if (offset != file->f_pos)
>  			file->f_pos = offset;
> -			file->f_version = 0;
> -		}
>  		retval = offset;
>  	}
>  out:
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ca4925008244..7e11ce172140 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1003,7 +1003,6 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
>   * @f_pos_lock: lock protecting file position
>   * @f_pipe: specific to pipes
>   * @f_pos: file position
> - * @f_version: file version
>   * @f_security: LSM security context of this file
>   * @f_owner: file owner
>   * @f_wb_err: writeback error
> @@ -1034,11 +1033,10 @@ struct file {
>  		u64			f_pipe;
>  	};
>  	loff_t				f_pos;
> -	u64				f_version;
> -	/* --- cacheline 2 boundary (128 bytes) --- */
>  #ifdef CONFIG_SECURITY
>  	void				*f_security;
>  #endif
> +	/* --- cacheline 2 boundary (128 bytes) --- */
>  	struct fown_struct		*f_owner;
>  	errseq_t			f_wb_err;
>  	errseq_t			f_sb_err;
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

