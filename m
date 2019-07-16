Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 121B06A3FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 10:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbfGPIhr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 04:37:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41261 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfGPIhq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:37:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so8757883pff.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2019 01:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d5YQlIKKkuDS08glaQtz+2CmlaQCbXhxEEG92fwEkgc=;
        b=CsxR848oXNv0SGx7lrrmlW/EFOw9d/A77U3g3HqLdnzQXz9W+0cxfMoa8bEYGoXURh
         m8GxLMkoHCYswLdtdnUJ+iBrvvcKKjZbcU1qvZqr2o95nWV31wYJsJz5Dh6UhD3jgfTf
         5nivHOcKZtu6NiXtTp/wAzu9i/RSZAOEHLHz80kaXnhboxxZghbC+4Zr/y70MEqCyABV
         qn0BYsyJyIthL8JHY+XcetgGY+N2MuOwdMCbhswDZ+jUF5W/jWzTTHxbcIVuDRWHC7id
         KxQb7HGZt+O2zUduFDS/VkICES4vWtb0wGS9znIb2yrTGO5QGHPknE6OPaDWHe8cPkNv
         JSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d5YQlIKKkuDS08glaQtz+2CmlaQCbXhxEEG92fwEkgc=;
        b=OmLgkTS6xh674CMIjVL0K60uasKUx7CDp7i+G8f/8ABVOq+CHHiZrmvGBt8JvlejtV
         RWCTpEqi0V6Sr5M32+4ddC0jm7JWXDkLx3jPidUYloL0mIsygScT0Y78Fdl0ewzFDBl3
         4UUwPN+x7aIZkNlW8gfqK0OK7+TYPM3ckKlzdvOn7w2NaSBsAJ+om1sCIoIwsbG4yOBz
         MehVaCXhtOg4/Xrwgj6btEuOdAsgMYVYnZZFK3fZ+a20oCsxrV56Q1/YdHN6MZdqXObW
         fCOmuJmpLtouB2PiB8FLxlZvksI39Bm2T8w9FjDrwOj3X+6bLSf+9+PuVRoiBiob0Trk
         z+Dw==
X-Gm-Message-State: APjAAAWLJd7Qma63xnSxgjpTIM6pWoEn6JSxgb5S7E2RoE/Nauc8tE1I
        8yJf0O801HefRgjm+DnJxJq7wUd+s/y80+lGVRlt7w==
X-Google-Smtp-Source: APXvYqw/pjkOVZaApgOgNLX2yiZ2DSfhsd3LaKVyfBf+7gS0zPt8gXh/9iP62Z9w8bWZyNakENvfhgJaHPTPzm3RyWM=
X-Received: by 2002:a63:eb51:: with SMTP id b17mr31131916pgk.384.1563266265401;
 Tue, 16 Jul 2019 01:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-5-brendanhiggins@google.com> <20190715221554.8417320665@mail.kernel.org>
 <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com>
In-Reply-To: <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 16 Jul 2019 01:37:34 -0700
Message-ID: <CAFd5g44_axVHNMBzxSURQB_-R+Rif7cZcg7PyZ_SS+5hcy5jZA@mail.gmail.com>
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

On Tue, Jul 16, 2019 at 12:57 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Mon, Jul 15, 2019 at 3:15 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-07-12 01:17:30)
> > > diff --git a/include/kunit/kunit-stream.h b/include/kunit/kunit-stream.h
> > > new file mode 100644
> > > index 0000000000000..a7b53eabf6be4
> > > --- /dev/null
> > > +++ b/include/kunit/kunit-stream.h
> > > @@ -0,0 +1,81 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * C++ stream style string formatter and printer used in KUnit for outputting
> > > + * KUnit messages.
> > > + *
> > > + * Copyright (C) 2019, Google LLC.
> > > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > > + */
> > > +
> > > +#ifndef _KUNIT_KUNIT_STREAM_H
> > > +#define _KUNIT_KUNIT_STREAM_H
> > > +
> > > +#include <linux/types.h>
> > > +#include <kunit/string-stream.h>
> > > +
> > > +struct kunit;
> > > +
> > > +/**
> > > + * struct kunit_stream - a std::stream style string builder.
> > > + *
> > > + * A std::stream style string builder. Allows messages to be built up and
> > > + * printed all at once.
> > > + */
> > > +struct kunit_stream {
> > > +       /* private: internal use only. */
> > > +       struct kunit *test;
> > > +       const char *level;
> >
> > Is the level changed? See my comment below, but I wonder if this whole
> > struct can go away and the wrappers can just operate on 'struct
> > string_stream' instead.
>
> I was inclined to agree with you when I first read your comment, but
> then I thought about the case that someone wants to add in a debug
> message (of which I currently have none). I think under most
> circumstances a user of kunit_stream would likely want to pick a
> default verbosity that maybe I should provide, but may still want
> different verbosity levels.
>
> The main reason I want to keep the types separate, string_stream vs.
> kunit_stream, is that they are intended to be used differently.
> string_stream is just a generic string builder. If you are using that,
> you are expecting to see someone building the string at some point and
> then doing something interesting with it. kunit_stream really tells
> you specifically that KUnit is putting together a message to
> communicate something to a user of KUnit. It is really used in a very
> specific way, and I wouldn't want to generalize its usage beyond how
> it is currently used. I think in order to preserve the author's
> intention it adds clarity to keep the types separate regardless of how
> similar they might be in reality.
>
> > > +       struct string_stream *internal_stream;
> > > +};
> > > diff --git a/kunit/kunit-stream.c b/kunit/kunit-stream.c
> > > new file mode 100644
> > > index 0000000000000..8bea1f22eafb5
> > > --- /dev/null
> > > +++ b/kunit/kunit-stream.c
> > > @@ -0,0 +1,123 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * C++ stream style string formatter and printer used in KUnit for outputting
> > > + * KUnit messages.
> > > + *
> > > + * Copyright (C) 2019, Google LLC.
> > > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > > + */
> > > +
> > > +#include <kunit/test.h>
> > > +#include <kunit/kunit-stream.h>
> > > +#include <kunit/string-stream.h>
> > > +
> > > +void kunit_stream_add(struct kunit_stream *kstream, const char *fmt, ...)
> > > +{
> > > +       va_list args;
> > > +       struct string_stream *stream = kstream->internal_stream;
> > > +
> > > +       va_start(args, fmt);
> > > +
> > > +       if (string_stream_vadd(stream, fmt, args) < 0)
> > > +               kunit_err(kstream->test,
> > > +                         "Failed to allocate fragment: %s\n",
> > > +                         fmt);
> > > +
> > > +       va_end(args);
> > > +}
> > > +
> > > +void kunit_stream_append(struct kunit_stream *kstream,
> > > +                               struct kunit_stream *other)
> > > +{
> > > +       struct string_stream *other_stream = other->internal_stream;
> > > +       const char *other_content;
> > > +
> > > +       other_content = string_stream_get_string(other_stream);
> > > +
> > > +       if (!other_content) {
> > > +               kunit_err(kstream->test,
> > > +                         "Failed to get string from second argument for appending\n");
> > > +               return;
> > > +       }
> > > +
> > > +       kunit_stream_add(kstream, other_content);
> > > +}
> >
> > Why can't this function be implemented in the string_stream API? Seems
> > valid to want to append one stream to another and that isn't
> > kunit_stream specific.
>
> Fair point. Will do.
>
> > > +
> > > +void kunit_stream_clear(struct kunit_stream *kstream)
> > > +{
> > > +       string_stream_clear(kstream->internal_stream);
> > > +}
> > > +
> > > +void kunit_stream_commit(struct kunit_stream *kstream)
> > > +{
> > > +       struct string_stream *stream = kstream->internal_stream;
> > > +       struct string_stream_fragment *fragment;
> > > +       struct kunit *test = kstream->test;
> > > +       char *buf;
> > > +
> > > +       buf = string_stream_get_string(stream);
> > > +       if (!buf) {
> > > +               kunit_err(test,
> > > +                         "Could not allocate buffer, dumping stream:\n");
> > > +               list_for_each_entry(fragment, &stream->fragments, node) {
> > > +                       kunit_err(test, fragment->fragment);
> > > +               }
> > > +               kunit_err(test, "\n");
> > > +               goto cleanup;
> > > +       }
> > > +
> > > +       kunit_printk(kstream->level, test, buf);
> > > +       kfree(buf);
> > > +
> > > +cleanup:
> >
> > Drop the goto and use an 'else' please.
>
> Will do.
>
> > > +       kunit_stream_clear(kstream);
> > > +}
> > > +
> > > +static int kunit_stream_init(struct kunit_resource *res, void *context)
> > > +{
> > > +       struct kunit *test = context;
> > > +       struct kunit_stream *stream;
> > > +
> > > +       stream = kzalloc(sizeof(*stream), GFP_KERNEL);
> > > +       if (!stream)
> > > +               return -ENOMEM;
> > > +
> > > +       res->allocation = stream;
> > > +       stream->test = test;
> > > +       stream->internal_stream = alloc_string_stream(test);
> > > +
> > > +       if (!stream->internal_stream)
> > > +               return -ENOMEM;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void kunit_stream_free(struct kunit_resource *res)
> > > +{
> > > +       struct kunit_stream *stream = res->allocation;
> > > +
> > > +       if (!string_stream_is_empty(stream->internal_stream)) {
> > > +               kunit_err(stream->test,
> > > +                         "End of test case reached with uncommitted stream entries\n");
> > > +               kunit_stream_commit(stream);
> > > +       }
> > > +}
> > > +
> >
> > Nitpick: Drop this extra newline.
>
> Oops, nice catch.

Not super important, but I don't want you to think that I am ignoring
you. I think you must have unintentionally deleted the last function
in this file, or maybe you are referring to something that I am just
not seeing, but I don't see the extra newline here.

> > > diff --git a/kunit/test.c b/kunit/test.c
> > > index f165c9d8e10b0..29edf34a89a37 100644
> > > --- a/kunit/test.c
> > > +++ b/kunit/test.c
> > > @@ -120,6 +120,12 @@ static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
> > >                               test_case->name);
> > >  }
> > >
> > > +void kunit_fail(struct kunit *test, struct kunit_stream *stream)
> >
> > Why doesn't 'struct kunit' have a 'struct kunit_stream' inside of it? It
> > seems that the two are highly related, to the point that it might just
> > make sense to have
>
> A `struct kunit_stream` is usually associated with a message that is
> being built up over time like maybe an expectation; it is meant to
> capture the idea that we might want to send some information out to
> the user pertaining to some thing 'X', but we aren't sure that we
> actually want to send it until 'X' is complete, but do to the nature
> of 'X' it is easier to start constructing the message before 'X' is
> complete.
>
> Consider a complicated expectation, there might be multiple conditions
> that satisfy it and multiple conditions which could make it fail. As
> we start exploring the input to the expectation we gain information
> that we might want to share back with the user if the expectation were
> to fail and we might get that information before we are actually sure
> that the expectation does indeed fail.
>
> When we first step into the expectation we immediately know the
> function name, file name, and line number where we are called and
> would want to put that information into any message we would send to
> the user about this expectation. Next, we might want to check a
> property of the input, it may or may not be enough information on its
> own for the expectation to fail, but we want to share the result of
> the property check with the user regardless, BUT only if the
> expectation as a whole fails.
>
> Hence, we can have multiple `struct kunit_stream`s associated with a
> `struct kunit` active at any given time.
>
> >         struct kunit {
> >                 struct kunit_stream stream;
> >                 ...
> >         };
> >
> > > +{
> > > +       kunit_set_failure(test);
> > > +       kunit_stream_commit(stream);
> >
> > And then this function can just take a test and the stream can be
> > associated with the test directly. Use container_of() to get to the test
> > when the only pointer in hand is for the stream too.
>
> Unfortunately that wouldn't work. See my above explanation.
>
> > > +}
> > > +
> > >  void kunit_init_test(struct kunit *test, const char *name)
> > >  {
> > >         mutex_init(&test->lock);
>
> Thanks!
