Return-Path: <linux-fsdevel+bounces-25134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B029495A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8AA0B25BB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECFA38DD8;
	Tue,  6 Aug 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP04S5cW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185093D0AD;
	Tue,  6 Aug 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960854; cv=none; b=oJVrmoO7cn7/4oSqPyVf3ZU3tdtgH5kU+GtTeaYtXVISgsYErM+Pqwvb/BaqrG5jNyWOJrHF9Pr9mhbHiR9giI6sTPnRvBdbKXcZgRxof7WVNW0bkm1MbFpXL2cB27kYgtlMpbdF8uoZkWB7mNp+6tALwWgvx6sIRmnFDKsG3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960854; c=relaxed/simple;
	bh=MG/gfWes2n4xcHW93nKlK63FEPiHPtfxSBniAdb0FIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3sLfKPzr9AzYRprOc6eMha11buqiGdZ2NkvLkUbIe6iwQ9Zx0Avt7MQ6woZDWr40wbr8V22+jZ+0RQwOZkFgAbg5/KKAFKUCMYklFEgYQ4pWJlHetFozhppxWT45FJtuSuvhg9ECFgg/eIT/MfNgxeHImsGei2o2xRJUhqzm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HP04S5cW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so84834666b.3;
        Tue, 06 Aug 2024 09:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722960851; x=1723565651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MG/gfWes2n4xcHW93nKlK63FEPiHPtfxSBniAdb0FIA=;
        b=HP04S5cWAuqKssz/AgBYEsqOqXqvYsri75yJsWEW24IweZTC5latZum3Lozzu9tCg/
         g2Kw7DkFZ+43IJXJw+XqZxcYJ4kINGTQ0sBE7IMC6Pn3k/jHDgCQAYFEwazcQg722SNo
         8xf7I/MoXdLNzXAlumyApCgjPLAvYjmEop7TTrqf51m9CUmsUgNNM39xggVWGKePtGPW
         buaAgoMTgFXvdhqjMFjkAT3pDDZNq2wqptDZQH3Y/bMbLVb9DjfE+Ync1kWzCJKnyBCA
         Thcylp3sqb7EGxPQobeHOeNuJxUQLR6/Rk0Nx63kXmdkbq+JBzXvTbYPqxvVEo435HUC
         xyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722960851; x=1723565651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MG/gfWes2n4xcHW93nKlK63FEPiHPtfxSBniAdb0FIA=;
        b=NE+qjapq8e1CzarYj2aACv+YvvFUusqwG9M0qnwGLUwkyOcBvDfsP2rCaAoH8+Myqd
         zifJPMD6WRABD9yX4bCr+dc1BNanRx8L0gUpwSTcHIergP6vs3QVXwGyOP9SdIqhvItM
         iOB1EsVZe8+07gWBLP3ofqCX5oHKIjpqVz6b83hhhTrqbJNkxxETvfw3/5X+CPJoAyft
         Yx/2j8e9U4EsfSEPY7GgfKsiLIxBDOPHMEEx//DYOAC++31CFnAsA1D3+RblvUzLxFPg
         Kr5hD0+D/6HnvpO/rdmxnC/juKQUe9uVd1960Mm/MiTirDcVpbwZSyLxxacUBFt7ZHxt
         5Gqg==
X-Forwarded-Encrypted: i=1; AJvYcCUB/DpC94j5hMd0z7IYpQ6wmiFUjNZki8MHtVDreYhq/UVL0Q/YO7GGAeVsXtFkls1UZEPwjAy6987nDKzub/rrR7VjBNzEO3LQKrsxAa58zv8fkql3DKu46bIyb0jpkAEr+Q==
X-Gm-Message-State: AOJu0YyL6O5zKiplE+0f1rkZuyTZYnBnJn/wpn2DEkmaGx7h+DvTGf/n
	ZT57y0tDYS6RLYp3wmHP00d53sLG5IQ9UDHs1EayVUjRiFXhvKm1oM0aMrWZa7L68cYb/ulir0K
	Cw+x0hz1sD0c7cM/Yaheiyt38se0v9Q==
X-Google-Smtp-Source: AGHT+IGJvucnXfSNd86lM60tif7RHSH9YUb3viE0bow7hAMFEK9eo1FyNnwLbf13ib1yKzJjg/zjoH5CxdobyrdqFgg=
X-Received: by 2002:adf:e78d:0:b0:369:8a8c:fd24 with SMTP id
 ffacd0b85a97d-36bbc117deemr8968638f8f.37.1722960449399; Tue, 06 Aug 2024
 09:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731110833.1834742-1-mattbobrowski@google.com>
 <20240731110833.1834742-2-mattbobrowski@google.com> <CAPhsuW69Y2+UmieROek+dP0cjYEL2x0XBVYp06yCwZtQNHS4xA@mail.gmail.com>
In-Reply-To: <CAPhsuW69Y2+UmieROek+dP0cjYEL2x0XBVYp06yCwZtQNHS4xA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Aug 2024 09:07:18 -0700
Message-ID: <CAADnVQKafwnXK=vdmgH1LjXCV0ukqVtDuTJTCX4tNrUAaigiOQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
To: Song Liu <song@kernel.org>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 6:16=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> > --- /dev/null
> > +++ b/fs/bpf_fs_kfuncs.c
> > @@ -0,0 +1,127 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 Google LLC. */
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/btf.h>
> > +#include <linux/btf_ids.h>
> > +#include <linux/dcache.h>
> > +#include <linux/err.h>
> > +#include <linux/fs.h>
> > +#include <linux/file.h>
> > +#include <linux/init.h>
> > +#include <linux/mm.h>
> > +#include <linux/path.h>
> > +#include <linux/sched.h>
>
> It appears we don't need to include all these headers. With my
> daily config, #include <linux/bpf.h> alone is sufficient.

In general it's a good idea to include necessary headers and
not rely on implicit recursive includes, but in this case the
list is indeed excessive.
I trimmed it a bit while applying.

Thanks everyone!

