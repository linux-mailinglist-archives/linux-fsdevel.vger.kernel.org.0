Return-Path: <linux-fsdevel+bounces-69020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61314C6BABD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 21:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3318344D9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 20:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060EA30BB89;
	Tue, 18 Nov 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkbzpiUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9DF30AD1A
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763499231; cv=none; b=dIjvg36w4L+2SPS+whSiVDu4BkyE0ogRGPbvbNJ17lYEZv8D/j2QkB3lTEazcuuHeObuPemqPnedVVRl0qBJnWD9SdyskDCqP9eGACduUvudrpaEPJazr7qOET7lovSqw45HTA3xpFq5uabweTtE+EaYhbB6EM3Mj+3t5V7lv6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763499231; c=relaxed/simple;
	bh=/wOkCW7Thy72o43Iyftj6wzQDwWAAbCMPTgjw/110yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eE9hc8jnNoAXACuVkKxoWtLpdcGgjIkOG3fNGaq+FDVUfFpHvObnduP6yUwiE66m/XCr7zPHEiBC4lSTPizRPi7BU+L5JYuUhI9ZpLcsrjsnY5G3FB08rK2ZkbqWBm8X7x3t14Hkvgil0GKR7psJDlRNabsfyh1SDLkSs0Y+oo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkbzpiUh; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b1e54aefc5so499616085a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 12:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763499229; x=1764104029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Bxqymo15qhiCvBcsy7BEC+eEUIGbNjqyBlntW6N3DU=;
        b=VkbzpiUh2iNHUkMieAsJKBN8PtfcMt6bF3hMaRdy97ww7kdnQGASmwNJy+qs9/6CXL
         nvrahxlT9d3MMuUAbcCcCsGfR0qPP0Wc/vZ1fHQTSZD7AJ+nurZwVdwcHKyDTDKmT1dQ
         tVtueoQYNpBS+fePwCDvv5ZhtbTO01sqZZjMWGcx1xzsQo0m1b18QRtWucAAE/K4nfB8
         rGSGpWKneKoBt8emTwyiWxvdeyowA67Bz3BP1GN7HTtD0ZYXUxP4sf/TyurEKMnHhzQC
         gBDA5d1tWx4HGt0ZnRvqQCEDg7YtbKZIF1KB1Wv7hfsahcOAKr05yyOl9CvglPoo7d1k
         typw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763499229; x=1764104029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Bxqymo15qhiCvBcsy7BEC+eEUIGbNjqyBlntW6N3DU=;
        b=EoXiPqL471SWvcMxg02d2gSKi4xo+I6kFdnwoe6/O9uOGiL89g+6GNiU+yO07Uy+F8
         t0nApE8vPMCUirsEObWE2eWTKDw4hL6u5mtF5O2jQ+az+uBQexgGiy7/8cD9c+q5atPA
         Ib0jTHaSsnYu38+uKgYXBpWRk/nqOrA5kjhsuyrx+lK+K1eUkZZjP/d+qe22WUKK2Kv/
         Lm5M3yF4ggLzAbrVlaWfuXz7B/4WfF79L3XHhKwoJx4EhmMOrPzPUwrRGEYDN7TzDFc2
         G5P00t+iBC+VI93gCDPUnbwJoiu1AAeVJguqjqMHPgdjshvtdbib9U4IirxFfiYOd3dm
         QfOw==
X-Forwarded-Encrypted: i=1; AJvYcCXeKBRjVq0qo76o/mv3Ci7pJuJ03ETntSEGMKZl4pf72p9e4SbXiaVVJq4/HfCP61g7vjGTVKdypApC0qkz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr8aLyMfTKUBhB9VKUXZBjmDFl6ekgtdX4pHgJSdhjS/8qssBa
	zVgR35Tt7f2rgSv4YZSpDAEqrvLmM2xW0Kbl21iney9VR1e0zLSirzB5MI1sa0XLFqHSjcnYJmK
	iCkZvGmn6FzVsVedfCZUT6YEvH2lhASLw/RS0
X-Gm-Gg: ASbGncvW/oJWkNOQW8Ln+IOj7VcK+9Y/T4iOzFlTNzEfEuH44hZuEFxmkNTgqYKDVgv
	9gOFBp0PT0m4vJRQWZa7vPi6YlEupKhYay1hcq48Gi/AnnaMgX5+s/CIZLsX+8QV+EbJY52vaYE
	aIBYgTf5FuVa9tV8+DNYQzJW754xzq/K0/ZJqV9JUz7Ghl+Av4usFMI5Lj02Qv5yiOGCDxFw+XW
	fOsmkMA54d/lPcUnpT7Tdwt8+Erx6H20667l5y05n9M7VcmLJdd6OxiUGvKwztKj/k0aJZqRcvt
	RESM
X-Google-Smtp-Source: AGHT+IHhrgKqn/sF3ulad9QB3rQr5cpe/J3GXTJCWteLyR9XOv3stkQplrOPK2OLVG0xzX+G/7pqxeMlAdnXg3OXL+Q=
X-Received: by 2002:a05:622a:50a:b0:4ee:1b36:b5b4 with SMTP id
 d75a77b69052e-4ee1b36b8bamr111815201cf.15.1763499228761; Tue, 18 Nov 2025
 12:53:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118004421.3500340-1-joannelkoong@gmail.com> <aRwJRnGDrp9oruta@infradead.org>
In-Reply-To: <aRwJRnGDrp9oruta@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 18 Nov 2025 12:53:37 -0800
X-Gm-Features: AWmQ_bnwb-7toRLUCHEaQN1-ATKQn6OQyFrc4TWela50BNlC3Tj-cFecu6_J3Zg
Message-ID: <CAJnrk1bkg_FvHxMtfdf=knCX4si2rTrmeMGyK=MO--Jz+hU6fw@mail.gmail.com>
Subject: Re: [PATCH] iomap: fix iomap_read_end() for already uptodate folios
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 9:51=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Nov 17, 2025 at 04:44:21PM -0800, Joanne Koong wrote:
> > There are some cases where when iomap_read_end() is called, the folio
> > may already have been marked uptodate. For example, if the iomap block
> > needed zeroing, then the folio may have been marked uptodate after the
> > zeroing.
> >
> > iomap_read_end() should unlock the folio instead of calling
> > folio_end_read(), which is how these cases were handled prior to commit
> > f8eaf79406fe ("iomap: simplify ->read_folio_range() error handling for
> > reads"). Calling folio_end_read() on an uptodate folio leads to buggy
> > behavior where marking an already uptodate folio as uptodate will XOR i=
t
> > to be marked nonuptodate.
> >
> > Fixes: f8eaf79406fe ("iomap: simplify ->read_folio_range() error handli=
ng for reads")
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > ---
> > This is a fix for commit f8eaf79406fe in the 'vfs-6.19.iomap' branch. I=
t
> > would be great if this could get folded up into that original commit, i=
f it's
> > not too late to do so.
> >
> > Thanks,
> > Joanne
> > ---
> >  fs/iomap/buffered-io.c | 37 +++++++++++++++++++------------------
> >  1 file changed, 19 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 0475d949e5a0..a5d6e838b801 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -455,29 +455,30 @@ static void iomap_read_end(struct folio *folio, s=
ize_t bytes_submitted)
> >
> >       if (ifs) {
> >               bool end_read, uptodate;
> > +             size_t bytes_not_submitted;
> >
> >               spin_lock_irq(&ifs->state_lock);
> >               if (!ifs->read_bytes_pending) {
> >                       WARN_ON_ONCE(bytes_submitted);
> > +                     spin_unlock_irq(&ifs->state_lock);
> > +                     folio_unlock(folio);
> > +                     return;
> >               }
> > +
> > +             /*
> > +              * Subtract any bytes that were initially accounted to
> > +              * read_bytes_pending but skipped for IO. The +1 accounts=
 for
> > +              * the bias we added in iomap_read_init().
> > +              */
> > +             bytes_not_submitted =3D folio_size(folio) + 1 - bytes_sub=
mitted;
> > +             ifs->read_bytes_pending -=3D bytes_not_submitted;
> > +             /*
>
> Very nitpicky comment:  I'd do away with the bytes_not_submitted
> variable:
>
>                 ifs->read_bytes_pending -=3D
>                         (folio_size(folio) + 1 - bytes_submitted);
>
> and keep an empty line before the start of the next block comment after
> this.

I'll submit v2 today with these changes. Thanks for reviewing this.

>
> Otherwise looks good;
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>

