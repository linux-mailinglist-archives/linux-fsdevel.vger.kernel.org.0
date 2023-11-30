Return-Path: <linux-fsdevel+bounces-4445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F2A7FF9B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C78E1B20AB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366154672
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAEF1A3
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 08:39:36 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C39871FD13;
	Thu, 30 Nov 2023 16:39:34 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B339B13A5C;
	Thu, 30 Nov 2023 16:39:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id It6/K8a6aGUtFgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 16:39:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE195A06F9; Thu, 30 Nov 2023 17:39:29 +0100 (CET)
Date: Thu, 30 Nov 2023 17:39:29 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Carlos Llamas <cmllamas@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC 1/5] file: s/close_fd_get_file()/file_close_fd()/g
Message-ID: <20231130163929.dacbkntq7ij7ipws@quack3>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
 <20231130-vfs-files-fixes-v1-1-e73ca6f4ea83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130-vfs-files-fixes-v1-1-e73ca6f4ea83@kernel.org>
X-Spamd-Bar: +++++++++++
X-Spam-Score: 11.78
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz;
	dmarc=none
X-Rspamd-Queue-Id: C39871FD13
X-Spamd-Result: default: False [11.78 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(2.89)[0.965];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all];
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

On Thu 30-11-23 13:49:07, Christian Brauner wrote:
> That really shouldn't have "get" in there as that implies we're bumping
> the reference count which we don't do at all. We used to but not anmore.
> Now we're just closing the fd and pick that file from the fdtable
> without bumping the reference count. Update the wrong documentation
> while at it.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/android/binder.c |  2 +-
>  fs/file.c                | 14 +++++++++-----
>  fs/open.c                |  2 +-
>  include/linux/fdtable.h  |  2 +-
>  4 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 92128aae2d06..7658103ba760 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1921,7 +1921,7 @@ static void binder_deferred_fd_close(int fd)
>  	if (!twcb)
>  		return;
>  	init_task_work(&twcb->twork, binder_do_fd_close);
> -	twcb->file = close_fd_get_file(fd);
> +	twcb->file = file_close_fd(fd);
>  	if (twcb->file) {
>  		// pin it until binder_do_fd_close(); see comments there
>  		get_file(twcb->file);
> diff --git a/fs/file.c b/fs/file.c
> index 50df31e104a5..66f04442a384 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -796,7 +796,7 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
>  }
>  
>  /*
> - * See close_fd_get_file() below, this variant assumes current->files->file_lock
> + * See file_close_fd() below, this variant assumes current->files->file_lock
>   * is held.
>   */
>  struct file *__close_fd_get_file(unsigned int fd)
> @@ -804,11 +804,15 @@ struct file *__close_fd_get_file(unsigned int fd)
>  	return pick_file(current->files, fd);
>  }
>  
> -/*
> - * variant of close_fd that gets a ref on the file for later fput.
> - * The caller must ensure that filp_close() called on the file.
> +/**
> + * file_close_fd - return file associated with fd
> + * @fd: file descriptor to retrieve file for
> + *
> + * Doesn't take a separate reference count.
> + *
> + * Returns: The file associated with @fd (NULL if @fd is not open)
>   */
> -struct file *close_fd_get_file(unsigned int fd)
> +struct file *file_close_fd(unsigned int fd)
>  {
>  	struct files_struct *files = current->files;
>  	struct file *file;
> diff --git a/fs/open.c b/fs/open.c
> index 0bd7fce21cbf..328dc6ef1883 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1578,7 +1578,7 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
>  	int retval;
>  	struct file *file;
>  
> -	file = close_fd_get_file(fd);
> +	file = file_close_fd(fd);
>  	if (!file)
>  		return -EBADF;
>  
> diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> index 80bd7789bab1..78c8326d74ae 100644
> --- a/include/linux/fdtable.h
> +++ b/include/linux/fdtable.h
> @@ -119,7 +119,7 @@ int iterate_fd(struct files_struct *, unsigned,
>  
>  extern int close_fd(unsigned int fd);
>  extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
> -extern struct file *close_fd_get_file(unsigned int fd);
> +extern struct file *file_close_fd(unsigned int fd);
>  extern int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
>  		      struct files_struct **new_fdp);
>  
> 
> -- 
> 2.42.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

