Return-Path: <linux-fsdevel+bounces-3594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC07D7F6B6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296A41C20C69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089F963D5;
	Fri, 24 Nov 2023 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2A11AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 20:33:19 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D63E31FDCC;
	Thu, 23 Nov 2023 16:52:13 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BC6E313A82;
	Thu, 23 Nov 2023 16:52:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id t0FpLT2DX2VkIAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 16:52:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 113BCA07D9; Thu, 23 Nov 2023 17:52:13 +0100 (CET)
Date: Thu, 23 Nov 2023 17:52:13 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] remap_range: move permission hooks out of
 do_clone_file_range()
Message-ID: <20231123165213.qzk6vwy7tljqbzbe@quack3>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-7-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-7-amir73il@gmail.com>
X-Spamd-Bar: ++++++
X-Spam-Score: 6.95
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: D63E31FDCC
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Spamd-Result: default: False [6.95 / 50.00];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.44)[91.23%]

On Wed 22-11-23 14:27:05, Amir Goldstein wrote:
> In many of the vfs helpers, file permission hook is called before
> taking sb_start_write(), making them "start-write-safe".
> do_clone_file_range() is an exception to this rule.
> 
> do_clone_file_range() has two callers - vfs_clone_file_range() and
> overlayfs. Move remap_verify_area() checks from do_clone_file_range()
> out to vfs_clone_file_range() to make them "start-write-safe".
> 
> Overlayfs already has calls to rw_verify_area() with the same security
> permission hooks as remap_verify_area() has.
> The rest of the checks in remap_verify_area() are irrelevant for
> overlayfs that calls do_clone_file_range() offset 0 and positive length.
> 
> This is needed for fanotify "pre content" events.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/remap_range.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 87ae4f0dc3aa..42f79cb2b1b1 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -385,14 +385,6 @@ loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
>  	if (!file_in->f_op->remap_file_range)
>  		return -EOPNOTSUPP;
>  
> -	ret = remap_verify_area(file_in, pos_in, len, false);
> -	if (ret)
> -		return ret;
> -
> -	ret = remap_verify_area(file_out, pos_out, len, true);
> -	if (ret)
> -		return ret;
> -
>  	ret = file_in->f_op->remap_file_range(file_in, pos_in,
>  			file_out, pos_out, len, remap_flags);
>  	if (ret < 0)
> @@ -410,6 +402,14 @@ loff_t vfs_clone_file_range(struct file *file_in, loff_t pos_in,
>  {
>  	loff_t ret;
>  
> +	ret = remap_verify_area(file_in, pos_in, len, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = remap_verify_area(file_out, pos_out, len, true);
> +	if (ret)
> +		return ret;
> +
>  	file_start_write(file_out);
>  	ret = do_clone_file_range(file_in, pos_in, file_out, pos_out, len,
>  				  remap_flags);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

