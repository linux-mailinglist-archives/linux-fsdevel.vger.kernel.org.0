Return-Path: <linux-fsdevel+bounces-31174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 436CF992C46
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB891C21F3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833101D31B3;
	Mon,  7 Oct 2024 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMMj9X5p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8D1D2B23;
	Mon,  7 Oct 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304952; cv=none; b=PV4CFk/wdOdnJXKG8XDMDZ0Uu6DZ14NxtwBo5ne/vFMRrakmW1bi7ki5nAzFdjMU5gXiJ5d2lZa+yt9Hjuvcs2N5Ssc+pbZ+98iAIZoShERfeAARbgEXVy8MYgWk1sP5AJjssP8rthWvTT8rIwR9SlHwZYRzCHEI07qAe2aWrho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304952; c=relaxed/simple;
	bh=/JCGegeu/bJtZOeM11GrAFFbEEysaISBFfJDI6X6RHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIV69a7a4w0aU6+G4YlzbK6VISm2DgbNQl//q1RRtMIntZ0pNS4iM7YJbTcLsYOKs/QQBFM31nXxWAnRQRca23ydDqVj2kqE8glMDhY6Q/8Zxy6TlPUGGpiaQIHRYrwCT7UJroLepTUZ5HuBVdu7s+i+5+E8BjALkXF4GPRZjGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMMj9X5p; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50ca34282c4so388012e0c.0;
        Mon, 07 Oct 2024 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728304949; x=1728909749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzaOVNpOaoiTMFQo74Hex9EECFlGPCDZVVqCLj6zhIA=;
        b=jMMj9X5pXVXbiBtWoV2nLTgQMtig1gRs9d7J+AsKljCTa8GFFtySRLTlkRz33HsDD7
         JAj0bW3Tf6Af0iao+0PyM2VYaAaekJtuZtWW5CnmTdrvk5lg+HDaHQ68tYLMoqwBGKbi
         pGHZhm4I7KjUCDuVoD/anSS8Y6AAV5KqWJWfv2ojwxrUynP/Acr/0CCTlkJt7ALb6O3G
         vqVg2KO1CBG6k7u5Uw3WmtfTFehnPaXgWC0okMN6cD3084D0O9jt4tkMzxsNHA8rOHDF
         DOn//LG4SWmauUlLhIL5undJBHh8oTGePIETR6qfsU/MrZdgeUdcm/1H+ObQ1LyeSnWU
         NSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728304949; x=1728909749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzaOVNpOaoiTMFQo74Hex9EECFlGPCDZVVqCLj6zhIA=;
        b=uBsg+So91twMF6ybMTYLtpGISIoMl2X+aHDSe8ov6mqZtHzb9j6RaH8wE8HLBX0Ef4
         /dYgQ4pwgPPOQUNG9HiPF+9kGd4tMEx5+lcl4DsiKcwXNx6WW4OF0pkC0YKpHXM4RY6G
         SZKMBnKDIMK+tupHSsmU2qZrINQa1d2NWQEX9Gui1bSfSeKns2vtqrWbFxjq+dmRGjgo
         1+n4o8FY9lTi9wd2RBThbRLTATqyOC6O94VbyBNuyh7V/N/HYmQerp2Y0YO3J6fn4H7K
         F/7Uvf1m7G9Wms0ModCRjsB01WA4YlyLTg5/sKYc8tPIqHrsn85mk5tDna4wnox3PYWY
         w3vg==
X-Forwarded-Encrypted: i=1; AJvYcCVUoqdp/C4c/K5FgLxUO7TwLrkJ56xOyr0ATLCReoHY2amxLiOhdLXBIVIGMay3itb7/fEOUEOBRsxqIui/zw==@vger.kernel.org, AJvYcCVpIeOwgP/MOmPOtyKeB9PITSsAp2B/aK5tCnfiO6aFx888AMLje72jwqA+6etUQOWNAqkzf5MFR1W9OxKc@vger.kernel.org
X-Gm-Message-State: AOJu0YwDa3T98orl63KsRoSdm0THSGh2xR11QXNibSPvinowVl9hJ3y0
	GJVVrVUFYn1ValBTXNfqJSeE7ZufN+imByxGulIvJDul5asHYMAaXuDv5K7uHCtqQwvr7lbBtQW
	ibB2Ap7wL0FFL6klWl7ySCpsYlbqwXh45
X-Google-Smtp-Source: AGHT+IF6s/BDzfPWgcNrTUsremBvhlSxmiimvEhpfhSjDRlz/tJGN1ZpgMg0Iokz7CWkBnU+dVcs2LXKfPjU2YNI96I=
X-Received: by 2002:a05:6122:794:b0:4f6:a697:d380 with SMTP id
 71dfb90a1353d-50c8557ec18mr6072645e0c.10.1728304949236; Mon, 07 Oct 2024
 05:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006082359.263755-1-amir73il@gmail.com> <CAJfpegsrwq8GCACdqCG3jx5zBVWC4DRp4+uvQjYAsttr5SuqQw@mail.gmail.com>
 <CAOQ4uxjxLRuVEXhY1z_7x-u=Yui4sC8m0NU83e0dLggRLSXHRA@mail.gmail.com>
 <CAJfpegvbAsRu-ncwZcr-FTpst4Qq_ygrp3L7T5X4a2YiODZ4yg@mail.gmail.com>
 <CAOQ4uxi0LKDi0VaYzDq0ja-Qn0D=Zg_wxraqnVomat29Z1QVuw@mail.gmail.com> <CAJfpegtdL0R9BgbdMP7YzEVD0ZdWV=71cWSZtkCFhhOjXWOzrg@mail.gmail.com>
In-Reply-To: <CAJfpegtdL0R9BgbdMP7YzEVD0ZdWV=71cWSZtkCFhhOjXWOzrg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Oct 2024 14:42:17 +0200
Message-ID: <CAOQ4uxiPgk36=VUiGC87XykEJ6ZWwq25kdi--q1-69daCFQhBQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Stash overlay real upper file in backing_file
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 1:16=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Mon, 7 Oct 2024 at 13:02, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > What I see after my patch is that ->private_data points to a singly
> > linked list of length 1 to 2 of backing files.
>
> Well, yeah.
>
> Still, it's adding (arguably minimal) data and code to backing_file,
> that is overlay specific.   If you show how this is relevant to fuse's
> use of backing files, then that's a much stronger argument in favor.
>
> > Well, this is not any worth that current ->private_data, but I could
> > also make it, if you like it better:
> >
> >  struct backing_file {
> >         struct file file;
> >         struct path user_path;
> > +       struct file *next;
> >  };
> >
> > +struct file **backing_file_private_ptr(struct file *f)
> > +{
> > +       return &backing_file(f)->next;
> > +}
> > +EXPORT_SYMBOL_GPL(backing_file_next_ptr);
>
> Yeah, that would solve type safety, but would make the infrastructure
> less generic.
>
> > Again, I am not terribly opposed to allocating struct ovl_file as we do
> > with directory - it is certainly more straight forward to read, so that
> > is a good enough argument in itself, and "personal dislike" is also a f=
air
> > argument, just arguing for the sake of argument so you understand my PO=
V.
>
> I think readability is more important here than savings on memory or CPU.
>

Will do.

Thanks,
Amir.

