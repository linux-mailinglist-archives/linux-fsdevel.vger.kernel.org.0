Return-Path: <linux-fsdevel+bounces-15113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E03D8887103
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 17:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC611C21CCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745845D47A;
	Fri, 22 Mar 2024 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXoFqmac"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BFB59163;
	Fri, 22 Mar 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125597; cv=none; b=jsd5DTfJdutP+0aXWmF8LzSWE096CjpxRLUEzhNRdNLeBEfm34AmRgGjiWPlRxCfpIhoFnzZPhVX58I+MtURsU5uDJM14J4RhaRnvcdw6A67bV+c/7JXcxlR3/8eyAiR8wj0asp6snIFJAzpf8av2qdvwD/cPCS5JGkB6FHj3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125597; c=relaxed/simple;
	bh=7v+ihhXci5sqhX8V+jNruf1JVBOlr5+Ra+WTdULUBEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVjKzvZ+IhWhLZrqH7g3Nlfcsto6t8O4PCzHTX5t90d0QpPn/HAzb69gl98ihFxDuy3H3k3ErtgPkwiPWIXnD3PtYHwXrPZexXOd8DgiIn2C8giRiSiehRwdpAPgbEgSdJ5vG8vr/YlAm1tpnL63zZ0qnxa5D8IWHIcoCkCtHDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXoFqmac; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29fbe140c24so1628199a91.0;
        Fri, 22 Mar 2024 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711125596; x=1711730396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZidRDuY5Aevf95sEzZzzxNl7J8LcO4JJpSyMrNFhevQ=;
        b=iXoFqmac3oBxDQr5Tf4CjkA+6IE3q4pjzalPFe0CJaY+HeoZLRscawiu71n3UJpP4T
         roRp4rTq4AYoeDDmoepV+TYWsjHeHrnMiyEMyR5mP0M9iBRcOExR2z8rQpV3aR8oc8Ai
         Xj+ouEQiIeQ+HD/3wIeFXoqjk8fbxOcT2EDxg7m5rIhAP7bZtH7rwNADgDtnpmOWFxP6
         v1Tu5c9sf1Nza1sxSxkVuJV1xBYEF31aHGPsgGL+72QPRAjcOI7ALj3vZ3nnbje5hAYk
         f1sfSvimNo8yy8uRUrn8bRU4tWonyawkVRwMOas3hmc2f2MT2Rv6rYVDb5AGXpsWsN+k
         ASSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711125596; x=1711730396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZidRDuY5Aevf95sEzZzzxNl7J8LcO4JJpSyMrNFhevQ=;
        b=gzwbfh++ULSwjHU2+oZ8MdCy6cfh7c0rc8iJVdSDFQIZNK5FnXHwtHTUcDRjJ8SAYg
         9x2ALh56GweJbJyTmIVjTkJAXoA/Ox3aKfa/3eogt/U4YaXg4ntUW/ZshXa2KCcllCG+
         owq9yx52P+AGw7byP8M+vQiBu6KKtACc049jX86APWydYzZ3nENxK+RzHzW3AYoJfZfP
         7rYfiT5SVLzHC5yB5DDdnFm5VEk/B88FLd1c12v8O2wnlllBomHa8zTfw3FA74s/Qw2K
         umX5LAprhnynbPg6Ni/EEn2ih+UeleTWPCJHmPJmqDD4lajdG6bI5JrZLN/i2uMcHZTy
         KAWA==
X-Forwarded-Encrypted: i=1; AJvYcCWPdWAkYjFJkdRlFVILD2PaqBxwkvNYYEBFLdgMsuKezHgXX0izOPSLK8MyMVyZSND4YaZrJj9unf6LkNft5P9LzpLWV5j9QGAnL5yDIBw8VvlohfE26qz1MJ05RJRmJIp90hH1hw==
X-Gm-Message-State: AOJu0YxkEqR7zlYt0n0Mi356aI3Vp6ADyyQuFyxAcbul+nPN/GIm4wo5
	3undBmEURkbGQlA8awFvEGE3w9d6eYGSdhDp/PtoTkK7ONkl/I6jnqrQ3MQclu7v/0bQSRDSJot
	nPRb40i1HhjmdJKpONUrrYwvIPO4=
X-Google-Smtp-Source: AGHT+IFFDT4lxr5rv/sSdVPMZV2VS9eEMJx70sZTwM8qOxvzpf7GeHb5N66oQ8piCdfm1OVUveKq3wOuVHYS3S5Oii8=
X-Received: by 2002:a17:90a:c503:b0:29f:aee7:f41b with SMTP id
 k3-20020a17090ac50300b0029faee7f41bmr154889pjt.42.1711125595924; Fri, 22 Mar
 2024 09:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320182607.1472887-1-jcmvbkbc@gmail.com> <202403211004.19F5EE27F@keescook>
 <CAMo8Bf+jbsnok=zy3gT2Z-F8=LCMVVFhAoiJ8sjwaEBSbbJXzw@mail.gmail.com> <202403212041.AEB471AC@keescook>
In-Reply-To: <202403212041.AEB471AC@keescook>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 22 Mar 2024 09:39:43 -0700
Message-ID: <CAMo8BfKhk8dk3-n7gx3edZKSZUhCa+GJf4XwFvXr6bYzcwsb-A@mail.gmail.com>
Subject: Re: [PATCH] exec: fix linux_binprm::exec in transfer_args_to_stack()
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Rich Felker <dalias@libc.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 8:48=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Thu, Mar 21, 2024 at 12:52:16PM -0700, Max Filippov wrote:
> > On Thu, Mar 21, 2024 at 10:05=E2=80=AFAM Kees Cook <keescook@chromium.o=
rg> wrote:
> > > What's the best way to test this? (Is there a qemu setup I can use to
> > > see the before/after of AT_EXECFN?)
> >
> > I put a readme with the steps to build such system here:
> >   http://jcmvbkbc.org/~dumb/tmp/202403211236/README
> > it uses a prebuilt rootfs image and a 6.8 kernel branch with two
> > patches on top of it: one adds a dts and a defconfig and the other
> > is this fix. The rootfs boots successfully with this fix, but panics
> > if this fix is removed.
>
> Does musl have something like the LD_SHOW_AUXV env variable. With glibc,
> I usually explore auxv like so:
>
> $ LD_SHOW_AUXV=3D1 uname -a | grep EXECFN
> AT_EXECFN:            /usr/bin/uname

I couldn't find anything like that in either musl or uClibc-ng.
So I updated the above rootfs and put the following program
into it as /bin/test-auxv:

#include <stdio.h>
#include <sys/auxv.h>

int main()
{
       unsigned long p =3D getauxval(AT_EXECFN);
       fprintf(stderr, "AT_EXECFN: 0x%lx\n", p);
       if (p)
               fprintf(stderr, "%s\n", (const char *)p);
       return 0;
}

While looking at it I also noticed that /proc/<pid>/auxv is empty
on NOMMU, looks like there will be yet another fix for that.

--=20
Thanks.
-- Max

