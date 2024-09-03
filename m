Return-Path: <linux-fsdevel+bounces-28352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CD7969BE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8E4284CB3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A31E1A42B3;
	Tue,  3 Sep 2024 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J4Jhyk+1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5bZ7O1fl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J4Jhyk+1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5bZ7O1fl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F6195
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363258; cv=none; b=bTw2VGKzdOryiFSmA17CCvRYuZs7b8qFSl5wzjXV44OlbpPVXa15U48eegEGOnh7olR9dykp2bYiapTV4A0ZEdvpzKQDPhaukRbJE9y1hNqyPrK1w4R8rdHBWrgOfUa/d21Ph3tAktYDZufYrjiXzb5wna4b2axZDDXF0QfZyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363258; c=relaxed/simple;
	bh=P+EdmlUvz27yef53iSi4qkrClozAsawkeqxb/FMoTxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM4Nca/plBu3fPdrbMnF+uHJmZUWxJ/c/fdSjMtXtZv7G7JEhqwPLtw79zTtKgaX7MxOPrbLFYXW4mJqHhbBZer5bCpahag1jr9OZGBjqZ+/mrPSMo4kLV+f7wdp4RY0nt25wbJyBb7MA7Hzq6v8qoaEGy4nc/OQJBW5gwEehyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J4Jhyk+1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5bZ7O1fl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J4Jhyk+1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5bZ7O1fl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21D981F444;
	Tue,  3 Sep 2024 11:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725363249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbpl8y5bvuv7uoZzXoWbfJs2TKbvWCGXH0yoB2kfils=;
	b=J4Jhyk+1V5UK8gYmb4x3jZIRE7FPgD6PwvuG8uOvESOK0Sp+w+jPeAyOcZbY8MusDMuif/
	dKXapiMOlt6kmfw95tCyH1mGLWWT/fF4+BrOShK67e1IdssVUSMIUOQzgu4D73ldJy5wBZ
	DgUG92qA/u32KS2uo2gNtU+ryuKafRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725363249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbpl8y5bvuv7uoZzXoWbfJs2TKbvWCGXH0yoB2kfils=;
	b=5bZ7O1fluRDSGUMAzXy3o8J9KuFe+Hl0UU35o1CaFdQVUTtWoxGNdb+AkH4PlCBqvBWODF
	jTCDrBcvlucoUYAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J4Jhyk+1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5bZ7O1fl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725363249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbpl8y5bvuv7uoZzXoWbfJs2TKbvWCGXH0yoB2kfils=;
	b=J4Jhyk+1V5UK8gYmb4x3jZIRE7FPgD6PwvuG8uOvESOK0Sp+w+jPeAyOcZbY8MusDMuif/
	dKXapiMOlt6kmfw95tCyH1mGLWWT/fF4+BrOShK67e1IdssVUSMIUOQzgu4D73ldJy5wBZ
	DgUG92qA/u32KS2uo2gNtU+ryuKafRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725363249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbpl8y5bvuv7uoZzXoWbfJs2TKbvWCGXH0yoB2kfils=;
	b=5bZ7O1fluRDSGUMAzXy3o8J9KuFe+Hl0UU35o1CaFdQVUTtWoxGNdb+AkH4PlCBqvBWODF
	jTCDrBcvlucoUYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B6A913A52;
	Tue,  3 Sep 2024 11:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZEjFAjH01mb5IgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 11:34:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C43D8A096C; Tue,  3 Sep 2024 13:34:04 +0200 (CEST)
Date: Tue, 3 Sep 2024 13:34:04 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 08/20] fs: add generic_llseek_cookie()
Message-ID: <20240903113404.jhwxodtvghg3ss7q@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-8-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-8-6d3e4816aa7b@kernel.org>
X-Rspamd-Queue-Id: 21D981F444
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 30-08-24 15:04:49, Christian Brauner wrote:
> This is similar to generic_file_llseek() but allows the caller to
> specify a cookie that will be updated to indicate that a seek happened.
> Caller's requiring that information in their readdir implementations can
> use that.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/read_write.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  2 ++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index ad93b72cc378..47f7b4e32a53 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -179,6 +179,50 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
>  }
>  EXPORT_SYMBOL(generic_file_llseek_size);
>  
> +/**
> + * generic_llseek_cookie - versioned llseek implementation
> + * @file:	file structure to seek on
> + * @offset:	file offset to seek to
> + * @whence:	type of seek
> + * @cookie:	cookie to update
> + *
> + * See generic_file_llseek for a general description and locking assumptions.
> + *
> + * In contrast to generic_file_llseek, this function also resets a
> + * specified cookie to indicate a seek took place.
> + */
> +loff_t generic_llseek_cookie(struct file *file, loff_t offset, int whence,
> +			     u64 *cookie)
> +{
> +	struct inode *inode = file->f_mapping->host;
> +	loff_t maxsize = inode->i_sb->s_maxbytes;
> +	loff_t eof = i_size_read(inode);
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!cookie))
> +		return -EINVAL;
> +
> +	ret = must_set_pos(file, &offset, whence, eof);
> +	if (ret < 0)
> +		return ret;
> +	if (ret == 0)
> +		return offset;
> +
> +	if (whence == SEEK_CUR) {
> +		/*
> +		 * f_lock protects against read/modify/write race with
> +		 * other SEEK_CURs. Note that parallel writes and reads
> +		 * behave like SEEK_SET.
> +		 */
> +		guard(spinlock)(&file->f_lock);
> +		return vfs_setpos_cookie(file, file->f_pos + offset, maxsize,
> +					 cookie);
> +	}
> +
> +	return vfs_setpos_cookie(file, offset, maxsize, cookie);
> +}
> +EXPORT_SYMBOL(generic_llseek_cookie);
> +
>  /**
>   * generic_file_llseek - generic llseek implementation for regular files
>   * @file:	file structure to seek on
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 58c91a52cad1..3e6b3c1afb31 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3202,6 +3202,8 @@ extern loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize);
>  extern loff_t generic_file_llseek(struct file *file, loff_t offset, int whence);
>  extern loff_t generic_file_llseek_size(struct file *file, loff_t offset,
>  		int whence, loff_t maxsize, loff_t eof);
> +loff_t generic_llseek_cookie(struct file *file, loff_t offset, int whence,
> +			     u64 *cookie);
>  extern loff_t fixed_size_llseek(struct file *file, loff_t offset,
>  		int whence, loff_t size);
>  extern loff_t no_seek_end_llseek_size(struct file *, loff_t, int, loff_t);
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

