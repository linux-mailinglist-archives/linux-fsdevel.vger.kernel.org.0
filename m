Return-Path: <linux-fsdevel+bounces-41776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82589A36E2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 13:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E15F1895465
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 12:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AFF1C7001;
	Sat, 15 Feb 2025 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2zAbfZp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BF8748D;
	Sat, 15 Feb 2025 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739623305; cv=none; b=UppqY2xAGKEcMb1NMre3WA9hBJil9cNGgADKgQNkG0UtJ5j9O+IQNetyv66k5MuzAxba2Ty8B4Qcvr8tB+mXI0ZuhlVplckqkAnoZAhfw6sxkeMBDhtM0ebaRrwxF6PKjX+u7qhsdAAVLmLBsreu6s0P4r+LGn/wSpysnaYMqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739623305; c=relaxed/simple;
	bh=hTRcluaXCD4NbfY/iwIWF7OPNbAWEt9IUSJEOK1Ncic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B7P5h9+YXQWydw4PBzfaMJn9COV0ycC8JDglpAo1DryTNsh/PoojAaAFz2fP1AI/TMEIW8NNzxttUMAUs4fKISvmAFkjZLlKxkNvwTrMxNXghXutSuTspEc0wHbKvgU00FK0iKY74wKLRQHtbJOTNRdL7/+FF8ZKQfizjva045c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2zAbfZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D719FC4CEDF;
	Sat, 15 Feb 2025 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739623304;
	bh=hTRcluaXCD4NbfY/iwIWF7OPNbAWEt9IUSJEOK1Ncic=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=W2zAbfZp33zLD+9nsL1L2FNdMtoPRt7aKwwKsrq8GvD6wPKmpOM9oI7V/ijbggfpF
	 eAXlGq1PLsSdplakKzKnypR5pvA8El2rFa5F20T5CWL0jdQRChyg6RgQOqrlI/MaqD
	 PEXiaYGxr4ypFgpmhC36DzHbbMEoe8lvZV8Bc7VT0Z8EJfO0gmn2DfD4Dh56T9/TY4
	 47XE7gzhGHtJF00S2LuYkc/nKzzjQJaI8Ud6t6WMf3VkP8oIIUt7igUTIklWPm5xO0
	 oTQD+dbkaTQ5TEMKVPcXN5B+nsPdqHxc/YbGMZ/x8nI47mghtDcTxEl8iQOPV2TL7m
	 RYC8QfwDBcacw==
Message-ID: <e28efa280c28e4b577d561f6e7dae72c0fd06be5.camel@kernel.org>
Subject: Re: [PATCH 1/2] prep for ceph_encode_encrypted_fname() fixes
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, Luis Henriques <luis@igalia.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Ilya Dryomov
	 <idryomov@gmail.com>
Date: Sat, 15 Feb 2025 07:41:42 -0500
In-Reply-To: <20250215044714.GA3451131@ZenIV>
References: <20250214024756.GY1977892@ZenIV>
	 <20250214032820.GZ1977892@ZenIV>
	 <bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org>
	 <87frkg7bqh.fsf@igalia.com> <20250215044616.GF1977892@ZenIV>
	 <20250215044714.GA3451131@ZenIV>
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
> ceph_encode_encrypted_dname() would be better off with plaintext name
> already copied into buffer; we'll lift that into the callers on the
> next step, which will allow to fix UAF on races with rename; for now
> copy it in the very beginning of ceph_encode_encrypted_dname().
>=20
> That has a pleasant side benefit - we don't need to mess with tmp_buf
> anymore (i.e. that's 256 bytes off the stack footprint).
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/ceph/crypto.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
>=20
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index 3b3c4d8d401e..09346b91215a 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -265,31 +265,28 @@ int ceph_encode_encrypted_dname(struct inode *paren=
t, struct qstr *d_name,
>  {
>  	struct ceph_client *cl =3D ceph_inode_to_client(parent);
>  	struct inode *dir =3D parent;
> -	struct qstr iname;
> +	char *p =3D buf;
>  	u32 len;
>  	int name_len;
>  	int elen;
>  	int ret;
>  	u8 *cryptbuf =3D NULL;
> =20
> -	iname.name =3D d_name->name;
> -	name_len =3D d_name->len;
> +	memcpy(buf, d_name->name, d_name->len);
> +	elen =3D d_name->len;
> +
> +	name_len =3D elen;
> =20
>  	/* Handle the special case of snapshot names that start with '_' */
> -	if ((ceph_snap(dir) =3D=3D CEPH_SNAPDIR) && (name_len > 0) &&
> -	    (iname.name[0] =3D=3D '_')) {
> -		dir =3D parse_longname(parent, iname.name, &name_len);
> +	if (ceph_snap(dir) =3D=3D CEPH_SNAPDIR && *p =3D=3D '_') {
> +		dir =3D parse_longname(parent, p, &name_len);
>  		if (IS_ERR(dir))
>  			return PTR_ERR(dir);
> -		iname.name++; /* skip initial '_' */
> +		p++; /* skip initial '_' */
>  	}
> -	iname.len =3D name_len;
> =20
> -	if (!fscrypt_has_encryption_key(dir)) {
> -		memcpy(buf, d_name->name, d_name->len);
> -		elen =3D d_name->len;
> +	if (!fscrypt_has_encryption_key(dir))
>  		goto out;
> -	}
> =20
>  	/*
>  	 * Convert cleartext d_name to ciphertext. If result is longer than
> @@ -297,7 +294,7 @@ int ceph_encode_encrypted_dname(struct inode *parent,=
 struct qstr *d_name,
>  	 *
>  	 * See: fscrypt_setup_filename
>  	 */
> -	if (!fscrypt_fname_encrypted_size(dir, iname.len, NAME_MAX, &len)) {
> +	if (!fscrypt_fname_encrypted_size(dir, name_len, NAME_MAX, &len)) {
>  		elen =3D -ENAMETOOLONG;
>  		goto out;
>  	}
> @@ -310,7 +307,9 @@ int ceph_encode_encrypted_dname(struct inode *parent,=
 struct qstr *d_name,
>  		goto out;
>  	}
> =20
> -	ret =3D fscrypt_fname_encrypt(dir, &iname, cryptbuf, len);
> +	ret =3D fscrypt_fname_encrypt(dir,
> +				    &(struct qstr)QSTR_INIT(p, name_len),
> +				    cryptbuf, len);
>  	if (ret) {
>  		elen =3D ret;
>  		goto out;
> @@ -331,18 +330,13 @@ int ceph_encode_encrypted_dname(struct inode *paren=
t, struct qstr *d_name,
>  	}
> =20
>  	/* base64 encode the encrypted name */
> -	elen =3D ceph_base64_encode(cryptbuf, len, buf);
> -	doutc(cl, "base64-encoded ciphertext name =3D %.*s\n", elen, buf);
> +	elen =3D ceph_base64_encode(cryptbuf, len, p);
> +	doutc(cl, "base64-encoded ciphertext name =3D %.*s\n", elen, p);
> =20
>  	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
>  	WARN_ON(elen > 240);
> -	if ((elen > 0) && (dir !=3D parent)) {
> -		char tmp_buf[NAME_MAX];
> -
> -		elen =3D snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
> -				elen, buf, dir->i_ino);
> -		memcpy(buf, tmp_buf, elen);
> -	}
> +	if (dir !=3D parent) // leading _ is already there; append _<inum>
> +		elen +=3D 1 + sprintf(p + elen, "_%ld", dir->i_ino);
> =20
>  out:
>  	kfree(cryptbuf);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

