Return-Path: <linux-fsdevel+bounces-40935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143CFA29611
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 17:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEB53A5034
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7791ADC7C;
	Wed,  5 Feb 2025 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR9wfEqE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152F149C7B;
	Wed,  5 Feb 2025 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772459; cv=none; b=uj2/HYJeNIy+eaVExDg73v1DIecMs+mv67mqmq0wWjlKEOo57H75sxF+Bt3/6rBf9lqJI/JrzXyiAeRB8TMgy+Df9LjoqaCvAGPw1laTfl8bDxwrPJIQxBe4uPhWscgFNmlr1TXdJz5earBwa8A84znUmVThvbpT555CObSiYts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772459; c=relaxed/simple;
	bh=aP2BzWrYzqtOxKGsLnRIEWiahrH1IhK3A/dN52whdfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bovy9XltXfm8khbOE0q2hkJKKovIa7Zuob81teBNlzI6AGZ1p4m+tD3nrVYoIy4/liZvpZd8jvPSUV+txfO5bLIgqMww772N8bXLRDjAGAU0DN6w2hXgy9qVLfHe4tYCV656PZQ9yivciPvwg2K6XnQ5vDqnN7MnEH//AnBpHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RR9wfEqE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dce27a72e8so1173679a12.2;
        Wed, 05 Feb 2025 08:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738772456; x=1739377256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dsklJ3NdwvShMVLaf0HLzIYtGuGTs4uDvsBBrNHhL0=;
        b=RR9wfEqEyXvqm2SwpIRVBlClP/++4wzpuMJ1iXHA53o41yETxgYEX89zQI3Ttp18JH
         ybrMKQ13tIfy5Pw1IcrULJb+4TDPENPPUmocgWkVTSrW9o2jQiPI5BGM8gqIc7W0yl+s
         sArjqHLlFZgclT4VPVH9pVk4/UnuBGPR5oeS5/DzDdiGjyRU4q+9VsZ6fnZvfNRiX2gK
         dHwvlMSGg76rjl96XR3TOz6ozNxNDiMgAhOceSY3NmBCMJoAFGM4n83s0J/egqhfZBOH
         tnQBizdt2IbMmZgHwJzOdy0N+U/ywJFGekPe2DgnWj1dHskKHcyXG5b4Ij9tuX9Feo7V
         xGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738772456; x=1739377256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dsklJ3NdwvShMVLaf0HLzIYtGuGTs4uDvsBBrNHhL0=;
        b=OLbzLCChc7Xhg9UbVRQdK76zeS3EMk3DZKMh3NiiZkT3xuJi+pTo6z+zlULh7uLGJ/
         yV7fFjxEKPuUqNx9FD+7I8FWJHNw/TiF6SII91AVqnLKFK/oNUKE6b851X6OKS4Por7N
         2q1gfGce8vjgWymrXUGDevA/lljecRGMdzviv4/fxZ1esZ/eCw5Jo15NkzfeAeehsaQ0
         PySC5lHHQUMtUdVmCxzzyv7YQNjTHqPGots4CApE2niu7Sr/XvoX9Z+FMfqtOT2dkoNJ
         LXNoQQv04NjSGdUlwTBunHnS/5yYVaq7sY0oPEHcn39CTB3dp0QU+c1wY+KA5FCniX3H
         guKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCqdVOR3KVNKiorOnpmjv9DXbtVhivKMbKFlxXZjkBIrJ76X3QQWnzzva3U/9dg5CSDqBmPTonh4kXGyvs@vger.kernel.org, AJvYcCVNc7W68/A4wyhmQGcaxpzPayR+6OYqtEuJtOGSaXP3cu5iG8Izt5E9FEq2bL+XMViejAIxejyGmkTtTqqC@vger.kernel.org
X-Gm-Message-State: AOJu0YwDNk8NwaBwK6kL0+b/C0Ss9Y09C4EaAcTx+gDAQHl/3/GQ3O6+
	PXGZHZCTaX9nF9ppNjhnLV5Q4q/PS4xitn3dpgW0AQk500Wg7j2vo28D5L9yJ/a3EEyNqlO7Aeu
	uZTOzcvmE4qQl98TdUn/lv2b3B8s=
X-Gm-Gg: ASbGncvwYHmj2LHMUB0jWk3Xl8Cc6S/ijzonPpDL6QoaRWwApRBqa/X6FU/Da0BHCAW
	MrCoc3KeLXY47jQgRNAcFsTHO6p4O785UPSum8LHirw45lU1YwuT0z3P+Mi0k0Uj0JJ/KaKk=
X-Google-Smtp-Source: AGHT+IHg+2tc9SNm/MpbY8Mjia3MuZCcZPSalVG2ewveHhLFq4EtQZk0RvdLZy1VQRvsYt3h3NdCegkXV32tpo72Bcg=
X-Received: by 2002:a05:6402:280d:b0:5db:d9ac:b302 with SMTP id
 4fb4d7f45d1cf-5dcdb77fcb0mr4292768a12.32.1738772455362; Wed, 05 Feb 2025
 08:20:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204213207.337980-1-mjguzik@gmail.com> <zatx4ddmdvymae4454vrpci642gecbq4l6iuv4u64tssixeplc@h6rimv2lhicg>
In-Reply-To: <zatx4ddmdvymae4454vrpci642gecbq4l6iuv4u64tssixeplc@h6rimv2lhicg>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Feb 2025 17:20:43 +0100
X-Gm-Features: AWEUYZlGbG-o6X09GtoR8NsOMA1RTJpgO4SqC7ogM6ynpb-B7NOQV33ZZtjaDis
Message-ID: <CAGudoHHeHKo6+R86pZTFSzAFRf2v=bc5LOGvbHmC0mCfkjRvgw@mail.gmail.com>
Subject: Re: [PATCH] vfs: sanity check the length passed to inode_set_cached_link()
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 5:12=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 04-02-25 22:32:07, Mateusz Guzik wrote:
> > This costs a strlen() call when instatianating a symlink.
> >
> > Preferably it would be hidden behind VFS_WARN_ON (or compatible), but
> > there is no such facility at the moment. With the facility in place the
> > call can be patched out in production kernels.
> >
> > In the meantime, since the cost is being paid unconditionally, use the
> > result to a fixup the bad caller.
> >
> > This is not expected to persist in the long run (tm).
> >
> > Sample splat:
> > bad length passed for symlink [/tmp/syz-imagegen43743633/file0/file0] (=
got 131109, expected 37)
> > [rest of WARN blurp goes here]
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>
> Yeah, it looks a bit pointless to pass the length in only to compare it
> against strlen(). But as a quick fix until we figure out something more
> clever it's fine I guess.
>

There is some dayjob stuff I need to take care of.

Once I'm both out from under the ruble *and* bored enough, I'll post
provisional support for VFS_WARN_ON and VFS_BUG_ON macros.

But that's for -next.

> Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>                                                                 Honza
>
> > ---
> >
> > This has a side effect of working around the panic reported in:
> > https://lore.kernel.org/all/67a1e1f4.050a0220.163cdc.0063.GAE@google.co=
m/
> >
> > I'm confident this merely exposed a bug in ext4, see:
> > https://lore.kernel.org/all/CAGudoHEv+Diti3r0x9VmF5ixgRVKk4trYnX_skVJNk=
QoTMaDHg@mail.gmail.com/#t
> >
> > Nonethelss, should help catch future problems.
> >
> >  include/linux/fs.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index be3ad155ec9f..1437a3323731 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -791,6 +791,19 @@ struct inode {
> >
> >  static inline void inode_set_cached_link(struct inode *inode, char *li=
nk, int linklen)
> >  {
> > +     int testlen;
> > +
> > +     /*
> > +      * TODO: patch it into a debug-only check if relevant macros show=
 up.
> > +      * In the meantime, since we are suffering strlen even on product=
ion kernels
> > +      * to find the right length, do a fixup if the wrong value got pa=
ssed.
> > +      */
> > +     testlen =3D strlen(link);
> > +     if (testlen !=3D linklen) {
> > +             WARN_ONCE(1, "bad length passed for symlink [%s] (got %d,=
 expected %d)",
> > +                       link, linklen, testlen);
> > +             linklen =3D testlen;
> > +     }
> >       inode->i_link =3D link;
> >       inode->i_linklen =3D linklen;
> >       inode->i_opflags |=3D IOP_CACHED_LINK;
> > --
> > 2.43.0
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



--=20
Mateusz Guzik <mjguzik gmail.com>

