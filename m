Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368708AE79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 07:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfHMFEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 01:04:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43496 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfHMFEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 01:04:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id v12so3096271pfn.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 22:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yw2VPeqxmsRoQHPYiMspo9WSTIZItOOYPkJzlzz97sQ=;
        b=R+xjVFNBTOKx66Ip6R2LUuGGTv9eRVrdSycmzhhLqv6ShkSGz9R0iiaQlwquO7BkEU
         x0+Ib4JO36b96tMczjZmXSHPyXXgXTGAWZTVVhOp2T/QIbWWY9V/IwNi6o7K3rnqxKD6
         ziqRin5+uEzkBO92V/m+9MKxmbzCf0EpwYeh574LKHHRRabDjwTHNTwZWhEFkvfuCrXM
         uElR/9bIqUIPxCl1QveNg860hXAYpRf6f2BJRo4B5oKRtiCThZ4ssb+YGhqyKYj3MwTn
         75s7SvppXdJK7apvtGoXkIluns/j2aGIDRd+g49iLbsgOZ5chYru9qT65dM05aT4eQAY
         d3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yw2VPeqxmsRoQHPYiMspo9WSTIZItOOYPkJzlzz97sQ=;
        b=tzzJ2+dxb6D5rvNO9mhrqmt+3J2XfZNDR5x+Pczo0++LbJ699P3RejpnbS0t/UcT0J
         Tns9f3r/ZwoRFNKzNHa18f927A7nD1HeNo4axQt8hgUN5ZT/EyU6drAsW6c+DMR4k1Ip
         wzc2homcvrfZuFw0i0TilTUw6I/hWlJ6Sh6XJHdqqOrFOFgZ2aPLuW8TuiKXkCq+zysQ
         xt7KGRq/RW4Egll5njt5vZ1fBZkVb/nHhAdfAQRSOjXdq3Ysz6ythEfAai2vqEoBNfR3
         OpupH7V/NESyPFqmfkrFtpZnVofJlmBCwYOPbatXtxh2AkjCmlkTxW1No158rQEc7bRl
         eMbw==
X-Gm-Message-State: APjAAAVseoNnRpyoU2A1AQcCayTzUThAb9xe1924mGziuqnAnRCnSW+4
        krVAcTjog/JAn36vPCallHG0Hrj3CRhvyDgY02Enfw==
X-Google-Smtp-Source: APXvYqzY7+RzhfN0PwrRrz6X4tFGzeJErvdkB+WMoL53BHH2m/gFw2SJjgYuiLuK2/VE++6KBxdxNTyzwKrq+P1ZkEU=
X-Received: by 2002:a63:eb51:: with SMTP id b17mr32062966pgk.384.1565672681626;
 Mon, 12 Aug 2019 22:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-6-brendanhiggins@google.com> <20190812235701.533E82063F@mail.kernel.org>
 <20190813003352.GA235915@google.com> <20190813050206.2A49C206C2@mail.kernel.org>
In-Reply-To: <20190813050206.2A49C206C2@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 12 Aug 2019 22:04:30 -0700
Message-ID: <CAFd5g44VBzDSjxHGUZ=8A9hempQ0_3Ym_8qzj0ETEJ8AzM6poA@mail.gmail.com>
Subject: Re: [PATCH v12 05/18] kunit: test: add the concept of expectations
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

On Mon, Aug 12, 2019 at 10:02 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 17:33:52)
> > On Mon, Aug 12, 2019 at 04:57:00PM -0700, Stephen Boyd wrote:
> > > Quoting Brendan Higgins (2019-08-12 11:24:08)
> > > > + */
> > > > +#define KUNIT_EXPECT_TRUE(test, condition) \
> > > > +               KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
> > >
> > > A lot of these macros seem double indented.
> >
> > In a case you pointed out in the preceding patch, I was just keeping the
> > arguments column aligned.
> >
> > In this case I am just indenting two tabs for a line continuation. I
> > thought I found other instances in the kernel that did this early on
> > (and that's also what the Linux kernel vim plugin wanted me to do).
> > After a couple of spot checks, it seems like one tab for this kind of
> > line continuation seems more common. I personally don't feel strongly
> > about any particular version. I just want to know now what the correct
> > indentation is for macros before I go through and change them all.
> >
> > I think there are three cases:
> >
> > #define macro0(param0, param1) \
> >                 a_really_long_macro(...)
> >
> > In this first case, I use two tabs for the first indent, I think you are
> > telling me this should be one tab.
>
> Yes. Should be one.
>
> >
> > #define macro1(param0, param1) {                                               \
> >         statement_in_a_block0;                                                 \
> >         statement_in_a_block1;                                                 \
> >         ...                                                                    \
> > }
> >
> > In this case, every line is in a block and is indented as it would be in
> > a function body. I think you are okay with this, and now that I am
> > thinking about it, what I think you are proposing for macro0 will make
> > these two cases more consistent.
> >
> > #define macro2(param0,                                                         \
> >                param1,                                                         \
> >                param2,                                                         \
> >                param3,                                                         \
> >                ...,                                                            \
> >                paramn) ...                                                     \
> >
> > In this last case, the body would be indented as in macro0, or macro1,
> > but the parameters passed into the macro are column aligned, consistent
> > with one of the acceptable ways of formatting function parameters that
> > don't fit on a single line.
> >
> > In all cases, I put 1 space in between the closing parameter paren and
> > the line continuation `\`, if only one `\` is needed. Otherwise, I align
> > all the `\s` to the 80th column. Is this okay, or would you prefer that
> > I align them all to the 80th column, or something else?
> >
>
> This all sounds fine and I'm not nitpicking this style. Just the double
> tabs making lines longer than required.

Sounds good. Will do.
