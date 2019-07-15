Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10ECF69CCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 22:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbfGOUaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 16:30:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33805 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731779AbfGOUaf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:30:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so2038894pgc.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2019 13:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Guk3L6+8PLdqP7pYPvzhoPuDjq05e+2mmqgYxycfTpo=;
        b=nmdIrQ2ZG9zLY+uPnHaC+zU9b/FYlCcJUklqPlgIEvxvjrncOHXB+C4uonVCMPNT5U
         RDlsPPFfFHanzQy12v9LKBzsgYs//6dy4qqJq9wWWyI4pDK3aCgJ1J/JgmQXwTE7LK3E
         iw5kJfsnm+yh+B2qKZbTQBSYW2yNi7ZyoDweAfKbzMv3dfSuT0useTynnAjypl5lf7/d
         jTEh9cq2DJ6lxhwAR1P3fF5Tm12yriac2Lepz1S6WLSn9ipeqXXdzi8KqMKw91pnk6DG
         ICc14afUNRCpD25tMKIn+kqhek6winXiVWbGXLe13YMzt6iQrEchkA/y8vKWAxCaJIaL
         ulxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Guk3L6+8PLdqP7pYPvzhoPuDjq05e+2mmqgYxycfTpo=;
        b=J3ujiRgCfIoCSz5HBWb7PAuTKmtT+ZWZc8BgpDqID8RfWfsCwsOyuK5JGYOtq0T3Em
         IJzBfEhBXSGWK89svYTrZePYW+oVB2FqrNrcawzRgklT/toVUaDMWa4rdKHpglXKUTA5
         Eub4cTDnAWpPmPZ7NWkLwn/xjrXVFt6y9hdEPWuMsFupaVs3e3dOZskZnEOYDLDEaPYL
         ohfVynrkl+oP/JwKcQkpHbq1JqzYsjbJQ0jSROFhxCFkkoIeSbL08jS6M3nnmmIyJi24
         S94F3PorUiifz+mQrc7XWPhUGTy2XiAbzQwycjUbYCDdbKEMih79U3w/zTBc9TyBxpUM
         XEcg==
X-Gm-Message-State: APjAAAWztxTW3c9gFZy5jxDDrBN/7WDuUtGbYTZyYFN7Ig7rA4z3RdCa
        7GWSp3o1Hre0BUO64ts+yA5uyTGiwMXTMINhjXNJxQ==
X-Google-Smtp-Source: APXvYqzKQuaXpGEOS+dMEmBo8FPFiuVIjj5hhYTkizz5+oKRzaBKQU1vUVyuyXBWxZXEb/U0Rw/0GC/2FiD36LZR+90=
X-Received: by 2002:a63:b919:: with SMTP id z25mr28642556pge.201.1563222633591;
 Mon, 15 Jul 2019 13:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-3-brendanhiggins@google.com> <20190715202425.CE64C20665@mail.kernel.org>
In-Reply-To: <20190715202425.CE64C20665@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 15 Jul 2019 13:30:22 -0700
Message-ID: <CAFd5g45iHnMLOGQbXwzX6F74pkQGKBCSufkpYPOcw_iNSeiQKg@mail.gmail.com>
Subject: Re: [PATCH v9 02/18] kunit: test: add test resource management API
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

On Mon, Jul 15, 2019 at 1:24 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-12 01:17:28)
> > diff --git a/kunit/test.c b/kunit/test.c
> > index 571e4c65deb5c..f165c9d8e10b0 100644
> > --- a/kunit/test.c
> > +++ b/kunit/test.c
> > @@ -171,6 +175,96 @@ int kunit_run_tests(struct kunit_suite *suite)
> >         return 0;
> >  }
> >
> > +struct kunit_resource *kunit_alloc_resource(struct kunit *test,
> > +                                           kunit_resource_init_t init,
> > +                                           kunit_resource_free_t free,
> > +                                           void *context)
> > +{
> > +       struct kunit_resource *res;
> > +       int ret;
> > +
> > +       res = kzalloc(sizeof(*res), GFP_KERNEL);
>
> This uses GFP_KERNEL.
>
> > +       if (!res)
> > +               return NULL;
> > +
> > +       ret = init(res, context);
> > +       if (ret)
> > +               return NULL;
> > +
> > +       res->free = free;
> > +       mutex_lock(&test->lock);
>
> And this can sleep.
>
> > +       list_add_tail(&res->node, &test->resources);
> > +       mutex_unlock(&test->lock);
> > +
> > +       return res;
> > +}
> > +
> > +void kunit_free_resource(struct kunit *test, struct kunit_resource *res)
>
> Should probably add a note that we assume the test lock is held here, or
> even add a lockdep_assert_held(&test->lock) into the function to
> document that and assert it at the same time.

Seems reasonable.

> > +{
> > +       res->free(res);
> > +       list_del(&res->node);
> > +       kfree(res);
> > +}
> > +
> > +struct kunit_kmalloc_params {
> > +       size_t size;
> > +       gfp_t gfp;
> > +};
> > +
> > +static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
> > +{
> > +       struct kunit_kmalloc_params *params = context;
> > +
> > +       res->allocation = kmalloc(params->size, params->gfp);
> > +       if (!res->allocation)
> > +               return -ENOMEM;
> > +
> > +       return 0;
> > +}
> > +
> > +static void kunit_kmalloc_free(struct kunit_resource *res)
> > +{
> > +       kfree(res->allocation);
> > +}
> > +
> > +void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
> > +{
> > +       struct kunit_kmalloc_params params;
> > +       struct kunit_resource *res;
> > +
> > +       params.size = size;
> > +       params.gfp = gfp;
> > +
> > +       res = kunit_alloc_resource(test,
>
> This calls that sleeping function above...
>
> > +                                  kunit_kmalloc_init,
> > +                                  kunit_kmalloc_free,
> > +                                  &params);
>
> but this passes a GFP flags parameter through to the
> kunit_kmalloc_init() function. How is this going to work if some code
> uses GFP_ATOMIC, but then we try to allocate and sleep in
> kunit_alloc_resource() with GFP_KERNEL?

Yeah, that's an inconsistency. I need to fix that.

> One solution would be to piggyback on all the existing devres allocation
> logic we already have and make each struct kunit a device that we pass
> into the devres functions. A far simpler solution would be to just
> copy/paste what devres does and use a spinlock and an allocation
> function that takes GFP flags.

Yeah, that's what I did originally, but I thought from the discussion
on patch 01 that you thought a spinlock was overkill for struct kunit.
I take it you only meant in that initial patch?

> > +
> > +       if (res)
> > +               return res->allocation;
> > +
> > +       return NULL;
> > +}

Cheers
