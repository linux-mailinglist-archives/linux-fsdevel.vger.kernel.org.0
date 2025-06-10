Return-Path: <linux-fsdevel+bounces-51180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2016EAD400E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 19:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA24F189DD16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E99224336D;
	Tue, 10 Jun 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLEobg4z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1E224293F;
	Tue, 10 Jun 2025 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575232; cv=none; b=H+ZSw6qNjlPJYBOfkw5HTwyIZ1WrTyqjzB7ttPsNXV3TrpFG9hqLIMC6V3FTIYEYllpNIy5XMWHoFK8qSFzRwK5paDgpZjJRUt1hLNnhZk+1RTyppwqob4nY1UG+6vb+JxY2x2m2glF4iMF0VPJplhX1yaE3b19BmKJ0mvcbqYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575232; c=relaxed/simple;
	bh=46zR+ZR50XcleClVyr4cP8nJe5FVa5UX1au6OYPIudw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKlbxR24LcG1T8CZhpEzXwbFc0A9ftVLppqxcom598RCnNaIuS0hm1te5sdoTDsOtridZkTjpC5NU6IW/HpfdWfJqyC8tOZlCf2Htl0+DX8hmxsMCzviJqJGPwPQRu6rcp87evRb0MmoZZ9lnnJKCoEj1FyP6JroiR0zyRgosdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLEobg4z; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32a81344ae9so59736801fa.0;
        Tue, 10 Jun 2025 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749575229; x=1750180029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3WVKJVLsC72+25+NT9c5Ak83GPqKH0nfsEur1vtPag=;
        b=eLEobg4zdQx1X/9v+tFozZOPPZfsCZPfVO6YGwTBL+gjmdSlo0jB3tvDi+A9/b4Emo
         9L2oh0MYdBsErXnSyuVfgwHxCoMDDo4+CpJrj5lKd2qq1uCfXiwFHAFhSXRmUXCWXUEH
         L12sEhgjzr5QzCybd86d6x4DVADRiiynnh7TxpXFrM3v1Jy5PnIwf7E6kc2lJb05oH8a
         0SnPJ5FgfvH6rH7c3RAP9stfzCxefijUpHHQPO/qDNBZ9lOZ2aqWZV8ECL2SS2W1ciAa
         gEdSq12Wt3WE9mDhw2DrgNimQdDnVpg/AEAdVuqFpQ2YjoNVsYEzF2Bi86FR+OEwJVtN
         D+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749575229; x=1750180029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3WVKJVLsC72+25+NT9c5Ak83GPqKH0nfsEur1vtPag=;
        b=rpaB290k3elqeTibBzyBRfy9DNb6a7HZSFUwhwiIng+a4X95umI5js7paEr+9DQfiI
         8bak6LmnIZHv1KmPSvNXqjUGd0ygIISP0hIcYnkZJQpzZUO6ya1Shz1q/t0bKF7Abky7
         L7EEe2L5SmJkthzl/9wsmPb327tG318lWmhzXCUGS3hDuq7zhEWHE5eOPO1TSMe3SzfM
         +8uyifvdC4xFsfPzm8v8EsUKiNNCZxSbCgxzxepz2Y/cPI/Xw53k6WDZ7Iw2AwpQ46al
         aVXY6Gps8O4gOIyjAOChXvjVldCpX6L1yLVT5Q3oe54fonldwgFbwEJFHu6NV9r087ly
         nsjg==
X-Forwarded-Encrypted: i=1; AJvYcCV3ign3nj1b7CPLIFaXPh4RBEcR+A0fSJlsjf2t1RITnnH7DDJzmpprVwimubswPLgfs0YrlFJinNauC+nG@vger.kernel.org, AJvYcCW5GCy6NRWWPhYAB8fHBOt/D7TKhkHZnoyiuJJbOrhAU6Fa8GCbmAXjcLmF65F91OmWZYeUPT56ocEo@vger.kernel.org, AJvYcCXqyfF3H8I+swyA43tji5ATnYepvaKew+aUlWctT49fGJniPPYX2UsoHeMG+6dvrIZKH/UwP4qBY6BF6fjC9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjBsuQeLp0V5RpC7j5RnuAcXI/F4JCMxQqWXdov2ecpOpVCo/I
	KVkXvWkqH6GbepSzn1EVaA64OeWkLPZd8KoS/x+71qz42Smbb3qlxR7iSzRLtq7MZ+9LqQnDq/x
	TrZA8F6MrDJaN/aYBV8/wAgP3rnp60xFvGALW
X-Gm-Gg: ASbGncv5W9NYzIVJTqVndpTiwb5PvfUxGxZD2/dhi0zx6IrNwWfa0Uw2zwgeT9NNskZ
	97NJHgRIjzyHQEr14K65gocTMQpqZPB082LaysL7acU20336Ui0PShIBi29UwnEVZBRBGoPRSVD
	/puiC0rgJoGHET2SOft57K34pnAjG/LyFp+rq4eAlLvlZaN7XwBi17RKHNJXaOxlR6N9YYfalM/
	2UDTA==
X-Google-Smtp-Source: AGHT+IHj14OlWbkJdXRqC0T1Ze5gzdUiLPGZS7cDMtXasmwQwA1hhSMY2Ega9w6NMi0lya9r+ehXQRq7EAQ2VhZfklU=
X-Received: by 2002:a05:651c:19a7:b0:30b:f52d:148f with SMTP id
 38308e7fff4ca-32b202588a2mr2097211fa.18.1749575228385; Tue, 10 Jun 2025
 10:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174951744454.608730.18354002683881684261@noble.neil.brown.name>
In-Reply-To: <174951744454.608730.18354002683881684261@noble.neil.brown.name>
From: Steve French <smfrench@gmail.com>
Date: Tue, 10 Jun 2025 12:06:56 -0500
X-Gm-Features: AX0GCFtIGiwQTKeGFcZKlbCtKzdoo3Qt-Wx67IUVp1GdHgRsejHkKeWgnEhS2to
Message-ID: <CAH2r5mvJdA4hcnnWinNThWFUTEWHOt9wMa2-PVHDVAjM02fAzQ@mail.gmail.com>
Subject: Re: [PATCH] VFS: change try_lookup_noperm() to skip revalidation
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	Bharath S M <bharathsm@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Steve French <stfrench@microsoft.com>

I verified that it fixed the performance regression in generic/676
(see e.g. a full test run this morning with the patch on 6.16-rc1
http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/3/=
builds/497),
the test took 10:48 vs. 23 to 30 minutes without the patch.

I also saw similar performance yesterday with 6.16-rc1 with reverting
the patch ("Use try_lookup_noperm() instead of d_hash_and_lookup()
outside of VFS"
) For that run test generic/676 took 9:32.

On Mon, Jun 9, 2025 at 8:04=E2=80=AFPM NeilBrown <neil@brown.name> wrote:
>
>
> The recent change from using d_hash_and_lookup() to using
> try_lookup_noperm() inadvertently introduce a d_revalidate() call when
> the lookup was successful.  Steven French reports that this resulted in
> worse than halving of performance in some cases.
>
> Prior to the offending patch the only caller of try_lookup_noperm() was
> autofs which does not need the d_revalidate().  So it is safe to remove
> the d_revalidate() call providing we stop using try_lookup_noperm() to
> implement lookup_noperm().
>
> The "try_" in the name is strongly suggestive that the caller isn't
> expecting much effort, so it seems reasonable to avoid the effort of
> d_revalidate().
>
> Fixes: 06c567403ae5 ("Use try_lookup_noperm() instead of d_hash_and_looku=
p() outside of VFS")
> Reported-by: Steve French <smfrench@gmail.com>
> Link: https://lore.kernel.org/all/CAH2r5mu5SfBrdc2CFHwzft8=3Dn9koPMk+Jzwp=
y-oUMx-wCRCesQ@mail.gmail.com/
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 4bb889fc980b..f761cafaeaad 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2917,7 +2917,8 @@ static int lookup_one_common(struct mnt_idmap *idma=
p,
>   * @base:      base directory to lookup from
>   *
>   * Look up a dentry by name in the dcache, returning NULL if it does not
> - * currently exist.  The function does not try to create a dentry.
> + * currently exist.  The function does not try to create a dentry and if=
 one
> + * is found it doesn't try to revalidate it.
>   *
>   * Note that this routine is purely a helper for filesystem usage and sh=
ould
>   * not be called by generic code.  It does no permission checking.
> @@ -2933,7 +2934,7 @@ struct dentry *try_lookup_noperm(struct qstr *name,=
 struct dentry *base)
>         if (err)
>                 return ERR_PTR(err);
>
> -       return lookup_dcache(name, base, 0);
> +       return d_lookup(base, name);
>  }
>  EXPORT_SYMBOL(try_lookup_noperm);
>
> @@ -3057,14 +3058,22 @@ EXPORT_SYMBOL(lookup_one_positive_unlocked);
>   * Note that this routine is purely a helper for filesystem usage and sh=
ould
>   * not be called by generic code. It does no permission checking.
>   *
> - * Unlike lookup_noperm, it should be called without the parent
> + * Unlike lookup_noperm(), it should be called without the parent
>   * i_rwsem held, and will take the i_rwsem itself if necessary.
> + *
> + * Unlike try_lookup_noperm() it *does* revalidate the dentry if it alre=
ady
> + * existed.
>   */
>  struct dentry *lookup_noperm_unlocked(struct qstr *name, struct dentry *=
base)
>  {
>         struct dentry *ret;
> +       int err;
>
> -       ret =3D try_lookup_noperm(name, base);
> +       err =3D lookup_noperm_common(name, base);
> +       if (err)
> +               return ERR_PTR(err);
> +
> +       ret =3D lookup_dcache(name, base, 0);
>         if (!ret)
>                 ret =3D lookup_slow(name, base, 0);
>         return ret;
> --
> 2.49.0
>


--=20
Thanks,

Steve

