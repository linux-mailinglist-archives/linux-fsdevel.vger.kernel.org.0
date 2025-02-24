Return-Path: <linux-fsdevel+bounces-42544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50226A4310F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 00:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC8F16B733
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 23:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ADC20C008;
	Mon, 24 Feb 2025 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auF9L8i6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260CB2571AD;
	Mon, 24 Feb 2025 23:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440469; cv=none; b=pEh8nLWRrMvgSzQpZX5KR+Se/9Yh5E7EIQC2KahXzBw65wo17pig3OEaI1lYTC1EX2ffZgYsCsaUfZ5ZSpg2zXiUZ9iodytg52qgHWdBCtmVsQ2Yz/E1eU0iSEA5IizHKOQtCvZDkR/CpAqC3UCJOLjnOmyLNJjsq6KDhLxV+Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440469; c=relaxed/simple;
	bh=HuwPjSd+Ieq420aTOaET9+4Zo8XlqBvhJjzTKzAEEIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gdq8LjhlNAxYqVHNaAmRrgr+d54TChnvqalaoOz9rdmSJ5N2wp9D1T9/RnYwJFAYovGDCrl/6NkzIELqGsJerIsUGIwkGz/GhADp/DTocR7AHAVwlWMlgwaXcM25jGFf1/gLKMDEtcNkQ7nXzDPD4oX3yX9DYC3xvSFoTGoEbuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auF9L8i6; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46fd4bf03cbso80165851cf.0;
        Mon, 24 Feb 2025 15:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740440467; x=1741045267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyC9yWt0ihuJwz9KECLNyHPrySoIePQO8WmxTvAC7oo=;
        b=auF9L8i6mTz/js6qMByaTK0dVfe3yfDK+HAp2ukes/WBRL29AFdmMygnQFxzAUiiv5
         /jOZ77eq//Ff3tOfPbF1bVtBpVVEXtuvGFuHFfpY4OsmIi8qSw9WJ80imbs0j+R34Mtv
         3FPDJGCZFIlVltrr6bCRW0Zxn6SVw7F/4KfGC7tucbfSuu1hQhivGpAHyztTC0HxEgyf
         q/e0+ACosFZXvgRpZCOGS15J9X5Cmm7bp3+zwLckZQdsCZJuBuYRvZc6hTLEVziirCx3
         R37X7owUGMj8Sp7Uiap8lUfHF20GgcaE9v446SmlU39/+oPj3HldytvoLMXn9CPPpRwh
         lTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740440467; x=1741045267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyC9yWt0ihuJwz9KECLNyHPrySoIePQO8WmxTvAC7oo=;
        b=OVeNjAq5gDci7g8ephWjwWO85Fryku9z8Dedva2iTWi5qk4/gH6ZPz4Iu9dqkRwucp
         tjSlBzkcUEUxULscOP2rtGU8lFdQlVjYQ84els6hChzklDSYj/FNaZZriBvKLSnAA5JQ
         pjRW1WY80OMDQrIcU89OpSq878WLvXQ1wAyIf98NAGT3ktqY/8Cf283Ldx8rVf8vPYIo
         Xo2Qi4h3zHHU1b8OzuzLl2SvYac0Ywc/RJ6JQq1JmxGM/HSiApytXue3Ly59h+rWu9sW
         ogcDwFco9ZBlSk+x6aV/qoXaaADLFrMl4t6R8iPwKYEx6FmLIIS+aBxtCNWas1LnzmlG
         34kw==
X-Forwarded-Encrypted: i=1; AJvYcCVOx8K6Z1XKlu6KQqNvskDuSWclnuWY0wWer2+hSlHRauSDqB32xo9yUFu63Ykm3D+dglo0zQcwnv0z2ZLe8A==@vger.kernel.org, AJvYcCWNaYgqutlLFhIa4dTLPn/z8G++J3Fiuzr/uNoZ0GXgmiaWTbrjZTdpSkE7PWZdL0U3n7eT/rZNPk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt6hLfBAjJbfpwTfCf91BR9sa+w9kFpmMYQqO9bGdpF2AEKK92
	uucZnPGuDoC0CH3JDjpo2oulR9wF+ajCsQuzIEVr4agrykM7hKZQt90O+BDDaZbMIsMU7przWdq
	CHoeIo+SiJybOpGJATv3JtuxCYiw=
X-Gm-Gg: ASbGncu56cYn4etA8KMZvsHgcFV2a7Us+YbrAwHij4x90bIcBeuNPDkGtOj+TPcbXIB
	11bDniXRKXlyXT9PUuPc6nS9UModDtjSwKs4Vm8jNHRpM8u+gLp4muNmsFwuBgUveTQndN1URYI
	2Swy5vuyia
X-Google-Smtp-Source: AGHT+IEos+Te3LWAJ6vPcdvAntGUnPzNwwKMe1HnRxzFBeYkq54gslMy1TycuqYBfPz1yhq3Ksv4VBS2buWCI3XlaoY=
X-Received: by 2002:ac8:7d8a:0:b0:472:116f:94ec with SMTP id
 d75a77b69052e-4737725cda1mr19583941cf.32.1740440466849; Mon, 24 Feb 2025
 15:41:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224152535.42380-1-john@groves.net>
In-Reply-To: <20250224152535.42380-1-john@groves.net>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 24 Feb 2025 15:40:55 -0800
X-Gm-Features: AWEUYZnQfkFnxoExaZjo3T7N6gKii1d37AJEki2fWBvtbmPjhXc_57Tso91H6Ug
Message-ID: <CAJnrk1bJ5jE5qWdRju6xz+DipYHUrj8w4PdL80J1M6ujMxXJ1g@mail.gmail.com>
Subject: Re: famfs port to fuse - questions
To: John Groves <John@groves.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, John Groves <jgroves@micron.com>, linux-fsdevel@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, Eishan Mirakhur <emirakhur@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 7:25=E2=80=AFAM John Groves <John@groves.net> wrote=
:
>
> Miklos et. al.:
>
> Here are some specific questions related to the famfs port into fuse [1][=
2]
> that I hope Miklos (and others) can give me feedback on soonish.
>
> This work is active and serious, although you haven't heard much from me
> recently. I'm showing a famfs poster at Usenix FAST '25 this week [3].
>
> I'm generally following the approach in [1] - in a famfs file system,
> LOOKUP is followed by GET_FMAP to retrieve the famfs file/dax metadata.
> It's tempting to merge the fmap into the LOOKUP reply, but this seems lik=
e
> an optimization to consider once basic function is established.
>
> Q: Do you think it makes sense to make the famfs fmap an optional,
>    variable sized addition to the LOOKUP response?
>
> Whenever an fmap references a dax device that isn't already known to the
> famfs/fuse kernel code, a GET_DAXDEV message is sent, with the reply
> providing the info required to open teh daxdev. A file becomes available
> when the fmap is complete and all referenced daxdevs are "opened".
>
> Q: Any heartburn here?
>
> When GET_FMAP is separate from LOOKUP, READDIRPLUS won't add value unless=
 it
> receives fmaps as part of the attributes (i.e. lookups) that come back in
> its response - since a READDIRPLUS that gets 12 files will still need 12
> GET_FMAP messages/responses to be complete. Merging fmaps as optional,
> variable-length components of the READDIRPLUS response buffers could
> eventualy make sense, but a cleaner solution intially would seem to be
> to disable READDIRPLUS in famfs. But...
>

Hi John,

> * The libfuse/kernel ABI appears to allow low-level fuse servers that don=
't
>   support READDIRPLUS...
> * But libfuse doesn't look at conn->want for the READDIRPLUS related
>   capabilities
> * I have overridden that, but the kernel still sends the READDIRPLUS
>   messages. It's possible I'm doing something hinky, and I'll keep lookin=
g
>   for it.

On the kernel side, FUSE_READDIR / FUSE_READDIRPLUS requests are sent
in fuse_readdir_uncached(). I don't see anything there that skips
sending readdir / readdirplus requests if the server doesn't have
.readdir / .readdirplus implemented. For some request types (eg
FUSE_RENAME2, FUSE_LINK, FUSE_FSYNCDIR, FUSE_CREATE, ...), we do track
if a request type isn't implemented by the server and then skip
sending that request in the future (for example, see fuse_tmpfile()).
If we wanted to do this skipping for readdir as well, it'd probably
look something like

--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -870,6 +870,9 @@ struct fuse_conn {
        /* Is link not implemented by fs? */
        unsigned int no_link:1;

+       /* Is readdir/readdirplus not implemented by fs? */
+       unsigned int no_readdir:1;
+
        /* Use io_uring for communication */
        unsigned int io_uring;

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 17ce9636a2b1..176d6ce953e5 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -341,6 +341,9 @@ static int fuse_readdir_uncached(struct file
*file, struct dir_context *ctx)
        u64 attr_version =3D 0, evict_ctr =3D 0;
        bool locked;

+       if (fm->fc->no_readdir)
+               return -ENOSYS;
+
        folio =3D folio_alloc(GFP_KERNEL, 0);
        if (!folio)
                return -ENOMEM;
@@ -376,6 +379,8 @@ static int fuse_readdir_uncached(struct file
*file, struct dir_context *ctx)
                        res =3D parse_dirfile(folio_address(folio), res, fi=
le,
                                            ctx);
                }
+       } else if (res =3D=3D -ENOSYS) {
+               fm->fc->no_readdir =3D 1;
        }

        folio_put(folio);

> * When I just return -ENOSYS to READDIRPLUS, things don't work well. Stil=
l
>   looking into this.
>
> Q: Do you know whether the current fuse kernel mod can handle a low-level
>    fuse server that doesn't support READDIRPLUS? This may be broken.

From what I see, the fuse kernel code can handle servers that don't
support readdir/readdirplus. The fuse readdir path gets invoked from
file_operations->iterate_shared callback, which from what i see, the
only ramification of this always returning an error is that the
syscalls calling into this (eg getdents(), readdir()) fail.

>
> Q: If READDIRPLUS isn't actually optional, do you think the same attribut=
e
>    reply merge (attr + famfs fmap) is viable for READDIRPLUS? I'd very mu=
ch
>    like to do this part "later".
>
> Q: Are fuse lowlevel file systems like famfs expected to use libfuse and =
its
>    message handling (particularly init), or is it preferred that they not
>    do so? Seems a shame to throw away all that api version checking, but
>    turning off READDIRPLUS would require changes that might affect other
>    libfuse clients. Please advise...
>

imo, I don't see any benefits from using a custom-written library
instead of libfuse. I think there'd end up being a lot of overlap
between the two and wouldn't be worth the hassle.

> Note that the intended use cases for famfs generally involve large files
> rather than *many* files, so giving up READDIRPLUS may not matter very mu=
ch,
> at least in the early going.
>
> I'm hoping to get an initial RFC patch set out in a few weeks, but these
> questions address [some of] the open issues that need to be [at least
> initially] resolved first.
>

Looking forward to reading your RFC patch.

Thanks,
Joanne
>
> Regards,
> John
>
> [1] https://lore.kernel.org/linux-fsdevel/20241029011308.24890-1-john@gro=
ves.net/
> [2] https://lwn.net/Articles/983105/
> [3] https://www.usenix.org/conference/fast25/poster-session

