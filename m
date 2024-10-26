Return-Path: <linux-fsdevel+bounces-33007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9EC9B15C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 09:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993B61F24FA7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 07:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457DF185B72;
	Sat, 26 Oct 2024 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1u0BEkB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD204CA5A;
	Sat, 26 Oct 2024 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729926468; cv=none; b=iFam+ZqztabSJ4RbzavAxrUmyVEmSu7cJiY63ntd6dg3P6Ud4wUnlfJkvS0Hbl/leQE5RfztLBhkKhbClPS5X5fXe5VBrNxkUUBVcmctlze4Kb30CeFtrVBnSPF7FLKOOCIlFebkXcHcKIsua1w1dWNn5Jw6HlVU8t/O0gB963M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729926468; c=relaxed/simple;
	bh=hoTSZJngHiober32o6tA8UtxNG2+oOVmktAiLr3qtAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvbgUBwtK0nA7pPt6MsleVyvxA+BSCIQn3wFxHlh3rWsq4l1zxhAZYmln3MkSFdTYqrnzFIVtVSPlJNp2djHCNt+/2PAbofEyTIomPiqOd5tD3aEeBgYD7AEYybuq1f26aj2v+BVkBjQ0ACRmZpXML2OWR7ZwZLobZg2Y1mi5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1u0BEkB; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e38ebcc0abso33899287b3.2;
        Sat, 26 Oct 2024 00:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729926465; x=1730531265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUPGuf/B41PecwUAIA/RMCoEgGV/IQ+8muJ7AxScygU=;
        b=M1u0BEkB79vtZqzQkt1zWC1OUT8hGHhk6a9TnmfzJ+MU3bpZxXVp9dpM2RxJWLbyql
         QYkcImOg/jGlzjHqFVL+akTIOx4/U/wAXPh/2NEFY8UcwzJ1sbsiWJIpby2NCPyhlglf
         BaK0a5pq/9eZx5UaST/lZLulcBOfReXEOaFGMUlcegAYQUWfJczQ/VP6HEvFRYsPACeA
         nVEdooFhiH33mj9KeVrkMCKNcgsNTXzHgfZxGTtT98SypzhqesuyWj62Whm2C5BepYy8
         T/cpQW2PtcurrgyipJfTkzEZfQ6GrDNGWiSIwGt0wBTKDoT1dy2BpHuSML7693ujiqm0
         l/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729926465; x=1730531265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUPGuf/B41PecwUAIA/RMCoEgGV/IQ+8muJ7AxScygU=;
        b=SGM9zgWcjZdGw2rvykSTJ0hxc8R2bd6h/q1HyWqENoLrPFHEodhCxd+p30xuUXRegp
         EXoZYPT9A0kZhHzclAoC88AcycYdfTff1Pu/TzVdv76A2Tni1DnzpEYz3MljRXbc2H24
         oayLUYFQYkHsnq9p829S2qApMBbM6kGiVAUzM29NHj+MFGYdGcHxlu2C00HLqNqrV7ss
         /S5R93yaKMPQimymE11JU/NC2IpcE7EAG5UZK0QwULHbVfySs8E94Ga93ELRx46+LXMc
         IcMs9kH/7e6Hr5YFrxly2d6OKpzSJ2wQnDezf6xcBOW1btmCuoMOKjTchxYrEWUnrH4T
         Yb3A==
X-Forwarded-Encrypted: i=1; AJvYcCWnwizROaAjXTXuDDNWC9T6+E3T3O1AeokpjfSnmLTpEdrCHknWEOLfJCdxE/WEsUjNCju9NSh1GdW1nNLf@vger.kernel.org, AJvYcCXOZvXH//XmKT47HMradtD8yIj1lcqNdZ+LBmh/pFxBG9u3OITRgbREL+jjDFnxQ0erGLYDmzPN@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQZjc3XpBav26H3MhP8btkFmcTZGqiOIjUJOGeEAaKteMtOTm
	tvpc1GmUGpQR7F/EIEBD+vfMQCWpejdYX2D6ClxVknCoOKVuEgpEsR+CE9Zbo9sdL2Y2tfi81eP
	mMvNqsbue0O3KzZcnyQyCLTldXUo5+XtXRj0=
X-Google-Smtp-Source: AGHT+IET2IlY+4eh0HPZYUUUvl4s1re/vs3sYpmb6Nn5gfXnazvVed7Zg6Rl5kP5EAKc4wxaV6XzRaS1lkhe7v106SA=
X-Received: by 2002:a05:690c:c94:b0:6e3:2cfb:9a86 with SMTP id
 00721157ae682-6e9d89970dfmr22427307b3.26.1729926464709; Sat, 26 Oct 2024
 00:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANeMGR6CBxC8HtqbGamgpLGM+M1Ndng_WJ-RxFXXJnc9O3cVwQ@mail.gmail.com>
 <ZxwTOB5ENi66C_kq@codewreck.org>
In-Reply-To: <ZxwTOB5ENi66C_kq@codewreck.org>
From: Guan Xin <guanx.bac@gmail.com>
Date: Sat, 26 Oct 2024 15:07:08 +0800
Message-ID: <CANeMGR4TFdLnrH-=S7ZNacaOendJvm_ocbvN-Md8A6rAQdmkhg@mail.gmail.com>
Subject: Re: [PATCH] Calculate VIRTQUEUE_NUM in "net/9p/trans_virtio.c" from
 stack size
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Eric Van Hensbergen <ericvh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dominique,

On Sat, Oct 26, 2024 at 5:53=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
>> Have a look at other recent patches on https://lore.kernel.org/v9fs/

Sorry I'm new to Linux and didn't find out the exact workflow from the
numerous instruction files.
Thank you for pointing me to the examples!
This is greatly helpful.

Guan

P.S. Patch attached:

> Guan Xin wrote on Sat, Oct 26, 2024 at 12:18:42AM +0800:
> > For HPC applications the hard-coded VIRTQUEUE_NUM of 128 seems to
> > limit the throughput of guest systems accessing cluster filesystems
> > mounted on the host.
> >
> > Just increase VIRTQUEUE_NUM for kernels with a
> > larger stack.
>
> You're replacing an hardcoded value with another, this could be made
> dynamic e.g. as a module_param so someone could tune this based on their
> actual needs (and test more easily); I'd more readily accept such a
> patch.
>
> > Author: GUAN Xin <guanx.bac@gmail.com>
>
> Author: tag doesn't exist and would be useless here as it's the mail you
> sent the patch from.
>
> > Signed-off-by: GUAN Xin <guanx.bac@gmail.com>
> > cc: Eric Van Hensbergen <ericvh@kernel.org>
> > cc: v9fs@lists.linux.dev
> > cc: netdev@vger.kernel.org
> > cc: linux-fsdevel@vger.kernel.org
> >
> > --- net/9p/trans_virtio.c.orig  2024-10-25 10:25:09.390922517 +0800
> > +++ net/9p/trans_virtio.c       2024-10-25 16:48:40.451680192 +0800
> > @@ -31,11 +31,12 @@
> > #include <net/9p/transport.h>
> > #include <linux/scatterlist.h>
> > #include <linux/swap.h>
> > +#include <linux/thread_info.h>
> > #include <linux/virtio.h>
> > #include <linux/virtio_9p.h>
> > #include "trans_common.h"
> >
> > -#define VIRTQUEUE_NUM  128
> > +#define VIRTQUEUE_NUM  (1 << (THREAD_SIZE_ORDER + PAGE_SHIFT - 6))
>
> (FWIW that turned out to be 256 on my system)

