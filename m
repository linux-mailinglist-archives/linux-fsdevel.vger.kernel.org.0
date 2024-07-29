Return-Path: <linux-fsdevel+bounces-24493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E1693FBDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6281F2323E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3BE15DBA5;
	Mon, 29 Jul 2024 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk7y/4lI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2E978B50;
	Mon, 29 Jul 2024 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271953; cv=none; b=S2DqAngKmZj7OG927lpvDYdhuoi98mzTdpAOsbBtHUvus+Z6sCFrqjQbzyxNRhJ1et+E2jhm4zSGjHfpRye0Eu9jP6YqgX8wlk6lYYh0olPZPRIslIO4zDPTAmswzg0L4VyYWu9maUwv9BQPZZO8pcfGj9gkSYCspMtOIDraBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271953; c=relaxed/simple;
	bh=RQT5WWRujTcAqltR+0zVcm58GG+9YxEIRL8PNIgQUSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJaOzyOxdY+uFi42mwsQslwiCzW55Z89oD4tRrAJ50NCKOz7o1OBu2lQHY2KmN3bUzsJnj0rnRf1myl4k83vwc97Eb2ZPiZzN48aXKZXgkmtTArYyUfxdLIr9Q60nxRg7BXHvB++kAVGcFz9TYLBVAvLxrhCN52bJEDWNUNck/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yk7y/4lI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cd5e3c27c5so2160766a91.3;
        Mon, 29 Jul 2024 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722271951; x=1722876751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1ho5QoGVALlGvO1PPceVK1Uz2j6z5FfEI7hQnwqjGw=;
        b=Yk7y/4lIQb129jBbiRi89A2K1OUUPd10w3Gm8IJ6dT+p89zMxbHq4e24XXunAQy99i
         bFPVu8KVNpL214+0VKMGw1PtCNzsJxnV25FLZs6O7klimZcJVCwcofyBUapcK0sNYAWi
         nSlE9Du9ejhW7XghxBgSsgxRtYaQukPMWsGzIslkFCp0z5O+Ls6+/HCh+/uITs3RMy1S
         Kv9ypddp4/fEQBw9bhpUi7g1M/tH/kzEwU8giEfQ3lk5V6aNYrfMSP/wx/1E+NQpXVAC
         rnabWkKfQJF0NtM82R3vpPltZ0e+DpJNmVEnhc6kurJZO31id+Kc/C4zQ99lgL6O9Y5r
         60ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271951; x=1722876751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1ho5QoGVALlGvO1PPceVK1Uz2j6z5FfEI7hQnwqjGw=;
        b=Ai4gMIflVGDrm4SPlwl1tZO7oesCSKleBa87T+DaCTj+IP/z3v2Hj1uJs59d78MBQZ
         iZdyyBVw9KKp2yUByUGayG2w9thYdM2t4MgO5NOFFNbo7MKfyHqD5vxQLws5PwWcu1ci
         X5hUlZZEyTylD3lGK/ibJbYTv/+75nIezdeSPaOGtIaSEBIfq2lSg9eSh3+rXMFdgskk
         dGfsWmjdfBiBSEHSnsizK5GSzJIzSnIDXWWaMARpE8+fcoTI3iwwjd6gDPYGn28Yl4Yu
         s1jVeWDcXm6F01hhmlktXF9WFydK55Y9SsWdCZN8hYcXz75gJUYdSQgw9Q5GkutGzXcR
         K11g==
X-Forwarded-Encrypted: i=1; AJvYcCUZvfB2NByVTA/KW/7CJldB7W0yE95JJn2IgLOkbdi6V8qHtfUl00ROe3vSc4nQIHvvVYl1S3zsrofo1ea4OP3oK4KAZLzCAV1iToI2Qf3aUhyWytemY1DzK7rcjgseONi7nydeEr8pKsmKReP/oGjdWa97hqZOsNca0KtnForirg==
X-Gm-Message-State: AOJu0Yzt5YvGrhSA90dpoZr71GPePqQr36P9UbM0rpXN9mYXJamHUw9o
	UgX3pnmyYzoGjYIvIidBh7QBOXvSgOkYg5iz2BGIl/zJcJVvW8CXtbc/FHY6aHWJ3mSvoEWXGsj
	kIDOrRJAm2tNo8lL+xRf+2+Kzsi8=
X-Google-Smtp-Source: AGHT+IFOQKm1kOOY1enndLUmrwVyPkPWD9zlOkNYF4MshasZERBRGWashb+a1LdHxEgXCuM3q9OHW2D9HSs6IbtHY2s=
X-Received: by 2002:a17:90a:a018:b0:2c9:359c:b0c with SMTP id
 98e67ed59e1d1-2cf7e82fdf9mr5911155a91.28.1722271951367; Mon, 29 Jul 2024
 09:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627170900.1672542-1-andrii@kernel.org> <20240627170900.1672542-4-andrii@kernel.org>
 <CAG48ez3VuVQbbCCPRudOGq8jTVkhH17qe6vv7opuCghHAAd3Zw@mail.gmail.com>
In-Reply-To: <CAG48ez3VuVQbbCCPRudOGq8jTVkhH17qe6vv7opuCghHAAd3Zw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Jul 2024 09:52:19 -0700
Message-ID: <CAEf4Bza761YA=io2p_E8qSxuOxkkKFF7=RXnK2vDUE4eUdUmBw@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] fs/procfs: add build ID fetching to PROCMAP_QUERY API
To: Jann Horn <jannh@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com, 
	rppt@kernel.org, adobriyan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 8:48=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Jun 27, 2024 at 7:08=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> > The need to get ELF build ID reliably is an important aspect when
> > dealing with profiling and stack trace symbolization, and
> > /proc/<pid>/maps textual representation doesn't help with this.
> [...]
> > @@ -539,6 +543,21 @@ static int do_procmap_query(struct proc_maps_priva=
te *priv, void __user *uarg)
> >                 }
> >         }
> >
> > +       if (karg.build_id_size) {
> > +               __u32 build_id_sz;
> > +
> > +               err =3D build_id_parse(vma, build_id_buf, &build_id_sz)=
;
> > +               if (err) {
> > +                       karg.build_id_size =3D 0;
> > +               } else {
> > +                       if (karg.build_id_size < build_id_sz) {
> > +                               err =3D -ENAMETOOLONG;
> > +                               goto out;
> > +                       }
> > +                       karg.build_id_size =3D build_id_sz;
> > +               }
> > +       }
>
> The diff doesn't have enough context lines to see it here, but the two
> closing curly braces above are another copy of exactly the same code
> block from the preceding patch. The current state in mainline looks
> like this, with two repetitions of exactly the same block:

Yeah, you are right, thanks for the heads up! Seems like a rebase
screw up which duplicated build_id logic. It doesn't have any negative
effects besides doing the same work twice (if build ID parsing is
requested), but I'll definitely will send a fix to drop the
duplication.

>
> [...]
>                 karg.dev_minor =3D 0;
>                 karg.inode =3D 0;
>         }
>
>         if (karg.build_id_size) {
>                 __u32 build_id_sz;
>
>                 err =3D build_id_parse(vma, build_id_buf, &build_id_sz);
>                 if (err) {
>                         karg.build_id_size =3D 0;
>                 } else {
>                         if (karg.build_id_size < build_id_sz) {
>                                 err =3D -ENAMETOOLONG;
>                                 goto out;
>                         }
>                         karg.build_id_size =3D build_id_sz;
>                 }
>         }
>
>         if (karg.build_id_size) {
>                 __u32 build_id_sz;
>
>                 err =3D build_id_parse(vma, build_id_buf, &build_id_sz);
>                 if (err) {
>                         karg.build_id_size =3D 0;
>                 } else {
>                         if (karg.build_id_size < build_id_sz) {
>                                 err =3D -ENAMETOOLONG;
>                                 goto out;
>                         }
>                         karg.build_id_size =3D build_id_sz;
>                 }
>         }
>
>         if (karg.vma_name_size) {
> [...]

