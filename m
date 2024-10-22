Return-Path: <linux-fsdevel+bounces-32597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EC39AB5B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E03B22E46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FCA1C9EB3;
	Tue, 22 Oct 2024 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQv1PbrZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9B1C9EA1
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620372; cv=none; b=XXDgHilNvku6W8uRV52tUoccWtTqZ6yvv3xxY4t9TFgjEWzfWVnZMdahbejZcvwgP3CzV38XTTAJ6rypkf4UkSFDqeOlKh/s9qZlT7MKA5L+agnxGBOv0LJiz8Rs+ED0eFx0dx+d2N9/jeoZBi4XDcDImRXKAmag/R5IXqawUpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620372; c=relaxed/simple;
	bh=Pz965/nWK0KQ9TnNiCt/dSLHpt8V7R+oR8sjDzw57g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPdakcQKt7OadJNqnd9QbDiEqQjBgBfKOAr7ZbVz3DpUU9+nAvEEU1Rm5YUt2psWRwIxqgBmX1SmAJROeY9Ghxm14HGnxpS0LXsL/6B3sSdqo0lVwkqKpyILDBl9pFrKc/2zkIT0wvVa+o/awBrmAfPPVDDDR/rQn+/hn23EcxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQv1PbrZ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460b2e4c50fso28579371cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729620370; x=1730225170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7fKdYgefTKSP2CYEqjhvK5TWuWdIjJ5IyBe33wK+JU=;
        b=HQv1PbrZ9rEKHlZz/re397Iw3QGLoYR4l9lPo/TUUcdVAEuEdrx/O7x6k6JshFvCiP
         1JvcbStTEMRlzjZGxqeYtadSx4bZjjlcmLj5OoUJZ11UHiMoTLg7zFPBk01LlH1dcqpq
         NmYnPnsm4JaalWZZpEjotwqzi5xOPQfaH0qv74SSD6cBHRIuVgkobd7QP08rpeCRv4oS
         UN14fWTrYKiIiNUKcw7qmOTjJBS8X5iuMSw1CPLbe+2Kijt+0NaPmEJcAgCzhzirTLKU
         JM8Ol8g5lBYIwdkDiM5pO4YDSPi3VPUcCvfqDPwcMkwJZ6rOA+YNujiZHanEn5HCodAO
         7ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729620370; x=1730225170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7fKdYgefTKSP2CYEqjhvK5TWuWdIjJ5IyBe33wK+JU=;
        b=h5OZS7gS30DpeRELWd6Q387EZHMOdyT8fq2q63bXNF/iKRUr5RTTNOoVpGmeZc+YuV
         fPQJOkORKF/XU627ON7QtB5rLQUwGKsfoNRiKH/JK04o5vjXDau/tznLpopaa2CX9qHI
         JuHsSjHm2c+9t4v1frZpBDtEARfw1YO/19h+33iXiUhwjERnYT4pl+eFJYn67TyUK1Ot
         FsDy7Sd5y7jE5wtoTq7Gy+QEb/sUBAMAbnO7G7sDufbGM9urHvmJoJL3PFf7sURRHOjZ
         HY3YBvA+x4M/SsUvF1NbZs6JX0z7jgExiX6MGIIu01YkbF+jaxvG3bs3sipsqpW1B8g2
         Zl8g==
X-Forwarded-Encrypted: i=1; AJvYcCWqJaIZZfDk5hHvs/NxP7oQiT1h5/kHXJ+igv2ctBxKJerBfdD8sLj48OI6zAu8Hf35aUDzbeNfUVfC0LYe@vger.kernel.org
X-Gm-Message-State: AOJu0YzsfRcgbkN1GjpD5vShsw5hAf5TgX5MEmMGbwkwp5kYaYOttGMW
	ytMVwj90GErTq6n+p6A+Ky/xM27Ay5XsxLGl0+635dclChhLnY2wWK+RwhO9R0isZ6Fx30dRN+I
	ckGQQ9Ck875c1fPnrh6QQ8/rZkTA=
X-Google-Smtp-Source: AGHT+IH1ja05EFu0iFqjA4BFSMtULFpkFvV7mX2znjT8hoyP/sqe+g9k+39Eh1YCz8ZV0M5iGVLFgiOu/GWb1rK7yVg=
X-Received: by 2002:a05:622a:449:b0:460:8f81:8c9a with SMTP id
 d75a77b69052e-460aee847a0mr240056671cf.60.1729620369752; Tue, 22 Oct 2024
 11:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002165253.3872513-1-joannelkoong@gmail.com>
 <20241002165253.3872513-12-joannelkoong@gmail.com> <20241018200139.GB2473677@perftesting>
In-Reply-To: <20241018200139.GB2473677@perftesting>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 22 Oct 2024 11:05:58 -0700
Message-ID: <CAJnrk1ZR4O++NBRhwzEw6GdpuxNDxGVW=dMYOvuZ-CyQP83iwA@mail.gmail.com>
Subject: Re: [PATCH 11/13] mm/writeback: add folio_mark_dirty_lock()
To: Josef Bacik <josef@toxicpanda.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 1:01=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Wed, Oct 02, 2024 at 09:52:51AM -0700, Joanne Koong wrote:
> > Add a new convenience helper folio_mark_dirty_lock() that grabs the
> > folio lock before calling folio_mark_dirty().
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/mm.h  |  1 +
> >  mm/page-writeback.c | 12 ++++++++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index ecf63d2b0582..446d7096c48f 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2539,6 +2539,7 @@ struct kvec;
> >  struct page *get_dump_page(unsigned long addr);
> >
> >  bool folio_mark_dirty(struct folio *folio);
> > +bool folio_mark_dirty_lock(struct folio *folio);
> >  bool set_page_dirty(struct page *page);
> >  int set_page_dirty_lock(struct page *page);
> >
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index fcd4c1439cb9..9b1c95dd219c 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -2913,6 +2913,18 @@ bool folio_mark_dirty(struct folio *folio)
> >  }
> >  EXPORT_SYMBOL(folio_mark_dirty);
> >
>
> I think you should include the comment description from set_page_dirty_lo=
ck() as
> well here, generally good to keep documentation consistent.  Thanks,

Looking at this some more, for v2 I am going to replace
set_page_dirty_lock() to be a wrapper around folio_mark_dirty_lock(),
eg something like

+int set_page_dirty_lock(struct page *page)
+{
+       return folio_mark_dirty_lock(page_folio(page));
+}
+EXPORT_SYMBOL(set_page_dirty_lock);

so that we have one source of truth for the logic. I'll remove your
Reviewed-by for this patch in v2 in case you have disagreements on the
newer v2 implementation.


Thanks,
Joanne

>
> Josef

