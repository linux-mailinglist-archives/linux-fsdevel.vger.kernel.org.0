Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95AB421CF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfEQR6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 13:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbfEQR6n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 13:58:43 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3396216FD;
        Fri, 17 May 2019 17:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558115922;
        bh=6wuDO6C2j5ISFUHqCZvEZgXgmSk5Y1yp2LQuMtU2X3c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sDtAwiFiKEC7wD2Ufzw/udB7/5BWIyScyUaJXH5U6VCsDwlqQoDM/P4m+X1+94VzN
         UMN8BtoINRqIUVkug6vKVri3xHvdA3/CbFFhbNpR4pZcBbxJrTK6xZUmI6Dk+l/a4V
         1dq1lsjIu2TctOk9kzXv+Q2ILY/h6f897iZjhR+M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190514221711.248228-5-brendanhiggins@google.com>
References: <20190514221711.248228-1-brendanhiggins@google.com> <20190514221711.248228-5-brendanhiggins@google.com>
Subject: Re: [PATCH v4 04/18] kunit: test: add kunit_stream a std::stream like logger
From:   Stephen Boyd <sboyd@kernel.org>
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
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date:   Fri, 17 May 2019 10:58:41 -0700
Message-Id: <20190517175841.F3396216FD@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-05-14 15:16:57)
> diff --git a/kunit/kunit-stream.c b/kunit/kunit-stream.c
> new file mode 100644
> index 0000000000000..1884f1b550888
> --- /dev/null
> +++ b/kunit/kunit-stream.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * C++ stream style string formatter and printer used in KUnit for outpu=
tting
> + * KUnit messages.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <kunit/kunit-stream.h>
> +#include <kunit/string-stream.h>
> +
> +static const char *kunit_stream_get_level(struct kunit_stream *this)
> +{
> +       unsigned long flags;
> +       const char *level;
> +
> +       spin_lock_irqsave(&this->lock, flags);
> +       level =3D this->level;
> +       spin_unlock_irqrestore(&this->lock, flags);
> +
> +       return level;

Please remove this whole function and inline it to the one call-site.

> +}
> +
> +void kunit_stream_set_level(struct kunit_stream *this, const char *level)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&this->lock, flags);
> +       this->level =3D level;
> +       spin_unlock_irqrestore(&this->lock, flags);

I don't get the locking here. What are we protecting against? Are tests
running in parallel using the same kunit_stream? If so, why is the level
changeable in one call and then adding strings is done in a different
function call? It would make sense to combine the level setting and
string adding so that it's one atomic operation if it's truly a parallel
operation, or remove the locking entirely.

> +}
> +
> +void kunit_stream_add(struct kunit_stream *this, const char *fmt, ...)
> +{
> +       va_list args;
> +       struct string_stream *stream =3D this->internal_stream;
> +
> +       va_start(args, fmt);
> +
> +       if (string_stream_vadd(stream, fmt, args) < 0)
> +               kunit_err(this->test, "Failed to allocate fragment: %s\n"=
, fmt);
> +
> +       va_end(args);
> +}
> +
> +void kunit_stream_append(struct kunit_stream *this,
> +                               struct kunit_stream *other)
> +{
> +       struct string_stream *other_stream =3D other->internal_stream;
> +       const char *other_content;
> +
> +       other_content =3D string_stream_get_string(other_stream);
> +
> +       if (!other_content) {
> +               kunit_err(this->test,
> +                         "Failed to get string from second argument for =
appending.\n");
> +               return;
> +       }
> +
> +       kunit_stream_add(this, other_content);
> +}
> +
> +void kunit_stream_clear(struct kunit_stream *this)
> +{
> +       string_stream_clear(this->internal_stream);
> +}
> +
> +void kunit_stream_commit(struct kunit_stream *this)

Should this be rather called kunit_stream_flush()?

> +{
> +       struct string_stream *stream =3D this->internal_stream;
> +       struct string_stream_fragment *fragment;
> +       const char *level;
> +       char *buf;
> +
> +       level =3D kunit_stream_get_level(this);
> +       if (!level) {
> +               kunit_err(this->test,
> +                         "Stream was committed without a specified log l=
evel.\n");

Drop the full-stop?

> +               level =3D KERN_ERR;
> +               kunit_stream_set_level(this, level);
> +       }
> +
> +       buf =3D string_stream_get_string(stream);
> +       if (!buf) {
> +               kunit_err(this->test,

Can you grow a local variable for 'this->test'? It's used many times.

Also, 'this' is not very kernel idiomatic. We usually name variables by
their type instead of 'this' which is a keyword in other languages.
Perhaps it could be named 'kstream'?

> +                        "Could not allocate buffer, dumping stream:\n");
> +               list_for_each_entry(fragment, &stream->fragments, node) {
> +                       kunit_err(this->test, fragment->fragment);
> +               }
> +               kunit_err(this->test, "\n");
> +               goto cleanup;
> +       }
> +
> +       kunit_printk(level, this->test, buf);
> +       kfree(buf);
> +
> +cleanup:
> +       kunit_stream_clear(this);
> +}
> +
> +static int kunit_stream_init(struct kunit_resource *res, void *context)
> +{
> +       struct kunit *test =3D context;
> +       struct kunit_stream *stream;
> +
> +       stream =3D kzalloc(sizeof(*stream), GFP_KERNEL);

Of course, here it's called 'stream', so maybe it should be 'kstream'
here too.

> +       if (!stream)
> +               return -ENOMEM;
> +
> +       res->allocation =3D stream;
> +       stream->test =3D test;
> +       spin_lock_init(&stream->lock);
> +       stream->internal_stream =3D new_string_stream();

Can new_string_stream() be renamed to alloc_string_stream()? Sorry, I
just see so much C++ isms in here it's hard to read from the kernel
developer perspective.

> +
> +       if (!stream->internal_stream) {

Nitpick: Please join this to the "allocation" event above instead of
keeping it separated.

> +               kfree(stream);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static void kunit_stream_free(struct kunit_resource *res)
> +{
> +       struct kunit_stream *stream =3D res->allocation;
> +
> +       if (!string_stream_is_empty(stream->internal_stream)) {
> +               kunit_err(stream->test,
> +                        "End of test case reached with uncommitted strea=
m entries.\n");
> +               kunit_stream_commit(stream);
> +       }
> +
> +       destroy_string_stream(stream->internal_stream);
> +       kfree(stream);
> +}
> +
> +struct kunit_stream *kunit_new_stream(struct kunit *test)
> +{
> +       struct kunit_resource *res;
> +
> +       res =3D kunit_alloc_resource(test,
> +                                  kunit_stream_init,
> +                                  kunit_stream_free,
> +                                  test);
> +
> +       if (res)
> +               return res->allocation;
> +       else
> +               return NULL;

Don't have if (...) return ...; else return ..., just return instead of
else.

