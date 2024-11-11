Return-Path: <linux-fsdevel+bounces-34327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 874CA9C48B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A42FDB3B50B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F0A1BC07B;
	Mon, 11 Nov 2024 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCj5aATx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04712AEE0
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731359508; cv=none; b=A3gCIsUvxOjgx5cCl8tY88HrD9yId5eKecuMNHvUF9XpVuTzm5OvY2BBmFIcnaN6SDVEnB/4yw3LpO6iPIdHI9XFzTaXDwjCx7Wt1+mlo4tYtVfP7pCEz7RMLyuZTJVLq42fwWWM1oLityUihT7DH1JwAxSrmxKuTZ668iqpfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731359508; c=relaxed/simple;
	bh=NLMZb4sPLhu7DhAP2XtUtSQV82QzeMptwhoTkj0X91w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGBoz1U9mrbkMje6OH1mirhDE4+6Puy90kOb2Sc4Xx7hFUA4PCafr1JA6Y853lOONQVDQI9NHHb549gBSxtdtdNtPXYSveyYDZotJ/b+++ru4US4DyHiR/4G1I3Df/pXHegqSJlXY4VeqmSdX/FCflzanjdOY1iocTg5GhTkwNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCj5aATx; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46098928354so37962041cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 13:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731359506; x=1731964306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOuGggVzA+8zaGETY+eOMb+uIgke6CbhFZrDQWG+q10=;
        b=BCj5aATxzezHdxmnxr8zu/Ypa8ZVZtRCs+wpQQsl9N8WJ6X5fDdb3HX8PK6VFniRoE
         uELuUyyN3ZHHSxEKIIaFdKNGR7NFFVoluLHZkDu0BxYoxXawDqsfutjgVIUtRvJ+ma6n
         LBsWTWOLEfkhy7mDIQXFID8ahRppIUVCEUxKF62FrLL/xcQadOF8Kxfhe7ttCQUCgrzW
         TqsK0b14riw8kRjgzlxt2Y782UTW02DQk1SEiH1KrLYYJ3AxpdD0M0EpCsJWV5ZvsErV
         BmGVbpWsiwFlVtSk/+54t1lyCd7Y1a3/t34Ad39ad3UrcgijcTSUWIWXcaYfQxrEsVFb
         riUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731359506; x=1731964306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOuGggVzA+8zaGETY+eOMb+uIgke6CbhFZrDQWG+q10=;
        b=IFKg8ifcdpIeR3NaqlBYH1cuJ9pJIzeM+XmAps7UyfGronAjDM8WobI5PXApO0K+wU
         jVuvKdzSTXccBTkxeioIIdNd/1vI83rNYNQtA/3SA9fj0CXRRRO23sOhxpCyDfEtLhen
         uolsjOUyLqKsZBoMvHgCPlt+Y12qZiW7zwfMt9RW/vYELPpihAxZliYIhkiZIqFoXbUy
         HkOCAWKo5gkfb2tfcMR3T2gMSz2BD5dwdBzibcHbdSt81tnW5JmQaJemFIOKCa4cGp/h
         4tbnBOUKKMsfM0ikU5okagZQszLgANghfUHki+7xESNPay12c4Fk8IjjLi71GYWViMSB
         eZPg==
X-Forwarded-Encrypted: i=1; AJvYcCWCIu5OcN6xkcssyJAwYnQcVzkC7lzzB7U1+y3LUC/icsFgFILKwTeyMosA+yycOkO70g0HIKIHePFkHan8@vger.kernel.org
X-Gm-Message-State: AOJu0YzAWG1mbuFeGqvuPcKe4OOuz2lD15Jn2oJMr1HRU2LkBuqwiI/P
	JoeB/5AX2iJKKkUlCAVH7qajWJfZXhHFRmUxAS5a38wQ7Fva6sR+8ao8KZb3K+/xYgUGKz2J24b
	+vQv5b6jwkm66VMHutuCZ3L9O+lw=
X-Google-Smtp-Source: AGHT+IGN9ZO/+N+r0n0P+Zj63FMITfOdmxQ/lqEoV5Fi5gl96VhVmitjdYWqxbhfMtAW0FfCDRlFyjDmoZ8Cbxt3Ixo=
X-Received: by 2002:a05:622a:1990:b0:458:4bf1:1f46 with SMTP id
 d75a77b69052e-4630942ad76mr235936441cf.53.1731359505782; Mon, 11 Nov 2024
 13:11:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
 <20241107235614.3637221-2-joannelkoong@gmail.com> <lbwgnktuip4jf5yqqgkgopddibulf5we6clmitt5mg3vff53zq@feyj77bk7pdt>
In-Reply-To: <lbwgnktuip4jf5yqqgkgopddibulf5we6clmitt5mg3vff53zq@feyj77bk7pdt>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 11 Nov 2024 13:11:35 -0800
Message-ID: <CAJnrk1ZOc3xwCk7bVTKBSAh7sf-_szoSW-brEVx8e09icYiDDQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] mm: add AS_WRITEBACK_MAY_BLOCK mapping flag
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 4:10=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Thu, Nov 07, 2024 at 03:56:09PM -0800, Joanne Koong wrote:
> > Add a new mapping flag AS_WRITEBACK_MAY_BLOCK which filesystems may set
> > to indicate that writeback operations may block or take an indeterminat=
e
> > amount of time to complete. Extra caution should be taken when waiting
> > on writeback for folios belonging to mappings where this flag is set.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/pagemap.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 68a5f1ff3301..eb5a7837e142 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -210,6 +210,7 @@ enum mapping_flags {
> >       AS_STABLE_WRITES =3D 7,   /* must wait for writeback before modif=
ying
> >                                  folio contents */
> >       AS_INACCESSIBLE =3D 8,    /* Do not attempt direct R/W access to =
the mapping */
> > +     AS_WRITEBACK_MAY_BLOCK =3D 9, /* Use caution when waiting on writ=
eback */
>
> To me 'may block' does not feel right. For example in reclaim code,
> folio_wait_writeback() can get blocked and that is fine. However with
> non-privileged fuse involved, there are security concerns. Somehow 'may
> block' does not convey that. Anyways, I am not really pushing back but
> I think there is a need for better name here.

Ahh I see where this naming causes confusion - the "MAY_BLOCK" part
could be interpreted in two ways: a) may block as in it's possible for
the writeback to block and b) may block as in it's permissible/ok for
the writeback to block. I intended "may block" to signify a) but
you're right, it could be easily interpreted as b).

I'll change this to AS_WRITEBACK_BLOCKING.

Thanks,
Joanne

>
> >       /* Bits 16-25 are used for FOLIO_ORDER */
> >       AS_FOLIO_ORDER_BITS =3D 5,
> >       AS_FOLIO_ORDER_MIN =3D 16,
> > @@ -335,6 +336,16 @@ static inline bool mapping_inaccessible(struct add=
ress_space *mapping)
> >       return test_bit(AS_INACCESSIBLE, &mapping->flags);
> >  }
> >
> > +static inline void mapping_set_writeback_may_block(struct address_spac=
e *mapping)
> > +{
> > +     set_bit(AS_WRITEBACK_MAY_BLOCK, &mapping->flags);
> > +}
> > +
> > +static inline bool mapping_writeback_may_block(struct address_space *m=
apping)
> > +{
> > +     return test_bit(AS_WRITEBACK_MAY_BLOCK, &mapping->flags);
> > +}
> > +
> >  static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
> >  {
> >       return mapping->gfp_mask;
> > --
> > 2.43.5
> >

