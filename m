Return-Path: <linux-fsdevel+bounces-15126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0B988745E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 22:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933C22821B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 21:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932847FBC4;
	Fri, 22 Mar 2024 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Tq47jvbP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB4A7FBA8
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711142050; cv=none; b=eFphCKRLIfvvBi9+XgdTdWG2oZxnq8YfHjz+cT1w0a+Lh0ZewRWpce4UefKhOslnUCEPE9kdALburKDVcLbDX6vWDhnCci3v7yqk7SxXW/IS9BeyDSA78351/FskH7SnGB4jyMmFrExGoJCA4fRGQSWGhhBqJZygxiLq4g8hMoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711142050; c=relaxed/simple;
	bh=YK8oWB/5jtIhX0dRO1eYJBGTD8O4TPyHeQZLJnKitag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdXmxTfCVqbJqyiT7+mOdtOjPqiTDcpRcL716P2iYZxeGxEqGWGgd/aOmzK73g/ufE6wNOBGZwspus88pL/OV9ymVwkJAOWqT3QgOzQatSbocpKmf/aP8Cnm94TEdJF7N9Rx3BbfbQSYfbORXnH720yGvxw4vWQImF8Zs9BC3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Tq47jvbP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a473865ee3aso85530266b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1711142047; x=1711746847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KmgzYVb0qHzcH73XxTT4tk5ZPnrch6O0LrMU5dSxuQ4=;
        b=Tq47jvbPrBpg0pRpjlqi9YL/LJWBpyxn1sfm+6hBKAJuwRJMSyfsTYNK7nyVpfDq9k
         9ffDwARUo0DIPaU9m1E+ldk5tRX9AO26y6Mf1uGapXWB9au1NjHtjv7LDCJhtaQorJVf
         2cLU56jLh6CL3OICfvrQS+VaNeZZGjbFEYghc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711142047; x=1711746847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmgzYVb0qHzcH73XxTT4tk5ZPnrch6O0LrMU5dSxuQ4=;
        b=CGAuhLJZhPO7htUk4HNSqvxw7xGUfyv3Wevl+ACPC6+dpur+ithUgMcWC72gRIlm2D
         D3c3rrAb/9HgbBJqBQqr9m7U4w3lvfgMyrsEtwy9D0oERR9msFv59VSg5OASPJHp+xmd
         b1e4Phbg952++q1jWST97a/ekU3Dv8O54ZI0pEylXnQmXubdb40ugm7Pxx0N67upRAc6
         tM2A/hlO31VZgk5IVZgyzVTMM/e7NFji+sIpUxSSeLjoaNK+LTSLSFLaKhnUIN3zp71m
         3HvCJYqGyecvBEN3fLy3+8eaejzk29EOtxvVB0Vnu7+7aSFyjQScYH8BFv6iqefIVE67
         ePBg==
X-Forwarded-Encrypted: i=1; AJvYcCWUBOIrUgiaZl8ao/1CZvD/AyYOCsYQsYAPWJsyrKrhgnd/1Rhsi+LEO5rShoz80wP8qwdGZ+7tto5WajrrZ9rgW24bqhCKkvtpYpUFrQ==
X-Gm-Message-State: AOJu0YxdOVuZ6T/AVrWK3XNNgUT+E3zMeVXDoVvbgl+10co1CtJynnny
	jZ49W1BXyPm6yQqY9Zm28Yp7wSIRijukT0aXymf8i/k7FmZWsas3JGT45RTM2FoxU8FjFKOK8DI
	+wkWaRi5uN+sFHjOoyPVgiqEr+vcAcdwrvQlIbA==
X-Google-Smtp-Source: AGHT+IHKQa75GXq/U1NjxtoNfEyHGpXqUM7XHMqglu9Eh8+LxUFFMfvLnYffCDOzrMaHkijgXtHtYKVc5oxO/rNlAOA=
X-Received: by 2002:a17:907:77ce:b0:a46:d049:6de2 with SMTP id
 kz14-20020a17090777ce00b00a46d0496de2mr496828ejc.70.1711142046762; Fri, 22
 Mar 2024 14:14:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com>
 <CAJfpegu8qTARQBftZSaiif0E6dbRcbBvZvW7dQf8sf_ymoogCA@mail.gmail.com>
 <c58a8dc8-5346-4247-9a0a-8b1be286e779@redhat.com> <CAJfpegt3UCsMmxd0taOY11Uaw5U=eS1fE5dn0wZX3HF0oy8-oQ@mail.gmail.com>
 <620f68b0-4fe0-4e3e-856a-dedb4bcdf3a7@redhat.com>
In-Reply-To: <620f68b0-4fe0-4e3e-856a-dedb4bcdf3a7@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 22 Mar 2024 22:13:55 +0100
Message-ID: <CAJfpegub5Ny9kyX+dDbRwx7kd6ZdxtOeQ9RTK8n=LGGSzA9iOQ@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in fuse_copy_do
To: David Hildenbrand <david@redhat.com>
Cc: xingwei lee <xrivendell7@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, samsun1006219@gmail.com, 
	syzkaller-bugs@googlegroups.com, linux-mm <linux-mm@kvack.org>, 
	Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 22:08, David Hildenbrand <david@redhat.com> wrote:
>
> On 22.03.24 20:46, Miklos Szeredi wrote:
> > On Fri, 22 Mar 2024 at 16:41, David Hildenbrand <david@redhat.com> wrote:
> >
> >> But at least the vmsplice() just seems to work. Which is weird, because
> >> GUP-fast should not apply (page not faulted in?)
> >
> > But it is faulted in, and that indeed seems to be the root cause.
>
> secretmem mmap() won't populate the page tables. So it's not faulted in yet.
>
> When we GUP via vmsplice, GUP-fast should not find it in the page tables
> and fallback to slow GUP.
>
> There, we seem to pass check_vma_flags(), trigger faultin_page() to
> fault it in, and then find it via follow_page_mask().
>
> ... and I wonder how we manage to skip check_vma_flags(), or otherwise
> managed to GUP it.
>
> vmsplice() should, in theory, never succeed here.
>
> Weird :/
>
> > Improved repro:
> >
> > #define _GNU_SOURCE
> >
> > #include <fcntl.h>
> > #include <unistd.h>
> > #include <stdio.h>
> > #include <errno.h>
> > #include <sys/mman.h>
> > #include <sys/syscall.h>
> >
> > int main(void)
> > {
> >          int fd1, fd2;
> >          int pip[2];
> >          struct iovec iov;
> >          char *addr;
> >          int ret;
> >
> >          fd1 = syscall(__NR_memfd_secret, 0);
> >          addr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd1, 0);
> >          ftruncate(fd1, 7);
> >          addr[0] = 1; /* fault in page */

Here the page is faulted in and GUP-fast will find it.  It's not in
the kernel page table, but it is in the user page table, which is what
matter for GUP.

Thanks,
Miklos

