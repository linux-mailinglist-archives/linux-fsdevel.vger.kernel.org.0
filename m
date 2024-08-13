Return-Path: <linux-fsdevel+bounces-25788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5AB9505DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 15:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E340FB292DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 13:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E6319ADB9;
	Tue, 13 Aug 2024 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxwxxorj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56904C8C
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554131; cv=none; b=Zg+BWVG3ojjcqDDfN0Yiz5yxyVfpS6HQ1rwmtiNanrfGKwKLQX9mFOneIJKQsTxUphXcdGG3NcZv67o3WoeJmJBcSS1hyqwQLjxEWTCtS5kVPDpD5k7eN6dnZ7hUYa3Y+U5Q7BxsuJ6Xa8V9vi7z1rM/0XVFElnpBCSenRxK3J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554131; c=relaxed/simple;
	bh=v6DB+SN8DZsQ0wJaHO+zLFuxDhHPLMmbb/cxcPA9tTQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TBGJZC6j96jpqQ2LA3ARGtl4s6frQ9CopF/SIUYT+nK+mZBpAUL+cD1I+3X6ISQIraUVRTvlGe1iqSCkNDWwmjU7eJSFTc8Cde/Ihud9qgMttJ116YwBkF5vy/y2utPGyEl1TCg6NYgkYqctISCLp9DE40h+2lfdAXhOP1Z9qJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wxwxxorj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BBFC4AF0B;
	Tue, 13 Aug 2024 13:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723554131;
	bh=v6DB+SN8DZsQ0wJaHO+zLFuxDhHPLMmbb/cxcPA9tTQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WxwxxorjA7Y0MI7oU4eVXmsNOV/Sk90CsYNVdJLfaljI3m4rN7NOskSsvx/mQchrc
	 cd+npUk/3WAuBtIfIN3xn7nHlCXAC9ej/t0HZpVaeLBSJ9UePWGLf/nHSCD5dUqgAa
	 q/R8gY3eIxJcGB0M36F7LnM6n+Tby820htl3Xw/cK5s0QzISgqP4uLGlANZTTDU8aG
	 0h9Q+fdQl0kknpmpCqUTpqbitdQunKDYUdIOn8RnFz3yfoZJpXU9Ln2DPg/Ve2WB5q
	 Kul4xmoIMrH9f7St6G1O7JvDZ6BxZK1E+0r6G4seHQsfRppKg2X7eT8sXRayEF8vrx
	 1zaxcVP1LM5qA==
Message-ID: <99445ca03b6b3edc4b4943add498e2b29c367dec.camel@kernel.org>
Subject: Re: [PATCH v2] file: reclaim 24 bytes from f_owner
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro
	 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>, Josef Bacik
	 <josef@toxicpanda.com>, Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 13 Aug 2024 09:02:09 -0400
In-Reply-To: <20240813-work-f_owner-v2-1-4e9343a79f9f@kernel.org>
References: <20240813-work-f_owner-v2-1-4e9343a79f9f@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-13 at 14:30 +0200, Christian Brauner wrote:
> We do embedd struct fown_struct into struct file letting it take up 32
> bytes in total. We could tweak struct fown_struct to be more compact but
> really it shouldn't even be embedded in struct file in the first place.
>=20
> Instead, actual users of struct fown_struct should allocate the struct
> on demand. This frees up 24 bytes in struct file.
>=20
> That will have some potentially user-visible changes for the ownership
> fcntl()s. Some of them can now fail due to allocation failures.
> Practically, that probably will almost never happen as the allocations
> are small and they only happen once per file.
>=20
> The fown_struct is used during kill_fasync() which is used by e.g.,
> pipes to generate a SIGIO signal. Sending of such signals is conditional
> on userspace having set an owner for the file using one of the F_OWNER
> fcntl()s. Such users will be unaffected if struct fown_struct is
> allocated during the fcntl() call.
>=20
> There are a few subsystems that call __f_setown() expecting
> file->f_owner to be allocated:
>=20
> (1) tun devices
>     file->f_op->fasync::tun_chr_fasync()
>     -> __f_setown()
>=20
>     There are no callers of tun_chr_fasync().
>=20
> (2) tty devices
>=20
>     file->f_op->fasync::tty_fasync()
>     -> __tty_fasync()
>        -> __f_setown()
>=20
>     tty_fasync() has no additional callers but __tty_fasync() has. Note
>     that __tty_fasync() only calls __f_setown() if the @on argument is
>     true. It's called from:
>=20
>     file->f_op->release::tty_release()
>     -> tty_release()
>        -> __tty_fasync()
>           -> __f_setown()
>=20
>     tty_release() calls __tty_fasync() with @on false
>     =3D> __f_setown() is never called from tty_release().
>        =3D> All callers of tty_release() are safe as well.
>=20
>     file->f_op->release::tty_open()
>     -> tty_release()
>        -> __tty_fasync()
>           -> __f_setown()
>=20
>     __tty_hangup() calls __tty_fasync() with @on false
>     =3D> __f_setown() is never called from tty_release().
>        =3D> All callers of __tty_hangup() are safe as well.
>=20
> From the callchains it's obvious that (1) and (2) end up getting called
> via file->f_op->fasync(). That can happen either through the F_SETFL
> fcntl() with the FASYNC flag raised or via the FIOASYNC ioctl(). If
> FASYNC is requested and the file isn't already FASYNC then
> file->f_op->fasync() is called with @on true which ends up causing both
> (1) and (2) to call __f_setown().
>=20
> (1) and (2) are the only subsystems that call __f_setown() from the
> file->f_op->fasync() handler. So both (1) and (2) have been updated to
> allocate a struct fown_struct prior to calling fasync_helper() to
> register with the fasync infrastructure. That's safe as they both call
> fasync_helper() which also does allocations if @on is true.
>=20
> The other interesting case are file leases:
>=20
> (3) file leases
>     lease_manager_ops->lm_setup::lease_setup()
>     -> __f_setown()
>=20
>     Which in turn is called from:
>=20
>     generic_add_lease()
>     -> lease_manager_ops->lm_setup::lease_setup()
>        -> __f_setown()
>=20
> So here again we can simply make generic_add_lease() allocate struct
> fown_struct prior to the lease_manager_ops->lm_setup::lease_setup()
> which happens under a spinlock.
>=20
> With that the two remaining subsystems that call __f_setown() are:
>=20
> (4) dnotify
> (5) sockets
>=20
> Both have their own custom ioctls to set struct fown_struct and both
> have been converted to allocate a struct fown_struct on demand from
> their respective ioctls.
>=20
> Interactions with O_PATH are fine as well e.g., when opening a /dev/tty
> as O_PATH then no file->f_op->open() happens thus no file->f_owner is
> allocated. That's fine as no file operation will be set for those and
> the device has never been opened. fcntl()s called on such things will
> just allocate a ->f_owner on demand. Although I have zero idea why'd you
> care about f_owner on an O_PATH fd.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> * There's no more cleanup macros used in this version as we can solve
>   that all much simpler.
> * Survives LTP which tests a bunch of that stuff.
> * Survives perf's watermak signal tests which make use of FASYNC.
>=20
> Goes into -next unless I hear objections.
> ---
>=20
> ---
>  drivers/net/tun.c           |   6 ++
>  drivers/tty/tty_io.c        |   6 ++
>  fs/fcntl.c                  | 153 ++++++++++++++++++++++++++++++++++----=
------
>  fs/file_table.c             |   6 +-
>  fs/locks.c                  |   6 +-
>  fs/notify/dnotify/dnotify.c |   6 +-
>  include/linux/fs.h          |  11 +++-
>  net/core/sock.c             |   2 +-
>  security/selinux/hooks.c    |   2 +-
>  security/smack/smack_lsm.c  |   2 +-
>  10 files changed, 157 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 1d06c560c5e6..6fe5e8f7017c 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3451,6 +3451,12 @@ static int tun_chr_fasync(int fd, struct file *fil=
e, int on)
>  	struct tun_file *tfile =3D file->private_data;
>  	int ret;
> =20
> +	if (on) {
> +		ret =3D file_f_owner_allocate(file);
> +		if (ret)
> +			goto out;
> +	}
> +
>  	if ((ret =3D fasync_helper(fd, file, on, &tfile->fasync)) < 0)
>  		goto out;
> =20
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 407b0d87b7c1..7ae0c8934f42 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -2225,6 +2225,12 @@ static int __tty_fasync(int fd, struct file *filp,=
 int on)
>  	if (tty_paranoia_check(tty, file_inode(filp), "tty_fasync"))
>  		goto out;
> =20
> +	if (on) {
> +		retval =3D file_f_owner_allocate(filp);
> +		if (retval)
> +			goto out;
> +	}
> +
>  	retval =3D fasync_helper(fd, filp, on, &tty->fasync);
>  	if (retval <=3D 0)
>  		goto out;
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 300e5d9ad913..b002730fdcd1 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -87,22 +87,53 @@ static int setfl(int fd, struct file * filp, unsigned=
 int arg)
>  	return error;
>  }
> =20
> +/*
> + * Allocate an file->f_owner struct if it doesn't exist, handling racing
> + * allocations correctly.
> + */
> +int file_f_owner_allocate(struct file *file)
> +{
> +	struct fown_struct *f_owner;
> +
> +	f_owner =3D file_f_owner(file);
> +	if (f_owner)
> +		return 0;
> +
> +	f_owner =3D kzalloc(sizeof(struct fown_struct), GFP_KERNEL);
> +	if (!f_owner)
> +		return -ENOMEM;
> +
> +	rwlock_init(&f_owner->lock);
> +	f_owner->file =3D file;
> +	/* If someone else raced us, drop our allocation. */
> +	if (unlikely(cmpxchg(&file->f_owner, NULL, f_owner)))

nit: try_cmpxchg generates better asm and should be fine here.

> +		kfree(f_owner);
> +	return 0;
> +}
> +EXPORT_SYMBOL(file_f_owner_allocate);
> +
>  static void f_modown(struct file *filp, struct pid *pid, enum pid_type t=
ype,
>                       int force)
>  {
> -	write_lock_irq(&filp->f_owner.lock);
> -	if (force || !filp->f_owner.pid) {
> -		put_pid(filp->f_owner.pid);
> -		filp->f_owner.pid =3D get_pid(pid);
> -		filp->f_owner.pid_type =3D type;
> +	struct fown_struct *f_owner;
> +
> +	f_owner =3D file_f_owner(filp);
> +	if (WARN_ON_ONCE(!f_owner))=20
> +		return;
> +
> +	write_lock_irq(&f_owner->lock);
> +	if (force || !f_owner->pid) {
> +		put_pid(f_owner->pid);
> +		f_owner->pid =3D get_pid(pid);
> +		f_owner->pid_type =3D type;
> =20
>  		if (pid) {
>  			const struct cred *cred =3D current_cred();
> -			filp->f_owner.uid =3D cred->uid;
> -			filp->f_owner.euid =3D cred->euid;
> +			f_owner->uid =3D cred->uid;
> +			f_owner->euid =3D cred->euid;
>  		}
>  	}
> -	write_unlock_irq(&filp->f_owner.lock);
> +	write_unlock_irq(&f_owner->lock);
>  }
> =20
>  void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
> @@ -119,6 +150,8 @@ int f_setown(struct file *filp, int who, int force)
>  	struct pid *pid =3D NULL;
>  	int ret =3D 0;
> =20
> +	might_sleep();
> +
>  	type =3D PIDTYPE_TGID;
>  	if (who < 0) {
>  		/* avoid overflow below */
> @@ -129,6 +162,10 @@ int f_setown(struct file *filp, int who, int force)
>  		who =3D -who;
>  	}
> =20
> +	ret =3D file_f_owner_allocate(filp);
> +	if (ret)
> +		return ret;
> +
>  	rcu_read_lock();
>  	if (who) {
>  		pid =3D find_vpid(who);
> @@ -152,16 +189,21 @@ void f_delown(struct file *filp)
>  pid_t f_getown(struct file *filp)
>  {
>  	pid_t pid =3D 0;
> +	struct fown_struct *f_owner;
> =20
> -	read_lock_irq(&filp->f_owner.lock);
> +	f_owner =3D file_f_owner(filp);
> +	if (!f_owner)
> +		return pid;
> +
> +	read_lock_irq(&f_owner->lock);
>  	rcu_read_lock();
> -	if (pid_task(filp->f_owner.pid, filp->f_owner.pid_type)) {
> -		pid =3D pid_vnr(filp->f_owner.pid);
> -		if (filp->f_owner.pid_type =3D=3D PIDTYPE_PGID)
> +	if (pid_task(f_owner->pid, f_owner->pid_type)) {
> +		pid =3D pid_vnr(f_owner->pid);
> +		if (f_owner->pid_type =3D=3D PIDTYPE_PGID)
>  			pid =3D -pid;
>  	}
>  	rcu_read_unlock();
> -	read_unlock_irq(&filp->f_owner.lock);
> +	read_unlock_irq(&f_owner->lock);
>  	return pid;
>  }
> =20
> @@ -194,6 +236,10 @@ static int f_setown_ex(struct file *filp, unsigned l=
ong arg)
>  		return -EINVAL;
>  	}
> =20
> +	ret =3D file_f_owner_allocate(filp);
> +	if (ret)
> +		return ret;
> +
>  	rcu_read_lock();
>  	pid =3D find_vpid(owner.pid);
>  	if (owner.pid && !pid)
> @@ -210,13 +256,20 @@ static int f_getown_ex(struct file *filp, unsigned =
long arg)
>  	struct f_owner_ex __user *owner_p =3D (void __user *)arg;
>  	struct f_owner_ex owner =3D {};
>  	int ret =3D 0;
> +	struct fown_struct *f_owner;
> +	enum pid_type pid_type =3D PIDTYPE_PID;
> =20
> -	read_lock_irq(&filp->f_owner.lock);
> -	rcu_read_lock();
> -	if (pid_task(filp->f_owner.pid, filp->f_owner.pid_type))
> -		owner.pid =3D pid_vnr(filp->f_owner.pid);
> -	rcu_read_unlock();
> -	switch (filp->f_owner.pid_type) {
> +	f_owner =3D file_f_owner(filp);
> +	if (f_owner) {
> +		read_lock_irq(&f_owner->lock);
> +		rcu_read_lock();
> +		if (pid_task(f_owner->pid, f_owner->pid_type))
> +			owner.pid =3D pid_vnr(f_owner->pid);
> +		rcu_read_unlock();
> +		pid_type =3D f_owner->pid_type;
> +	}
> +
> +	switch (pid_type) {
>  	case PIDTYPE_PID:
>  		owner.type =3D F_OWNER_TID;
>  		break;
> @@ -234,7 +287,8 @@ static int f_getown_ex(struct file *filp, unsigned lo=
ng arg)
>  		ret =3D -EINVAL;
>  		break;
>  	}
> -	read_unlock_irq(&filp->f_owner.lock);
> +	if (f_owner)
> +		read_unlock_irq(&f_owner->lock);
> =20
>  	if (!ret) {
>  		ret =3D copy_to_user(owner_p, &owner, sizeof(owner));
> @@ -248,14 +302,18 @@ static int f_getown_ex(struct file *filp, unsigned =
long arg)
>  static int f_getowner_uids(struct file *filp, unsigned long arg)
>  {
>  	struct user_namespace *user_ns =3D current_user_ns();
> +	struct fown_struct *f_owner;
>  	uid_t __user *dst =3D (void __user *)arg;
> -	uid_t src[2];
> +	uid_t src[2] =3D {0, 0};
>  	int err;
> =20
> -	read_lock_irq(&filp->f_owner.lock);
> -	src[0] =3D from_kuid(user_ns, filp->f_owner.uid);
> -	src[1] =3D from_kuid(user_ns, filp->f_owner.euid);
> -	read_unlock_irq(&filp->f_owner.lock);
> +	f_owner =3D file_f_owner(filp);
> +	if (f_owner) {
> +		read_lock_irq(&f_owner->lock);
> +		src[0] =3D from_kuid(user_ns, f_owner->uid);
> +		src[1] =3D from_kuid(user_ns, f_owner->euid);
> +		read_unlock_irq(&f_owner->lock);
> +	}
> =20
>  	err  =3D put_user(src[0], &dst[0]);
>  	err |=3D put_user(src[1], &dst[1]);
> @@ -343,6 +401,30 @@ static long f_dupfd_query(int fd, struct file *filp)
>  	return f.file =3D=3D filp;
>  }
> =20
> +static int f_owner_sig(struct file *filp, int signum, bool setsig)
> +{
> +	int ret =3D 0;
> +	struct fown_struct *f_owner;
> +
> +	might_sleep();
> +
> +	if (setsig) {
> +		if (!valid_signal(signum))
> +			return -EINVAL;
> +
> +		ret =3D file_f_owner_allocate(filp);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	f_owner =3D file_f_owner(filp);
> +	if (setsig)
> +		f_owner->signum =3D signum;
> +	else if (f_owner)
> +		ret =3D f_owner->signum;
> +	return ret;
> +}
> +
>  static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
>  		struct file *filp)
>  {
> @@ -421,15 +503,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsi=
gned long arg,
>  		err =3D f_getowner_uids(filp, arg);
>  		break;
>  	case F_GETSIG:
> -		err =3D filp->f_owner.signum;
> +		err =3D f_owner_sig(filp, 0, false);
>  		break;
>  	case F_SETSIG:
> -		/* arg =3D=3D 0 restores default behaviour. */
> -		if (!valid_signal(argi)) {
> -			break;
> -		}
> -		err =3D 0;
> -		filp->f_owner.signum =3D argi;
> +		err =3D f_owner_sig(filp, argi, true);
>  		break;
>  	case F_GETLEASE:
>  		err =3D fcntl_getlease(filp);
> @@ -844,14 +921,19 @@ static void send_sigurg_to_task(struct task_struct =
*p,
>  		do_send_sig_info(SIGURG, SEND_SIG_PRIV, p, type);
>  }
> =20
> -int send_sigurg(struct fown_struct *fown)
> +int send_sigurg(struct file *file)
>  {
> +	struct fown_struct *fown;
>  	struct task_struct *p;
>  	enum pid_type type;
>  	struct pid *pid;
>  	unsigned long flags;
>  	int ret =3D 0;
>  =09
> +	fown =3D file_f_owner(file);
> +	if (fown)
> +		return 0;

This needs to be fixed (as Mateusz pointed out).

> +
>  	read_lock_irqsave(&fown->lock, flags);
> =20
>  	type =3D fown->pid_type;
> @@ -1027,13 +1109,16 @@ static void kill_fasync_rcu(struct fasync_struct =
*fa, int sig, int band)
>  		}
>  		read_lock_irqsave(&fa->fa_lock, flags);
>  		if (fa->fa_file) {
> -			fown =3D &fa->fa_file->f_owner;
> +			fown =3D file_f_owner(fa->fa_file);
> +			if (!fown)
> +				goto next;
>  			/* Don't send SIGURG to processes which have not set a
>  			   queued signum: SIGURG has its own default signalling
>  			   mechanism. */
>  			if (!(sig =3D=3D SIGURG && fown->signum =3D=3D 0))
>  				send_sigio(fown, fa->fa_fd, band);
>  		}
> +next:
>  		read_unlock_irqrestore(&fa->fa_lock, flags);
>  		fa =3D rcu_dereference(fa->fa_next);
>  	}
> diff --git a/fs/file_table.c b/fs/file_table.c
> index ca7843dde56d..41ff037a8dc9 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -155,7 +155,6 @@ static int init_file(struct file *f, int flags, const=
 struct cred *cred)
>  		return error;
>  	}
> =20
> -	rwlock_init(&f->f_owner.lock);
>  	spin_lock_init(&f->f_lock);
>  	mutex_init(&f->f_pos_lock);
>  	f->f_flags =3D flags;
> @@ -425,7 +424,10 @@ static void __fput(struct file *file)
>  		cdev_put(inode->i_cdev);
>  	}
>  	fops_put(file->f_op);
> -	put_pid(file->f_owner.pid);
> +	if (file->f_owner) {
> +		put_pid(file->f_owner->pid);
> +		kfree(file->f_owner);
> +	}
>  	put_file_access(file);
>  	dput(dentry);
>  	if (unlikely(mode & FMODE_NEED_UNMOUNT))
> diff --git a/fs/locks.c b/fs/locks.c
> index 9afb16e0683f..c0d312481b97 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1451,7 +1451,7 @@ int lease_modify(struct file_lease *fl, int arg, st=
ruct list_head *dispose)
>  		struct file *filp =3D fl->c.flc_file;
> =20
>  		f_delown(filp);
> -		filp->f_owner.signum =3D 0;
> +		file_f_owner(filp)->signum =3D 0;
>  		fasync_helper(0, fl->c.flc_file, 0, &fl->fl_fasync);
>  		if (fl->fl_fasync !=3D NULL) {
>  			printk(KERN_ERR "locks_delete_lock: fasync =3D=3D %p\n", fl->fl_fasyn=
c);
> @@ -1783,6 +1783,10 @@ generic_add_lease(struct file *filp, int arg, stru=
ct file_lease **flp, void **pr
>  	lease =3D *flp;
>  	trace_generic_add_lease(inode, lease);
> =20
> +	error =3D file_f_owner_allocate(filp);
> +	if (error)
> +		return error;
> +
>  	/* Note that arg is never F_UNLCK here */
>  	ctx =3D locks_get_lock_context(inode, arg);
>  	if (!ctx)
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index f3669403fabf..46440fbb8662 100644
> --- a/fs/notify/dnotify/dnotify.c
> +++ b/fs/notify/dnotify/dnotify.c
> @@ -110,7 +110,7 @@ static int dnotify_handle_event(struct fsnotify_mark =
*inode_mark, u32 mask,
>  			prev =3D &dn->dn_next;
>  			continue;
>  		}
> -		fown =3D &dn->dn_filp->f_owner;
> +		fown =3D file_f_owner(dn->dn_filp);
>  		send_sigio(fown, dn->dn_fd, POLL_MSG);
>  		if (dn->dn_mask & FS_DN_MULTISHOT)
>  			prev =3D &dn->dn_next;
> @@ -316,6 +316,10 @@ int fcntl_dirnotify(int fd, struct file *filp, unsig=
ned int arg)
>  		goto out_err;
>  	}
> =20
> +	error =3D file_f_owner_allocate(filp);
> +	if (error)
> +		goto out_err;
> +
>  	/* set up the new_fsn_mark and new_dn_mark */
>  	new_fsn_mark =3D &new_dn_mark->fsn_mark;
>  	fsnotify_init_mark(new_fsn_mark, dnotify_group);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd34b5755c0b..319c566a9e98 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -947,6 +947,7 @@ static inline unsigned imajor(const struct inode *ino=
de)
>  }
> =20
>  struct fown_struct {
> +	struct file *file;	/* backpointer for security modules */

This struct was 32 bytes before (on x86_64). Now it'll be 40. That's
fine, but it may be worthwhile to create a dedicated slabcache for this
now, since it's no longer a power-of-2 size.

>  	rwlock_t lock;          /* protects pid, uid, euid fields */
>  	struct pid *pid;	/* pid or -pgrp where SIGIO should be sent */
>  	enum pid_type pid_type;	/* Kind of process group SIGIO should be sent t=
o */
> @@ -1011,7 +1012,7 @@ struct file {
>  	struct mutex		f_pos_lock;
>  	loff_t			f_pos;
>  	unsigned int		f_flags;
> -	struct fown_struct	f_owner;
> +	struct fown_struct	*f_owner;
>  	const struct cred	*f_cred;
>  	struct file_ra_state	f_ra;
>  	struct path		f_path;
> @@ -1076,6 +1077,12 @@ struct file_lease;
>  #define OFFT_OFFSET_MAX	type_max(off_t)
>  #endif
> =20
> +int file_f_owner_allocate(struct file *file);
> +static inline struct fown_struct *file_f_owner(const struct file *file)
> +{
> +	return READ_ONCE(file->f_owner);
> +}
> +
>  extern void send_sigio(struct fown_struct *fown, int fd, int band);
> =20
>  static inline struct inode *file_inode(const struct file *f)
> @@ -1124,7 +1131,7 @@ extern void __f_setown(struct file *filp, struct pi=
d *, enum pid_type, int force
>  extern int f_setown(struct file *filp, int who, int force);
>  extern void f_delown(struct file *filp);
>  extern pid_t f_getown(struct file *filp);
> -extern int send_sigurg(struct fown_struct *fown);
> +extern int send_sigurg(struct file *file);
> =20
>  /*
>   * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 9abc4fe25953..bbe4c58470c3 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3429,7 +3429,7 @@ static void sock_def_destruct(struct sock *sk)
>  void sk_send_sigurg(struct sock *sk)
>  {
>  	if (sk->sk_socket && sk->sk_socket->file)
> -		if (send_sigurg(&sk->sk_socket->file->f_owner))
> +		if (send_sigurg(sk->sk_socket->file))
>  			sk_wake_async(sk, SOCK_WAKE_URG, POLL_PRI);
>  }
>  EXPORT_SYMBOL(sk_send_sigurg);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 55c78c318ccd..ed252cfba4e9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3940,7 +3940,7 @@ static int selinux_file_send_sigiotask(struct task_=
struct *tsk,
>  	struct file_security_struct *fsec;
> =20
>  	/* struct fown_struct is never outside the context of a struct file */
> -	file =3D container_of(fown, struct file, f_owner);
> +	file =3D fown->file;
> =20
>  	fsec =3D selinux_file(file);
> =20
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 4164699cd4f6..cb33920ab67c 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1950,7 +1950,7 @@ static int smack_file_send_sigiotask(struct task_st=
ruct *tsk,
>  	/*
>  	 * struct fown_struct is never outside the context of a struct file
>  	 */
> -	file =3D container_of(fown, struct file, f_owner);
> +	file =3D fown->file;
> =20
>  	/* we don't log here as rc can be overriden */
>  	blob =3D smack_file(file);
>=20
> ---
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> change-id: 20240813-work-f_owner-0fbbc50f9671
>=20

Aside from the bug that Mateusz pointed out, this looks fine to me.
Assuming you fix that bug:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

