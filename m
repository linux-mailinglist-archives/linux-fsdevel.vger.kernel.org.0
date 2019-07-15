Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0003869CFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 22:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbfGOUn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 16:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729505AbfGOUn6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:43:58 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E3F92145D;
        Mon, 15 Jul 2019 20:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563223436;
        bh=+IIfFnKIOjWTmwaRJEChc9l3CevcKSbzmFOtE/evOAU=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=2D/DWnjPJfNBG7NYPEoSnof8ifxB1rawCM7/CUbrnZIPW3Zi2YWorHQGF6/z75/6L
         RKAXw2zM/5nEvZ1RkvkBKTg0FcUf6B9HpAvuQUUd25YVNCdUqRP/ramxo68k4WPlMp
         cJg+sqLS8pPS0/aDekjj4QIsITQLRDIGfdmOTsao=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190712081744.87097-4-brendanhiggins@google.com>
References: <20190712081744.87097-1-brendanhiggins@google.com> <20190712081744.87097-4-brendanhiggins@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v9 03/18] kunit: test: add string_stream a std::stream like string builder
User-Agent: alot/0.8.1
Date:   Mon, 15 Jul 2019 13:43:55 -0700
Message-Id: <20190715204356.4E3F92145D@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-07-12 01:17:29)
> diff --git a/include/kunit/string-stream.h b/include/kunit/string-stream.h
> new file mode 100644
> index 0000000000000..0552a05781afe
> --- /dev/null
> +++ b/include/kunit/string-stream.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * C++ stream style string builder used in KUnit for building messages.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#ifndef _KUNIT_STRING_STREAM_H
> +#define _KUNIT_STRING_STREAM_H
> +
> +#include <linux/types.h>
> +#include <linux/spinlock.h>
> +#include <linux/kref.h>

What is this include for? I'd expect to see linux/list.h instead.

> +#include <stdarg.h>
> +
> +struct string_stream_fragment {
> +       struct list_head node;
> +       char *fragment;
> +};
> +
> +struct string_stream {
> +       size_t length;
> +       struct list_head fragments;
> +       /* length and fragments are protected by this lock */
> +       spinlock_t lock;
> +};
> +
> diff --git a/kunit/string-stream.c b/kunit/string-stream.c
> new file mode 100644
> index 0000000000000..0463a92dad74b
> --- /dev/null
> +++ b/kunit/string-stream.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * C++ stream style string builder used in KUnit for building messages.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <kunit/string-stream.h>
> +#include <kunit/test.h>
> +
> +int string_stream_vadd(struct string_stream *stream,
> +                      const char *fmt,
> +                      va_list args)
> +{
> +       struct string_stream_fragment *frag_container;
> +       int len;
> +       va_list args_for_counting;
> +       unsigned long flags;
> +
> +       /* Make a copy because `vsnprintf` could change it */
> +       va_copy(args_for_counting, args);
> +
> +       /* Need space for null byte. */
> +       len =3D vsnprintf(NULL, 0, fmt, args_for_counting) + 1;
> +
> +       va_end(args_for_counting);
> +
> +       frag_container =3D kmalloc(sizeof(*frag_container), GFP_KERNEL);

This is confusing in that it allocates with GFP_KERNEL but then grabs a
spinlock to add and remove from the fragment list. Is it ever going to
be called from a place where it can't sleep? If so, the GFP_KERNEL needs
to be changed. Otherwise, maybe a mutex would work better to protect
access to the fragment list.

I also wonder if it would be better to just have a big slop buffer of a
4K page or something so that we almost never have to allocate anything
with a string_stream and we can just rely on a reader consuming data
while writers are writing. That might work out better, but I don't quite
understand the use case for the string stream.

> +       if (!frag_container)
> +               return -ENOMEM;
> +
> +       frag_container->fragment =3D kmalloc(len, GFP_KERNEL);
> +       if (!frag_container->fragment) {
> +               kfree(frag_container);
> +               return -ENOMEM;
> +       }
> +
> +       len =3D vsnprintf(frag_container->fragment, len, fmt, args);
> +       spin_lock_irqsave(&stream->lock, flags);
> +       stream->length +=3D len;
> +       list_add_tail(&frag_container->node, &stream->fragments);
> +       spin_unlock_irqrestore(&stream->lock, flags);
> +
> +       return 0;
> +}
> +
[...]
> +
> +bool string_stream_is_empty(struct string_stream *stream)
> +{
> +       bool is_empty;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&stream->lock, flags);

I'm not sure what benefit grabbing the lock is having here. If the list
isn't empty after this is called then the race isn't resolved by
grabbing and releasing the lock. The function is returning stale data in
that case.

> +       is_empty =3D list_empty(&stream->fragments);
> +       spin_unlock_irqrestore(&stream->lock, flags);
> +
> +       return is_empty;
> +}
> +
> +static int string_stream_init(struct kunit_resource *res, void *context)
> +{
> +       struct string_stream *stream;
> +
> +       stream =3D kzalloc(sizeof(*stream), GFP_KERNEL);
> +       if (!stream)
> +               return -ENOMEM;
> +
> +       res->allocation =3D stream;
> +       INIT_LIST_HEAD(&stream->fragments);
> +       spin_lock_init(&stream->lock);
> +
> +       return 0;
> +}
> +
> +static void string_stream_free(struct kunit_resource *res)
> +{
> +       struct string_stream *stream =3D res->allocation;
> +
> +       string_stream_clear(stream);
> +       kfree(stream);
> +}
> +
> +struct string_stream *alloc_string_stream(struct kunit *test)
> +{
> +       struct kunit_resource *res;
> +
> +       res =3D kunit_alloc_resource(test,
> +                                  string_stream_init,
> +                                  string_stream_free,
> +                                  NULL);
> +
> +       if (!res)
> +               return NULL;
> +
> +       return res->allocation;

Maybe kunit_alloc_resource() should just return res->allocation, or
NULL, so that these functions can be simplified to 'return
kunit_alloc_resource()'? Does the caller ever care to do anything with
struct kunit_resource anyway?

