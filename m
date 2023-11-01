Return-Path: <linux-fsdevel+bounces-1740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E049D7DE271
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 15:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F5E2817EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 14:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C87134BB;
	Wed,  1 Nov 2023 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SbxRFayN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368912B60
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 14:42:26 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B692128
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 07:42:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso11381495a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698849739; x=1699454539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Asse2ptdl7Tak3ppRFci+aJxpWXPvtiV3ADKe+PDLc=;
        b=SbxRFayN2+PNPJ7wNGhwh7NcBU6Jm5NVZiOaq8DNOyy2ne9nypB4I0ixJ8o407AENS
         leutymEdwxlpjL8C7M3GVqi7gT/uJk38FaAQuCYLyjujDsQxZIVM9c+Up3+dk5Kyw9kc
         tEGEyskBIrzRthYJ5Vb3USZ77fh5zP1YWZnPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698849739; x=1699454539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Asse2ptdl7Tak3ppRFci+aJxpWXPvtiV3ADKe+PDLc=;
        b=BGp5v36KLImp4DYUoSFZfwVSxQdM8HSyYlyGxvNU9ZX2VgeTw0flts4GnM780Y+c2i
         WRaNk/EigBpc6mHrsDjQZvmJOjL2Mo1a6i5Kwizzd0KfJ+a7A6tNg/uUgL6Rd4kwc6YU
         2PI001DHYTqPDk+wPoknsXgMsSWvS5GKWeWXa/xKGiQNbTMONwXt9mTfBRKLQ3OUz0AX
         vVXRvV6s4zFsjAYSJO6aQVOvC9XbdksbPbok+Ud4q12+W3BHPC1PIZYYzhvTLLc4YJRq
         /OU7V0he9TQshkIg+H5aWfwLo86loAWy6QBjgsyK9n4JW/NiV+M8jJxsf6UtReqKHEuw
         4TrQ==
X-Gm-Message-State: AOJu0Yz3UHdqoyBI0aX2VncRKjtVNBivXYq31LQZ5sSsgJ/4Co5i7Veu
	pfYBEEB3O91qEq4PB7ArIH0+H8xwNCa8rtfWVw5WFlRiJR/cw9qI
X-Google-Smtp-Source: AGHT+IHU3c/UX/dcIwP+BeRW92Gd8RE0o0lrKhZAX/8p5jjQx6c2vi+Ga2oA1N3Xs49sGv3OnAYf4H7H+Vu8TOgZ7bg=
X-Received: by 2002:a50:fb02:0:b0:53f:7199:f442 with SMTP id
 d2-20020a50fb02000000b0053f7199f442mr13545843edq.3.1698849739617; Wed, 01 Nov
 2023 07:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh=cLySge6htd+DnJrqAKF=C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com>
 <CAJfpegtZGC93-ydnFEt1Gzk+Yy5peJ-osuZD8GRYV4c+WPu0EQ@mail.gmail.com>
 <CAOQ4uxjYLta7_fJc90C4=tPUxTw-WR2v9du8JHTVdsy_iZnFmA@mail.gmail.com>
 <CAJfpegufvtaBaK8p+Q3v=9Qoeob3WamWBye=1BwGniRsvO5HZg@mail.gmail.com>
 <CAOQ4uxj+myANTk2C+_tk_YNLe748i2xA0HMZ7FKCuw7W5RUCuA@mail.gmail.com>
 <CAJfpegs1v=JKaEREORbTsvyTe02_DgkFhNSEJKR6xpjUW1NBDg@mail.gmail.com>
 <CAOQ4uxiBu8bZ4URhwKuMeHB_Oykz2LHY8mXA1eB3FBoeM_Vs6w@mail.gmail.com>
 <CAJfpegtr1yOYKOW0GLkow_iALMc_A0+CUaErZasQunAfJ7NFzw@mail.gmail.com> <CAOQ4uxjbj4fQr9=wxRR8a5vNp-vo+_JjK6uHizZPyNFiN1jh4w@mail.gmail.com>
In-Reply-To: <CAOQ4uxjbj4fQr9=wxRR8a5vNp-vo+_JjK6uHizZPyNFiN1jh4w@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 1 Nov 2023 15:42:07 +0100
Message-ID: <CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=6HtpaA+W83vvQea5PycQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Nov 2023 at 14:23, Amir Goldstein <amir73il@gmail.com> wrote:

> However, I can imagine users wanting to do passthrough for read-only
> fd without doing passthrough for read-write fd, for example, if data is
> never manipulated by the server, but it is inspected on write.

Okay, that could make sense in a read-mostly use case.  But I think
that special case could be enabled with FOPEN_DIRECT_IO since we have
that anyway.  I.e. FOPEN_DIRECT_IO would override the per-inode state,
which is what it does now.

What doesn't make sense is to mix cached I/O with non-cached (direct
or passthrough) I/O.

> I have one problem with my in-house server and passthough of readdir.
> readdir passthrough cannot do readdirplus to populate inode cache.
> For readdir of a large, read-mostly directory, cached readdir is preferred
> because of readdirplus.
> For a large, write-often directory, when only readdir is needed, readdir
> passthough is preferred.
> No one size fits all here.

But in this case the cache part of readdirplus is not useful, only the
prepopulation part.  So why cache in that case?

Now using readdirplus for prepopulation might be the right interface,
but it also might make sense to use it _only_ for that and use
passthrough for the actual readdir.

> I don't mind dropping the last readdir passthrough patch for the first
> version, if you want to take more time to think this over.
> I'd just like to know that there is a path forward to make conditional
> passthrough per fd possible in future versions.

I think first version should just do regular file passthrough.

> BTW, the FUSE BPF patches that map a backing inode to
> fuse inode allow fallback to server depending on BPF program result.

Yep, that also makes sense.  What we need to make sure is that cache
and non-cache access are not mixed, because that way lies madness.

Thanks,
Miklos

