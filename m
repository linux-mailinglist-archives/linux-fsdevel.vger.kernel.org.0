Return-Path: <linux-fsdevel+bounces-25154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E42D949799
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1148F1F2333F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D11279B87;
	Tue,  6 Aug 2024 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W6ujq1Qx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D65B1FB
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969213; cv=none; b=bvz4YbwlYx0jZbaGiG66FJ39A3z5+kWYA7Xvy2RXDJc93JPRP7ZHvg7tUeOlVntncMDNkBST0zW9ATfO+In6ujcyE4U7N/G1i9EDG2jcqJPdMUQbYt2Mzm+omyUR0BivjmZ15oVQJeXEYpISbbFW9g2pjIJwsl290vSAJTFm0j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969213; c=relaxed/simple;
	bh=zasWR6zw0PGiFl5giUz4J/s3nZol4hptXlqOgdgsDiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIflNZB5yJMSrS5fwtQZan1kqrxI2xDcOsQRC7p0eczq3d90P+f96ootiUpJDSjDgjym5OYUucss56U/cYPvGBfwps0+G6UYbc3CEUiJxL4HbfX/GxxwezVE/9HDgaSJN6iYQA0fqV+f8jlwhG3YYQRDRKQ6q1HUgjWjSuYqJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W6ujq1Qx; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so15446911fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722969210; x=1723574010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ms28GEaZtsEeVLD5znVUMcSsrF85gVuP0sxo+Yw2Xgg=;
        b=W6ujq1QxGMweHUqBpOJfRpLQqQIpQN8CBF/k1l4vmPFOnv6pQjZoJuluna6AFjEZBX
         jSZGHLLlqs6n+5Pftk9Y8YJLo42cFomW9bnWm4S75Kru6GeEDz3R+pIriy7X0HLsjtGn
         y4f38xLir1iknN7vLAEEf2AqGd7GFXJmew4EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722969210; x=1723574010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ms28GEaZtsEeVLD5znVUMcSsrF85gVuP0sxo+Yw2Xgg=;
        b=B5B2b5WxhStY4/dclpT86918B1VaGW5t8lBnSjINo12EthKNNLJBkk242YL/Pxribx
         gOHQ/ZzjQA83OFCMFQauEchw2Fm1wfAyNqJYplwQcYf81N+mFQkmrooKQehoK/yXuxHG
         hKjns29zdoawe3iQWukn++ShCxzuhMDMZHDCT4k1qtzJYgSrAzFqX2yDB3inzYMgW15q
         X/VMZh0yIBIS9uJ5iu88lHDdsM1zWDbiQDHrEgSt0YZPReuUGbiI12zMVk3cBZinxRO4
         QLB538x5xmVoCHd5HLIrWvHcq2BK1VfZ5WmCBnzmteANdlgnuwJ/wucZDHLnE9AZ30cV
         gdZg==
X-Forwarded-Encrypted: i=1; AJvYcCVt+oXggSx+ezHSs/mog1nxeptw6y1WX04hx97V56djDI5EBM6MI+ntoSgIdSbqhS15UXEkm7n7ST5n4cu0fsvqOPEPRGCTLDeaZo7DPg==
X-Gm-Message-State: AOJu0Yy9Fkew+fohDrUTaKwLtL+9hrMx9702Eij48PjJdt9KFaRMYMO1
	wwDTJc9spbFjfZhu2fPYle8R0k0rMjtj4JZ8GCy0PHGAK1G/ZX8qE/+cec5lVnv5XAB50fq2nnN
	dNhI5fw==
X-Google-Smtp-Source: AGHT+IEnETeXLjPC3kRLuOvKnjDG32RbzTo/QUEBnUbW9jMG0VpUXGC9G+TFIH6Py/4dex5sh7B75Q==
X-Received: by 2002:a05:651c:210d:b0:2f1:5da7:5f14 with SMTP id 38308e7fff4ca-2f15da76073mr153215471fa.31.1722969209572;
        Tue, 06 Aug 2024 11:33:29 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e186355sm15144121fa.15.2024.08.06.11.33.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 11:33:28 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso15798291fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 11:33:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAvkQCn6fbkZGIlQR3g92HrjqFoSxri/PhA391d9gAcWx2GoeFm2kGS6aKr1E8xlZQZtxZnqxrw5PW21a2jOeiWyRtB7IVSv91J0uaew==
X-Received: by 2002:a2e:9cc9:0:b0:2ef:1c0f:a0f3 with SMTP id
 38308e7fff4ca-2f15aa88b76mr128814961fa.6.1722969208425; Tue, 06 Aug 2024
 11:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
In-Reply-To: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Aug 2024 11:33:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_P7UR6RiYmgBDQ4L-kgmmLMziGarLsx_0bUn5vYTJUw@mail.gmail.com>
Message-ID: <CAHk-=wh_P7UR6RiYmgBDQ4L-kgmmLMziGarLsx_0bUn5vYTJUw@mail.gmail.com>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
To: Brian Mak <makb@juniper.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 11:16, Brian Mak <makb@juniper.net> wrote:
>
> @@ -1253,5 +1266,8 @@ static bool dump_vma_snapshot(struct coredump_params *cprm)
>                 cprm->vma_data_size += m->dump_size;
>         }
>
> +       sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
> +               cmp_vma_size, NULL);
> +
>         return true;
>  }

Hmm. Realistically we only dump core in ELF, and the order of the
segments shouldn't matter.

But I wonder if we should do this in the ->core_dump() function
itself, in case it would have mattered for other dump formats?

IOW, instead of being at the bottom of dump_vma_snapshot(), maybe the
sorting should be at the top of elf_core_dump()?

And yes, in practice I doubt we'll ever have other dump formats, and
no, a.out isn't doing some miraculous comeback either.

But I bet you didn't test elf_fdpic_core_dump() even if I bet it (a)
works and (b) nobody cares.

So moving it to the ELF side might be conceptually the right thing to do?

(Or is there some reason it needs to be done at snapshot time that I
just didn't fully appreciate?)

           Linus

