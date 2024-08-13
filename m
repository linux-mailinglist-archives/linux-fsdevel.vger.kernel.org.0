Return-Path: <linux-fsdevel+bounces-25757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BE494FC47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 05:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A852B20E2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 03:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10BB1CA9E;
	Tue, 13 Aug 2024 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbg7Os3R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70E81BC39;
	Tue, 13 Aug 2024 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723519970; cv=none; b=hlt4lQhArZzK+LsUw1A677gFvR6gO5gD3O6RkEnhxY6Rv7Dia3oxSrhJiodQ0/lg8h/7kGPuSDaVxMrsMjcXb8kpvXuy/67E/9mhwQXUcWhnQYP5IW0zQwQCSSrvGCjnwyA2zhUQSYlCZH9eLLbYFivgmsSIw3cmoFFZ36D4ArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723519970; c=relaxed/simple;
	bh=VfZKpzSzmxeCP+ISk3acmz4CxXRITaKL5T/IGvJTi+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zsx9W5tWKLAFKYhQ155qVaZT5dfiYIt1A3YzKNnjX+j17JPEnjF5A3MPcbOHqtJIvnESneJ5Q3XIJIhPvXmiZgNJLnc/SgxNncL9caw+3X/qpn8XhGCf4our+gDuX+ztmMwkqCkukTzgxe6omsG8VvjbigSyIOkeHRrEcDgM+HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbg7Os3R; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so3488866a12.3;
        Mon, 12 Aug 2024 20:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723519968; x=1724124768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfZKpzSzmxeCP+ISk3acmz4CxXRITaKL5T/IGvJTi+Q=;
        b=mbg7Os3RAD59PViOLvpbChvTi/DIanI+AaQJyGt92MdNw+K6IjLuTRDdqYiaTEwkzz
         LW4XVBfRRT1/4VGRwSKa/3NN5/Bjqf8sVJCxD78DSiCux3eSbIuaUGIZb9zrErbxAIuP
         dxM9m/nJ2zGKN/RhZjKwxGvEV0ikdK90MCWqphsizJIz2vRCojjtIadQeBSIhsVvqljC
         PT+kaQkmzCMPJfkyvPPuyav34Q3pIzVaag+GQ0SChb8NSJk0XtWMohdB4WBd++AV1a0/
         SKmvfuKzkid2j/q4+SuTWgMccbOkHyeurfyMTYF2fGv9oR60n5BLYJfQjixX3hOd6f9o
         +S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723519968; x=1724124768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfZKpzSzmxeCP+ISk3acmz4CxXRITaKL5T/IGvJTi+Q=;
        b=hQwvrmpWcnRyo42Hk1B4CqPQj4qrJ8lqcL+3ctxclVELhqS93JC73dvHwYoEuFw9Qi
         o+W2c0SUOC208m7rd7ujsUPa8DfUnpWw75aZAogNOy9cvgmurguDfBmU1q0J5LGJ7tFx
         dDjBjHcENRGwUHypXublDCPj183WTN1Nuk1cI0qSZGqj27VLgM6smQwuclCKbtyhyl0C
         Pnu6VZHj5GsD4RE2C26B1/Tw7ZeCvIK0KNCueLzlmtgtsApC2zYHfGP3NvtQHYlgxwFx
         fM5tpIoMShDQ9i7v9GuzrbhinBV6pcRuQlkHGh98QUBYtdog5H8Yac75f8G/UBMdFqzq
         XMKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg5e0lU1cCJAC6I9GhEcnG2uBxjka/KWK0EF6PBFiBkjW8elDaCsvyKOfn/EgyePmOqRIjmc2p1rphXg8N9EKESxd+lzYreLQm6qn52CStTV1dN2qnAiIAZy/QZiChQ2CoY45wSYllrT9ONZ6wWymmLK1bH+5jmIfgP5bA4PeQ1I4HUvTGc3NphC5VbkEj/OCx5OfglkmwxaXibvQOQz4yaVkUdcJKzrE=
X-Gm-Message-State: AOJu0YwQYCGW/AxsZlqiSz8kuOgdL5RtN9rcYyIjSapbO1/VnQo1w7ls
	DauZ4WjhsiaFnTi4FKT1wN5nx3qFj0v+/x+P4bXJcodhxNpXP9f/jREmJmEzvvKUSsE59684RkS
	Q/Iu1thpSxIT4z01ZX7mDprDD1X4=
X-Google-Smtp-Source: AGHT+IFh/5uOEOg72gpS6vOsn2g3n3u2/ODBL1YjJAJxMbMVs16tdzK2dKIlRduQHPcaa0PYK8jzxCJwm051A8lpwD8=
X-Received: by 2002:a17:90a:460f:b0:2c9:95c7:7521 with SMTP id
 98e67ed59e1d1-2d3924d2a73mr2756900a91.1.1723519967564; Mon, 12 Aug 2024
 20:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730050927.GC5334@ZenIV> <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-17-viro@kernel.org> <CAEf4BzZipqBVhoY-S+WdeQ8=MhpKk-2dE_ESfGpV-VTm31oQUQ@mail.gmail.com>
 <20240807-fehlschlag-entfiel-f03a6df0e735@brauner> <CAEf4BzaeFTn41pP_hbcrCTKNZjwt3TPojv0_CYbP=+973YnWiA@mail.gmail.com>
 <CAADnVQKZW--EOkn5unFybxTKPNw-6rPB+=mY+cy_yUUsXe8R-w@mail.gmail.com>
 <20240810032952.GB13701@ZenIV> <CAEf4Bzb=yJKSByBktNXQDd8rqWPNCU9EWziqQhFBnCVuTGKCdg@mail.gmail.com>
 <20240813020651.GJ13701@ZenIV>
In-Reply-To: <20240813020651.GJ13701@ZenIV>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Aug 2024 20:32:34 -0700
Message-ID: <CAEf4BzbNfA0usftdY16jg=+zD5zadM5BsDqtcZqd1y9+G0cfLA@mail.gmail.com>
Subject: Re: [PATCH 17/39] bpf: resolve_pseudo_ldimm64(): take handling of a
 single ldimm64 insn into helper
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Christian Brauner <brauner@kernel.org>, viro@kernel.org, 
	bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, kvm@vger.kernel.org, 
	Network Development <netdev@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 7:06=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Mon, Aug 12, 2024 at 01:05:19PM -0700, Andrii Nakryiko wrote:
> > On Fri, Aug 9, 2024 at 8:29???PM Al Viro <viro@zeniv.linux.org.uk> wrot=
e:
> > >
> > > On Thu, Aug 08, 2024 at 09:51:34AM -0700, Alexei Starovoitov wrote:
> > >
> > > > The bpf changes look ok and Andrii's approach is easier to grasp.
> > > > It's better to route bpf conversion to CLASS(fd,..) via bpf-next,
> > > > so it goes through bpf CI and our other testing.
> > > >
> > > > bpf patches don't seem to depend on newly added CLASS(fd_pos, ...
> > > > and fderr, so pretty much independent from other patches.
> > >
> > > Representation change and switch to accessors do matter, though.
> > > OTOH, I can put just those into never-rebased branch (basically,
> > > "introduce fd_file(), convert all accessors to it" +
> > > "struct fd representation change" + possibly "add struct fd construct=
ors,
> > > get rid of __to_fd()", for completeness sake), so you could pull it.
> > > Otherwise you'll get textual conflicts on all those f.file vs. fd_fil=
e(f)...
> >
> > Yep, makes sense. Let's do that, we can merge that branch into
> > bpf-next/master and I will follow up with my changes on top of that.
> >
> > Let's just drop the do_one_ldimm64() extraction, and keep fdput(f)
> > logic, plus add fd_file() accessor changes. I'll then add a switch to
> > CLASS(fd) after a bit more BPF-specific clean ups. This code is pretty
> > sensitive, so I'd rather have all the non-trivial refactoring done
> > separately. Thanks!
>
> Done (#stable-struct_fd);

great, thanks, I'll look at this tomorrow

> BTW, which tree do you want "convert __bpf_prog_get()
> to CLASS(fd)" to go through?

So we seem to have the following for BPF-related stuff:

[PATCH 16/39] convert __bpf_prog_get() to CLASS(fd, ...)

This looks to be ready to go in.

[PATCH 17/39] bpf: resolve_pseudo_ldimm64(): take handling of a single
ldimm64 insn into helper

This one I'd like to rework differently and land it through bpf-next.

[PATCH 18/39] bpf maps: switch to CLASS(fd, ...)

This one touches __bpf_map_get() which I'm going to remove or refactor
as part of the abovementioned refactoring, so there will be conflicts.

[PATCH 19/39] fdget_raw() users: switch to CLASS(fd_raw, ...)

This one touches a bunch of cases across multiple systems, including
BPF's kernel/bpf/bpf_inode_storage.c.


So how about this. We take #16 as is through bpf-next, change how #17
is done, take 18 mostly as is but adjust as necessary. As for #19, if
you could split out changes in bpf_inode_storage.c to a separate
patch, we can also apply it in bpf-next as one coherent set. I'll send
all that as one complete patch set for you to do the final review.

WDYT?

