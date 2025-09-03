Return-Path: <linux-fsdevel+bounces-60178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 208ADB42787
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 19:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A968F178FB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5B12D4B57;
	Wed,  3 Sep 2025 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5WWsdzI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29651805E;
	Wed,  3 Sep 2025 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919023; cv=none; b=hJ2TWCcVCVtIL5r1k93kBFboDcYVyecJO2KQuFo68xE/OddMLZQb5KiP0MK8Z+ephlfoh9C/Iqq1uUWpN45oCyyevMcHrqK2xND11RbDx/pFpdqW/0gd2XBE1taXjvE92YINexzqJ9QpWlhLRa6yNxvMhC276BQztHeEgVdjYVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919023; c=relaxed/simple;
	bh=9vHOeF2LU7ZwdGp1tabT6SEl/2WFwNh1zBMCpsR9rFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXfPw6g6NkhCA52pi+llO+wDRogus1JvKfhwQjxnGH/FaWHROZydoUw7616p+zWPXeOByO1uN3KSqJ2G3l945vQtfRB4mRV+P+bvno+Xitup9hI6FBtziX5iPOY9q1OcdLP09osnnz0Rvwy284uj3S/Z2HhrkquQdW7EE0I4VCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5WWsdzI; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b2f4ac4786so1434171cf.1;
        Wed, 03 Sep 2025 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756919020; x=1757523820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WDMUvc3IzguNyJTNH5XqsuyyvVAZS7oWiw/JC7NJbE=;
        b=B5WWsdzIKKBjI4P9X6HFe0pyRx4DssNr3x8wQhqs4G0MMdHLrvToALNsAsALd02kZP
         pcb6GqREtGiu0TjP5SDxVGMWKY8pjEZtUq595MXkLiS38nzBJEILkpm0wbLxX67Xdb5s
         FJIIi4iVebtZK1+tS93tsOvevQl7qjHd2vog5XSl4QlBtc5GTmsG8/YKL8I2aK+y08Ks
         2LNhdnXdSFrSVh2V9OES9lt52zNUMnmMECmeBeo1GVTlqRAghZFs45Snj0+BZV7wRzH5
         Xxd8OolxbFeGQmyhyniJaWdWOcsuBJhTOOGmN3vRiOVPSQ7DCMqrYXTAcZeJ6ZJkQGtB
         lkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756919020; x=1757523820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WDMUvc3IzguNyJTNH5XqsuyyvVAZS7oWiw/JC7NJbE=;
        b=vUsXs0cyxAvanC4uKAyT5Bgyf7ZrK096syX/QVIfTVAzBEfkKs3SnaGUzfjcysS+Xc
         ABAMVDkercV4BFdoVbfOdsHON/wzMjcm+hXeEkUqzdVMW6GYJE1Qx6k+I7SsEbnbF/Oc
         C1zJvfkXBtMhNVkcCe+TIxQ9Y8pf+InW/eDsEIDEtvFK7n/S0O6IGgOmly9yB7MucgJS
         xb69YdeZAFnXLB3lx+I9QUMMBLmN4X2CJN3tIgqeMPJM/QacyEdvWvNLuYG64or4Xkfk
         vvl6SiqYHQmAwAaFLnDts2aJoCwzyBWO8dixHlImGnW/JdsPaHK7S016YUhNXFkl2PjY
         olmA==
X-Forwarded-Encrypted: i=1; AJvYcCVBPgbJJVEQtQPgrfaTmFq93oLo1a0MbAhNZwdLX5qmJmyGaBxd+jBkPzkieb2h0aLP42gWqPjxyLi5RSnO@vger.kernel.org, AJvYcCWUF3JYk003qFs/ZMzbz9/dyMCNRNPK3+j8CPs+FjwOLEVedOyA0XCbTLjjDa09JEmeeITuryrgTx+SVQKP@vger.kernel.org
X-Gm-Message-State: AOJu0YwYJUeAIGZTdNT+4plB3R7jo0sSYporTMyb1/pOL5g4i6Hfa82H
	2kHmv+LUdRTdxyDVeBlhKA5DUz//nYSN2yDqAlHnIsqxA3FolnxDsRAd7riAFhcg0/r7pI3TzNC
	WHpDPKbcrpr+f1T4iVVQycVEzn1iUr38=
X-Gm-Gg: ASbGncs8+YzOc1Hl4Cebm0BW0hs1kUXWAEieO4CMAWBcpBf2lCiEj6ga81NXLvQSpvD
	b6KpUNwVNtDihSmTRWWs0CUJMKr6gGaKGchC6+aVdepV7GubaPwtubprqyGR7VA1JTjkmKB6V7s
	8H61qTrIUt47poVOzM7CEL1YjImN/WVMj6xp6uN3TAoa2uMYn5LGazg/MsbFmHmJECmWdpUdkYq
	a/8op6/GQizJfOcvNk=
X-Google-Smtp-Source: AGHT+IHdlA0i+dky5ApCo58qw2xUmCIJosO/ENRY1IUKIlwLWotjtp2B8QX9u1nFJWBL2JKTBQIWxJYhF1wkjmZIsFc=
X-Received: by 2002:a05:622a:4a89:b0:4b4:9773:5863 with SMTP id
 d75a77b69052e-4b49782a07dmr22037331cf.48.1756919020370; Wed, 03 Sep 2025
 10:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903083453.26618-1-luis@igalia.com>
In-Reply-To: <20250903083453.26618-1-luis@igalia.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 3 Sep 2025 10:03:28 -0700
X-Gm-Features: Ac12FXxXVFuOvg49eoKET4kfHHZIaOeTUYGW4JGNmnEFfqCW_TnYvkldXYfeiB8
Message-ID: <CAJnrk1aWaZLcZkQ_OZhQd8ZfHC=ix6_TZ8ZW270PWu0418gOmA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: prevent possible NULL pointer dereference in fuse_iomap_writeback_{range,submit}()
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:35=E2=80=AFAM Luis Henriques <luis@igalia.com> wro=
te:
>
> These two functions make use of the WARN_ON_ONCE() macro to help debuggin=
g
> a NULL wpc->wb_ctx.  However, this doesn't prevent the possibility of NUL=
L
> pointer dereferences in the code.  This patch adds some extra defensive
> checks to avoid these NULL pointer accesses.
>
> Fixes: ef7e7cbb323f ("fuse: use iomap for writeback")
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
> Hi!
>
> This v2 results from Joanne's inputs -- I now believe that it is better t=
o
> keep the WARN_ON_ONCE() macros, but it's still good to try to minimise
> the undesirable effects of a NULL wpc->wb_ctx.
>
> I've also added the 'Fixes:' tag to the commit message.
>
>  fs/fuse/file.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 5525a4520b0f..990c287bc3e3 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2135,14 +2135,18 @@ static ssize_t fuse_iomap_writeback_range(struct =
iomap_writepage_ctx *wpc,
>                                           unsigned len, u64 end_pos)
>  {
>         struct fuse_fill_wb_data *data =3D wpc->wb_ctx;
> -       struct fuse_writepage_args *wpa =3D data->wpa;
> -       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> +       struct fuse_writepage_args *wpa;
> +       struct fuse_args_pages *ap;
>         struct inode *inode =3D wpc->inode;
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
>         struct fuse_conn *fc =3D get_fuse_conn(inode);
>         loff_t offset =3D offset_in_folio(folio, pos);
>
> -       WARN_ON_ONCE(!data);
> +       if (WARN_ON_ONCE(!data))
> +               return -EIO;

imo this WARN_ON_ONCE (and the one below) should be left as is instead
of embedded in the "if" construct. The data pointer passed in is set
by fuse and as such, we're able to reasonably guarantee that data is a
valid pointer. Looking at other examples of WARN_ON in the fuse
codebase, the places where an "if" construct is used are for cases
where the assumptions that are made are more delicate (eg folio
mapping state, in fuse_try_move_folio()) and less clearly obvious. I
think this WARN_ON_ONCE here and below should be left as is.


Thanks,
Joanne

> +
> +       wpa =3D data->wpa;
> +       ap =3D &wpa->ia.ap;
>
>         if (!data->ff) {
>                 data->ff =3D fuse_write_file_get(fi);
> @@ -2182,7 +2186,8 @@ static int fuse_iomap_writeback_submit(struct iomap=
_writepage_ctx *wpc,
>  {
>         struct fuse_fill_wb_data *data =3D wpc->wb_ctx;
>
> -       WARN_ON_ONCE(!data);
> +       if (WARN_ON_ONCE(!data))
> +               return error ? error : -EIO;
>
>         if (data->wpa) {
>                 WARN_ON(!data->wpa->ia.ap.num_folios);

