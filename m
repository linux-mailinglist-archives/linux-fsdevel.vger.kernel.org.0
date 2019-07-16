Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A4B6A35B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 09:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfGPH5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 03:57:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33708 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfGPH5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 03:57:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so8715210pfq.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2019 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hj/eyxtCjevB1+PnZR+txqFBPeZmBpgwE/GtSSJfKak=;
        b=C4HP24IR8lBSiExf/3eblNnl51w3i/GXv6g0d/Ej5rPsntQ1UQeR7zznUPtv769PDQ
         2XbzVujWNejHQFDRm+ISE10iEvh4oahTqWvJvqDwJgUouIsH+npmqd/ytHwkc89ZlKlz
         GZ8KAQLfSaOhylWQtFw5Qk5ORxuKjnto8l6AK0EoSTMhLJSgcAUsidGBSw3tIFAL7Nlu
         Eq0EOGx4ArvrOKXmHmXkdsxURjUiyC7FqwB1cHlSJi7BonYJfZBHkWrKYRMOOX8Seysz
         GxaRriJmb72xSK0w4Ta+k66Q5WGyM5EDDsfYjuU9UMlvilAzPNioXLTXa6bDoCBKjvlx
         T3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hj/eyxtCjevB1+PnZR+txqFBPeZmBpgwE/GtSSJfKak=;
        b=oGch6slE4TmSj3Bko1VzcP6UcNRCs5xNCxCZHM90BXOOXFSJBtGAvaX8a1bBOGx31c
         ezgKnCsH5PkBsUjojUqJpjSZ2tZzdpNbOkUPxfjJx/F5FuvwO4cGfFP0Ap0r1AOPA+GC
         pkLqdeXIFi56Sk7t/dFesZqSZeLXuzB8eZL8K1Z9oxIlRqKX6UVcil02XHIASCCZaFv1
         V8En5wBqbuEF9Tlf8zuWtn+gJo23Q6tAYSyeelu6so5dSUq+NI6rgUhhlp5HFDP1nKjb
         x3KjGjg025CmSmjeXVzttC8oJDdPkugKKG9qUx5cAWuNEod/UyPgrITDzm8x2trmqvCr
         wXkQ==
X-Gm-Message-State: APjAAAXGaSgu8UmwM1b8RcXPbf/XRf4K/besIY+JWRXZLIFP6G4mOfDy
        QDrTC560iKlReXYAExCcQI4WryLNUCqimhb5YjT1OA==
X-Google-Smtp-Source: APXvYqxRN7k0ohWxf4YsbnJVRW8wqK5xEZVOZfCD9fKAsePqyFDzc1+rDjRXhAo3uNTbJkv3qcZDCMpUOUOZHkLrnvg=
X-Received: by 2002:a17:90a:ab0d:: with SMTP id m13mr32936932pjq.84.1563263837424;
 Tue, 16 Jul 2019 00:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-5-brendanhiggins@google.com> <20190715221554.8417320665@mail.kernel.org>
In-Reply-To: <20190715221554.8417320665@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 16 Jul 2019 00:57:06 -0700
Message-ID: <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like logger
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 15, 2019 at 3:15 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-12 01:17:30)
> > diff --git a/include/kunit/kunit-stream.h b/include/kunit/kunit-stream.h
> > new file mode 100644
> > index 0000000000000..a7b53eabf6be4
> > --- /dev/null
> > +++ b/include/kunit/kunit-stream.h
> > @@ -0,0 +1,81 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * C++ stream style string formatter and printer used in KUnit for outputting
> > + * KUnit messages.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#ifndef _KUNIT_KUNIT_STREAM_H
> > +#define _KUNIT_KUNIT_STREAM_H
> > +
> > +#include <linux/types.h>
> > +#include <kunit/string-stream.h>
> > +
> > +struct kunit;
> > +
> > +/**
> > + * struct kunit_stream - a std::stream style string builder.
> > + *
> > + * A std::stream style string builder. Allows messages to be built up and
> > + * printed all at once.
> > + */
> > +struct kunit_stream {
> > +       /* private: internal use only. */
> > +       struct kunit *test;
> > +       const char *level;
>
> Is the level changed? See my comment below, but I wonder if this whole
> struct can go away and the wrappers can just operate on 'struct
> string_stream' instead.

I was inclined to agree with you when I first read your comment, but
then I thought about the case that someone wants to add in a debug
message (of which I currently have none). I think under most
circumstances a user of kunit_stream would likely want to pick a
default verbosity that maybe I should provide, but may still want
different verbosity levels.

The main reason I want to keep the types separate, string_stream vs.
kunit_stream, is that they are intended to be used differently.
string_stream is just a generic string builder. If you are using that,
you are expecting to see someone building the string at some point and
then doing something interesting with it. kunit_stream really tells
you specifically that KUnit is putting together a message to
communicate something to a user of KUnit. It is really used in a very
specific way, and I wouldn't want to generalize its usage beyond how
it is currently used. I think in order to preserve the author's
intention it adds clarity to keep the types separate regardless of how
similar they might be in reality.

> > +       struct string_stream *internal_stream;
> > +};
> > diff --git a/kunit/kunit-stream.c b/kunit/kunit-stream.c
> > new file mode 100644
> > index 0000000000000..8bea1f22eafb5
> > --- /dev/null
> > +++ b/kunit/kunit-stream.c
> > @@ -0,0 +1,123 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * C++ stream style string formatter and printer used in KUnit for outputting
> > + * KUnit messages.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <kunit/kunit-stream.h>
> > +#include <kunit/string-stream.h>
> > +
> > +void kunit_stream_add(struct kunit_stream *kstream, const char *fmt, ...)
> > +{
> > +       va_list args;
> > +       struct string_stream *stream = kstream->internal_stream;
> > +
> > +       va_start(args, fmt);
> > +
> > +       if (string_stream_vadd(stream, fmt, args) < 0)
> > +               kunit_err(kstream->test,
> > +                         "Failed to allocate fragment: %s\n",
> > +                         fmt);
> > +
> > +       va_end(args);
> > +}
> > +
> > +void kunit_stream_append(struct kunit_stream *kstream,
> > +                               struct kunit_stream *other)
> > +{
> > +       struct string_stream *other_stream = other->internal_stream;
> > +       const char *other_content;
> > +
> > +       other_content = string_stream_get_string(other_stream);
> > +
> > +       if (!other_content) {
> > +               kunit_err(kstream->test,
> > +                         "Failed to get string from second argument for appending\n");
> > +               return;
> > +       }
> > +
> > +       kunit_stream_add(kstream, other_content);
> > +}
>
> Why can't this function be implemented in the string_stream API? Seems
> valid to want to append one stream to another and that isn't
> kunit_stream specific.

Fair point. Will do.

> > +
> > +void kunit_stream_clear(struct kunit_stream *kstream)
> > +{
> > +       string_stream_clear(kstream->internal_stream);
> > +}
> > +
> > +void kunit_stream_commit(struct kunit_stream *kstream)
> > +{
> > +       struct string_stream *stream = kstream->internal_stream;
> > +       struct string_stream_fragment *fragment;
> > +       struct kunit *test = kstream->test;
> > +       char *buf;
> > +
> > +       buf = string_stream_get_string(stream);
> > +       if (!buf) {
> > +               kunit_err(test,
> > +                         "Could not allocate buffer, dumping stream:\n");
> > +               list_for_each_entry(fragment, &stream->fragments, node) {
> > +                       kunit_err(test, fragment->fragment);
> > +               }
> > +               kunit_err(test, "\n");
> > +               goto cleanup;
> > +       }
> > +
> > +       kunit_printk(kstream->level, test, buf);
> > +       kfree(buf);
> > +
> > +cleanup:
>
> Drop the goto and use an 'else' please.

Will do.

> > +       kunit_stream_clear(kstream);
> > +}
> > +
> > +static int kunit_stream_init(struct kunit_resource *res, void *context)
> > +{
> > +       struct kunit *test = context;
> > +       struct kunit_stream *stream;
> > +
> > +       stream = kzalloc(sizeof(*stream), GFP_KERNEL);
> > +       if (!stream)
> > +               return -ENOMEM;
> > +
> > +       res->allocation = stream;
> > +       stream->test = test;
> > +       stream->internal_stream = alloc_string_stream(test);
> > +
> > +       if (!stream->internal_stream)
> > +               return -ENOMEM;
> > +
> > +       return 0;
> > +}
> > +
> > +static void kunit_stream_free(struct kunit_resource *res)
> > +{
> > +       struct kunit_stream *stream = res->allocation;
> > +
> > +       if (!string_stream_is_empty(stream->internal_stream)) {
> > +               kunit_err(stream->test,
> > +                         "End of test case reached with uncommitted stream entries\n");
> > +               kunit_stream_commit(stream);
> > +       }
> > +}
> > +
>
> Nitpick: Drop this extra newline.

Oops, nice catch.

> > diff --git a/kunit/test.c b/kunit/test.c
> > index f165c9d8e10b0..29edf34a89a37 100644
> > --- a/kunit/test.c
> > +++ b/kunit/test.c
> > @@ -120,6 +120,12 @@ static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
> >                               test_case->name);
> >  }
> >
> > +void kunit_fail(struct kunit *test, struct kunit_stream *stream)
>
> Why doesn't 'struct kunit' have a 'struct kunit_stream' inside of it? It
> seems that the two are highly related, to the point that it might just
> make sense to have

A `struct kunit_stream` is usually associated with a message that is
being built up over time like maybe an expectation; it is meant to
capture the idea that we might want to send some information out to
the user pertaining to some thing 'X', but we aren't sure that we
actually want to send it until 'X' is complete, but do to the nature
of 'X' it is easier to start constructing the message before 'X' is
complete.

Consider a complicated expectation, there might be multiple conditions
that satisfy it and multiple conditions which could make it fail. As
we start exploring the input to the expectation we gain information
that we might want to share back with the user if the expectation were
to fail and we might get that information before we are actually sure
that the expectation does indeed fail.

When we first step into the expectation we immediately know the
function name, file name, and line number where we are called and
would want to put that information into any message we would send to
the user about this expectation. Next, we might want to check a
property of the input, it may or may not be enough information on its
own for the expectation to fail, but we want to share the result of
the property check with the user regardless, BUT only if the
expectation as a whole fails.

Hence, we can have multiple `struct kunit_stream`s associated with a
`struct kunit` active at any given time.

>         struct kunit {
>                 struct kunit_stream stream;
>                 ...
>         };
>
> > +{
> > +       kunit_set_failure(test);
> > +       kunit_stream_commit(stream);
>
> And then this function can just take a test and the stream can be
> associated with the test directly. Use container_of() to get to the test
> when the only pointer in hand is for the stream too.

Unfortunately that wouldn't work. See my above explanation.

> > +}
> > +
> >  void kunit_init_test(struct kunit *test, const char *name)
> >  {
> >         mutex_init(&test->lock);

Thanks!
