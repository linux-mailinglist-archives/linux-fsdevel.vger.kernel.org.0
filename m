Return-Path: <linux-fsdevel+bounces-3582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB047F6B39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AAB28102E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119394683;
	Fri, 24 Nov 2023 04:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 85 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Nov 2023 20:18:54 PST
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168E61BE
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 20:18:54 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E9651FDCA;
	Thu, 23 Nov 2023 16:54:01 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 67F8313A82;
	Thu, 23 Nov 2023 16:54:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /uFfGamDX2XBIAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 16:54:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A2809A07D9; Thu, 23 Nov 2023 17:54:00 +0100 (CET)
Date: Thu, 23 Nov 2023 17:54:00 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 08/16] btrfs: move file_start_write() to after
 permission hook
Message-ID: <20231123165400.akwegucagsbs32wg@quack3>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-9-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-9-amir73il@gmail.com>
X-Spamd-Bar: ++++++
X-Spam-Score: 6.28
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 7E9651FDCA
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Spamd-Result: default: False [6.28 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.11)[95.71%]

On Wed 22-11-23 14:27:07, Amir Goldstein wrote:
> In vfs code, file_start_write() is usually called after the permission
> hook in rw_verify_area().  btrfs_ioctl_encoded_write() in an exception
> to this rule.
> 
> Move file_start_write() to after the rw_verify_area() check in encoded
> write to make the permission hook "start-write-safe".
> 
> This is needed for fanotify "pre content" events.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/btrfs/ioctl.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index dfe257e1845b..0a7850c4be67 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4523,29 +4523,29 @@ static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool
>  	if (ret < 0)
>  		goto out_acct;
>  
> -	file_start_write(file);
> -
>  	if (iov_iter_count(&iter) == 0) {
>  		ret = 0;
> -		goto out_end_write;
> +		goto out_iov;
>  	}
>  	pos = args.offset;
>  	ret = rw_verify_area(WRITE, file, &pos, args.len);
>  	if (ret < 0)
> -		goto out_end_write;
> +		goto out_iov;
>  
>  	init_sync_kiocb(&kiocb, file);
>  	ret = kiocb_set_rw_flags(&kiocb, 0);
>  	if (ret)
> -		goto out_end_write;
> +		goto out_iov;
>  	kiocb.ki_pos = pos;
>  
> +	file_start_write(file);
> +
>  	ret = btrfs_do_write_iter(&kiocb, &iter, &args);
>  	if (ret > 0)
>  		fsnotify_modify(file);
>  
> -out_end_write:
>  	file_end_write(file);
> +out_iov:
>  	kfree(iov);
>  out_acct:
>  	if (ret > 0)
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

