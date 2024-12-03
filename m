Return-Path: <linux-fsdevel+bounces-36372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5D29E2916
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 18:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22FF4169532
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 17:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85D71FAC46;
	Tue,  3 Dec 2024 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E/JfWzdl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="twlHtRZg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E/JfWzdl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="twlHtRZg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250E61E570E
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246685; cv=none; b=t5TSAkIHut/EVJBu1lW608xIhJZ94HgAaaTgu1QMFu5Yd8UtsQqK5IAsvVMYAYO/1+pV53BGUREsi35On+o4R+Rbb56tPq42QBvY6Rs3Vo4fpiWrOFNttewuHE2E48X5iKxz/KvQ8C9w6Zxg84Dl7Sb1hKmlm+KMs6biwwB3itY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246685; c=relaxed/simple;
	bh=m8MmJT8TVvufeINnrvsNa1iBld1F/LMWhjAEpDk0Kjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4gpfG7CqNz1ry/sxuDhtLzrCQU9CF4Xnc4DKm9SysgKSmWa4bD5L9XjBF6RuQxH4jfQweguma+WK9gK5TSB8eRmwluN3woElq1Xqem6FblVnMWDHcQYCMJ+gULPNHk/6HntGOF8aWpSIDTT2VHTZ7usEP1bdxfmT//FI2M/Fy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E/JfWzdl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=twlHtRZg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E/JfWzdl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=twlHtRZg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24D971F453;
	Tue,  3 Dec 2024 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733246681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jha0lM+RLKUMrJrlrTmH87VvDQ4RXhMNpG3HPh8iK74=;
	b=E/JfWzdl52fY1qfJmB8rDMDe8jUHMW9YvmXPdzJZIZuMqsR3VtKD2wWiByPGLGyFYSoiZg
	et1n5RjhxmbMjp8pYw+qIJwFz0QicX23oOS1/iuEXYdMQ75oqRr1hvV80W3pxcG6qVQGY9
	S2584ZlJ+z3O054VZgwojBUEKuO/8Vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733246681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jha0lM+RLKUMrJrlrTmH87VvDQ4RXhMNpG3HPh8iK74=;
	b=twlHtRZg+Q9YkinF3Gy+kRJ364qxbYL+KtWpAaYlb0X1Y/l4MknTPgksK9SJBx4F9QhVcK
	lKF2inVXessR+4Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="E/JfWzdl";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=twlHtRZg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733246681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jha0lM+RLKUMrJrlrTmH87VvDQ4RXhMNpG3HPh8iK74=;
	b=E/JfWzdl52fY1qfJmB8rDMDe8jUHMW9YvmXPdzJZIZuMqsR3VtKD2wWiByPGLGyFYSoiZg
	et1n5RjhxmbMjp8pYw+qIJwFz0QicX23oOS1/iuEXYdMQ75oqRr1hvV80W3pxcG6qVQGY9
	S2584ZlJ+z3O054VZgwojBUEKuO/8Vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733246681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jha0lM+RLKUMrJrlrTmH87VvDQ4RXhMNpG3HPh8iK74=;
	b=twlHtRZg+Q9YkinF3Gy+kRJ364qxbYL+KtWpAaYlb0X1Y/l4MknTPgksK9SJBx4F9QhVcK
	lKF2inVXessR+4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18D3E139C2;
	Tue,  3 Dec 2024 17:24:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mp8LBtk+T2dcbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Dec 2024 17:24:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BF14AA08FB; Tue,  3 Dec 2024 18:24:40 +0100 (CET)
Date: Tue, 3 Dec 2024 18:24:40 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: don't block write during exec on pre-content watched
 files
Message-ID: <20241203172440.hjmwhfg6b3uiuxaz@quack3>
References: <20241128142532.465176-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128142532.465176-1-amir73il@gmail.com>
X-Rspamd-Queue-Id: 24D971F453
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 28-11-24 15:25:32, Amir Goldstein wrote:
> Commit 2a010c412853 ("fs: don't block i_writecount during exec") removed
> the legacy behavior of getting ETXTBSY on attempt to open and executable
> file for write while it is being executed.
> 
> This commit was reverted because an application that depends on this
> legacy behavior was broken by the change.
> 
> We need to allow HSM writing into executable files while executed to
> fill their content on-the-fly.
> 
> To that end, disable the ETXTBSY legacy behavior for files that are
> watched by pre-content events.
> 
> This change is not expected to cause regressions with existing systems
> which do not have any pre-content event listeners.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Jan,
> 
> This patch is on top of your fsnotify_hsm rebased branch.
> It passed LTP sanity tests, but did not test filling an executable
> on-the-fly.

Just to be clear: I'm fine with this approach but I'd like to see this
tested and get Christian's ack before pushing the patch into my tree
(and then into linux-next because at this point this is the only
outstanding problem I'm aware of).

								Honza

>  fs/binfmt_elf.c       |  4 ++--
>  fs/binfmt_elf_fdpic.c |  4 ++--
>  fs/exec.c             |  8 ++++----
>  include/linux/fs.h    | 17 +++++++++++++++++
>  kernel/fork.c         | 12 ++++++------
>  5 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 106f0e8af177..8054f44d39cf 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1257,7 +1257,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		}
>  		reloc_func_desc = interp_load_addr;
>  
> -		allow_write_access(interpreter);
> +		exe_file_allow_write_access(interpreter);
>  		fput(interpreter);
>  
>  		kfree(interp_elf_ex);
> @@ -1354,7 +1354,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	kfree(interp_elf_ex);
>  	kfree(interp_elf_phdata);
>  out_free_file:
> -	allow_write_access(interpreter);
> +	exe_file_allow_write_access(interpreter);
>  	if (interpreter)
>  		fput(interpreter);
>  out_free_ph:
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index f1a7c4875c4a..c13ee8180b17 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -394,7 +394,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>  			goto error;
>  		}
>  
> -		allow_write_access(interpreter);
> +		exe_file_allow_write_access(interpreter);
>  		fput(interpreter);
>  		interpreter = NULL;
>  	}
> @@ -467,7 +467,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>  
>  error:
>  	if (interpreter) {
> -		allow_write_access(interpreter);
> +		exe_file_allow_write_access(interpreter);
>  		fput(interpreter);
>  	}
>  	kfree(interpreter_name);
> diff --git a/fs/exec.c b/fs/exec.c
> index 98cb7ba9983c..c41cfd35c74c 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -912,7 +912,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
>  	    path_noexec(&file->f_path))
>  		return ERR_PTR(-EACCES);
>  
> -	err = deny_write_access(file);
> +	err = exe_file_deny_write_access(file);
>  	if (err)
>  		return ERR_PTR(err);
>  
> @@ -927,7 +927,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
>   * Returns ERR_PTR on failure or allocated struct file on success.
>   *
>   * As this is a wrapper for the internal do_open_execat(), callers
> - * must call allow_write_access() before fput() on release. Also see
> + * must call exe_file_allow_write_access() before fput() on release. Also see
>   * do_close_execat().
>   */
>  struct file *open_exec(const char *name)
> @@ -1471,7 +1471,7 @@ static void do_close_execat(struct file *file)
>  {
>  	if (!file)
>  		return;
> -	allow_write_access(file);
> +	exe_file_allow_write_access(file);
>  	fput(file);
>  }
>  
> @@ -1797,7 +1797,7 @@ static int exec_binprm(struct linux_binprm *bprm)
>  		bprm->file = bprm->interpreter;
>  		bprm->interpreter = NULL;
>  
> -		allow_write_access(exec);
> +		exe_file_allow_write_access(exec);
>  		if (unlikely(bprm->have_execfd)) {
>  			if (bprm->executable) {
>  				fput(exec);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index dd6d0eddea9b..2aeab643f1ab 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3089,6 +3089,23 @@ static inline void allow_write_access(struct file *file)
>  	if (file)
>  		atomic_inc(&file_inode(file)->i_writecount);
>  }
> +
> +/*
> + * Do not prevent write to executable file when watched by pre-content events.
> + */
> +static inline int exe_file_deny_write_access(struct file *exe_file)
> +{
> +	if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
> +		return 0;
> +	return deny_write_access(exe_file);
> +}
> +static inline void exe_file_allow_write_access(struct file *exe_file)
> +{
> +	if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
> +		return;
> +	allow_write_access(exe_file);
> +}
> +
>  static inline bool inode_is_open_for_write(const struct inode *inode)
>  {
>  	return atomic_read(&inode->i_writecount) > 0;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1450b461d196..015c397f47ca 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -625,8 +625,8 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
>  	 * We depend on the oldmm having properly denied write access to the
>  	 * exe_file already.
>  	 */
> -	if (exe_file && deny_write_access(exe_file))
> -		pr_warn_once("deny_write_access() failed in %s\n", __func__);
> +	if (exe_file && exe_file_deny_write_access(exe_file))
> +		pr_warn_once("exe_file_deny_write_access() failed in %s\n", __func__);
>  }
>  
>  #ifdef CONFIG_MMU
> @@ -1424,13 +1424,13 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>  		 * We expect the caller (i.e., sys_execve) to already denied
>  		 * write access, so this is unlikely to fail.
>  		 */
> -		if (unlikely(deny_write_access(new_exe_file)))
> +		if (unlikely(exe_file_deny_write_access(new_exe_file)))
>  			return -EACCES;
>  		get_file(new_exe_file);
>  	}
>  	rcu_assign_pointer(mm->exe_file, new_exe_file);
>  	if (old_exe_file) {
> -		allow_write_access(old_exe_file);
> +		exe_file_allow_write_access(old_exe_file);
>  		fput(old_exe_file);
>  	}
>  	return 0;
> @@ -1471,7 +1471,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>  			return ret;
>  	}
>  
> -	ret = deny_write_access(new_exe_file);
> +	ret = exe_file_deny_write_access(new_exe_file);
>  	if (ret)
>  		return -EACCES;
>  	get_file(new_exe_file);
> @@ -1483,7 +1483,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>  	mmap_write_unlock(mm);
>  
>  	if (old_exe_file) {
> -		allow_write_access(old_exe_file);
> +		exe_file_allow_write_access(old_exe_file);
>  		fput(old_exe_file);
>  	}
>  	return 0;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

