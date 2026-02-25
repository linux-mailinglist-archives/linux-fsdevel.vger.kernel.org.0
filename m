Return-Path: <linux-fsdevel+bounces-78360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJcHB8/mnmkCXwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:10:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AF41970B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30EFA30347B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5253ACF0B;
	Wed, 25 Feb 2026 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZfxDoFx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7D3EBF29;
	Wed, 25 Feb 2026 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021448; cv=none; b=qf3gEtX/GJPzQXFxcZw4mUZdhkR/xrm3sYImH9DZ4q5+QCtEcJufus3tN1dQfSUlO/LiT6qYuPjT9b4c512OS6XOfZ0Tf2EsMdzjX6B42nGJSm64gtUiCjV0uJxuaFU9LmDiMbe1vkW/Wr8IFtqwLcKsMUoN0xqs4M7MMHem9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021448; c=relaxed/simple;
	bh=/q8sVfRU4ndmuihfjtKvenuVZXXY25pqMBJ3upSXdY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KX+0raobBTOvqj5qJFVxNPCamhim6mPLoE9ZPaa8hWsR9stnPCl23eyRTLUZa41vxa0eFLQuVPeJFnAHJErHtpotkhxz5zhM/wLccMZY1GAYVDzgcwjZnwE1k7xku95HeL0OxidlJWcP+ss1qkGeaDcy3sKILbiMRK6wU86e77s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZfxDoFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7163CC116D0;
	Wed, 25 Feb 2026 12:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772021448;
	bh=/q8sVfRU4ndmuihfjtKvenuVZXXY25pqMBJ3upSXdY4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kZfxDoFxRRCEK7JOyhZHLSDtrbSESWp827YjQYeh5Thkp9KQE76r9A26DPgccaKi1
	 jt21FfMv+d3/U6c1Isb3uPaeCEuTqPzO2IjK+eUHA0mO0DW20SYWPGpnpbQzs5WOfZ
	 KLOuXCEXo2ipvhe1s5rOmbMeJcaaZlwCKqiVyXsgY1eyAQcA2XU0AE+e7t+vTqQyBO
	 yDwlZDuue5TMKCxDANZAslR7m58osBPxw7JbwaXQtHaq8qeEQeJyXX9uFFT0IkSUXQ
	 1cKxfFOnwO7NSUwOaJbmMiGmLHxcgQcm6Q9d5PwAgCNUBBq5jI/tCD62cacQRfkRg6
	 PBQl2KhbBLEUQ==
Message-ID: <c64ca6ae0f2d948f42b454c87ebcc58edee8bc3c.camel@kernel.org>
Subject: Re: [PATCH v7 3/3] NFSD: Sign filehandles
From: Jeff Layton <jlayton@kernel.org>
To: Benjamin Coddington <bcodding@hammerspace.com>, Chuck Lever
	 <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Trond Myklebust
	 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Eric Biggers
	 <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Date: Wed, 25 Feb 2026 07:10:45 -0500
In-Reply-To: <6ca1559957e3ebe3a96ac9553df621305a4b33ea.1771961922.git.bcodding@hammerspace.com>
References: <cover.1771961922.git.bcodding@hammerspace.com>
	 <6ca1559957e3ebe3a96ac9553df621305a4b33ea.1771961922.git.bcodding@hammerspace.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[hammerspace.com,oracle.com,brown.name,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78360-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C0AF41970B2
X-Rspamd-Action: no action

On Tue, 2026-02-24 at 14:41 -0500, Benjamin Coddington wrote:
> NFS clients may bypass restrictive directory permissions by using
> open_by_handle() (or other available OS system call) to guess the
> filehandles for files below that directory.
>=20
> In order to harden knfsd servers against this attack, create a method to
> sign and verify filehandles using SipHash-2-4 as a MAC (Message
> Authentication Code).  According to
> https://cr.yp.to/siphash/siphash-20120918.pdf, SipHash can be used as a
> MAC, and our use of SipHash-2-4 provides a low 1 in 2^64 chance of forger=
y.
>=20
> Filehandles that have been signed cannot be tampered with, nor can
> clients reasonably guess correct filehandles and hashes that may exist in
> parts of the filesystem they cannot access due to directory permissions.
>=20
> Append the 8 byte SipHash to encoded filehandles for exports that have se=
t
> the "sign_fh" export option.  Filehandles received from clients are
> verified by comparing the appended hash to the expected hash.  If the MAC
> does not match the server responds with NFS error _STALE.  If unsigned
> filehandles are received for an export with "sign_fh" they are rejected
> with NFS error _STALE.
>=20
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/filesystems/nfs/exporting.rst |  85 +++++++++++++
>  fs/nfsd/Kconfig                             |   2 +-
>  fs/nfsd/nfsfh.c                             | 127 +++++++++++++++++++-
>  fs/nfsd/trace.h                             |   1 +
>  4 files changed, 210 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/=
filesystems/nfs/exporting.rst
> index a01d9b9b5bc3..4aa59b0bf253 100644
> --- a/Documentation/filesystems/nfs/exporting.rst
> +++ b/Documentation/filesystems/nfs/exporting.rst
> @@ -206,3 +206,88 @@ following flags are defined:
>      all of an inode's dirty data on last close. Exports that behave this
>      way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
>      waiting for writeback when closing such files.
> +
> +Signed Filehandles
> +------------------
> +
> +To protect against filehandle guessing attacks, the Linux NFS server can=
 be
> +configured to sign filehandles with a Message Authentication Code (MAC).
> +
> +Standard NFS filehandles are often predictable. If an attacker can guess
> +a valid filehandle for a file they do not have permission to access via
> +directory traversal, they may be able to bypass path-based permissions
> +(though they still remain subject to inode-level permissions).
> +
> +Signed filehandles prevent this by appending a MAC to the filehandle
> +before it is sent to the client. Upon receiving a filehandle back from a
> +client, the server re-calculates the MAC using its internal key and
> +verifies it against the one provided. If the signatures do not match,
> +the server treats the filehandle as invalid (returning NFS[34]ERR_STALE)=
.
> +
> +Note that signing filehandles provides integrity and authenticity but
> +not confidentiality. The contents of the filehandle remain visible to
> +the client; they simply cannot be forged or modified.
> +
> +Configuration
> +~~~~~~~~~~~~~
> +
> +To enable signed filehandles, the administrator must provide a signing
> +key to the kernel and enable the "sign_fh" export option.
> +
> +1. Providing a Key
> +   The signing key is managed via the nfsd netlink interface. This key
> +   is per-network-namespace and must be set before any exports using
> +   "sign_fh" become active.
> +
> +2. Export Options
> +   The feature is controlled on a per-export basis in /etc/exports:
> +
> +   sign_fh
> +     Enables signing for all filehandles generated under this export.
> +
> +   no_sign_fh
> +     (Default) Disables signing.
> +
> +Key Management and Rotation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The security of this mechanism relies entirely on the secrecy of the
> +signing key.
> +
> +Initial Setup:
> +  The key should be generated using a high-quality random source and
> +  loaded early in the boot process or during the nfs-server startup
> +  sequence.
> +
> +Changing Keys:
> +  If a key is changed while clients have active mounts, existing
> +  filehandles held by those clients will become invalid, resulting in
> +  "Stale file handle" errors on the client side.
> +
> +Safe Rotation:
> +  Currently, there is no mechanism for "graceful" key rotation
> +  (maintaining multiple valid keys). Changing the key is an atomic
> +  operation that immediately invalidates all previous signatures.
> +
> +Transitioning Exports
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +When adding or removing the "sign_fh" flag from an active export, the
> +following behaviors should be expected:
> +
> ++-------------------+---------------------------------------------------=
+
> +| Change            | Result for Existing Clients                       =
|
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| Adding sign_fh    | Clients holding unsigned filehandles will find    =
|
> +|                   | them rejected, as the server now expects a        =
|
> +|                   | signature.                                        =
|
> ++-------------------+---------------------------------------------------=
+
> +| Removing sign_fh  | Clients holding signed filehandles will find them =
|
> +|                   | rejected, as the server now expects the           =
|
> +|                   | filehandle to end at its traditional boundary     =
|
> +|                   | without a MAC.                                    =
|
> ++-------------------+---------------------------------------------------=
+
> +
> +Because filehandles are often cached persistently by clients, adding or
> +removing this option should generally be done during a scheduled mainten=
ance
> +window involving a NFS client unmount/remount.
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index fc0e87eaa257..ffb76761d6a8 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -7,6 +7,7 @@ config NFSD
>  	select CRC32
>  	select CRYPTO_LIB_MD5 if NFSD_LEGACY_CLIENT_TRACKING
>  	select CRYPTO_LIB_SHA256 if NFSD_V4
> +	select CRYPTO # required by RPCSEC_GSS_KRB5 and signed filehandles
>  	select LOCKD
>  	select SUNRPC
>  	select EXPORTFS
> @@ -78,7 +79,6 @@ config NFSD_V4
>  	depends on NFSD && PROC_FS
>  	select FS_POSIX_ACL
>  	select RPCSEC_GSS_KRB5
> -	select CRYPTO # required by RPCSEC_GSS_KRB5
>  	select GRACE_PERIOD
>  	select NFS_V4_2_SSC_HELPER if NFS_V4_2
>  	help
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 68b629fbaaeb..383d04596627 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -11,6 +11,7 @@
>  #include <linux/exportfs.h>
> =20
>  #include <linux/sunrpc/svcauth_gss.h>
> +#include <crypto/utils.h>
>  #include "nfsd.h"
>  #include "vfs.h"
>  #include "auth.h"
> @@ -140,6 +141,110 @@ static inline __be32 check_pseudo_root(struct dentr=
y *dentry,
>  	return nfs_ok;
>  }
> =20
> +/* Size of a file handle MAC, in 4-octet words */
> +#define FH_MAC_WORDS (sizeof(__le64) / 4)
> +
> +static bool fh_append_mac(struct svc_fh *fhp, struct net *net)

I get build failures with this patch in place. This function is defined
here....

> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct knfsd_fh *fh =3D &fhp->fh_handle;
> +	siphash_key_t *fh_key =3D nn->fh_key;
> +	__le64 hash;
> +
> +	if (!fh_key)
> +		goto out_no_key;
> +	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize)
> +		goto out_no_space;
> +
> +	hash =3D cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size, fh_key));
> +	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
> +	fh->fh_size +=3D sizeof(hash);
> +	return true;
> +
> +out_no_key:
> +	pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not set.\=
n");
> +	return false;
> +
> +out_no_space:
> +	pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %zu woul=
d be greater than fh_maxsize %d.\n",
> +			    fh->fh_size + sizeof(hash), fhp->fh_maxsize);
> +	return false;
> +}
> +
> +/*
> + * Verify that the filehandle's MAC was hashed from this filehandle
> + * given the server's fh_key:
> + */
> +static bool fh_verify_mac(struct svc_fh *fhp, struct net *net)
> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct knfsd_fh *fh =3D &fhp->fh_handle;
> +	siphash_key_t *fh_key =3D nn->fh_key;
> +	__le64 hash;
> +
> +	if (!fh_key) {
> +		pr_warn_ratelimited("NFSD: unable to verify signed filehandles, fh_key=
 not set.\n");
> +		return false;
> +	}
> +
> +	hash =3D cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  =
fh_key));
> +	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)],
> +					&hash, sizeof(hash)) =3D=3D 0;
> +}
> +
> +/*
> + * Append an 8-byte MAC to the filehandle hashed from the server's fh_ke=
y:
> + */
> +#define FH_MAC_WORDS sizeof(__le64)/4
> +static bool fh_append_mac(struct svc_fh *fhp, struct net *net)


...and here, and the compiler doesn't seem to like that.

> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct knfsd_fh *fh =3D &fhp->fh_handle;
> +	siphash_key_t *fh_key =3D nn->fh_key;
> +	__le64 hash;
> +
> +	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
> +		return true;
> +
> +	if (!fh_key) {
> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not set.=
\n");
> +		return false;
> +	}
> +
> +	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d woul=
d be greater"
> +			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)), fhp->fh_=
maxsize);
> +		return false;
> +	}
> +
> +	hash =3D cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size, fh_key));
> +	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
> +	fh->fh_size +=3D sizeof(hash);
> +
> +	return true;
> +}
> +
> +/*
> + * Verify that the filehandle's MAC was hashed from this filehandle
> + * given the server's fh_key:
> + */
> +static bool fh_verify_mac(struct svc_fh *fhp, struct net *net)
> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct knfsd_fh *fh =3D &fhp->fh_handle;
> +	siphash_key_t *fh_key =3D nn->fh_key;
> +	__le64 hash;
> +
> +	if (!fh_key) {
> +		pr_warn_ratelimited("NFSD: unable to verify signed filehandles, fh_key=
 not set.\n");
> +		return false;
> +	}
> +
> +	hash =3D cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  =
fh_key));
> +	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)],
> +					&hash, sizeof(hash)) =3D=3D 0;
> +}
> +
>  /*
>   * Use the given filehandle to look up the corresponding export and
>   * dentry.  On success, the results are used to set fh_export and
> @@ -236,13 +341,21 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *r=
qstp, struct net *net,
>  	/*
>  	 * Look up the dentry using the NFS file handle.
>  	 */
> -	error =3D nfserr_badhandle;
> -
>  	fileid_type =3D fh->fh_fileid_type;
> +	error =3D nfserr_stale;
> =20
> -	if (fileid_type =3D=3D FILEID_ROOT)
> +	if (fileid_type =3D=3D FILEID_ROOT) {
> +		/* We don't sign or verify the root, no per-file identity */
>  		dentry =3D dget(exp->ex_path.dentry);
> -	else {
> +	} else {
> +		if (exp->ex_flags & NFSEXP_SIGN_FH) {
> +			if (!fh_verify_mac(fhp, net)) {
> +				trace_nfsd_set_fh_dentry_badmac(rqstp, fhp, -ESTALE);
> +				goto out;
> +			}
> +			data_left -=3D FH_MAC_WORDS;
> +		}
> +
>  		dentry =3D exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
>  						data_left, fileid_type, 0,
>  						nfsd_acceptable, exp);
> @@ -258,6 +371,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqs=
tp, struct net *net,
>  			}
>  		}
>  	}
> +
> +	error =3D nfserr_badhandle;
>  	if (dentry =3D=3D NULL)
>  		goto out;
>  	if (IS_ERR(dentry)) {
> @@ -498,6 +613,10 @@ static void _fh_update(struct svc_fh *fhp, struct sv=
c_export *exp,
>  		fhp->fh_handle.fh_fileid_type =3D
>  			fileid_type > 0 ? fileid_type : FILEID_INVALID;
>  		fhp->fh_handle.fh_size +=3D maxsize * 4;
> +
> +		if (exp->ex_flags & NFSEXP_SIGN_FH)
> +			if (!fh_append_mac(fhp, exp->cd->net))
> +				fhp->fh_handle.fh_fileid_type =3D FILEID_INVALID;
>  	} else {
>  		fhp->fh_handle.fh_fileid_type =3D FILEID_ROOT;
>  	}
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 185a998996a0..5ad38f50836d 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -373,6 +373,7 @@ DEFINE_EVENT_CONDITION(nfsd_fh_err_class, nfsd_##name=
,	\
> =20
>  DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badexport);
>  DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badhandle);
> +DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badmac);
> =20
>  TRACE_EVENT(nfsd_exp_find_key,
>  	TP_PROTO(const struct svc_expkey *key,

--=20
Jeff Layton <jlayton@kernel.org>

