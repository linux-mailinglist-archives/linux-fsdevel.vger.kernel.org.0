Return-Path: <linux-fsdevel+bounces-8398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3810835CCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 09:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618661F22E48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 08:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5176C22092;
	Mon, 22 Jan 2024 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbXOj8Vr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C639843;
	Mon, 22 Jan 2024 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912695; cv=none; b=JPMQ/Ca+n9QQz9CZVO+zP3q3vEneUmN0sCINJboy/OkKlVoM4bJS8wnSM7eJUvxFP8akxiSOcQr3UY6I8YQArT/Q+Z7GMnOykOD2M4QOa2yWWLflbxnr+XzLOw8cgq+4+go0Or7VKqrUm6ckj+fsSAkcFTl+4Ojz8UGFIF21c8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912695; c=relaxed/simple;
	bh=xxSWNMBN0ZR751Z7G6tfKZnRRQoV/sVm3qfNAVT2cOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wy4jgGygrsHhgaTBUe+IGB0dw8uZXnRPA8/4rAyquBEJnuRQa3lJDXV84dDqM2GNmaaZD3XKDiEFk6BOtqkdn+orkJD8UEwlxbhgcr7Jvo85yyhD1I3pQdeeJxMidBCPkHw2LCMUm3PcwzOP6TgvsdSS5d+GNreCAbojTzLqEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbXOj8Vr; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78329cb6742so194498285a.0;
        Mon, 22 Jan 2024 00:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705912693; x=1706517493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYslVcdkxN8a4Q7ghB4ymZ6NUOCDG3LuVvw8IjLgvsU=;
        b=EbXOj8Vr76eNyGUeQ3Maw+nGJsvmWaLdlJR44SC6Xz7aDvkz1wpTUudyOgqjsrpgOe
         CT/PBnaA0+doV3WnVxczmMa4y0SPvYS8gmID2DPpJpbisi9L0H2zZ3m8QfA/5hKVNXlw
         t94UJUqdUi03/3jxgiKXtIMoQMHgc1w8dC1pE5GTBAYxwU/9KUcl2cQQcR7cLbAK6gIc
         MsWr46g4CQ2CDHeuyxz5h0vjLMFR4wEViXKuUfW9mlHSfecG24KuNqXIZdGtemc22j6c
         7wF60zKbZyy2yBe/ZE8wwHBJ5YsCFOQWZYLT6J7g+QBMgXMBvV//7WvB+y9FmnkTXg+M
         ZCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912693; x=1706517493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYslVcdkxN8a4Q7ghB4ymZ6NUOCDG3LuVvw8IjLgvsU=;
        b=tTm+OL7oUc0y3bT88Uz4uZwpkHDEkazZV/RCv4nEVFj5gF2+g4iIts7ncQqmt3gj9b
         H2EsaFZAKFO/yt7nB86daDsNHbmbDUQJlM6+rU9dHq4MiHfRAXierai1GpYmNnxwgU42
         qq0cTad775inOoGfUbf6KZRMbmrZbx9TUrE1wH/ZkbSimCKnxo1uZIR64xBC9S2LZd2b
         J2wnx81vf9psp1f3MdQQvbL1eqMT8y+6CzXPV6Y6IdjIfJCBaeUHt6jmDieOrnvGs2RM
         gv4kVh7oJTQvH4BjYqM75Slcb+CTW7oqjKadlMSZfMAfD8VGaiF+FOaFUQ4rYGJa7blb
         7Nkw==
X-Gm-Message-State: AOJu0Yy0mBHRfXqGqx/WlOwe4LBx9BTGfsdqFRH4JFxN8HpFutXBeqCq
	5wZP9KWNMU0lOUeYmBf3E6igXFHcAHLkQPfYqjN3zLxwXIKNrU+ufM6SxpTJL28SaK/boMhz/No
	HrnqJ3kHI0GpBRQ85L/9r8+Ut0Q4=
X-Google-Smtp-Source: AGHT+IG43zNnKxodwV2s4LGG55IGBHYkOXghKaHxhJj2hriU35RlEVPl/GMDuXaNuWmy15NfFQfUNOgS3802HwoARoA=
X-Received: by 2002:a0c:e312:0:b0:680:fb20:202f with SMTP id
 s18-20020a0ce312000000b00680fb20202fmr3046897qvl.127.1705912693195; Mon, 22
 Jan 2024 00:38:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119101454.532809-1-mszeredi@redhat.com> <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
 <5ee3a210f8f4fc89cb750b3d1a378a0ff0187c9f.camel@redhat.com>
In-Reply-To: <5ee3a210f8f4fc89cb750b3d1a378a0ff0187c9f.camel@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 22 Jan 2024 10:38:01 +0200
Message-ID: <CAOQ4uxj_EWqa716+9xxu0zEd-ziEFpoGsv2OggUrb8_eGGkDDw@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: require xwhiteout feature flag on layer roots
To: Alexander Larsson <alexl@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 6:35=E2=80=AFPM Alexander Larsson <alexl@redhat.com=
> wrote:
>
> On Fri, 2024-01-19 at 13:08 +0200, Amir Goldstein wrote:
> > On Fri, Jan 19, 2024 at 12:14=E2=80=AFPM Miklos Szeredi <mszeredi@redha=
t.com>
> > wrote:
> >
> >
> > Do you want me to fix/test and send this to Linus?
> >
> > Alex, can we add your RVB to v2?
>
> I ran into an issue converting composefs to use this.
>
> Suppose we have a chroot of files containing some upper dirs and we
> want to make a composefs of this. For example, say
> /foo/lower/dir/whiteout is a traditional whiteout.
>
> Previously, what happened is that I marked the whiteout file with
> trusted.overlay.overlay.whiteout, and the /foo/lower/dir with
> trusted.overlay.overlay.whiteouts.
>
> Them when I mounted then entire chroot with overlayfs these xattrs
> would get unescaped and I would get a $mnt/foo/lower/dir/whiteout with
> a trusted.overlay.whiteout xattr, and a $mnt/foo/lower/dir with a
> trusted.overlay.whiteout. When I then mounted another overlayfs with a
> lowerdir of $mnt/foo/lower it would treat the whiteout as a xwhiteout.
>
> However, now I need the lowerdir toplevel dir to also have a
> trusted.overlay.whiteouts xattr. But when I'm converting the entire
> chroot I do not know which of the directories is going to be used as
> the toplevel lower dir, so I don't know where to put this marker.
>
> The only solution I see is to put it on *all* parent directories. Is
> there a better approach here?
>

Alex,

As you can see, I posted v3 with an alternative approach that would not
require marking all possible lower layer roots.

However, I cannot help wondering if it wouldn't be better practice, when
composing layers, to always be explicit, per-directory about whether the
composed directory is a "base" or a "diff" layer.

Isn't this information always known at composing time?

In legacy overlayfs, there is an explicit mark for "this is a base dir" -
namely, the opaque xattr, but there is no such explicit mark on
directories without an entry with the same name in layers below them.

The lack of explicit mark "merge" vs. "opaque" in all directories in all
the layers had led to problems in the past, for example, this is the
reason that this fix was needed:

  b79e05aaa166 ovl: no direct iteration for dir with origin xattr

In conclusion, since composefs is the first tool, that I know of, to
compose "non-legacy" overlayfs layers (i.e. with overlay xattrs),
I think the correct design decision would mark every directory in
every layer explicitly as at exactly one of "merge"/"opaque".

Note that non-dir are always marked explicitly as "metacopy",
so there is no ambiguity with non-dirs and we also error out
if a non-dir stack does not end with an "opaque" entry.

Additionally, when composing layers, since all the children of
a directory should be explicitly marked as "merge" vs. "opaque"
then the parent's "impure" (meaning contains "merge" children)
can also be set at composing time.

Failing to set "impure" correctly when composing layers could
result in wrong readdir d_ino results.

My proposition in v3 for an explicit mark was to
"reinterpret the opaque xattr from boolean to enum".
My proposal included only the states 'y' (opaque) and 'x' (contains
xwhiteouts), but for composefs, I would extend this to also mark
a merge dir explicitly with opaque=3D'n' and explicitly mark all the
directories in a "base layer" with opaque=3D'y'.

Implementation-wise, composefs could start by marking each directory
with either 'y'/'n' state based on the lowerstack, and if xwhiteout entries
are added, 'n' state could be changed to 'x' state.

What do you think?

Does it make sense from composefs POV?
Am I correct to assume that at composing time, every directory
state is known (base 'y' vs. diff 'n')?

Thanks,
Amir.

