Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21592423D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 03:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgHLBno (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 21:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgHLBno (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:43:44 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E1EC06174A;
        Tue, 11 Aug 2020 18:43:44 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4BRCCc5sllzKmjr;
        Wed, 12 Aug 2020 03:43:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id MgTaKt_bYsTh; Wed, 12 Aug 2020 03:43:36 +0200 (CEST)
Date:   Wed, 12 Aug 2020 11:43:24 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org,
        Mattias Nissler <mnissler@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>,
        Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH v7] Add a "nosymfollow" mount option.
Message-ID: <20200812014324.rtvlhvopifgkw4mi@yavin.dot.cyphar.com>
References: <20200811222803.3224434-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cin4lu5msomn5ja6"
Content-Disposition: inline
In-Reply-To: <20200811222803.3224434-1-zwisler@google.com>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -10.21 / 15.00 / 15.00
X-Rspamd-Queue-Id: 30C491816
X-Rspamd-UID: 9b5518
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--cin4lu5msomn5ja6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-11, Ross Zwisler <zwisler@chromium.org> wrote:
> From: Mattias Nissler <mnissler@chromium.org>
>=20
> For mounts that have the new "nosymfollow" option, don't follow symlinks
> when resolving paths. The new option is similar in spirit to the
> existing "nodev", "noexec", and "nosuid" options, as well as to the
> LOOKUP_NO_SYMLINKS resolve flag in the openat2(2) syscall. Various BSD
> variants have been supporting the "nosymfollow" mount option for a long
> time with equivalent implementations.
>=20
> Note that symlinks may still be created on file systems mounted with
> the "nosymfollow" option present. readlink() remains functional, so
> user space code that is aware of symlinks can still choose to follow
> them explicitly.
>=20
> Setting the "nosymfollow" mount option helps prevent privileged
> writers from modifying files unintentionally in case there is an
> unexpected link along the accessed path. The "nosymfollow" option is
> thus useful as a defensive measure for systems that need to deal with
> untrusted file systems in privileged contexts.
>=20
> More information on the history and motivation for this patch can be
> found here:
>=20
> https://sites.google.com/a/chromium.org/dev/chromium-os/chromiumos-design=
-docs/hardening-against-malicious-stateful-data#TOC-Restricting-symlink-tra=
versal

Looks good. Did you plan to add an in-tree test for this (you could
shove it in tools/testing/selftests/mount)?

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

> Signed-off-by: Mattias Nissler <mnissler@chromium.org>
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
> Changes since v6 [1]:
>  * Rebased onto v5.8.
>  * Another round of testing including readlink(1), readlink(2),
>    realpath(1), realpath(3), statfs(2) and mount(2) to make sure
>    everything still works.
>=20
> After this lands I will upstream changes to util-linux[2] and man-pages
> [3].
>=20
> [1]: https://lkml.org/lkml/2020/3/4/770
> [2]: https://github.com/rzwisler/util-linux/commit/7f8771acd85edb70d97921=
c026c55e1e724d4e15
> [3]: https://github.com/rzwisler/man-pages/commit/b8fe8079f64b5068940c014=
4586e580399a71668
> ---
>  fs/namei.c                 | 3 ++-
>  fs/namespace.c             | 2 ++
>  fs/proc_namespace.c        | 1 +
>  fs/statfs.c                | 2 ++
>  include/linux/mount.h      | 3 ++-
>  include/linux/statfs.h     | 1 +
>  include/uapi/linux/mount.h | 1 +
>  7 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 72d4219c93acb..ed68478fb1fb6 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1626,7 +1626,8 @@ static const char *pick_link(struct nameidata *nd, =
struct path *link,
>  			return ERR_PTR(error);
>  	}
> =20
> -	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS))
> +	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS) ||
> +			unlikely(nd->path.mnt->mnt_flags & MNT_NOSYMFOLLOW))
>  		return ERR_PTR(-ELOOP);
> =20
>  	if (!(nd->flags & LOOKUP_RCU)) {
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 4a0f600a33285..1cbbf5a9b954f 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3167,6 +3167,8 @@ long do_mount(const char *dev_name, const char __us=
er *dir_name,
>  		mnt_flags &=3D ~(MNT_RELATIME | MNT_NOATIME);
>  	if (flags & MS_RDONLY)
>  		mnt_flags |=3D MNT_READONLY;
> +	if (flags & MS_NOSYMFOLLOW)
> +		mnt_flags |=3D MNT_NOSYMFOLLOW;
> =20
>  	/* The default atime for remount is preservation */
>  	if ((flags & MS_REMOUNT) &&
> diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> index 3059a9394c2d6..e59d4bb3a89e4 100644
> --- a/fs/proc_namespace.c
> +++ b/fs/proc_namespace.c
> @@ -70,6 +70,7 @@ static void show_mnt_opts(struct seq_file *m, struct vf=
smount *mnt)
>  		{ MNT_NOATIME, ",noatime" },
>  		{ MNT_NODIRATIME, ",nodiratime" },
>  		{ MNT_RELATIME, ",relatime" },
> +		{ MNT_NOSYMFOLLOW, ",nosymfollow" },
>  		{ 0, NULL }
>  	};
>  	const struct proc_fs_opts *fs_infop;
> diff --git a/fs/statfs.c b/fs/statfs.c
> index 2616424012ea7..59f33752c1311 100644
> --- a/fs/statfs.c
> +++ b/fs/statfs.c
> @@ -29,6 +29,8 @@ static int flags_by_mnt(int mnt_flags)
>  		flags |=3D ST_NODIRATIME;
>  	if (mnt_flags & MNT_RELATIME)
>  		flags |=3D ST_RELATIME;
> +	if (mnt_flags & MNT_NOSYMFOLLOW)
> +		flags |=3D ST_NOSYMFOLLOW;
>  	return flags;
>  }
> =20
> diff --git a/include/linux/mount.h b/include/linux/mount.h
> index de657bd211fa6..aaf343b38671c 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -30,6 +30,7 @@ struct fs_context;
>  #define MNT_NODIRATIME	0x10
>  #define MNT_RELATIME	0x20
>  #define MNT_READONLY	0x40	/* does the user want this to be r/o? */
> +#define MNT_NOSYMFOLLOW	0x80
> =20
>  #define MNT_SHRINKABLE	0x100
>  #define MNT_WRITE_HOLD	0x200
> @@ -46,7 +47,7 @@ struct fs_context;
>  #define MNT_SHARED_MASK	(MNT_UNBINDABLE)
>  #define MNT_USER_SETTABLE_MASK  (MNT_NOSUID | MNT_NODEV | MNT_NOEXEC \
>  				 | MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME \
> -				 | MNT_READONLY)
> +				 | MNT_READONLY | MNT_NOSYMFOLLOW)
>  #define MNT_ATIME_MASK (MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME )
> =20
>  #define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL |=
 \
> diff --git a/include/linux/statfs.h b/include/linux/statfs.h
> index 9bc69edb8f188..fac4356ea1bfc 100644
> --- a/include/linux/statfs.h
> +++ b/include/linux/statfs.h
> @@ -40,6 +40,7 @@ struct kstatfs {
>  #define ST_NOATIME	0x0400	/* do not update access times */
>  #define ST_NODIRATIME	0x0800	/* do not update directory access times */
>  #define ST_RELATIME	0x1000	/* update atime relative to mtime/ctime */
> +#define ST_NOSYMFOLLOW	0x2000	/* do not follow symlinks */
> =20
>  struct dentry;
>  extern int vfs_get_fsid(struct dentry *dentry, __kernel_fsid_t *fsid);
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 96a0240f23fed..dd8306ea336c1 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -16,6 +16,7 @@
>  #define MS_REMOUNT	32	/* Alter flags of a mounted FS */
>  #define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
>  #define MS_DIRSYNC	128	/* Directory modifications are synchronous */
> +#define MS_NOSYMFOLLOW	256	/* Do not follow symlinks */
>  #define MS_NOATIME	1024	/* Do not update access times. */
>  #define MS_NODIRATIME	2048	/* Do not update directory access times */
>  #define MS_BIND		4096
> --=20
> 2.28.0.236.gb10cc79966-goog
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--cin4lu5msomn5ja6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXzNJLQAKCRCdlLljIbnQ
EsDjAQDDwisyM9fOuV+Ed0MJ00dzw040RQ7+LVK/5aoQkBbRmQEAr67/mlNPDrRB
npO+QCicLL7SvDb22zFE3wueer23Hwk=
=Fd7y
-----END PGP SIGNATURE-----

--cin4lu5msomn5ja6--
