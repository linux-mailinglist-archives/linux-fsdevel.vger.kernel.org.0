Return-Path: <linux-fsdevel+bounces-54637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32952B01BFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 14:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00ED77672D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 12:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E610427A127;
	Fri, 11 Jul 2025 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThB3Ckfc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E51E5729;
	Fri, 11 Jul 2025 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236872; cv=none; b=bIykk8Ldu+3spy9SfhTwQHrp9Y4WywByEWvKO06ebYO1fn+d+pRagCWkwrcViiANUjKULAGFlqlnw0ztAg7zzo36jBK4NEwqQoBdj/jtVwLx+hZBVkhGeytupleMJsvybVuneKkLhu6i1BsDEkcuE3hWL35Qk/Bi9IsWy6MW0iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236872; c=relaxed/simple;
	bh=PhQ3dlRsMJ8vip6CKBXOnNiAEjzE/9zENItgWYR3KXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqMN2Y/zVhpXMoqHOC91Ylby6BcjVMGOXiZSRa+9ytgJ7GwuRaOqKlCcj6bmglNcVuLlhITdC/5KDSEF+QYtccfXIhtgmI4DUFscVewcz4SGibekaaYUufxm2QhZ4UDInPDICrNfjR7CAyV/8wTCejnp5i+TSHRI/C/aQRCf6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThB3Ckfc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0dad3a179so336950766b.1;
        Fri, 11 Jul 2025 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752236869; x=1752841669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdMrtK2JsEC572SsEOewV75Kg8FzqfFbvPciv2mJGJI=;
        b=ThB3CkfcvdqT2kPNYEhI2BqcSFYxypLR9y0WMsfMsvnSfwliv+/L9v5mStaDKvzJx6
         jOVdUt4oH1BK0g/lbil1az36pdAMp5v4zt+XFNiSEMPEA5dcug+yQ5A+YkTQkIs//wsQ
         QWMLcLHJ9psUCOO0RTa75VsTmN8TgDGNbcIDrxbA/H3aDRr23PQutqCIPDA9Ak2LsdVK
         G/UXOp2N/HGDBoHcEf/kwGiWo81K0ENiaVZoWDDFjV1JavMihcHVtQkwrKRy9oMCdmS4
         HBJgrgGVMXAW1onSHdo5cm5UJfj7E+FywA4ayFtaZrraAc5e1DFyY/ATP6lKxw2BOYdr
         UtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752236869; x=1752841669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdMrtK2JsEC572SsEOewV75Kg8FzqfFbvPciv2mJGJI=;
        b=RWJnttYIvSfUlYwwCLfbeTNCcSkuK62pNJxt1owPi+zJSZFPWwn9LFQQRUFWeiNJLV
         yofPh1LbLwyZW8m0gejf9vCjgcjprQC9+fdrADI7BMlEDeT7HgVL2QE1bNp2CYahYJBR
         IbHvu1wJHzSvNUgZ3KyD4IeV02PiaeAAJSgYy93zBYMJYGq7AXYV0GslCCjK9KcNUz6i
         bvMLAeOtPTNILofLYtaz2JjHdQrqo3EYAprvqO/V2hxqCaZ29TKeSVL9/hPOnJCY6bse
         ExhM8hK7Np3cWFYZiChTdLqKQyGniLh52Q2XQbmz5o4s1kUeBk2UC5tSgQo2SnccNz4k
         TKhg==
X-Forwarded-Encrypted: i=1; AJvYcCUhCtyK+cDRn3txsTv6NID4ViexDkjXAxPBK+YpOBYYnoTgtzRs/n+EkGoDHNkMSKGLrVnnawi8wbxaxlsmyQ==@vger.kernel.org, AJvYcCWC7zPEewawNn3fKq7sd6SSOYUJqG4MjDoUKNKsTbTLQqGI590Sy7WiaeTM8iozWqXgEKR69fuqDkBE7gEf@vger.kernel.org
X-Gm-Message-State: AOJu0YwM96s4pe9p7IOupKnlJVaevS59mRzStN+twmU9s9qJThcGEoiy
	2035VNEvR8xp23oqZ3NgujkIpu3mIlZ5Plr8Yq7Po6dPmYu3tXcQSTDKlDJerdKvtyK94An9Jg7
	J31/5kKPugKnnU3zyt52a+P/IWvuWKxE=
X-Gm-Gg: ASbGncvgry5UcbS1Ca1aL7+tPBywEwXp2uDouxuQW/VNbqNgP3VDYnZP3YQD9/IDB9l
	6lBtD1jd0TfCHDulhoIGlAXKfaRczbn8/qSRXlFyacJrpRGM2fN0I3ZTcXA0irYwRTDiu9i4uLL
	FDOy1NzJkYRQkWCeHt3ygd1qopTl+08eKt71AtZ697x3Ga9W2ur2YksSqen3ex3upcoV213juYQ
	IrCuJA=
X-Google-Smtp-Source: AGHT+IFPtsWO5PXIr0Nt1ie9uaTE9/fP6xppFQ2WlwuaBSUEDA0LRRWJcap8dVnH1VtZUDa9dgSHKIPZhRf+QTTEjZ4=
X-Received: by 2002:a17:907:3e9f:b0:ae0:a1c2:262e with SMTP id
 a640c23a62f3a-ae6fbf9b027mr266384466b.50.1752236868642; Fri, 11 Jul 2025
 05:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-7-neil@brown.name>
In-Reply-To: <20250710232109.3014537-7-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 14:27:37 +0200
X-Gm-Features: Ac12FXzN3wYm-nx7u6DEJEGzqQK5f2JjJMudSlwzRXZpmVqH0oFqbvbNIsimQ4M
Message-ID: <CAOQ4uxhru5BA92yoVj35V0L2WzmCmhuRySXDDEAu8kuGvp3N=w@mail.gmail.com>
Subject: Re: [PATCH 06/20] ovl: narrow locking in ovl_clear_empty()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Neil,

Half way through the review I noticed that your individual patches are
not tagged v2
This makes a bit of a mess when trying to search the inbox for
previous versions.

Please do git format-patch -v3 for the next posting.

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Drop the locks immediately after rename, and use a separate lock for
> cleanup.
>
> This makes way for future changes where locks are taken on individual
> dentries rather than the whole directory.
>
> Note that ovl_cleanup_whiteouts() operates on "upper", a child of
> "upperdir" and does not require upperdir or workdir to be locked.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

You may keep my RVB, but...

> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/dir.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index fa438e13e8b1..b3d858654f23 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -353,7 +353,6 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>  {
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         struct dentry *workdir =3D ovl_workdir(dentry);
> -       struct inode *wdir =3D workdir->d_inode;
>         struct dentry *upperdir =3D ovl_dentry_upper(dentry->d_parent);
>         struct path upperpath;
>         struct dentry *upper;
> @@ -400,10 +399,10 @@ static struct dentry *ovl_clear_empty(struct dentry=
 *dentry,
>         err =3D ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper, R=
ENAME_EXCHANGE);
>         if (err)
>                 goto out_cleanup;
> +       unlock_rename(workdir, upperdir);

If you look out_cleanup now, it basically does unlock_rename(workdir, upper=
dir);
and then out_cleanup_unlocked:
so I think this would look a bit nicer to bring unlock further closer
to do_rename ?

         err =3D ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper,
RENAME_EXCHANGE);
+       unlock_rename(workdir, upperdir);
         if (err)
-                 goto out_cleanup;
+                 goto out_cleanup_unlocked;


and leave newline after goto please :)

Thanks,
Amir.

