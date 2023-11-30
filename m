Return-Path: <linux-fsdevel+bounces-4451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2327FF9B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9071C20BE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE7F5A0F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02111A4
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 08:43:39 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BCAB21B4D;
	Thu, 30 Nov 2023 16:43:38 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DF7F13A5C;
	Thu, 30 Nov 2023 16:43:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id LT3uFrq7aGX+FgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 16:43:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0B48CA06F9; Thu, 30 Nov 2023 17:43:38 +0100 (CET)
Date: Thu, 30 Nov 2023 17:43:38 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Carlos Llamas <cmllamas@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC 4/5] file: stop exposing receive_fd_user()
Message-ID: <20231130164338.wot25gtq2yvfglh3@quack3>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
 <20231130-vfs-files-fixes-v1-4-e73ca6f4ea83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130-vfs-files-fixes-v1-4-e73ca6f4ea83@kernel.org>
X-Spamd-Bar: ++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [4.39 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 4.39
X-Rspamd-Queue-Id: 6BCAB21B4D

On Thu 30-11-23 13:49:10, Christian Brauner wrote:
> Not every subsystem needs to have their own specialized helper.
> Just us the __receive_fd() helper.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Modulo the typo Jens pointed out, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/file.h | 7 -------
>  include/net/scm.h    | 9 +++++++++
>  net/compat.c         | 2 +-
>  net/core/scm.c       | 2 +-
>  4 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 6e9099d29343..c0d5219c2852 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -101,13 +101,6 @@ extern int __receive_fd(struct file *file, int __user *ufd,
>  
>  extern int receive_fd(struct file *file, unsigned int o_flags);
>  
> -static inline int receive_fd_user(struct file *file, int __user *ufd,
> -				  unsigned int o_flags)
> -{
> -	if (ufd == NULL)
> -		return -EFAULT;
> -	return __receive_fd(file, ufd, o_flags);
> -}
>  int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
>  
>  extern void flush_delayed_fput(void);
> diff --git a/include/net/scm.h b/include/net/scm.h
> index e8c76b4be2fe..8aae2468bae0 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -5,6 +5,7 @@
>  #include <linux/limits.h>
>  #include <linux/net.h>
>  #include <linux/cred.h>
> +#include <linux/file.h>
>  #include <linux/security.h>
>  #include <linux/pid.h>
>  #include <linux/nsproxy.h>
> @@ -208,5 +209,13 @@ static inline void scm_recv_unix(struct socket *sock, struct msghdr *msg,
>  	scm_destroy_cred(scm);
>  }
>  
> +static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
> +				  unsigned int flags)
> +{
> +	if (!ufd)
> +		return -EFAULT;
> +	return __receive_fd(f, ufd, flags);
> +}
> +
>  #endif /* __LINUX_NET_SCM_H */
>  
> diff --git a/net/compat.c b/net/compat.c
> index 6564720f32b7..485db8ee9b28 100644
> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -297,7 +297,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
>  	int err = 0, i;
>  
>  	for (i = 0; i < fdmax; i++) {
> -		err = receive_fd_user(scm->fp->fp[i], cmsg_data + i, o_flags);
> +		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
>  		if (err < 0)
>  			break;
>  	}
> diff --git a/net/core/scm.c b/net/core/scm.c
> index 880027ecf516..eec78e312550 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -319,7 +319,7 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
>  	}
>  
>  	for (i = 0; i < fdmax; i++) {
> -		err = receive_fd_user(scm->fp->fp[i], cmsg_data + i, o_flags);
> +		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
>  		if (err < 0)
>  			break;
>  	}
> 
> -- 
> 2.42.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

