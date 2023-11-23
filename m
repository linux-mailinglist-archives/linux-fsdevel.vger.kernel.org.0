Return-Path: <linux-fsdevel+bounces-3592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBA47F6B62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 05:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB2C1F20D6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 04:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28DEBE4B;
	Fri, 24 Nov 2023 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10418D5A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 20:33:09 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD56C1FE59;
	Thu, 23 Nov 2023 17:35:36 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BDF3132F8;
	Thu, 23 Nov 2023 17:35:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tLvDJWiNX2XkLAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 17:35:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1921FA07D9; Thu, 23 Nov 2023 18:35:32 +0100 (CET)
Date: Thu, 23 Nov 2023 18:35:32 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 16/16] fs: create {sb,file}_write_not_started() helpers
Message-ID: <20231123173532.6h7gxacrlg4pyooh@quack3>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-17-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-17-amir73il@gmail.com>
X-Spamd-Bar: ++++++++
X-Spam-Score: 8.21
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: AD56C1FE59
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Spamd-Result: default: False [8.21 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
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
	 NEURAL_HAM_SHORT(-0.10)[-0.507];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.08)[63.78%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]

On Wed 22-11-23 14:27:15, Amir Goldstein wrote:
> Create new helpers {sb,file}_write_not_started() that can be used
> to assert that sb_start_write() is not held.
> 
> This is needed for fanotify "pre content" events.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I'm not against this but I'm somewhat wondering, where exactly do you plan
to use this :) (does not seem to be in this patch set). Because one easily
forgets about the subtle implementation details and uses
!sb_write_started() instead of sb_write_not_started()...

								Honza

> ---
>  include/linux/fs.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 05780d993c7d..c085172f832f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1669,6 +1669,17 @@ static inline bool sb_write_started(const struct super_block *sb)
>  	return __sb_write_started(sb, SB_FREEZE_WRITE);
>  }
>  
> +/**
> + * sb_write_not_started - check if SB_FREEZE_WRITE is not held
> + * @sb: the super we write to
> + *
> + * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
> + */
> +static inline bool sb_write_not_started(const struct super_block *sb)
> +{
> +	return __sb_write_started(sb, SB_FREEZE_WRITE) <= 0;
> +}
> +
>  /**
>   * file_write_started - check if SB_FREEZE_WRITE is held
>   * @file: the file we write to
> @@ -1684,6 +1695,21 @@ static inline bool file_write_started(const struct file *file)
>  	return sb_write_started(file_inode(file)->i_sb);
>  }
>  
> +/**
> + * file_write_not_started - check if SB_FREEZE_WRITE is not held
> + * @file: the file we write to
> + *
> + * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
> + * May be false positive with !S_ISREG, because file_start_write() has
> + * no effect on !S_ISREG.
> + */
> +static inline bool file_write_not_started(const struct file *file)
> +{
> +	if (!S_ISREG(file_inode(file)->i_mode))
> +		return true;
> +	return sb_write_not_started(file_inode(file)->i_sb);
> +}
> +
>  /**
>   * sb_end_write - drop write access to a superblock
>   * @sb: the super we wrote to
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

