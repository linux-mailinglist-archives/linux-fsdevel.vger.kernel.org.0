Return-Path: <linux-fsdevel+bounces-36407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0ED9E37FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD3D1628B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 10:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9891B0F1A;
	Wed,  4 Dec 2024 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Peqza4oJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708919049A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309804; cv=none; b=Rp9Yrxt0sedRfCXavCsIwtYhaLk3zM6iTjsCxJjFpfSLEfBo9YditVM+4s06YRYlZrxe34kr97LXjiXhahXi6J6Za4Z5A8kmUSt9+1dHA4kjKkWlBKyCzItp5bGGB5Y1smNVkn34n6w39DTopIXYnCvN6IhL+DDbbORtewDD+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309804; c=relaxed/simple;
	bh=5cMovJX3BJhLKrNhDOmG7jbCTliMz8YObfv6sfm5GP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KA5mc4TnLZ6+cSWknmCa01x+/fuANrQrdUzeOtF+Y8e9NJzo4uir4v9LwSYU3mpskvzdY1227tRxGS5gSBnkKiFZp5seH7mwBydnuzQXD2kfqGkoDA0nvjd5KBuN/yF6S90r2cpehVAqNsYyH4b9HkDfCMzue6/M1hoDh3fvQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Peqza4oJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D543C4CED1;
	Wed,  4 Dec 2024 10:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733309803;
	bh=5cMovJX3BJhLKrNhDOmG7jbCTliMz8YObfv6sfm5GP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Peqza4oJ04qH+F1UO8pAFY0R1oEsauDvTW+AGQSku584bBQ6fNWqx9nJs35BTePog
	 17d4XbZlyj/Dd/fPNcJraakZLjPLU8srOblYS3jR7KwE9jKLbQIm/5CSoVFYg1zXq4
	 NJ9FRt3/fT3vA0IECK/bVkWyff9rpotDC+HaFFkXOO0MGUkxd5yFqB2jxJUu555E7Q
	 6o8EhPG3GQMOr8vsI7se485x3EAjBal7twIaUPnUDRcx2vp7gfHakMU2umjD/Oqf4w
	 YGy4n9Hx/5D31HfKs6pz5OEpGtuUBsrS1Wdv35suHBdTKwClmusi7XNJikoCXcSXW8
	 Ji4CC/sVktMQQ==
Date: Wed, 4 Dec 2024 11:56:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: don't block write during exec on pre-content watched
 files
Message-ID: <20241204-felswand-filmverleih-b5a694ca46a4@brauner>
References: <20241128142532.465176-1-amir73il@gmail.com>
 <20241203172440.hjmwhfg6b3uiuxaz@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203172440.hjmwhfg6b3uiuxaz@quack3>

On Tue, Dec 03, 2024 at 06:24:40PM +0100, Jan Kara wrote:
> On Thu 28-11-24 15:25:32, Amir Goldstein wrote:
> > Commit 2a010c412853 ("fs: don't block i_writecount during exec") removed
> > the legacy behavior of getting ETXTBSY on attempt to open and executable
> > file for write while it is being executed.
> > 
> > This commit was reverted because an application that depends on this
> > legacy behavior was broken by the change.
> > 
> > We need to allow HSM writing into executable files while executed to
> > fill their content on-the-fly.
> > 
> > To that end, disable the ETXTBSY legacy behavior for files that are
> > watched by pre-content events.
> > 
> > This change is not expected to cause regressions with existing systems
> > which do not have any pre-content event listeners.
> > 
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> > 
> > Jan,
> > 
> > This patch is on top of your fsnotify_hsm rebased branch.
> > It passed LTP sanity tests, but did not test filling an executable
> > on-the-fly.
> 
> Just to be clear: I'm fine with this approach but I'd like to see this
> tested and get Christian's ack before pushing the patch into my tree

Thanks! This is fine by me. I already mentioned to Linus that we might
have to accept some unpleasantness in this area but this looks pretty
acceptable to me.

Only one question: The FMODE_FSNOTIFY_HSM(exe_file->f_mode) cannot
change once it's set, right?

The reason I'm asking is that we don't want to end up in a scenario
where we didn't block writecount in exe_file_deny_write_access() but
then unblock someone else's writecount in exe_file_allow_write_access().

Acked-by: Christian Brauner <brauner@kernel.org>

> (and then into linux-next because at this point this is the only
> outstanding problem I'm aware of).
> 
> 								Honza
> 
> >  fs/binfmt_elf.c       |  4 ++--
> >  fs/binfmt_elf_fdpic.c |  4 ++--
> >  fs/exec.c             |  8 ++++----
> >  include/linux/fs.h    | 17 +++++++++++++++++
> >  kernel/fork.c         | 12 ++++++------
> >  5 files changed, 31 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 106f0e8af177..8054f44d39cf 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1257,7 +1257,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  		}
> >  		reloc_func_desc = interp_load_addr;
> >  
> > -		allow_write_access(interpreter);
> > +		exe_file_allow_write_access(interpreter);
> >  		fput(interpreter);
> >  
> >  		kfree(interp_elf_ex);
> > @@ -1354,7 +1354,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  	kfree(interp_elf_ex);
> >  	kfree(interp_elf_phdata);
> >  out_free_file:
> > -	allow_write_access(interpreter);
> > +	exe_file_allow_write_access(interpreter);
> >  	if (interpreter)
> >  		fput(interpreter);
> >  out_free_ph:
> > diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> > index f1a7c4875c4a..c13ee8180b17 100644
> > --- a/fs/binfmt_elf_fdpic.c
> > +++ b/fs/binfmt_elf_fdpic.c
> > @@ -394,7 +394,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
> >  			goto error;
> >  		}
> >  
> > -		allow_write_access(interpreter);
> > +		exe_file_allow_write_access(interpreter);
> >  		fput(interpreter);
> >  		interpreter = NULL;
> >  	}
> > @@ -467,7 +467,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
> >  
> >  error:
> >  	if (interpreter) {
> > -		allow_write_access(interpreter);
> > +		exe_file_allow_write_access(interpreter);
> >  		fput(interpreter);
> >  	}
> >  	kfree(interpreter_name);
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 98cb7ba9983c..c41cfd35c74c 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -912,7 +912,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
> >  	    path_noexec(&file->f_path))
> >  		return ERR_PTR(-EACCES);
> >  
> > -	err = deny_write_access(file);
> > +	err = exe_file_deny_write_access(file);
> >  	if (err)
> >  		return ERR_PTR(err);
> >  
> > @@ -927,7 +927,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
> >   * Returns ERR_PTR on failure or allocated struct file on success.
> >   *
> >   * As this is a wrapper for the internal do_open_execat(), callers
> > - * must call allow_write_access() before fput() on release. Also see
> > + * must call exe_file_allow_write_access() before fput() on release. Also see
> >   * do_close_execat().
> >   */
> >  struct file *open_exec(const char *name)
> > @@ -1471,7 +1471,7 @@ static void do_close_execat(struct file *file)
> >  {
> >  	if (!file)
> >  		return;
> > -	allow_write_access(file);
> > +	exe_file_allow_write_access(file);
> >  	fput(file);
> >  }
> >  
> > @@ -1797,7 +1797,7 @@ static int exec_binprm(struct linux_binprm *bprm)
> >  		bprm->file = bprm->interpreter;
> >  		bprm->interpreter = NULL;
> >  
> > -		allow_write_access(exec);
> > +		exe_file_allow_write_access(exec);
> >  		if (unlikely(bprm->have_execfd)) {
> >  			if (bprm->executable) {
> >  				fput(exec);
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index dd6d0eddea9b..2aeab643f1ab 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3089,6 +3089,23 @@ static inline void allow_write_access(struct file *file)
> >  	if (file)
> >  		atomic_inc(&file_inode(file)->i_writecount);
> >  }
> > +
> > +/*
> > + * Do not prevent write to executable file when watched by pre-content events.
> > + */
> > +static inline int exe_file_deny_write_access(struct file *exe_file)
> > +{
> > +	if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
> > +		return 0;
> > +	return deny_write_access(exe_file);
> > +}
> > +static inline void exe_file_allow_write_access(struct file *exe_file)
> > +{
> > +	if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
> > +		return;
> > +	allow_write_access(exe_file);
> > +}
> > +
> >  static inline bool inode_is_open_for_write(const struct inode *inode)
> >  {
> >  	return atomic_read(&inode->i_writecount) > 0;
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 1450b461d196..015c397f47ca 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -625,8 +625,8 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
> >  	 * We depend on the oldmm having properly denied write access to the
> >  	 * exe_file already.
> >  	 */
> > -	if (exe_file && deny_write_access(exe_file))
> > -		pr_warn_once("deny_write_access() failed in %s\n", __func__);
> > +	if (exe_file && exe_file_deny_write_access(exe_file))
> > +		pr_warn_once("exe_file_deny_write_access() failed in %s\n", __func__);
> >  }
> >  
> >  #ifdef CONFIG_MMU
> > @@ -1424,13 +1424,13 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
> >  		 * We expect the caller (i.e., sys_execve) to already denied
> >  		 * write access, so this is unlikely to fail.
> >  		 */
> > -		if (unlikely(deny_write_access(new_exe_file)))
> > +		if (unlikely(exe_file_deny_write_access(new_exe_file)))
> >  			return -EACCES;
> >  		get_file(new_exe_file);
> >  	}
> >  	rcu_assign_pointer(mm->exe_file, new_exe_file);
> >  	if (old_exe_file) {
> > -		allow_write_access(old_exe_file);
> > +		exe_file_allow_write_access(old_exe_file);
> >  		fput(old_exe_file);
> >  	}
> >  	return 0;
> > @@ -1471,7 +1471,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
> >  			return ret;
> >  	}
> >  
> > -	ret = deny_write_access(new_exe_file);
> > +	ret = exe_file_deny_write_access(new_exe_file);
> >  	if (ret)
> >  		return -EACCES;
> >  	get_file(new_exe_file);
> > @@ -1483,7 +1483,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
> >  	mmap_write_unlock(mm);
> >  
> >  	if (old_exe_file) {
> > -		allow_write_access(old_exe_file);
> > +		exe_file_allow_write_access(old_exe_file);
> >  		fput(old_exe_file);
> >  	}
> >  	return 0;
> > -- 
> > 2.34.1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

