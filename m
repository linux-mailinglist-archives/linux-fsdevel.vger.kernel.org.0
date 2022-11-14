Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A736289A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 20:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbiKNTqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 14:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiKNTql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:46:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F2418B21;
        Mon, 14 Nov 2022 11:46:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB0CCB81212;
        Mon, 14 Nov 2022 19:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2333FC433C1;
        Mon, 14 Nov 2022 19:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668455197;
        bh=PDwQX/Z2EUfB/RVRwN2u27UcRNLUBKMGkiODEqFLrnI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S3vDKpqp3uvyeHOdYB5vClJflLN+ve+/c4TRByJ1UeyJIKTGSeX11IImNSGh2BlLH
         eZYiYI38AQuue/ASh/yJoKAsowzpG2plqFgYpR8UrnQBh6VDeKzoAgj6IgGUE3GBJ4
         ZQRpwJZeK4y7Mcij+kaRMyfSQ6BEuGY9g/D7fUUTkdhZOAs/e7QB9Pd3A1A98thmIV
         RMPvD4xpp/ItP2CJ2tYCngNVhiv/9jzuxos5HvQiHnPzJ9LnOdNWo9QBGBJfyBraWh
         kMs39/5UJY9z1bh2gIpTpoPVJ3GFG0OvAhpaZYsZTIWOl1DjVHvWHiKyHAT1TPTyL3
         MJfS5RZ8M5gWA==
Message-ID: <30355bc8aa4998cb48b34df958837a8f818ceeb0.camel@kernel.org>
Subject: Re: [RFC PATCH] filelock: new helper: vfs_file_has_locks
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com, xiubli@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Date:   Mon, 14 Nov 2022 14:46:35 -0500
In-Reply-To: <20221114140747.134928-1-jlayton@kernel.org>
References: <20221114140747.134928-1-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-11-14 at 09:07 -0500, Jeff Layton wrote:
> Ceph has a need to know whether a particular file has any locks set on
> it. It's currently tracking that by a num_locks field in its
> filp->private_data, but that's problematic as it tries to decrement this
> field when releasing locks and that can race with the file being torn
> down.
>=20
> Add a new vfs_file_has_locks helper that will scan the flock and posix
> lists, and return true if any of the locks have a fl_file that matches
> the given one. Ceph can then call this instead of doing its own
> tracking.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/locks.c         | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  1 +
>  2 files changed, 37 insertions(+)
>=20
> Xiubo,
>=20
> Here's what I was thinking instead of trying to track this within ceph.
> Most inodes never have locks set, so in most cases this will be a NULL
> pointer check.
>=20
>=20
>=20

I went ahead and added a slightly updated version of this this to my
locks-next branch for now, but...

Thinking about this more...I'm not sure this whole concept of what the
ceph code is trying to do makes sense. Locks only conflict if they have
different owners, and POSIX locks are owned by the process. Consider
this scenario (obviously, this is not a problem with OFD locks).

A process has the same file open via two different fds. It sets lock A
from offset 0..9 via fd 1. Now, same process sets lock B from 10..19 via
fd 2. The two locks will be merged, because they don't conflict (because
it's the same process).

Against which fd should the merged lock record be counted?

Would it be better to always check for CEPH_I_ERROR_FILELOCK, even when
the fd hasn't had any locks explicitly set on it?

> diff --git a/fs/locks.c b/fs/locks.c
> index 5876c8ff0edc..c7f903b63a53 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2672,6 +2672,42 @@ int vfs_cancel_lock(struct file *filp, struct file=
_lock *fl)
>  }
>  EXPORT_SYMBOL_GPL(vfs_cancel_lock);
> =20
> +/**
> + * vfs_file_has_locks - are any locks held that were set on @filp?
> + * @filp: open file to check for locks
> + *
> + * Return true if are any FL_POSIX or FL_FLOCK locks currently held
> + * on @filp.
> + */
> +bool vfs_file_has_locks(struct file *filp)
> +{
> +	struct file_lock_context *ctx;
> +	struct file_lock *fl;
> +	bool ret =3D false;
> +
> +	ctx =3D smp_load_acquire(&locks_inode(filp)->i_flctx);
> +	if (!ctx)
> +		return false;
> +
> +	spin_lock(&ctx->flc_lock);
> +	list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> +		if (fl->fl_file =3D=3D filp) {
> +			ret =3D true;
> +			goto out;
> +		}
> +	}
> +	list_for_each_entry(fl, &ctx->flc_flock, fl_list) {
> +		if (fl->fl_file =3D=3D filp) {
> +			ret =3D true;
> +			break;
> +		}
> +	}
> +out:
> +	spin_unlock(&ctx->flc_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(vfs_file_has_locks);
> +
>  #ifdef CONFIG_PROC_FS
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e654435f1651..e4d0f1fa7f9f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1170,6 +1170,7 @@ extern int locks_delete_block(struct file_lock *);
>  extern int vfs_test_lock(struct file *, struct file_lock *);
>  extern int vfs_lock_file(struct file *, unsigned int, struct file_lock *=
, struct file_lock *);
>  extern int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
> +bool vfs_file_has_locks(struct file *file);
>  extern int locks_lock_inode_wait(struct inode *inode, struct file_lock *=
fl);
>  extern int __break_lease(struct inode *inode, unsigned int flags, unsign=
ed int type);
>  extern void lease_get_mtime(struct inode *, struct timespec64 *time);

--=20
Jeff Layton <jlayton@kernel.org>
