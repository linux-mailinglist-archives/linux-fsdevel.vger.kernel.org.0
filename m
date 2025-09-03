Return-Path: <linux-fsdevel+bounces-60190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7302CB428B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE7E1BA12E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 18:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B853629A7;
	Wed,  3 Sep 2025 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHPkXy9f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDFE1624C0;
	Wed,  3 Sep 2025 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924280; cv=none; b=YdjaA5BYLJ5jj6NJ10JMmZw6/h8MBKHR2enq6G1NF6uJK5WeCrEYnom69TqZO4FVlAb71C4BBPQnrloVgAyI57XAFKzbsfiI61O9mzd8lYRaB+O5ORuvrl/mZq1iLEsqcavRGXxveA8aF79RfheaW4pncyMkrXHX9dTEAJieu7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924280; c=relaxed/simple;
	bh=Oebq/suGCC5fmC4qcEo+dhhN9f9dKTJa8nVy/6KezsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sc4rH86mlE8Aqg2eJSF3nHLkajE5Kiuum0JEhpbsl6t8IWBYpNjRT99t2IHaEPUkQ8mqNsfYgnMWEpnmLnErezNnBB+kdynSNVgUnc6u0NU8J7SDI14vU8TYk89cNRMruWnrN4+JT+mEAGx7Xq+DN6I0KNTAG++hu1f3KUPGA9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHPkXy9f; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-805a1931a15so25683585a.1;
        Wed, 03 Sep 2025 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756924278; x=1757529078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qSvo2uZgovlgx0FfJJeK9qSwaaMzcgiCqTuZCwC6B4=;
        b=lHPkXy9f09j30m4+RuGsYhZzPUR3o+0o6I1E6/gXFvkO7cUqyLXY+kHMPke0U/uHaa
         WbiQznWEaDEuDswWZc+JjTDiykBDsUP3cPH0T+LUIHY+TCgl4plf5B+qcO7IyclsNjUY
         hOciFJLg3tMuio1USX2GC5jZN8TLXHbUKHpMwYsLXl2wvbMMljx9DOGueowMUb+ObRL6
         X8QKxOl1gs4tuC+AWfFp1Ru+E5JatnTxCA9cAnDAgZJ3X86FSKB9FLTpzrQTF17bo7V5
         Rsj9DKG3nMLdypUUg5NfvIu99QjOS+Y5sruCMXyQgZIAESOi7NcsKz4ZwNC4Au6netxN
         tUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756924278; x=1757529078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qSvo2uZgovlgx0FfJJeK9qSwaaMzcgiCqTuZCwC6B4=;
        b=BNeVwvUbAB3fcQQklUMaEVYSemzTZK6Os9/RibfbZDcFmRj2udPbZIQkSQ+f15Gl6f
         eftDHaWrpitRP82vdpAnL6uUA2Ku5uvBiaUhJkvr9jtpBw3lm28EzdywhUGCvwLSEPeH
         94ckRBkF139SUd5ZHdJ2+eehlj7M7NutlJwhv8STHxXRu6+QPmIT7DJ9jRoudiITbuiw
         Svfd3gxP/4YFEedwKVxZxVrsCtH27oHTxlRIRA20FO4xz7s1x9t3vajOAZYhP4cWm8G9
         Y6UYjq8YJSQB8FS9rjKbz98OZUKKRJPwUMxA0pjUvRbQMa9VlpUjAvrqhOm74ZIDsoey
         mwFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWzGoCBvxJ+D2uLT6jD159SMJFMn6zPtfVYX3a/NpP7oT89jejj4XixzstAtWCGW6Nc53uo65RanMy@vger.kernel.org, AJvYcCXE9DgjnbyFOQj3MFXeAQ5jLpOMP2tTPvGXQ08UpOA42z95g5eI2sq0t7HFToOR4O6c72BTjV13kkaj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy83Ps/HhNG4GSYxpJN9FeXE8ROKdbTdlHseVEhfwkqw5dluYvQ
	1WZEkE+/0vSBWAypmM5jym9Ben+MRCyKCQpLFx8UJyRr6HTljQecpYGKTFlrCg4x5E6/gcj8Bb1
	BJleoIJ6ESqie/UgCHkwQJv9yAB3FKs0=
X-Gm-Gg: ASbGnctawBngBpM9EmoRpV0dBO/m3Jcq49lzn2O+qoVfGQIBiToTbNOUs08YFtnr5eI
	LVgwniI2XLauNEW3ViKLpxhxQxFJSWlEMbCPjf1+7OLmyvVKQYmv4WLsclT6aqRCjQYJJxMGgHL
	lfgQjLn/5OanLjvfDbBPFTdqv3wuQFGA0fT5sycVJbBcHRAWq2gycFNus3pWzPpqI3kfXnsk6aE
	shC2FjVK3h7zpPkbCc=
X-Google-Smtp-Source: AGHT+IE3XOodSa4+Yym/aMpYxbb8gIvknV1OOwtdLdTWe73FoscR9Bhnt7It4WMH/rYILUqX6BpVE5Zi5HZv3XGlSPc=
X-Received: by 2002:a05:620a:178b:b0:7de:fa4b:773f with SMTP id
 af79cd13be357-7ff26eaad4dmr1984699485a.17.1756924277350; Wed, 03 Sep 2025
 11:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902150755.289469-1-bfoster@redhat.com> <20250902150755.289469-3-bfoster@redhat.com>
 <CAJnrk1bmjCB=8o-YOkPScftoXMrgpBKU3vtkMOViEfFQ9LXLfg@mail.gmail.com> <aLgyELz3TH_TCZRw@bfoster>
In-Reply-To: <aLgyELz3TH_TCZRw@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 3 Sep 2025 11:31:05 -0700
X-Gm-Features: Ac12FXzXhB4BODApWtar5e62UMm9uHMNorJoBb-ra_x0jxdFtiu9ViWdjWqt9nU
Message-ID: <CAJnrk1bwDun7EtQJsvMYi_0ODcduRLGaT+sJdXhzjNP3+Ynbeg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] iomap: revert the iomap_iter pos on ->iomap_end() error
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jack@suse.cz, djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 5:14=E2=80=AFAM Brian Foster <bfoster@redhat.com> wr=
ote:
>
> On Tue, Sep 02, 2025 at 02:11:35PM -0700, Joanne Koong wrote:
> > On Tue, Sep 2, 2025 at 8:04=E2=80=AFAM Brian Foster <bfoster@redhat.com=
> wrote:
> > >
> > > An iomap op iteration should not be considered successful if
> > > ->iomap_end() fails. Most ->iomap_end() callbacks do not return
> > > errors, and for those that do we return the error to the caller, but
> > > this is still not sufficient in some corner cases.
> > >
> > > For example, if a DAX write to a shared iomap fails at ->iomap_end()
> > > on XFS, this means the remap of shared blocks from the COW fork to
> > > the data fork has possibly failed. In turn this means that just
> > > written data may not be accessible in the file. dax_iomap_rw()
> > > returns partial success over a returned error code and the operation
> > > has already advanced iter.pos by the time ->iomap_end() is called.
> > > This means that dax_iomap_rw() can return more bytes processed than
> > > have been completed successfully, including partial success instead
> > > of an error code if the first iteration happens to fail.
> > >
> > > To address this problem, first tweak the ->iomap_end() error
> > > handling logic to run regardless of whether the current iteration
> > > advanced the iter. Next, revert pos in the error handling path. Add
> > > a new helper to undo the changes from iomap_iter_advance(). It is
> > > static to start since the only initial user is in iomap_iter.c.
> > >
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > >  fs/iomap/iter.c | 20 +++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> > > index 7cc4599b9c9b..69c993fe51fa 100644
> > > --- a/fs/iomap/iter.c
> > > +++ b/fs/iomap/iter.c
> > > @@ -27,6 +27,22 @@ int iomap_iter_advance(struct iomap_iter *iter, u6=
4 *count)
> > >         return 0;
> > >  }
> > >
> > > +/**
> > > + * iomap_iter_revert - revert the iterator position
> > > + * @iter: iteration structure
> > > + * @count: number of bytes to revert
> > > + *
> > > + * Revert the iterator position by the specified number of bytes, un=
doing
> > > + * the effect of a previous iomap_iter_advance() call. The count mus=
t not
> > > + * exceed the amount previously advanced in the current iter.
> > > + */
> > > +static void iomap_iter_revert(struct iomap_iter *iter, u64 count)
> > > +{
> > > +       count =3D min_t(u64, iter->pos - iter->iter_start_pos, count)=
;
> > > +       iter->pos -=3D count;
> > > +       iter->len +=3D count;
> > > +}
> > > +
> > >  static inline void iomap_iter_done(struct iomap_iter *iter)
> > >  {
> > >         WARN_ON_ONCE(iter->iomap.offset > iter->pos);
> > > @@ -80,8 +96,10 @@ int iomap_iter(struct iomap_iter *iter, const stru=
ct iomap_ops *ops)
> > >                                 iomap_length_trim(iter, iter->iter_st=
art_pos,
> > >                                                   olen),
> > >                                 advanced, iter->flags, &iter->iomap);
> > > -               if (ret < 0 && !advanced && !iter->status)
> > > +               if (ret < 0 && !iter->status) {
> > > +                       iomap_iter_revert(iter, advanced);
> > >                         return ret;
> > > +               }
> >
> > Should iomap_iter_revert() also be called in the "if (iter->status <
> > 0)" case a few lines below? I think otherwise, that leads to the same
> > problem in dax_iomap_rw() you pointed out in the commit message.
> >
>
> My thinking was that I wanted to try for the invariant that the
> operation/iteration is responsible to set the iter appropriately in the
> event that it returns an error in iter.status. I.e., either not advance
> or revert if appropriate.
>
> This is more consistent with how the iter is advanced and I suspect will
> help prevent potential whack a mole issues with inconsistent
> expectations for error handling at the iomap_iter() level. I actually
> had iomap_iter_revert() non-static originally, but changed it since I
> didn't spot anywhere it needed to be called as of yet. I could have
> certainly missed something though. Did you have a particular sequence in
> mind, or were just thinking in general?

Thanks for explaining your thought process. That reasoning makes sense to m=
e.

Originally I thought the dax_iomap_rw() sequence needed a
iomap_iter_revert() but looking at it again, I'm realizing now that
that function is intended to return successfully even if the writes in
further iterations fail.

Thanks,
Joanne

>
> FWIW, I suspect there's a reasonable argument for doing the same for
> ->iomap_end() and make the callback responsible for reverting if
> necessary. I went the way in this patch just because it seemed more
> simple given the limited scope, but that may not always be the case
> and/or may just be cleaner. I can take a closer look at that if there
> are stronger opinions..? Thanks for the feedback.
> > > returns partial success over a returned error code and the operation
> > > has already advanced iter.pos by the time ->iomap_end() is called.
> > > This means that dax_iomap_rw() can return more bytes processed than
> > > have been completed successfully, including partial success instead
> > > of an error code if the first iteration happens to fail.
>
> Brian
>
> > Thanks,
> > Joanne
> > >         }
> > >
> > >         /* detect old return semantics where this would advance */
> > > --
> > > 2.51.0
> > >
> > >
> >
>

