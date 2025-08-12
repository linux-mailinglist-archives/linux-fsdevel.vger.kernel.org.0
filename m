Return-Path: <linux-fsdevel+bounces-57595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA120B23C2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 01:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E4C3B5C6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA5521CC5B;
	Tue, 12 Aug 2025 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqLjy3Id"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789544C81
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755039746; cv=none; b=ggqSAhqvPhRjROlUjijgdyf6vlQIT74cHckSWZG2+D2RAL518gaHBqOJrAiZcswsEavWY9m24LayZSqE7NkyqgDf4kd3KyiPGjGOdzSVBlC4CBfpAHh8M+OvG3D6MifVKi0byNOFVpZ9NITeZ8L7hpgxb4IYzmrtqiLLt9DU9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755039746; c=relaxed/simple;
	bh=RU8ffK1o+XCQ42xrOfhjrtiAj7nlOD1I+iysnQiePi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1r8CNnp2HxB2p3zDGIgFvRNJgeaO+B3Nicm/eSkj8NZC9zfVwcJXlEGoPwLqJBfVv88azi9Hd/EUQPj+FMmvxV11l6WN34QzeRCOFTzj9A7qeMGVRKBUHdEFjRkg/B9sPcckZkuZBsx/Crk3tRqgHVkinW3VR2bky/Ljc6xHt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqLjy3Id; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b08c56d838so4915981cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 16:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755039743; x=1755644543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RU8ffK1o+XCQ42xrOfhjrtiAj7nlOD1I+iysnQiePi8=;
        b=VqLjy3IdMSDLx/uVJuclRP6iTqNnKEBJr0REy+9cRAa9DD8NZSveLJCkt4lG2uL4nn
         KEXH85ZHfalNSMlRVtSPGbuJhHennIjufymdx82IAfr/FPm/1R+FxX9jcq8v+3Gedkia
         rf+O2CjlhYxTDUMw+ynJqF38nTsaAZHYsK1MWPTt5t07f/H8yEFlC5bnDgIo1rNjDjik
         gehy4IDoizmMamgGMayAX3tn6WYX5kTXasjxDfG7HwQvXV39YZYp9/gMuBjufdYYGyYN
         8QwkFj6lB8hIHjQoN0peOmMXHHZ04fitL+/jr5IJMz3EcmOZgCHj/ArZOab5boCjG0FD
         +XZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755039743; x=1755644543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RU8ffK1o+XCQ42xrOfhjrtiAj7nlOD1I+iysnQiePi8=;
        b=Yti70MYokjA/IswXpRGTV0gFXpCMapaRbBBE5jn91JrAzVPAsr9KisQpnhI62Lsi9K
         XV8Sxmxupd1g8/HYT/a9L0n2B97Q2YVm6QiPZmHq7dwVZ826KnXwtVWGfGhdPIS8P/+Y
         cua1hMLNTJGqvjcwTPsjDebd6qToqZHflrku6unhHjp7X1tRbPb09m/FnkOATiqCpgM3
         ke2fBpx27f2CoPApHC7cvK7G6fIJ/uAswjmk76gBDGVsktDhywRW6SuCi4Ikma9qU+DD
         Yl4TlOWQ4SODvkAce8OurGi979wNbHovhAY8bsl0vnETqbakxwMvc32gUmJ0vj2BTO6P
         U7vQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6FMU46QVfMi7bOnFAt5+NOJpCM5sJ+9OPXmRj3+eWsKRhHmTFxicl8wdzJ0+xrDp82PNvICgsC3xidMeD@vger.kernel.org
X-Gm-Message-State: AOJu0YxiBN2ABoXhn1AOYPxV7s0yBL6pvi9/+bNBexZgJ7phNIx7zNWU
	1rzMtgHwBaPaBHINaac5uqS0oEtbVgbRarWKjNwknZ8pMWgy/jbsOWx6MwqvxK1RRZmRljwPFpo
	A7SWTsddy0AV8RCIR1svknKC5zHVoJFg=
X-Gm-Gg: ASbGncvqVGXGt1pOZMrLuzXf1i4tQyEofNFkRWZ3XI0MBVZtnDXabAZtvaA1Bp4/7j9
	Vh6H9Har0Ov+cDQKbCYjXwLzcFDzA/K0XsFZiTwRPwzGqC+5w0ocrF4eL9qRHA88hQ8N8D3M7WD
	qNmvanF00pYiGpcyi6O/ixQpI8VK+a+g8G5HOhCgiCX08nmUoqL+7LoR3iKUpVQhE6lZcCD++M1
	HuH+Yj2
X-Google-Smtp-Source: AGHT+IE+jwyI95fHGLjAFWSCOccxkPmOPghPXj3XIxFR96tSmHKsT+MxeARkk1gVCf+zdJ0cyMawCTNxlW9lcLa4uQY=
X-Received: by 2002:a05:622a:1aa3:b0:4b0:69ef:8209 with SMTP id
 d75a77b69052e-4b0fe2eb53emr4348851cf.26.1755039743022; Tue, 12 Aug 2025
 16:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811204008.3269665-1-joannelkoong@gmail.com>
 <CAJnrk1ZLxmgGerHrjqeK-srL7RtRhiiwfvaOc75UBpRuvatcNw@mail.gmail.com>
 <CAJfpegs_BH6GFdKuAFbtt2Z6c0SGEVnQnqMX0or9Ps1cO3j+LA@mail.gmail.com> <20250812193842.GJ7942@frogsfrogsfrogs>
In-Reply-To: <20250812193842.GJ7942@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 12 Aug 2025 16:02:12 -0700
X-Gm-Features: Ac12FXyW0KnRbB1cfCOXwt_-ssDlcAOxuFsBQrgZ2lj4RdIDZhtTtKzYF8ZG8a0
Message-ID: <CAJnrk1Y27jYLxORfTaVWvMxH1h2-TrpxrexxxqawSK1rOzdrYg@mail.gmail.com>
Subject: Re: [PATCH] fuse: enable large folios (if writeback cache is unused)
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, bernd.schubert@fastmail.fm, willy@infradead.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 12:38=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Tue, Aug 12, 2025 at 01:13:57PM +0200, Miklos Szeredi wrote:
> > On Mon, 11 Aug 2025 at 23:13, Joanne Koong <joannelkoong@gmail.com> wro=
te:
> > >
> > > On Mon, Aug 11, 2025 at 1:43=E2=80=AFPM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > > >
> > > > Large folios are only enabled if the writeback cache isn't on.
> > > > (Strictlimiting needs to be turned off if the writeback cache is us=
ed in
> > > > conjunction with large folios, else this tanks performance.)
> >
> > Is there an explanation somewhere about the writeback cache vs.
> > strictlimit issue?
>
> and, for n00bs such as myself: what is "strictlimit"? :)
>

My understanding of strictlimit is that it's a way of preventing
non-trusted filesystems from dirtying too many pages too quickly and
thus taking up too much bandwidth. It imposes stricter / more
conservative limits on how many pages a filesystem can dirty before it
gets forcibly throttled (the bulk of the logic happens in
balance_dirty_pages()). This is needed for fuse because fuse servers
may be unprivileged and malicious or buggy. The feature was introduced
in commit 5a53748568f7 ("mm/page-writeback.c: add strictlimit
feature). The reason we now run into this is because with large
folios, the dirtying happens so much faster now (eg a 1MB folio is
dirtied and copied at once instead of page by page), and as a result
the fuse server gets throttled more while doing large writes, which
ends up making the write overall slower.


Thanks,
Joanne

> --D
>
> > Thanks,
> > Miklos
> >

