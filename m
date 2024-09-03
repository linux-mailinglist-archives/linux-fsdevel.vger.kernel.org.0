Return-Path: <linux-fsdevel+bounces-28351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2503C969BE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78535284B70
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE24C1A42B9;
	Tue,  3 Sep 2024 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ilG0e6H2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XrYmZe0M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ilG0e6H2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XrYmZe0M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0815382F
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363149; cv=none; b=Rq8k23wawhWhXpoTbGUg3tVcR1YOoXlPKd0RYGquMnf4jfrKTsXJafxb3FRzG83WL+Q62bYGUqGEDTGChyMzV1Oxw1jb72aX/9ZkOL4VRMcWwCfjeE3nZe30rvtw9yY3fruXSpOt1Mit8dDwRRA7jHLFeQVzrB3aYZerRzU3lGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363149; c=relaxed/simple;
	bh=8sogvgm8rmII+uOcZ/46EWKdAwIqXXXXinSPj0k6LIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnvoPPTGBaZuWbz5P/AbxJopxUfh+RBzMIFIbHtDw4K5bQEa0HIzUJ6DxIacTBQL2Ak3NqewAnmefRGB7QKwXqePU+YSJq/JowhNxvRUF4FW2wtQBrFkBLHociuLMCB1/rSCaTEnEphWXTPzdMIUT1CdUCTB6yriBvUu3yyZhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ilG0e6H2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XrYmZe0M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ilG0e6H2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XrYmZe0M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8AF321986;
	Tue,  3 Sep 2024 11:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725363145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JRKJkKZzodTVWNHy7SvxAwOwhTSFqz3AUCjW+c8KbjI=;
	b=ilG0e6H2CKpmp357tf9nyaaTMaOdDopt1fSgT88jsQS75o5rae+saCa3xeutLqiH+vz5GE
	xxYhbeOYz1FWyeSRreWYP3gT1O/cyawJDtrL4Me5AhoxiKNWd1GECxXMZiltlhYr1jrJUO
	ntupuEA52IUwxN2uwKUEHxvOzl05wdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725363145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JRKJkKZzodTVWNHy7SvxAwOwhTSFqz3AUCjW+c8KbjI=;
	b=XrYmZe0M0ZHR2+pVugsdvQNVS1CVZCE3cXowy3/qo9m706VSEGLHlMrs9hjd2eaAvUC4hX
	/s5/krdyXf7AmcDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725363145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JRKJkKZzodTVWNHy7SvxAwOwhTSFqz3AUCjW+c8KbjI=;
	b=ilG0e6H2CKpmp357tf9nyaaTMaOdDopt1fSgT88jsQS75o5rae+saCa3xeutLqiH+vz5GE
	xxYhbeOYz1FWyeSRreWYP3gT1O/cyawJDtrL4Me5AhoxiKNWd1GECxXMZiltlhYr1jrJUO
	ntupuEA52IUwxN2uwKUEHxvOzl05wdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725363145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JRKJkKZzodTVWNHy7SvxAwOwhTSFqz3AUCjW+c8KbjI=;
	b=XrYmZe0M0ZHR2+pVugsdvQNVS1CVZCE3cXowy3/qo9m706VSEGLHlMrs9hjd2eaAvUC4hX
	/s5/krdyXf7AmcDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9ED4513A52;
	Tue,  3 Sep 2024 11:32:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KKjFJsnz1mZbIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 11:32:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5B442A096C; Tue,  3 Sep 2024 13:32:21 +0200 (CEST)
Date: Tue, 3 Sep 2024 13:32:21 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 06/20] fs: add must_set_pos()
Message-ID: <20240903113221.yy4opukwk2ayee5o@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-6-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-6-6d3e4816aa7b@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 30-08-24 15:04:47, Christian Brauner wrote:
> Add a new must_set_pos() helper. We will use it in follow-up patches.
> Temporarily mark it as unused. This is only done to keep the diff small
> and reviewable.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/read_write.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 66ff52860496..acee26989d95 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -85,6 +85,58 @@ loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize)
>  }
>  EXPORT_SYMBOL(vfs_setpos);
>  
> +/**
> + * must_set_pos - check whether f_pos has to be updated
> + * @offset: offset to use
> + * @whence: type of seek operation
> + * @eof: end of file
> + *
> + * Check whether f_pos needs to be updated and update @offset according
> + * to @whence.
> + *
> + * Return: 0 if f_pos doesn't need to be updated, 1 if f_pos has to be
> + * updated, and negative error code on failure.
> + */
> +static __maybe_unused int must_set_pos(struct file *file, loff_t *offset, int whence, loff_t eof)
> +{
> +	switch (whence) {
> +	case SEEK_END:
> +		*offset += eof;
> +		break;
> +	case SEEK_CUR:
> +		/*
> +		 * Here we special-case the lseek(fd, 0, SEEK_CUR)
> +		 * position-querying operation.  Avoid rewriting the "same"
> +		 * f_pos value back to the file because a concurrent read(),
> +		 * write() or lseek() might have altered it
> +		 */
> +		if (*offset == 0) {
> +			*offset = file->f_pos;
> +			return 0;
> +		}
> +		break;
> +	case SEEK_DATA:
> +		/*
> +		 * In the generic case the entire file is data, so as long as
> +		 * offset isn't at the end of the file then the offset is data.
> +		 */
> +		if ((unsigned long long)*offset >= eof)
> +			return -ENXIO;
> +		break;
> +	case SEEK_HOLE:
> +		/*
> +		 * There is a virtual hole at the end of the file, so as long as
> +		 * offset isn't i_size or larger, return i_size.
> +		 */
> +		if ((unsigned long long)*offset >= eof)
> +			return -ENXIO;
> +		*offset = eof;
> +		break;
> +	}
> +
> +	return 1;
> +}
> +
>  /**
>   * generic_file_llseek_size - generic llseek implementation for regular files
>   * @file:	file structure to seek on
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

