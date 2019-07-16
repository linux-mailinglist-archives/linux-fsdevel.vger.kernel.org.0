Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C556ADFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 19:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbfGPRwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 13:52:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32958 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388299AbfGPRv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:51:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id f20so568951pgj.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2019 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxEnHLXatCKhmQ8tqkHkTC9RIIficSilWz6s4BKeyXQ=;
        b=IR8gpax66RigZJS8zzOEEHslcoRtMBTJQr+BwYoG5krQI/IrW7RBJJOb1HnDxCU/yV
         QgfV9zvBkZxiaRdpVQ5UvleUCuWprZ5drSQYCn+Y2SQ0WJBxkU9y96Vg0A/X9/w6puUy
         wJPZSB5OIH+Fs7UZF2sgnWroJ6gzdmui3EJVbxSAUEw1zlnflSZQkCP2CyGkcZhrQ2Ik
         nTu4JglIMF5h/vJexddFclKM2bow42WXkycOAGCzBHj4V7nlFfCvnoPh2kZ9tat4r+lR
         ldeIM3HQ86qC69oeN4VGJIE3aUlKeqjYM8fm2x0XfJ1yNou0BI3BeFip69rcKSz9jBAN
         0rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxEnHLXatCKhmQ8tqkHkTC9RIIficSilWz6s4BKeyXQ=;
        b=IdO/X5gX8YI4liajBaMRM5AGwRlSunYKtYBn3fbyF/h0DABbSaHenxJ0qbS3zSARjc
         6GkEu8ppt0dxZW9s5L50e8nb7/BHsMC2vVigH+cUUmbNJrXUSV4b2WxGlQPCVXSHhjHM
         Fg0Q8RFRvz9/w6pLzGxKIwpmzFzDxQ9MlX9F+oaa+VgnSkCvm1NbBGmrW4FFia2bgtXV
         7Dh+ff/JCBM1O5GBKMbGOdpPfZ0fTG50EsYNArfidq1Zmzyfww2FnO4L5S0YionWDVDP
         mfXl9jwAghLZv+797+8JMm37TMbQhOFdFGc6tjxbMhvfN2Hyu3gTq61wJnm+f5IdveRn
         6djQ==
X-Gm-Message-State: APjAAAXtHmg6Mtf7F2cDa7l9EodD8P1+OB74IXXMHr4sVw/+6pNqvwnp
        iENWTwtYdkafOTTni8fVSw2LF+SHE17zvxp7Q/u/Xw==
X-Google-Smtp-Source: APXvYqyaJ18vLD4kzF4vse9+yxk+DvjTEGfbRhJU4ABRtN/S/Q3OhUTQ5bxT7G2cnasvpqzT1qZSk1Dd9UfyhosJ/h0=
X-Received: by 2002:a63:b919:: with SMTP id z25mr35314546pge.201.1563299516676;
 Tue, 16 Jul 2019 10:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-5-brendanhiggins@google.com> <20190715221554.8417320665@mail.kernel.org>
 <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com>
 <CAFd5g44_axVHNMBzxSURQB_-R+Rif7cZcg7PyZ_SS+5hcy5jZA@mail.gmail.com> <20190716153002.49E292054F@mail.kernel.org>
In-Reply-To: <20190716153002.49E292054F@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 16 Jul 2019 10:51:45 -0700
Message-ID: <CAFd5g44jruCZLunpQuDPnQS995x0F+Gxp99z4BoP_pLt=Hr1BQ@mail.gmail.com>
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

On Tue, Jul 16, 2019 at 8:30 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-16 01:37:34)
> > On Tue, Jul 16, 2019 at 12:57 AM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Mon, Jul 15, 2019 at 3:15 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > Quoting Brendan Higgins (2019-07-12 01:17:30)
> > > > > diff --git a/include/kunit/kunit-stream.h b/include/kunit/kunit-stream.h
> > > > > new file mode 100644
> > > > > index 0000000000000..a7b53eabf6be4
> > > > > --- /dev/null
> > > > > +++ b/include/kunit/kunit-stream.h
> > > > > +/**
> > > > > + * struct kunit_stream - a std::stream style string builder.
> > > > > + *
> > > > > + * A std::stream style string builder. Allows messages to be built up and
> > > > > + * printed all at once.
> > > > > + */
> > > > > +struct kunit_stream {
> > > > > +       /* private: internal use only. */
> > > > > +       struct kunit *test;
> > > > > +       const char *level;
> > > >
> > > > Is the level changed? See my comment below, but I wonder if this whole
> > > > struct can go away and the wrappers can just operate on 'struct
> > > > string_stream' instead.
> > >
> > > I was inclined to agree with you when I first read your comment, but
> > > then I thought about the case that someone wants to add in a debug
> > > message (of which I currently have none). I think under most
> > > circumstances a user of kunit_stream would likely want to pick a
> > > default verbosity that maybe I should provide, but may still want
> > > different verbosity levels.
> > >
> > > The main reason I want to keep the types separate, string_stream vs.
> > > kunit_stream, is that they are intended to be used differently.
> > > string_stream is just a generic string builder. If you are using that,
> > > you are expecting to see someone building the string at some point and
> > > then doing something interesting with it. kunit_stream really tells
> > > you specifically that KUnit is putting together a message to
> > > communicate something to a user of KUnit. It is really used in a very
> > > specific way, and I wouldn't want to generalize its usage beyond how
> > > it is currently used. I think in order to preserve the author's
> > > intention it adds clarity to keep the types separate regardless of how
> > > similar they might be in reality.
>
> You may want to add some of these reasons to the commit text.

Will do.

> > > > > +
> > > > > +       if (!string_stream_is_empty(stream->internal_stream)) {
> > > > > +               kunit_err(stream->test,
> > > > > +                         "End of test case reached with uncommitted stream entries\n");
> > > > > +               kunit_stream_commit(stream);
> > > > > +       }
> > > > > +}
> > > > > +
> > > >
> > > > Nitpick: Drop this extra newline.
> > >
> > > Oops, nice catch.
> >
> > Not super important, but I don't want you to think that I am ignoring
> > you. I think you must have unintentionally deleted the last function
> > in this file, or maybe you are referring to something that I am just
> > not seeing, but I don't see the extra newline here.
>
> No worries. Sorry for the noise.
>
> > > property of the input, it may or may not be enough information on its
> > > own for the expectation to fail, but we want to share the result of
> > > the property check with the user regardless, BUT only if the
> > > expectation as a whole fails.
> > >
> > > Hence, we can have multiple `struct kunit_stream`s associated with a
> > > `struct kunit` active at any given time.
>
> Makes sense. I wasn't sure if there were more than one stream associated
> with a test. Sounds like there are many to one so it can't just be a
> member of the test. This could be documented somewhere so this question
> doesn't come up again.

Sounds good. Will do.

Thanks!
