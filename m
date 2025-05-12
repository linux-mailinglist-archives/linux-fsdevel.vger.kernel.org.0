Return-Path: <linux-fsdevel+bounces-48770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A480AB443E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 21:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2C316B989
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 19:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35A297127;
	Mon, 12 May 2025 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NifmSJ0A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A43297120
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076622; cv=none; b=DDafnUe7ZLfKXHggWvaai+ySMrJRC+o2AMKL6cH73kuU/VWTBSmLeWUmotbipnlaXz0yjHuK2lF14iK9Jvd/2ELYzhRPgLlO/c8N2dHc6amIefW00gN3oaNhzycE6ovs7mr84+QBfm5iQA6SLBHcbMcLz+w61BRUNytZ9AxCn/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076622; c=relaxed/simple;
	bh=XakVI9DzPVojkrzY8zceGjJ2COo0W8/sH0AT7UtzVhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzQfW3YMq1htL5xGodVWc7LxxrjzLrNlojDX6/LnMvGO/e7Ghudu7lxN5JPVFvhYNmDwvR3piSdCer1gf+HTJ07a2RNnj2yQJHF290E3/7qWK4zq3foUdJl7lZe8KsYP4ZjWBw2KfRXfFJiCg6GNuBKP+LxD3xQQyQgcvZQz1HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NifmSJ0A; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476a1acf61eso52225001cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 12:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747076619; x=1747681419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XakVI9DzPVojkrzY8zceGjJ2COo0W8/sH0AT7UtzVhg=;
        b=NifmSJ0AgjAT2eChFgSqb/jwvHwWDdxuehQ0+dLdtI5ffJQqTZPlzvL+MQEwKaS9rv
         JdgdJZryxq1IOc0fvOsje7KBmYZUeNN3FTVckPFcjh9xPwQBZ9QSSQ7uMhGe8mCQWg8a
         wWRHUSzsrigoyABhvoylt4OR+VtaGg43qdE7cpSKzHnNzOS2fqyZynAEyeBsDXq54Qv1
         F4tx3mFGAS/phVpyRTfujscXozLiUTmsCPnJhi6RYQr0+BK56MoL5oi2tgSevHlZFAod
         moZz771htLND5zoRFOO0k7tO94ASxFethik21T1YR0Hy0vLeTSWdTZ7vkvwtJzv7q+sQ
         qEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747076619; x=1747681419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XakVI9DzPVojkrzY8zceGjJ2COo0W8/sH0AT7UtzVhg=;
        b=HbadAbuwNuCA3p3KOjhPKUcgU3HSuaMxVQEYFTG9DtrF+f8M9+juj6Lz5TbvUbaJ1K
         UnCrGFAvUnyJU7N+bnewYwhibBdSMzF7j/FPIqWT9iL8YdEP948wrH9ck940krjyGHos
         yPr7UNrVWMvmovw95nCrIMbhRakmNIElfMdToedMlHyqUXiRpTsDMZBBQgJZiHN8pXuO
         LRM0GJF99QsGVNyA18svRlsLDdGbHpht3oiaW3MuQQXTSERZTwT5FwhyYIxjMXFWRMgK
         nouCWp5qpDvbzhiUCMvN6vmLP1qBzwirHyWA1BvpKAtVHJWHnxmKYclRUWGmLOvuJZ/D
         OGPQ==
X-Gm-Message-State: AOJu0YxQ3tUQtQUv+dTvHe6y4nt7lb01+hQT5eV5Zg2+uIkxRcHVSn+r
	TDwPQLwnXR/Bz3gRZ8KyiNrOOhGyByB5CiH2uZdyvW1QphXzv4dQbrdfl4q3MMYUZH7LYoOLw3j
	hyxwS+O+ONcIGqbK4wYt3CUzv7aJWNQ==
X-Gm-Gg: ASbGncsiGXSU0Tm3aX4U2lFKM/DsupeEkTKvtaTRWdNnKGucYLm6yJTXB0077ivlVF5
	TE9bma4LEhso5TzpTxRd8aNMK/XQo4kSeVm3Y/N/7XFEK86Us6FS01LyA6mur3m1A9VIKcTGO3b
	x/CK+8v17RvL2WcJ9EcGRTWuaONikp50y7fNxcSrOG/Omq6NKO
X-Google-Smtp-Source: AGHT+IEWXltaMeGEXg/Hj7wfyty5UeTbiur2O79HWNktQIbtEUhEqfEsCPVk7c43DfhDWp3nepT5QmZA2oDxlSk62dY=
X-Received: by 2002:a05:622a:19a0:b0:478:f736:f545 with SMTP id
 d75a77b69052e-494527fa1e2mr193985171cf.51.1747076619460; Mon, 12 May 2025
 12:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422235607.3652064-1-joannelkoong@gmail.com> <CAJfpegsc8OHkv8wQrHSxXE-5Tq8DMhNnGWVpSnpu5+z5PBghFA@mail.gmail.com>
In-Reply-To: <CAJfpegsc8OHkv8wQrHSxXE-5Tq8DMhNnGWVpSnpu5+z5PBghFA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 12 May 2025 12:03:26 -0700
X-Gm-Features: AX0GCFsaA9f953IRLAXANe_ZxlUDRgNjYahqqYFAZGSrY3JetaUZCe1imZPHndI
Message-ID: <CAJnrk1ZXBOzMB69vyhzpqZWdSmpSxRcJuirVBVmPd6ynemt_SQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use splice for reading user pages on servers
 that enable it
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	jlayton@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 7:45=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Wed, 23 Apr 2025 at 01:56, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > For servers that do not need to access pages after answering the
> > request, splice gives a non-trivial improvement in performance.
> > Benchmarks show roughly a 40% speedup.
>
> Hmm, have you looked at where this speedup comes from?
>
> Is this a real zero-copy scenario where the server just forwards the
> pages to a driver which does DMA, so that the CPU never actually
> touches the page contents?

I ran the benchmarks last month on the passthrough_ll server (from the
libfuse examples) with the actual copying out / buffer processing
removed (eg the .write_buf handler immediately returns
"fuse_reply_write(req, fuse_buf_size(in_buf));".

Thanks,
Joanne

>
> Thanks,
> Miklos

