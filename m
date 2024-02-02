Return-Path: <linux-fsdevel+bounces-10046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0278474A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0561D1C26377
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563C21474DF;
	Fri,  2 Feb 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YDPgpbrP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEF41474D6
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891081; cv=none; b=nskOpCddt8VtBBFbSateaaKye93p4IFgHX2PVwjRYfVJDk/OkjAHlqkKWQLAZcJ84eOBjjc7srSHG77NEx/gGc5dan5rDa9nLxleJUPgvOnWeIz52MBP0OUgqcN1UXmA0Lz3+U+wirrv2MduI7T2kFKbJ5n0Ao7qiT7YQPjDTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891081; c=relaxed/simple;
	bh=OWKrqSZ7x1a/wVUnOc2GqZECW2DrOBKub+iqKARk7Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJkXLfALZH4xJvsOakG0phgfSAaCGexbxJSPRFrJeZ0Hl5FREY1EJyryyvyrYYkE6gvuNHVZ6eKZV0L6rw3R52qqegW3g4Rna46Ywtlc+7ydyP+J5H32aF/ZVDPz7pbIDWay83pp/BoGK7/YaWJPXKQroCwyG93OXtjMt/M5Oxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YDPgpbrP; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cf3a095ba6so25500751fa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 08:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706891075; x=1707495875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHbpeNpyu3wqI87Qy7h1gmd0YJLbzF1zOL2R+Rngvbk=;
        b=YDPgpbrPHpGBjCHCuZL8588PoKlBR/jCq6Lrqek00cQGIKhpvHAt/2uGqNsTi+67c7
         Wka9GLTXMOOuXBrLxT3VHljsfI6SmtlWCu41MVmUHVO4ulcXz3S53eFRcA9q6PXgZhTM
         sql0jfdM3dH0wlqmle13eUg+yNVAUN61LYUA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891075; x=1707495875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHbpeNpyu3wqI87Qy7h1gmd0YJLbzF1zOL2R+Rngvbk=;
        b=Yw8QAjdtur9abqoKvtW0dyx2Okj2/DDbbGLRmsgQXKfX4g7AmmFetPP5vP7QHPa8MF
         pMV+MH8Sz4u6XoqttE3aDOVxk7UMxksXrn2tjU1Eqy5857BDfoZ0Bgp7g7l2Z2xZ8WH9
         3K5qPUYfEfN1bCKuMBOT+oeLltGSY87C09t2OJPG+jcat+d9ie0QJ+KL7/le9gzLTjOV
         5s9NEddr3ePF+BuWHmzpDKhQ+Xa9E2LCeZkLIknSUcV0lWss8IoJQIZAyDcAxHeEM+IS
         NhhER81RNHZoXVTswGsrsndGkDDcaY5YtuFv+1G1+C0UCF1GSJGuI7YOMdXDbx1Z91kt
         p8lQ==
X-Gm-Message-State: AOJu0YydM+Kz0O5/hlaHBY/P2fmxasZu/fPsEVguYCVAQV59NYU3JYon
	oeUy0uonxTNxBzuj+0b3ILFqN3/fQlRQjDekx5x93KAiEz9+/Fq56EqV9dxPfVkSyKHut01gQFU
	Md6ct
X-Google-Smtp-Source: AGHT+IHG788c9NZgyzZFgCiUe2XMhkDytw6n2O9sj9PU+9TWkoDjyOa33dYrcGiUNBLw6MwnLxQFmA==
X-Received: by 2002:a2e:8509:0:b0:2d0:6fb5:46b with SMTP id j9-20020a2e8509000000b002d06fb5046bmr1514202lji.23.1706891075175;
        Fri, 02 Feb 2024 08:24:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVYn6DZfoGjifI0mDNb6lWUuueGEPBqtj45/kEouBUZ2r6Dtt6olIc1cYWAJRp2fz47wwgW4PJv1DzM/+GzH8uNlWljUGOmvSGouyIpSQ==
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id j13-20020a2e850d000000b002d06a4e645bsm315342lji.76.2024.02.02.08.24.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 08:24:34 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40f00adacfeso49705e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 08:24:34 -0800 (PST)
X-Received: by 2002:a05:600c:1e1c:b0:40e:f5c6:738a with SMTP id
 ay28-20020a05600c1e1c00b0040ef5c6738amr8421wmb.0.1706891073620; Fri, 02 Feb
 2024 08:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <20240202012249.GU2087318@ZenIV> <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
 <20240202030438.GV2087318@ZenIV> <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
 <20240202034925.GW2087318@ZenIV> <20240202040503.GX2087318@ZenIV>
In-Reply-To: <20240202040503.GX2087318@ZenIV>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 2 Feb 2024 08:24:17 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X93KNMF4NwQY8uh-L=1J8PrDFQYu-cqSd+KnY5+Pq+_w@mail.gmail.com>
Message-ID: <CAD=FV=X93KNMF4NwQY8uh-L=1J8PrDFQYu-cqSd+KnY5+Pq+_w@mail.gmail.com>
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, 
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 1, 2024 at 8:05=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Fri, Feb 02, 2024 at 03:49:25AM +0000, Al Viro wrote:
> > On Thu, Feb 01, 2024 at 07:15:48PM -0800, Doug Anderson wrote:
> > > >
> > > > Well, the next step would be to see which regset it is - if you
> > > > see that kind of allocation, print regset->n, regset->size and
> > > > regset->core_note_type.
> > >
> > > Of course! Here are the big ones:
> > >
> > > [   45.875574] DOUG: Allocating 279584 bytes, n=3D17474, size=3D16,
> > > core_note_type=3D1029
> >
> > 0x405, NT_ARM_SVE
> >         [REGSET_SVE] =3D { /* Scalable Vector Extension */
> >                 .core_note_type =3D NT_ARM_SVE,
> >                 .n =3D DIV_ROUND_UP(SVE_PT_SIZE(SVE_VQ_MAX, SVE_PT_REGS=
_SVE),
> >                                   SVE_VQ_BYTES),
> >                 .size =3D SVE_VQ_BYTES,
> >
> > IDGI.  Wasn't SVE up to 32 * 2Kbit, i.e. 8Kbyte max?  Any ARM folks aro=
und?
> > Sure, I understand that it's variable-sized and we want to allocate eno=
ugh
> > for the worst case, but can we really get about 280Kb there?  Context s=
witches
> > would be really unpleasant on such boxen...
>
> FWIW, this apparently intends to be "variable, up to SVE_PT_SIZE(...) byt=
es";
> no idea if SVE_PT_SIZE is the right thing to use here.

+folks from `./scripts/get_maintainer.pl -f arch/arm64/kernel/ptrace.c`

Trying to follow the macros to see where "n" comes from is a maze of
twisty little passages, all alike. Hopefully someone from the ARM
world can help tell if the value of 17474 for n here is correct or if
something is wonky.

