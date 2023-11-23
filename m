Return-Path: <linux-fsdevel+bounces-3593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F827F6B68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22C3CB210AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002B315AE2;
	Fri, 24 Nov 2023 04:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Abjuun+r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NGOaWwJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A4A10E7
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 20:33:12 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2EF531FDAE;
	Thu, 23 Nov 2023 16:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700756924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7TCev8B2aGTFdgXWsNrMY5/CmPE08YsJDV10LrJFTUY=;
	b=Abjuun+r7yMHyQM+vAdaO6j4dvjy+5VAo3eop7WE9sSrf0AAnJyN6sbiz9DqwtqEhYfSjJ
	/2wT9FKXs1tVN8uH/48Xyg2SJXEy4PANoHaSjvyTR6ao/Uc/Q7lPZrTCB85lgaNjJBuTDj
	smaJeOcJwMrAwxlK9EY1R4s4Xx2pkjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700756924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7TCev8B2aGTFdgXWsNrMY5/CmPE08YsJDV10LrJFTUY=;
	b=NGOaWwJtNDsZQirNPi4BqRD97suPdIAmE4gpzsmenio8J9g3ijc1gapN+go/yQAZJE/HDQ
	LzZoLak9uE6SxmBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1873613A82;
	Thu, 23 Nov 2023 16:28:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id J2b2Bbx9X2UGGwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 16:28:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 51BB0A07D9; Thu, 23 Nov 2023 17:28:43 +0100 (CET)
Date: Thu, 23 Nov 2023 17:28:43 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 02/16] splice: remove permission hook from
 do_splice_direct()
Message-ID: <20231123162843.7enughlrl3si4ltl@quack3>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-3-amir73il@gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -0.78
X-Spam-Level: 
X-Spamd-Result: default: False [-0.78 / 50.00];
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
	 BAYES_HAM(-1.18)[89.03%]

On Wed 22-11-23 14:27:01, Amir Goldstein wrote:
> All callers of do_splice_direct() have a call to rw_verify_area() for
> the entire range that is being copied, e.g. by vfs_copy_file_range() or
> do_sendfile() before calling do_splice_direct().
> 
> The rw_verify_area() check inside do_splice_direct() is redundant and
> is called after sb_start_write(), so it is not "start-write-safe".
> Remove this redundant check.
> 
> This is needed for fanotify "pre content" events.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/splice.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index d983d375ff11..6e917db6f49a 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1166,6 +1166,7 @@ static void direct_file_splice_eof(struct splice_desc *sd)
>   *    (splice in + splice out, as compared to just sendfile()). So this helper
>   *    can splice directly through a process-private pipe.
>   *
> + * Callers already called rw_verify_area() on the entire range.
>   */
>  long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
>  		      loff_t *opos, size_t len, unsigned int flags)
> @@ -1187,10 +1188,6 @@ long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
>  	if (unlikely(out->f_flags & O_APPEND))
>  		return -EINVAL;
>  
> -	ret = rw_verify_area(WRITE, out, opos, len);
> -	if (unlikely(ret < 0))
> -		return ret;
> -
>  	ret = splice_direct_to_actor(in, &sd, direct_splice_actor);
>  	if (ret > 0)
>  		*ppos = sd.pos;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

