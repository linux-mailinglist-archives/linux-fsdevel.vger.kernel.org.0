Return-Path: <linux-fsdevel+bounces-27854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B81964818
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5281DB282FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BABC1AE87B;
	Thu, 29 Aug 2024 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV7dV8L5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D351AD9E0;
	Thu, 29 Aug 2024 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941079; cv=none; b=M/oXkiO/6BFgD5NIghibSBOxSewXPRDjKv0cIQNqCH+g7CFVz/GEpCS12Qz0nNt1rno6xnVRqwihcNxPQRBjAKbCZ6y2TVFur+locO7W2qYYQpfDNBQMhq4C3YAL/Fs0pWrth+ISthqoV+IoxYBzB+XBo/X01PIPSLB/0g5AqUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941079; c=relaxed/simple;
	bh=BUgGsbvIBDNDaN6wbOzZSpODOFDYjenHhKrfXF2U9oo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IsG4H/ms60CBqaYmWwmNUNzsnLbHFkoQoNQVtSZX9FDH7KjpDyKGY+GCunDxatot9HfXve6B5X2MVmBTagaGExEioNOsJmgVTOS5dLaphFbGH0L6LSn26cai7txBbB8i/qp+k7jKi/YVf7tNaO1Ed8rZdIAHxEn7nvFwGZfUNAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV7dV8L5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E47FC4CEC8;
	Thu, 29 Aug 2024 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724941079;
	bh=BUgGsbvIBDNDaN6wbOzZSpODOFDYjenHhKrfXF2U9oo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XV7dV8L5199M8+fPzUSlDmlOxTlfDvNkxl541eP2x700AHjkfM+qYefe4I1Lcaagw
	 Pg89vkZeazASO1tYUVpw6QNBebzyMw2zgL9j75yBdzUYGJks9jdGksZJXkMEOP2W40
	 Rmr5jpzRMg8OA1ttRECxYLzqWe30z2ejmqbimxIlI4MvNZR2B7JZYhhHeJCODLB8p7
	 rBE1l8fmdJEIAhp0h4MduuMgYsC/t3mhnbgoUR2HZn3gCxp5yFKrFVMa1DCq41DT7K
	 PuVny/9Gvmh0N4DSdIBSIjT9HpLhKsJ2feKezE35UzkV8PXWKDyydaACUcdxjiGi/k
	 BAYQctp5Ue3xA==
Message-ID: <9246925ad716d8bb96a45bf831caec13c833c660.camel@kernel.org>
Subject: Re: [PATCH v14 02/25] nfs_common: factor out nfs4_errtbl and
 nfs4_stat_to_errno
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, 
 Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 linux-fsdevel@vger.kernel.org
Date: Thu, 29 Aug 2024 10:17:56 -0400
In-Reply-To: <20240829010424.83693-3-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
	 <20240829010424.83693-3-snitzer@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-28 at 21:03 -0400, Mike Snitzer wrote:
> Common nfs4_stat_to_errno() is used by fs/nfs/nfs4xdr.c and will be
> used by fs/nfs/localio.c
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> =C2=A0fs/nfs/nfs4xdr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 67 --------------------------------------
> =C2=A0fs/nfs_common/common.c=C2=A0=C2=A0=C2=A0=C2=A0 | 67 +++++++++++++++=
+++++++++++++++++++++++
> =C2=A0include/linux/nfs_common.h |=C2=A0 1 +
> =C2=A03 files changed, 68 insertions(+), 67 deletions(-)
>=20
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index b4091af1a60d..971305bdaecb 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -65,7 +65,6 @@
> =C2=A0#define NFSDBG_FACILITY		NFSDBG_XDR
> =C2=A0
> =C2=A0struct compound_hdr;
> -static int nfs4_stat_to_errno(int);
> =C2=A0static void encode_layoutget(struct xdr_stream *xdr,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 const struct nfs4_layoutget_args *args,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 struct compound_hdr *hdr);
> @@ -7619,72 +7618,6 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, str=
uct nfs_entry *entry,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -/*
> - * We need to translate between nfs status return values and
> - * the local errno values which may not be the same.
> - */
> -static struct {
> -	int stat;
> -	int errno;
> -} nfs_errtbl[] =3D {
> -	{ NFS4_OK,		0		},
> -	{ NFS4ERR_PERM,		-EPERM		},
> -	{ NFS4ERR_NOENT,	-ENOENT		},
> -	{ NFS4ERR_IO,		-errno_NFSERR_IO},
> -	{ NFS4ERR_NXIO,		-ENXIO		},
> -	{ NFS4ERR_ACCESS,	-EACCES		},
> -	{ NFS4ERR_EXIST,	-EEXIST		},
> -	{ NFS4ERR_XDEV,		-EXDEV		},
> -	{ NFS4ERR_NOTDIR,	-ENOTDIR	},
> -	{ NFS4ERR_ISDIR,	-EISDIR		},
> -	{ NFS4ERR_INVAL,	-EINVAL		},
> -	{ NFS4ERR_FBIG,		-EFBIG		},
> -	{ NFS4ERR_NOSPC,	-ENOSPC		},
> -	{ NFS4ERR_ROFS,		-EROFS		},
> -	{ NFS4ERR_MLINK,	-EMLINK		},
> -	{ NFS4ERR_NAMETOOLONG,	-ENAMETOOLONG	},
> -	{ NFS4ERR_NOTEMPTY,	-ENOTEMPTY	},
> -	{ NFS4ERR_DQUOT,	-EDQUOT		},
> -	{ NFS4ERR_STALE,	-ESTALE		},
> -	{ NFS4ERR_BADHANDLE,	-EBADHANDLE	},
> -	{ NFS4ERR_BAD_COOKIE,	-EBADCOOKIE	},
> -	{ NFS4ERR_NOTSUPP,	-ENOTSUPP	},
> -	{ NFS4ERR_TOOSMALL,	-ETOOSMALL	},
> -	{ NFS4ERR_SERVERFAULT,	-EREMOTEIO	},
> -	{ NFS4ERR_BADTYPE,	-EBADTYPE	},
> -	{ NFS4ERR_LOCKED,	-EAGAIN		},
> -	{ NFS4ERR_SYMLINK,	-ELOOP		},
> -	{ NFS4ERR_OP_ILLEGAL,	-EOPNOTSUPP	},
> -	{ NFS4ERR_DEADLOCK,	-EDEADLK	},
> -	{ NFS4ERR_NOXATTR,	-ENODATA	},
> -	{ NFS4ERR_XATTR2BIG,	-E2BIG		},
> -	{ -1,			-EIO		}
> -};
> -
> -/*
> - * Convert an NFS error code to a local one.
> - * This one is used jointly by NFSv2 and NFSv3.
> - */
> -static int
> -nfs4_stat_to_errno(int stat)
> -{
> -	int i;
> -	for (i =3D 0; nfs_errtbl[i].stat !=3D -1; i++) {
> -		if (nfs_errtbl[i].stat =3D=3D stat)
> -			return nfs_errtbl[i].errno;
> -	}
> -	if (stat <=3D 10000 || stat > 10100) {
> -		/* The server is looney tunes. */
> -		return -EREMOTEIO;
> -	}
> -	/* If we cannot translate the error, the recovery routines should
> -	 * handle it.
> -	 * Note: remaining NFSv4 error codes have values > 10000, so should
> -	 * not conflict with native Linux error codes.
> -	 */
> -	return -stat;
> -}
> -
> =C2=A0#ifdef CONFIG_NFS_V4_2
> =C2=A0#include "nfs42xdr.c"
> =C2=A0#endif /* CONFIG_NFS_V4_2 */
> diff --git a/fs/nfs_common/common.c b/fs/nfs_common/common.c
> index a4ee95da2174..34a115176f97 100644
> --- a/fs/nfs_common/common.c
> +++ b/fs/nfs_common/common.c
> @@ -2,6 +2,7 @@
> =C2=A0
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/nfs_common.h>
> +#include <linux/nfs4.h>
> =C2=A0
> =C2=A0/*
> =C2=A0 * We need to translate between nfs status return values and
> @@ -65,3 +66,69 @@ int nfs_stat_to_errno(enum nfs_stat status)
> =C2=A0	return nfs_errtbl[i].errno;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(nfs_stat_to_errno);
> +
> +/*
> + * We need to translate between nfs v4 status return values and
> + * the local errno values which may not be the same.
> + */
> +static const struct {
> +	int stat;
> +	int errno;
> +} nfs4_errtbl[] =3D {
> +	{ NFS4_OK,		0		},
> +	{ NFS4ERR_PERM,		-EPERM		},
> +	{ NFS4ERR_NOENT,	-ENOENT		},
> +	{ NFS4ERR_IO,		-errno_NFSERR_IO},
> +	{ NFS4ERR_NXIO,		-ENXIO		},
> +	{ NFS4ERR_ACCESS,	-EACCES		},
> +	{ NFS4ERR_EXIST,	-EEXIST		},
> +	{ NFS4ERR_XDEV,		-EXDEV		},
> +	{ NFS4ERR_NOTDIR,	-ENOTDIR	},
> +	{ NFS4ERR_ISDIR,	-EISDIR		},
> +	{ NFS4ERR_INVAL,	-EINVAL		},
> +	{ NFS4ERR_FBIG,		-EFBIG		},
> +	{ NFS4ERR_NOSPC,	-ENOSPC		},
> +	{ NFS4ERR_ROFS,		-EROFS		},
> +	{ NFS4ERR_MLINK,	-EMLINK		},
> +	{ NFS4ERR_NAMETOOLONG,	-ENAMETOOLONG	},
> +	{ NFS4ERR_NOTEMPTY,	-ENOTEMPTY	},
> +	{ NFS4ERR_DQUOT,	-EDQUOT		},
> +	{ NFS4ERR_STALE,	-ESTALE		},
> +	{ NFS4ERR_BADHANDLE,	-EBADHANDLE	},
> +	{ NFS4ERR_BAD_COOKIE,	-EBADCOOKIE	},
> +	{ NFS4ERR_NOTSUPP,	-ENOTSUPP	},
> +	{ NFS4ERR_TOOSMALL,	-ETOOSMALL	},
> +	{ NFS4ERR_SERVERFAULT,	-EREMOTEIO	},
> +	{ NFS4ERR_BADTYPE,	-EBADTYPE	},
> +	{ NFS4ERR_LOCKED,	-EAGAIN		},
> +	{ NFS4ERR_SYMLINK,	-ELOOP		},
> +	{ NFS4ERR_OP_ILLEGAL,	-EOPNOTSUPP	},
> +	{ NFS4ERR_DEADLOCK,	-EDEADLK	},
> +	{ NFS4ERR_NOXATTR,	-ENODATA	},
> +	{ NFS4ERR_XATTR2BIG,	-E2BIG		},
> +	{ -1,			-EIO		}
> +};
> +
> +/*
> + * Convert an NFS error code to a local one.
> + * This one is used by NFSv4.
> + */
> +int nfs4_stat_to_errno(int stat)
> +{
> +	int i;
> +	for (i =3D 0; nfs4_errtbl[i].stat !=3D -1; i++) {
> +		if (nfs4_errtbl[i].stat =3D=3D stat)
> +			return nfs4_errtbl[i].errno;
> +	}
> +	if (stat <=3D 10000 || stat > 10100) {
> +		/* The server is looney tunes. */
> +		return -EREMOTEIO;
> +	}
> +	/* If we cannot translate the error, the recovery routines should
> +	 * handle it.
> +	 * Note: remaining NFSv4 error codes have values > 10000, so should
> +	 * not conflict with native Linux error codes.
> +	 */
> +	return -stat;
> +}
> +EXPORT_SYMBOL_GPL(nfs4_stat_to_errno);
> diff --git a/include/linux/nfs_common.h b/include/linux/nfs_common.h
> index 3395c4a4d372..5fc02df88252 100644
> --- a/include/linux/nfs_common.h
> +++ b/include/linux/nfs_common.h
> @@ -12,5 +12,6 @@
> =C2=A0#define errno_NFSERR_IO EIO
> =C2=A0
> =C2=A0int nfs_stat_to_errno(enum nfs_stat status);
> +int nfs4_stat_to_errno(int stat);
> =C2=A0
> =C2=A0#endif /* _LINUX_NFS_COMMON_H */

Reviewed-by: Jeff Layton <jlayton@kernel.org>

