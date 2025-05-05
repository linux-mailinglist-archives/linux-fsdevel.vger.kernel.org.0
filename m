Return-Path: <linux-fsdevel+bounces-48052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C69AA918C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2A4175683
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49641FF7B0;
	Mon,  5 May 2025 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EbaW63iD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kTv5xL64";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EbaW63iD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kTv5xL64"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718D21C3BE2
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746443276; cv=none; b=X24CDTmlCWzJQRuaRAOrCw57U4HIFUcCruqR+dGjOXsGuIkB42FJDKwxsIweCBDHwiWLCV4PHhvioVBY5J52eRk/rL23FaZCPsXwf74wIANQkNSfkKsese83to8CVEaUVlGQyOnnb9zz1OJfwK/2sutX9MWAoGiP3LPXo0GdBSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746443276; c=relaxed/simple;
	bh=75xTaqX5t3LkXn4DghonFn4V2vp0/OkMdcyBgJ3fOMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSm6K53GXrk5Q3oXp5gsXnr9V1zVr+Qimlhj0b1ShmQnzkVMewyjhrK3AK7sp1LpafoWgt89MFK0ygsZeiyHNDEPeDSJmY23Qi/kwtuKpe4XdAcOIEF5OMFUB3uV/XzE0RP7JoXyOUq2rfYP0+kdv/dFA6E35phCaEpwlisXJCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EbaW63iD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kTv5xL64; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EbaW63iD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kTv5xL64; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 749FA1F453;
	Mon,  5 May 2025 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746443272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=moeccF8N//NdzTwsOxcbl58QpJE0t4cPwcQaT+6GOws=;
	b=EbaW63iDsy1jtD+R9ckfxVrSqDWzot8JkPEB7kbCsBgB2UvC+Yx/F1LZEcnx9fAQLUjwlV
	qcxnMhC6VeHtVxBnBRUHttjgdpk2bsp6qZWxQepMCunT5EkeuO/U81jDjD/ExI3Plyt/S8
	xRKGLaTWwIQtcY914DkeBcCEwceXdCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746443272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=moeccF8N//NdzTwsOxcbl58QpJE0t4cPwcQaT+6GOws=;
	b=kTv5xL64qPXfGQEwMcvAO+AbTZVXRozuyEagoeH3ZjjWI50I+joLkCjXrYYhDIjQwvm1/C
	St+8ynBE47hyD1Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746443272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=moeccF8N//NdzTwsOxcbl58QpJE0t4cPwcQaT+6GOws=;
	b=EbaW63iDsy1jtD+R9ckfxVrSqDWzot8JkPEB7kbCsBgB2UvC+Yx/F1LZEcnx9fAQLUjwlV
	qcxnMhC6VeHtVxBnBRUHttjgdpk2bsp6qZWxQepMCunT5EkeuO/U81jDjD/ExI3Plyt/S8
	xRKGLaTWwIQtcY914DkeBcCEwceXdCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746443272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=moeccF8N//NdzTwsOxcbl58QpJE0t4cPwcQaT+6GOws=;
	b=kTv5xL64qPXfGQEwMcvAO+AbTZVXRozuyEagoeH3ZjjWI50I+joLkCjXrYYhDIjQwvm1/C
	St+8ynBE47hyD1Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65EF113AB7;
	Mon,  5 May 2025 11:07:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lBDZGAicGGjvCQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 May 2025 11:07:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1DED5A0670; Mon,  5 May 2025 13:07:52 +0200 (CEST)
Date: Mon, 5 May 2025 13:07:52 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Melissa Wen <mwen@igalia.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH][CFT][RFC] sanitize handling of long-term internal mounts
Message-ID: <jlvm4mtd2pexrb2n5msf5fmhp3zxvbqi6tqyi2ea5f5z3yuckk@rmpggn53till>
References: <20250503230251.GA2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503230251.GA2023217@ZenIV>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun 04-05-25 00:02:51, Al Viro wrote:
> [folks, review and testing would be very welcome; i915 and v3d conversions
> are essentially untested and I would really like to hear from DRM people
> before pushing those anywhere.  I've no problem with splitting these
> parts off and putting the infrastructure bits into a never-rebased
> branch, if somebody prefers to have those taken via drm tree]
> 
> Original rationale for those had been the reduced cost of mntput()
> for the stuff that is mounted somewhere.  Mount refcount increments and
> decrements are frequent; what's worse, they tend to concentrate on the
> same instances and cacheline pingpong is quite noticable.
> 
> As the result, mount refcounts are per-cpu; that allows a very cheap
> increment.  Plain decrement would be just as easy, but decrement-and-test
> is anything but (we need to add the components up, with exclusion against
> possible increment-from-zero, etc.).
> 
> Fortunately, there is a very common case where we can tell that decrement
> won't be the final one - if the thing we are dropping is currently
> mounted somewhere.  We have an RCU delay between the removal from mount
> tree and dropping the reference that used to pin it there, so we can
> just take rcu_read_lock() and check if the victim is mounted somewhere.
> If it is, we can go ahead and decrement without and further checks -
> the reference we are dropping is not the last one.  If it isn't, we
> get all the fun with locking, carefully adding up components, etc.,
> but the majority of refcount decrements end up taking the fast path.
> 
> There is a major exception, though - pipes and sockets.  Those live
> on the internal filesystems that are not going to be mounted anywhere.
> They are not going to be _un_mounted, of course, so having to take the
> slow path every time a pipe or socket gets closed is really obnoxious.
> Solution had been to mark them as long-lived ones - essentially faking
> "they are mounted somewhere" indicator.
> 
> With minor modification that works even for ones that do eventually get
> dropped - all it takes is making sure we have an RCU delay between
> clearing the "mounted somewhere" indicator and dropping the reference.
> 
> There are some additional twists (if you want to drop a dozen of such
> internal mounts, you'd be better off with clearing the indicator on
> all of them, doing an RCU delay once, then dropping the references),
> but in the basic form it had been
> 	* use kern_mount() if you want your internal mount to be
> a long-term one.
> 	* use kern_unmount() to undo that.
> 
> Unfortunately, the things did rot a bit during the mount API reshuffling.
> In several cases we have lost the "fake the indicator" part; kern_unmount()
> on the unmount side remained (it doesn't warn if you use it on a mount
> without the indicator), but all benefits regaring mntput() cost had been
> lost.
> 
> To get rid of that bitrot, let's add a new helper that would work
> with fs_context-based API: fc_mount_longterm().  It's a counterpart
> of fc_mount() that does, on success, mark its result as long-term.
> It must be paired with kern_unmount() or equivalents.
> 
> Converted:
> 	1) mqueue (it used to use kern_mount_data() and the umount side
> is still as it used to be)
> 	2) hugetlbfs (used to use kern_mount_data(), internal mount is
> never unmounted in this one)
> 	3) i915 gemfs (used to be kern_mount() + manual remount to set
> options, still uses kern_unmount() on umount side)
> 	4) v3d gemfs (copied from i915)
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

The VFS bits look good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
> index 46b9a17d6abc..aae7c0a3c966 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
> @@ -6,16 +6,23 @@
>  
>  #include <linux/fs.h>
>  #include <linux/mount.h>
> +#include <linux/fs_context.h>
>  
>  #include "i915_drv.h"
>  #include "i915_gemfs.h"
>  #include "i915_utils.h"
>  
> +static int add_param(struct fs_context *fc, const char *key, const char *val)
> +{
> +	return vfs_parse_fs_string(fc, key, val, strlen(val));
> +}
> +
>  void i915_gemfs_init(struct drm_i915_private *i915)
>  {
> -	char huge_opt[] = "huge=within_size"; /* r/w */
>  	struct file_system_type *type;
> +	struct fs_context *fc;
>  	struct vfsmount *gemfs;
> +	int ret;
>  
>  	/*
>  	 * By creating our own shmemfs mountpoint, we can pass in
> @@ -39,8 +46,16 @@ void i915_gemfs_init(struct drm_i915_private *i915)
>  	if (!type)
>  		goto err;
>  
> -	gemfs = vfs_kern_mount(type, SB_KERNMOUNT, type->name, huge_opt);
> -	if (IS_ERR(gemfs))
> +	fc = fs_context_for_mount(type, SB_KERNMOUNT);
> +	if (IS_ERR(fc))
> +		goto err;
> +	ret = add_param(fc, "source", "tmpfs");
> +	if (!ret)
> +		ret = add_param(fc, "huge", "within_size");
> +	if (!ret)
> +		gemfs = fc_mount_longterm(fc);
> +	put_fs_context(fc);
> +	if (ret)
>  		goto err;
>  
>  	i915->mm.gemfs = gemfs;
> diff --git a/drivers/gpu/drm/v3d/v3d_gemfs.c b/drivers/gpu/drm/v3d/v3d_gemfs.c
> index 4c5e18590a5c..8ec6ed82b3d9 100644
> --- a/drivers/gpu/drm/v3d/v3d_gemfs.c
> +++ b/drivers/gpu/drm/v3d/v3d_gemfs.c
> @@ -3,14 +3,21 @@
>  
>  #include <linux/fs.h>
>  #include <linux/mount.h>
> +#include <linux/fs_context.h>
>  
>  #include "v3d_drv.h"
>  
> +static int add_param(struct fs_context *fc, const char *key, const char *val)
> +{
> +	return vfs_parse_fs_string(fc, key, val, strlen(val));
> +}
> +
>  void v3d_gemfs_init(struct v3d_dev *v3d)
>  {
> -	char huge_opt[] = "huge=within_size";
>  	struct file_system_type *type;
> +	struct fs_context *fc;
>  	struct vfsmount *gemfs;
> +	int ret;
>  
>  	/*
>  	 * By creating our own shmemfs mountpoint, we can pass in
> @@ -28,8 +35,16 @@ void v3d_gemfs_init(struct v3d_dev *v3d)
>  	if (!type)
>  		goto err;
>  
> -	gemfs = vfs_kern_mount(type, SB_KERNMOUNT, type->name, huge_opt);
> -	if (IS_ERR(gemfs))
> +	fc = fs_context_for_mount(type, SB_KERNMOUNT);
> +	if (IS_ERR(fc))
> +		goto err;
> +	ret = add_param(fc, "source", "tmpfs");
> +	if (!ret)
> +		ret = add_param(fc, "huge", "within_size");
> +	if (!ret)
> +		gemfs = fc_mount_longterm(fc);
> +	put_fs_context(fc);
> +	if (ret)
>  		goto err;
>  
>  	v3d->gemfs = gemfs;
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index e4de5425838d..4e0397775167 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1587,7 +1587,7 @@ static struct vfsmount *__init mount_one_hugetlbfs(struct hstate *h)
>  	} else {
>  		struct hugetlbfs_fs_context *ctx = fc->fs_private;
>  		ctx->hstate = h;
> -		mnt = fc_mount(fc);
> +		mnt = fc_mount_longterm(fc);
>  		put_fs_context(fc);
>  	}
>  	if (IS_ERR(mnt))
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 6f7b2174f25b..07f636036b86 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1258,6 +1258,15 @@ struct vfsmount *fc_mount(struct fs_context *fc)
>  }
>  EXPORT_SYMBOL(fc_mount);
>  
> +struct vfsmount *fc_mount_longterm(struct fs_context *fc)
> +{
> +	struct vfsmount *mnt = fc_mount(fc);
> +	if (!IS_ERR(mnt))
> +		real_mount(mnt)->mnt_ns = MNT_NS_INTERNAL;
> +	return mnt;
> +}
> +EXPORT_SYMBOL(fc_mount_longterm);
> +
>  struct vfsmount *vfs_kern_mount(struct file_system_type *type,
>  				int flags, const char *name,
>  				void *data)
> diff --git a/include/linux/mount.h b/include/linux/mount.h
> index dcc17ce8a959..9376d76dd61f 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -94,6 +94,7 @@ int mnt_get_write_access(struct vfsmount *mnt);
>  void mnt_put_write_access(struct vfsmount *mnt);
>  
>  extern struct vfsmount *fc_mount(struct fs_context *fc);
> +extern struct vfsmount *fc_mount_longterm(struct fs_context *fc);
>  extern struct vfsmount *vfs_create_mount(struct fs_context *fc);
>  extern struct vfsmount *vfs_kern_mount(struct file_system_type *type,
>  				      int flags, const char *name,
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 35b4f8659904..daabf7f02b63 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -482,7 +482,7 @@ static struct vfsmount *mq_create_mount(struct ipc_namespace *ns)
>  	put_user_ns(fc->user_ns);
>  	fc->user_ns = get_user_ns(ctx->ipc_ns->user_ns);
>  
> -	mnt = fc_mount(fc);
> +	mnt = fc_mount_longterm(fc);
>  	put_fs_context(fc);
>  	return mnt;
>  }
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

