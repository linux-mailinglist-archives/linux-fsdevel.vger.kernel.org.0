Return-Path: <linux-fsdevel+bounces-25486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D075494C713
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 00:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5B21F236D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 22:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D9E15B0FC;
	Thu,  8 Aug 2024 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqV8OefN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482EA15B57D;
	Thu,  8 Aug 2024 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723157103; cv=none; b=cv8Cvoa4tfuQyppATTDBMUQRCQyi60CrT22N/VgHZtiy+VpGN5SJDj0iD/SyT3KFvZaYqILtWgWzNA9Amq1NWtmI262gW2JE0iYSpoYG68vHTRzYqTzYm4Ar1Cb2G7F5yFdcylLQkH/+As7Ff3pp5Bykgs4Sdazx/aFMtYA3uVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723157103; c=relaxed/simple;
	bh=FhWUv362e1r6Qcc9177WpuRorA/ylERHuvt6hwwi++w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ef9sFzh2Ze1nG3Q8kHzRvZuqqZFzo6SeM9tFM+t7MW21OsN4GsG2ni6iVVcGXe6CpM5amX6mIWncpeXukyCpxAJEVvwffDiNsNHol/hTf0t8uMgwhAcKh6ey+7Qr3I0NRlr+3vCkTGrGAkqVcu0ELxgZHEnbQIiIKtoWMiff4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqV8OefN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7d26c2297eso178445166b.2;
        Thu, 08 Aug 2024 15:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723157100; x=1723761900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZV5WCkf7CasIKV2LJxpurqw99P9KzsH3qsMPPbtVRI=;
        b=YqV8OefNgE+iNyTeO7E4mpPAkicn00h3k2Y8oiRXTgUZXsO7FuFGAEjDdsLkW0EaRR
         aXvORz9mpQYg22on4VaMV32g9bPAJDk/YxAKHzHoCjWnPD3ATSJETw2GWkcbWzlQxYW1
         hxBOLyGFFMN+9eDwHJnuMmChT7uYjqos3OKNsnEa1cBWtgZ7H6yfDH6WcwMfwRv/oWOz
         mJPNOa4JDz6PBKsbOLyVOmWO8GAEYO5qEL9fdMnvqiwSdzFkcfFMxAfdRbSnaEtYLMIc
         v42Jcf6QlmraRV6MJhsVfqP4VfeLVFLw6yworf8rZO26dXXWeEEa7HbJA+o5AsQV67O9
         6rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723157100; x=1723761900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZV5WCkf7CasIKV2LJxpurqw99P9KzsH3qsMPPbtVRI=;
        b=Q1d9zZbsKca74kiQJJVEYHY8LMseL41coU0lvtFxJLbEHpwZGpsW5MUEgkRC6AuqmC
         q8/trMMwx1zZJjVxQk1ivfGq8uU50qqd9RsIAoX4iN7YNa7cvBUT/Fgeuxh6pYt4+89u
         /UkS5nFz0WWuk26J5gRbqQ7eAc8DfpccLlb+uIPy4RB5Zm/01MREOqOtnDcOUKialClb
         dJev+sf+5YB8h/8rjRJx5UQM+4Ow8YoJnSNcj12VikjFKGMxEH7yPIVKBdLydf4nUa9I
         9xByRZPpEuTVFbEunuTv6X5aTWbVMwfsnhcQCY6WGEGYxLrStxsnk9awVynvMijdOjSx
         5ZVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBekWF05WVVw23v6uVeUVPy24b50VPUfVLaNg7jQuei713FuTQk+HeETvM0UD79BF+mrs=@vger.kernel.org, AJvYcCUpDf2p7LoQJxhaZMCqBfq0cdsLfaMv3bt9Uot7YjAlI3tbnoKEN3Lg5fU6Wn6O3gEFaUxWGQU4fQX2TRwUZg==@vger.kernel.org, AJvYcCWtE+dHvVmA4FLKddqxuuXOfULYzbCZWUnXHa730kfvmUP58riI4RB+ffGFT68bn7wcdvQauUx1@vger.kernel.org
X-Gm-Message-State: AOJu0YxCX7G7cgo5C9fVu48qcqunXvVjxCmQdX8nR/nR0/RTwpZRJP/b
	fJJad41JlPuha87KGGcBKk3hDwulhnicGZM3AVzeq2AcgSUesIzJU+qF8rQuq9hmpDuFRTx1qvc
	tFW7Ca3hVOnLUT6OzceupvZz+c0s=
X-Google-Smtp-Source: AGHT+IG/YPRxcC08HkH67Q3Vq+I5hXDvlyQUZ1pzgMt0KKq2oynlYrGf2/7uSVAo1l9iKrWNS7rEEGkGkR9WxP1kyuA=
X-Received: by 2002:a17:907:d2ce:b0:a7a:acae:340c with SMTP id
 a640c23a62f3a-a8090c23031mr243233666b.13.1723157100106; Thu, 08 Aug 2024
 15:45:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807234029.456316-1-andrii@kernel.org> <20240807234029.456316-2-andrii@kernel.org>
 <ZrVFkWQU5qpP2yUh@tassilo>
In-Reply-To: <ZrVFkWQU5qpP2yUh@tassilo>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Aug 2024 15:44:44 -0700
Message-ID: <CAEf4Bzawbs-hTzurU1pNu30=U=2V84_OsW62PiKpFS-2Ayz5KQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 01/10] lib/buildid: harden build ID parsing logic
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, osandov@osandov.com, song@kernel.org, jannh@google.com, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 3:24=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wrot=
e:
>
> > +             name_sz =3D READ_ONCE(nhdr->n_namesz);
> > +             desc_sz =3D READ_ONCE(nhdr->n_descsz);
> > +             new_offs =3D note_offs + sizeof(Elf32_Nhdr) + ALIGN(name_=
sz, 4) + ALIGN(desc_sz, 4);
>
> Don't you need to check the name_sz and desc_sz overflows separately?
>
> Otherwise name_sz could be ~0 and desc_sz small (or reversed) and the che=
ck
> below wouldn't trigger, but still bad things could happen.

Yes, both sizes are full u32, so yes, they could technically both
overflow resulting in final non-overflown new_offs. I'll switch the
additions to be done step by step.

>
>
> > +             if (new_offs <=3D note_offs /* overflow */ || new_offs > =
note_size)
> > +                     break;
>
> -Andi

