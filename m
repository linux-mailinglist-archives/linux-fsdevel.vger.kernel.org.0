Return-Path: <linux-fsdevel+bounces-25839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9086B951076
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334741F24EF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65341ABECB;
	Tue, 13 Aug 2024 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwm2XBWt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DAA16DEA9;
	Tue, 13 Aug 2024 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723591290; cv=none; b=qU/cO2FmOVTKj8F218ye884xBdcatdGoW76Y/ewn682berLDlb20k7Lx7oTYGKIYk7rUP1jz4OIoNwSbEf3nbRQJ+ifIrJmOOyI7kIgYfiTJltRKi3M0seXJr14wxCgUiz/Cc4N4Gmt1vQth7xESnIEUJSFM+DK24W3pPQJofY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723591290; c=relaxed/simple;
	bh=I/stLCIMd0luzbDQF2GjVeVbaLukOG6+7jHACLkeuE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtoH06UUA5rZjXER2Oj97ZvWECzll6W8QRuo91cRw2x8MqADG81YmyfnfuFSwXlzjGrJmGmfyLjdq7CJ1PAB73L363OTLh902rPjATd4ffTVv4Ux5uNMrx7Shk7mHUA6O8JfHrbwM9IhGQFIoJWT3yJ8ABrK49yrFGjZ8OGtuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwm2XBWt; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7a1be7b5d70so248627a12.0;
        Tue, 13 Aug 2024 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723591288; x=1724196088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRyVpZs3XdkTAtKOIHKoJQ2IsgMagpAKPl7vl1yKGVg=;
        b=dwm2XBWtmqcSdibYB1FHyb5h16VcYPGmnm/kuJ/8psI8Q3VEw9Mdy/igReJOqIKdc8
         tS68kHiwRTOTEETzVwB6/kPgi9wibe++9sNK6jO4pmQy4CdMMsHixtTgl8PoZmAY8hiH
         q5936AO4vX8eqME1IUJBscicWf3c2jR+DHSZB4SguKrlo73bWGL5+kkaV6IIAz4uvi+1
         2JBsGc6RyT8+J/4+Yxp1hCU0K5UbG7PFUS+kk7FQOv0izcqrAQdfTz1uJ13aV2Pbv/CH
         jW5TND1bnpYvSuTx1NHfJd9BN2NH7mi4wEiAsuslYn+wRveEeQ6tzL4XpNtHPbREWm3N
         0Ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723591288; x=1724196088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRyVpZs3XdkTAtKOIHKoJQ2IsgMagpAKPl7vl1yKGVg=;
        b=Qyn67mNE345WiUreJpQBO1sZ28O7lQlj+iN536wDGu/m1YnK8fKZU+ROri2v57OAZr
         0/7XwzQXGzOE592OfsKfcmIeL6GmCoGLV6YYJTdRnBfyYB9nVM844AZcQDTVbjQBgNZA
         diV1zAN3PhNWkdNnB3MLkS2lIXxFNCVLZ/cotFkuDQlzhMkuCo4/9ABD9eSQJrkMrend
         EoE1NSgypRLx6eM559O9REIneW33sHwDLNWPpDV1og9VyHUHNg2x3dWpXkswjMh7MieV
         lOpODC8mb1ZsOe/jgkRpsVBXlru+wclPG36tGwuUqg2hog3UaxQGky4SNjcF30tVBVY3
         FBSA==
X-Forwarded-Encrypted: i=1; AJvYcCVhHmQ0rV1yfJAp1G6sxRRr9i0dp9J9iQU8ORawALJ6c2OZZb76UgFU+zbDoxvdOtMvht5216xbb+IzZxPQ51Cz0R4ruLCgps4WfYrPh3KD8h1jTqCohRnc4DRmCDd0T1mAKrsDKzS9LnQ7ObvTnYZBtZL8tGID6yhVZQ==
X-Gm-Message-State: AOJu0YwWeiTm/zRK1+JYRb3FZdUTosdo0clsNksePo2Zcn2fYmsnGO8p
	CUlb7TCfi3XeGs4XKs0TY2v+uHbFkKPdF2rgH+5MQtqaHSfYw4oGpNbYbLRCRTCu7hW7odnqcQ/
	lkYlRm5tTgaeUymNkKDgxUwyP6ws=
X-Google-Smtp-Source: AGHT+IFPgLZng5y94JxpAKfjZfHPUVopiPIVhjrWL7lyUUQAEEn+X2FVV/76vMV3lqN11qMFZg0DDadF+clCNCCF8Bo=
X-Received: by 2002:a17:90a:474c:b0:2c9:63d3:1f20 with SMTP id
 98e67ed59e1d1-2d3ace55317mr433766a91.18.1723591288215; Tue, 13 Aug 2024
 16:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813002932.3373935-1-andrii@kernel.org> <20240813002932.3373935-2-andrii@kernel.org>
 <CAG48ez1oUas3ZMsDdJSxbZoFK0xfsLFiEZjJmOryzkURPPBeBA@mail.gmail.com>
In-Reply-To: <CAG48ez1oUas3ZMsDdJSxbZoFK0xfsLFiEZjJmOryzkURPPBeBA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Aug 2024 16:21:16 -0700
Message-ID: <CAEf4BzZa9Rkm=MAOOF58K444NAfiRry2Y1DDgPYaB48x6yEdbw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 01/10] lib/buildid: harden build ID parsing logic
To: Jann Horn <jannh@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 1:59=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Aug 13, 2024 at 2:29=E2=80=AFAM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> > Harden build ID parsing logic, adding explicit READ_ONCE() where it's
> > important to have a consistent value read and validated just once.
> >
> > Also, as pointed out by Andi Kleen, we need to make sure that entire EL=
F
> > note is within a page bounds, so move the overflow check up and add an
> > extra note_size boundaries validation.
> >
> > Fixes tag below points to the code that moved this code into
> > lib/buildid.c, and then subsequently was used in perf subsystem, making
> > this code exposed to perf_event_open() users in v5.12+.
>
> Sorry, I missed some things in previous review rounds:
>
> [...]
> > @@ -18,31 +18,37 @@ static int parse_build_id_buf(unsigned char *build_=
id,
> [...]
> >                 if (nhdr->n_type =3D=3D BUILD_ID &&
> > -                   nhdr->n_namesz =3D=3D sizeof("GNU") &&
> > -                   !strcmp((char *)(nhdr + 1), "GNU") &&
> > -                   nhdr->n_descsz > 0 &&
> > -                   nhdr->n_descsz <=3D BUILD_ID_SIZE_MAX) {
> > -                       memcpy(build_id,
> > -                              note_start + note_offs +
> > -                              ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_N=
hdr),
> > -                              nhdr->n_descsz);
> > -                       memset(build_id + nhdr->n_descsz, 0,
> > -                              BUILD_ID_SIZE_MAX - nhdr->n_descsz);
> > +                   name_sz =3D=3D note_name_sz &&
> > +                   strcmp((char *)(nhdr + 1), note_name) =3D=3D 0 &&
>
> Please change this to something like "memcmp((char *)(nhdr + 1),
> note_name, note_name_sz) =3D=3D 0" to ensure that we can't run off the en=
d
> of the page if there are no null bytes in the rest of the page.

I did switch this to strncmp() at some earlier point, but then
realized that there is no point because note_name is controlled by us
and will ensure there is a zero at byte (note_name_sz - 1). So I don't
think memcmp() buys us anything.

>
> [...]
> > @@ -90,8 +97,8 @@ static int get_build_id_32(const void *page_addr, uns=
igned char *build_id,
> >         for (i =3D 0; i < ehdr->e_phnum; ++i) {
>
> Please change this to "for (i =3D 0; i < phnum; ++i) {" like in the
> 64-bit version.

This did slip through, yep. I'll check with BPF maintainers if this
can be fixed up while applying or whether I should send another
revision.

>
> With these two changes applied:
>
> Reviewed-by: Jann Horn <jannh@google.com>

