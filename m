Return-Path: <linux-fsdevel+bounces-51352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BDAAD5E3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 20:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965DE1BC164B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 18:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2D023643F;
	Wed, 11 Jun 2025 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSy4kFps"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E4380;
	Wed, 11 Jun 2025 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749666833; cv=none; b=DcpoGTvENgtlK7zss0IQhldhfLqyNLnmgJwsj1HaCEVMPoZnXdZobMf3B3/x1IY1mTdxoFJOwJLDm7gljSWfny/Xwugo0PIFWxW3MSArZm/M7NqYCzJDOnNgIFybahvhhvBOxhNZb/EoIXc82F7Rs77zRe+3fsUf/8Vt1JeUmCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749666833; c=relaxed/simple;
	bh=+oW48Ajcnw3gDN8bOcRQ1flz01JQd3Dh8GUHwcy/ghw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnT01ZSalNvLB5CzD5HSXc9z9PdegdGmkI1AQLyCfTd3uU493w6pl6DlF8+ZxHABW/eeNQtuF3sm3sG9w1JdWnPDhVWKXNKCF2A7ECadX/1wnG9g1WzdewCi7Ql/jzMxLAnJesJfn8FIETbZLJ3EmxRWysZvU/040hGa0NrI7uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSy4kFps; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4947635914aso2086321cf.3;
        Wed, 11 Jun 2025 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749666831; x=1750271631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjW3L/KHyaPCvszolItGQqJB4wMrgc+SriLcSr14SIk=;
        b=OSy4kFps3Sl3tmwu660CJhnAI+kNxPxHTOuPrxNgVblT0g3lv8RVDYckKFNJFruJt6
         FMIpTJPt1wMieJ/fXYLQcZbT469Gg3e6d0zkDpdbJALwUuzmI3UIec6S86PIHuQ8KeFM
         mpHknlouvj8zrKgvISNx9HjB0hdUSGM+X7CuDXlOKGF3qaCgiJ9vClI4PxnJl9T4WSOq
         e0BNWcTwWKSJ8u/Qy12ukshdFLAuiQ1LhirJPW9271MK3TSDYR4HKpl1rKUfyNqAki9V
         I2dNeShnfeUyW13pBxISWgwL0ojIzotTO9TmmthyqKgTq30tHx9Syt04oN6xTSJE2Quo
         /2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749666831; x=1750271631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjW3L/KHyaPCvszolItGQqJB4wMrgc+SriLcSr14SIk=;
        b=OqnWYJE+rVRP9ythZHmyEOiL2uI0yoBh8K/EV8LN2s2BhYtR0QmhEIRoiVWpBTd+dB
         uepO0p0tCC9pKgM0NCabMgSdMShL9EImI24wAobFPR6znVRPoDNq26DAkbUFKrDBLVqX
         KoH3iUM65adWxs9hS6Pk5PMCgmDwHj5uaj2YG4xh6evdMV3zXLohQTRnUEg9XIiXRi/j
         cVsCUN8Keq9Av12mde87pd8v2O5h1lGWwyrtMGX5cg6MsAU2utdrWkoPv90dl85/7B7m
         T9+fnlSaVifSucsh4DgUUqBvqQFRV4y2vfieY8ac2r1XJDYGR/wY4GExjl+VcYc9ntgI
         ftPA==
X-Forwarded-Encrypted: i=1; AJvYcCWNDDTEhDEK6tySilwot3p83N4PiWbGn7WoNCy38YaCpB/qsFFh8tHtTNz8ORvkB6hlWrw3Oc347/DI7zpg@vger.kernel.org, AJvYcCXjc+ck0fqX0Zjv79h8fBcCuqOW0H/12TLu37h58eeQ/Tiz4UFFMED978vy7C8KZrj8svP+hBUusJG0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4m6MbXt/L8syjLy50HiMCfC+O2w9gb37hiUyI6bEC2oEt6g1o
	fvzUPmJQZ/wDKCYFOvxvHuLt1uZqcIEjYsNNkw+qSJDHBc8Q8sQ91I+ik/HG8Ikf/2ZO729S13V
	ID8P0NdZnwjxtvZOKBVr2zz1CbCzAxnI=
X-Gm-Gg: ASbGncslRzd4hAykDzZjC6mq/1/ckCJx9r3GrRJjZlURQOMZ9SXcigtdSsR3+LWoYYG
	wfrRPfvfREQbCOIfBChxL8OHXCQKBzpGQpRcMolZ8vrrvjWP7PuYk1zrY/AvifWPzi0xoel2JL4
	kQxjN7AAw8msWMoLCB5PzEwqlL6lBRkdjyTYV1w++YHI0E5ZgX7L66V4/xl64=
X-Google-Smtp-Source: AGHT+IH6TXU7QromkAsPD8BA+Mw3b5bFnzJoYLr6sNWPOa4RfNsuvd75bPdL8OpvFjToP1ko1w45Z6Hf0MpsySrELMA=
X-Received: by 2002:a05:622a:4c83:b0:4a6:eac8:58c6 with SMTP id
 d75a77b69052e-4a713b9f7bcmr83720921cf.13.1749666830984; Wed, 11 Jun 2025
 11:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-3-joannelkoong@gmail.com> <aEZm-tocHd4ITwvr@infradead.org>
 <CAJnrk1Z-ubwmkpnC79OEWAdgumAS7PDtmGaecr8Fopwt0nW-aw@mail.gmail.com>
 <aEeo7TbyczIILjml@infradead.org> <aEgyu86jWSz0Gpia@infradead.org>
 <CAJnrk1b6eB71BmE_aOS77O-=77L_r5pim6GZYg45tUQnWChHUg@mail.gmail.com>
 <aEkARG3yyWSYcOu6@infradead.org> <CAJnrk1b8edbe8svuZXLtvWBnsNhY14hBCXhoqNXdHM6=df6YAg@mail.gmail.com>
In-Reply-To: <CAJnrk1b8edbe8svuZXLtvWBnsNhY14hBCXhoqNXdHM6=df6YAg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 11 Jun 2025 11:33:40 -0700
X-Gm-Features: AX0GCFs6dQOSA1lKs5eLYQ1kKjuwsKRMo3OXe1BwXvRsYQ-AStyGh-GPTSkiUn8
Message-ID: <CAJnrk1au_grkFx=GT-DmbqFE4FmXhyG1qOr0moXXpg8BuBdp1A@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] iomap: add IOMAP_IN_MEM iomap type
To: Christoph Hellwig <hch@infradead.org>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 11:00=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Tue, Jun 10, 2025 at 9:04=E2=80=AFPM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Tue, Jun 10, 2025 at 01:13:09PM -0700, Joanne Koong wrote:
> >
> > > For fuse at least, we definitely want granular reads, since reads may
> > > be extremely expensive (eg it may be a network fetch) and there's
> > > non-trivial mempcy overhead incurred with fuse needing to memcpy read
> > > buffer data from userspace back to the kernel.
> >
> > Ok, with that the plain ->read_folio variant is not going to fly.
> >
> > > > +               folio_lock(folio);
> > > > +               if (unlikely(folio->mapping !=3D inode->i_mapping))
> > > > +                       return 1;
> > > > +               if (unlikely(!iomap_validate(iter)))
> > > > +                       return 1;
> > >
> > > Does this now basically mean that every caller that uses iomap for
> > > writes will have to implement ->iomap_valid and up the sequence
> > > counter anytime there's a write or truncate, in case the folio change=
s
> > > during the lock drop? Or were we already supposed to be doing this?
> >
> > Not any more than before.  It's is still option, but you still
> > very much want it to protect against races updating the mapping.
> >
> Okay thanks, I think I'll need to add this in for fuse then. I'll look
> at this some more

I read some of the thread in [1] and I don't think fuse needs this
after all. The iomap mapping won't be changing state and concurrent
writes are already protected by the file lock (if we don't use the
plain ->read_folio variant).

[1] https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disast=
er.area/

