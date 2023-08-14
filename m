Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3849F77B08C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 06:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjHNEla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 00:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjHNElG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 00:41:06 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050:0:465::103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0142A124;
        Sun, 13 Aug 2023 21:41:02 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RPMCv0pvGz9sSv;
        Mon, 14 Aug 2023 06:40:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1691988059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=43qZRKeOym7Zpe2Q8XPFRWz1J2Nsc1q3BwFZXLvbbTU=;
        b=0WRQ2O3ewN0V7ngvtzrGr+fcmi/f3pDl0hUSuJ7H11V570fB914kot19+TJllzIHAr+W+2
        tYAuXzN+VQ9jRY5pERWTKprXrbgh59/tuoH0PyV0nd/lZcNwJUCLc6Gso5rQsW0fkCjU2P
        /HmJ9CIYzdLXfRrTHofLQhDlD3jzwsN5qX1ODOSnPTcc0mp71h9QH+yW4dKttvu4EO5udX
        hlF1woxcFtfTv6/ATl0gI73oosJMYMW9LvSIPEDnGjCC7PmTh5uByZmkpMAyUdGACDTEdE
        zuGTT+ZoBUSnrEL9eLXOZkQjQKD5FvsmrRYIXx0JFBN0kIauVTmKatKfESIoBw==
Date:   Mon, 14 Aug 2023 14:40:45 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 2/3] fs: Allow user to lock mount attributes with
 mount_setattr
Message-ID: <20230811.020617-buttery.agate.grand.surgery-EoCrXfehGJ8@cyphar.com>
References: <20230810090044.1252084-1-sargun@sargun.me>
 <20230810090044.1252084-2-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pvl3yxq3ubgyqshu"
Content-Disposition: inline
In-Reply-To: <20230810090044.1252084-2-sargun@sargun.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--pvl3yxq3ubgyqshu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-08-10, Sargun Dhillon <sargun@sargun.me> wrote:
> We support locking certain mount attributes in the kernel. This API
> isn't directly exposed to users. Right now, users can lock mount
> attributes by going through the process of creating a new user
> namespaces, and when the mounts are copied to the "lower privilege"
> domain, they're locked. The mount can be reopened, and passed around
> as a "locked mount".
>=20
> Locked mounts are useful, for example, in container execution without
> user namespaces, where you may want to expose some host data as read
> only without allowing the container to remount the mount as mutable.
>=20
> The API currently requires that the given privilege is taken away
> while or before locking the flag in the less privileged position.
> This could be relaxed in the future, where the user is allowed to
> remount the mount as read only, but once they do, they cannot make
> it read only again.
>=20
> Right now, this allows for all flags that are lockable via the
> userns unshare trick to be locked, other than the atime related
> ones. This is because the semantics of what the "less privileged"
> position is around the atime flags is unclear.
>=20
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  fs/namespace.c             | 40 +++++++++++++++++++++++++++++++++++---
>  include/uapi/linux/mount.h |  2 ++
>  2 files changed, 39 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 54847db5b819..5396e544ac84 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -78,6 +78,7 @@ static LIST_HEAD(ex_mountpoints); /* protected by names=
pace_sem */
>  struct mount_kattr {
>  	unsigned int attr_set;
>  	unsigned int attr_clr;
> +	unsigned int attr_lock;
>  	unsigned int propagation;
>  	unsigned int lookup_flags;
>  	bool recurse;
> @@ -3608,6 +3609,9 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, cha=
r __user *, dir_name,
> =20
>  #define MOUNT_SETATTR_PROPAGATION_FLAGS \
>  	(MS_UNBINDABLE | MS_PRIVATE | MS_SLAVE | MS_SHARED)
> +#define MOUNT_SETATTR_VALID_LOCK_FLAGS					       \
> +	(MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV |	       \
> +	 MOUNT_ATTR_NOEXEC)
> =20
>  static unsigned int attr_flags_to_mnt_flags(u64 attr_flags)
>  {
> @@ -3629,6 +3633,22 @@ static unsigned int attr_flags_to_mnt_flags(u64 at=
tr_flags)
>  	return mnt_flags;
>  }
> =20
> +static unsigned int attr_flags_to_mnt_lock_flags(u64 attr_flags)
> +{
> +	unsigned int mnt_flags =3D 0;
> +
> +	if (attr_flags & MOUNT_ATTR_RDONLY)
> +		mnt_flags |=3D MNT_LOCK_READONLY;
> +	if (attr_flags & MOUNT_ATTR_NOSUID)
> +		mnt_flags |=3D MNT_LOCK_NOSUID;
> +	if (attr_flags & MOUNT_ATTR_NODEV)
> +		mnt_flags |=3D MNT_LOCK_NODEV;
> +	if (attr_flags & MOUNT_ATTR_NOEXEC)
> +		mnt_flags |=3D MNT_LOCK_NOEXEC;
> +
> +	return mnt_flags;
> +}
> +
>  /*
>   * Create a kernel mount representation for a new, prepared superblock
>   * (specified by fs_fd) and attach to an open_tree-like file descriptor.
> @@ -4037,11 +4057,18 @@ static int mount_setattr_prepare(struct mount_kat=
tr *kattr, struct mount *mnt)
>  	int err;
> =20
>  	for (m =3D mnt; m; m =3D next_mnt(m, mnt)) {
> -		if (!can_change_locked_flags(m, recalc_flags(kattr, m))) {
> +		int new_mount_flags =3D recalc_flags(kattr, m);
> +
> +		if (!can_change_locked_flags(m, new_mount_flags)) {
>  			err =3D -EPERM;
>  			break;
>  		}

It just occurred to me that the whole MNT_LOCK_* machinery has the
unfortunate consequence of restricting the host root user from being
able to modify the locked flags. Since this change will let you do this
without creating a userns, do we want to make can_change_locked_flags()
do capable(CAP_SYS_MOUNT)?

> +		if ((new_mount_flags & kattr->attr_lock) !=3D kattr->attr_lock) {
> +			err =3D -EINVAL;
> +			break;
> +		}

Since the MNT_LOCK_* flags are invisible to userspace, it seems more
reasonable to have the attr_lock set be added to the existing set rather
than requiring userspace to pass the same set of flags.

Actually, AFAICS this implementation breaks backwards compatibility
because with this change you now need to pass MNT_LOCK_* flags if
operating on a mount that has locks applied already. So existing
programs (which have .attr_lock=3D0) will start getting -EINVAL when
operating on mounts with locked flags (such as those locked in the
userns case). Or am I missing something?

In any case, the most reasonable behaviour would be to OR the requested
lock flags with the existing ones IMHO.

> +
>  		err =3D can_idmap_mount(kattr, m);
>  		if (err)
>  			break;
> @@ -4278,8 +4305,14 @@ static int build_mount_kattr(const struct mount_at=
tr *attr, size_t usize,
>  	if ((attr->attr_set | attr->attr_clr) & ~MOUNT_SETATTR_VALID_FLAGS)
>  		return -EINVAL;
> =20
> +	if (attr->attr_lock & ~MOUNT_SETATTR_VALID_LOCK_FLAGS)
> +		return -EINVAL;
> +
>  	kattr->attr_set =3D attr_flags_to_mnt_flags(attr->attr_set);
>  	kattr->attr_clr =3D attr_flags_to_mnt_flags(attr->attr_clr);
> +	kattr->attr_lock =3D attr_flags_to_mnt_flags(attr->attr_lock);
> +	kattr->attr_set |=3D attr_flags_to_mnt_lock_flags(attr->attr_lock);
> +
> =20
>  	/*
>  	 * Since the MOUNT_ATTR_<atime> values are an enum, not a bitmap,
> @@ -4337,7 +4370,7 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char=
 __user *, path,
>  	struct mount_attr attr;
>  	struct mount_kattr kattr;
> =20
> -	BUILD_BUG_ON(sizeof(struct mount_attr) !=3D MOUNT_ATTR_SIZE_VER0);
> +	BUILD_BUG_ON(sizeof(struct mount_attr) !=3D MOUNT_ATTR_SIZE_VER1);
> =20
>  	if (flags & ~(AT_EMPTY_PATH |
>  		      AT_RECURSIVE |
> @@ -4360,7 +4393,8 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char=
 __user *, path,
>  	/* Don't bother walking through the mounts if this is a nop. */
>  	if (attr.attr_set =3D=3D 0 &&
>  	    attr.attr_clr =3D=3D 0 &&
> -	    attr.propagation =3D=3D 0)
> +	    attr.propagation =3D=3D 0 &&
> +	    attr.attr_lock =3D=3D 0)
>  		return 0;
> =20
>  	err =3D build_mount_kattr(&attr, usize, &kattr, flags);
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 4d93967f8aea..de667c4f852d 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -131,9 +131,11 @@ struct mount_attr {
>  	__u64 attr_clr;
>  	__u64 propagation;
>  	__u64 userns_fd;
> +	__u64 attr_lock;
>  };
> =20
>  /* List of all mount_attr versions. */
>  #define MOUNT_ATTR_SIZE_VER0	32 /* sizeof first published struct */
> +#define MOUNT_ATTR_SIZE_VER1	40
> =20
>  #endif /* _UAPI_LINUX_MOUNT_H */
> --=20
> 2.39.3
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--pvl3yxq3ubgyqshu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZNmwTQAKCRAol/rSt+lE
b85YAQDCnQlmH7d6dEvOZMf3JSIZKFpQVLCR+ASroHQvguYPoAEAowEiZ5CJ3XBX
+HTHXHI2gxuzKXcmu1ty4O/5XcsSpQ0=
=uEdy
-----END PGP SIGNATURE-----

--pvl3yxq3ubgyqshu--
