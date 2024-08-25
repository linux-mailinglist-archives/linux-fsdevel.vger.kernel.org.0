Return-Path: <linux-fsdevel+bounces-27068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2081495E4ED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 21:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AAE283890
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 19:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792165473E;
	Sun, 25 Aug 2024 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmxGT41P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437033207;
	Sun, 25 Aug 2024 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724614558; cv=none; b=se0ppFz7ee31DNnZVJ9r5ginT7JH8FzuQFNML0WT2aIycQ7MEa+TL5jTxjmLEI+3AGXZFhFmjhA6VC4rL8GehTHkSo26YHurn+9jDRcm9YtXb2AnsxcDWyqRXv82xetaqcR/yYYC5ZafmGL/L+mqlc7vj8jSVvFLR79MgCLFLTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724614558; c=relaxed/simple;
	bh=/rL16dZNhfwqG9czxx8m676FTaW9Dj5RHYajQCdYwhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqg0IiPoa2nnEgw8/4gMpgluY+XAvIgYC72B6/lzOouryo093wEaOVEHPVlFZACuR/gHeQ4taMp2YoMtMb+qVVDVO2W7tcDbhaBqxwEmi3WmXPM0aDwVLKQByX3iag3+mfLLzYn2A/wfWWW00Y0L7nG2pWYk9CyejLBfxSlwLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmxGT41P; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso31249205e9.0;
        Sun, 25 Aug 2024 12:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724614555; x=1725219355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4fYJT8DmjFd+6l6gWF+nGq3GZh2Sq1k6f9Xf+Fjxl4=;
        b=LmxGT41P/e4gSWvwEnmNJlvP2eEoRUd2K738S1/yy8ALp/UxgyAk6muMx/yf3Cnted
         NRLxP5v8A8Ii9XYt4rFEYhM/Su1U5FMbhsDFInJ7Hu+waFZr6zUqJH7QdCVmI5elwZoS
         rS2Y62llZ0hYmkr14xJOYBTHB99eCbKr/XwYWupbov29JcDrC0PjN0jWa6zpaj+zOL0k
         OJEPgsaAIEadLfWGLMEEWowdJ2vI6Eno1WJlFHedeRuWG65hQFIlUVvb38+bb8eKTOii
         p5BQ+eFedffQwfCo0qRhVLsCe7joSDwlUfyjrZ1gk4qeDt8gKbwaYlIs97LAgo7kxCWN
         c/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724614555; x=1725219355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4fYJT8DmjFd+6l6gWF+nGq3GZh2Sq1k6f9Xf+Fjxl4=;
        b=wQ4suhGE+pZysTqre0Ni/GE6rDwFQ9v3WoIAZDXQhDymfETpj2BGimjKCz6QuVnYgU
         KzZum0gUNFCzsqtn8Rc5yGKkhohWgKaBWRceGvgWSW8W+hOgf/HNs2t+LqsHyOPPuiGc
         5YzW38OtHfbacAsHR/jdBnap/OZOEVcJiP0c4TbM/7ZXwmAXc824XHTODF2lfyb91CQ5
         gPcshLFpidb9bJ0k3bHhPyWnW6h1PTOYRk0IK1w7wfoxjkCoDorIu10sHIgwCpgnaGC3
         Mqy4xFN0CCoDhbyJKf+4483ew9ocLsQaPaJKGwo68NL8RdGmSPDXzBJXuIBeyMahroSz
         zSvw==
X-Forwarded-Encrypted: i=1; AJvYcCWB9OsmuoT6lItukVoFZ3AMf9jiwiSU244fxAu3cmupSL0A5ZGIBwKVFtWHp3e65mlwRRW1i1tD+qGJvwUn0w==@vger.kernel.org, AJvYcCX3Imc88k9T3/qbTUtanqkX9cT4TfpnSAvLrJdUy8fLaOZbNwjBGxnFSUKmWWldUgTvIhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNKElTKJpl5O4asZlKBHEuZUKtNPw2a7wl9NvtOJ4fujDEG09W
	ddglpAMAklJVLpFt4JYZWC6BDm1ZC11Zb6SSPiucs5ShpsZOnEIn3WmxP15n5PHqr6w3rwvNTtn
	jYIF/foZ+8fp5CmDJoex+IaVhSso=
X-Google-Smtp-Source: AGHT+IHvzjxCZw2mTuuhYMtFZiC9e77Uqjlp5fVEBcyYyq1vEc7ciikKkVKG/oHglz001SGQ5S4BKiPRRyBuAtn0gRM=
X-Received: by 2002:a05:600c:1992:b0:425:69b7:3361 with SMTP id
 5b1f17b1804b1-42acc8e121fmr61732195e9.18.1724614555024; Sun, 25 Aug 2024
 12:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814185417.1171430-1-andrii@kernel.org> <d9a46f4d54df8d5ac57011222ebdf21b0f15f52d.camel@gmail.com>
In-Reply-To: <d9a46f4d54df8d5ac57011222ebdf21b0f15f52d.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 25 Aug 2024 12:35:43 -0700
Message-ID: <CAADnVQL5GyqMfaBsAH+XxNv5n3JySVdEGTee+cY=dZGNr-t7xg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 00/10] Harden and extend ELF build ID parsing logic
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexey Dobriyan <adobriyan@gmail.com>, shakeel.butt@linux.dev, 
	Johannes Weiner <hannes@cmpxchg.org>, Andi Kleen <ak@linux.intel.com>, 
	Omar Sandoval <osandov@osandov.com>, Song Liu <song@kernel.org>, Jann Horn <jannh@google.com>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 4:23=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-08-14 at 11:54 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > Andrii Nakryiko (10):
> >   lib/buildid: harden build ID parsing logic
> >   lib/buildid: add single folio-based file reader abstraction
> >   lib/buildid: take into account e_phoff when fetching program headers
> >   lib/buildid: remove single-page limit for PHDR search
> >   lib/buildid: rename build_id_parse() into build_id_parse_nofault()
> >   lib/buildid: implement sleepable build_id_parse() API
> >   lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
>
> Never worked with lib/buildid before, so not sure how valuable my input i=
s.
> Anyways:
> - I compared the resulting parser with ELF specification and available
>   documentation for buildid, all seems correct.
>   (with a small caveat that ELF defines Elf{32,64}_Ehdr->e_ehsize field
>    to encode actual size of the elf header, and e_phentsize
>    to encode actual size of the program header.
>    Parser uses sizeof(Elf{32,64}_{Ehdr,Phdr}) instead,
>    and this is how it was before, so probably does not matter).
>
> - The `freader` abstraction nicely hides away difference between
>   sleepable and non-sleepable contexts.
>   (with a caveat, that freader_get_folio() uses read_cache_folio()
>    which is documented as expecting mapping->invalidate_lock to be held.
>    I assume that this is true for vma's passed to build_id_parse(), right=
?)
>
> For what it's worth, full patch-set looks good to me.
>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

Thank you for the review.
The patch set looks good to me as well, but I think it needs
a bit more Acks to land it through bpf-next.


Andrew,

since lib/ is under your supervision, please review and hopefully ack.


Matthew,

since you commented on the previous version pls double check
that patch 2 plus patch 6 make the right use of folio apis.

