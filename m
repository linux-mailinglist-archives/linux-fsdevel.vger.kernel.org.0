Return-Path: <linux-fsdevel+bounces-54642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86917B01D15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9497C1CA254B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56BE2D77E0;
	Fri, 11 Jul 2025 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6VNe0cC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BDD2D3725;
	Fri, 11 Jul 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239555; cv=none; b=N/tv6tG2sEoQ9N3qI3+gyJZHgIz7nSSYVQk7nEu/ZVU4DD0nXkpZ4EHvxHnjkuvnj4YYetdPs3ui1XpYRaC4E2iEdoJu16Ec3Z/ayhrOR4j44AfVUWAWO5xbrkWfRQTctWCc2UnurU/oOHfaDZC8rRqnjkBMnilGQDWB1LUE1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239555; c=relaxed/simple;
	bh=9xZaOMnnl4MjROp/1VCncCngjbXRX6EXI4pxLHipeDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNnO8vWj8BI0tpnLDfpkfa1RRxpRVHXtPloHsBT7D70gSzZuNWlrHHUjtSgIwVqryw/LMEXYRXzgaqcklC2YqXWgegpnwKJHcRwPf0gUH/Xfo+AwEhDi4Xwc4WrGs8cWYWkSB54gn2q0BtOgfZLR2BEItEiA8+a9U2q/Tfrm7bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6VNe0cC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so443833166b.1;
        Fri, 11 Jul 2025 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752239552; x=1752844352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfgb4I4d2TA4YbWvSSnOh1NmJkFIrRLUqozVb7Z8b6A=;
        b=D6VNe0cCMysM/X5DjFolk+8Iq/s2c6U2vKLZdjGW7gEV71KxB+CKUslz0Zm2PCsh/c
         mXzeuhAnGR75sAISZMaFTfL9s8sehxrCJwgSmmFsaMmgoz16OHNXRwl714nQ9YYHsYVp
         xUq6sN8YsUKh1yR7BqgUOH9yz+VIN9jMe3y2OCVIOk5sETNyLYWuk00XmTpJoophK6kp
         NJyj7qEvUtjlGY9JwrmBWxYqYKgh94HJZ0oftP5f26NYgYrFlbEXSMRullpDjD9XFBZa
         Y3l7+OLNpxwwCvHEtGO12wCSCVw2Kpp/C29tYnSHljMJ8lkxfwUpe3Is/7if+X0pKZ62
         xv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752239552; x=1752844352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfgb4I4d2TA4YbWvSSnOh1NmJkFIrRLUqozVb7Z8b6A=;
        b=OWLJP2NwuxtOe/0dQgsIsih+We2YMjQemN3cKY2HpqcXQz+uklIRc+ScSsQavjbz5G
         Mkapvnzgr9g/8WsPHSRyhWeqbfUiLmyGhvcAlFab92Honn8mLapw5YOiaokO7VBW70WO
         z2Ptl41BrK0gafYVVLflmu+MAzCeA5sfR3jyy8xo69OPE1aZQkyIJp78K9syHkv1DHE+
         0eV1rvAOHH3yrmsT1Bx4ZdLxC+W/GqvGxJVowUsj+uk/CDqyHfc5a7+YhnJYsE9qHTJD
         0bS+2l+3jywv4gAyJkvbbZ7WehiSXhLQRGHY8P+WAYi0fYE4TrRk89trBL2TPwFX2h4M
         Og6w==
X-Forwarded-Encrypted: i=1; AJvYcCVJVEA6lzqjUdJP/hvGPttEZLGumv4AyEfaCGLWJVxfqGGj2Ou80+sJ+XRtaQ/hNVCSIV2FTqRuBvbhI+Mi@vger.kernel.org, AJvYcCXiGyu6TeWEjCwyxq9PZBuBdp3yI9VZLaLkjYkrex1eFokiEKfojIp3N5gTk7JLsWhiDTtxHZDcorie7B8XQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2wrr9bT5r4naRgNwnq2eqeb7za6XmmKLLEoBToYZuSqSj9/NG
	ENHIXMHrBILq/tiD0eS8607EV798JKJ268BYFwYQy5hQdrqPkpgrUiJtQxRenxUdPpbmRacEWqA
	RKKVWgesFz7+zVZUmP9GRNbAv7NTTQVg=
X-Gm-Gg: ASbGnctZYSG5htLoaDPq4+rnMFPupf/mfEkox1eqt8krGDCYVvGZ/2Y6eIiPDWWP7Ik
	u+p9bIQ8NBdnDS9iCsckliKR/BKxg6yWTk9Hp/80YDGLq2PT5q86L2iRFBG8GZ9e0oDdWr2sCUV
	gHawPNmU1nL8YFEi7ql+9M+V34Mw3cD8GqYYKobbyp9b5hxGp5E9BF0bvSjd9v/3qyEKiHIiw4k
	WFUuqk=
X-Google-Smtp-Source: AGHT+IF19JEeURu8Pefpnisse5Cz2Ie++qWLlVdUELlKNESYR82GGgfkoh5nXTx4FPL2OYS+IPRkoJVcqeRLefuY64I=
X-Received: by 2002:a17:907:d84d:b0:ae1:a69c:ea76 with SMTP id
 a640c23a62f3a-ae6e24bbf01mr685897066b.23.1752239551249; Fri, 11 Jul 2025
 06:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-11-neil@brown.name>
In-Reply-To: <20250710232109.3014537-11-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 15:12:18 +0200
X-Gm-Features: Ac12FXyRHhL5u4euFTOqax_8cUtXwwQv00rCfBjn_6t42d6y8Tto5SRiecWISS0
Message-ID: <CAOQ4uxht32aHnM2K3rD_sBjJLkONf-zzNbGZUq34a8hH5qhLkA@mail.gmail.com>
Subject: Re: [PATCH 10/20] ovl: narrow locking in ovl_cleanup_index()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> ovl_cleanup_index() takes a lock on the directory and then does a lookup
> and possibly one of two different cleanups.
> This patch narrows the locking to use the _unlocked() versions of the
> lookup and one cleanup, and just takes the lock for the other cleanup.
>
> A subsequent patch will take the lock into the cleanup.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/util.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 9ce9fe62ef28..7369193b11ec 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1107,21 +1107,20 @@ static void ovl_cleanup_index(struct dentry *dent=
ry)
>                 goto out;
>         }
>
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
> -       index =3D ovl_lookup_upper(ofs, name.name, indexdir, name.len);
> +       index =3D ovl_lookup_upper_unlocked(ofs, name.name, indexdir, nam=
e.len);
>         err =3D PTR_ERR(index);
>         if (IS_ERR(index)) {
>                 index =3D NULL;
>         } else if (ovl_index_all(dentry->d_sb)) {
>                 /* Whiteout orphan index to block future open by handle *=
/
> +               inode_lock_nested(dir, I_MUTEX_PARENT);

Don't we need to verify that index wasn't moved with
parent_lock(indexdi, index)?

Thanks,
Amir.

>                 err =3D ovl_cleanup_and_whiteout(OVL_FS(dentry->d_sb),
>                                                indexdir, index);
> +               inode_unlock(dir);
>         } else {
>                 /* Cleanup orphan index entries */
> -               err =3D ovl_cleanup(ofs, dir, index);
> +               err =3D ovl_cleanup_unlocked(ofs, indexdir, index);
>         }
> -
> -       inode_unlock(dir);
>         if (err)
>                 goto fail;
>
> --
> 2.49.0
>

