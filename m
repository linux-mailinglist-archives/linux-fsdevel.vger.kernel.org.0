Return-Path: <linux-fsdevel+bounces-62863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB39BA3157
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 11:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288DF1BC20FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F6D2848A0;
	Fri, 26 Sep 2025 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TLSkVHa2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2TXhmpwi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DaqQs4rp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IXIvd3pp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CF421D3D2
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878007; cv=none; b=ETrV10elqANFeFWJ5leOpxIHH/4Zg6yTnVXkVLHejRP+eucRFeOCt8NLUls6tJxaAAE00ixywcBVRQBdAMdJTUJzB6zm9g7HUzo9jdRMIf76F2YnqjAs9zW+5UQCMhvRYiI2gKm9vT3wUEyhd/eQWtDTtIsUzDwWAOmN3BLggRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878007; c=relaxed/simple;
	bh=j76R47SpIDp+FtERTu4kREWuem7Dx4sTCA4TG11wY+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy3MMAa9TEVt1oCpPxhp+avbUjyd4yG3N71Og7zh9S7wNHXPy0sBF8gCG7YdlaNHdWsqknPPo7yMBXbrKZHhRYzJDqGSE2/NTn3MZD/mgjSZCmoL6OGGr10MTVrauvQwXZlZW69mSPiAT/5wXGi2hzcGgMMBNJ+wJuYjpIMCUdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TLSkVHa2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2TXhmpwi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DaqQs4rp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IXIvd3pp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF391222FF;
	Fri, 26 Sep 2025 09:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758877998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx0eVsXY5uDnQUwuI1WUNIqGo8HSmocoGI0dKYibn20=;
	b=TLSkVHa2aU8dAFPEdrFnBia4BMDM2dfRmIyCJpFZHREKhzYg/07zRmE8q2rRiD11Z7rE0M
	agdwxOMCZBAJ03IA/uqYVWWnyOBRuqsovgSxn5p8GKYMjNbme4N+RUdRTIlUmzsrwEZliO
	SpQOswxDwDteUpfXshgpA26DFwHE+e8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758877998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx0eVsXY5uDnQUwuI1WUNIqGo8HSmocoGI0dKYibn20=;
	b=2TXhmpwi1niygI7IZHUbsPCBkQA0ZkRXuLCnvQv81QLqNbb708akCs3qJOrGtwucGAyj/T
	gZsfsCZ4rZKPjtBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DaqQs4rp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IXIvd3pp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758877997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx0eVsXY5uDnQUwuI1WUNIqGo8HSmocoGI0dKYibn20=;
	b=DaqQs4rpgNgtF2aEuxySB3eTDceAjEq1GOG9CWbvuSiG0Hc3q0UPPQ6BfzK6poLx0CxFvK
	9LGyTFQIy41EaOlB6Vu0pGQcr5a17sG32aylE8C73623+grdQWC8Jso24yQwUC9sR4GsgH
	NeE5TrJMoCoCvYKuBGV9bIzGtx6ABfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758877997;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx0eVsXY5uDnQUwuI1WUNIqGo8HSmocoGI0dKYibn20=;
	b=IXIvd3pp5VxZ189HEInb8BbaV4+fKvqZQTUp+nTWZ+Ep872u8ni7uWNnNk7QWl5jy4jKrO
	U4Wji5ewTrtgakBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C40BE1386E;
	Fri, 26 Sep 2025 09:13:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l3rVLy1Z1mhnBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 26 Sep 2025 09:13:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 33D37A0AA5; Fri, 26 Sep 2025 11:13:13 +0200 (CEST)
Date: Fri, 26 Sep 2025 11:13:13 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, John Johansen <john@apparmor.net>, 
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] kernel/acct.c: saner struct file treatment
Message-ID: <wfofpsjxr7ehya3gc3byibov6r6iyl4b444syvs7sv2wfdvabd@qyw2rft2bgsx>
References: <20250906090738.GA31600@ZenIV>
 <20250906091339.GB31600@ZenIV>
 <4892af80-8e0b-4ee5-98ac-1cce7e252b6a@sirena.org.uk>
 <klzgui6d2jo2tng5py776uku2xnwzcwi4jt5qf5iulszdtoqxo@q6o2zmvvxcuz>
 <20250925185630.GZ39973@ZenIV>
 <20250925190944.GA39973@ZenIV>
 <20250925205647.GC39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925205647.GC39973@ZenIV>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,linux-foundation.org,kernel.org,gmail.com,oracle.com,apparmor.net];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: DF391222FF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Thu 25-09-25 21:56:47, Al Viro wrote:
> [seems to work properly now]
> 	Instead of switching ->f_path.mnt of an opened file to internal
> clone, get a struct path with ->mnt set to internal clone of that
> ->f_path.mnt, then dentry_open() that to get the file with right ->f_path.mnt
> from the very beginning.
> 
> 	The only subtle part here is that on failure exits we need to
> close the file with __fput_sync() and make sure we do that *before*
> dropping the original mount.
> 
> 	With that done, only fs/{file_table,open,namei}.c ever store
> anything to file->f_path and only prior to file->f_mode & FMODE_OPENED
> becoming true.  Analysis of mount write count handling also becomes
> less brittle and convoluted...
> 
> [AV: folded a fix for a bug spotted by Jan Kara - we do need a full-blown
> open of the original file, not just user_path_at() or we end up skipping
> permission checks]
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> diff --git a/kernel/acct.c b/kernel/acct.c
> index 6520baa13669..61630110e29d 100644
> --- a/kernel/acct.c
> +++ b/kernel/acct.c
> @@ -44,19 +44,14 @@
>   * a struct file opened for write. Fixed. 2/6/2000, AV.
>   */
>  
> -#include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/acct.h>
>  #include <linux/capability.h>
> -#include <linux/file.h>
>  #include <linux/tty.h>
> -#include <linux/security.h>
> -#include <linux/vfs.h>
> +#include <linux/statfs.h>
>  #include <linux/jiffies.h>
> -#include <linux/times.h>
>  #include <linux/syscalls.h>
> -#include <linux/mount.h>
> -#include <linux/uaccess.h>
> +#include <linux/namei.h>
>  #include <linux/sched/cputime.h>
>  
>  #include <asm/div64.h>
> @@ -217,84 +212,70 @@ static void close_work(struct work_struct *work)
>  	complete(&acct->done);
>  }
>  
> -static int acct_on(struct filename *pathname)
> +DEFINE_FREE(fput_sync, struct file *, if (!IS_ERR_OR_NULL(_T)) __fput_sync(_T))
> +static int acct_on(const char __user *name)
>  {
> -	struct file *file;
> -	struct vfsmount *mnt, *internal;
> +	/* Difference from BSD - they don't do O_APPEND */
> +	const int open_flags = O_WRONLY|O_APPEND|O_LARGEFILE;
>  	struct pid_namespace *ns = task_active_pid_ns(current);
> +	struct filename *pathname __free(putname) = getname(name);
> +	struct file *original_file __free(fput) = NULL;	// in that order
> +	struct path internal __free(path_put) = {};	// in that order
> +	struct file *file __free(fput_sync) = NULL;	// in that order
>  	struct bsd_acct_struct *acct;
> +	struct vfsmount *mnt;
>  	struct fs_pin *old;
> -	int err;
>  
> -	acct = kzalloc(sizeof(struct bsd_acct_struct), GFP_KERNEL);
> -	if (!acct)
> -		return -ENOMEM;
> +	if (IS_ERR(pathname))
> +		return PTR_ERR(pathname);
> +	original_file = file_open_name(pathname, open_flags, 0);
> +	if (IS_ERR(original_file))
> +		return PTR_ERR(original_file);
>  
> -	/* Difference from BSD - they don't do O_APPEND */
> -	file = file_open_name(pathname, O_WRONLY|O_APPEND|O_LARGEFILE, 0);
> -	if (IS_ERR(file)) {
> -		kfree(acct);
> +	mnt = mnt_clone_internal(&original_file->f_path);
> +	if (IS_ERR(mnt))
> +		return PTR_ERR(mnt);
> +
> +	internal.mnt = mnt;
> +	internal.dentry = dget(mnt->mnt_root);
> +
> +	file = dentry_open(&internal, open_flags, current_cred());
> +	if (IS_ERR(file))
>  		return PTR_ERR(file);
> -	}
>  
> -	if (!S_ISREG(file_inode(file)->i_mode)) {
> -		kfree(acct);
> -		filp_close(file, NULL);
> +	if (!S_ISREG(file_inode(file)->i_mode))
>  		return -EACCES;
> -	}
>  
>  	/* Exclude kernel kernel internal filesystems. */
> -	if (file_inode(file)->i_sb->s_flags & (SB_NOUSER | SB_KERNMOUNT)) {
> -		kfree(acct);
> -		filp_close(file, NULL);
> +	if (file_inode(file)->i_sb->s_flags & (SB_NOUSER | SB_KERNMOUNT))
>  		return -EINVAL;
> -	}
>  
>  	/* Exclude procfs and sysfs. */
> -	if (file_inode(file)->i_sb->s_iflags & SB_I_USERNS_VISIBLE) {
> -		kfree(acct);
> -		filp_close(file, NULL);
> +	if (file_inode(file)->i_sb->s_iflags & SB_I_USERNS_VISIBLE)
>  		return -EINVAL;
> -	}
>  
> -	if (!(file->f_mode & FMODE_CAN_WRITE)) {
> -		kfree(acct);
> -		filp_close(file, NULL);
> +	if (!(file->f_mode & FMODE_CAN_WRITE))
>  		return -EIO;
> -	}
> -	internal = mnt_clone_internal(&file->f_path);
> -	if (IS_ERR(internal)) {
> -		kfree(acct);
> -		filp_close(file, NULL);
> -		return PTR_ERR(internal);
> -	}
> -	err = mnt_get_write_access(internal);
> -	if (err) {
> -		mntput(internal);
> -		kfree(acct);
> -		filp_close(file, NULL);
> -		return err;
> -	}
> -	mnt = file->f_path.mnt;
> -	file->f_path.mnt = internal;
> +
> +	acct = kzalloc(sizeof(struct bsd_acct_struct), GFP_KERNEL);
> +	if (!acct)
> +		return -ENOMEM;
>  
>  	atomic_long_set(&acct->count, 1);
>  	init_fs_pin(&acct->pin, acct_pin_kill);
> -	acct->file = file;
> +	acct->file = no_free_ptr(file);
>  	acct->needcheck = jiffies;
>  	acct->ns = ns;
>  	mutex_init(&acct->lock);
>  	INIT_WORK(&acct->work, close_work);
>  	init_completion(&acct->done);
>  	mutex_lock_nested(&acct->lock, 1);	/* nobody has seen it yet */
> -	pin_insert(&acct->pin, mnt);
> +	pin_insert(&acct->pin, original_file->f_path.mnt);
>  
>  	rcu_read_lock();
>  	old = xchg(&ns->bacct, &acct->pin);
>  	mutex_unlock(&acct->lock);
>  	pin_kill(old);
> -	mnt_put_write_access(mnt);
> -	mntput(mnt);
>  	return 0;
>  }
>  
> @@ -319,14 +300,9 @@ SYSCALL_DEFINE1(acct, const char __user *, name)
>  		return -EPERM;
>  
>  	if (name) {
> -		struct filename *tmp = getname(name);
> -
> -		if (IS_ERR(tmp))
> -			return PTR_ERR(tmp);
>  		mutex_lock(&acct_on_mutex);
> -		error = acct_on(tmp);
> +		error = acct_on(name);
>  		mutex_unlock(&acct_on_mutex);
> -		putname(tmp);
>  	} else {
>  		rcu_read_lock();
>  		pin_kill(task_active_pid_ns(current)->bacct);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

