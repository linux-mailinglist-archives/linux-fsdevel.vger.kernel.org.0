Return-Path: <linux-fsdevel+bounces-34985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E466C9CF597
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 21:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A924288141
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 20:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A461D88D7;
	Fri, 15 Nov 2024 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbRrOMCd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10EE1DA23
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701836; cv=none; b=O7yS/+/ViglZiC1L/5LPRzn1W/1yFWzAp7NIG3MvjrMPcmhyzTQFTLvARgdsSjL8e9z+CIEg0zmS5OXIsbuY2MuMXEypNa3RoHmoeUsrmS6vNVnIoPUr2R3IDTgb54aiOaH4pBFJVd9s/BGhfGJ3LXcRhvTE/1Tt7yEmEnr7f5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701836; c=relaxed/simple;
	bh=FnoQgHkv4aT0MDGGYligilSySN601w/zPbya0C3aYyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h14QhhF8DErFQ8d58OT2aPxZ4C8S7Id2uF2xpf8K4YNhCUdk03b2C5V9dOMfRpli1PDNqrURcK0/k9RcRNivgG4nYHcfUnY3Tgis07XWu0LA3f2btG0IrN6zOz63UiL4WPlCEcRc3UPy5D6bRulJ5ev9mNTkJqFLIn7IhTNg5fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbRrOMCd; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460ab1bc2aeso52401cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 12:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731701834; x=1732306634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qh0I7Vu3/qZRwEeJS0ggWs9HsmxO9itGmPQ36bmBqHs=;
        b=NbRrOMCdLUZm2VDdE8M1F1o/tuOV9q4DkNXemgwFNst0Gcgtb2YFZjWqU6EeDbBsyD
         Qwm9HE+Ju0lGycfplBHVj5PKxVsDxwwPksFhxtNhCUrKjFk0KPW3pTF4kmzbmawOwHmz
         jLWycCI2t5t31ykgqdMvr0rgzNZkMYaYbLddAytLO/AuFoHlmzL7sbnp6RHOeJu0oK8g
         W52YfTBNjjMgvTTEJsIi7XrHmpyS0kJ/28rxYHQUUK/aPosFuQiy9hX2D8KHSfREP1/0
         G0qTtjSM1A9OjT8IluTwLv9sAwFtt742VJ+ZLv6cBhHPm5LUvAbA0fzDivbUI187lema
         6gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701834; x=1732306634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qh0I7Vu3/qZRwEeJS0ggWs9HsmxO9itGmPQ36bmBqHs=;
        b=dxQJhDCCM7mKqUhRdWlahXITR4R3RQytFc1MFIXao9UZ00wVrUVGfAfAxUTypMNC6A
         dYFAoUDn62PHy9swkBs9jOPfMTtilwMQ9ogIYfk4MSzXDp/sRG+bpRcv50POcJmdq7ot
         9cs9oN/+LhLIFh45tqDlAQHxNPqY8woN15Hd1urGB6uAjWfNKqEXWTKllXRg6ppsWlbw
         DblOGqH6yHYupOwtslYnVu3mPueKJJwVC898B+7GKcgkWxtllPBRgct7YMt3fhIRUsFb
         +ii6zmhK/fxjNTAtQCgx0x83qKPRNAaAZEkoqZUNo6Azf4Epx8FK2YoVdul94HbJ1vGP
         ac7g==
X-Forwarded-Encrypted: i=1; AJvYcCXFnI1i3JM2wWJXM48lnLzKuTjL1TWCu/8Ic9dC47vJ3xxGHcFqRkbEN93m2WgDVfVVG3RSwVd+DD9IGtCz@vger.kernel.org
X-Gm-Message-State: AOJu0YwFtwt6g5KEnH6oJHaGDopuSB3Qpuij2NAPo4qObl3B3Zjur/fI
	3RfYRfu+Phn431TwrpqkhoHuTiJ3P2D5tH+7ApMD0YqJMYI1HWxzFjeAXiuMRwRI/BMxbyYj57T
	uMZ4agJ23VWCJCV9et1Bl2hhfELM=
X-Google-Smtp-Source: AGHT+IFo9bs/NXX6VgmwCQgjqu7sNaOLsuEMw29hSI02h8Mwvlmx8v9LUjg4r/mt7fhnF07DLJeATG5r/Flm4If81tU=
X-Received: by 2002:a05:622a:40a:b0:460:9946:56af with SMTP id
 d75a77b69052e-46363e972b7mr55439681cf.44.1731701833679; Fri, 15 Nov 2024
 12:17:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
 <20241107235614.3637221-2-joannelkoong@gmail.com> <lbwgnktuip4jf5yqqgkgopddibulf5we6clmitt5mg3vff53zq@feyj77bk7pdt>
 <CAJnrk1ZOc3xwCk7bVTKBSAh7sf-_szoSW-brEVx8e09icYiDDQ@mail.gmail.com> <CAJnrk1YmwRaMFZHzfLiHfXmVHeHdKmyR2027YpwN+_LS91YS6g@mail.gmail.com>
In-Reply-To: <CAJnrk1YmwRaMFZHzfLiHfXmVHeHdKmyR2027YpwN+_LS91YS6g@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 15 Nov 2024 12:17:02 -0800
Message-ID: <CAJnrk1bkU4-ydnk8QatJP4=_VYta_wRh3-Z+1U3VxM=BE4h3Mg@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] mm: add AS_WRITEBACK_MAY_BLOCK mapping flag
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 11:33=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Mon, Nov 11, 2024 at 1:11=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Fri, Nov 8, 2024 at 4:10=E2=80=AFPM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
> > >
> > > On Thu, Nov 07, 2024 at 03:56:09PM -0800, Joanne Koong wrote:
> > > > Add a new mapping flag AS_WRITEBACK_MAY_BLOCK which filesystems may=
 set
> > > > to indicate that writeback operations may block or take an indeterm=
inate
> > > > amount of time to complete. Extra caution should be taken when wait=
ing
> > > > on writeback for folios belonging to mappings where this flag is se=
t.
> > > >
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > ---
> > > >  include/linux/pagemap.h | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > > > index 68a5f1ff3301..eb5a7837e142 100644
> > > > --- a/include/linux/pagemap.h
> > > > +++ b/include/linux/pagemap.h
> > > > @@ -210,6 +210,7 @@ enum mapping_flags {
> > > >       AS_STABLE_WRITES =3D 7,   /* must wait for writeback before m=
odifying
> > > >                                  folio contents */
> > > >       AS_INACCESSIBLE =3D 8,    /* Do not attempt direct R/W access=
 to the mapping */
> > > > +     AS_WRITEBACK_MAY_BLOCK =3D 9, /* Use caution when waiting on =
writeback */
> > >
> > > To me 'may block' does not feel right. For example in reclaim code,
> > > folio_wait_writeback() can get blocked and that is fine. However with
> > > non-privileged fuse involved, there are security concerns. Somehow 'm=
ay
> > > block' does not convey that. Anyways, I am not really pushing back bu=
t
> > > I think there is a need for better name here.
> >
> > Ahh I see where this naming causes confusion - the "MAY_BLOCK" part
> > could be interpreted in two ways: a) may block as in it's possible for
> > the writeback to block and b) may block as in it's permissible/ok for
> > the writeback to block. I intended "may block" to signify a) but
> > you're right, it could be easily interpreted as b).
> >
> > I'll change this to AS_WRITEBACK_BLOCKING.
>
> Thinking about this some more, I think AS_WRITEBACK_ASYNC would be a
> better name. (AS_WRITEBACK_BLOCKING might imply that the writeback
> ->writepages() operation itself is blocking).

Ugh, AS_WRITEBACK_ASYNC probably doesn't work either since NFS is also
async. Okay, maybe "AS_WRITEBACK_INDETERMINATE" then? We can keep
riffing on this, for v5 I'll submit it using
AS_WRITEBACK_INDETERMINATE.

>
> I'll make this change for v5.
>
> Thanks,
> Joanne
>
> >
> > Thanks,
> > Joanne
> >
> > >
> > > >       /* Bits 16-25 are used for FOLIO_ORDER */
> > > >       AS_FOLIO_ORDER_BITS =3D 5,
> > > >       AS_FOLIO_ORDER_MIN =3D 16,
> > > > @@ -335,6 +336,16 @@ static inline bool mapping_inaccessible(struct=
 address_space *mapping)
> > > >       return test_bit(AS_INACCESSIBLE, &mapping->flags);
> > > >  }
> > > >
> > > > +static inline void mapping_set_writeback_may_block(struct address_=
space *mapping)
> > > > +{
> > > > +     set_bit(AS_WRITEBACK_MAY_BLOCK, &mapping->flags);
> > > > +}
> > > > +
> > > > +static inline bool mapping_writeback_may_block(struct address_spac=
e *mapping)
> > > > +{
> > > > +     return test_bit(AS_WRITEBACK_MAY_BLOCK, &mapping->flags);
> > > > +}
> > > > +
> > > >  static inline gfp_t mapping_gfp_mask(struct address_space * mappin=
g)
> > > >  {
> > > >       return mapping->gfp_mask;
> > > > --
> > > > 2.43.5
> > > >

