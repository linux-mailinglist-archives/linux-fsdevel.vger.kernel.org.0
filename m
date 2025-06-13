Return-Path: <linux-fsdevel+bounces-51616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EADAD960D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 22:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D21C3A7C08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 20:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213BD24676E;
	Fri, 13 Jun 2025 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDT9TYTU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C8B2343B6
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845691; cv=none; b=egB0nvkNHHy+PVssr3b/MoffuOwEWvDEw04RpWgzkybYLXpHeGVUj0Qvs64Z1QTfeMiq7ocmdDEpHFSv8KklfxlM2pIDN/bPXEnTjinWjxp4DV659CaIRuFX71bZIViq4HRq4CBiZbID6QgJ4G4Fn8ozd5jo+PL1BYBNxt6wcl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845691; c=relaxed/simple;
	bh=hep9uBn9ActASOpnXkm2ScJMSgR297XylRgWmyMkmUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtSmJ1yfELIhWzB9gk9khCBzByBfkMr/I6Wr2+zBdoH4rR0wRbXufOQi/GYO8uqru3sTskWuJ0zb+Yy+eIzLuY+vPQbOekQi3sgevPBOxYeNa9ebPmxtJY52MPamUO+HhK6Zr4CjX7+KzJtabTxVKUom/aii2XKfy+hBR9QnvlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDT9TYTU; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a4bb155edeso31209681cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 13:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749845689; x=1750450489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcbNR8DW/M5pbm/7oWuCkME0vVkclLJn4bMDfXKZX+U=;
        b=FDT9TYTUFadoiOuz79ck7CcVZjzBrh3q+bQehWWJdwbfAEyHiuyMZiHp9HxuMRql1w
         6U51hnUqc0z8XdVgI8jVb7lWL/A/T+WIW500r4HN1aPGqDW8q+BUny4ljhOHseXGJGOc
         wjE8itXNTxcN8FAseEVtrci+H6ejqKHolxnvb+drGq1ClLq1J6tOKpeSNglLUafi2kj+
         DfNSSDo7C11oN7CTk50np4gZOL20bA8WjQ2sP1xhZ7IEwU+Dj0Hj10qRsOwxEFsXT8b7
         28xtU4mXk3QWGN2/EntOtB/2gD62XFdjhQzBtpzRphgrZhMD6rOsJCIa91c7sFsw1Hqq
         xctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749845689; x=1750450489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcbNR8DW/M5pbm/7oWuCkME0vVkclLJn4bMDfXKZX+U=;
        b=hr1k7qPv7V4HM/qZ9IyJVGVWmc7Z+uvt1m9RAIcKRILGf4m4A+B49cSzQ+GSVLhZU4
         BJSB3lGdVcito1qJAhwifY98JtY6Q3lKb0SGlHHN2GR8OK4E8jJ2PoXxfavN0rVlInvh
         KrBQMG86aJgjxHJheW+6EI5Z+8PZfOuLaG6mLH+MKYTnJN455loSsSAua4+FcNtlgWnl
         immO2O43v4mwb76rNPn+GEpOFppu6pfzGCfgqdDqSRnogzhEY5dY/GAiebPiJByLJszK
         F2EnKcsbUhk2/e1c+/x0pA4cK5KucD53rNAdt29h0EmwBdM0qbYKu52Rl0CJEtRIQARd
         pEzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAw9U6EWpXyfafWVgPEK7sU3BZfWjrX8C1JIH8E15bF0EGYn76cyOE1jDcIeIMnbtfLkQz3XKeNTHpo2eb@vger.kernel.org
X-Gm-Message-State: AOJu0YxVSVI//ap0NscRPUa3fetC/FmIHFWxBdp262VkZlJjfdtdDEYw
	cA1gRXoC11VxWp7lEdqr+lJTvbDinLqHHKr0ZbFNZRnROX+hAzyJPfo50TSailvRGvIk8mSgSkM
	2gmdJQ/mTy2CIQJ3eOUWPAZzSL/ELMys=
X-Gm-Gg: ASbGnctxHcsPjcHY74yBOOI+/jYzZUfUR2m2BztuEr/I+EsnUVLBQB3ugTnVBSDgbsD
	xOTOyVf+dl7P/ii9SaY5mCqiLBIkpmF5YOfjeuFzmbcEDLvb9GKW0qNqpwdSevOMnwmsFYPGvK4
	rnmKAjWDM0a7Oc/aiUpmwsjudcZP9Ho069frPJYz91Z5sWsGJRsxxyxmiabdE=
X-Google-Smtp-Source: AGHT+IFHilnAMx6neiuLCmfPOAIKaObFwkzGDm5GZm1f2yvaJs5fzDy0cgDCrX+UuIXrMMzm2qmOOgeN6yvicOG9SYY=
X-Received: by 2002:ac8:5ace:0:b0:494:78d5:baea with SMTP id
 d75a77b69052e-4a73c662a0amr7523561cf.51.1749845688813; Fri, 13 Jun 2025
 13:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613164646.3139481-1-willy@infradead.org> <20250613164646.3139481-2-willy@infradead.org>
In-Reply-To: <20250613164646.3139481-2-willy@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 13 Jun 2025 13:14:37 -0700
X-Gm-Features: AX0GCFsh_YAaus2mgBBHr90aFtLyUgJlaMIn0Gs6F8F2ZQ3p-Pxgnv3Cpl-QdoE
Message-ID: <CAJnrk1ZJ+Oi6kQWQawLFBdH22kS_z3WCgAXs8bsHdbVvnDSjDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: Use a folio in fuse_add_dirent_to_cache()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 9:46=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Retrieve a folio from the page cache and use it throughout.
> Removes three hidden calls to compound_head().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/readdir.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index c2aae2eef086..09bed488ee35 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -35,7 +35,7 @@ static void fuse_add_dirent_to_cache(struct file *file,
>         struct fuse_inode *fi =3D get_fuse_inode(file_inode(file));
>         size_t reclen =3D FUSE_DIRENT_SIZE(dirent);
>         pgoff_t index;
> -       struct page *page;
> +       struct folio *folio;
>         loff_t size;
>         u64 version;
>         unsigned int offset;
> @@ -62,12 +62,13 @@ static void fuse_add_dirent_to_cache(struct file *fil=
e,
>         spin_unlock(&fi->rdc.lock);
>
>         if (offset) {
> -               page =3D find_lock_page(file->f_mapping, index);
> +               folio =3D filemap_lock_folio(file->f_mapping, index);
>         } else {
> -               page =3D find_or_create_page(file->f_mapping, index,
> -                                          mapping_gfp_mask(file->f_mappi=
ng));
> +               folio =3D __filemap_get_folio(file->f_mapping, index,
> +                               FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
> +                               mapping_gfp_mask(file->f_mapping));

nit: in the fuse codebase, the convention for line breaks is for the
next line to have the same indentation as where the previous line's
args start

>         }
> -       if (!page)
> +       if (!folio)
>                 return;

