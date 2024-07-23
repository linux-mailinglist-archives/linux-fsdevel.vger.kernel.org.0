Return-Path: <linux-fsdevel+bounces-24146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A157493A401
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 17:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2CA1F245D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A0F15748E;
	Tue, 23 Jul 2024 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTwjMndw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB01534FB;
	Tue, 23 Jul 2024 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749841; cv=none; b=fwsDoMzwuKyjgNEEBD6Z3wqKKy9JyK8qdUllAtXV2XgWxqF8RCosgDt7ywCZG9n8G4FrH50OFntEOvi292lOBsVaqh5Okj4qtL8c0o5y+EGNsowsFpaH2yoKP41WT3LbofjxpUFnOGcLkI1lnFnXRkEAneF6ayJdB1XlC5/Uyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749841; c=relaxed/simple;
	bh=TnGMsrJ4pto9VumueOBg6ah9e5LJdE4tr9oJecz4Ptg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JwkDoDK2u9vDojfpn2oE1da4RChHmTCakOQoKXpt/m0VJUgAwPMnFLAPx9+WcXouCkMkxO6DojyoyADTwOWt+K4GjRDQN0sdOtGqb7L2UQXjQEm4+RsZdIqko5E93vsvh8REuxf0cBSbm6hu/y16DC0EGF2wfgLXVozdlWP4YJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTwjMndw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7EAC4AF0E;
	Tue, 23 Jul 2024 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721749841;
	bh=TnGMsrJ4pto9VumueOBg6ah9e5LJdE4tr9oJecz4Ptg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=oTwjMndwy4XRxPmDNLdjyU0pGmn1DtwsL+TZCskHHCJ6XDLRUVhrBn+HLAA5GXf7M
	 f/SW0AsP9rxp0Fsm2jBgQIG3jmoxx2D1oEFadCmMSououeezWNYb0nwIWFINKteTgc
	 1FnKFuPCvEzAeFF38xLB6AqXBZzIdjCcfqY6UxA5AAb+oXjHFMKbkfWUOi1SMfQbV6
	 i+01PC2rwajbj8osUZey5bkN4j7uU9XXUFNPt+hFWPYBlWYoYfAB/R+ANhQyRGp175
	 UGnyxA11PcBezhTv6GNdCPmG8JrF5f6b6ythiGmUOxkZK7YGXWYjoDca+P7ago3q4G
	 ggYZls6eAK2wg==
Message-ID: <0616b6be151e2063627fb7f22100b9d3407aceb3.camel@kernel.org>
Subject: Re: [PATCH] filelock: Fix fcntl/close race recovery compat path
From: Jeff Layton <jlayton@kernel.org>
To: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner
	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever
	 <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@kernel.org
Date: Tue, 23 Jul 2024 11:50:37 -0400
In-Reply-To: <20240723-fs-lock-recover-compatfix-v1-1-148096719529@google.com>
References: 
	<20240723-fs-lock-recover-compatfix-v1-1-148096719529@google.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-23 at 17:03 +0200, Jann Horn wrote:
> When I wrote commit 3cad1bc01041 ("filelock: Remove locks reliably when
> fcntl/close race is detected"), I missed that there are two copies of the
> code I was patching: The normal version, and the version for 64-bit offse=
ts
> on 32-bit kernels.
> Thanks to Greg KH for stumbling over this while doing the stable
> backport...
>=20
> Apply exactly the same fix to the compat path for 32-bit kernels.
>=20
> Fixes: c293621bbf67 ("[PATCH] stale POSIX lock handling")
> Cc: stable@kernel.org
> Link: https://bugs.chromium.org/p/project-zero/issues/detail?id=3D2563
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> =C2=A0fs/locks.c | 9 ++++-----
> =C2=A01 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index bdd94c32256f..9afb16e0683f 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2570,8 +2570,9 @@ int fcntl_setlk64(unsigned int fd, struct file *fil=
p, unsigned int cmd,
> =C2=A0	error =3D do_lock_file_wait(filp, cmd, file_lock);
> =C2=A0
> =C2=A0	/*
> -	 * Attempt to detect a close/fcntl race and recover by releasing the
> -	 * lock that was just acquired. There is no need to do that when we're
> +	 * Detect close/fcntl races and recover by zapping all POSIX locks
> +	 * associated with this file and our files_struct, just like on
> +	 * filp_flush(). There is no need to do that when we're
> =C2=A0	 * unlocking though, or for OFD locks.
> =C2=A0	 */
> =C2=A0	if (!error && file_lock->c.flc_type !=3D F_UNLCK &&
> @@ -2586,9 +2587,7 @@ int fcntl_setlk64(unsigned int fd, struct file *fil=
p, unsigned int cmd,
> =C2=A0		f =3D files_lookup_fd_locked(files, fd);
> =C2=A0		spin_unlock(&files->file_lock);
> =C2=A0		if (f !=3D filp) {
> -			file_lock->c.flc_type =3D F_UNLCK;
> -			error =3D do_lock_file_wait(filp, cmd, file_lock);
> -			WARN_ON_ONCE(error);
> +			locks_remove_posix(filp, files);
> =C2=A0			error =3D -EBADF;
> =C2=A0		}
> =C2=A0	}
>=20
> ---
> base-commit: 66ebbdfdeb093e097399b1883390079cd4c3022b
> change-id: 20240723-fs-lock-recover-compatfix-cf2cbab343d1

Doh! Good catch.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

