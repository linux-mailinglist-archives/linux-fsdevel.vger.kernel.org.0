Return-Path: <linux-fsdevel+bounces-2911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 764DD7EC838
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 17:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D70B20C07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EAB3309E;
	Wed, 15 Nov 2023 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h1/7xNMi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14F31754
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 16:12:40 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DDC19D
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 08:12:36 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso2001349a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 08:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700064755; x=1700669555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ab4jnXj8Bjx21zU5WbouPNL4gj/h303kBNvkdQgDmY=;
        b=h1/7xNMieJaAuf/jrXyUHehG13wEAiqZ5f8n7rRqeSoXwyqJpaPyqF+CWZ/Du51dXz
         CtnC9ol4Qoa7nTY0AuL3KV6vgQ/KOXXm2rSmEbhZIvpWCi0UG4/xsKK1XUBKU7d7DbZX
         OcRybgUOO5+gFWl/SjNuiPdfh+qS31MXFAvjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064755; x=1700669555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ab4jnXj8Bjx21zU5WbouPNL4gj/h303kBNvkdQgDmY=;
        b=uYdxNWqRlxHoErIkbgbRjp5QZwk7dCtuDo+CU0o0zyGi22cC6FdYQXc+l9MZi8rEwA
         qDrjr1IaJoPQ0M+yNIDIemoqtmaD0vdzBAoWoLum78hqWsZLk61nlRo3Ohx7WQsb5XKB
         CcpKe9v2I5UKPyn9UD1P1A5n0oz4u17w9I5urkXgawgHKkJndxY74h+pAcv2MCKDdroM
         8anLxgPexiPozW9afIxBHQrtc/FI8qltU1ypjvYAuKzXrMEY2f36hM0UDo1jY8NwFkNz
         Oq1GYd03E3Dp0L3rJq3asuFj2AY8cLZ9SoimPvtuiw35mWxCW4qykdGpbKSxalm4Kvck
         tftg==
X-Gm-Message-State: AOJu0YyhHfjHwwHlJRtRe8Tgo04njhG9ScYW/TCarX+Sp9xiVuQ6hoyC
	CZtbpFSIXRPzpEnSjy1OpeZnlZ0s6jUgRAVeflllm+er
X-Google-Smtp-Source: AGHT+IHqfCkUn6STel6TWMzfnKSDF/u/7Kzz3BMbObtoOZXNIEdW7L/uU4CIwHLvIIjQbgjd4PLIzA==
X-Received: by 2002:a17:906:8417:b0:9ba:8ed:ea58 with SMTP id n23-20020a170906841700b009ba08edea58mr4980961ejx.30.1700064755121;
        Wed, 15 Nov 2023 08:12:35 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id t2-20020a17090616c200b009ddaf5ebb6fsm7368375ejd.177.2023.11.15.08.12.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:12:34 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-547e7de7b6fso951754a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 08:12:34 -0800 (PST)
X-Received: by 2002:aa7:da07:0:b0:542:ff1b:6c7a with SMTP id
 r7-20020aa7da07000000b00542ff1b6c7amr5958727eds.9.1700064753769; Wed, 15 Nov
 2023 08:12:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com> <20231115154946.3933808-6-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-6-dhowells@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Nov 2023 11:12:17 -0500
X-Gmail-Original-Message-ID: <CAHk-=wgHciqm3iaq6hhtP64+Zsca6Y6z5UfzHzjfhUhA=jP0zA@mail.gmail.com>
Message-ID: <CAHk-=wgHciqm3iaq6hhtP64+Zsca6Y6z5UfzHzjfhUhA=jP0zA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] iov_iter: Create a function to prepare userspace
 VM for UBUF/IOVEC tests
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, loongarch@lists.linux.dev, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 10:50, David Howells <dhowells@redhat.com> wrote:
>
> This requires access to otherwise unexported core symbols: mm_alloc(),
> vm_area_alloc(), insert_vm_struct() arch_pick_mmap_layout() and
> anon_inode_getfile_secure(), which I've exported _GPL.
>
> [?] Would it be better if this were done in core and not in a module?

I'm not going to take this, even if it were to be sent to me through Christian.

I think the exports really show that this shouldn't be done. And yes,
doing it in core would avoid the exports, but would be even worse.

Those functions exist for setting up user space. You should be doing
this in user space.

I'm getting really fed up with the problems that ther KUnit tests
cause. We have a long history of self-inflicted pain due to "unit
testing", where it has caused stupid problems like just overflowing
the kernel stack etc.

This needs to stop. And this is where I'm putting my foot down. No
more KUnit tests that make up interfaces - or use interfaces - that
they have absolutely no place using.

From a quick look, what you were doing was checking that the patterns
you set up in user space came through ok. Dammit, what's wrong with
just using read()/write() on a pipe, or splice, or whatever. It will
test exactly the same iov_iter thing.

Kernel code should do things that can *only* be done in the kernel.
This is not it.

              Linus

