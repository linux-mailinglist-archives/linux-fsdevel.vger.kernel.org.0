Return-Path: <linux-fsdevel+bounces-25911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEB0951A86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 14:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EC41F235EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 12:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AEB1AE847;
	Wed, 14 Aug 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZmb8Zwr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBBE13D51D;
	Wed, 14 Aug 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637044; cv=none; b=SyidQ3BzYjwgVmIKIOUpLokOYgIpUIp9ksEyLgzY1S4RFtnfyASKl1YtNcYAWobSrqsa1pfa76seg2wv2xk08ziugeBOdKduYBRDWC/ZqSEtIN+8H76G4f7+D+OR9rOJ7KKk0IgxmwTHzDLYppIv+U7CwBI14qzwhpoclneRCbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637044; c=relaxed/simple;
	bh=mJC8bfWvfQg78Ul16meJjJNrey0FbR5OLBUbT9IBlSk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nu/wNNKVkV9zPQ4hA89Q3oiui6UYwZW0g/auYUx8msEmwLYE552lvJ3FhlCXzTg0NXPZzEOlbKJYtBt7CuV4t1y3Zyf+NKrvV74mG4pWEhqW6CM4FhWL/IVbB7nVBdA3khIkD6kf28ixUt6E1HygwsTyRdUNEp8r6pZH2WaxXA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZmb8Zwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26553C32786;
	Wed, 14 Aug 2024 12:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723637043;
	bh=mJC8bfWvfQg78Ul16meJjJNrey0FbR5OLBUbT9IBlSk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bZmb8ZwrWeaXVp7db4gu2xjMfPYfB0Cytp+1K78HhDjsw3/QWCQLDZmOWBuztkoNS
	 ubFsmkjzXRFXwkIe1m1HuqrMPe9sYap17TRSoGSCMG98SedWeQB0yDb8EAIvMKLFAy
	 7uxCGZHLl9td2hERJrL9BHnG1JhBeyj+clz4pw4bsRUdCrlH/MTYzr/pOKN5zbqlEn
	 oKKuK2C1N/rmhJL38ZBGbdCMKFduhVBNY8SExl31Xe24eFDfrEFURdwj/+/Guqku/W
	 bs3xnLFfy1egAuXP9WeRN54xSf6z5KnGa05WZ58LfFVFln0ZFnmDaIdrod8prpcWNW
	 tOUEuBWK0wdZg==
Message-ID: <4244e028b15819c0149c8f0395d28abcd1da01e4.camel@kernel.org>
Subject: Re: [PATCH] vfs: drop one lock trip in evict()
From: Jeff Layton <jlayton@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Date: Wed, 14 Aug 2024 08:04:01 -0400
In-Reply-To: <20240813143626.1573445-1-mjguzik@gmail.com>
References: <20240813143626.1573445-1-mjguzik@gmail.com>
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

On Tue, 2024-08-13 at 16:36 +0200, Mateusz Guzik wrote:
> Most commonly neither I_LRU_ISOLATING nor I_SYNC are set, but the stock
> kernel takes a back-to-back relock trip to check for them.
>=20
> It probably can be avoided altogether, but for now massage things back
> to just one lock acquire.
>=20
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>=20
> there are smp_mb's in the area I'm going to look at removing at some
> point(tm), in the meantime I think this is an easy cleanup
>=20
> has a side effect of whacking a inode_wait_for_writeback which was only
> there to deal with not holding the lock
>=20
>  fs/fs-writeback.c | 17 +++--------------
>  fs/inode.c        |  5 +++--
>  2 files changed, 6 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 4451ecff37c4..1a5006329f6f 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1510,13 +1510,12 @@ static int write_inode(struct inode *inode, struc=
t writeback_control *wbc)
>   * Wait for writeback on an inode to complete. Called with i_lock held.
>   * Caller must make sure inode cannot go away when we drop i_lock.
>   */
> -static void __inode_wait_for_writeback(struct inode *inode)
> -	__releases(inode->i_lock)
> -	__acquires(inode->i_lock)
> +void inode_wait_for_writeback(struct inode *inode)
>  {
>  	DEFINE_WAIT_BIT(wq, &inode->i_state, __I_SYNC);
>  	wait_queue_head_t *wqh;
> =20
> +	lockdep_assert_held(&inode->i_lock);
>  	wqh =3D bit_waitqueue(&inode->i_state, __I_SYNC);
>  	while (inode->i_state & I_SYNC) {
>  		spin_unlock(&inode->i_lock);
> @@ -1526,16 +1525,6 @@ static void __inode_wait_for_writeback(struct inod=
e *inode)
>  	}
>  }
> =20
> -/*
> - * Wait for writeback on an inode to complete. Caller must have inode pi=
nned.
> - */
> -void inode_wait_for_writeback(struct inode *inode)
> -{
> -	spin_lock(&inode->i_lock);
> -	__inode_wait_for_writeback(inode);
> -	spin_unlock(&inode->i_lock);
> -}
> -
>  /*
>   * Sleep until I_SYNC is cleared. This function must be called with i_lo=
ck
>   * held and drops it. It is aimed for callers not holding any inode refe=
rence
> @@ -1757,7 +1746,7 @@ static int writeback_single_inode(struct inode *ino=
de,
>  		 */
>  		if (wbc->sync_mode !=3D WB_SYNC_ALL)
>  			goto out;
> -		__inode_wait_for_writeback(inode);
> +		inode_wait_for_writeback(inode);
>  	}
>  	WARN_ON(inode->i_state & I_SYNC);
>  	/*
> diff --git a/fs/inode.c b/fs/inode.c
> index 73183a499b1c..d48d29d39cd2 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -582,7 +582,7 @@ static void inode_unpin_lru_isolating(struct inode *i=
node)
> =20
>  static void inode_wait_for_lru_isolating(struct inode *inode)
>  {
> -	spin_lock(&inode->i_lock);
> +	lockdep_assert_held(&inode->i_lock);
>  	if (inode->i_state & I_LRU_ISOLATING) {
>  		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
>  		wait_queue_head_t *wqh;
> @@ -593,7 +593,6 @@ static void inode_wait_for_lru_isolating(struct inode=
 *inode)
>  		spin_lock(&inode->i_lock);
>  		WARN_ON(inode->i_state & I_LRU_ISOLATING);
>  	}
> -	spin_unlock(&inode->i_lock);
>  }
> =20
>  /**
> @@ -765,6 +764,7 @@ static void evict(struct inode *inode)
> =20
>  	inode_sb_list_del(inode);
> =20
> +	spin_lock(&inode->i_lock);
>  	inode_wait_for_lru_isolating(inode);
> =20
>  	/*
> @@ -774,6 +774,7 @@ static void evict(struct inode *inode)
>  	 * the inode.  We just have to wait for running writeback to finish.
>  	 */
>  	inode_wait_for_writeback(inode);
> +	spin_unlock(&inode->i_lock);
> =20
>  	if (op->evict_inode) {
>  		op->evict_inode(inode);

...and a nice cleanup to boot.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

