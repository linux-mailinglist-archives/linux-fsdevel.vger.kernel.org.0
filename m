Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF076281F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 20:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbfGHSNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 14:13:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43652 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389079AbfGHSNH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:13:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so8081159pgv.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2019 11:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCk1WdM0E6nhQWvL7vJ1kxAIGG56jCba8QRd4SGiDCA=;
        b=OgF8cL2jlYPassQya/5LPanMn4rdt4wOzgmrqwzZxEQPZIqKVwIc/cbAKjQaKs4FzI
         MO+lSWFVjE1BjbNrUM+omMAeEVXWMjykV41krvzt8AWSDOTa5viWTuQtJ9ep0X0LXNYj
         OdiZ626za04Q5e0ee0vw+VtEjSvuMHfSSgdE6F33EKsPb+2cKBbfbxgMScj9OazVWVAS
         RUi9fLCfATh+IjCkIXVEG9DerSHN7LKc7YsX4AxnaewNdUelqDZmIgeZ0zeSR0DCe4sE
         eOaHDJj5UB+8gGaq9GRuZY4qOho86pU0SRPsJdJUsDSn1VzYLTJqJx6RyW6gChbKWFWj
         8y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCk1WdM0E6nhQWvL7vJ1kxAIGG56jCba8QRd4SGiDCA=;
        b=PvR6DToab31cJ6E/i0chU5jIehqs5xpOrBcPaNIlJjSRsmMJdUjujZVKRsr8oJ2pvG
         34eHQ8gYywotYZwRuZlAj0if6IbaGY7q7LF9+OHN6N2yAyh6dZFxxYYbL3vg74lbMzRC
         JDNipOGhSYsmCniHMU/f12KFH9B9Fb05V5jxF3TpvX8cklrky/UR2aX6TdfqNhUIN1zY
         Bu/+41AcJyYjbkf2DKoE3qIBlHu1fGU9Fj9X/rB5WnxOwXBySRPKnKNhiVrE7R2Ed5t6
         yDoXbswMxyaDPzCHY72J3y554TOhmNni1lY3f6+Srj5bKU8US11sJ+CzNIZR/SYT3Fyv
         C5sg==
X-Gm-Message-State: APjAAAU6H66B6wG48jP/rZHzbFEuSq6+32YFft/jeIKL8wZNR6Fozy8x
        S26wK5Y9WlU/iSd5xPb8RFQxhQ8NxTfVZ8mNf6K7KA==
X-Google-Smtp-Source: APXvYqwC0igtuHeVBLKgctH3AD+JJSF1DFvHIy3IKlb3b8t5WGygrYUkxCrtO7R9CSN2ItDaerVKeb0U4IrWm5FTm44=
X-Received: by 2002:a17:90b:f0e:: with SMTP id br14mr27407161pjb.117.1562609586818;
 Mon, 08 Jul 2019 11:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-2-brendanhiggins@google.com> <20190705202051.GB19023@42.do-not-panic.com>
In-Reply-To: <20190705202051.GB19023@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 8 Jul 2019 11:12:55 -0700
Message-ID: <CAFd5g44_NoGHsMRfZJ-V42=8U6QYOYZV7zUmEdx-6V4xGarxHg@mail.gmail.com>
Subject: Re: [PATCH v6 01/18] kunit: test: add KUnit test runner core
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
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

On Fri, Jul 5, 2019 at 1:20 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Jul 03, 2019 at 05:35:58PM -0700, Brendan Higgins wrote:
> > +struct kunit {
> > +     void *priv;
> > +
> > +     /* private: internal use only. */
> > +     const char *name; /* Read only after initialization! */
> > +     bool success; /* Read only after test_case finishes! */
> > +};
>
> No lock attribute above.
>
> > +void kunit_init_test(struct kunit *test, const char *name)
> > +{
> > +     spin_lock_init(&test->lock);
> > +     test->name = name;
> > +     test->success = true;
> > +}
>
> And yet here you initialize a spin lock... This won't compile. Seems
> you forgot to remove this line. So I guess a re-spin is better.

Oh crap, sorry about that. You can't compile these patches until the
kbuild patch. I will fix this and make sure I didn't make any similar
mistakes on these early patches.

Thanks!
