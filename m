Return-Path: <linux-fsdevel+bounces-38484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C643EA0326B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 23:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F6F3A4E68
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 22:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC131E0DEE;
	Mon,  6 Jan 2025 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on6pmF3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4E11E0DD0;
	Mon,  6 Jan 2025 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736200895; cv=none; b=Ar69CGrDviyflNVhJrjESqpLexKpuCBKwjhVgZ4K2P3OQLmb+6MDDP95FOnvT5URrT7uAkMb3VECxiCmbemokoUQBX/vwuK6vESUKfFo1ldbnSKk/6ye5cHs3mc2qpSXSIdF6+xsVLIUeDhjAV0m1afB1hiLqNhSSrpWPLLOijY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736200895; c=relaxed/simple;
	bh=S2QpiZGspdAdj3+qLUTQA5K+9H4mlRwZcICOV9quZqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohPDtq563cBGz7+rVfDhx9Ddjg3hihp8uH4wscHpjMoZCdGjTcy0LT63/WdEL2NaiHOgQrnfF93ERv3nRKet4cIBtFEfPVQDwG9K5FLXeR2Xzxv7l9lnNskniMHCB0f98/tLom2v7apAZomHidBsjGEhUiCCrtrfJT+pNYhUsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on6pmF3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF03CC4CED2;
	Mon,  6 Jan 2025 22:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736200895;
	bh=S2QpiZGspdAdj3+qLUTQA5K+9H4mlRwZcICOV9quZqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=on6pmF3iIyL5HkSnbBKNp6n129URPEwx4FrNNyKapkIvKskMmgGMVYYC8fCpSlPeF
	 u4V+sJ6UejHDjxSB5jxWvgvBPeZbM9lsntDxS1FCqY2Rft0IWdFoOBGU5iMdxNbUmi
	 8GBVOjzPMQow8YiTM6besGnNT+pBgHDGZz8BqGqxd79ENlGwT0lrjNzaQiZRlg1BPY
	 ElESiceu7si03B7OB+4dq02s0smSNp/kevkxyFxScxt7cuwiNBrV0z5EpLTvqpRC68
	 kGWwCctyNs/4gbgDRhfg6pD8pLAec4JIz2q+g9a6SqOt+BJWz/RBO+2hHojRGoU9yW
	 zoPe9SVDJ54aQ==
Date: Mon, 6 Jan 2025 23:01:34 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Hongbo Li <lihongbo22@huawei.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH] statx.2: document STATX_DIO_READ_ALIGN
Message-ID: <v53wfbop4gkwjaptg2vppcooeoqlp2wcb3uret6hopuqisxqif@xtpgtzrgiv64>
References: <20250106151607.954940-1-hch@lst.de>
 <20250106151938.GA27324@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="toqkwwn2i3pvzsuk"
Content-Disposition: inline
In-Reply-To: <20250106151938.GA27324@lst.de>


--toqkwwn2i3pvzsuk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Hongbo Li <lihongbo22@huawei.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: Re: [PATCH] statx.2: document STATX_DIO_READ_ALIGN
References: <20250106151607.954940-1-hch@lst.de>
 <20250106151938.GA27324@lst.de>
MIME-Version: 1.0
In-Reply-To: <20250106151938.GA27324@lst.de>

Hi Christoph,

On Mon, Jan 06, 2025 at 04:19:38PM +0100, Christoph Hellwig wrote:
> Document the new STATX_DIO_READ_ALIGN flag and the new
> stx_dio_read_offset_align field guarded by it.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for the patch!  Please see some minor comments below.

Have a lovely night!
Alex

> ---
>  man/man2/statx.2 | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index c5b5a28ec2f1..378bf363d93f 100644
> --- a/man/man2/statx.2
> +++ b/man/man2/statx.2
> @@ -76,6 +76,9 @@ struct statx {
>      __u32 stx_atomic_write_unit_min;
>      __u32 stx_atomic_write_unit_max;
>      __u32 stx_atomic_write_segments_max;
> +
> +    /* File offset alignment for direct I/O reads */
> +    __u32   stx_dio_read_offset_align;
>  };
>  .EE
>  .in
> @@ -261,7 +264,7 @@ STATX_BTIME	Want stx_btime
>  STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
>  	It is deprecated and should not be used.
>  STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
> -STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
> +STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align.
>  	(since Linux 6.1; support varies by filesystem)
>  STATX_MNT_ID_UNIQUE	Want unique stx_mnt_id (since Linux 6.8)
>  STATX_SUBVOL	Want stx_subvol
> @@ -270,6 +273,8 @@ STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min,
>  	stx_atomic_write_unit_max,
>  	and stx_atomic_write_segments_max.
>  	(since Linux 6.11; support varies by filesystem)
> +STATX_DIO_READ_ALIGN	Want stx_dio_read_offset_align.
> +	(since Linux 6.14; support varies by filesystem)
>  .TE
>  .in
>  .P
> @@ -467,6 +472,26 @@ This will only be nonzero if
>  .I stx_dio_mem_align
>  is nonzero, and vice versa.
>  .TP
> +.I stx_dio_read_offset_align
> +The alignment (in bytes) required for file offsets and I/O segment lengt=
hs for
> +direct I/O reads
> +.RB ( O_DIRECT )
> +on this file.  If zero the limit in

Please write poems, not prose.  :)

In other words, new sentence, new line.  See man-pages(7).

$ MANWIDTH=3D72 man man-pages | sed -n '/Use semantic newlines/,/^$/p'
   Use semantic newlines
     In the source of a manual page, new sentences should be started on
     new lines, long sentences should be split  into  lines  at  clause
     breaks  (commas,  semicolons, colons, and so on), and long clauses
     should be split at phrase boundaries.  This convention,  sometimes
     known as "semantic newlines", makes it easier to see the effect of
     patches, which often operate at the level of individual sentences,
     clauses, or phrases.

> +.I
> +stx_dio_offset_align

We put the italics word in the same line as the .I.

> +applies for reads as well.  If non-zero this value must be
> +smaller than
> +.I
> +stx_dio_offset_align
> +which must be provided by the file system.
> +This value does not affect the memory alignent in
> +.I stx_dio_mem_align .
> +.IP
> +.B STATX_DIO_READ_ALIGN
> +.I ( stx_dio_offset_align )

You probably meant .RI (roman-italics alternating).

> +support by filesystem;
> +it is supported by xfs since Linux 6.14.
> +.TP
>  .I stx_subvol
>  Subvolume number of the current file.
>  .IP
> --=20
> 2.45.2
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--toqkwwn2i3pvzsuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmd8Ur4ACgkQnowa+77/
2zLv8BAAnNftXiOmD+T+yg5Z7i+ZS+CkNjevuv6jJaQn/egxcN9uRWcmmoWaqMds
XvDZ9tEwPlWUk8CEgf1G7IKhvPQs5KlBQDZ/R9V2ubuoo2jMxIaPzEY8egztlA/2
LFy4RVN4jsjaJvM5/efTrvksaxiqdYS7NYqb6tt2nYW6uJszKJmzAfcKI61WuGz6
iYZAGWkvgxaV5cHXd8PhJWGcZCgPR4Wr9DL47btZgXONsNAFarKjJqEP5o1BFlXy
Qss36MvpCM0TYd1EvdHlcm+sAEop1TR5Ax7JBGmcj1FXXd4H05EsTl0UrV3XYzlX
ItZeZtjojr/ZfvBjmWqn3H7MobYtQtwbLP3DnsvgsxYnz7l1NupNhmQTtCwLEDv0
gr+DFXdB+wX/meBOlG3s7jVRx0fogNDbPPT8Cf9Z8yC9BWrm9Oc92O15FYI3jqO7
UmI93XovGSfeW1QFm+SoYBM4na2FxppLJttSkbiOliiynNzQ83XGXYHGwryRpoN+
UF7PPRCbIwskbrefIi6O5qJ9Kp9ipyy0PQlsqHlqz/TuWfnCuiEUY101TvyZFTbU
o2YQb3Mrcr6McO1foOrZp89+IrrWjFaoXYuoYqcV0gagm9IA7CoLHYnmeVEkalNn
gKQtkWDbXJcbiRX0hIAvDEGQ4hLU0hQ9KfKHZBNh+iLwa/BB7vs=
=5ZsW
-----END PGP SIGNATURE-----

--toqkwwn2i3pvzsuk--

