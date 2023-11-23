Return-Path: <linux-fsdevel+bounces-3583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D03FF7F6B3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8834E1F20F2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFE04C64;
	Fri, 24 Nov 2023 04:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2E6D56
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 20:18:55 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79C851FDBC;
	Thu, 23 Nov 2023 16:37:41 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6333113A82;
	Thu, 23 Nov 2023 16:37:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9h/eF9V/X2UPHQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 16:37:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D7D19A07D9; Thu, 23 Nov 2023 17:37:40 +0100 (CET)
Date: Thu, 23 Nov 2023 17:37:40 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 04/16] splice: move permission hook out of
 splice_file_to_pipe()
Message-ID: <20231123163740.celnfvjpw3wbf5ev@quack3>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-5-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-5-amir73il@gmail.com>
X-Spamd-Bar: +++++++
X-Spam-Score: 7.43
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 79C851FDBC
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Spamd-Result: default: False [7.43 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.96)[86.66%]

On Wed 22-11-23 14:27:03, Amir Goldstein wrote:
> vfs_splice_read() has a permission hook inside rw_verify_area() and
> it is called from splice_file_to_pipe(), which is called from
> do_splice() and do_sendfile().
> 
> do_sendfile() already has a rw_verify_area() check for the entire range.
> do_splice() has a rw_verify_check() for the splice to file case, not for
> the splice from file case.
> 
> Add the rw_verify_area() check for splice from file case in do_splice()
> and use a variant of vfs_splice_read() without rw_verify_area() check
> in splice_file_to_pipe() to avoid the redundant rw_verify_area() checks.
> 
> This is needed for fanotify "pre content" events.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/splice.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index 6fc2c27e9520..d4fdd44c0b32 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1239,7 +1239,7 @@ long splice_file_to_pipe(struct file *in,
>  	pipe_lock(opipe);
>  	ret = wait_for_space(opipe, flags);
>  	if (!ret)
> -		ret = vfs_splice_read(in, offset, opipe, len, flags);
> +		ret = do_splice_read(in, offset, opipe, len, flags);
>  	pipe_unlock(opipe);
>  	if (ret > 0)
>  		wakeup_pipe_readers(opipe);
> @@ -1316,6 +1316,10 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
>  			offset = in->f_pos;
>  		}
>  
> +		ret = rw_verify_area(READ, in, &offset, len);
> +		if (unlikely(ret < 0))
> +			return ret;
> +
>  		if (out->f_flags & O_NONBLOCK)
>  			flags |= SPLICE_F_NONBLOCK;
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

