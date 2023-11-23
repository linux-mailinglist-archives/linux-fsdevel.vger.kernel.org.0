Return-Path: <linux-fsdevel+bounces-3586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E7E7F6B4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49EA2816BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85849473;
	Fri, 24 Nov 2023 04:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980B8D5A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 20:20:35 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03FE321B09;
	Thu, 23 Nov 2023 16:53:08 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DCFCB13A82;
	Thu, 23 Nov 2023 16:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id XD/yNXODX2WWIAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 16:53:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 429B2A07D9; Thu, 23 Nov 2023 17:53:07 +0100 (CET)
Date: Thu, 23 Nov 2023 17:53:07 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 07/16] remap_range: move file_start_write() to after
 permission hook
Message-ID: <20231123165307.utcpaeggmsfd4fpq@quack3>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-8-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-8-amir73il@gmail.com>
X-Spamd-Bar: ++++++
X-Spam-Score: 6.06
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 03FE321B09
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Spamd-Result: default: False [6.06 / 50.00];
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
	 BAYES_HAM(-2.33)[96.89%]

On Wed 22-11-23 14:27:06, Amir Goldstein wrote:
> In vfs code, file_start_write() is usually called after the permission
> hook in rw_verify_area().  vfs_dedupe_file_range_one() is an exception
> to this rule.
> 
> In vfs_dedupe_file_range_one(), move file_start_write() to after the
> the rw_verify_area() checks to make them "start-write-safe".
> 
> This is needed for fanotify "pre content" events.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/remap_range.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 42f79cb2b1b1..12131f2a6c9e 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -420,7 +420,7 @@ loff_t vfs_clone_file_range(struct file *file_in, loff_t pos_in,
>  EXPORT_SYMBOL(vfs_clone_file_range);
>  
>  /* Check whether we are allowed to dedupe the destination file */
> -static bool allow_file_dedupe(struct file *file)
> +static bool may_dedupe_file(struct file *file)
>  {
>  	struct mnt_idmap *idmap = file_mnt_idmap(file);
>  	struct inode *inode = file_inode(file);
> @@ -445,24 +445,29 @@ loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
>  	WARN_ON_ONCE(remap_flags & ~(REMAP_FILE_DEDUP |
>  				     REMAP_FILE_CAN_SHORTEN));
>  
> -	ret = mnt_want_write_file(dst_file);
> -	if (ret)
> -		return ret;
> -
>  	/*
>  	 * This is redundant if called from vfs_dedupe_file_range(), but other
>  	 * callers need it and it's not performance sesitive...
>  	 */
>  	ret = remap_verify_area(src_file, src_pos, len, false);
>  	if (ret)
> -		goto out_drop_write;
> +		return ret;
>  
>  	ret = remap_verify_area(dst_file, dst_pos, len, true);
>  	if (ret)
> -		goto out_drop_write;
> +		return ret;
> +
> +	/*
> +	 * This needs to be called after remap_verify_area() because of
> +	 * sb_start_write() and before may_dedupe_file() because the mount's
> +	 * MAY_WRITE need to be checked with mnt_get_write_access_file() held.
> +	 */
> +	ret = mnt_want_write_file(dst_file);
> +	if (ret)
> +		return ret;
>  
>  	ret = -EPERM;
> -	if (!allow_file_dedupe(dst_file))
> +	if (!may_dedupe_file(dst_file))
>  		goto out_drop_write;
>  
>  	ret = -EXDEV;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

