Return-Path: <linux-fsdevel+bounces-27853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E58079647D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7507A1F24649
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA191B0120;
	Thu, 29 Aug 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKcFMsvV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDD619005B;
	Thu, 29 Aug 2024 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941050; cv=none; b=UHH/bu08iwAD361oDVuJAxvK9FJM7N3ZhNo1Xty/vcHK397YscKG4pqR7H9s72K4RTFreAQ7fLqKN5gNqP52TgWBP0JhdujC62QTJcqmV7Po7RPqDdo7LvJOQ6JUixozJV+JQ/QS5PPh6n+zJDCAjqJP0KKEyqF48jDAXVSws2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941050; c=relaxed/simple;
	bh=5EyLkg9TpPjpz1PDESP9BtotD+VvKSRmodNygGhY3O0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TOG0EfcHXz8kiJywdX4cQrT4nYrueEUoux9kkOskZJrgaGk1nAIje1oxGbeL8kQLZPgOpSxOhC5QAJV55GgWq1PefAySxNaiUQ18PBBjqWkJ0swrLuU9EKOZUCvPb5xvxFqe+b/FfZSLxuzg5z8mvv1BIKAaFFy06vZTIDf5WPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKcFMsvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8C6C4CEC1;
	Thu, 29 Aug 2024 14:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724941049;
	bh=5EyLkg9TpPjpz1PDESP9BtotD+VvKSRmodNygGhY3O0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HKcFMsvVkX0m455U3kKDhovoFiD5JF/LtScB1lnD708xiVexEjPxCbGrWlHatxwIF
	 3FJRTz/Mu1PJV1dh1qhYU9kOsaOIoFib/D8NLT3kpfpFHm5tUDlil5Dr9LXqyjLziN
	 idLcD4IZZgmGRCy3QbcozlZYdWYU+M6P77YrfmA9zXfnTTfJ6naCSHi5H20+EzckOB
	 Ud0+O5MgUcZYP//wf2mZ3yEnmsNeTMc3zMpWmLRVza1T8rccKLRJ8keXmpIxNSbbdc
	 pY6VwoJEhxMorr3ei6uIoxrA29p2d8kgalZ1QWuYi6tm81CSWEbWCG/OzjLLOY+7fZ
	 Y1MivXIK/PGvA==
Message-ID: <251afa885bf38e0d819d64f8fc24fbddfd7b57ec.camel@kernel.org>
Subject: Re: [PATCH v14 01/25] nfs_common: factor out nfs_errtbl and
 nfs_stat_to_errno
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, 
 Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 linux-fsdevel@vger.kernel.org
Date: Thu, 29 Aug 2024 10:17:27 -0400
In-Reply-To: <20240829010424.83693-2-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
	 <20240829010424.83693-2-snitzer@kernel.org>
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
> Common nfs_stat_to_errno() is used by both fs/nfs/nfs2xdr.c and
> fs/nfs/nfs3xdr.c
>=20
> Will also be used by fs/nfsd/localio.c
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> =C2=A0fs/nfs/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0fs/nfs/nfs2xdr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 70 +-----------------------
> =C2=A0fs/nfs/nfs3xdr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 108 +++++++----------------------------
> --
> =C2=A0fs/nfs/nfs4xdr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 4 +-
> =C2=A0fs/nfs_common/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0fs/nfs_common/common.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 67 +++++++++=
++++++++++++++
> =C2=A0fs/nfsd/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0include/linux/nfs_common.h |=C2=A0 16 ++++++
> =C2=A08 files changed, 109 insertions(+), 160 deletions(-)
> =C2=A0create mode 100644 fs/nfs_common/common.c
> =C2=A0create mode 100644 include/linux/nfs_common.h
>=20
> diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
> index 57249f040dfc..0eb20012792f 100644
> --- a/fs/nfs/Kconfig
> +++ b/fs/nfs/Kconfig
> @@ -4,6 +4,7 @@ config NFS_FS
> =C2=A0	depends on INET && FILE_LOCKING && MULTIUSER
> =C2=A0	select LOCKD
> =C2=A0	select SUNRPC
> +	select NFS_COMMON
> =C2=A0	select NFS_ACL_SUPPORT if NFS_V3_ACL
> =C2=A0	help
> =C2=A0	=C2=A0 Choose Y here if you want to access files residing on
> other
> diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
> index c19093814296..6e75c6c2d234 100644
> --- a/fs/nfs/nfs2xdr.c
> +++ b/fs/nfs/nfs2xdr.c
> @@ -22,14 +22,12 @@
> =C2=A0#include <linux/nfs.h>
> =C2=A0#include <linux/nfs2.h>
> =C2=A0#include <linux/nfs_fs.h>
> +#include <linux/nfs_common.h>
> =C2=A0#include "nfstrace.h"
> =C2=A0#include "internal.h"
> =C2=A0
> =C2=A0#define NFSDBG_FACILITY		NFSDBG_XDR
> =C2=A0
> -/* Mapping from NFS error code to "errno" error code. */
> -#define errno_NFSERR_IO		EIO
> -
> =C2=A0/*
> =C2=A0 * Declare the space requirements for NFS arguments and replies as
> =C2=A0 * number of 32bit-words
> @@ -64,8 +62,6 @@
> =C2=A0#define NFS_readdirres_sz	(1+NFS_pagepad_sz)
> =C2=A0#define NFS_statfsres_sz	(1+NFS_info_sz)
> =C2=A0
> -static int nfs_stat_to_errno(enum nfs_stat);
> -
> =C2=A0/*
> =C2=A0 * Encode/decode NFSv2 basic data types
> =C2=A0 *
> @@ -1054,70 +1050,6 @@ static int nfs2_xdr_dec_statfsres(struct
> rpc_rqst *req, struct xdr_stream *xdr,
> =C2=A0	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> -
> -/*
> - * We need to translate between nfs status return values and
> - * the local errno values which may not be the same.
> - */
> -static const struct {
> -	int stat;
> -	int errno;
> -} nfs_errtbl[] =3D {
> -	{ NFS_OK,		0		},
> -	{ NFSERR_PERM,		-EPERM		},
> -	{ NFSERR_NOENT,		-ENOENT		},
> -	{ NFSERR_IO,		-errno_NFSERR_IO},
> -	{ NFSERR_NXIO,		-ENXIO		},
> -/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
> -	{ NFSERR_ACCES,		-EACCES		},
> -	{ NFSERR_EXIST,		-EEXIST		},
> -	{ NFSERR_XDEV,		-EXDEV		},
> -	{ NFSERR_NODEV,		-ENODEV		},
> -	{ NFSERR_NOTDIR,	-ENOTDIR	},
> -	{ NFSERR_ISDIR,		-EISDIR		},
> -	{ NFSERR_INVAL,		-EINVAL		},
> -	{ NFSERR_FBIG,		-EFBIG		},
> -	{ NFSERR_NOSPC,		-ENOSPC		},
> -	{ NFSERR_ROFS,		-EROFS		},
> -	{ NFSERR_MLINK,		-EMLINK		},
> -	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
> -	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
> -	{ NFSERR_DQUOT,		-EDQUOT		},
> -	{ NFSERR_STALE,		-ESTALE		},
> -	{ NFSERR_REMOTE,	-EREMOTE	},
> -#ifdef EWFLUSH
> -	{ NFSERR_WFLUSH,	-EWFLUSH	},
> -#endif
> -	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
> -	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
> -	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
> -	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
> -	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
> -	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
> -	{ NFSERR_BADTYPE,	-EBADTYPE	},
> -	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
> -	{ -1,			-EIO		}
> -};
> -
> -/**
> - * nfs_stat_to_errno - convert an NFS status code to a local errno
> - * @status: NFS status code to convert
> - *
> - * Returns a local errno value, or -EIO if the NFS status code is
> - * not recognized.=C2=A0 This function is used jointly by NFSv2 and
> NFSv3.
> - */
> -static int nfs_stat_to_errno(enum nfs_stat status)
> -{
> -	int i;
> -
> -	for (i =3D 0; nfs_errtbl[i].stat !=3D -1; i++) {
> -		if (nfs_errtbl[i].stat =3D=3D (int)status)
> -			return nfs_errtbl[i].errno;
> -	}
> -	dprintk("NFS: Unrecognized nfs status value: %u\n", status);
> -	return nfs_errtbl[i].errno;
> -}
> -
> =C2=A0#define PROC(proc, argtype, restype,
> timer)				\
> =C2=A0[NFSPROC_##proc] =3D
> {							\
> =C2=A0	.p_proc	=C2=A0=C2=A0=C2=A0 =3D=C2=A0
> NFSPROC_##proc,					\
> diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
> index 60f032be805a..4ae01c10b7e2 100644
> --- a/fs/nfs/nfs3xdr.c
> +++ b/fs/nfs/nfs3xdr.c
> @@ -21,14 +21,13 @@
> =C2=A0#include <linux/nfs3.h>
> =C2=A0#include <linux/nfs_fs.h>
> =C2=A0#include <linux/nfsacl.h>
> +#include <linux/nfs_common.h>
> +
> =C2=A0#include "nfstrace.h"
> =C2=A0#include "internal.h"
> =C2=A0
> =C2=A0#define NFSDBG_FACILITY		NFSDBG_XDR
> =C2=A0
> -/* Mapping from NFS error code to "errno" error code. */
> -#define errno_NFSERR_IO		EIO
> -
> =C2=A0/*
> =C2=A0 * Declare the space requirements for NFS arguments and replies as
> =C2=A0 * number of 32bit-words
> @@ -91,8 +90,6 @@
> =C2=A0				NFS3_pagepad_sz)
> =C2=A0#define ACL3_setaclres_sz	(1+NFS3_post_op_attr_sz)
> =C2=A0
> -static int nfs3_stat_to_errno(enum nfs_stat);
> -
> =C2=A0/*
> =C2=A0 * Map file type to S_IFMT bits
> =C2=A0 */
> @@ -1406,7 +1403,7 @@ static int nfs3_xdr_dec_getattr3res(struct
> rpc_rqst *req,
> =C2=A0out:
> =C2=A0	return error;
> =C2=A0out_default:
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -1445,7 +1442,7 @@ static int nfs3_xdr_dec_setattr3res(struct
> rpc_rqst *req,
> =C2=A0out:
> =C2=A0	return error;
> =C2=A0out_status:
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -1495,7 +1492,7 @@ static int nfs3_xdr_dec_lookup3res(struct
> rpc_rqst *req,
> =C2=A0	error =3D decode_post_op_attr(xdr, result->dir_attr, userns);
> =C2=A0	if (unlikely(error))
> =C2=A0		goto out;
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -1537,7 +1534,7 @@ static int nfs3_xdr_dec_access3res(struct
> rpc_rqst *req,
> =C2=A0out:
> =C2=A0	return error;
> =C2=A0out_default:
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -1578,7 +1575,7 @@ static int nfs3_xdr_dec_readlink3res(struct
> rpc_rqst *req,
> =C2=A0out:
> =C2=A0	return error;
> =C2=A0out_default:
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -1658,7 +1655,7 @@ static int nfs3_xdr_dec_read3res(struct
> rpc_rqst *req, struct xdr_stream *xdr,
> =C2=A0out:
> =C2=A0	return error;
> =C2=A0out_status:
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -1728,7 +1725,7 @@ static int nfs3_xdr_dec_write3res(struct
> rpc_rqst *req, struct xdr_stream *xdr,
> =C2=A0out:
> =C2=A0	return error;
> =C2=A0out_status:
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -1795,7 +1792,7 @@ static int nfs3_xdr_dec_create3res(struct
> rpc_rqst *req,
> =C2=A0	error =3D decode_wcc_data(xdr, result->dir_attr, userns);
> =C2=A0	if (unlikely(error))
> =C2=A0		goto out;
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -1835,7 +1832,7 @@ static int nfs3_xdr_dec_remove3res(struct
> rpc_rqst *req,
> =C2=A0out:
> =C2=A0	return error;
> =C2=A0out_status:
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -1881,7 +1878,7 @@ static int nfs3_xdr_dec_rename3res(struct
> rpc_rqst *req,
> =C2=A0out:
> =C2=A0	return error;
> =C2=A0out_status:
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -1926,7 +1923,7 @@ static int nfs3_xdr_dec_link3res(struct
> rpc_rqst *req, struct xdr_stream *xdr,
> =C2=A0out:
> =C2=A0	return error;
> =C2=A0out_status:
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -2101,7 +2098,7 @@ static int nfs3_xdr_dec_readdir3res(struct
> rpc_rqst *req,
> =C2=A0	error =3D decode_post_op_attr(xdr, result->dir_attr,
> rpc_rqst_userns(req));
> =C2=A0	if (unlikely(error))
> =C2=A0		goto out;
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -2167,7 +2164,7 @@ static int nfs3_xdr_dec_fsstat3res(struct
> rpc_rqst *req,
> =C2=A0out:
> =C2=A0	return error;
> =C2=A0out_status:
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -2243,7 +2240,7 @@ static int nfs3_xdr_dec_fsinfo3res(struct
> rpc_rqst *req,
> =C2=A0out:
> =C2=A0	return error;
> =C2=A0out_status:
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -2304,7 +2301,7 @@ static int nfs3_xdr_dec_pathconf3res(struct
> rpc_rqst *req,
> =C2=A0out:
> =C2=A0	return error;
> =C2=A0out_status:
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -2350,7 +2347,7 @@ static int nfs3_xdr_dec_commit3res(struct
> rpc_rqst *req,
> =C2=A0out:
> =C2=A0	return error;
> =C2=A0out_status:
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0#ifdef CONFIG_NFS_V3_ACL
> @@ -2416,7 +2413,7 @@ static int nfs3_xdr_dec_getacl3res(struct
> rpc_rqst *req,
> =C2=A0out:
> =C2=A0	return error;
> =C2=A0out_default:
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0static int nfs3_xdr_dec_setacl3res(struct rpc_rqst *req,
> @@ -2435,76 +2432,11 @@ static int nfs3_xdr_dec_setacl3res(struct
> rpc_rqst *req,
> =C2=A0out:
> =C2=A0	return error;
> =C2=A0out_default:
> -	return nfs3_stat_to_errno(status);
> +	return nfs_stat_to_errno(status);
> =C2=A0}
> =C2=A0
> =C2=A0#endif=C2=A0 /* CONFIG_NFS_V3_ACL */
> =C2=A0
> -
> -/*
> - * We need to translate between nfs status return values and
> - * the local errno values which may not be the same.
> - */
> -static const struct {
> -	int stat;
> -	int errno;
> -} nfs_errtbl[] =3D {
> -	{ NFS_OK,		0		},
> -	{ NFSERR_PERM,		-EPERM		},
> -	{ NFSERR_NOENT,		-ENOENT		},
> -	{ NFSERR_IO,		-errno_NFSERR_IO},
> -	{ NFSERR_NXIO,		-ENXIO		},
> -/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
> -	{ NFSERR_ACCES,		-EACCES		},
> -	{ NFSERR_EXIST,		-EEXIST		},
> -	{ NFSERR_XDEV,		-EXDEV		},
> -	{ NFSERR_NODEV,		-ENODEV		},
> -	{ NFSERR_NOTDIR,	-ENOTDIR	},
> -	{ NFSERR_ISDIR,		-EISDIR		},
> -	{ NFSERR_INVAL,		-EINVAL		},
> -	{ NFSERR_FBIG,		-EFBIG		},
> -	{ NFSERR_NOSPC,		-ENOSPC		},
> -	{ NFSERR_ROFS,		-EROFS		},
> -	{ NFSERR_MLINK,		-EMLINK		},
> -	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
> -	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
> -	{ NFSERR_DQUOT,		-EDQUOT		},
> -	{ NFSERR_STALE,		-ESTALE		},
> -	{ NFSERR_REMOTE,	-EREMOTE	},
> -#ifdef EWFLUSH
> -	{ NFSERR_WFLUSH,	-EWFLUSH	},
> -#endif
> -	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
> -	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
> -	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
> -	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
> -	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
> -	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
> -	{ NFSERR_BADTYPE,	-EBADTYPE	},
> -	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
> -	{ -1,			-EIO		}
> -};
> -
> -/**
> - * nfs3_stat_to_errno - convert an NFS status code to a local errno
> - * @status: NFS status code to convert
> - *
> - * Returns a local errno value, or -EIO if the NFS status code is
> - * not recognized.=C2=A0 This function is used jointly by NFSv2 and
> NFSv3.
> - */
> -static int nfs3_stat_to_errno(enum nfs_stat status)
> -{
> -	int i;
> -
> -	for (i =3D 0; nfs_errtbl[i].stat !=3D -1; i++) {
> -		if (nfs_errtbl[i].stat =3D=3D (int)status)
> -			return nfs_errtbl[i].errno;
> -	}
> -	dprintk("NFS: Unrecognized nfs status value: %u\n", status);
> -	return nfs_errtbl[i].errno;
> -}
> -
> -
> =C2=A0#define PROC(proc, argtype, restype,
> timer)				\
> =C2=A0[NFS3PROC_##proc] =3D
> {							\
> =C2=A0	.p_proc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D
> NFS3PROC_##proc,					\
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 7704a4509676..b4091af1a60d 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -52,6 +52,7 @@
> =C2=A0#include <linux/nfs.h>
> =C2=A0#include <linux/nfs4.h>
> =C2=A0#include <linux/nfs_fs.h>
> +#include <linux/nfs_common.h>
> =C2=A0
> =C2=A0#include "nfs4_fs.h"
> =C2=A0#include "nfs4trace.h"
> @@ -63,9 +64,6 @@
> =C2=A0
> =C2=A0#define NFSDBG_FACILITY		NFSDBG_XDR
> =C2=A0
> -/* Mapping from NFS error code to "errno" error code. */
> -#define errno_NFSERR_IO		EIO
> -
> =C2=A0struct compound_hdr;
> =C2=A0static int nfs4_stat_to_errno(int);
> =C2=A0static void encode_layoutget(struct xdr_stream *xdr,
> diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
> index 119c75ab9fd0..e58b01bb8dda 100644
> --- a/fs/nfs_common/Makefile
> +++ b/fs/nfs_common/Makefile
> @@ -8,3 +8,5 @@ nfs_acl-objs :=3D nfsacl.o
> =C2=A0
> =C2=A0obj-$(CONFIG_GRACE_PERIOD) +=3D grace.o
> =C2=A0obj-$(CONFIG_NFS_V4_2_SSC_HELPER) +=3D nfs_ssc.o
> +
> +obj-$(CONFIG_NFS_COMMON) +=3D common.o
> diff --git a/fs/nfs_common/common.c b/fs/nfs_common/common.c
> new file mode 100644
> index 000000000000..a4ee95da2174
> --- /dev/null
> +++ b/fs/nfs_common/common.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/module.h>
> +#include <linux/nfs_common.h>
> +
> +/*
> + * We need to translate between nfs status return values and
> + * the local errno values which may not be the same.
> + */
> +static const struct {
> +	int stat;
> +	int errno;
> +} nfs_errtbl[] =3D {
> +	{ NFS_OK,		0		},
> +	{ NFSERR_PERM,		-EPERM		},
> +	{ NFSERR_NOENT,		-ENOENT		},
> +	{ NFSERR_IO,		-errno_NFSERR_IO},
> +	{ NFSERR_NXIO,		-ENXIO		},
> +/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
> +	{ NFSERR_ACCES,		-EACCES		},
> +	{ NFSERR_EXIST,		-EEXIST		},
> +	{ NFSERR_XDEV,		-EXDEV		},
> +	{ NFSERR_NODEV,		-ENODEV		},
> +	{ NFSERR_NOTDIR,	-ENOTDIR	},
> +	{ NFSERR_ISDIR,		-EISDIR		},
> +	{ NFSERR_INVAL,		-EINVAL		},
> +	{ NFSERR_FBIG,		-EFBIG		},
> +	{ NFSERR_NOSPC,		-ENOSPC		},
> +	{ NFSERR_ROFS,		-EROFS		},
> +	{ NFSERR_MLINK,		-EMLINK		},
> +	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
> +	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
> +	{ NFSERR_DQUOT,		-EDQUOT		},
> +	{ NFSERR_STALE,		-ESTALE		},
> +	{ NFSERR_REMOTE,	-EREMOTE	},
> +#ifdef EWFLUSH
> +	{ NFSERR_WFLUSH,	-EWFLUSH	},
> +#endif
> +	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
> +	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
> +	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
> +	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
> +	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
> +	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
> +	{ NFSERR_BADTYPE,	-EBADTYPE	},
> +	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
> +	{ -1,			-EIO		}
> +};
> +
> +/**
> + * nfs_stat_to_errno - convert an NFS status code to a local errno
> + * @status: NFS status code to convert
> + *
> + * Returns a local errno value, or -EIO if the NFS status code is
> + * not recognized.=C2=A0 This function is used jointly by NFSv2 and
> NFSv3.
> + */
> +int nfs_stat_to_errno(enum nfs_stat status)
> +{
> +	int i;
> +
> +	for (i =3D 0; nfs_errtbl[i].stat !=3D -1; i++) {
> +		if (nfs_errtbl[i].stat =3D=3D (int)status)
> +			return nfs_errtbl[i].errno;
> +	}
> +	return nfs_errtbl[i].errno;
> +}
> +EXPORT_SYMBOL_GPL(nfs_stat_to_errno);
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index ec2ab6429e00..c0bd1509ccd4 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -7,6 +7,7 @@ config NFSD
> =C2=A0	select LOCKD
> =C2=A0	select SUNRPC
> =C2=A0	select EXPORTFS
> +	select NFS_COMMON
> =C2=A0	select NFS_ACL_SUPPORT if NFSD_V2_ACL
> =C2=A0	select NFS_ACL_SUPPORT if NFSD_V3_ACL
> =C2=A0	depends on MULTIUSER
> diff --git a/include/linux/nfs_common.h b/include/linux/nfs_common.h
> new file mode 100644
> index 000000000000..3395c4a4d372
> --- /dev/null
> +++ b/include/linux/nfs_common.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This file contains constants and methods used by both NFS client
> and server.
> + */
> +#ifndef _LINUX_NFS_COMMON_H
> +#define _LINUX_NFS_COMMON_H
> +
> +#include <linux/errno.h>
> +#include <uapi/linux/nfs.h>
> +
> +/* Mapping from NFS error code to "errno" error code. */
> +#define errno_NFSERR_IO EIO
> +
> +int nfs_stat_to_errno(enum nfs_stat status);
> +
> +#endif /* _LINUX_NFS_COMMON_H */

Reviewed-by: Jeff Layton <jlayton@kernel.org>

