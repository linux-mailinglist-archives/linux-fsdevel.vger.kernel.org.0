Return-Path: <linux-fsdevel+bounces-28358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFC3969C29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE3B1F23F08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BED1A42DF;
	Tue,  3 Sep 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yiPNubSD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EyE59HPY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yiPNubSD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EyE59HPY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68A19F422
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363629; cv=none; b=p/O88icuRQTENuAEPbfD/iS0NcbIoKiwaGx5UYjywieFFq3mOsoc2TdAtXQWcpT5s16Pa77LyerKxjigfup2p9U2MEFbpkDTDzz7E0P13C7A94sQR+6O1AmwkPqstdk3L+PvpVaVhYBxr3nsWZbilCLDjYbGPf28BmQWRPkR+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363629; c=relaxed/simple;
	bh=YoqSXF37YSddcFwrOLRUUXWrtd5PaeJxGYObmhT24Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAbbe3GwOt1MwxgAc1nAUVCU0HwYrb+XZ+ayZDhBDjuBxhSxwzxov4ZcfZjMJcr0YP2FWPJF2B6mVIHroFu3cJ0YWhO6SnWAeUiqZrVbbbtUdqWeGrvmUde+T5NYRflq+AkwsQLXbuF0JPtCyPdcJ9NEw7384aexdhynmi0B0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yiPNubSD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EyE59HPY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yiPNubSD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EyE59HPY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FF641FD0C;
	Tue,  3 Sep 2024 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725363625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uEiIrDtMvcOw5cFdbHpRo+VHm7TsZV5rfTMaF1FuFCo=;
	b=yiPNubSDcAKD84uTHxCLAvNz0fNJu1/sC3QFMuKOEEbNghvB3NoKRuPDNSgqtrqKAxNE5l
	iv9ZhPiUzZwWSe/p2kUEW4szgRTBE4cPAwlyP/XTreASYQc6zUeV4wlaqs+YTkqbNbe6Mt
	Hy3R46QopW+sOySRDnB+VH7IMhOuipQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725363625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uEiIrDtMvcOw5cFdbHpRo+VHm7TsZV5rfTMaF1FuFCo=;
	b=EyE59HPYrgetWUGHGvGfRzvb6/omYWup30k2hx5FYaeGvsJ5hnRN0uWz6HZLTYtiML86z6
	PkScb67El87BMyDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725363625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uEiIrDtMvcOw5cFdbHpRo+VHm7TsZV5rfTMaF1FuFCo=;
	b=yiPNubSDcAKD84uTHxCLAvNz0fNJu1/sC3QFMuKOEEbNghvB3NoKRuPDNSgqtrqKAxNE5l
	iv9ZhPiUzZwWSe/p2kUEW4szgRTBE4cPAwlyP/XTreASYQc6zUeV4wlaqs+YTkqbNbe6Mt
	Hy3R46QopW+sOySRDnB+VH7IMhOuipQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725363625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uEiIrDtMvcOw5cFdbHpRo+VHm7TsZV5rfTMaF1FuFCo=;
	b=EyE59HPYrgetWUGHGvGfRzvb6/omYWup30k2hx5FYaeGvsJ5hnRN0uWz6HZLTYtiML86z6
	PkScb67El87BMyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FF9313A52;
	Tue,  3 Sep 2024 11:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sZjgHqn11mYBJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 11:40:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2A1B8A096C; Tue,  3 Sep 2024 13:40:25 +0200 (CEST)
Date: Tue, 3 Sep 2024 13:40:25 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 12/20] input: remove f_version abuse
Message-ID: <20240903114025.r5l4oqskpoaxuypm@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-12-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-12-6d3e4816aa7b@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 30-08-24 15:04:53, Christian Brauner wrote:
> Remove the f_version abuse from input. Use seq_private_open() to stash
> the information for poll.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/input/input.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 54c57b267b25..b03ae43707d8 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1081,9 +1081,11 @@ static inline void input_wakeup_procfs_readers(void)
>  
>  static __poll_t input_proc_devices_poll(struct file *file, poll_table *wait)
>  {
> +	struct seq_file *m = file->private_data;
> +
>  	poll_wait(file, &input_devices_poll_wait, wait);
> -	if (file->f_version != input_devices_state) {
> -		file->f_version = input_devices_state;
> +	if (*(u64 *)m->private != input_devices_state) {
> +		*(u64 *)m->private = input_devices_state;
>  		return EPOLLIN | EPOLLRDNORM;
>  	}
>  
> @@ -1210,7 +1212,7 @@ static const struct seq_operations input_devices_seq_ops = {
>  
>  static int input_proc_devices_open(struct inode *inode, struct file *file)
>  {
> -	return seq_open(file, &input_devices_seq_ops);
> +	return seq_open_private(file, &input_devices_seq_ops, sizeof(u64));
>  }
>  
>  static const struct proc_ops input_devices_proc_ops = {
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

