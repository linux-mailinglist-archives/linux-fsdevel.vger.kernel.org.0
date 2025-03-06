Return-Path: <linux-fsdevel+bounces-43377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404E7A55426
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 19:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA7917A612
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 18:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D0C278158;
	Thu,  6 Mar 2025 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KhlqDGLs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D00527810A
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284281; cv=none; b=pe7YbYjj9OPo9VKYXNuE/eRwEE8YfFKYGdIG2qWhRjl78y0cQW0wvkUIrZPGNeSeTNqu1MDwsnGr+5nT4b6iMMdKUwdK01U8kYyoU/YAkNrhXSWBuXpmXkTRS+0UYKc0tVW8lX84bGDFCTIt6tKdE43eAwOdpfWPgsk0pNNUF28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284281; c=relaxed/simple;
	bh=y5+pGGebbUWRK5H1usbDrXzuwMWW4SWe1mdJ6KkEhaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUD+QOXmcuk/DjV8pfpgKdGhD708cpRFDKx27c/yrNho199l3elKJkj7p/0CLWlCTJVXDwrU+mrPzJzyVGmTFXfRssEhIoW6NiqjVplDNd72wqqF8DdD5Xr+IZVoToaWaAmLwFaABIhNbitE8cUfqiwIsQBrxAqPQmzEv850Jwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KhlqDGLs; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso665437a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Mar 2025 10:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741284277; x=1741889077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vd2MF6jMwWmVMWwx4ZMQ8WJbC3PZ2CeCHabSL+mH+8U=;
        b=KhlqDGLsc4D+sjG1iXHME5S18JclU4+0PTBwFcU4KLqaqZgTYKYZldKwNMQdOhJYtZ
         TqZM568DFmsu6Lr11rixx8bztvNhlbJXa3v+hbb7ftbPBElbKebOdQvUQHJlqKSbu3gJ
         MBPlvty6dFIO4U0edvhvZYsPaXVhrHjEopykc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741284277; x=1741889077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vd2MF6jMwWmVMWwx4ZMQ8WJbC3PZ2CeCHabSL+mH+8U=;
        b=ULfOZbMQ9wK6Bkg2WujU9RDNXQYfR6Bmz8pOPZ4H+rE8Ck4JkJZLRWc35DTGcFe0Q4
         vSNJFDpa/kkXAqII8tr8L3Kd89Tbi1c++lbDFv+wrl4pESCbGKQaHRHypOp7x2upQJVp
         jrlplkl0duVA6FnZxBCgXVUEg3chZaeLRWs0Y1OkMgzrSJveg5GQJ8dqjzAcpLm4Cinn
         iB7wDdiB+ILXBEA+7KS4oo0/AGt5p01jKpGK6hAvTuCaZACJyHh2mrhM2fRZcfUvS170
         TlFUIb34L/jsUczWFBWUHjFaFJlsWA1oBGKRtragY+SHH5omCnxcEMd0TDpXLoeXV3pG
         NIgg==
X-Forwarded-Encrypted: i=1; AJvYcCXEPeSFWVjjtMWhUGq+c501jJpx9FE0k6wH2x4rKX8z/eY5sr1WnclQOkAPlU7FZyUzio4HqHEViLwFWANA@vger.kernel.org
X-Gm-Message-State: AOJu0YwFgIB0WN5A1TcoXmYMhqPKrEP/DiS7GXdRN5np40/ZOIOFUUhD
	2gyC7FWNCwtViEmmpBAKkfzmk2kUt2xysGjyVcxabU+Ot8gZYCdB6DBFmsVtQfkDuVmPVADH8lU
	kPkM=
X-Gm-Gg: ASbGncvH4VwNagCQ878O9EEukNADGDYhk7Sxw4/5iTxBg4CsGMxbBRcqgOUekM2umUd
	1GnwrPJAMW2lqMC/3Kzux1EmqCVc6F85mte03IHklrQMcLJfS6WDx4wMfqN4+IwqJBLapIOgl+5
	Q+ZBMv9IugxN7aGUlZX1LQtRzdIuV72BL7rbYdFcJu7FLMGkrYPynpu0t0I5pTcc05Ygh6uMduq
	2L6iyFIPCM3Fe6ba3fm3sfo0DERO3XZaZhcF/S5Ag8rqFjYd/IUighAreT8b8ZWkw7HDbMPkgY4
	QEJxpSUhgz8wsY0tpJtXX3biPxwZ36e0eK1k42aMcha9RWiyVyYaRWqrOOlZPQHSuSGNn6S1bG+
	f9wWiSNrA42mVrwd8M3Y=
X-Google-Smtp-Source: AGHT+IFlLJUKNLvONDxkHpK5PmAsom5bZXuDp9ZdLZWpLsPaIv/JuroKVvWARnv3ZLkNd9sI+ocZUg==
X-Received: by 2002:a17:907:3e13:b0:abf:6e9:3732 with SMTP id a640c23a62f3a-ac22ca6c386mr410266066b.3.1741284276952;
        Thu, 06 Mar 2025 10:04:36 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2394858a3sm133203266b.62.2025.03.06.10.04.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 10:04:35 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac0cc83e9adso440876666b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Mar 2025 10:04:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIaWzzdtPIWlSykE6jvFpWFzPhB0sbg10SD/z/ryOUYJ7dyXunyXub1nh70V0RnE5urIyOnGI7V77EYmhz@vger.kernel.org
X-Received: by 2002:a17:907:61a2:b0:ac1:e08c:6ac8 with SMTP id
 a640c23a62f3a-ac24e8a57dcmr59352966b.2.1741284274683; Thu, 06 Mar 2025
 10:04:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
 <20250306113924.20004-1-kprateek.nayak@amd.com> <20250306113924.20004-4-kprateek.nayak@amd.com>
 <20250306123245.GE19868@redhat.com> <20250306124120.GF19868@redhat.com> <39574d99-51a2-4314-989e-6331ca7c0d75@amd.com>
In-Reply-To: <39574d99-51a2-4314-989e-6331ca7c0d75@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Mar 2025 08:04:18 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg10syD6-3BwuQCCKxua3_bdK1gfjiw_DtCqNqe8zXFaA@mail.gmail.com>
X-Gm-Features: AQ5f1JoHVwZMPlgVDTPqJEc90ra_MHfbaLp-G-nJPvd2lDeghC0Pw92_liw9JP4
Message-ID: <CAHk-=wg10syD6-3BwuQCCKxua3_bdK1gfjiw_DtCqNqe8zXFaA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] treewide: pipe: Convert all references to
 pipe->{head,tail,max_usage,ring_size} to unsigned short
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Rasmus Villemoes <ravi@prevas.dk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 05:33, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> >>
> >> I dunno... but if we do this, perhaps we should
> >> s/unsigned int/pipe_index_t instead?
> >>
> >> At least this would be more grep friendly.
>
> Ack. I'll leave the typedef untouched and convert these to use
> pipe_index_t. This was an experiment so see if anything breaks with u16
> conversion just to get more testing on that scenario. As Rasmus
> mentioned, leaving the head and tail as u32 on 64bit will lead to
> better code generation.

Yes, I was going to say the same - please don't change to 'unsigned short'.

Judicious use of 'pipe_index_t' may be a good idea, but as I fixed
some issues Rasmus found, I was also looking at the generated code,
and on at least x86 where 16-bit generates extra instructions and
prefixes, it seems marginally better to treat the values as 32-bit,
and then only do the compares in 16 bits.

That only causes a few "movzwl" instructions (at load time), and then
the occasional "cmpw" (empty check) and "movw" (store) etc.

But I only did a very quick "let's look at a few cases of x86-64 also
using a 16-bit pipe_index_t".

So for testing purposes your patch looks fine, but not as something to apply.

If anything, I think we should actively try to remove as many direct
accesses to these pipe fields as humanly possible. As Oleg said, a lot
of them should just be cleaned up to use the helpers we already have.

Rasmus found a few cases of that already, like that FIONREAD case
where it was just doing a lot of open-coding of things that shouldn't
be open-coded.

I've fixed the two cases he pointed at up as obvious bugs, but it
would be good to see where else issues like this might lurk.

                 Linus

