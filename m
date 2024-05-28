Return-Path: <linux-fsdevel+bounces-20356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6398D2029
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 17:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC41A286B37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDF217164D;
	Tue, 28 May 2024 15:17:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11316FF4F;
	Tue, 28 May 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909437; cv=none; b=uolQf8lcPvcxYbyqyU+IFMShmyFg18HqlCXMMPIeOlxyajUAGzDY6Z2en1S0uIRoJiDH13NvpV7oipgrVjj+/5XlHjIGyDvqxSdlygNbSQeb1lzH1O+sVW+Vhi5JLhfSo+5xQjaHvPScm7YjzuyBO8vwlw5SUR9SLJOpTWSvdVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909437; c=relaxed/simple;
	bh=IJfXyghJCx3n9bOFggphQjk/yccvY0Ys2u/43WwXOVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Si2Eyfk4JvwljpD2zl/roWKv3RXzEF6vVzXNEVG5uDgGOg7HsPBELaGmLSCME1M+WZ7fndnEVGDtvtciRD2C5/PpsfiA5ps/hFA8NQIp07HX7IrxbocfONz7MEvmU6aCOd7kXRyWcjT1Wgdxtu+NEbIXNs7Y9fLd1J0sphzDxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-df7607785e9so893214276.2;
        Tue, 28 May 2024 08:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909434; x=1717514234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNi8/BhZqnIF83VuvAuQW5ywgzli2KEyZ1LygFSKuFY=;
        b=SJvAVu+mYkcWCnH/5GxVVlTp5nePPtgQCS1/WafifvpwrActLbRbhihMBfrKShd5L3
         ozJ+6FalWrNH8HUD+DXvbOc/JVG8szTPh8VuezlLk6LGn28F4sTk7MhKmI0jm7zmatN4
         DzcjeUDyEhm6Ci1w4jmyvZORFPgg3PAS4BVPG1crw/8JXoKZZ8eEndiqUtdm93baPoye
         tnq3hUt5+YDjbwwthqcWZupZZtjPD9zyIM8PgTLlMNKCqN2p3wyBbk2UoTVKh8sbBNH8
         Z7pxRHwmSScMlB6nujnoNXwT2j9B+Gx5K/hoC1vA3yIpDaU7rrRLBw16Ozna3oUnAoSn
         TmVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIL2YkhovvkN7PbkDDaz5Lw+47FDz+or6lI0pS25r0N+G5Rs+NMS/xc5pLgueUx8wijsGc7XaRv0vXISzNYLL7edB4XI1WzHbTUhm8TJZE8BKT58LcYYraZi7bQatkfrWsSx/C5mdBSX67zcr/1TSo7vUPIhBXRXyNJz1BQAoC1s+e61YneOUYMIiY
X-Gm-Message-State: AOJu0YyGAcN7pABsZlIetS6jsZksh1gj+a+cVcxzeMEviHEglH29S0AR
	Zu3IqsyXifj/sz4AHgeu2+6m1qVh5a8wEnfiZkrhRRYveppuP+68XUMuITQM7vo=
X-Google-Smtp-Source: AGHT+IEaNBcEZJtY8k4slGLDYE0OiYxufw2MZ0bZhq6I+vZrnGksYpVwo6N0nVkcLDeulh63poxoNw==
X-Received: by 2002:a25:81c7:0:b0:df4:ab38:64eb with SMTP id 3f1490d57ef6-df77221c33emr12131997276.40.1716909434392;
        Tue, 28 May 2024 08:17:14 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-df774741defsm1062636276.54.2024.05.28.08.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 08:17:14 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-df4e40a3cb6so1024282276.0;
        Tue, 28 May 2024 08:17:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqALxVhAz4x5iY2wzfqN5tbsqnrlBeFF0RIvJgtSX/5wF3oZS4KgCDDtJOlYF10OgkAsw9kgRrB+yiTsFpt7k66GMH9QMAX4YFn4xbGti96Pup1xBc/QzaeJbygcTRCTTa79q4yZL45D/nG54ltUjVJlhs5lq/7Tp8XbLU01P9zyXn4T6wlNqZ3B69
X-Received: by 2002:a5b:ecb:0:b0:dcc:d694:b4a6 with SMTP id
 3f1490d57ef6-df772185be3mr11329083276.15.1716909434046; Tue, 28 May 2024
 08:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <zhtllemg2gcex7hwybjzoavzrsnrwheuxtswqyo3mn2dlhsxbx@dkfnr5zx3r2x>
 <202405191921.C218169@keescook> <CAMuHMdUUTy7G6fUa7+P+ZionsiYag-ni_K4smcp6j=gFb9RJJg@mail.gmail.com>
 <uetvuew5tmhjeipqlemyuocqtx2yn2t5gkuew4vmxh4tbny7kx@4g2qkhfpwbmg>
In-Reply-To: <uetvuew5tmhjeipqlemyuocqtx2yn2t5gkuew4vmxh4tbny7kx@4g2qkhfpwbmg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 May 2024 17:17:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUd6mz+PhC17zNbacY2iYGdG8Q4UzXuaZvcQ5qHo=mmBw@mail.gmail.com>
Message-ID: <CAMuHMdUd6mz+PhC17zNbacY2iYGdG8Q4UzXuaZvcQ5qHo=mmBw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs updates fro 6.10-rc1
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kent,

On Tue, May 28, 2024 at 4:57=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Tue, May 28, 2024 at 09:18:24AM +0200, Geert Uytterhoeven wrote:
> > These are caused by commit 1d34085cde461893 ("bcachefs:
> > Plumb bkey into __btree_err()"), which is nowhere to be found on
> > any public mailing list archived by lore.
> >
> > +               prt_printf(out, " bset byte offset %zu",
> > +                          (unsigned long)(void *)k -
> > +                          ((unsigned long)(void *)i & ~511UL));
> >
> > Please stop committing private unreviewed patches to linux-next,
> > as I have asked before [4].
> > Thank you!
>
> You seem to be complaining about test infrastructur eissues - you don't
> seriously expect code review to be catching 32 bit build isues, do you?

I do expect code review to catch (a) wrong printf format specifiers
(especially when lots of casts are involved), (b) hardcoded constants,
and (c) opportunities for introducing helper macros,

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

