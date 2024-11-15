Return-Path: <linux-fsdevel+bounces-34975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0769CF4E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 20:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E10BB2B292
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 19:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BF71D63EE;
	Fri, 15 Nov 2024 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRTkh1FA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C170713D297
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699202; cv=none; b=Qg4MuWG3nSh4zEBL52I0sKneJkGKZuOL5DTxuYM8aq25teqIh4isNJnakJEHBMIbXnRe8Y5yvWZobFMNDbl4T7VI9v2TZQ8qqVoY8bZxFNKf3dKSkAQasNP/u93jXDtCpaP636xarunWn9BjBXBKhavr6Olr/0NKtE56axaFaNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699202; c=relaxed/simple;
	bh=95ohT0IF3uLJ1BUQ0CBDN7i7vyBA0unWb6I0/J1pLG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2sJT8hrANE38hQrN4q5O4n87TnK1VvrTFXCx+2e3XiQrC5x+CwzS0x+51V5o/sCxix6ESj2lUV4XGLn//wAe1OOMI8Ey1qIgNH57rmXeBtmjqDga8Hw49nCx/88mwPffZl0dCzdYZkbBLWlnqx1qyFMNii0/JNB31J9JJhkzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRTkh1FA; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5eb70a779baso1159296eaf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 11:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731699200; x=1732304000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iQri3sxuB/Kv03iTUdizwGXxr5fOcdPkNRuCmH3lcM=;
        b=DRTkh1FAXyhXfyArLLhHkrokTGMJzLSjH6hRe/s0fU0W6Uy/RHM+pHNYS+faHS2ViC
         VY48JnniNGp7R98knWTI/U+HlDR5tcm6QpFHyuFEM+4DnBAuuL6nnapQ2C7AZ5Q6my5Y
         dq2LjEWn8x0KC7PfiDqOn+w66bEZjTFJdgOJAJSF35TvWuHXnIDk+Im+oMwo619SYeMp
         Wh6a5bbi/8eGxFM4wMTmk3PBdDOEeboMdffFO+ermFCnrDF1pvxC/wdkRH4MpRmfypHh
         Wu6tVeO4GLBjhrc9BqlhxlVnRdro/tfDNOf3r0mg00pcG82pVuzJf3tJGBdmzgfM0lBj
         fNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731699200; x=1732304000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iQri3sxuB/Kv03iTUdizwGXxr5fOcdPkNRuCmH3lcM=;
        b=spdAIxvaVtXSopICvehbvx1JjWuX5XEOx1UvnAOS4P5LaJOOYSstYD4Bhkrx2ojWUI
         FTypzI0EfUrViYbtY+4cWi/TT0h5MUHX5lJU+fuowSn2fyDT9jL6RvCt5QSWyYfPQ6mx
         E7zVIZgKlTOl5eIDMTHA+tJ+TD85xjSjT3G89IIooL4Kwk0letbhmJ4W47GkVs2eAsZy
         hGFtz+maww26HTy2/RgylNRBAUYpadTO0GlOJqXkyRWDZEx5nC9T6NsraN2yqEjHKdUw
         5AN83xPe+YDYHoT2AWEayd0LQt8O2fBPEu3v1kHim7TlTsZl/KNu6Af/DqXgtDZg0v4N
         Z6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYBpdJPBwtRDrrchtFXrBGto9wE60yf+lUkdckwBs95QrwCTVplZcQVFmdmxOQaB+v9vWl2sSWnx+gV9Os@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9qrKlALSHyRC4wnShep5Jy8YZsPcKb8yyFkLtQjUVi9LJzkII
	CQt9rJMWz1nKfUvornI28w75tC6TDcj8cc/5JgYSHZNvYy+Nc+ow7zDUfc1KMbX6xxACcz1Wl9f
	JC9ipSZNXD2CEgFP3QpbFeB9SMeE=
X-Google-Smtp-Source: AGHT+IH2RmcVes3AG0lbD9cuLYYXUcOiGnvmOTFEevBeg1h1Hv39lcvK78H5/4/K7h3wGT7+BQnzD/ccTxeDJ13johg=
X-Received: by 2002:a05:6359:100c:b0:1c3:d56f:75d5 with SMTP id
 e5c5f4694b2df-1c6cd0a3e56mr285100855d.12.1731699199614; Fri, 15 Nov 2024
 11:33:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
 <20241107235614.3637221-2-joannelkoong@gmail.com> <lbwgnktuip4jf5yqqgkgopddibulf5we6clmitt5mg3vff53zq@feyj77bk7pdt>
 <CAJnrk1ZOc3xwCk7bVTKBSAh7sf-_szoSW-brEVx8e09icYiDDQ@mail.gmail.com>
In-Reply-To: <CAJnrk1ZOc3xwCk7bVTKBSAh7sf-_szoSW-brEVx8e09icYiDDQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 15 Nov 2024 11:33:08 -0800
Message-ID: <CAJnrk1YmwRaMFZHzfLiHfXmVHeHdKmyR2027YpwN+_LS91YS6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] mm: add AS_WRITEBACK_MAY_BLOCK mapping flag
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 1:11=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Fri, Nov 8, 2024 at 4:10=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
> >
> > On Thu, Nov 07, 2024 at 03:56:09PM -0800, Joanne Koong wrote:
> > > Add a new mapping flag AS_WRITEBACK_MAY_BLOCK which filesystems may s=
et
> > > to indicate that writeback operations may block or take an indetermin=
ate
> > > amount of time to complete. Extra caution should be taken when waitin=
g
> > > on writeback for folios belonging to mappings where this flag is set.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  include/linux/pagemap.h | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > > index 68a5f1ff3301..eb5a7837e142 100644
> > > --- a/include/linux/pagemap.h
> > > +++ b/include/linux/pagemap.h
> > > @@ -210,6 +210,7 @@ enum mapping_flags {
> > >       AS_STABLE_WRITES =3D 7,   /* must wait for writeback before mod=
ifying
> > >                                  folio contents */
> > >       AS_INACCESSIBLE =3D 8,    /* Do not attempt direct R/W access t=
o the mapping */
> > > +     AS_WRITEBACK_MAY_BLOCK =3D 9, /* Use caution when waiting on wr=
iteback */
> >
> > To me 'may block' does not feel right. For example in reclaim code,
> > folio_wait_writeback() can get blocked and that is fine. However with
> > non-privileged fuse involved, there are security concerns. Somehow 'may
> > block' does not convey that. Anyways, I am not really pushing back but
> > I think there is a need for better name here.
>
> Ahh I see where this naming causes confusion - the "MAY_BLOCK" part
> could be interpreted in two ways: a) may block as in it's possible for
> the writeback to block and b) may block as in it's permissible/ok for
> the writeback to block. I intended "may block" to signify a) but
> you're right, it could be easily interpreted as b).
>
> I'll change this to AS_WRITEBACK_BLOCKING.

Thinking about this some more, I think AS_WRITEBACK_ASYNC would be a
better name. (AS_WRITEBACK_BLOCKING might imply that the writeback
->writepages() operation itself is blocking).

I'll make this change for v5.

Thanks,
Joanne

>
> Thanks,
> Joanne
>
> >
> > >       /* Bits 16-25 are used for FOLIO_ORDER */
> > >       AS_FOLIO_ORDER_BITS =3D 5,
> > >       AS_FOLIO_ORDER_MIN =3D 16,
> > > @@ -335,6 +336,16 @@ static inline bool mapping_inaccessible(struct a=
ddress_space *mapping)
> > >       return test_bit(AS_INACCESSIBLE, &mapping->flags);
> > >  }
> > >
> > > +static inline void mapping_set_writeback_may_block(struct address_sp=
ace *mapping)
> > > +{
> > > +     set_bit(AS_WRITEBACK_MAY_BLOCK, &mapping->flags);
> > > +}
> > > +
> > > +static inline bool mapping_writeback_may_block(struct address_space =
*mapping)
> > > +{
> > > +     return test_bit(AS_WRITEBACK_MAY_BLOCK, &mapping->flags);
> > > +}
> > > +
> > >  static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
> > >  {
> > >       return mapping->gfp_mask;
> > > --
> > > 2.43.5
> > >

