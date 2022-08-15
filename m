Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C3B592E15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 13:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiHOLVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 07:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242241AbiHOLVr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C801A383
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 04:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33CC36115D
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 11:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28591C433D6;
        Mon, 15 Aug 2022 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660562502;
        bh=LdLB+zNz3tDQsuKaWXbJSweBsIbxkeT7SglzG7EDYgE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=H7WpZC76LFE57kmE1crmaifeaYwlOBYrpviqtwTHcnq898YOFgZZ9JbeYkV1+MbVD
         qw5Usl1QrwXEwYRq3duZxMxDb8YcnihUfEwx7UbVX8HQo73hcj4+VEd2357kvUDOAw
         QJe/wm/BgJHi6qgIa54qp5NBEBhrPwRKWDtPBE7racHJYg2R1txNzQ87rJuiosgMVe
         nZQMhDwcEmYxwVMvIBfWfId+PeYYZdQE8CkMwB5KNDGnEYv1NhYfQaz8+OAS4PzugG
         j/dTr1WMIlKbkvjCsyA2gi9hoxAVoJGIVwqEJRx+zy/zu84oI9OWj3+XS+bQ/WUH9Z
         rOpfarUNianRg==
Message-ID: <d910e1ef7c8fcf65fbdb0bc438ebba2d7a1d6f83.camel@kernel.org>
Subject: Re: [PATCH] locks: fix TOCTOU race when granting write lease
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 15 Aug 2022 07:21:40 -0400
In-Reply-To: <20220814152322.569296-1-amir73il@gmail.com>
References: <20220814152322.569296-1-amir73il@gmail.com>
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

On Sun, 2022-08-14 at 18:23 +0300, Amir Goldstein wrote:
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

Nice catch.

> Use a helper put_file_access() to decrement i_readcount or i_writecount
> in do_dentry_open() and __fput().
>=20
> Fixes: 387e3746d01c ("locks: eliminate false positive conflicts for write=
 lease")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>=20
> Hi Jeff,
>=20
> This fixes a race I found during code audit - I do not have a reproducer
> for it.
>=20
> I ran the fstests I found for locks and leases:
> generic/131 generic/478 generic/504 generic/571
> and the LTP fcntl tests.
>=20
> Encountered this warning with generic/131, but I also see it on
> current master:
>=20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: suspicious RCU usage
>  5.19.0-xfstests-14277-gbd6ab3ef4e93 #966 Not tainted
>  -----------------------------
>  include/net/sock.h:592 suspicious rcu_dereference_check() usage!
>=20
>  other info that might help us debug this:
>=20
>=20
>  rcu_scheduler_active =3D 2, debug_locks =3D 1
>  5 locks held by locktest/3996:
>   #0: ffff88800be1d7a0 (&sb->s_type->i_mutex_key#8){+.+.}-{3:3}, at: __so=
ck_release+0x25/0x97
>   #1: ffff88800909ce00 (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_close+0x14/=
0x60
>   #2: ffff888006847cc8 (&h->lhash2[i].lock){+.+.}-{2:2}, at: inet_unhash+=
0x3a/0xcf
>   #3: ffffffff82a8ac18 (reuseport_lock){+...}-{2:2}, at: reuseport_detach=
_sock+0x17/0xb8
>   #4: ffff88800909d0b0 (clock-AF_INET){++..}-{2:2}, at: bpf_sk_reuseport_=
detach+0x1b/0x85
>=20
>  stack backtrace:
>  CPU: 1 PID: 3996 Comm: locktest Not tainted 5.19.0-xfstests-14277-gbd6ab=
3ef4e93 #966
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubun=
tu1.1 04/01/2014
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x45/0x5d
>   bpf_sk_reuseport_detach+0x5c/0x85
>   reuseport_detach_sock+0x65/0xb8
>   inet_unhash+0x55/0xcf
>   tcp_set_state+0xb3/0x10d
>   ? mark_lock.part.0+0x30/0x101
>   __tcp_close+0x26/0x32d
>   tcp_close+0x20/0x60
>   inet_release+0x50/0x64
>   __sock_release+0x32/0x97
>   sock_close+0x14/0x1b
>   __fput+0x118/0x1eb
>=20
>=20
> Let me know what you think.
>=20
> Thanks,
> Amir.
>=20
>  fs/file_table.c    |  7 +------
>  fs/open.c          | 11 ++++-------
>  include/linux/fs.h | 10 ++++++++++
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
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9eced4cc286e..8bc04852c3da 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3000,6 +3000,16 @@ static inline void i_readcount_inc(struct inode *i=
node)
>  	return;
>  }
>  #endif
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
>  extern int do_pipe_flags(int *, int);
> =20
>  extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);

Looks good to me. I like the new helper.

In addition to Al's comment about which header this should go in, it
might also be good to put a kerneldoc comment over it.

Al, did you want to take this via your tree or do you want me to take it
via the filelocks tree?

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
