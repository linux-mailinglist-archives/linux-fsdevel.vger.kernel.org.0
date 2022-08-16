Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC583595E24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 16:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbiHPONV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 10:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiHPONT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:13:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D1D2F016
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 07:13:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4DDBB81A56
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 14:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DFBC433C1;
        Tue, 16 Aug 2022 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660659195;
        bh=wzJwajZsalrHDyn9kaULA3mYTI0sdKe5v/7V1b1ul3o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=s1ZO1c9ayC6vlgF+64oFj2PR38HMvmoYxHePmUhepyrCI1KIRpta99JK2AaHbdlOq
         xigqUhLi75mwccWI8djPDUAZ1zTqtN47LH2znViYYjE3w82a+5pVEUM1i30B1UuzZl
         ZR+Y7PJYqQ52VfvkxJfqRSTQFCBkngNrINI2ecYRy7MpcYT7+Z+nLlD/6uMvk0A4pv
         zgKunsGNBHofBgIt0gFeu5IrQlVAYlzm5DhQPzCgcM5GeWu/Ux5fzyV+g9JTMkPJyW
         g09XeyKc0k+5FZe5GSR/h8EI19fDNyluZqXSjeFSGI6+cu5xRbgo9qDSQYL6cPp4am
         DeZMa+e9Hp8Dw==
Message-ID: <ad29f2cb374ef5f7db731685adf25ea258414dda.camel@kernel.org>
Subject: Re: [PATCH v2] locks: fix TOCTOU race when granting write lease
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org
Date:   Tue, 16 Aug 2022 10:13:13 -0400
In-Reply-To: <20220816140818.708431-1-amir73il@gmail.com>
References: <20220816140818.708431-1-amir73il@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-08-16 at 17:08 +0300, Amir Goldstein wrote:
> Thread A trying to acquire a write lease checks the value of i_readcount
> and i_writecount in check_conflicting_open() to verify that its own fd
> is the only fd referencing the file.
>=20
> Thread B trying to open the file for read will call break_lease() in
> do_dentry_open() before incrementing i_readcount, which leaves a small
> window where thread A can acquire the write lease and then thread B
> completes the open of the file for read without breaking the write lease
> that was acquired by thread A.
>=20
> Fix this race by incrementing i_readcount before checking for existing
> leases, same as the case with i_writecount.
>=20
> Use a helper put_file_access() to decrement i_readcount or i_writecount
> in do_dentry_open() and __fput().
>=20
> Fixes: 387e3746d01c ("locks: eliminate false positive conflicts for write=
 lease")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>=20
> Hi Al,
>=20
> Per your request, here is v2 with moved helper.
>=20
> Jeff has suggested that I add kerneldoc, but I couldn't
> come up with a good description and didn't think it was very
> important, so I left it as is.
>=20


It's not terribly important.

> Thanks,
> Amir.
>=20
> Changes since v1:
> - Move helper to internal.h
>=20
>  fs/file_table.c |  7 +------
>  fs/internal.h   | 10 ++++++++++
>  fs/open.c       | 11 ++++-------
>  3 files changed, 15 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 99c6796c9f28..dd88701e54a9 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -324,12 +324,7 @@ static void __fput(struct file *file)
>  	}
>  	fops_put(file->f_op);
>  	put_pid(file->f_owner.pid);
> -	if ((mode & (FMODE_READ | FMODE_WRITE)) =3D=3D FMODE_READ)
> -		i_readcount_dec(inode);
> -	if (mode & FMODE_WRITER) {
> -		put_write_access(inode);
> -		__mnt_drop_write(mnt);
> -	}
> +	put_file_access(file);
>  	dput(dentry);
>  	if (unlikely(mode & FMODE_NEED_UNMOUNT))
>  		dissolve_on_fput(mnt);
> diff --git a/fs/internal.h b/fs/internal.h
> index 87e96b9024ce..31861e6c3eff 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -101,6 +101,16 @@ extern void chroot_fs_refs(const struct path *, cons=
t struct path *);
>  extern struct file *alloc_empty_file(int, const struct cred *);
>  extern struct file *alloc_empty_file_noaccount(int, const struct cred *)=
;
> =20
> +static inline void put_file_access(struct file *file)
> +{
> +	if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) =3D=3D FMODE_READ) {
> +		i_readcount_dec(file->f_inode);
> +	} else if (file->f_mode & FMODE_WRITER) {
> +		put_write_access(file->f_inode);
> +		__mnt_drop_write(file->f_path.mnt);
> +	}
> +}
> +
>  /*
>   * super.c
>   */
> diff --git a/fs/open.c b/fs/open.c
> index 8a813fa5ca56..a98572585815 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -840,7 +840,9 @@ static int do_dentry_open(struct file *f,
>  		return 0;
>  	}
> =20
> -	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
> +	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) =3D=3D FMODE_READ) {
> +		i_readcount_inc(inode);
> +	} else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
>  		error =3D get_write_access(inode);
>  		if (unlikely(error))
>  			goto cleanup_file;
> @@ -880,8 +882,6 @@ static int do_dentry_open(struct file *f,
>  			goto cleanup_all;
>  	}
>  	f->f_mode |=3D FMODE_OPENED;
> -	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) =3D=3D FMODE_READ)
> -		i_readcount_inc(inode);
>  	if ((f->f_mode & FMODE_READ) &&
>  	     likely(f->f_op->read || f->f_op->read_iter))
>  		f->f_mode |=3D FMODE_CAN_READ;
> @@ -935,10 +935,7 @@ static int do_dentry_open(struct file *f,
>  	if (WARN_ON_ONCE(error > 0))
>  		error =3D -EINVAL;
>  	fops_put(f->f_op);
> -	if (f->f_mode & FMODE_WRITER) {
> -		put_write_access(inode);
> -		__mnt_drop_write(f->f_path.mnt);
> -	}
> +	put_file_access(f);
>  cleanup_file:
>  	path_put(&f->f_path);
>  	f->f_path.mnt =3D NULL;

Let me know if you need me to take this via my tree. Since Al responded,
I'm assuming he'll pick this one up.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
