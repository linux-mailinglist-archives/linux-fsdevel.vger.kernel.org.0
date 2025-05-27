Return-Path: <linux-fsdevel+bounces-49937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17547AC5D5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 00:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74924A8746
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 22:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3534E217F56;
	Tue, 27 May 2025 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="tb9jfkzG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E020E6E3
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748385992; cv=none; b=pughWuOuhXKmByU7egXqti//6VKh8IzXAp/gLlcpiPHyMVWzwuOs/G4VP4PezD7+72kt2WCDQq9JWs+O3N5kssZ9kxewVlXQ8Vp9AB8TQC/evUeYJ/SOf0lAFtHmEGsjp/ld2aFuyHoRnIQ44SczJohIPhWxD/f4+pCef8qVuCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748385992; c=relaxed/simple;
	bh=lOUqnh6zlgBeQIUb30emAgDDxUWBy/K7XzQ/IAOJ10w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r5Iexw0Fui5YTJohTn4jHQPRTVhy7YE59QrI+zpPTeo7gOYwVxp9iXttGVhscQJzi3PUduc+eBG2uKXBCuvjl3Jz0a1cd4X4Mua7/n+02nsjouxHVg4BzGI+3TuEJYV4oFEPyJxBmum1ObW/83r4xni2DkMYsSMyMp+vRjkKHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=tb9jfkzG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso4158559b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1748385990; x=1748990790; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iEWlqUp6AjwrQz8VBkkI6kcZdrVT9V6EgrDsAu2VRl4=;
        b=tb9jfkzGOuJzmEamQhhcQurwl+EVdWlnAoGtBsvfozz+yabAJKrFlfDGYdYCJGAsLd
         gPJm+eU4WFuxTOWhd+TI0k+9AureJC71jisHB/Rm2B6PSRXiv+Hdmxe5KHXLfI1fK+i9
         Q+k3Fkt47ovtgn/xpnw1ZHJv4J4XKIFNQQ/DnHTdR8PGpeC3Dgvv0nQpa5AAm4APmGub
         IUcCuPTOA5sJqzSiNscrmryWr/XZflsFsFKcyjGa8Ik9kaPouC08pzypBfBc5dGTh4wA
         R/g9YgN20M0by56sRWVOaJOIX2PNvUuh6nplIcN/73LtqY7nBpjEiUDRtzpJgr4iBSoB
         a3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748385990; x=1748990790;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iEWlqUp6AjwrQz8VBkkI6kcZdrVT9V6EgrDsAu2VRl4=;
        b=XIi/xeef4gSm9ZG7cNyo3O2eTlsM5d073lixHdVuQWkCwyjuvTZXJ6PbMFA+3knb3T
         158BlU8NuBu12diQBZdxG4268IL9a6QKFijfpLilaMH4chnGcaVpN23teVYQO46989dc
         fk88So2lNu3w9J8U1IHKBWbpfrGtkBZuPXwm7cmOi1N00YmORZ9+rI8HEMls2iIGeqGl
         +iF9cv3gWTkwhPQMmFmAbI6IbnWhWQ5UX41cKtxmJYeplEpHapiYK4VtXlQ1EWUsjTor
         EsDRv3n4EPmSvUCWn8llFHw4AaskfxBOGaDm4sIUfH8qJynyEYHeDylUlgZCeS4iQbSW
         6XcQ==
X-Gm-Message-State: AOJu0YxkeTqAzq+qDgeQ0G+SGJEqXgwgBYJ+7/uh6/TMsXORdXuGTNzt
	Iz1jsJeH1zDnAuf4UPpbPv7ccoL17bScsUmdTNOL/I7xHM88wbMrZJqoGgOT7R1XGTY=
X-Gm-Gg: ASbGncsNwZ6xAwpqRvMb33Ikvn7tFeuokeJ8ECptMQkcJlN96Qg7OlttDolKtUrbYHX
	+Wq8pZI/pNjt/M5+wqz/K4jd6GexrVPNVD4gPrkFDSMZSInbE3bPY8cCLA1aHkYgsM2clNSN9rn
	h+TbaouZxxu8W+wkfgyeX1ZhSMRSLZROfwOnAWzEOfGexCeqUd8xjyqyyPVTydKU+vzCduvt5zx
	M50nvjREKbukdbfszIq4M/iAf2yptdsIZMh3yrgSuS5nBg6wimyzAswrylZfx4KPOap3JWlfTGO
	UVPrvF/pv56cgbz04w8FWYqvdD0FsxQTD2GGKPK4A7WM1n5mbUs+jNZoDV6Bu8+iS2CxU4CbYI6
	31sFuU5nR/x5/ODKTO+EDq7pa8Bndk9X2Hg==
X-Google-Smtp-Source: AGHT+IHW0FlyFCy2Tk4oM9nybIEHfyutJ6kk0DbTc32pC46klNxamK+5Q9E3J23coi4/jymOLJ1YsA==
X-Received: by 2002:a05:6a00:a06:b0:72d:9cbc:730d with SMTP id d2e1a72fcca58-745fdf76e13mr17990887b3a.11.1748385990008;
        Tue, 27 May 2025 15:46:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:dc04:52d5:a995:1c97? ([2600:1700:6476:1430:dc04:52d5:a995:1c97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7465e66243csm112202b3a.63.2025.05.27.15.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 15:46:29 -0700 (PDT)
Message-ID: <3bbf9fe0b5e4b2fa26e472533e16a31c9d480903.camel@dubeyko.com>
Subject: Re: [PATCH v2 3/3] hfs: fix to update ctime after rename
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Slava.Dubeyko@ibm.com
Date: Tue, 27 May 2025 15:46:28 -0700
In-Reply-To: <20250519165214.1181931-3-frank.li@vivo.com>
References: <20250519165214.1181931-1-frank.li@vivo.com>
	 <20250519165214.1181931-3-frank.li@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-19 at 10:52 -0600, Yangtao Li wrote:
> Similar to hfsplus, let's update file ctime after the rename
> operation
> in hfs_rename().
>=20

Frankly speaking, I don't quite follow why should we update ctime
during the rename operation. Why do we need to do this? What is the
justification of this?

And we still continue to operate by atime [1-4]. Should we do something
with it?

Thanks,
Slava.

[1]
https://elixir.bootlin.com/linux/v6.15/source/fs/hfsplus/inode.c#L519
[2]
https://elixir.bootlin.com/linux/v6.15/source/fs/hfsplus/inode.c#L562
[3]
https://elixir.bootlin.com/linux/v6.15/source/fs/hfsplus/inode.c#L609
[4]
https://elixir.bootlin.com/linux/v6.15/source/fs/hfsplus/inode.c#L644

> W/O patch(xfstest generic/003):
>=20
> =C2=A0+ERROR: access time has not been updated after accessing file1 firs=
t
> time
> =C2=A0+ERROR: access time has not been updated after accessing file2
> =C2=A0+ERROR: access time has changed after modifying file1
> =C2=A0+ERROR: change time has not been updated after changing file1
> =C2=A0+ERROR: access time has not been updated after accessing file3
> second time
> =C2=A0+ERROR: access time has not been updated after accessing file3 thir=
d
> time
>=20
> W/ patch(xfstest generic/003):
>=20
> =C2=A0+ERROR: access time has not been updated after accessing file1 firs=
t
> time
> =C2=A0+ERROR: access time has not been updated after accessing file2
> =C2=A0+ERROR: access time has changed after modifying file1
> =C2=A0+ERROR: access time has not been updated after accessing file3
> second time
> =C2=A0+ERROR: access time has not been updated after accessing file3 thir=
d
> time
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> =C2=A0fs/hfs/dir.c | 17 ++++++++++-------
> =C2=A01 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> index 86a6b317b474..756ea7b895e2 100644
> --- a/fs/hfs/dir.c
> +++ b/fs/hfs/dir.c
> @@ -284,6 +284,7 @@ static int hfs_rename(struct mnt_idmap *idmap,
> struct inode *old_dir,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *old_dentry, struct =
inode
> *new_dir,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *new_dentry, unsigne=
d int flags)
> =C2=A0{
> +	struct inode *inode =3D d_inode(old_dentry);
> =C2=A0	int res;
> =C2=A0
> =C2=A0	if (flags & ~RENAME_NOREPLACE)
> @@ -296,14 +297,16 @@ static int hfs_rename(struct mnt_idmap *idmap,
> struct inode *old_dir,
> =C2=A0			return res;
> =C2=A0	}
> =C2=A0
> -	res =3D hfs_cat_move(d_inode(old_dentry)->i_ino,
> -			=C2=A0=C2=A0 old_dir, &old_dentry->d_name,
> +	res =3D hfs_cat_move(inode->i_ino, old_dir, &old_dentry-
> >d_name,
> =C2=A0			=C2=A0=C2=A0 new_dir, &new_dentry->d_name);
> -	if (!res)
> -		hfs_cat_build_key(old_dir->i_sb,
> -				=C2=A0 (btree_key
> *)&HFS_I(d_inode(old_dentry))->cat_key,
> -				=C2=A0 new_dir->i_ino, &new_dentry-
> >d_name);
> -	return res;
> +	if (res)
> +		return res;
> +
> +	hfs_cat_build_key(old_dir->i_sb, (btree_key *)&HFS_I(inode)-
> >cat_key,
> +			=C2=A0 new_dir->i_ino, &new_dentry->d_name);
> +	inode_set_ctime_current(inode);
> +	mark_inode_dirty(inode);
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0const struct file_operations hfs_dir_operations =3D {

