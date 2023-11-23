Return-Path: <linux-fsdevel+bounces-3587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F097F6B4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA1D1C20B8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466CA94F;
	Fri, 24 Nov 2023 04:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s7nLIKdo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WD9Tkm79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816CDD56
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 20:20:54 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A32621BAA;
	Thu, 23 Nov 2023 17:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700760712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bs1uCWzDYyrEhezL5q43KKeR+Du1sj/mqF3MjJfl8Ac=;
	b=s7nLIKdoEM4AJJLsSkXshK2IzHzqsUsfdhXPiOh18RhL6NeFbcUhdfRGIcfDjROs5FtBk6
	p7Dc9yZCqIcFh1mxKmzFyO7Ui3ZfHR4VoXKrm+CuZJgEGaPdpTXuB4MDn7NK1yTpq9idej
	g8g5E23K8TBXFjjsUp8vygWnc4thhtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700760712;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bs1uCWzDYyrEhezL5q43KKeR+Du1sj/mqF3MjJfl8Ac=;
	b=WD9Tkm79kFRHfqQu3rKDed12MZs000RYdkGJAYKEcXrrC0Yz1F4ywCbHbz8yeD+fnjLJSQ
	tMSdowGRx89ZaRCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C163132F8;
	Thu, 23 Nov 2023 17:31:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9uXBCoiMX2UoLAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 17:31:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A1AA9A07D9; Thu, 23 Nov 2023 18:31:51 +0100 (CET)
Date: Thu, 23 Nov 2023 18:31:51 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 14/16] fs: create __sb_write_started() helper
Message-ID: <20231123173151.zafempdspyqloxca@quack3>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-15-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-15-amir73il@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 5.18
X-Spamd-Result: default: False [5.18 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.62)[0.872];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.34)[90.41%]

On Wed 22-11-23 14:27:13, Amir Goldstein wrote:
> Similar to sb_write_started() for use by other sb freeze levels.
> 
> Unlike the boolean sb_write_started(), this helper returns a tristate
> to distiguish the cases of lockdep disabled or unknown lock state.
> 
> This is needed for fanotify "pre content" events.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 98b7a7a8c42e..e8aa48797bf4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1645,9 +1645,22 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
>  #define __sb_writers_release(sb, lev)	\
>  	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
>  
> +/**
> + * __sb_write_started - check if sb freeze level is held
> + * @sb: the super we write to
> + *
> + * > 0 sb freeze level is held
> + *   0 sb freeze level is not held
> + * < 0 !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN
> + */
> +static inline int __sb_write_started(const struct super_block *sb, int level)
> +{
> +	return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
> +}
> +
>  static inline bool sb_write_started(const struct super_block *sb)
>  {
> -	return lockdep_is_held_type(sb->s_writers.rw_sem + SB_FREEZE_WRITE - 1, 1);
> +	return __sb_write_started(sb, SB_FREEZE_WRITE);
>  }
>  
>  /**
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

