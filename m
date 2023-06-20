Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481D17369C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 12:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjFTKq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 06:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjFTKqz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C351A8;
        Tue, 20 Jun 2023 03:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6656E61027;
        Tue, 20 Jun 2023 10:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB50C433C8;
        Tue, 20 Jun 2023 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687258012;
        bh=lWjifKf2FqCNvCK8X0R9it3LY9aiFl5yBJrM3U6vEDA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DFbs4vp/37QViUs9RoMT1km2vJ8Au8sNPfqXgC7CadroS7dk/qWbnDACJwMpRwYPc
         AOUCi19c2ntjTvizNCoeKVYwF6rukjBReVBWC02Y7UIu/JNqG/Dvx2zIZuO/y7oXc+
         IOpQn3y2Dxf9lZ1puT7RfRXHkG7yJHxCkDa8tqGYk4MKHzXCPUXFsYsurgTH6hR3Ws
         OrWCZ4u5LZa3QVdFBCEUsVhqBOqgZccDgW4XgQrI6A9qgfaNNn87vjq+xBFul/G3Qr
         x4LTpDKdXC2PPhs2G1hVg4eBcSCcFdcuuAyCncneQ3WO8xOWXwvOtv+7NiK+XyduBd
         Ii8Ii2LxYs5gA==
Message-ID: <c6d4e620cad72da5f85df03443a64747b5719939.camel@kernel.org>
Subject: Re: [PATCH 1/3] fs/locks: F_UNLCK extension for F_OFD_GETLK
From:   Jeff Layton <jlayton@kernel.org>
To:     Stas Sergeev <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 20 Jun 2023 06:46:50 -0400
In-Reply-To: <20230620095507.2677463-2-stsp2@yandex.ru>
References: <20230620095507.2677463-1-stsp2@yandex.ru>
         <20230620095507.2677463-2-stsp2@yandex.ru>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-06-20 at 14:55 +0500, Stas Sergeev wrote:
> Currently F_UNLCK with F_OFD_GETLK returns -EINVAL.
> The proposed extension allows to use it for getting the lock
> information from the particular fd.
>=20
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
>=20
> CC: Jeff Layton <jlayton@kernel.org>
> CC: Chuck Lever <chuck.lever@oracle.com>
> CC: Alexander Viro <viro@zeniv.linux.org.uk>
> CC: Christian Brauner <brauner@kernel.org>
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
>=20
> ---
>  fs/locks.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index df8b26a42524..210766007e63 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -868,6 +868,21 @@ static bool posix_locks_conflict(struct file_lock *c=
aller_fl,
>  	return locks_conflict(caller_fl, sys_fl);
>  }
> =20
> +/* Determine if lock sys_fl blocks lock caller_fl. Used on xx_GETLK
> + * path so checks for additional GETLK-specific things like F_UNLCK.
> + */
> +static bool posix_test_locks_conflict(struct file_lock *caller_fl,
> +				      struct file_lock *sys_fl)
> +{
> +	/* F_UNLCK checks any locks on the same fd. */
> +	if (caller_fl->fl_type =3D=3D F_UNLCK) {
> +		if (!posix_same_owner(caller_fl, sys_fl))
> +			return false;
> +		return locks_overlap(caller_fl, sys_fl);
> +	}
> +	return posix_locks_conflict(caller_fl, sys_fl);
> +}
> +
>  /* Determine if lock sys_fl blocks lock caller_fl. FLOCK specific
>   * checking before calling the locks_conflict().
>   */
> @@ -901,7 +916,7 @@ posix_test_lock(struct file *filp, struct file_lock *=
fl)
>  retry:
>  	spin_lock(&ctx->flc_lock);
>  	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
> -		if (!posix_locks_conflict(fl, cfl))
> +		if (!posix_test_locks_conflict(fl, cfl))
>  			continue;
>  		if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_expirable
>  			&& (*cfl->fl_lmops->lm_lock_expirable)(cfl)) {
> @@ -2207,7 +2222,8 @@ int fcntl_getlk(struct file *filp, unsigned int cmd=
, struct flock *flock)
>  	if (fl =3D=3D NULL)
>  		return -ENOMEM;
>  	error =3D -EINVAL;
> -	if (flock->l_type !=3D F_RDLCK && flock->l_type !=3D F_WRLCK)
> +	if (cmd !=3D F_OFD_GETLK && flock->l_type !=3D F_RDLCK
> +			&& flock->l_type !=3D F_WRLCK)
>  		goto out;
> =20
>  	error =3D flock_to_posix_lock(filp, fl, flock);
> @@ -2414,7 +2430,8 @@ int fcntl_getlk64(struct file *filp, unsigned int c=
md, struct flock64 *flock)
>  		return -ENOMEM;
> =20
>  	error =3D -EINVAL;
> -	if (flock->l_type !=3D F_RDLCK && flock->l_type !=3D F_WRLCK)
> +	if (cmd !=3D F_OFD_GETLK && flock->l_type !=3D F_RDLCK
> +			&& flock->l_type !=3D F_WRLCK)
>  		goto out;
> =20
>  	error =3D flock64_to_posix_lock(filp, fl, flock);

This seems like a reasonable sort of interface to add, particularly for
the CRIU case. Using F_UNLCK for this is a bit kludgey, but adding a new
constant is probably worse.

I'm willing to take this in with an eye toward v6.6. Are you also
willing to draft up some manpage patches that detail this new interface?

--=20
Jeff Layton <jlayton@kernel.org>
