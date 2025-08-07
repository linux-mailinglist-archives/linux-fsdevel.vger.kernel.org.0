Return-Path: <linux-fsdevel+bounces-56964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E97AB1D45E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 10:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E341A62846B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 08:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99727256C87;
	Thu,  7 Aug 2025 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LnUmBl1Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB8A233136;
	Thu,  7 Aug 2025 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754556071; cv=none; b=dCn1TKc532ka3pS48G5+1I26M6dptWdGOJEdqLcUNPB4DoO5JTMEUv0eS+Jz3SebmS79hH7a5eMbzAIBOYWZS4a6zutQJTuVmtJrc40+XXZdRvjYAz/I1aNJW2znhbZKXHCsihFlN4VsT4QCgen7AG0IPlYMOMxw2vueiyB0bsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754556071; c=relaxed/simple;
	bh=29/0/D42/WwMJ2+ruqP8oXlKefinLhx/lRUtc4cP/kU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E41DVD34a78bcsi7mLc8XDitx3T18UVab0xwtXm2jopG512qBXJe+epUPYu3Sfc1/+KTmhZ59ZZu3mcpndBMwgCsrgk9bHpSp3zcK7uJXVLGODCxssUuGuMDlXfBS5/KbZFuErIZx1245aCXBQ1re7gW07bqo214558najORNT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LnUmBl1Z; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YSbYWHuNmw8y1RdYInOumWjpEswg0F29surRDM+7eW0=; b=LnUmBl1ZkjfES3scO0WN9jKW6E
	zDJTk55GVnoBGbPwyZCkF3Q5bFYld87AAgnEuCVC1g5PKf8ymlitAy4SJH7Uy45tbqMxvMSuxPpX9
	9grXKs31pNJYpx4zR9Nz7ZlXmqtR4ckKZu5aD8Ux650Bi2vGz4kYSQjrOLlYr+yZi6wJlxHmq6kQR
	GveqUgLoXvXKc7K3Bx4xvB5tRPUnUtmyvMEHQZSaUDaoEyOK4QJCRAVopGPeeDvFjARS+KAeoX1Kk
	iF8UCZNwEy+IulVHPTnLjz8BJNJQ0SlMx9SqrnTieDo25gXAClBRBg3oIAzN40GbEczTxHm5rtF9H
	HBZbRKTw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ujwBI-00Auyx-Nd; Thu, 07 Aug 2025 10:41:00 +0200
From: Luis Henriques <luis@igalia.com>
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: miklos@szeredi.hu,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: Move same-superblock check to fuse_copy_file_range
In-Reply-To: <20250806135254.352-1-luochunsheng@ustc.edu> (Chunsheng Luo's
	message of "Wed, 6 Aug 2025 21:52:54 +0800")
References: <20250806135254.352-1-luochunsheng@ustc.edu>
Date: Thu, 07 Aug 2025 09:40:55 +0100
Message-ID: <87bjorle20.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06 2025, Chunsheng Luo wrote:

> The copy_file_range COPY_FILE_SPLICE capability allows filesystems to
> handle cross-superblock copy. However, in the current fuse implementation,
> __fuse_copy_file_range accesses src_file->private_data under the assumpti=
on
> that it points to a fuse_file structure. When the source file belongs to a
> non-FUSE filesystem, it will leads to kernel panics.

I wonder if you have actually seen this kernel panic happening.  It seems
like the code you're moving into fuse_copy_file_range() shouldn't be
needed as the same check is already done in generic_copy_file_checks()
(which is called from vfs_copy_file_range()).

Either way, I think your change to fuse_copy_file_range() could be
simplified with something like:

	ssize_t ret =3D -EXDEV;

	if (file_inode(src_file)->i_sb =3D=3D file_inode(dst_file)->i_sb)
		ret =3D __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
					     len, flags);

	if (ret =3D=3D -EOPNOTSUPP || ret =3D=3D -EXDEV)
		ret =3D splice_copy_file_range(src_file, src_off, dst_file,
					     dst_off, len);

But again, my understanding is that this should never happen in practice
and that the superblock check could even be removed from
__fuse_copy_file_range().

Cheers,
--=20
Lu=C3=ADs

>
> To resolve this, move the same-superblock check from __fuse_copy_file_ran=
ge
> to fuse_copy_file_range to ensure both files belong to the same fuse
> superblock before accessing private_data.
>
> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
> ---
>  fs/fuse/file.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 95275a1e2f54..a29f1b84f11b 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2984,9 +2984,6 @@ static ssize_t __fuse_copy_file_range(struct file *=
file_in, loff_t pos_in,
>  	if (fc->no_copy_file_range)
>  		return -EOPNOTSUPP;
>=20=20
> -	if (file_inode(file_in)->i_sb !=3D file_inode(file_out)->i_sb)
> -		return -EXDEV;
> -
>  	inode_lock(inode_in);
>  	err =3D fuse_writeback_range(inode_in, pos_in, pos_in + len - 1);
>  	inode_unlock(inode_in);
> @@ -3066,9 +3063,12 @@ static ssize_t fuse_copy_file_range(struct file *s=
rc_file, loff_t src_off,
>  {
>  	ssize_t ret;
>=20=20
> +	if (file_inode(src_file)->i_sb !=3D file_inode(dst_file)->i_sb)
> +		return splice_copy_file_range(src_file, src_off, dst_file,
> +					     dst_off, len);
> +
>  	ret =3D __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
>  				     len, flags);
> -
>  	if (ret =3D=3D -EOPNOTSUPP || ret =3D=3D -EXDEV)
>  		ret =3D splice_copy_file_range(src_file, src_off, dst_file,
>  					     dst_off, len);
> --=20
> 2.43.0
>


