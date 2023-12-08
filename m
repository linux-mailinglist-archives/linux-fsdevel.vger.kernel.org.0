Return-Path: <linux-fsdevel+bounces-5365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C442A80AC4B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A4B1F2106F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5E74CB20
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hlo6/DOh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VlTccrew";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hlo6/DOh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VlTccrew"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F201BA3
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 10:33:06 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 525B11F458;
	Fri,  8 Dec 2023 18:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702060385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8SMp6ng7C7obNXAZJQWSv0vZm7soBvz13r81rAiNtc=;
	b=hlo6/DOhqiTaHIhowIY/g6r1Q4QmDfJvNL6sYWZk9kkOvUD386Z9SFGlHBUcQZtodMSO52
	g2krh30SKNGd6fNg3+V4wCIdhz+dHhWW09deNS6RjCBhsBDdmHinUh+AEM328aisz8Cj/4
	Ryh35cHCsopxjf19ZqNNWP4O29w01QQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702060385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8SMp6ng7C7obNXAZJQWSv0vZm7soBvz13r81rAiNtc=;
	b=VlTccrewBsvWqxQvkUpc/esJaznkw3XN/L+ltZOUzuyXQVwt6Xh5j8IqInnwMfCFd52jon
	FR/VYq6u9HA5IZCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702060385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8SMp6ng7C7obNXAZJQWSv0vZm7soBvz13r81rAiNtc=;
	b=hlo6/DOhqiTaHIhowIY/g6r1Q4QmDfJvNL6sYWZk9kkOvUD386Z9SFGlHBUcQZtodMSO52
	g2krh30SKNGd6fNg3+V4wCIdhz+dHhWW09deNS6RjCBhsBDdmHinUh+AEM328aisz8Cj/4
	Ryh35cHCsopxjf19ZqNNWP4O29w01QQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702060385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8SMp6ng7C7obNXAZJQWSv0vZm7soBvz13r81rAiNtc=;
	b=VlTccrewBsvWqxQvkUpc/esJaznkw3XN/L+ltZOUzuyXQVwt6Xh5j8IqInnwMfCFd52jon
	FR/VYq6u9HA5IZCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 32699138FF;
	Fri,  8 Dec 2023 18:33:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0dsLDGFhc2XYXgAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 08 Dec 2023 18:33:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BA379A07DC; Fri,  8 Dec 2023 19:33:04 +0100 (CET)
Date: Fri, 8 Dec 2023 19:33:04 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] fsnotify: split fsnotify_perm() into two hooks
Message-ID: <20231208183304.iwz4fqksmutvphtd@quack3>
References: <20231207123825.4011620-1-amir73il@gmail.com>
 <20231207123825.4011620-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207123825.4011620-3-amir73il@gmail.com>
X-Spam-Score: 8.19
X-Spamd-Result: default: False [5.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spamd-Bar: +++++
X-Rspamd-Server: rspamd1
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 525B11F458
X-Spam-Score: 5.79
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="hlo6/DOh";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VlTccrew;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz;
	dmarc=none

On Thu 07-12-23 14:38:23, Amir Goldstein wrote:
> We would like to make changes to the fsnotify access permission hook -
> add file range arguments and add the pre modify event.
> 
> In preparation for these changes, split the fsnotify_perm() hook into
> fsnotify_open_perm() and fsnotify_file_perm().
> 
> This is needed for fanotify "pre content" events.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fsnotify.h | 34 +++++++++++++++++++---------------
>  security/security.c      |  4 ++--
>  2 files changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index bcb6609b54b3..926bb4461b9e 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -100,29 +100,33 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
>  	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
>  }
>  
> -/* Simple call site for access decisions */
> -static inline int fsnotify_perm(struct file *file, int mask)
> +/*
> + * fsnotify_file_perm - permission hook before file access
> + */
> +static inline int fsnotify_file_perm(struct file *file, int perm_mask)
>  {
> -	int ret;
> -	__u32 fsnotify_mask = 0;
> +	__u32 fsnotify_mask = FS_ACCESS_PERM;
>  
> -	if (!(mask & (MAY_READ | MAY_OPEN)))
> +	if (!(perm_mask & MAY_READ))
>  		return 0;
>  
> -	if (mask & MAY_OPEN) {
> -		fsnotify_mask = FS_OPEN_PERM;
> +	return fsnotify_file(file, fsnotify_mask);
> +}
>  
> -		if (file->f_flags & __FMODE_EXEC) {
> -			ret = fsnotify_file(file, FS_OPEN_EXEC_PERM);
> +/*
> + * fsnotify_open_perm - permission hook before file open
> + */
> +static inline int fsnotify_open_perm(struct file *file)
> +{
> +	int ret;
>  
> -			if (ret)
> -				return ret;
> -		}
> -	} else if (mask & MAY_READ) {
> -		fsnotify_mask = FS_ACCESS_PERM;
> +	if (file->f_flags & __FMODE_EXEC) {
> +		ret = fsnotify_file(file, FS_OPEN_EXEC_PERM);
> +		if (ret)
> +			return ret;
>  	}
>  
> -	return fsnotify_file(file, fsnotify_mask);
> +	return fsnotify_file(file, FS_OPEN_PERM);
>  }
>  
>  /*
> diff --git a/security/security.c b/security/security.c
> index dcb3e7014f9b..d7f3703c5905 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2586,7 +2586,7 @@ int security_file_permission(struct file *file, int mask)
>  	if (ret)
>  		return ret;
>  
> -	return fsnotify_perm(file, mask);
> +	return fsnotify_file_perm(file, mask);
>  }
>  
>  /**
> @@ -2837,7 +2837,7 @@ int security_file_open(struct file *file)
>  	if (ret)
>  		return ret;
>  
> -	return fsnotify_perm(file, MAY_OPEN);
> +	return fsnotify_open_perm(file);
>  }
>  
>  /**
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

