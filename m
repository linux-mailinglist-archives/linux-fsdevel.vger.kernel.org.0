Return-Path: <linux-fsdevel+bounces-44646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69699A6AFA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 22:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D018865AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 21:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F2022A4D1;
	Thu, 20 Mar 2025 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmG/yG+R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F32214228;
	Thu, 20 Mar 2025 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504950; cv=none; b=GrPM3bHqhLE3PwSGq+PWLbo73R6DmXyR5TejEVfrW1wBqhlPnB1jBQ4ZreCDZCZHB7yXt86+SS8Y1EDCkmAFmWVODRZMedgAkuf6FPaKW1a0TATWH1hw2nYW7SsyEREGA6uEkLGWIMap7QAJcWbvdxPWGcuD8vLDhF07xMovnoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504950; c=relaxed/simple;
	bh=PS6fFvcAl29nzssEdMgCy3wzRuOB3rUjwBjydmfFqC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPbe38zxKAsMApa48xQK2K7cHo41OVtuwVLxKg0gHVJNAwQ5sIsl76oKHG6Jn/3N/Pmx5cmpo+lpVg7IFcX66gxwSOGYNk7tlAZupP0wSAl9funu1RGzORpKzFX0Iy/xxk9a7md684oqofARMUFNT/NmVjOHXklm5x0e1lenktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmG/yG+R; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4766cb762b6so12236161cf.0;
        Thu, 20 Mar 2025 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742504947; x=1743109747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2MJ72UEvg61Oantat2YobsO8uU55tvuh/BJhVCEG2g=;
        b=CmG/yG+RcLAws1AHN9juOQ6avk5F27ZlgxqygDmYXZzsW7826RCLwSE8eeiBi/43Hd
         2HiRtroKoq0kl2jr6u2N8hKKmhenOb6ePTQ//5O2UO80EH5qrYmt09bEdYFR3IPsiQ7P
         8op1ZOvgzua3Ae7DfgPArtPo3M8+h+QAybDGQ5pm4/ArO2ivj+zEPaNrxvxD98vnOZjo
         cFptMxxgVvbuj6popt9TjoIFAY+1IZFIG2SO+kt78jKSpx0aiL2QHNrQ3P3AAOw+hkSE
         TdAqkogZv51kdnxtfRfSZsu0wheY0B5qWWBnnhiZCzmLteAI43wa3Gl8W85EBAVSmoR5
         GXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742504947; x=1743109747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2MJ72UEvg61Oantat2YobsO8uU55tvuh/BJhVCEG2g=;
        b=LYT3N9oM+CDWUbV4ZAWDLT2OAwjFy7Z1xM0th4vSEAypQCEbkE5hCEb2DVq9FXa6so
         hUCOl3bRHVgR1vynJ7DC9136pFZl3cC7UkqHx4q0XAPBVYMzPIzri6j1R3+CCGkiyrIp
         1zyl5BnibypdYDPJUUQmB4MeC+c+muI8NWSRbWhsO/sWNV/rcktoN+Saq768heWl+NAC
         Gm38EsgFsjsmESMy3echx7aDIx2RZRhnveR+e/6xzAMwkzOI0DHC3HKCfWqJXDN6IgO5
         6/g6ePzu8WcLsGlFFXHOboNkD7XcnlI4FtxyEDCKRK7nnGlANoCqfstKDLid9KKu26NG
         tSLg==
X-Forwarded-Encrypted: i=1; AJvYcCWnoCOTw30eJkTcf00E32oKLQ8T0TuXE6O2jcoe5SJYK/e1DI7l8Hsxlo9eA7+IgeaLIKDRMQwe6GIbHt++Og==@vger.kernel.org, AJvYcCXsVdRzKw6/GxpVM+QBLYkA+zrwJFyQ9KBPeTDxy4bVEfOmOoSbE4f//+cv73WUDNfB2WKXsmeTG0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7O47xMiPujBTIufxgCDyp9+spw3KPHhBqz4uNX2SrPPhw5xCF
	VGIFZsQy/Grl6l0PxCdAkQC9slS4tcK4WHIu4t23LzlZLtuZH33ZOnUjZtsa2XKGxKJSBopnHQI
	0TWrcg6SshtyCA73hGfn6GfX2f4w=
X-Gm-Gg: ASbGncvf/+LA/YDXt51yKEY886S+hb/zo7LkG1nuHCkbimJwYvT5dkHUqMt47IWvRoB
	zRJqLI98d5why754GywLaSWsHVo06zSNuv3c0QF/r10JWivDAKaey+nEM9oAn5YqFVjsCd813vy
	omtsxOTgNuWVnlLlUAbd6mhEprizvBb4buxyx6jg==
X-Google-Smtp-Source: AGHT+IF6iA5nRUBc4UG6ruLMgy4gGU7nnBGrJJk930IKNV6pq4WFjyglm5x5lzrx0yq8iMLu7h0ZqRtKx+mJiAsah3o=
X-Received: by 2002:a05:622a:4109:b0:477:bd4:6a4c with SMTP id
 d75a77b69052e-4771d90c07amr13585791cf.1.1742504947293; Thu, 20 Mar 2025
 14:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224152535.42380-1-john@groves.net> <CAJnrk1bJ5jE5qWdRju6xz+DipYHUrj8w4PdL80J1M6ujMxXJ1g@mail.gmail.com>
 <eqcigeptla4obqqaix737tfqmkjdet3fzmq2kqttm5etab2us5@vqignnrha2m5>
In-Reply-To: <eqcigeptla4obqqaix737tfqmkjdet3fzmq2kqttm5etab2us5@vqignnrha2m5>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 20 Mar 2025 14:08:56 -0700
X-Gm-Features: AQ5f1Jo7yxYjSPZp8L2xj1R42EDQFygEwZrpHIYzzhMLiKSbgKM9qNX-e_2D2lI
Message-ID: <CAJnrk1a1dU0r-ztPHUHzzixKDV8=sN9-_pqZaPZwhevXW0SQ2w@mail.gmail.com>
Subject: Re: famfs port to fuse - questions
To: John Groves <John@groves.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, John Groves <jgroves@micron.com>, linux-fsdevel@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, Eishan Mirakhur <emirakhur@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 6:06=E2=80=AFAM John Groves <John@groves.net> wrote=
:
>
> On 25/02/24 03:40PM, Joanne Koong wrote:
> > On Mon, Feb 24, 2025 at 7:25=E2=80=AFAM John Groves <John@groves.net> w=
rote:
> > >
> > > Miklos et. al.:
> > >
> > > Here are some specific questions related to the famfs port into fuse =
[1][2]
> > > that I hope Miklos (and others) can give me feedback on soonish.
> > >
> > > This work is active and serious, although you haven't heard much from=
 me
> > > recently. I'm showing a famfs poster at Usenix FAST '25 this week [3]=
.
> > >
> > > I'm generally following the approach in [1] - in a famfs file system,
> > > LOOKUP is followed by GET_FMAP to retrieve the famfs file/dax metadat=
a.
> > > It's tempting to merge the fmap into the LOOKUP reply, but this seems=
 like
> > > an optimization to consider once basic function is established.
> > >
> > > Q: Do you think it makes sense to make the famfs fmap an optional,
> > >    variable sized addition to the LOOKUP response?
> > >
> > > Whenever an fmap references a dax device that isn't already known to =
the
> > > famfs/fuse kernel code, a GET_DAXDEV message is sent, with the reply
> > > providing the info required to open teh daxdev. A file becomes availa=
ble
> > > when the fmap is complete and all referenced daxdevs are "opened".
> > >
> > > Q: Any heartburn here?
> > >
> > > When GET_FMAP is separate from LOOKUP, READDIRPLUS won't add value un=
less it
> > > receives fmaps as part of the attributes (i.e. lookups) that come bac=
k in
> > > its response - since a READDIRPLUS that gets 12 files will still need=
 12
> > > GET_FMAP messages/responses to be complete. Merging fmaps as optional=
,
> > > variable-length components of the READDIRPLUS response buffers could
> > > eventualy make sense, but a cleaner solution intially would seem to b=
e
> > > to disable READDIRPLUS in famfs. But...
> > >
> >
> > Hi John,
> >
> > > * The libfuse/kernel ABI appears to allow low-level fuse servers that=
 don't
> > >   support READDIRPLUS...
> > > * But libfuse doesn't look at conn->want for the READDIRPLUS related
> > >   capabilities
> > > * I have overridden that, but the kernel still sends the READDIRPLUS
> > >   messages. It's possible I'm doing something hinky, and I'll keep lo=
oking
> > >   for it.
> >
> > On the kernel side, FUSE_READDIR / FUSE_READDIRPLUS requests are sent
> > in fuse_readdir_uncached(). I don't see anything there that skips
> > sending readdir / readdirplus requests if the server doesn't have
> > .readdir / .readdirplus implemented. For some request types (eg
> > FUSE_RENAME2, FUSE_LINK, FUSE_FSYNCDIR, FUSE_CREATE, ...), we do track
> > if a request type isn't implemented by the server and then skip
> > sending that request in the future (for example, see fuse_tmpfile()).
> > If we wanted to do this skipping for readdir as well, it'd probably
> > look something like
> >
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -870,6 +870,9 @@ struct fuse_conn {
> >         /* Is link not implemented by fs? */
> >         unsigned int no_link:1;
> >
> > +       /* Is readdir/readdirplus not implemented by fs? */
> > +       unsigned int no_readdir:1;
> > +
> >         /* Use io_uring for communication */
> >         unsigned int io_uring;
> >
> > diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> > index 17ce9636a2b1..176d6ce953e5 100644
> > --- a/fs/fuse/readdir.c
> > +++ b/fs/fuse/readdir.c
> > @@ -341,6 +341,9 @@ static int fuse_readdir_uncached(struct file
> > *file, struct dir_context *ctx)
> >         u64 attr_version =3D 0, evict_ctr =3D 0;
> >         bool locked;
> >
> > +       if (fm->fc->no_readdir)
> > +               return -ENOSYS;
> > +
> >         folio =3D folio_alloc(GFP_KERNEL, 0);
> >         if (!folio)
> >                 return -ENOMEM;
> > @@ -376,6 +379,8 @@ static int fuse_readdir_uncached(struct file
> > *file, struct dir_context *ctx)
> >                         res =3D parse_dirfile(folio_address(folio), res=
, file,
> >                                             ctx);
> >                 }
> > +       } else if (res =3D=3D -ENOSYS) {
> > +               fm->fc->no_readdir =3D 1;
> >         }
> >
> >         folio_put(folio);
> >
> > > * When I just return -ENOSYS to READDIRPLUS, things don't work well. =
Still
> > >   looking into this.
> > >
> > > Q: Do you know whether the current fuse kernel mod can handle a low-l=
evel
> > >    fuse server that doesn't support READDIRPLUS? This may be broken.
> >
> > From what I see, the fuse kernel code can handle servers that don't
> > support readdir/readdirplus. The fuse readdir path gets invoked from
> > file_operations->iterate_shared callback, which from what i see, the
> > only ramification of this always returning an error is that the
> > syscalls calling into this (eg getdents(), readdir()) fail.
>
> Thanks for doing some of the digging Joanne. I'm not sure what was going =
wrong
> a few weeks ago when I initially disabled readdirplus, but I have it work=
ing
> now - in fact I now have famfs "fully" working under fuse (for some defin=
ition
> of fully ;).
>
> I have a gnarly rebase plus some documentation to write, but I may go ahe=
ad
> and share branches this week, in case anybody wants to take a look. That =
will
> be a fuse kernel branch, and a famfs user space branch...
>

Looking forward to seeing this.

> Also: any plans for a fuse BOF at LSFMM?

I'm definitely interested if there is one. There was some discussion
about this on this thread [1] a few months ago - Miklos said he won't
be able to make it to LSF this year and I think Bernd said he won't be
able to as well, but if there are some other interested FUSE people at
LSF, maybe we could have a fuse meetup that would be video-callable
in?

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/43474a67d1af7ec03e2fade9e83c7702b=
74fe66b.camel@kernel.org/T/#ma4968312a21f8bd0da3431d818c1b5bff75aefcc

>
> <snip>
>
> Thanks,
> John
>

