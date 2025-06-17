Return-Path: <linux-fsdevel+bounces-51988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1033CADDEB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 00:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46CF3BC563
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 22:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEE7295528;
	Tue, 17 Jun 2025 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+1Ybjnk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162CB202C48;
	Tue, 17 Jun 2025 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750199157; cv=none; b=FDzc/lRoFpGp3HPSr/DzpRLJtZJf/NH+3P996z35TbqrUQx+SDqSQ8J/LAAS0pKIgEoA2+VHe/zq/MPg5IJiPghE7QDzzP5IeRs/XDDIIIGCfcXPJi4HjxbXZcD3EhWVJA9Bw19XlZ8XJKyOIDFWQ84hqP2O3m9+gYcMZp5dRxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750199157; c=relaxed/simple;
	bh=IkHODsj3LMl6DlIAGg//NNU39NjtBqCmQQsRmb27n4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGF7TvQYXHRCUjecT1xNA4aXh7HMntY2k2vidQ62FT/7OjmEbPsibYYJk2uB5KnRe33aaJ8pqjNQyquDN/SM+bAlTCI6zhAw2lSHkt7gV6R9CcXkYZw285lXqvYjJpshgGa+t9hWocJylZw6Nn/GvkczXnPSnXT6kWJydGzojD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+1Ybjnk; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a43972dcd7so79800801cf.3;
        Tue, 17 Jun 2025 15:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750199155; x=1750803955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOHudB3qWFtr4TV/okRv6w4AxszP8orrjoIXfZSBLrg=;
        b=g+1YbjnkQ5KanzCYrF6em9UwZKyPuE1+sAUa7/1R7LJHDYhEnMUAdR9OlaapdU08uB
         r93kQcsUEomKT3rOcjvVYr431Q+ItYTKKwKRxl/3yWI7uTQRic41CjRRxqJ6weGDipm8
         2dx1fPlc2d3JLNr0Oxl1lqNBRaYwT/hVSTHL/AoR743w8D2aUgnMkeHZb89Ls5CcCFjf
         PlPMV8A/nlr9iBHqs/EJXKs5exQZ4HV9fxOncesiOrfDc18U+bzdRurGsqEZtaWF3PRr
         p2eX0VY/xJ9abnpC6jsjtMCKJsTM7YR/dMGCKXUvootR1xNjh1Arql4ZcDYuSZl+H27E
         zU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750199155; x=1750803955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOHudB3qWFtr4TV/okRv6w4AxszP8orrjoIXfZSBLrg=;
        b=IGgclu/UsNq0Wgy6EMnSn/YhJAlJ9ktJxaEMnIbJCiYGlME/+AX0NrfNg3sTsgkwBV
         dzrOfZXzQMM5CyEb9LDWzJX0x7bAxHFarSsovU00g3JljxtfBxnCSF7IAD3cVhgtZQiD
         NDLEJ+bCfsQFVSOvJZB/dCykH90JzwUvI4eJ349n20/rAuNUUvHmY9nSvhUB//8Opz7H
         +AbQwfNcd19m0NQbRP+Leroi1LQpG5eE/HXb75FefRvNuUSB8c7/jv657VAWchRbTuXY
         w4/Xx6wJQoW1J52FWOwSrJkn1Pg+uiB3pZN1yqqR7igyo8cIjIqgvPEb0DOajSR9mQXf
         qjFw==
X-Forwarded-Encrypted: i=1; AJvYcCWOAEhtkVApKd05bDdGSQfgoV0rclyKa/MrWZA8jz47bmS3GisJtsDgp29FLHDn90zvxx53I7YR7pri@vger.kernel.org, AJvYcCXKX0Y/RCn7HsYTol394N1Cu0alPvIjvsDWuHYTUDrH0/BNwmkHROzgUIexF4sBGf5xli6aOfmCvfrWRt40kA==@vger.kernel.org, AJvYcCXar8ty/VBPFrFzX50GIPvcOI72p/QIqG8g1p9PEek6OAtnmSaKTw+kh4GIokuxPhItIxKoSICapxgu@vger.kernel.org, AJvYcCXu/yF8EpvpNJRBMg30lY3bDX/MXM0ts4+R09crx9EaMNIKAG1aDsa3AwR2hDSvE+TTLr27hemgTZlVNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7C10F7DGsnedm/VrItoUTodWY8PNpNXQq1CfIhzCUWMrEaTc2
	+9UnBMdMVWY5DrswQYP2NttdE74cjD0IxU62sX7oP4us/DsLf0/NCxJP6OMKakA71IHe00ZGZnJ
	ONYCNj85AXhoKoT4D8R8//gUmHpvBjY4=
X-Gm-Gg: ASbGnctgV3vw7+InpjxRFQ8PaYPkQ2Tc89vUxDoMr63J7UwBgf3ZaukPxO4jkqWJgkd
	CGRzMchwPGjqnTgdVtRlE5iQsIxKUiIU/FtiYB1obKUM/0KTM/EVRa0Em/8yS2HZkJD4J0VZThh
	7fAi0HV/dIJCzP6kIKZlBfh/fMamvgS3DxBoqKemXzm6+T6OJ9DeE9Y3WX90c=
X-Google-Smtp-Source: AGHT+IFT2IbS7IY/ZG8utAx1TX8YtZX4KzeTFUBS4g3I5+hjckINK4fFIkyAX5117p/bYpzRPLh6P82Wyv/n/vAtbzc=
X-Received: by 2002:a05:622a:d1:b0:4a3:4d46:c2a6 with SMTP id
 d75a77b69052e-4a73c51f790mr202374651cf.7.1750199154958; Tue, 17 Jun 2025
 15:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-11-hch@lst.de>
In-Reply-To: <20250617105514.3393938-11-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 15:25:43 -0700
X-Gm-Features: AX0GCFsI21gwIMPwJfdvUohzFbNWXhMjQxHEzcHQpvBVMKKQzS8fPtvEOYy6xzg
Message-ID: <CAJnrk1YOtCnAD2R5G1sYipG=aTkWBdYfm-F0iioV55sE5A_HYQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] iomap: replace iomap_folio_ops with iomap_write_ops
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 3:55=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *f=
rom,
> -               const struct iomap_ops *ops, void *private);
> +               const struct iomap_ops *ops,
> +               const struct iomap_write_ops *write_ops, void *private);
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
>  void iomap_readahead(struct readahead_control *, const struct iomap_ops =
*ops);
>  bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t cou=
nt);
> @@ -344,11 +337,14 @@ bool iomap_release_folio(struct folio *folio, gfp_t=
 gfp_flags);
>  void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t l=
en);
>  bool iomap_dirty_folio(struct address_space *mapping, struct folio *foli=
o);
>  int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
> -               const struct iomap_ops *ops);
> +               const struct iomap_ops *ops,
> +               const struct iomap_write_ops *write_ops);
>  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
> -               bool *did_zero, const struct iomap_ops *ops, void *privat=
e);
> +               bool *did_zero, const struct iomap_ops *ops,
> +               const struct iomap_write_ops *write_ops, void *private);
>  int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> -               const struct iomap_ops *ops, void *private);
> +               const struct iomap_ops *ops,
> +               const struct iomap_write_ops *write_ops, void *private);
>  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_o=
ps *ops,
>                 void *private);

Maybe you'll hate this idea but what about just embedding struct
iomap_ops inside iomap_write_ops?

eg
 struct iomap_write_ops {
        struct iomap_ops iomap_ops;
        struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
                        unsigned len);
       ...
}

and then only having to pass in iomap_write_ops?

