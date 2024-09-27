Return-Path: <linux-fsdevel+bounces-30288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 035BB988C6D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 00:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2B61F21FA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32943188936;
	Fri, 27 Sep 2024 22:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMSDPw2J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2901F188583
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727475906; cv=none; b=eyWpp03OQDTPlBHpRSy/FsO6ZOPn2C3CwJoRoQ3Yvb6ZJfaCfk9Fl1uO57nGLdoTLly3qcTmIUgbkiBOZ/9SsC+S/kmqsO0+UXZ+qvGWj/if+rYU8a7PLpsgWoJCe56huB16cqe0QBKzczYej9C4XQZTOEjvHT0I/KHMLRSS+/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727475906; c=relaxed/simple;
	bh=/aFGgeqV1RMpR2mzH5tRdtulBpw6b19+S1oOHatSoAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfdXKET+WD4kf5we477029yfOVOp3v3PuTr6BexIAT1QZfhFFNakmYZiImYUdBWXfBIgumLIfC4i7MUS+KJlNzTEXaeyVmK09Qj8kq6xIrQU6QzZIjZk3Rg2JtFKpwtHIG5vE3XbL/toEGQFzIsju5tumW2yIbMpe6jwXHqFNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMSDPw2J; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4585e25f42bso21329741cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 15:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727475904; x=1728080704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1R/BIPgwpN2XRzidhXtoYfpeOggdurE68ki7Yr/NEo=;
        b=fMSDPw2JlUDG++N6EEwzAlPMjigjnm1Q1aPnbnBGM6lgDcEkXRbgjlc4e3AF4rdADn
         9jpEoy3l7ogtQUSIImJLuTm16drjRZn3yel7irEVmBRpT++wThthfsUIqs7qxDlUFJyv
         XLFHelHoXphhiGSbm9ZxQauQHRdi/jsCkZ7wzZ3TaOQtIB11Z+RZt7F6hP1CSlfjnire
         GhChkMvWTuQly2c8NXKwFS7pYaU2SW6LAVCqjyJAu8uuqYJoZzN8jJh3BWVu1a13WlLs
         RGiX/tjoa3HSKbgqopqbqcbun+VcTpQwUphloeAom6l/dYtrotXcW4WqUK/P8Ln5ORHl
         iPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727475904; x=1728080704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1R/BIPgwpN2XRzidhXtoYfpeOggdurE68ki7Yr/NEo=;
        b=q9U2KLcXargA4SGJMCijoMETPQevWUWbfJa7LgR/+bXl5+6dOL8UV6+J0uZhToJdOR
         sWwf/scE6ZSDDNYOST42v8HiGsYlBrpmlfeDa35ax01jEYyCw3B9S3ZOnLYAuUzIf4W0
         4YjZuusozinF70XHUZ1YSOkZ15R2JkY3U9p29Zm2ko10To/AaabhqeFWQweLXs/9oMmW
         DiapwZ+vFnM51nAogOwjbykEnlm+mf35oGP2/GT5s94o1oKgt9xfp9T/3EKnSl/EInfY
         UlFWtsVF/mfcuBpZurn6c/6GaOdIM3IQOIA8dpe4ZIHwtQBd+UOMhKAczckHBWfOaAKz
         3EeQ==
X-Gm-Message-State: AOJu0YyUrb/Q6EJRIi+zgiUOIdL6PmW/+lAn2TzJGjAu65a8A2HMPvoX
	MJuyiS0vi4FgdJydz6FeVe/AbKZLqs8bo5VgJ5JPHHGuhQ/msYbql8gik2NM2W0ithQ0uo6uh0S
	6ALqkNgHwt1oCUF+K8sq39hkVSzMrzfy4
X-Google-Smtp-Source: AGHT+IHfygWYMhcW9sE9xSyeT5vk7YQZHk82HQPjNdY5XskVykD1EEr3LrMTHL3wiF+SUtZGlJkikikdypIFval0Vzs=
X-Received: by 2002:a05:622a:412:b0:458:1de8:4e46 with SMTP id
 d75a77b69052e-45c9f1d6de7mr77737331cf.6.1727475903967; Fri, 27 Sep 2024
 15:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727469663.git.josef@toxicpanda.com> <f0e70cb0b99f46d05385705095fb9413a6c9ef0e.1727469663.git.josef@toxicpanda.com>
In-Reply-To: <f0e70cb0b99f46d05385705095fb9413a6c9ef0e.1727469663.git.josef@toxicpanda.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Sep 2024 15:24:53 -0700
Message-ID: <CAJnrk1Zb+NOE3uiSNh5dROyUuM0ZKKeA7D3zM=3QrZtDdH--EQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] fuse: convert fuse_send_write_pages to use folios
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu, 
	kernel-team@fb.com, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:46=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Convert this to grab the folio from the fuse_args_pages and use the
> appropriate folio related functions.
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/file.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 132528cde745..17ac2de61cdb 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1168,23 +1168,23 @@ static ssize_t fuse_send_write_pages(struct fuse_=
io_args *ia,
>         offset =3D ap->descs[0].offset;
>         count =3D ia->write.out.size;
>         for (i =3D 0; i < ap->num_pages; i++) {
> -               struct page *page =3D ap->pages[i];
> +               struct folio *folio =3D page_folio(ap->pages[i]);
>
>                 if (err) {
> -                       ClearPageUptodate(page);
> +                       folio_clear_uptodate(folio);
>                 } else {
> -                       if (count >=3D PAGE_SIZE - offset)
> -                               count -=3D PAGE_SIZE - offset;
> +                       if (count >=3D folio_size(folio) - offset)
> +                               count -=3D folio_size(folio) - offset;
>                         else {
>                                 if (short_write)
> -                                       ClearPageUptodate(page);
> +                                       folio_clear_uptodate(folio);
>                                 count =3D 0;
>                         }
>                         offset =3D 0;
>                 }
>                 if (ia->write.page_locked && (i =3D=3D ap->num_pages - 1)=
)
> -                       unlock_page(page);
> -               put_page(page);
> +                       folio_unlock(folio);
> +               folio_put(folio);
>         }
>
>         return err;
> --
> 2.43.0
>
>

