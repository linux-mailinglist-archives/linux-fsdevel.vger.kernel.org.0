Return-Path: <linux-fsdevel+bounces-56086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1871CB12BAF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 19:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192331C239D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 17:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A567288C08;
	Sat, 26 Jul 2025 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JxZTQY2d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814561F4CAE
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753552277; cv=none; b=iYqD3DsMLUvA8dqwJziKLhbaWnGSZUhKiAI3VQdm9+g1Ar7LDp5Aktmk6Y64oWWT4BaodNoay5yEmvrqBuRvmZnNA4Q5SP/y4jx0tSTOAGv7GG2o43oS73ASiCHMHwbCdZ+V/+PUm0SbFjCYzKiVKvmziTEwGXf0U1sDbgXxgZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753552277; c=relaxed/simple;
	bh=DooFKyvtMrhcGsvS73nOYMGBp2dUDW7K3Uj8YSGtKyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PR+4jMlJPEEF2nRzc9v9xCHnruMhixpu+YdDMN+2HrHctoo1d9LZqgp5xC2iI/rB4okjEUUA58U2d+4QQgdPeNTUkjqGPnGtBvj7ZuGs/xi4sMpUgRUTJBWKc35MDAfIrRbnph3180CCl7/QMVtwvcf/d/NITC/qM9jLAz+KGnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JxZTQY2d; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso5316712a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753552274; x=1754157074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HSxbEUJxkP0g7ZjvYqH7NhSZ9AP/JqKw188Y1XM8KDw=;
        b=JxZTQY2dGVvTNxDlTWO1q4xwBovmYslbtYKR2xbfBs+XedmT2tJEmBU7i0k7r8fFIc
         9zRHP7hasQ7CxnKrXlPvoMDL7DugWrGfZu2gSnoJJ1RAyvDW4ssf8wIUR92EheUQCyMx
         pytGoNTVLXSuIEE+Ud29UPIRfLYR+QLfLkgbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753552274; x=1754157074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSxbEUJxkP0g7ZjvYqH7NhSZ9AP/JqKw188Y1XM8KDw=;
        b=rBGYf7b+8z/HqaxIERWPJPaBQ4THOb70hzBv5IW5Z+L4wjBEflV0nuAUOxAZyiEhu4
         pO8pDUuIzpMD5zz1ieXljNA9uoVLeIA3cQrGHCcrxbroWx1WPXG/9Wmn/NK1c1i/hTlB
         9TGVgU7qdSRNJD/betpth2dDLLQ+OySyWkIG9VsR4GHw7UZsuoSn01Auap50chnzpWzr
         ozzEbwkGEt4D98/LeWlDyqIGTIrWGNVf4FAxfvBfCRI0ELht69pmGdh1shVlxc4VEdyg
         6e42XBU4iw6rJwmRVKFIJhYkSrwoGkSFWdUJjtzyesR8NWy7jJdDzb8l/drQZoF4XKDZ
         5OEg==
X-Forwarded-Encrypted: i=1; AJvYcCVRLVZpx9ZZlOJXpqWzn2zOYN7diH2N1Oy2ekhvkQCrmU8ilgDbsAFMMaPODwu/4YlGuilBGvMZY9XlShoW@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZoqGlNKMw1FrcbVs8i0mbtU9Dnr0OE6DnnpwYSU7RegQUY6q
	myc1SZ5/2nmgHAPKvbGjSmBx0x948p6PAoJBDpnuTk5oCxC9BJEQTPyCz09gx60UeKgqWDdoGZ6
	neKR+Q44=
X-Gm-Gg: ASbGncvz8I45A3GcG+pizI33kKr7PL4pTnrgH0x0KejG7h3gcMsNkqWVNeAg7+mgeRM
	Po2Orf6+h25qlqS/h6KU6XA3sfdmLn2U40kLT1zqEp8xzc1en/z55Yvoua/Ap2kxh9wxQxuSgnj
	HjzhNWlK6a69YWsCCfziyxqkr4i8+KG+oE2BRqJ5rQItF9lnfeWupNXNDJcmDxNNpUqhEqJm4BA
	55Xpx0eHifM5DVZPppnJFS/nO5PZY/sdOpYYYUvut8GFNsJpSMjUHNBBrFrx8Wonv1EARxzIgSW
	tqvlwfAUHo2c8MnukvzCeCwRleF6nfCNcTJVbqPHOVau0U4HJ9uAhcAypFuHsoUhFaTYBhxGA0u
	Ec6NX7zIdr7cOoNSfsSb8vLhBPmo3hTLeP6wKXarjR2fJZ9nvXvD29p6VJq0kTOjrEfEdwn0x
X-Google-Smtp-Source: AGHT+IHUaqG+lGFEjjYfhjNkntkZx2MJghdxcN0vD9YZHXsA93zn43/U4RsXOfY93CDYsmBVwCLNAA==
X-Received: by 2002:a17:907:3f07:b0:ae0:b604:894c with SMTP id a640c23a62f3a-af61e532986mr726706466b.48.1753552273587;
        Sat, 26 Jul 2025 10:51:13 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358d1a85sm172614466b.60.2025.07.26.10.51.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 10:51:12 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so4575544a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 10:51:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXtAp3/VkBVRDWpADocXYYQc0pkzg+LiTWv/OI5+dfz180jFcmv4OMYL1/uLyOeP7Lr2gj79ApM9SqOoAp@vger.kernel.org
X-Received: by 2002:a05:6402:14d:b0:611:d10e:ebd7 with SMTP id
 4fb4d7f45d1cf-614f1da658amr5711204a12.19.1753552272125; Sat, 26 Jul 2025
 10:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724123612.206110-1-bhupesh@igalia.com> <20250724123612.206110-3-bhupesh@igalia.com>
 <202507241640.572BF86C70@keescook>
In-Reply-To: <202507241640.572BF86C70@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Jul 2025 10:50:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
X-Gm-Features: Ac12FXwUXdIlVLvMNocbefDF6HEUwlAESHc5g0TBeq7Fw2jKEkXsJpBWks3U_Dc
Message-ID: <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
To: Kees Cook <kees@kernel.org>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, 
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com, 
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org, 
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com, 
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

, but

On Thu, 24 Jul 2025 at 16:49, Kees Cook <kees@kernel.org> wrote:
>
> Why not switch all of these to get_task_comm()? It will correctly handle
> the size check and NUL termination.

I'd rather aim to get rid of get_task_comm() entirely.

I don't think it has ever made much sense, except in the "guarantee
NUL termination" sense, but since we have basically agreed to always
guarantee that natively in ->comm[] itself (by *never* writing non-NUL
characters to the last byte, rather than "write something, then
overwrite it") the whole concept is broken.

The alleged other reason for get_task_comm() is to get a stable
result, but since the source can be modified by users, there's no
"stable". If you get some half-way state, that *could* have been a
user just writing odd names.

So the other reason to use get_task_comm() is pretty much pointless too.

And several of the existing users are just pointless overhead, copying
the comm[] to a local copy only to print it out, and making it much
more complex than just using "%s" with tsk->comm.

End result: all get_task_comm() does now is to verify the size of the
result buffer, and that is *BAD*. We shouldn't care. If the result
buffer is smaller than the string, we should just have truncated it.
And if the buffer is bigger, we should zero-pad or not depending on
the use case.

And guess what? We *have* that function. It's called "strscpy()". It
already does the right thing, including passing in the size of a fixed
array and just dealing with it the RightWay(tm). Add '_pad()' if that
is the behavior you want, and now you *document* the fact that the
result is padded.

So I claim that get_task_comm() is bad, and we should feel bad about
ever having introduced it.

Now, the tracing code may actually care about *performance*, and what
it probably wants is that "just copy things and NUL-terminate it", but
I don't think we should use get_task_comm() for that because of all
the horrid bad history it has.

In other words, if "strscpy()" is too expensive (because it's being
careful and returns the size), I think we should look at maybe
optimizing strscpy() further. It already does word-at-a-time stuff,
but what strscpy() does *not* do is the "inline at call site for small
constant sizes".

We could inline sized_strscpy() for small constant sizes, but the real
problem is that it returns the length, and there's no way to do
"inline for small constant sizes when nobody cares about the result"
that I can think of. You can use _Generic() on the arguments, but not
on the "people don't look at the return value".

So we do probably want something for that "just copy comm to a
constant-sized array" case if people care about performance for it
(and tracing probably does), but I still think get_task_comm() has too
much baggage (and takes a size that it shouldn't take).

"get_task_array()" might be more palatable, and is certainly simple to
implement using something like

   static __always_inline void
       __cstr_array_copy(char *dst,
            const char *src, __kernel_size_t size)
   {
        memcpy(dst, src, size);
        dst[size] = 0;
   }

   #define get_task_array(a,b) \
      __cstr_array_copy(dst, src, __must_be_array(dst))

(Entirely untested, hasn't seen a compiler, is written for email, you
get the idea..).

But I think that should be a separate thing (and it should be
documented to be data-racy in the destination and *not* be the kind of
"stable NUL at the end" that strscpy and friends are.

               Linus

