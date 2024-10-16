Return-Path: <linux-fsdevel+bounces-32154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00F29A15C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 00:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD681C21268
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 22:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A2A1D45FE;
	Wed, 16 Oct 2024 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnoyuL2t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432701D434E
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729117309; cv=none; b=KNOzDaaeGfNNOK5DnHuFEf7TEbgewxlmLpE+xji645oSaVBHjvzAF2vHBD3zqYJucWcCdmjbMkJaD2bLzd9s/f+uihXcdE6X+s+8IcH/hNyCSh/82Fr6pmTuANhKUpqlpeOSAtcV10KPipGS4u/5tUMSpXC2rUGp/8VeSqHvGwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729117309; c=relaxed/simple;
	bh=Z3ayjFJol3t+JrwPYtJyBbDwU16XxVVIKPsBEf5HWlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgDWF3Sxh/Owd1/cG6VopERvn2lFToQiLq07AYVzZwHjGif943bf1rpDJIqnj6uUnALH7vzTWY3EvCwFy18FlqxeGEVCUlbnT2/3ln8WytgEPjs0txau4EFffMAVolZvOX1SW0dispiZqyjorhQREDGPbGZGTT9s6Hca09GsyX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnoyuL2t; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so459740a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 15:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729117306; x=1729722106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brWM2G6t2emt3c4j9EVo7ifDZXhOJXvFytTyLfgg90Q=;
        b=mnoyuL2tjjd9AaxXDr82hATrE7NLmb5OJB+hrC5iGdd/7CX7mPlCKFMxtu2Oh8lGAh
         GTcr+DZ1ZnR4w05HFrYOTOOQ0dlWNhra/TgEWOmeY2V/ygSIOsr3IAUrw5agFAiofLhY
         IaWYuvvnQxrD+xlAoxNhljDEfYeDtFI1zVbwfit7wH/dJ4ajiZO4L6LSJh5kDheX9XwC
         I+gQ+Cwbt2TYrhak+AOrRaERUuUxtyLjnCwS1BYqW6MtsHYtQRqxOgBqPYaBtalVmV7Y
         K0x8XG4JOUvHZ/MasGi7VVYeYGYPu+4NnQPf/q92d5KWLmicZfpQ/1URrxcsUuaknJKR
         PHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729117306; x=1729722106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brWM2G6t2emt3c4j9EVo7ifDZXhOJXvFytTyLfgg90Q=;
        b=euy51E8frkgb1+nfmRQe4mCSdJ0O1sN48sUYjuBxyGWc5jFtgpN7HT0DznCSSvhUGb
         aF7Nepc+uZudV3Vzi/DbKrgcuagqBjxW1O+jdjcgw8ybIVBvIqAjsdmzgW2XG69TLNDq
         SpTZrY4kFalhvJ+gDWWjJPHgQOEnpS0QQpyxFaDWCzV0w8pygANSo3X+TO4W5NcDZ+Xb
         jqzZ+cXFoI5rPOkpIFU9FZVVYbTdagSxvxUP7NeYqOHAiMbsJZvWWKqs6XsW4CwK6hli
         TYVdWwakhmi3g+XobuS+Aa0sz7BO1AHm5QnfT0dKNJ1+CspEqSJu2lioRJk33gwCX9FG
         SpTg==
X-Forwarded-Encrypted: i=1; AJvYcCV2FOTjNprywZf1ICusPiYfTX0VAVkqcsxPytNFSX2quJn9TR4oZulVfAPBWFunlJWLNHp1MTzEpI3ZPaqL@vger.kernel.org
X-Gm-Message-State: AOJu0YzPlf0Y8LyJkkIWACrO6Gp+FdWgbkK8GITC+rDYdwtDF0/1N89B
	QqGwmJlBwIUWllHqaK47s76BODackqk3qRr90rxCECGLDfQPWlG/QbWSbQwNuzg1a2pKbBKQ/+u
	za9z3CfGKdjcCI3f91V1wt0/qZhjPErc98KGc
X-Google-Smtp-Source: AGHT+IF07Z3g6o1w4z/AIMrQc+IqyySmDc7fz9ahOcksvgrfvFQRgMCGsZu1SdjfEi+cXeR9yZ4s1v+3VJ01Rrmazho=
X-Received: by 2002:a17:907:7ea0:b0:a77:c95e:9b1c with SMTP id
 a640c23a62f3a-a99e3b700b8mr1638007066b.27.1729117306331; Wed, 16 Oct 2024
 15:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016221629.1043883-1-andrii@kernel.org>
In-Reply-To: <20241016221629.1043883-1-andrii@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 16 Oct 2024 15:21:08 -0700
Message-ID: <CAJD7tkZmDz5siqwSHmqck27taMHP+z_Ds2yJPXpzA6vFUOvTwQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] lib/buildid: handle memfd_secret() files in build_id_parse()
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, rppt@kernel.org, david@redhat.com, 
	shakeel.butt@linux.dev, Yi Lai <yi1.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 3:16=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> From memfd_secret(2) manpage:
>
>   The memory areas backing the file created with memfd_secret(2) are
>   visible only to the processes that have access to the file descriptor.
>   The memory region is removed from the kernel page tables and only the
>   page tables of the processes holding the file descriptor map the
>   corresponding physical memory. (Thus, the pages in the region can't be
>   accessed by the kernel itself, so that, for example, pointers to the
>   region can't be passed to system calls.)
>
> So folios backed by such secretmem files are not mapped into kernel
> address space and shouldn't be accessed, in general.
>
> To make this a bit more generic of a fix and prevent regression in the
> future for similar special mappings, do a generic check of whether the
> folio we got is mapped with kernel_page_present(), as suggested in [1].
> This will handle secretmem, and any future special cases that use
> a similar approach.
>
> Original report and repro can be found in [0].
>
>   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
>   [1] https://lore.kernel.org/bpf/CAJD7tkbpEMx-eC4A-z8Jm1ikrY_KJVjWO+mhhz=
1_fni4x+COKw@mail.gmail.com/
>
> Reported-by: Yi Lai <yi1.lai@intel.com>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abs=
traction")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  lib/buildid.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 290641d92ac1..90df64fd64c1 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -5,6 +5,7 @@
>  #include <linux/elf.h>
>  #include <linux/kernel.h>
>  #include <linux/pagemap.h>
> +#include <linux/set_memory.h>
>
>  #define BUILD_ID 3
>
> @@ -74,7 +75,9 @@ static int freader_get_folio(struct freader *r, loff_t =
file_off)
>                 filemap_invalidate_unlock_shared(r->file->f_mapping);
>         }
>
> -       if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
> +       if (IS_ERR(r->folio) ||
> +           !kernel_page_present(&r->folio->page) ||
> +           !folio_test_uptodate(r->folio)) {

Do we need a comment here about the kernel_page_present() check to
make it clear that it is handling things like secretmem?

>                 if (!IS_ERR(r->folio))
>                         folio_put(r->folio);
>                 r->folio =3D NULL;
> --
> 2.43.5
>

