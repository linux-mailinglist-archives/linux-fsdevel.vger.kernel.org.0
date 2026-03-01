Return-Path: <linux-fsdevel+bounces-78842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK3QBc40pGmnaQUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 13:45:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 997231CFB02
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 13:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39236301913D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CD0325701;
	Sun,  1 Mar 2026 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDsJpZck"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055592773EE;
	Sun,  1 Mar 2026 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772369085; cv=none; b=qD6+eWLqo0CLm+RobUckoAdyftZ/MEy6sJj6+mp6ISIqnaWHGlYQtaflRkCehZI/DEWYVds9eSjwQZJtsHykKCFKvTwF3yJ5X+pGG58hnMmrdFAxYfdadrh5HsyOlgrjG/tt6iJ3ucIIqDEA8iW4JFADFjjb94CFhrJNlJSjNUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772369085; c=relaxed/simple;
	bh=YFXbyDuGu+lMcj0X0HvXFwBfz8rYM0ojfkKa4wsRy2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qy33AqdbP/4BmzhQFHURm0szHDcfbIV/6M3Hl5JDpX68o3/DJZWdd+S+8ZhSd58y4Ixpcn9H63FYG/D24mj7tH0KgysuvMEysx2/kIWS8IUCzQDLMeNXeyKuZkgjHXMgc75uAs8JBxE8HllzNF8TPAjvLa6JAvCI79vRR6/Ylyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDsJpZck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A88FC116C6;
	Sun,  1 Mar 2026 12:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772369084;
	bh=YFXbyDuGu+lMcj0X0HvXFwBfz8rYM0ojfkKa4wsRy2E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nDsJpZckQKwCwiBNpiRHfrOxN4/tuBXjynAZFFrhV3PFyb9BhNnqAIXT9uh9LlY4m
	 knQpj8u3vCib7c1UdzSHMWtE2l14XepARDIpi2sbeD0aCVR9FNteA6V7jB+EI9UJKA
	 uIfaNwwqGcA1Mlsy2qSCVwK9bbj5Xt6XjEq5VhrmO3Ht4fMsH/qxxiSAyJmBzsKcBE
	 3iB+hMamG5hCh/yWm49qwsp4D/IRrvKUeIP+eAGd8Mb6JoW8ND8H8wIq+yU4v5424o
	 Y8vc8SexINQMisBkUExD7VLoBNHU3AKEjbqRN5Lv7LJF2G0qAF6kgUl7Ub/BZxAUni
	 fpjNcF6CGYaAA==
Message-ID: <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
Subject: Re: [PATCH v4 1/4] openat2: new OPENAT2_REGULAR flag support
From: Jeff Layton <jlayton@kernel.org>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, 	v9fs@lists.linux.dev,
 linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, chuck.lever@oracle.com,
 alex.aring@gmail.com, 	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com,
 smfrench@gmail.com, 	richard.henderson@linaro.org, mattst88@gmail.com,
 linmag7@gmail.com, 	tsbogend@alpha.franken.de,
 James.Bottomley@HansenPartnership.com, deller@gmx.de, 	davem@davemloft.net,
 andreas@gaisler.com, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org,
 anna@kernel.org, 	sfrench@samba.org, pc@manguebit.org,
 ronniesahlberg@gmail.com, 	sprasad@microsoft.com, tom@talpey.com,
 bharathsm@microsoft.com, shuah@kernel.org, 	miklos@szeredi.hu,
 hansg@kernel.org
Date: Sun, 01 Mar 2026 07:44:28 -0500
In-Reply-To: <20260221145915.81749-2-dorjoychy111@gmail.com>
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
	 <20260221145915.81749-2-dorjoychy111@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78842-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uapi-group.org:url]
X-Rspamd-Queue-Id: 997231CFB02
X-Rspamd-Action: no action

On Sat, 2026-02-21 at 20:45 +0600, Dorjoy Chowdhury wrote:
> This flag indicates the path should be opened if it's a regular file.
> This is useful to write secure programs that want to avoid being
> tricked into opening device nodes with special semantics while thinking
> they operate on regular files. This is a requested feature from the
> uapi-group[1].
>=20
> A corresponding error code EFTYPE has been introduced. For example, if
> openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> param, it will return -EFTYPE.
>=20
> When used in combination with O_CREAT, either the regular file is
> created, or if the path already exists, it is opened if it's a regular
> file. Otherwise, -EFTYPE is returned.
>=20

It would be good to mention that EFTYPE has precedent in BSD/Darwin.
When an error code is already supported in another UNIX-y OS, then it
bolsters the case for adding it here.

Your cover letter mentions that you only tested this on btrfs. At the
very least, you should test NFS and SMB. It should be fairly easy to
set up mounts over loopback for those cases.

There are some places where it doesn't seem like -EFTYPE will be
returned. It looks like it can send back -EISDIR and -ENOTDIR in some
cases as well. With a new API like this, I think we ought to strive for
consistency.

Should this API return -EFTYPE for all cases where it's not S_IFREG? If
not, then what other errors are allowed? Bear in mind that you'll need
to document this in the manpages too.

> When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
> as it doesn't make sense to open a path that is both a directory and a
> regular file.
>=20
> [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regular=
-files
>=20
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
>  arch/alpha/include/uapi/asm/errno.h        |  2 ++
>  arch/alpha/include/uapi/asm/fcntl.h        |  1 +
>  arch/mips/include/uapi/asm/errno.h         |  2 ++
>  arch/parisc/include/uapi/asm/errno.h       |  2 ++
>  arch/parisc/include/uapi/asm/fcntl.h       |  1 +
>  arch/sparc/include/uapi/asm/errno.h        |  2 ++
>  arch/sparc/include/uapi/asm/fcntl.h        |  1 +
>  fs/ceph/file.c                             |  4 ++++
>  fs/gfs2/inode.c                            |  2 ++
>  fs/namei.c                                 |  4 ++++
>  fs/nfs/dir.c                               |  4 +++-
>  fs/open.c                                  |  4 +++-
>  fs/smb/client/dir.c                        | 11 ++++++++++-
>  include/linux/fcntl.h                      |  2 ++
>  include/uapi/asm-generic/errno.h           |  2 ++
>  include/uapi/asm-generic/fcntl.h           |  4 ++++
>  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
>  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
>  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
>  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
>  tools/include/uapi/asm-generic/errno.h     |  2 ++
>  21 files changed, 55 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/uap=
i/asm/errno.h
> index 6791f6508632..1a99f38813c7 100644
> --- a/arch/alpha/include/uapi/asm/errno.h
> +++ b/arch/alpha/include/uapi/asm/errno.h
> @@ -127,4 +127,6 @@
> =20
>  #define EHWPOISON	139	/* Memory page has hardware error */
> =20
> +#define EFTYPE		140	/* Wrong file type for the intended operation */
> +
>  #endif
> diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uap=
i/asm/fcntl.h
> index 50bdc8e8a271..fe488bf7c18e 100644
> --- a/arch/alpha/include/uapi/asm/fcntl.h
> +++ b/arch/alpha/include/uapi/asm/fcntl.h
> @@ -34,6 +34,7 @@
> =20
>  #define O_PATH		040000000
>  #define __O_TMPFILE	0100000000
> +#define OPENAT2_REGULAR	0200000000
> =20
>  #define F_GETLK		7
>  #define F_SETLK		8
> diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uapi/=
asm/errno.h
> index c01ed91b1ef4..1835a50b69ce 100644
> --- a/arch/mips/include/uapi/asm/errno.h
> +++ b/arch/mips/include/uapi/asm/errno.h
> @@ -126,6 +126,8 @@
> =20
>  #define EHWPOISON	168	/* Memory page has hardware error */
> =20
> +#define EFTYPE		169	/* Wrong file type for the intended operation */
> +
>  #define EDQUOT		1133	/* Quota exceeded */
> =20
> =20
> diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/u=
api/asm/errno.h
> index 8cbc07c1903e..93194fbb0a80 100644
> --- a/arch/parisc/include/uapi/asm/errno.h
> +++ b/arch/parisc/include/uapi/asm/errno.h
> @@ -124,4 +124,6 @@
> =20
>  #define EHWPOISON	257	/* Memory page has hardware error */
> =20
> +#define EFTYPE		258	/* Wrong file type for the intended operation */
> +
>  #endif
> diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/u=
api/asm/fcntl.h
> index 03dee816cb13..d46812f2f0f4 100644
> --- a/arch/parisc/include/uapi/asm/fcntl.h
> +++ b/arch/parisc/include/uapi/asm/fcntl.h
> @@ -19,6 +19,7 @@
> =20
>  #define O_PATH		020000000
>  #define __O_TMPFILE	040000000
> +#define OPENAT2_REGULAR	0100000000
> =20
>  #define F_GETLK64	8
>  #define F_SETLK64	9
> diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/uap=
i/asm/errno.h
> index 4a41e7835fd5..71940ec9130b 100644
> --- a/arch/sparc/include/uapi/asm/errno.h
> +++ b/arch/sparc/include/uapi/asm/errno.h
> @@ -117,4 +117,6 @@
> =20
>  #define EHWPOISON	135	/* Memory page has hardware error */
> =20
> +#define EFTYPE		136	/* Wrong file type for the intended operation */
> +
>  #endif
> diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uap=
i/asm/fcntl.h
> index 67dae75e5274..bb6e9fa94bc9 100644
> --- a/arch/sparc/include/uapi/asm/fcntl.h
> +++ b/arch/sparc/include/uapi/asm/fcntl.h
> @@ -37,6 +37,7 @@
> =20
>  #define O_PATH		0x1000000
>  #define __O_TMPFILE	0x2000000
> +#define OPENAT2_REGULAR	0x4000000
> =20
>  #define F_GETOWN	5	/*  for sockets. */
>  #define F_SETOWN	6	/*  for sockets. */
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 31b691b2aea2..0a4220f72ada 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -977,6 +977,10 @@ int ceph_atomic_open(struct inode *dir, struct dentr=
y *dentry,
>  			ceph_init_inode_acls(newino, &as_ctx);
>  			file->f_mode |=3D FMODE_CREATED;
>  		}
> +		if ((flags & OPENAT2_REGULAR) && !d_is_reg(dentry)) {
> +			err =3D -EFTYPE;
> +			goto out_req;
> +		}
>  		err =3D finish_open(file, dentry, ceph_open);
>  	}
>  out_req:
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 8344040ecaf7..0dc3e4240d9e 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -749,6 +749,8 @@ static int gfs2_create_inode(struct inode *dir, struc=
t dentry *dentry,
>  		if (file) {
>  			if (S_ISREG(inode->i_mode))
>  				error =3D finish_open(file, dentry, gfs2_open_common);
> +			else if (file->f_flags & OPENAT2_REGULAR)
> +				error =3D -EFTYPE;
>  			else
>  				error =3D finish_no_open(file, NULL);
>  		}
> diff --git a/fs/namei.c b/fs/namei.c
> index 5fe6cac48df8..aa5fb2672881 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4651,6 +4651,10 @@ static int do_open(struct nameidata *nd,
>  		if (unlikely(error))
>  			return error;
>  	}
> +
> +	if ((open_flag & OPENAT2_REGULAR) && !d_is_reg(nd->path.dentry))
> +		return -EFTYPE;
> +
>  	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
>  		return -ENOTDIR;
> =20
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index b3f5c9461204..ef61db67d06e 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2195,7 +2195,9 @@ int nfs_atomic_open(struct inode *dir, struct dentr=
y *dentry,
>  			break;
>  		case -EISDIR:
>  		case -ENOTDIR:
> -			goto no_open;
> +			if (!(open_flags & OPENAT2_REGULAR))
> +				goto no_open;
> +			break;

Shouldn't this also set the error to -EFTYPE?

>  		case -ELOOP:
>  			if (!(open_flags & O_NOFOLLOW))
>  				goto no_open;
> diff --git a/fs/open.c b/fs/open.c
> index 91f1139591ab..1524f52a1773 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1198,7 +1198,7 @@ inline int build_open_flags(const struct open_how *=
how, struct open_flags *op)
>  	 * values before calling build_open_flags(), but openat2(2) checks all
>  	 * of its arguments.
>  	 */
> -	if (flags & ~VALID_OPEN_FLAGS)
> +	if (flags & ~VALID_OPENAT2_FLAGS)
>  		return -EINVAL;
>  	if (how->resolve & ~VALID_RESOLVE_FLAGS)
>  		return -EINVAL;
> @@ -1237,6 +1237,8 @@ inline int build_open_flags(const struct open_how *=
how, struct open_flags *op)
>  			return -EINVAL;
>  		if (!(acc_mode & MAY_WRITE))
>  			return -EINVAL;
> +	} else if ((flags & O_DIRECTORY) && (flags & OPENAT2_REGULAR)) {
> +		return -EINVAL;
>  	}
>  	if (flags & O_PATH) {
>  		/* O_PATH only permits certain other flags to be set. */
> diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> index cb10088197d2..d12ed0c87599 100644
> --- a/fs/smb/client/dir.c
> +++ b/fs/smb/client/dir.c
> @@ -236,6 +236,11 @@ static int cifs_do_create(struct inode *inode, struc=
t dentry *direntry, unsigned
>  				 * lookup.
>  				 */
>  				CIFSSMBClose(xid, tcon, fid->netfid);
> +				if (oflags & OPENAT2_REGULAR) {
> +					iput(newinode);
> +					rc =3D -EFTYPE;
> +					goto out;
> +				}
>  				goto cifs_create_get_file_info;
>  			}
>  			/* success, no need to query */
> @@ -433,11 +438,15 @@ static int cifs_do_create(struct inode *inode, stru=
ct dentry *direntry, unsigned
>  		goto out_err;
>  	}
> =20
> -	if (newinode)
> +	if (newinode) {
>  		if (S_ISDIR(newinode->i_mode)) {
>  			rc =3D -EISDIR;
>  			goto out_err;

This logic doesn't look quite right. If you do a create and race with a
directory create, then it looks like you'll send back -EISDIR here
instead of -EFTYPE?

> +		} else if ((oflags & OPENAT2_REGULAR) && !S_ISREG(newinode->i_mode)) {
> +			rc =3D -EFTYPE;
> +			goto out_err;
>  		}
> +	}
> =20
>  	d_drop(direntry);
>  	d_add(direntry, newinode);
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index a332e79b3207..a80026718217 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -12,6 +12,8 @@
>  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
>  	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> =20
> +#define VALID_OPENAT2_FLAGS (VALID_OPEN_FLAGS | OPENAT2_REGULAR)
> +
>  /* List of all valid flags for the how->resolve argument: */
>  #define VALID_RESOLVE_FLAGS \
>  	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
> diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/=
errno.h
> index 92e7ae493ee3..bd78e69e0a43 100644
> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -122,4 +122,6 @@
> =20
>  #define EHWPOISON	133	/* Memory page has hardware error */
> =20
> +#define EFTYPE		134	/* Wrong file type for the intended operation */
> +
>  #endif
> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/=
fcntl.h
> index 613475285643..b2c2ddd0edc0 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -88,6 +88,10 @@
>  #define __O_TMPFILE	020000000
>  #endif
> =20
> +#ifndef OPENAT2_REGULAR
> +#define OPENAT2_REGULAR	040000000
> +#endif
> +
>  /* a horrid kludge trying to make sure that this will fail on old kernel=
s */
>  #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
> =20
> diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/alpha=
/include/uapi/asm/errno.h
> index 6791f6508632..1a99f38813c7 100644
> --- a/tools/arch/alpha/include/uapi/asm/errno.h
> +++ b/tools/arch/alpha/include/uapi/asm/errno.h
> @@ -127,4 +127,6 @@
> =20
>  #define EHWPOISON	139	/* Memory page has hardware error */
> =20
> +#define EFTYPE		140	/* Wrong file type for the intended operation */
> +
>  #endif
> diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mips/i=
nclude/uapi/asm/errno.h
> index c01ed91b1ef4..1835a50b69ce 100644
> --- a/tools/arch/mips/include/uapi/asm/errno.h
> +++ b/tools/arch/mips/include/uapi/asm/errno.h
> @@ -126,6 +126,8 @@
> =20
>  #define EHWPOISON	168	/* Memory page has hardware error */
> =20
> +#define EFTYPE		169	/* Wrong file type for the intended operation */
> +
>  #define EDQUOT		1133	/* Quota exceeded */
> =20
> =20
> diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/pari=
sc/include/uapi/asm/errno.h
> index 8cbc07c1903e..93194fbb0a80 100644
> --- a/tools/arch/parisc/include/uapi/asm/errno.h
> +++ b/tools/arch/parisc/include/uapi/asm/errno.h
> @@ -124,4 +124,6 @@
> =20
>  #define EHWPOISON	257	/* Memory page has hardware error */
> =20
> +#define EFTYPE		258	/* Wrong file type for the intended operation */
> +
>  #endif
> diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/sparc=
/include/uapi/asm/errno.h
> index 4a41e7835fd5..71940ec9130b 100644
> --- a/tools/arch/sparc/include/uapi/asm/errno.h
> +++ b/tools/arch/sparc/include/uapi/asm/errno.h
> @@ -117,4 +117,6 @@
> =20
>  #define EHWPOISON	135	/* Memory page has hardware error */
> =20
> +#define EFTYPE		136	/* Wrong file type for the intended operation */
> +
>  #endif
> diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/uapi/=
asm-generic/errno.h
> index 92e7ae493ee3..bd78e69e0a43 100644
> --- a/tools/include/uapi/asm-generic/errno.h
> +++ b/tools/include/uapi/asm-generic/errno.h
> @@ -122,4 +122,6 @@
> =20
>  #define EHWPOISON	133	/* Memory page has hardware error */
> =20
> +#define EFTYPE		134	/* Wrong file type for the intended operation */
> +
>  #endif

--=20
Jeff Layton <jlayton@kernel.org>

