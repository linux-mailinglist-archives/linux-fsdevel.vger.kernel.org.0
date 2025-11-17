Return-Path: <linux-fsdevel+bounces-68765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE3C65B24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB1104E62B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 18:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ABB313260;
	Mon, 17 Nov 2025 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyqM01mu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89F312829;
	Mon, 17 Nov 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403696; cv=none; b=evMV0QulMZrFUck2U63MnfqbnqmfCfXV25FY7kssZK9EfVlDumrbbn0yjZzzsn1iM9UoC9oTY6zaWLcQLS/SIYVXiBvmjJcxDD8nPPCmzPyU88My4vaJGt6AWQdVbgYLPU5Vn1YuSHN+Nr6uoGnrdKGtDSFKk+DgOtAyAQ+jz7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403696; c=relaxed/simple;
	bh=2yisANE7qjI9IISnPxhYqY2yn6Md2ZHrrpDB3XpbIOw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HRZqFEU/tSmjmd43IBJdtzWcTbEEJb6knAERDWSf56JKOS3+031PaTSH5H7pVs8c2apVThhn7AcRcuyhF6AMJgWsLVXT2TD4MjujCHGb3wvA7STXG74m10Wx/wClUjArmXqpfTxYm+ZHz313jYATCYMwKCMenjV9V7OuqQwCmsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyqM01mu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3295BC2BCB2;
	Mon, 17 Nov 2025 18:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763403695;
	bh=2yisANE7qjI9IISnPxhYqY2yn6Md2ZHrrpDB3XpbIOw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eyqM01mu5dcY4s04TTk8DUmlsmv4u6ZHm/RBNirRm8y0boW4sR9zElwcCj1omt3S1
	 u254ZPzt3wE0j9af2yTywcB9CAqABXakGEUXVTc6r5WWVE9UeJh8kon2HEvuSk+WlJ
	 CJE4Q7zUsHiCYWk+dv2n1vI4l/9NFpnRM3HuomWQXlUG0XQDUe7hvXoVWKwMz+VxjM
	 tgt2SH5BYxGTxL4vUJJZbMXHUwmpYuOJfju/eJuWXW0I0gG6dFpRgLSk2Txk/MD1i6
	 E3q7/KHwXLwiWYxFyBFfNvYpIZEVlQGgkgpcrNgbfvXVDwfmJD6yqFpf1tyWSX64Ni
	 8YSo49WF6Fx6Q==
Message-ID: <5d19304ea493177c35d0ce13abe6dbf358240fa1.camel@kernel.org>
Subject: Re: [PATCH v4 2/3] locks: Threads with layout conflict must wait
 until client was fenced.
From: Jeff Layton <jlayton@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com, neilb@ownmail.net,
 	okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Date: Mon, 17 Nov 2025 13:21:32 -0500
In-Reply-To: <20251115191722.3739234-3-dai.ngo@oracle.com>
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
	 <20251115191722.3739234-3-dai.ngo@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-15 at 11:16 -0800, Dai Ngo wrote:
> If multiple threads are waiting for a layout conflict on the same
> file in __break_lease, these threads must wait until one of the
> waiting threads completes the fencing operation before proceeding.
> This ensures that I/O operations from these threads can only occurs
> after the client was fenced.
>=20
> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/locks.c               | 24 ++++++++++++++++++++++++
>  include/linux/filelock.h |  5 +++++
>  2 files changed, 29 insertions(+)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 1f254e0cd398..b6fd6aa2498c 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -191,6 +191,7 @@ locks_get_lock_context(struct inode *inode, int type)
>  	INIT_LIST_HEAD(&ctx->flc_flock);
>  	INIT_LIST_HEAD(&ctx->flc_posix);
>  	INIT_LIST_HEAD(&ctx->flc_lease);
> +	init_waitqueue_head(&ctx->flc_dispose_wait);
> =20
>  	/*
>  	 * Assign the pointer if it's not already assigned. If it is, then
> @@ -1609,6 +1610,10 @@ int __break_lease(struct inode *inode, unsigned in=
t mode, unsigned int type)
>  		error =3D -EWOULDBLOCK;
>  		goto out;
>  	}
> +	if (type =3D=3D FL_LAYOUT && !ctx->flc_conflict) {
> +		ctx->flc_conflict =3D true;
> +		ctx->flc_wait_for_dispose =3D false;
> +	}

I don't like special casing this for FL_LAYOUT leases. It seems like we
ought to be able to set up a lm_breaker_timedout operation on any sort
of lease.

> =20
>  restart:
>  	fl =3D list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list)=
;
> @@ -1640,12 +1645,31 @@ int __break_lease(struct inode *inode, unsigned i=
nt mode, unsigned int type)
>  			time_out_leases(inode, &dispose);
>  		if (any_leases_conflict(inode, new_fl))
>  			goto restart;
> +		if (type =3D=3D FL_LAYOUT && ctx->flc_wait_for_dispose) {
> +			/*
> +			 * wait for flc_wait_for_dispose to ensure
> +			 * the offending client has been fenced.
> +			 */
> +			spin_unlock(&ctx->flc_lock);
> +			wait_event_interruptible(ctx->flc_dispose_wait,
> +				ctx->flc_wait_for_dispose =3D=3D false);
> +			spin_lock(&ctx->flc_lock);
> +		}
>  		error =3D 0;
> +		if (type =3D=3D FL_LAYOUT)
> +			ctx->flc_wait_for_dispose =3D true;
>  	}
>  out:
>  	spin_unlock(&ctx->flc_lock);
>  	percpu_up_read(&file_rwsem);
>  	locks_dispose_list(&dispose);
> +	if (type =3D=3D FL_LAYOUT) {
> +		spin_lock(&ctx->flc_lock);
> +		ctx->flc_wait_for_dispose =3D false;
> +		ctx->flc_conflict =3D false;
> +		wake_up(&ctx->flc_dispose_wait);
> +		spin_unlock(&ctx->flc_lock);
> +	}
>  free_lock:
>  	locks_free_lease(new_fl);
>  	return error;
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 06ccd6b66012..5c5353aabbc8 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -146,6 +146,11 @@ struct file_lock_context {
>  	struct list_head	flc_flock;
>  	struct list_head	flc_posix;
>  	struct list_head	flc_lease;
> +
> +	/* for FL_LAYOUT */
> +	bool			flc_conflict;
> +	bool			flc_wait_for_dispose;

I'm also not a fan of this particular bool. Waiting for any
lm_breaker_timeout operations to complete seems like something we ought
to just always do. In the trivial case where we have no special fencing
to do, that should just return quickly anyway.

> +	wait_queue_head_t	flc_dispose_wait;
>  };
> =20
>  #ifdef CONFIG_FILE_LOCKING

--=20
Jeff Layton <jlayton@kernel.org>

