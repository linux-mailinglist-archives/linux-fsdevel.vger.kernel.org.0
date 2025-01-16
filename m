Return-Path: <linux-fsdevel+bounces-39441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF95A142B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 21:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33DD188CCC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 20:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB39230D0A;
	Thu, 16 Jan 2025 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPZEY1RH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764A51527B4
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057733; cv=none; b=LOIE4vpuq6eNFPfRzqB1j12Z/NN12dmrJbj+zsIjmcqs1rZ/gUrJexaz2vJpKOM/684HifHEYVqAPR8foQpu4UJOKW+jp981A0F0vCuKzAh3EObiqjAvrOlOvnfl8Es4U2UVfDJH5ZzidT6SOFzu0e8nQP7Y+wOUETezhF5GAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057733; c=relaxed/simple;
	bh=kFO/HGjVt74C6EglhhdvBnSfm+JakFn5k56f/onYsMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ck1hhVDPaobPAvikXd3D3/W63bxcHHsd6/W5tniRIxeE5WBY5Qg3RQSKyo2KCokPZwxaWzzUG/TXztBRUMwgcSGIPD3/Kv7LjneAWlbLn4eqvaK2g5ZleRKwItkcUwJ13rqkECuEBX+0H6D2BCPfSsvoCkjBlD5DNwcl44WZMz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPZEY1RH; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46783d44db0so13021751cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 12:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737057730; x=1737662530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kmSFNTGgsEpQvRvsmfC/WHKK8LZr/LSIOliRNLE3QI=;
        b=OPZEY1RHsfZSxIuiOIvyxAM26RXwlYJQYHISLgkHZrQs4wLAQe9DrsB+sND6LjBHi2
         GgHMqr01UPnv+SH7b+3Os/PhrGeRMiqeAvMJKyNmEgJKGiEB0g3QQ90jf+FDfXU7dgSh
         7rg8O2c/Vifs9HZIyqA9+po7w06jXs0qrL0OyzZQNP/3ZHkjbzfhVtbxthxhQsaTSWOf
         OJEO0Q//7kUNhwP2HTsGG7eRNM8e59/D5uYVOzyNQxfvtw/R59EOKqdaHvZ44lM3v3eh
         /hKBi0Km75Ghka/w4A3MxXHCBGsgnthytQEzJmNa6KSEyswzW3SZUvJqNRVjsvoi5PfC
         uVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737057730; x=1737662530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kmSFNTGgsEpQvRvsmfC/WHKK8LZr/LSIOliRNLE3QI=;
        b=vtnFXDe26X56Yebimh04Yuqy5EiOAXwrHJRFWli3QTuqrx1lGEsX2n+NiOn+JIMss5
         KcMNt9MxMS89Zi9P+D6WnsCCb+DCM0yNcZq/xDdFIllKP3okjEBuke7yfXWaXY9t7FKw
         DICCoOT06C0aXtxpQhuD0xmXCIV3/EWca5N40KdMB25aulXfF4xiarz8DzsdWugTx9io
         rRePF24AId7Vg7r1mT0VNa+51Q/UxQDVAadfYhhfu6TPuCcEihn9SooGoUP/RXmY+kaq
         HFD+RHdpDSbyaH8H90t6qxJokc9L/vn+9xzWrhd4JOKvww3n9T06lB/OIdSvDJ613pGJ
         hhXQ==
X-Gm-Message-State: AOJu0Yz3rQgvqGq5ZxPuHx3X4cvBYyJqJ0K1szqx+lzlX9XB0Dz97J6I
	35iZuw0c2G1YAOdxobuMctQheG+BviGLuku9rrdwK7J+j4AnfmdMifWCuy6Pl5IFqAjsXQgI031
	V2miqQW8OcI9UUY1zjMiUlS0TJ98=
X-Gm-Gg: ASbGncuZUHSHNfY+ubci/p3W/Z5y+Z4wwFPDmO0h0ZRpLJgdl6MImMrHPnm6SDwFCv1
	Vv733vYbYvEOTVGyoZhSwPu0a4Q6YRwbMRJ7jIPQ=
X-Google-Smtp-Source: AGHT+IHleS4JzbMe++pWvU9WGbJjsY4VZL62OTmM7x/KnhWnFRkxqdtO7IfrVtivEJEXYLKAIAtFLLveL9Y10ezjVzo=
X-Received: by 2002:ac8:5a16:0:b0:467:67db:ef7a with SMTP id
 d75a77b69052e-46c71083cddmr527130471cf.44.1737057730322; Thu, 16 Jan 2025
 12:02:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218222630.99920-1-joannelkoong@gmail.com>
 <CAJnrk1YNtqrzxxEQZuQokMBU42owXGGKStfgZ-3jarm3gEjWQw@mail.gmail.com> <CAJfpegus1xAEABGnCgJN2CUF6L6=k1zHZ6eEAf8JqbwRdAJAMw@mail.gmail.com>
In-Reply-To: <CAJfpegus1xAEABGnCgJN2CUF6L6=k1zHZ6eEAf8JqbwRdAJAMw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 16 Jan 2025 12:01:59 -0800
X-Gm-Features: AbW1kvbs5o0h3aYi6d0rl2a-bkbUKu9iqeH17LoG1k-VuPj72fd3s_UUcnoJBGc
Message-ID: <CAJnrk1a1QCNhNxNX5sA63GV8EDCO7aZQ+DDG-R50yx-+Xs3vmA@mail.gmail.com>
Subject: Re: [PATCH v11 0/2] fuse: add kernel-enforced request timeout option
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, etmartin4313@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 4:11=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 15 Jan 2025 at 20:41, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > Miklos, is this patchset acceptable for your tree?
>
> Looks good generally.
>
> I wonder why you chose to use a mount option instead of an FUSE_INIT para=
m?

I think it was because I had wanted to cover the case where the init
request itself times out.

Maybe that's overkill and not worth worrying about. Interface wise, I
definitely prefer passing it through init as that's much simpler for
users than having to snprintf it to fuse_opt.

I'll push out v12 and change this to go through FUSE_INIT instead of
as a mount option.

Thanks,
Joanne

>
> Nowadays the new mount API allows feature negotiation (i.e. it's
> possible to check whether an option is supported by the kernel or
> not), just like FUSE_INIT, so the two interfaces are more or less
> equivalent.  But we've not added mount options to fuse for a long
> time...

I

>
> Thanks,
> Miklos

