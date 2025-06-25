Return-Path: <linux-fsdevel+bounces-52961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F34AE8C40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 20:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4892C1BC6477
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776B42D6601;
	Wed, 25 Jun 2025 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez0+tbrC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF51DB15F;
	Wed, 25 Jun 2025 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875777; cv=none; b=umenfuSJVj9gjQ1r18OmuIPy/MAJMnGBYvZCREvxMAJ/ybQ/MkETRiO0GEZT/ZzhAZ0i5XsdiYxk/q1uIFq08X4BuzlTzCrqn4LvlQ8ZpfzV4HhU6u3NCBkLK9Td2HIB2gCOhfRmzNW5k+rN//pqUzuGTf0HuOoHSQ74GqtGYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875777; c=relaxed/simple;
	bh=gjGaYRCYrUag7MztlOltEAYykia0C1e7kHs9zKybWiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOkAIRuo6P7m0mOU8g9NElc087mcIH0EzDEt8tmXHT9/eCs//4rLCI/nNrASiWkKqfqn/8p9i0yX7T37Z8vBwaPj4XS0tsnTIbMRUc3xfp9xHc6SRaGkOMVfZ3qATJGphmD7DY3usRF3JAqpmZoOQ70XcqYjZPurGTCtlDMN7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez0+tbrC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ade58ef47c0so47530566b.1;
        Wed, 25 Jun 2025 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750875774; x=1751480574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi0m7fgA8psac0nPrT4JM7gCShW7pczHGe7U/CUmk6c=;
        b=ez0+tbrC5ygkp9ul4rNc/jIk/3beMGXMgAF5fRhTgB+VhKImimbt+7kv5j5o2hmT+s
         ajK+bnr9H88/P1f8820gS+k2qQo5CnEq/yjCciVkcd6BfmukEbIZrHNSwN0OdhYojsLL
         JWmONg/xKZM2tsAb1GSLEpaT4K+qsPaTzXYXsVwYtcJXiUFR24fCU986WqmS+dysPPWC
         wODA2ygulRSFPNuuUyzri+oefvmTGz9Gx2z974DdFL8jm7/CXHTQWhH23jHC2pSfKEKh
         WNCeDad2VDvRwrFMIuctx/ZoBc2OYqUl8aBulOShKYXjLh9U1CzspOQuFyhBed4Dgctr
         1t7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750875774; x=1751480574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi0m7fgA8psac0nPrT4JM7gCShW7pczHGe7U/CUmk6c=;
        b=b7G4Hif2+fPlBVQEZllzryeJnOGfDNKTBEQdaSR15yVcTCC+6hMoTq/ys+n6+r5mTL
         UoUGT2ZxmVmUOmFCmjhuPjRJBGyUB5FwxvfzgS6VBKK+7PVoG5haDY5v7mRL6/bucCaD
         kurrtq7qpCojGwPEX14gyTkq+dO4NDdii/NPe6b5dR4gA1PEeP1hMtstz6qNZB20t5TP
         NSkVWWe2wcR7zIsFQomJqOCjZ8hE68MmyX8TclZd9zRmPDPfTy+CJ+dr5FULTaMRdG37
         vWZHSBpUblWduUMIhCNo7bUXQhpUK5Sqw47G2NGdbfP5vXx6J0YoAyHNR3gLB1Tu8aM+
         MiMg==
X-Forwarded-Encrypted: i=1; AJvYcCUic6RE3f9pn81iFu2t6X0ZqROqqcygCdAMoB7Xfw2TobKZOEKcueyzzj0FDIGHPmkJ6TkbfV1YhwnYwWk2Hg==@vger.kernel.org, AJvYcCW3YcTX5YbNwSvUrOV8UZ7zddOvJN2NX9WPRQUWpF/gNDZ1sfjL9VKyiJtD+s9WtetaQ2Fv5X0fTBrXnrPn@vger.kernel.org
X-Gm-Message-State: AOJu0YyRqCnJGHPfrkwHwueVjM8vRAjjUiRvyKpVl0olgMLgb1gHY23j
	t81aiBy8kGGggGFGL4pyP2VUfkiEOoJO4e/COrLetsylVUEa08Z12wvdIRXBkRXuVVkFKbibjCG
	Aut/ve67Z+W/mrvSXwJS7/3lGQwJeHiA=
X-Gm-Gg: ASbGncvKKchMEId5Bg6ct5CGh6MrZIgPJo3mO24v6uSHjLJHrehz4piXpwizseVVOC2
	Xb5u7EhmP6wegOa1dDeobQ3Tlbl1PPxSV8EbX0Au/PMoGATuAPEZMI7gp7I3W9rdmJfUlCuBqpZ
	UJpkg8PnETFkE1ed5z4uV24c8AiPYLh6acYuSjNbNI2vc=
X-Google-Smtp-Source: AGHT+IFdybK8LZPk5C+8CZrkt1KGVhO1eidZOIcOrOhf9tqVb6zIX1Y2DdbH46GqJa+aqQVdZ4aWyeZEeXlLCTv8LO4=
X-Received: by 2002:a17:907:1c18:b0:ad2:e08:e9e2 with SMTP id
 a640c23a62f3a-ae0d26dc306mr57634266b.27.1750875774114; Wed, 25 Jun 2025
 11:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624230636.3233059-1-neil@brown.name> <20250624230636.3233059-6-neil@brown.name>
In-Reply-To: <20250624230636.3233059-6-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Jun 2025 20:22:41 +0200
X-Gm-Features: Ac12FXwKR4nmqgDcf5Xfc5bip1jbz7kuMyYGOJx_29mwH7WtsAhr-ulcbOKtKnw
Message-ID: <CAOQ4uxhB73DUADGOM9gKoUXhO1_RXp7vUv6jx6i53jzOpdDhTQ@mail.gmail.com>
Subject: Re: [PATCH 05/12] ovl: narrow locking in ovl_clear_empty()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
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
> Signed-off-by: NeilBrown <neil@brown.name>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/dir.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 2d67704d641e..e3ea7d02219f 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -355,7 +355,6 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>  {
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         struct dentry *workdir =3D ovl_workdir(dentry);
> -       struct inode *wdir =3D workdir->d_inode;
>         struct dentry *upperdir =3D ovl_dentry_upper(dentry->d_parent);
>         struct inode *udir =3D upperdir->d_inode;
>         struct path upperpath;
> @@ -408,10 +407,10 @@ static struct dentry *ovl_clear_empty(struct dentry=
 *dentry,
>         err =3D ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper, R=
ENAME_EXCHANGE);
>         if (err)
>                 goto out_cleanup;
> +       unlock_rename(workdir, upperdir);
>
>         ovl_cleanup_whiteouts(ofs, upper, list);
> -       ovl_cleanup(ofs, wdir, upper);
> -       unlock_rename(workdir, upperdir);
> +       ovl_cleanup_unlocked(ofs, workdir, upper);
>
>         /* dentry's upper doesn't match now, get rid of it */
>         d_drop(dentry);
> --
> 2.49.0
>

