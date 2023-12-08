Return-Path: <linux-fsdevel+bounces-5366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8F680AE0D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 21:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FBF1C20311
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 20:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A9F3BB55
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b6xRUKDm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/7FHL6Rr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1IZiv7Ml";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ixK9Y3ZI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7397710E7
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 10:46:10 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE7C61F74D;
	Fri,  8 Dec 2023 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702061169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fi4paHaQDX+BjiWjAE0zDV7z8la+3YmZrhghgPdwHIM=;
	b=b6xRUKDmPaxBBUFSnHCeSz0B28gQwQO0GWDr9yPC/mrQZS6R1HiiwL6zMJXU9EnUhDLObq
	T+OTrqGIPJGROlk89IjlHA5vKdO4lsRAVoUmsdiYemYRqUGG8TxZ13kgNfahyrjfWw7piN
	E9wQjXhkp1QIuXs4jub9V6rdRoIIeM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702061169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fi4paHaQDX+BjiWjAE0zDV7z8la+3YmZrhghgPdwHIM=;
	b=/7FHL6RrigYm7Sjui1ddxQKXdYzw1SmXU8eqw2xdjBBSFPXCfNuTXDdjiYxzdpchlO1j6c
	r/ligFClAotDyRAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702061168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fi4paHaQDX+BjiWjAE0zDV7z8la+3YmZrhghgPdwHIM=;
	b=1IZiv7MlztiVOOR3qdtSFKVoIzTJnj77YpZrNNY5J4Ax3d0NRgUVdd1oYxcMX2JJtXRj2t
	UI+YnmC1s1CjE5Gk8fHlACyho9hOYnrqrFnKyrNOqig3JCxwUaBIlzbR1Romtrb25BzhfV
	nkFpZp2rt7HXK/SKRfkWGaoekh3M5gQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702061168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fi4paHaQDX+BjiWjAE0zDV7z8la+3YmZrhghgPdwHIM=;
	b=ixK9Y3ZIBlu9sUX9/vQ8wmJiKs3/fR8jS9Sy+VPMJtIuKIs4re5XB2WVJb8BlnQcuybMFe
	fMxgR7280vqtn1DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BE982138FF;
	Fri,  8 Dec 2023 18:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 7JJBLnBkc2UQYgAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 08 Dec 2023 18:46:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 587B7A07DC; Fri,  8 Dec 2023 19:46:08 +0100 (CET)
Date: Fri, 8 Dec 2023 19:46:08 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] fsnotify: assert that file_start_write() is not held
 in permission hooks
Message-ID: <20231208184608.n5fcrkj3peancy3u@quack3>
References: <20231207123825.4011620-1-amir73il@gmail.com>
 <20231207123825.4011620-4-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207123825.4011620-4-amir73il@gmail.com>
X-Spam-Score: 8.58
X-Spamd-Result: default: False [2.79 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spamd-Bar: ++
X-Rspamd-Server: rspamd1
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CE7C61F74D
X-Spam-Score: 2.79
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1IZiv7Ml;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ixK9Y3ZI;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz;
	dmarc=none

On Thu 07-12-23 14:38:24, Amir Goldstein wrote:
> filesystem may be modified in the context of fanotify permission events
> (e.g. by HSM service), so assert that sb freeze protection is not held.
> 
> If the assertion fails, then the following deadlock would be possible:
> 
> CPU0				CPU1			CPU2
> -------------------------------------------------------------------------
> file_start_write()#0
> ...
>   fsnotify_perm()
>     fanotify_get_response() =>	(read event and fill file)
> 				...
> 				...			freeze_super()
> 				...			  sb_wait_write()
> 				...
> 				vfs_write()
> 				  file_start_write()#1
> 
> This example demonstrates a use case of an hierarchical storage management
> (HSM) service that uses fanotify permission events to fill the content of
> a file before access, while a 3rd process starts fsfreeze.
> 
> This creates a circular dependeny:
>   file_start_write()#0 => fanotify_get_response =>
>     file_start_write()#1 =>
>       sb_wait_write() =>
>         file_end_write()#0
> 
> Where file_end_write()#0 can never be called and none of the threads can
> make progress.
> 
> The assertion is checked for both MAY_READ and MAY_WRITE permission
> hooks in preparation for a pre-modify permission event.
> 
> The assertion is not checked for an open permission event, because
> do_open() takes mnt_want_write() in O_TRUNC case, meaning that it is not
> safe to write to filesystem in the content of an open permission event.
				     ^^^^^ context

BTW, isn't this a bit inconvenient? I mean filling file contents on open
looks quite natural... Do you plan to fill files only on individual read /
write events? I was under the impression simple HSM handlers would be doing
it on open.
 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Anyway this particular change looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fsnotify.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 926bb4461b9e..0a9d6a8a747a 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -107,6 +107,13 @@ static inline int fsnotify_file_perm(struct file *file, int perm_mask)
>  {
>  	__u32 fsnotify_mask = FS_ACCESS_PERM;
>  
> +	/*
> +	 * filesystem may be modified in the context of permission events
> +	 * (e.g. by HSM filling a file on access), so sb freeze protection
> +	 * must not be held.
> +	 */
> +	lockdep_assert_once(file_write_not_started(file));
> +
>  	if (!(perm_mask & MAY_READ))
>  		return 0;
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

