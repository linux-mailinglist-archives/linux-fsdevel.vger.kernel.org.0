Return-Path: <linux-fsdevel+bounces-50103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C1CAC82DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 21:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5447B0B00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 19:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15529235070;
	Thu, 29 May 2025 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhBbzPTk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE2E55B;
	Thu, 29 May 2025 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748547975; cv=none; b=PABMj9nxWZUg1oKlaeXVeXJMzORcnI6F6thhqXziJ3leQnZbcO+DPpjina5rAol+sq5kOBeLe0n866eXLQQp4woSdm+V1lL6GoFPlUaQ/0Js7iqJ2SvP5pe0nF3ot5N3Ph5h1zURBpNVgybLtBfRSmu00c1EUqubRu0OCBYJk8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748547975; c=relaxed/simple;
	bh=PUrL8mn5uIdACfpE3eBmISpFl6piO91h/jKm7BYJGkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noZMPTc/IVqRdo0Giat9xwOcpl2pPBvrG5KxG+qLKVGrOo14wncsf1yM2l8JEMFid83NXfyJkYZ6oqc5OgE2Sk4o8zcTfYDXUqY3R3C/rvSVyHqZ9rKIHokNRznqM/6RR1ZhLObV8WXOsK8POTqZa+hUKiFuZMsfdtJNgPyR8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhBbzPTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAADC4CEEE;
	Thu, 29 May 2025 19:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748547973;
	bh=PUrL8mn5uIdACfpE3eBmISpFl6piO91h/jKm7BYJGkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dhBbzPTk0XNUJHO8ZLPLriWTxcCUcc5O8dTQXpUwAmMEvMYHsfSJ286+NfeZW0PXL
	 3oMjxVc7eGl95Aimp9pT6Jd5NGj5Qswxf3SsAanW3NIz7ZoV2D/LbDGdYj/EQVAUIZ
	 8N/bqFOYikEuwO/aKo3xUlZBMjN077MW4nF5H30fWj+D7hEytqDVNdBQoMIHTlfRfk
	 TZQxR8zXJPDDAsoXU/gLuIdEyAYXD/fD2sfIHkoyBn0URWgxchLH5SBVwXWDfb9RyJ
	 GJuJEsUUCJw+y4bRpZAsJ97vZak6ZLYgslGjZyjx4PqRVe6va1HWwhf9u8j43eH7+X
	 mM1kqxqujFhgw==
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4766631a6a4so14517261cf.2;
        Thu, 29 May 2025 12:46:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgUt1QuWBOb9xN47k0hTAmR1IL6IHYxq9iHRSIgnBnhNjFiuqjYrFP1dxFSEk2inHTh04aeDlEp3oUMqwy/TAxEQbJWmAc@vger.kernel.org, AJvYcCWUW7YRhMWgN4uytrK1oLYDpntZ42nYWF3gRxaUV0qiRrm/ED23MA2j807ksEWp0EYIvf8=@vger.kernel.org, AJvYcCWiN96DUizrRKR0vNEti/oZK6O4rXUft6BOImYAgLVSl6Px5d32yrRquInfJxE8Z9TcOT8uUzHujTD/t0sIcQ==@vger.kernel.org, AJvYcCXbOaadGxCPAt9hA71JVKfYw7pZCN74eq9+K449mI+5gJl1llVcsoCTFgyu5GFISkUA0hj6++ZoIjPRrk1J@vger.kernel.org
X-Gm-Message-State: AOJu0YypOb+Wzp4NolGnCXlR8LHjckQDt3tpEbeyxuoD28Kvk4sn497E
	SUXbMwJDh4C25sXOxK64Cc7Xm4jhhK0J2QqkukXHxHPavgqTFisRdZaBqnn29zhNR9QxDmeoS/2
	WE303vL7izhMD4LFIOuSOJSQ2TXqQLUs=
X-Google-Smtp-Source: AGHT+IFY6IU590S4bL+v5D6GhHAGoh9dEWG0xwhcHzGoy8EgWUJpivtPNMBxmodfjCBhvoBMJd3CfBXnBhJrzinrrSk=
X-Received: by 2002:a05:622a:1cc4:b0:4a4:2f0b:d2e4 with SMTP id
 d75a77b69052e-4a44004620cmr16325091cf.13.1748547972905; Thu, 29 May 2025
 12:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528222623.1373000-1-song@kernel.org> <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV> <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <20250529173810.GJ2023217@ZenIV> <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
 <20250529183536.GL2023217@ZenIV>
In-Reply-To: <20250529183536.GL2023217@ZenIV>
From: Song Liu <song@kernel.org>
Date: Thu, 29 May 2025 12:46:00 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
X-Gm-Features: AX0GCFucBpIhJ0-QFxVRuTA9Yczw7uUI-QGrQG2G-J0sOZi2vyvwqTFuO6IWqmQ
Message-ID: <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, 
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, 
	gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 11:35=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Thu, May 29, 2025 at 11:00:51AM -0700, Song Liu wrote:
> > On Thu, May 29, 2025 at 10:38=E2=80=AFAM Al Viro <viro@zeniv.linux.org.=
uk> wrote:
> > >
> > > On Thu, May 29, 2025 at 09:53:21AM -0700, Song Liu wrote:
> > >
> > > > Current version of path iterator only supports walking towards the =
root,
> > > > with helper path_parent. But the path iterator API can be extended
> > > > to cover other use cases.
> > >
> > > Clarify the last part, please - call me paranoid, but that sounds lik=
e
> > > a beginning of something that really should be discussed upfront.
> >
> > We don't have any plan with future use cases yet. The only example
> > I mentioned in the original version of the commit log is "walk the
> > mount tree". IOW, it is similar to the current iterator, but skips non
> > mount point iterations.
> >
> > Since we call it "path iterator", it might make sense to add ways to
> > iterate the VFS tree in different patterns. For example, we may
> > have an iterator that iterates all files within a directory. Again, we
> > don't see urgent use cases other than the current "walk to root"
> > iterator.
>
> What kinds of locking environments can that end up used in?

This will start with a referenced "struct path", in a sleepable context.

> The reason why I'm getting more and more unhappy with this thing is
> that it sounds like a massive headache for any correctness analysis in
> VFS work.
>
> Going straight to the root starting at a point you already have pinned
> is relatively mild - you can't do path_put() in any blocking contexts,
> obviously, and you'd better be careful with what you are doing on
> mountpoint traversal (e.g. combined with "now let's open that directory
> and read it" it's an instant "hell, no" - you could easily bypass MNT_LOC=
KED
> restrictions that way), but if there's a threat of that getting augmented
> with other things (iterating through all files in directory would be
> a very different beast from the locking POV, if nothing else)... ouch.

We are fully aware that a "files in the directory" iterator may need
different locking. This is the exact reason we want to provide this
logic as an iterator in the kernel: to get locking/etc correct in the
first place, so that the users can avoid making mistakes.

> Basically, you are creating a spot we will need to watch very carefully
> from now on.  And the rationale appears to include "so that we could
> expose that to random out-of-tree code that decided to call itself LSM",
> so pardon me for being rather suspicious about the details.

No matter what we call them, these use cases exist, out-of-tree or
in-tree, as BPF programs or kernel modules. We are learning from
Landlock here, simply because it is probably the best way to achieve
this.

This particular set introduces a safer API than combinations of
existing APIs (follow_up(), dget_parent(), etc.). It guarantees all
the memory accesses are to properly referenced kernel objects;
it also guaranteed all the acquired references are released.
Therefore, I don't see it adds risks in any sense.

Thanks,
Song

