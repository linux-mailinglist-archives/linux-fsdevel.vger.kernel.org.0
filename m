Return-Path: <linux-fsdevel+bounces-28619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9F696C6D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347211F22787
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54421E1A3C;
	Wed,  4 Sep 2024 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ejW5QtKs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639205E093
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476009; cv=none; b=cGc7gN/LBY3B6wztkS3qh8brB5tL0YbA8L/v4wT/nzPnVzezKO+l6rZqdlpwF5QWiflCt7DkJgg9flOYbvkoCwwNK8P2Hgi6JMH0BfCUMlo2rpYuB/tfOaOkqL11MMzLek2Dxp2Vy80+sQaPQmKqjPJoaDUI06iCCMwsYO8Xd3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476009; c=relaxed/simple;
	bh=Xoz7yg0lPjLZ9zCrvjndzTgGkrM0nq2F8MPShpr+Ipw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OE42RbYvOKzgK4F/6xg2esMe5i3m6yUkp74eOBdAqDMXDlT/c87laeIBeaQOh5Eg9TxrsZ+onViK6Hv5yqL3ssX1DcE3lctf2TwAiVtKcV9YxsCo3Ie8eF3KdMGnQQ5zB/wR/LCfUh+fkihz/PKX+4Qtui2KYOjernhH70i5ZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ejW5QtKs; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8684c31c60so822877466b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 11:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725476005; x=1726080805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=We1YdZoqz1zXgWa47nfs+iTUp8ErAHxC3mdSZ/mbYN0=;
        b=ejW5QtKsvdvOKfKP52Fg8/y2PQuD/5rBg2z6ehFaZdWp5iSPeFqIOtP3kRzuFBKh0S
         ZC+kenZ3MhsNoeEvodMtCmFEE4bfibD6l/+J2msOyYMEkNNzAbcwoHBCuD6c1Ec294e6
         O8CJs6MeFsGIPM49sTfzHFWnCMeBll3morj8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725476005; x=1726080805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=We1YdZoqz1zXgWa47nfs+iTUp8ErAHxC3mdSZ/mbYN0=;
        b=MKKUjHsNAMwvpXuynIyCFM3kAZalg0woBRVcemBEtcnjcDKOUYUGIa6tyx+0+XAZ9T
         71hGQ46eiKjIp7i0ruchd6JeCUscplP9LdzlcoSjCVrLVlF18T3Hk6yq4jcdo7VqpMO5
         NhiX5Hr9VIqXtVSxUtSxSPATe+j50n8FpY9OXBP9Hv0UMU/+7OWEZc+PuhvAQtcvctPq
         fyobLMRdOye77I2oTLzkvXpwwMdjXyB/yR0pSFd24JNJFhmQU5pw5Y8DvSmo/TkYEyxr
         fpKu0h4x7ryx7Usc+tq1JIl9dQr35Z8261GCFa4zCWA0r07Zg5zgB0xaN5YtRps/LfGy
         H3oA==
X-Forwarded-Encrypted: i=1; AJvYcCXeT4p2td0OKEV+B0n31M0n8UY5l2UBIiFZ5D3SeeoGq/IBHbNlCIOZTrG2sYbFNVdxHYs5TgtPKQZDHNec@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxwkzl0aSWHhyTU4yJNdP+BHOTYkYCfVVMPCSu6YJUeYZ1dTNF
	NyiS4294LnQoLpM/yZGTr2uxUVC27WEb1OFFI6Hxvh0Dpd02hNtNTLHYERNm3ghWmmfC9LeyQms
	bT3Br5g==
X-Google-Smtp-Source: AGHT+IEQFR+2EufI8m4uoUhEHup/y+EXCKTYBVFShAd0NaCIDB6/rJeyWxRyazO7k+JLySrTvgFhdA==
X-Received: by 2002:a17:907:7256:b0:a7a:a30b:7b93 with SMTP id a640c23a62f3a-a897f77eed8mr1809875366b.2.1725476004110;
        Wed, 04 Sep 2024 11:53:24 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a63bdsm23668166b.155.2024.09.04.11.53.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 11:53:23 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86a37208b2so845329866b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 11:53:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzD7L50BskF8qnL9e7RSCIjfARIzmBjNkdjMIrT7TpbjgOcLt+jIJUkkMdA298cCAoLhtVdKGCQsmXxHh6@vger.kernel.org
X-Received: by 2002:a17:907:e92:b0:a86:81b8:543f with SMTP id
 a640c23a62f3a-a897fad6921mr1415500366b.64.1725476002634; Wed, 04 Sep 2024
 11:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>
 <Zth5wHtDkX78gl1l@kernel.org> <9303896a-e3c8-4dc3-926b-c7e8fc75cf6b@suse.cz>
 <ZtiH7UNQ7Rnftr0o@kernel.org> <3ade6827-701d-4b50-b9bd-96c60ba38658@suse.cz> <20240904-kauffreudig-bauch-c2890b265e7e@brauner>
In-Reply-To: <20240904-kauffreudig-bauch-c2890b265e7e@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Sep 2024 11:53:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=TVyNzdCvp2rzmR3_1ijMaT4fGtH68owiU5Zo-_7XaQ@mail.gmail.com>
Message-ID: <CAHk-=wh=TVyNzdCvp2rzmR3_1ijMaT4fGtH68owiU5Zo-_7XaQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] slab: add struct kmem_cache_args
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Sept 2024 at 11:21, Christian Brauner <brauner@kernel.org> wrote:
>
> Sure. So can you fold your suggestion above and the small diff below
> into the translation layer patch?

Please don't.

This seems horrible. First you have a _Generic() macro that turns NULL
into the same function that a proper __kmem_cache_create_args() with a
real argument uses, and then you make that function check for NULL and
turn it into something else.

That seems *entirely* pointless.

I think the right model is to either

 (a) not allow a NULL pointer at all (ie not have a _Generic() case
for 'void *') and just error for that behavior

OR

 (b) make a NULL pointer explicitly go to some other function than the
one that gets a proper pointer

but not this "do extra work in the function to make it accept the NULL
we shunted to it".

IOW, something like this:

  #define kmem_cache_create(__name, __object_size, __args, ...)           \
       _Generic((__args),                                              \
               struct kmem_cache_args *: __kmem_cache_create_args,     \
               void *: __kmem_cache_default_args,                       \
              default: __kmem_cache_create)(__name, __object_size,
__args, __VA_ARGS__)

and then we have

 static inline struct kmem_cache *__kmem_cache_default_args(const char *name,
                                           unsigned int object_size,
                                           struct kmem_cache_args *args,
                                           slab_flags_t flags)
  { WARN_ON_ONCE(args); // It had *better* be NULL, not some random 'void *'
     return __kmem_cache_create_args(name, size, &kmem_args, flags); }

which basically just does a "turn NULL into &kmem_args" thing.

Notice how that does *not* add some odd NULL pointer check to the main
path (and the WARN_ON_ONCE() check should be compiled away for any
actual constant NULL argument, which is the only valid reason to have
that 'void *' anyway).

                     Linus

