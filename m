Return-Path: <linux-fsdevel+bounces-4452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513FF7FF9B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99326B20CB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4F65A0FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162621A4
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 08:44:31 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8BF6C21B67;
	Thu, 30 Nov 2023 16:44:27 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D21913A5C;
	Thu, 30 Nov 2023 16:44:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id FiKLHuu7aGU0FwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 16:44:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 180C3A06F9; Thu, 30 Nov 2023 17:44:23 +0100 (CET)
Date: Thu, 30 Nov 2023 17:44:23 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Carlos Llamas <cmllamas@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC 5/5] file: remove __receive_fd()
Message-ID: <20231130164423.7grqwr4x4o23v3dz@quack3>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
 <20231130-vfs-files-fixes-v1-5-e73ca6f4ea83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130-vfs-files-fixes-v1-5-e73ca6f4ea83@kernel.org>
X-Spamd-Bar: +++++++++++
X-Spam-Score: 11.78
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz;
	dmarc=none
X-Rspamd-Queue-Id: 8BF6C21B67
X-Spamd-Result: default: False [11.78 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(2.89)[0.964];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Thu 30-11-23 13:49:11, Christian Brauner wrote:
> Honestly, there's little value in having a helper with and without that
> int __user *ufd argument. It's just messy and doesn't really give us
> anything. Just expose receive_fd() with that argument and get rid of
> that helper.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c |  2 +-
>  fs/file.c                          | 11 +++--------
>  include/linux/file.h               |  5 +----
>  include/net/scm.h                  |  2 +-
>  kernel/pid.c                       |  2 +-
>  kernel/seccomp.c                   |  2 +-
>  6 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 6cb5ce4a8b9a..1d24da79c399 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1157,7 +1157,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  			fput(f);
>  			break;
>  		}
> -		ret = receive_fd(f, perm_to_file_flags(entry.perm));
> +		ret = receive_fd(f, NULL, perm_to_file_flags(entry.perm));
>  		fput(f);
>  		break;
>  	}
> diff --git a/fs/file.c b/fs/file.c
> index c8eaa0b29a08..3b683b9101d8 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1296,7 +1296,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
>  }
>  
>  /**
> - * __receive_fd() - Install received file into file descriptor table
> + * receive_fd() - Install received file into file descriptor table
>   * @file: struct file that was received from another process
>   * @ufd: __user pointer to write new fd number to
>   * @o_flags: the O_* flags to apply to the new fd entry
> @@ -1310,7 +1310,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
>   *
>   * Returns newly install fd or -ve on error.
>   */
> -int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
> +int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
>  {
>  	int new_fd;
>  	int error;
> @@ -1335,6 +1335,7 @@ int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
>  	__receive_sock(file);
>  	return new_fd;
>  }
> +EXPORT_SYMBOL_GPL(receive_fd);
>  
>  int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
>  {
> @@ -1350,12 +1351,6 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
>  	return new_fd;
>  }
>  
> -int receive_fd(struct file *file, unsigned int o_flags)
> -{
> -	return __receive_fd(file, NULL, o_flags);
> -}
> -EXPORT_SYMBOL_GPL(receive_fd);
> -
>  static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
>  {
>  	int err = -EBADF;
> diff --git a/include/linux/file.h b/include/linux/file.h
> index c0d5219c2852..a50545ef1197 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -96,10 +96,7 @@ DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
>  
>  extern void fd_install(unsigned int fd, struct file *file);
>  
> -extern int __receive_fd(struct file *file, int __user *ufd,
> -			unsigned int o_flags);
> -
> -extern int receive_fd(struct file *file, unsigned int o_flags);
> +extern int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags);
>  
>  int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
>  
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 8aae2468bae0..cf68acec4d70 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -214,7 +214,7 @@ static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
>  {
>  	if (!ufd)
>  		return -EFAULT;
> -	return __receive_fd(f, ufd, flags);
> +	return receive_fd(f, ufd, flags);
>  }
>  
>  #endif /* __LINUX_NET_SCM_H */
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 6500ef956f2f..b52b10865454 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -700,7 +700,7 @@ static int pidfd_getfd(struct pid *pid, int fd)
>  	if (IS_ERR(file))
>  		return PTR_ERR(file);
>  
> -	ret = receive_fd(file, O_CLOEXEC);
> +	ret = receive_fd(file, NULL, O_CLOEXEC);
>  	fput(file);
>  
>  	return ret;
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 255999ba9190..aca7b437882e 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1072,7 +1072,7 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_kn
>  	 */
>  	list_del_init(&addfd->list);
>  	if (!addfd->setfd)
> -		fd = receive_fd(addfd->file, addfd->flags);
> +		fd = receive_fd(addfd->file, NULL, addfd->flags);
>  	else
>  		fd = receive_fd_replace(addfd->fd, addfd->file, addfd->flags);
>  	addfd->ret = fd;
> 
> -- 
> 2.42.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

