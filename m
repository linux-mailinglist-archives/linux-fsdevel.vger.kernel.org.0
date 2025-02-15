Return-Path: <linux-fsdevel+bounces-41777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A61A36E31
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 13:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D7B3A77FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 12:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3756F1C7001;
	Sat, 15 Feb 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klwOJOf5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928501C32EA;
	Sat, 15 Feb 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739623330; cv=none; b=Kqp33vhAt9xbUsskOkponPXywwepDa1hi2EbmzuxbMRtDECOlOD9p0pdWp8srN5DNI/l0AxQDs4VYWzDqxmaWVaK/UWtNIcF7hv5KC3colE+NZI59vBctaTSZ20D/xDbyp5PyHHkqmp4DTHb6IDb3NKFRAssQW1pf/qHDja8dfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739623330; c=relaxed/simple;
	bh=BGHdrvNxNW8n+ipxhNxTtcCNXxWdsA7gFU1jZcbsD2M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=taAXsLRg4y7+KvTFU11eVQ3WtsaeGsx2+YTRLsmah80NWz6dnR3kLaU/4hDQRXgWJjkbENV4GZtJG5AN61sEKdTuM7zFFtRWURBdG+QsyLSihh1ahA870TGFU6Q+CXDzCxtBST7CUI+R4B1kD0EZNFqs+cyaQHTX+IDMtnzGh5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klwOJOf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B41C4CEDF;
	Sat, 15 Feb 2025 12:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739623329;
	bh=BGHdrvNxNW8n+ipxhNxTtcCNXxWdsA7gFU1jZcbsD2M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=klwOJOf5bXGICgbx82cXpIOy1DJ0JP9lRLQxLqQxo5Up/ZZpdemw+Dc8XBPBjwScv
	 KrC81arfPBmftNU7r6DMaZFXiP9eUMBBk1ey3QDdXtSyl51I2Khce/6tjnnnKpWdaT
	 t7UvFW/ay3ePHmjjd4INcDYYmdmU1kCIKwFojdWjlESr+B8yYwpX4Sd2ZdqbBv2Yu6
	 ThjfvuVu3bTa73FibTRurRznFXZpBE1fJQiy1Q3KmFT6qs3L5TfEFK079q04fE4Nl6
	 z1t43ToPZ6avCznHVUt2fN7gkgaWO+G+Ugcklf0y6PPJ0gfKFPpl6QLKbdV53+tSbj
	 A5eh2i3X7JhVg==
Message-ID: <9c6cc68f98ff5c35a419b9a85405e3f83f872a86.camel@kernel.org>
Subject: Re: [PATCH 2/2] ceph: fix a race with rename() in
 ceph_mdsc_build_path()
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, Luis Henriques <luis@igalia.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Ilya Dryomov
	 <idryomov@gmail.com>
Date: Sat, 15 Feb 2025 07:42:07 -0500
In-Reply-To: <20250215044739.GB3451131@ZenIV>
References: <20250214024756.GY1977892@ZenIV>
	 <20250214032820.GZ1977892@ZenIV>
	 <bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org>
	 <87frkg7bqh.fsf@igalia.com> <20250215044616.GF1977892@ZenIV>
	 <20250215044739.GB3451131@ZenIV>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-02-15 at 04:47 +0000, Al Viro wrote:
> Lift copying the name into callers of ceph_encode_encrypted_dname()
> that do not have it already copied; ceph_encode_encrypted_fname()
> disappears.
>=20
> That fixes a UAF in ceph_mdsc_build_path() - while the initial copy
> of plaintext into buf is done under ->d_lock, we access the
> original name again in ceph_encode_encrypted_fname() and that is
> done without any locking.  With ceph_encode_encrypted_dname() using
> the stable copy the problem goes away.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/ceph/caps.c       | 18 +++++++-----------
>  fs/ceph/crypto.c     | 20 +++-----------------
>  fs/ceph/crypto.h     | 18 ++++--------------
>  fs/ceph/dir.c        |  7 +++----
>  fs/ceph/mds_client.c |  4 ++--
>  5 files changed, 19 insertions(+), 48 deletions(-)
>=20
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index a8d8b56cf9d2..b1a8ff612c41 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -4957,24 +4957,20 @@ int ceph_encode_dentry_release(void **p, struct d=
entry *dentry,
>  	cl =3D ceph_inode_to_client(dir);
>  	spin_lock(&dentry->d_lock);
>  	if (ret && di->lease_session && di->lease_session->s_mds =3D=3D mds) {
> +		int len =3D dentry->d_name.len;
>  		doutc(cl, "%p mds%d seq %d\n",  dentry, mds,
>  		      (int)di->lease_seq);
>  		rel->dname_seq =3D cpu_to_le32(di->lease_seq);
>  		__ceph_mdsc_drop_dentry_lease(dentry);
> +		memcpy(*p, dentry->d_name.name, len);
>  		spin_unlock(&dentry->d_lock);
>  		if (IS_ENCRYPTED(dir) && fscrypt_has_encryption_key(dir)) {
> -			int ret2 =3D ceph_encode_encrypted_fname(dir, dentry, *p);
> -
> -			if (ret2 < 0)
> -				return ret2;
> -
> -			rel->dname_len =3D cpu_to_le32(ret2);
> -			*p +=3D ret2;
> -		} else {
> -			rel->dname_len =3D cpu_to_le32(dentry->d_name.len);
> -			memcpy(*p, dentry->d_name.name, dentry->d_name.len);
> -			*p +=3D dentry->d_name.len;
> +			len =3D ceph_encode_encrypted_dname(dir, *p, len);
> +			if (len < 0)
> +				return len;
>  		}
> +		rel->dname_len =3D cpu_to_le32(len);
> +		*p +=3D len;
>  	} else {
>  		spin_unlock(&dentry->d_lock);
>  	}
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index 09346b91215a..76a4a7e60270 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -260,23 +260,17 @@ static struct inode *parse_longname(const struct in=
ode *parent,
>  	return dir;
>  }
> =20
> -int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_nam=
e,
> -				char *buf)
> +int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int ele=
n)
>  {
>  	struct ceph_client *cl =3D ceph_inode_to_client(parent);
>  	struct inode *dir =3D parent;
>  	char *p =3D buf;
>  	u32 len;
> -	int name_len;
> -	int elen;
> +	int name_len =3D elen;
>  	int ret;
>  	u8 *cryptbuf =3D NULL;
> =20
> -	memcpy(buf, d_name->name, d_name->len);
> -	elen =3D d_name->len;
> -
> -	name_len =3D elen;
> -
> +	buf[elen] =3D '\0';
>  	/* Handle the special case of snapshot names that start with '_' */
>  	if (ceph_snap(dir) =3D=3D CEPH_SNAPDIR && *p =3D=3D '_') {
>  		dir =3D parse_longname(parent, p, &name_len);
> @@ -349,14 +343,6 @@ int ceph_encode_encrypted_dname(struct inode *parent=
, struct qstr *d_name,
>  	return elen;
>  }
> =20
> -int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *den=
try,
> -				char *buf)
> -{
> -	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
> -
> -	return ceph_encode_encrypted_dname(parent, &dentry->d_name, buf);
> -}
> -
>  /**
>   * ceph_fname_to_usr - convert a filename for userland presentation
>   * @fname: ceph_fname to be converted
> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> index d0768239a1c9..f752bbb2eb06 100644
> --- a/fs/ceph/crypto.h
> +++ b/fs/ceph/crypto.h
> @@ -102,10 +102,7 @@ int ceph_fscrypt_prepare_context(struct inode *dir, =
struct inode *inode,
>  				 struct ceph_acl_sec_ctx *as);
>  void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req,
>  				struct ceph_acl_sec_ctx *as);
> -int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_nam=
e,
> -				char *buf);
> -int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *den=
try,
> -				char *buf);
> +int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int len=
);
> =20
>  static inline int ceph_fname_alloc_buffer(struct inode *parent,
>  					  struct fscrypt_str *fname)
> @@ -194,17 +191,10 @@ static inline void ceph_fscrypt_as_ctx_to_req(struc=
t ceph_mds_request *req,
>  {
>  }
> =20
> -static inline int ceph_encode_encrypted_dname(struct inode *parent,
> -					      struct qstr *d_name, char *buf)
> +static inline int ceph_encode_encrypted_dname(struct inode *parent, char=
 *buf,
> +					      int len)
>  {
> -	memcpy(buf, d_name->name, d_name->len);
> -	return d_name->len;
> -}
> -
> -static inline int ceph_encode_encrypted_fname(struct inode *parent,
> -					      struct dentry *dentry, char *buf)
> -{
> -	return -EOPNOTSUPP;
> +	return len;
>  }
> =20
>  static inline int ceph_fname_alloc_buffer(struct inode *parent,
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 62e99e65250d..539954e2ea38 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -422,17 +422,16 @@ static int ceph_readdir(struct file *file, struct d=
ir_context *ctx)
>  			req->r_inode_drop =3D CEPH_CAP_FILE_EXCL;
>  		}
>  		if (dfi->last_name) {
> -			struct qstr d_name =3D { .name =3D dfi->last_name,
> -					       .len =3D strlen(dfi->last_name) };
> +			int len =3D strlen(dfi->last_name);
> =20
>  			req->r_path2 =3D kzalloc(NAME_MAX + 1, GFP_KERNEL);
>  			if (!req->r_path2) {
>  				ceph_mdsc_put_request(req);
>  				return -ENOMEM;
>  			}
> +			memcpy(req->r_path2, dfi->last_name, len);
> =20
> -			err =3D ceph_encode_encrypted_dname(inode, &d_name,
> -							  req->r_path2);
> +			err =3D ceph_encode_encrypted_dname(inode, req->r_path2, len);
>  			if (err < 0) {
>  				ceph_mdsc_put_request(req);
>  				return err;
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 54b3421501e9..7dc854631b55 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2766,8 +2766,8 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *=
mdsc, struct dentry *dentry,
>  			}
> =20
>  			if (fscrypt_has_encryption_key(d_inode(parent))) {
> -				len =3D ceph_encode_encrypted_fname(d_inode(parent),
> -								  cur, buf);
> +				len =3D ceph_encode_encrypted_dname(d_inode(parent),
> +								  buf, len);
>  				if (len < 0) {
>  					dput(parent);
>  					dput(cur);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

