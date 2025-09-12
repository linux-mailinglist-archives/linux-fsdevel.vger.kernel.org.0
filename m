Return-Path: <linux-fsdevel+bounces-61108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EE7B55460
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECA0AE71B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 16:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534C13164A3;
	Fri, 12 Sep 2025 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGpt8Rvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D088630B527
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692893; cv=none; b=rH+7y78Gz7Svqs2kuKUPM2q7vXccTXy/iJRXowruEEvae8NRxku55ziwR6PEKGHLgSYX4+TN2iHaLNrurhLB5dUIGz+h3Tf6x5QPzIgU0e9rkPZhHqqdHfpCkwidZMhucsUerLKHFNsZTLMRWTs+0zR6ZS/6sfabkKwq9RH13wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692893; c=relaxed/simple;
	bh=MRVkhyLhBzuYU060K/KA1IS9FmS+Zv1ZvikNViDB1i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEARs53PouCsW/1RbOEPO3orL94T2TNmWtzWu2XUN7xLPKDLAabIhJrNjGzCm1c3RP9lRMDUJhvqwC/aDdkUAP44fyEL7Vmslq9X6LTqC6Wp7ppkWySD+k2B2Lf+nvIjoJWp4KgH6o0Vty1rwWK3rf4eYv4N+ENC+N5ParQk1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGpt8Rvs; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b5ed9d7e30so24434981cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757692891; x=1758297691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOTrb4IXV8TTdWYoR9Od+Zkf9J1Lc0eHO5aRXijaq2Y=;
        b=AGpt8RvsOAhCTeRJL3LhbS6LxY4dCbTWGiTrmP8PM346aF5YnVVlt8JZkwY3zFKDi8
         1ELiPzumxjtp8N1VbuAAcOeseFODzlt+/fBQEEpqFdXnBkXNZAaBj16KFrQGEtzgRVBt
         dJmAK22od4FDQJUoF0ImLGCx6lKcnvoX8BBIjuQmEj/OJdEcitpQ4/7PwbfSzJPgrWEb
         bIyViWouxTdW6KN6Dj8nwaKVAmtr8zQYfs6mOKqRrszxUh4vM1fy3vYuoYvj3rPi4lw9
         263A/PaSBFBm3+57F5E3FfTBmBFSLzAcG4TYKU1eY/vXdR4GBlbxUhAcl4BgktPAd3eX
         iFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692891; x=1758297691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOTrb4IXV8TTdWYoR9Od+Zkf9J1Lc0eHO5aRXijaq2Y=;
        b=wzAtF6iqHMFBDVP9r0etPMci+PPZwBXuCReWasROLLxn+BUrur9H6BjyRZ8HxwnNEI
         spvj5lcWTyn3uEiTHqOCB8BeIqrYQ0y6OWf04Qtd+kABi+eHliafaT8U0KPduA+D+/pA
         ytp5xKrE0hmX1XRNOOhmxvfCW4QxMTSpzcOzhCdKk+11w53PsjVuHur+uZt8d5/PsBzC
         Zj/ksYnQQTD2tdsefUy8ROjER1IcSEzu1jYcx7a1PxP60r55otvmj4tJ7H/uKHpVWRcd
         mA3JzO9tyaVRq0ol+UjXEiy8nIbX1RbXwgL0fQnAymKkxn51Fp8R8VJz4qu9t4nXxTNj
         fdMw==
X-Forwarded-Encrypted: i=1; AJvYcCU1C8GVBPzv0mkGvAiFJXoFkmfzXMKFCoU52PDu9GvATC7z9gIpnEIlsdm+uy8g3eoG3do4p1EmPEBmQ9Sy@vger.kernel.org
X-Gm-Message-State: AOJu0YwWwHJNvkY7gtEnwEwm8WpSMqJD2fL3RdjYuYwCGd0FIjTZOCy8
	uWP26m+cWW9/h+WZzOsbcMAi9BgTF2gbSKnZWvk7ccqi5UWSMj+fH/Yev8/y8eUowjPReZlkBWj
	Jdr7c4I+Ii5dMfj/7RKFEi7gS7oXCynumlw==
X-Gm-Gg: ASbGncumeoPsYu5STjzIpUecVKb6WTO9yASScdeoWgonsWx28GLESO/QF02Fb3mf4Ic
	IzmjsnizKWz+GH90GX1UFZSnNjDk24KhsXdgNwLYggMV9/ppM+IyQi8uZb/QXpPnGuyNlLKVRSF
	+zev7KrOrPfcteUaqFoenemSpOld4pH8LH8x7GeGIv5cBeWepLfZFEAu702iOGIFVaD6rOdbqo2
	8j64lUvbhdYhLR0/ugqv98SVSP9HoCQePrlOPOMuMtv/7jA1dLZ
X-Google-Smtp-Source: AGHT+IFpEJeHHGMR/+rANXvYCLHGXODc/LHx0ut1LxSgKOWEZt2yvx1hw4BgafRJMV62S+17la7+3LzfUFy0mc1meoE=
X-Received: by 2002:a05:622a:4244:b0:4b5:da13:3b70 with SMTP id
 d75a77b69052e-4b77cfab1a5mr44965001cf.10.1757692890378; Fri, 12 Sep 2025
 09:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-2-joannelkoong@gmail.com> <aMKt52YxKi1Wrw4y@infradead.org>
In-Reply-To: <aMKt52YxKi1Wrw4y@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 12 Sep 2025 12:01:19 -0400
X-Gm-Features: Ac12FXyzQBWaHPsdA5p-aXewM42KENc2X1_esV-qMD6PmHLNB3vND9MBVb-40GM
Message-ID: <CAJnrk1bFQTKKBzU=2=nUFZ=-CH_Pc5VAj8JCJoG0hgNszMp2ag@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] iomap: move async bio read logic into helper function
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:13=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> > +static void iomap_read_folio_range_bio_async(const struct iomap_iter *=
iter,
> > +             struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
>
> The _async here feels very misplaced, because pretty much everyting in
> the area except for the odd write_begin helper is async, and the postfix
> does not match the method name.
>
> Also as a general discussion for naming, having common prefixed for sets
> of related helpers is nice.  Maybe use iomap_bio_* for all the bio
> helpers were're adding here?  We can then fix the direct I/O code to
> match that later.

Great point, I'll change this to "iomap_bio_read_folio_range()" for
the async version and then "iomap_bio_read_folio_range_sync()" for the
synchronous version.
>
> >  {
> > +     struct folio *folio =3D ctx->cur_folio;
> >       const struct iomap *iomap =3D &iter->iomap;
> > -     loff_t pos =3D iter->pos;
>
> Looking at the caller, it seems we should not need the pos argument if
> we adjust pos just after calculating count at the beginning of the loop.
> I think that would be a much better interface.
>

Sounds good, in that case I think we should do the same for the the
buffered writes ->read_folio_range() api later too then to have it
match

Thanks,
Joanne

