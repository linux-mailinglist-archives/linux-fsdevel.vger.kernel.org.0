Return-Path: <linux-fsdevel+bounces-71281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C496CBC537
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 04:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3F97301274E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 03:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE5A318140;
	Mon, 15 Dec 2025 03:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYuHwnlH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA852D595B
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765769106; cv=none; b=jLQ3EvF1mUTwue8wTrFsv8t7M8p0hNDuik8pdgdi9KlPS4UCFIKnumgItc5bLOeidfJoKXdwxgi7iWVcgSGFB3rGFma3EgRG+gWcOJLixxNayC0YCLgPNEFb3dnHuZ5RehX+R2MAmpeLJWLLq8/1+UYu0m/NIHs8Mjw7EVsGLxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765769106; c=relaxed/simple;
	bh=7JNvl31Kqw7/BtErdpYMC1Ckci85aKmIm6Yg3kUT0HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqAUYug2C4OCeYyZNuC7YNLFVl8/UxJMTXxokMplfNEMObQrSoEwj9sK8OXrKonYIOyJu+McMkxjuLYyOSkn3MixYmKXYDilFSys+Dh2aak9K5GHFYUUKBOBaIKGRVPiDcYEbk47+S/4Z1QmWgJ0/4PrvHJ/ICDQMip5nc3d8Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYuHwnlH; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4eddfb8c7f5so30705451cf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 19:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765769104; x=1766373904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JNvl31Kqw7/BtErdpYMC1Ckci85aKmIm6Yg3kUT0HA=;
        b=kYuHwnlHkp0AjnN6NTnMKN1UEcsUnhBIL+i+iGWW+U4Uj3JjFwTzFHiF/P7bYS7t9c
         v7sj3Nal97w1/4F0r3UFoXOuKfO4hqCI3JPTnsuuxi4EFdCOdfowVSMboptG5cDMpJTK
         dzC0Z4OlN+YTlGnj8Rcnh6wBOR0HlNiK2ybT0jvBrf+4xtJN8OQGQfENAYcVtxOn5QFQ
         xWncKJfuIn9RuW0p7BxsZDt3GqQDsNb9P6/PTKDXktxsilbgRwWNGeyBAypWc9TT9fKc
         A3lqnCNpIpodWgi7NyXSilpaas05LL6Pe+fLs4gCUacYmcze1ImX1Pz4MIHfb4jOcC/d
         rNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765769104; x=1766373904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7JNvl31Kqw7/BtErdpYMC1Ckci85aKmIm6Yg3kUT0HA=;
        b=lKpB/lTcslEBzyDJWv/fOmpuinaMzPbVePVG5jZNCB4H0YVPrakZjxCAhtVyh8Syf9
         Vz6Wo4lYUSzE5tg0zA1zq0Qc9PBw09yyYc/8fyGSL4NCH+cOJKfXlI4IItQajoPW3bsT
         OOdeR9xGFHUd8H7FgaOy/LeMQd245oRUz00jLOgFh8u2AUwVCSc9hKsm5x9ZEastLr3l
         SHBD82kbPzadiiTGe9X6BrrTvA/ZPxAhXSpI+Ta5iPlKVV04M/jh4gCLgqn8rAfNuL00
         0LgbqFBaF4e5VsuLzNfEz5czTWzRGLr/pnecMKGHeHX9vdo4Lbyls9e9XVQVlhNwHAAC
         pFRg==
X-Forwarded-Encrypted: i=1; AJvYcCXaRsDoroAEpxMzRLwKmxe251HDh5DWy9Z+B35NZTWdzyEAkbzdh+Ih7La8rg+z/YQt49gt9bRdG3C4xczr@vger.kernel.org
X-Gm-Message-State: AOJu0YygeeNUHz1yvtOaeIx+KK2WuraGKtna+c+6AG/PC2ArP3fSK/Lc
	KfsfnQvcekiBz0BaAXuNKHpjkkqqdqN4zmFBgmtNYcNd8r4ZAvwo2KGc28zRexZCr4FrNjCxU5+
	9GiWuNBedCjZnyu0Y0b5WHRNJdaJeqJ8=
X-Gm-Gg: AY/fxX7G6epmj+JXE34W4JqRuMzljJ6J9BsPzWgupANS6js15L4djVbn7IaXYDbdSsV
	UgFaDh7W4bBxh61/zNmAii6hFRE8QmJnxfpfYbeOriAnXm77Nkw+vLziwng/YOkYbgpEtb+MRkh
	jmO2M+YYBS9KGQ2c2GAhI36nxnuZcFZ/GlHlseDRpQyE4oycInJTmOM4Xer0pc9RQPN1dPr4wIL
	yXzzqLKbmfBQpxokdDvaFu9vuL6jvf9nPAzNYw6A4sdkYfFIy+ZSHBOKNbzuDCb0C8DHIDzPOXa
	HgE0kKsi/9WxW3F/naEIUw==
X-Google-Smtp-Source: AGHT+IHhSRvHw7Q243KfjNdvjk7Kij+G4+pbxqAeRpxPvtIb5smZb2O58dA8RbgalpKdwG5pU5FsF9ngvUUTWOeDbZI=
X-Received: by 2002:a05:622a:4a84:b0:4ed:b012:9706 with SMTP id
 d75a77b69052e-4f1d05a9332mr125199271cf.43.1765769103743; Sun, 14 Dec 2025
 19:25:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203003526.2889477-1-joannelkoong@gmail.com> <20251213091437.298874-1-safinaskar@gmail.com>
In-Reply-To: <20251213091437.298874-1-safinaskar@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 15 Dec 2025 12:24:52 +0900
X-Gm-Features: AQt7F2pUwASwzl_7FTb7HkIXXQb2v__ps0As7NY81fwHcb-4mHZnT_CnTJIplVk
Message-ID: <CAJnrk1a6gtiWFZpExWvsoC+N0O2FTeprfrMdtfzX1hi5ahHFyw@mail.gmail.com>
Subject: Re: [PATCH v1 00/30] fuse/io-uring: add kernel-managed buffer rings
 and zero-copy
To: Askar Safin <safinaskar@gmail.com>
Cc: asml.silence@gmail.com, axboe@kernel.dk, bschubert@ddn.com, 
	csander@purestorage.com, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, xiaobing.li@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 13, 2025 at 5:14=E2=80=AFPM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Joanne Koong <joannelkoong@gmail.com>:
> > This series adds buffer ring and zero-copy capabilities to fuse over io=
-uring.
>
> So this is superior modern io-uring-based zero-copy for fuse? I. e. moder=
n alternative
> to splice fuse hacks here:
> https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/fuse/dev.c#L979
> https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/fuse/dev.c#L2291
> ?
>
> If so, then may I remove that fuse splice special-casing?
>
> I assume that splice for fuse is not that fast anyway despite that specia=
l-casing
> linked above. So code linked above introduce complexity to the kernel wit=
hout
> giving any actual benefits. As opposed to truly fast modern uring interfa=
ces.
>
> Fuse is the only user of "pipe_buf_confirm" outside of fs/pipe.c and fs/s=
plice.c:
> https://elixir.bootlin.com/linux/v6.18-rc6/C/ident/pipe_buf_confirm
>
> It is the only user of "PIPE_BUF_FLAG_LRU" outside of fs/splice.c:
> https://elixir.bootlin.com/linux/v6.18-rc6/C/ident/PIPE_BUF_FLAG_LRU .
>
> It is the only user of "PIPE_BUF_FLAG_GIFT" outside of fs/splice.c:
> https://elixir.bootlin.com/linux/v6.18-rc6/C/ident/PIPE_BUF_FLAG_GIFT .
>
> It is one of the few users of "SPLICE_F_MOVE":
> https://elixir.bootlin.com/linux/v6.18-rc6/C/ident/SPLICE_F_MOVE .
>
> It is one of two callers of "pipe_buf_try_steal":
> https://elixir.bootlin.com/linux/v6.18-rc6/C/ident/pipe_buf_try_steal
> (the other is virtio-console).
>
> (Side note: Linus on pipe_buf_try_steal/SPLICE_F_GIFT: "Now, I would
> actually not disagree with removing that part. It's
> scary. But I think we don't really have any users (ok, fuse and some
> random console driver?)"
> - https://lore.kernel.org/all/CAHk-=3DwhYWEUU69nY6k4j1_EQnQDNPy4TqAMvpf1U=
A111UDdmYg@mail.gmail.com/
> )
>
> So, removing special handling of splice in fuse will lead to simplificati=
ons
> in core pipe/splice code. And I think that we need to do this, because
> splice is not fast anyway, compared to uring.
>
> Also from Linus:
> > Side note: maybe I should clarify. I have grown to pretty much hate
> > splice() over the years, just because it's been a constant source of
> > sorrow in so many ways.
> ...
> > It's just that it was never as lovely and as useful as it promised to
> > be. So I'd actually be more than happy to just say "let's decommission
> > splice entirely, just keeping the interfaces alive for backwards
> > compatibility"
> ...
> > I'd be willing to *simplify* splice() by just
> > saying "it was all a mistake", and just turning it into wrappers
> > around read/write. But those patches would have to be radical
> > simplifications, not adding yet more crud on top of the pain that is
> > splice().
> >
> > Because it will hurt performance. And I'm ok with that as long as it
> > comes with huge simplifications. What I'm *not* ok with is "I mis-used
> > splice, now I want splice to act differently, so let's make it even
> > more complicated".
> - https://lore.kernel.org/all/CAHk-=3DwgG_2cmHgZwKjydi7=3DiimyHyN8aessnbM=
9XQ9ufbaUz9g@mail.gmail.com/
> - https://lore.kernel.org/all/CAHk-=3DwjixHw6n_R5TQWW1r0a+GgFAPGw21KMj6ob=
kzr3qXXbYA@mail.gmail.com/
>
> For all these reasons, may I remove fuse splice special casing?

fuse uring is opt-in, not the default. Removing the splice
optimizations would regress performance for users who aren't using
uring, which is currently most of them.

Thanks,
Joanne

>
> --
> Askar Safin

