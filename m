Return-Path: <linux-fsdevel+bounces-25821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99279950E3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CD02840C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 21:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31231A76CC;
	Tue, 13 Aug 2024 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vshsCTUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13C11A707A
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582796; cv=none; b=RozQswFhRMwmEO35rrXREKZK1MlNDp5lMMtwmqvnk5PgK6gZE+qaP4OKYFYFIpK4fgtEZHfjpuk2Y0dgrGp4ab3+DlZy9tnRz5PZo/Cq3k5A240yoz8CUtcV7ZzwO7ka4h7peUDXZ+bcY5TriZ+R++DnN5A3r5yPo4L7TVKBojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582796; c=relaxed/simple;
	bh=hlBe3bO5nqL/9JxUsPJ41ih8e91oO5SDAycqip8w3t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/rjdKgPhq7V7wygLhcQZB7560PA6gZ6ySqBu5R+BPtbSTZiTRLW6nrAic0OEGTnXa5MZ8tZePE8YzFk0UP3YYdsRYZQrGQAjQcqJYgUthKivdnBBCZC8UMjpzujQ2Il13wgwnRmM6Owrq0QbXlNf64IDZzN++3uf0RGoYPpsu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vshsCTUu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd657c9199so10575ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723582794; x=1724187594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhgGYVMx+jW9NS5avNe3UcbWXP3uzGmp3M9nSD5W+Bo=;
        b=vshsCTUuNNTZL2oqksGKcyE19bjvuZRnBweL8t6iC2HOt88hS5++QZ3fxDxME+nF5d
         xVWcAlSt+0dtb64fUT/EXa6kZkRy9STOC9ITpu+5f3iTYx1hSAfABAKfshQAn4+kj6j9
         2umV+ES7ZYtp5AzSM8a1I3t/F/VFcDhOhC5hScwAn3N8WSgo5YRyG3FUGbH+OhidqvKg
         AMoFTSus2uAivEhqEfsudgcytpJQKn4w/U3fk8jSxAU48eEzoSM38wjHzbI+LtlCjiBG
         z0T+hUCuS2Wbf1bib/sYJv5OZ14Mod95q0EaXDZSoOWO17yc92Pay/hDs561h0q3Jowh
         MeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723582794; x=1724187594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhgGYVMx+jW9NS5avNe3UcbWXP3uzGmp3M9nSD5W+Bo=;
        b=ZXKFAnMbgD4isiGXfFXdqSc3qbjJtiHl4G1GfknQrqtFoNQ5tBo1RTbP6p6+3ZGEbr
         pshvQCxefcdZxV2AzKNHoAkj+2L9HN2aUUpDRriol8/SXOy77lvwb3hfS8OIXndywq/x
         t75mdz6WObBTFU9GHfBjf77ZWz67LxFhjahqNiDIfOZvV8ELFV3NcBWonf0OnvZNntlm
         SjvGU87uLK6pVhcoITydM9d0QPBqXREQymIP8oS/f46B8yo04gDxSvCz2ZYCQ6u6PcUS
         l9hM5xnm8W5ivXdXleg1FY4+c832FWtAIiYW7eyWkZ5LI2aLmAMli4JUcb/0Cu+IIOYj
         6Tyw==
X-Forwarded-Encrypted: i=1; AJvYcCUZLod4sbxysCcSNe/3mlKx04wkNpezAG58QIGga6rUibViS2GaihEzLeolTGwkhGeik+56FOBHEqXOyNJ6usXoSfiTmPRnpWyn00Hj4w==
X-Gm-Message-State: AOJu0YzfAuMu8UfyLnJBwERxYRzLZuoHxWs5LTm+qqRyVFAFLasOqh5U
	pkaDgqohex4eRqqcVp6AXz1ffX0rqdO7h7Koj2+T6CIqHjSqv4lcyH4qaz9rKu88S1Iy6evmq/y
	BcLV+NBoLXksAXS9gukWJRI1rwgut4AvNPtbK
X-Google-Smtp-Source: AGHT+IE7evxZcY5Q1trGPNN8QB7kOuoEiJu2YVj+e1IaKF5gw6xisj04CQzafN0peuVm9S/Q8W+/NmStPFUsjWgQGzQ=
X-Received: by 2002:a17:902:c949:b0:1fd:d0c0:1a69 with SMTP id
 d9443c01a7336-201d9261633mr66975ad.9.1723582793740; Tue, 13 Aug 2024 13:59:53
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813002932.3373935-1-andrii@kernel.org> <20240813002932.3373935-2-andrii@kernel.org>
In-Reply-To: <20240813002932.3373935-2-andrii@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Aug 2024 22:59:14 +0200
Message-ID: <CAG48ez1oUas3ZMsDdJSxbZoFK0xfsLFiEZjJmOryzkURPPBeBA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 01/10] lib/buildid: harden build ID parsing logic
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 2:29=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
> Harden build ID parsing logic, adding explicit READ_ONCE() where it's
> important to have a consistent value read and validated just once.
>
> Also, as pointed out by Andi Kleen, we need to make sure that entire ELF
> note is within a page bounds, so move the overflow check up and add an
> extra note_size boundaries validation.
>
> Fixes tag below points to the code that moved this code into
> lib/buildid.c, and then subsequently was used in perf subsystem, making
> this code exposed to perf_event_open() users in v5.12+.

Sorry, I missed some things in previous review rounds:

[...]
> @@ -18,31 +18,37 @@ static int parse_build_id_buf(unsigned char *build_id=
,
[...]
>                 if (nhdr->n_type =3D=3D BUILD_ID &&
> -                   nhdr->n_namesz =3D=3D sizeof("GNU") &&
> -                   !strcmp((char *)(nhdr + 1), "GNU") &&
> -                   nhdr->n_descsz > 0 &&
> -                   nhdr->n_descsz <=3D BUILD_ID_SIZE_MAX) {
> -                       memcpy(build_id,
> -                              note_start + note_offs +
> -                              ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhd=
r),
> -                              nhdr->n_descsz);
> -                       memset(build_id + nhdr->n_descsz, 0,
> -                              BUILD_ID_SIZE_MAX - nhdr->n_descsz);
> +                   name_sz =3D=3D note_name_sz &&
> +                   strcmp((char *)(nhdr + 1), note_name) =3D=3D 0 &&

Please change this to something like "memcmp((char *)(nhdr + 1),
note_name, note_name_sz) =3D=3D 0" to ensure that we can't run off the end
of the page if there are no null bytes in the rest of the page.

[...]
> @@ -90,8 +97,8 @@ static int get_build_id_32(const void *page_addr, unsig=
ned char *build_id,
>         for (i =3D 0; i < ehdr->e_phnum; ++i) {

Please change this to "for (i =3D 0; i < phnum; ++i) {" like in the
64-bit version.

With these two changes applied:

Reviewed-by: Jann Horn <jannh@google.com>

