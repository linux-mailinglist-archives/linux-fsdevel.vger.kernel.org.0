Return-Path: <linux-fsdevel+bounces-65560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9EC07A11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 20:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C68E568FCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 18:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48302346E67;
	Fri, 24 Oct 2025 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmsWDbuy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24923313277
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328951; cv=none; b=Ek65TmUDkVITIoJx60jUoP5LJBH8PB3ZhdqkYDsJen35HMXvhdz8EL0a/HlH6umpWNuIVRSD7F93AmuuOMVkjybXOnDZb+0adQEBlL8j5jecH+9r9sXVmoMwWAg9q4bETxCeU6gHZY2vNDodA9DaaW/wbGq8vsvVikDXYx78Stc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328951; c=relaxed/simple;
	bh=n3U5yfkUfv5ArTf3S1cM1mT8QSeYdL4U9ZBKUWuF8pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dz+oVDjgTA0F7NUBBW4XVamLuyC6gVg9cVN/KU4zSE6P+7BTc/JC5PeCdFgAs5LuayV97IoLC7mhylyrT3EHvyVwKukjlxzcLlN8Fu0HvIZr76QF5aHAolvDMI0WfW9/fP7QCygYRB08Cx2uV6vouZMM7mz1sH/Pf8wuT88V9SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmsWDbuy; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4e886550a26so11010401cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 11:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761328949; x=1761933749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3U5yfkUfv5ArTf3S1cM1mT8QSeYdL4U9ZBKUWuF8pE=;
        b=CmsWDbuycSUrehkKy8Y7RaYC5vDfqMeIeAX0gahBFEw8fZUbV9l1ETJ+vf7Zg1ZuKJ
         jUwBktNDx9ORQGR0IawiuiTntbxsNCqVIjlZc2XOSWRxV0JtjYvueE690OrkP6bhiBhS
         Hjz+NalGfXhrqOS14AxJK7ujvSIgp0oQZVyrnjqMk4L4LsdQuCIHpBpZkE1O5UZs9vFn
         iJQKqMslHyQeRj7tEXmy62AZm3oLG0+e4Z3LehcSVoHAE91VJyF2UDKOJtUyZ/eNbtw/
         IIHD90EOM728cI5JkLeHmNSkLXLHgzPWG4DGtOddlpXagbXPW10PNQ64Q0NS8FAGsaZq
         WiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328949; x=1761933749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3U5yfkUfv5ArTf3S1cM1mT8QSeYdL4U9ZBKUWuF8pE=;
        b=ZcbtdBEnPo1FVsnjDs3C6f2CUCnNg/jtcL2u/Id8ILYQf8l+1+7Q+MXFq52OSwWg96
         9JKRi8SUuMdvBsmTlsJSl7GSpPszBbB9LmD9v03OhZG7dBMT5d8DH6LhRyWeR/ofs/ud
         eif/AIoOU4tPeOdU1/yhTJ9XfcqDRiBm1g9stzr8CKOcCSuQcVeS0zaXuZxO78Fbp5wF
         UvBqjV9WtoTe4zwLmYu6PO6EiIYBBZ6ODYZeIBdGTPXA5J92z1Ee0mBmob4sxrUO4Xal
         rXuKynWn/OmkeRfyvha47KIcwU7H23pw4lc4C3BAWNeQipKybvmaQySQfd03JzGuBLVm
         2xsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgtXUCBnQ2x7KDPoEsUeaT8jIz6Xqnc9SE9K82AddI+kRZfuYWbaXlWMUiscBl8dEWrfWa5Zd3OtDaQYHA@vger.kernel.org
X-Gm-Message-State: AOJu0YwhzWKOqZaIR2mQfqKcYk7AFtzZ4jXLrb0h3y/ipL/MUH/ryjxj
	GEPuJYV81iEh1ddkJojiRR3h9fa0sBuaw0IDUV+QWSbiuN3moPab9cuFXXgzk5MH4FVDJzZ0w6a
	vls4nM9E5SiH5NtqnHf6c9Nspla+NPcc=
X-Gm-Gg: ASbGncvKXm5HqT5DHY916XnjdWdgt/4bzYsmgalnnIy4dhHIJqZC8jTqJLacyq/YGJD
	0YfjsPx22YIRWRfHndWGMrlKVpO7sP2G2/t3HGIDv67d7jr7qXxH2GMvwx9suEqThGtr6m0VcE3
	oVkjecv0gNGkpwDVk5u3DjOFMyBGxPL+/FAarDDRwm4l6sjwxGf6FhKc6C3A/lcMYwJewCTFyla
	6pOUT3MSHPu4sqQYuyE7MCfhkEmlrcVywegayMxoVQe4b1PPhJrT/nvLC+c3y5jDWAOJ1uNd5FG
	ELtr0NFTYkwcoJg=
X-Google-Smtp-Source: AGHT+IHOYAhak2DJmJnuD81MshZ0YrIbaQ7SPeN6Q7uc6WwOQ6CGgDUFvv7kdf9d8y+cHCgwg1tX6r6GxCHpt/IRZ+0=
X-Received: by 2002:a05:622a:1114:b0:4e8:aa11:586a with SMTP id
 d75a77b69052e-4e8aa115bbfmr316544311cf.53.1761328948898; Fri, 24 Oct 2025
 11:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20251023114956epcas5p33a9384d06985dc5936fd355f1d580fb2@epcas5p3.samsung.com>
 <20251022202021.3649586-1-joannelkoong@gmail.com> <20251023114524.1052805-1-xiaobing.li@samsung.com>
In-Reply-To: <20251023114524.1052805-1-xiaobing.li@samsung.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Oct 2025 11:02:17 -0700
X-Gm-Features: AS18NWClytBndieGCtwSHdHSq8PrGe29hlx395rcvjWj57qenh9N9_zO7YEzOlQ
Message-ID: <CAJnrk1YDkZf1GNNODXemHUV1kOyqXtLtQzODiA=Ujkkc5TpfKg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] fuse io_uring: support registered buffers
To: Xiaobing Li <xiaobing.li@samsung.com>
Cc: asml.silence@gmail.com, axboe@kernel.dk, bschubert@ddn.com, 
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	joshi.k@samsung.com, kun.dou@samsung.com, peiwei.li@samsung.com, 
	xue01.he@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:17=E2=80=AFPM Xiaobing Li <xiaobing.li@samsung.c=
om> wrote:
>
> On 10/22/25 22:20, Joanne Koong wrote:
> > This adds support for daemons who preregister buffers to minimize the o=
verhead
> > of pinning/unpinning user pages and translating virtual addresses. Regi=
stered
> > buffers pay the cost once during registration then reuse the pre-pinned=
 pages,
> > which helps reduce the per-op overhead.
> >
> > This is on top of commit 211ddde0823f in the iouring tree.
>
> Do you have any test data? How does the benefit compare?
> By the way, how were the changes made to libfuse?

Hi Xiaobing,

I am going to run more rigorous benchmarks on this next week after
making the changes for v2 and will report back what I see. The
libfuse-side changes are in this branch [1].

Thanks,
Joanne

[1] https://github.com/joannekoong/libfuse/tree/registered_buffers
>
> Thanks,
> Xiaobing Li

