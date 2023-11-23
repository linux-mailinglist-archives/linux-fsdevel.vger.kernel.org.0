Return-Path: <linux-fsdevel+bounces-3590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFAF7F6B53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5BF1C20CC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83FA3C1E;
	Fri, 24 Nov 2023 04:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dyq5Ib/b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6sIF1/RV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FCB101
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 20:21:30 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBFFE219BA;
	Thu, 23 Nov 2023 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700756897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rwSvm5vQA21r+qzTnLssiD/xzgui83BIo5DkyWTsbjk=;
	b=dyq5Ib/beKXQWSGCbOezV4OIdYB58PLceBPQvIweUppISgKIyDP2AJLUnJubwN9QItN66p
	SXy3y83xe7nIQu1DN71AGwaP8i+/CI4jrYscaot5VMdoJIjS2ZWdGVuU2qYSDwxZM6FyBL
	rUWpXEgoxTWEoKGu7LWDMCEliVgcM6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700756897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rwSvm5vQA21r+qzTnLssiD/xzgui83BIo5DkyWTsbjk=;
	b=6sIF1/RVS5a/GT8aOhTuKlCoCXj9tTN/9BUhlf4cAKEyKKxA3nRaVkGb/fraVensPhhSXF
	caN4haOfY2enZICg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D4BBE13A82;
	Thu, 23 Nov 2023 16:28:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ue+aM6F9X2XlGgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 16:28:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 39222A07D9; Thu, 23 Nov 2023 17:28:17 +0100 (CET)
Date: Thu, 23 Nov 2023 17:28:17 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 01/16] ovl: add permission hooks outside of
 do_splice_direct()
Message-ID: <20231123162817.dxqcr4ws657v6mvn@quack3>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-2-amir73il@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.60
X-Spam-Level: 
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed 22-11-23 14:27:00, Amir Goldstein wrote:
> The main callers of do_splice_direct() also call rw_verify_area() for
> the entire range that is being copied, e.g. by vfs_copy_file_range()
> or do_sendfile() before calling do_splice_direct().
> 
> The only caller that does not have those checks for entire range is
> ovl_copy_up_file().  In preparation for removing the checks inside
> do_splice_direct(), add rw_verify_area() call in ovl_copy_up_file().
> 
> For extra safety, perform minimal sanity checks from rw_verify_area()
> for non negative offsets also in the copy up do_splice_direct() loop
> without calling the file permission hooks.
> 
> This is needed for fanotify "pre content" events.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/overlayfs/copy_up.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 4382881b0709..106f8643af3b 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -230,6 +230,19 @@ static int ovl_copy_fileattr(struct inode *inode, const struct path *old,
>  	return ovl_real_fileattr_set(new, &newfa);
>  }
>  
> +static int ovl_verify_area(loff_t pos, loff_t pos2, loff_t len, loff_t totlen)
> +{
> +	loff_t tmp;
> +
> +	if (WARN_ON_ONCE(pos != pos2))
> +		return -EIO;
> +	if (WARN_ON_ONCE(pos < 0 || len < 0 || totlen < 0))
> +		return -EIO;
> +	if (WARN_ON_ONCE(check_add_overflow(pos, len, &tmp)))
> +		return -EIO;
> +	return 0;
> +}
> +
>  static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
>  			    struct file *new_file, loff_t len)
>  {
> @@ -244,13 +257,20 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
>  	int error = 0;
>  
>  	ovl_path_lowerdata(dentry, &datapath);
> -	if (WARN_ON(datapath.dentry == NULL))
> +	if (WARN_ON_ONCE(datapath.dentry == NULL) ||
> +	    WARN_ON_ONCE(len < 0))
>  		return -EIO;
>  
>  	old_file = ovl_path_open(&datapath, O_LARGEFILE | O_RDONLY);
>  	if (IS_ERR(old_file))
>  		return PTR_ERR(old_file);
>  
> +	error = rw_verify_area(READ, old_file, &old_pos, len);
> +	if (!error)
> +		error = rw_verify_area(WRITE, new_file, &new_pos, len);
> +	if (error)
> +		goto out_fput;
> +
>  	/* Try to use clone_file_range to clone up within the same fs */
>  	ovl_start_write(dentry);
>  	cloned = do_clone_file_range(old_file, 0, new_file, 0, len, 0);
> @@ -309,6 +329,10 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
>  			}
>  		}
>  
> +		error = ovl_verify_area(old_pos, new_pos, this_len, len);
> +		if (error)
> +			break;
> +
>  		ovl_start_write(dentry);
>  		bytes = do_splice_direct(old_file, &old_pos,
>  					 new_file, &new_pos,
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

