Return-Path: <linux-fsdevel+bounces-38434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFC1A02876
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 15:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BAC3A6267
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 14:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7736D7081E;
	Mon,  6 Jan 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HENpc+W3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16E41DE8A0
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174801; cv=none; b=IejckGTIvHhxVBQHEBuoQ/yu64OGvqtjVBO95HMac4Vs24yxCI2UCeNjE48gF5ZQ2Kc1XTamnaXPoT+PVcGkbNUL9pNeaxTnQrW8WEc3Yfyn+ZSDdyMqcYQbb16wPjOp/qanBT4Xq23eO4DpAqgKDYh1FoSuh8RQF3K7ad5V3rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174801; c=relaxed/simple;
	bh=C7LtKyCzlGdItHuAvJEs8/TMbunj1694sVRcpeAXX1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OilyjsokxJDsfxZMWU9xwsB32piJ+bsw5UkuWxtuXckqu/3XcWJ1gCZDFdz0qSQKo6GNWkMln0EymX/aOgOMrruIq4r236C+SG0AGrMzvU/if/nAWjpsfNnklwevmsNPOud1A94Qx/h3GRmHZdBbokdAN3dXz6ceigFmEMf49j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HENpc+W3; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-860f0e91121so8052793241.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 06:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736174797; x=1736779597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ggu2Gt6OoSUneMHd7Jw6i7jrimV8kEwyE4clScZyfis=;
        b=HENpc+W39EMiU4kcFSNgavPuhaAuzv0ehAk+9ld6uZ08OHxDF7NoOYswRlS4EdbQk9
         uAVAWah2xxkq5z6l+o9cBecnMP4cUv5GGwyo4efLYrFXIO9QtV6v8wIPdpvxDZ/rOxFc
         qwWaJxly6EMNW2VuH5/CQCDLTsueSr8FAUbz2t1BfgWrnNFRdmsICXG4F9hVIvXT7IDX
         hXcwqfYv97E866daOG9Hp5Z/v5zCssDlQW3qnrHb0HKoOZ9L9KiY9xle41IzmT+lanRx
         P542UjIwqAv8oZUMYSZBv70OuaNcmZ9s41K3I1rcxRZYxvdAD3V+feJrh66rXKZOVARR
         eaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736174797; x=1736779597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ggu2Gt6OoSUneMHd7Jw6i7jrimV8kEwyE4clScZyfis=;
        b=ZdDxbpJCwDkYfLWnQAupSa2j14umA92l+dvXpgIjgJolsNYnw+LFTfoecCH2Va4qeA
         Zz9wI4MUQowVbrjxI+5newO4EvTV9r6HVgLvqmGwLtEaQ1niBRahJU5rMdmexwFMhFqH
         SR1txmh7RMSEKZAvLc/OqoN9Nv8oxNbe3nbK6vizmRYbZoxnIlLyec2sGREDXWiVqXfO
         kS3mCJR9VEI6jCQW/6m7ZRG/fTkcV41rQjk0RUKArlhSXrfFo/uBFrRtHIOHvSj9IJcd
         iwWZUGBTM3p+n/fs4mzpyVTuG0Cyt73Ms/b3YF3RJuL+WLExdGlgSo8PJH5TZvnsmSEe
         Fwgg==
X-Gm-Message-State: AOJu0YwzmOPconHnmC77DmhePJpOBy9gUs8DKYPiT/dnd7NQi+Q8pVO9
	EgJwqBDLmbLWkjWfkVr2IZQgKUlz8EX6DOEo+2zZtz1F7MyiJcBwrxIAjLgWbvtGp0/Tw6/h6g0
	6cNEW8ZWEsmqM6fAlApxaGghQ4VImh9DRDWiR
X-Gm-Gg: ASbGncu+h4eeUwdf6dCcelOM3J8dKWGvx/djzSnXaGh5sI98ULyPU3NTDZgAv/RJXBx
	046TlFQJfcq9x91XfGVoF+hEnBBRT2/hRE78CRq1CR8jiYb9kWyleMdTfbt7gy+eLfp86bI8l
X-Google-Smtp-Source: AGHT+IGg7G0PuPPkuCcQLjmPI8VK22SX4dlE8VtTWHq+nREjtWO1cNSlhxCjShh11Xsdl/dES7hYgIzH8jVEQQmXPf0=
X-Received: by 2002:a05:6122:2b9:b0:516:dc0f:c925 with SMTP id
 71dfb90a1353d-51b64c06b47mr36789084e0c.6.1736174796980; Mon, 06 Jan 2025
 06:46:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250101130037.96680-1-amir73il@gmail.com> <CAJfpegvJsbK3A5p-c615KnN+gC0EF4sFGzAHp+GWaMDn=78CEQ@mail.gmail.com>
In-Reply-To: <CAJfpegvJsbK3A5p-c615KnN+gC0EF4sFGzAHp+GWaMDn=78CEQ@mail.gmail.com>
From: Prince Kumar <princer@google.com>
Date: Mon, 6 Jan 2025 20:16:25 +0530
X-Gm-Features: AbW1kva1hX6LI6hl7V8bgt8hsfAZbKf-3JJplrr5OC8uT-Tk8RcMTu6DlTs2Dpc
Message-ID: <CAEW=TRpjcx-CJRVNRzt-d2YdF732_=kXU-QCGz=L89CQNnC_Rw@mail.gmail.com>
Subject: Re: [PATCH] fuse: respect FOPEN_KEEP_CACHE on opendir
To: Amir Goldstein <amir73il@gmail.com>, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks everyone for the quick turnaround, especially Amir for the quick fix=
!!

Looking forward to the new release with this fix.

Regards,
Prince Kumar.





On Mon, Jan 6, 2025 at 4:01=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Wed, 1 Jan 2025 at 14:00, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > The re-factoring of fuse_dir_open() missed the need to invalidate
> > directory inode page cache with open flag FOPEN_KEEP_CACHE.
> >
> > Fixes: 7de64d521bf92 ("fuse: break up fuse_open_common()")
> > Reported-by: Prince Kumar <princer@google.com>
> > Closes: https://lore.kernel.org/linux-fsdevel/CAEW=3DTRr7CYb4LtsvQPLj-z=
x5Y+EYBmGfM24SuzwyDoGVNoKm7w@mail.gmail.com/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Miklos,
> >
> > I verified the fix using:
> > passthrough_ll -d -o source=3D/src,cache=3Dalways /mnt
> >
> > and watching debug prints from repeating 'ls /mnt' invocations.
> >
> > With current upstream, dir cache is kept even though passthrough_ll
> > never sets keep_cache in opendir.
> >
> > passthrough_hp always set keep_cache together with cache_readdir,
> > so it could not have noticed this regression.
> >
> > I've modified passthrough_ll as follows to test the keep_cache flag:
> >
> >         fi->fh =3D (uintptr_t) d;
> > <       if (lo->cache =3D=3D CACHE_ALWAYS)
> > >       if (lo->cache !=3D CACHE_NEVER)
> >                 fi->cache_readdir =3D 1;
> > >       if (lo->cache =3D=3D CACHE_ALWAYS)
> > >               fi->keep_cache =3D 1;
> >         fuse_reply_open(req, fi);
> >         return;
>
> Thanks for fixing this, Amir.
>
> Miklos

