Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3AE3AB686
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 16:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhFQOze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 10:55:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40664 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbhFQOzF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:55:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 65A1C1FD7D;
        Thu, 17 Jun 2021 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623941576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7q0OZNtypGAEjCrcoo+ttjQVNFn1Ky9KY47NqMeoHE=;
        b=swr8RaWpri8QMRimhSLL+MkiXIZp1KJaciCMlH71yrQPWh9RackYe0xdVbd+MOvvLq0wSG
        pviYRxCu1hhV/SGLMmfHsCdasxmK4ZEY9vkWSEMzcqEljci6lKbLjwt60+SQHl1rS/wVEC
        pTdTyAh32KJvNY+knLY20D/4Zgx2rl8=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DB893A3BB9;
        Thu, 17 Jun 2021 14:52:55 +0000 (UTC)
Date:   Thu, 17 Jun 2021 16:52:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jia He <justin.he@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFCv4 4/4] lib/test_printf.c: add test cases for '%pD'
Message-ID: <YMthxzhHv7jeZKBJ@alley>
References: <20210615154952.2744-1-justin.he@arm.com>
 <20210615154952.2744-5-justin.he@arm.com>
 <CAHp75VeB68UUfz=6dO31zf59p6_5wGBX7etWJEV_xtLYsy=hBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeB68UUfz=6dO31zf59p6_5wGBX7etWJEV_xtLYsy=hBQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2021-06-15 23:47:29, Andy Shevchenko wrote:
> On Tue, Jun 15, 2021 at 6:55 PM Jia He <justin.he@arm.com> wrote:
> >
> > After the behaviour of specifier '%pD' is changed to print full path
> > of struct file, the related test cases are also updated.
> >
> > Given the string of '%pD' is prepended from the end of the buffer, the
> > check of "wrote beyond the nul-terminator" should be skipped.
> >
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  lib/test_printf.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/test_printf.c b/lib/test_printf.c
> > index d1d2f898ebae..9f851a82b3af 100644
> > --- a/lib/test_printf.c
> > +++ b/lib/test_printf.c
> > @@ -78,7 +80,7 @@ do_test(int bufsize, const char *expect, int elen,
> >                 return 1;
> >         }
> >
> > -       if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
> 
> > +       if (!is_prepended_buf && memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
> 
> Can it be parametrized? I don't like the custom test case being
> involved here like this.

Yup, it would be nice.

Also it is far from obvious what @is_prepended_buf means if you do not
have context of this patchset. I think about a more generic name
that comes from the wording used in 3rd patch, e.g.

    @need_scratch_space or @using_scratch_space or @dirty_buf

Anyway, the most easy way to pass this as a parameter would be to add it
to __test() and define a wrapper, .e.g:

static void __printf(3, 4) __init
__test(const char *expect, int elen, bool using_scratch_space,
	const char *fmt, ...)

/*
 * More relaxed test for non-standard formats that are using the provided buffer
 * as a scratch space and write beyond the trailing '\0'.
 */
#define test_using_scratch_space(expect, fmt, ...)			\
	__test(expect, strlen(expect), true, fmt, ##__VA_ARGS__)


Best Regards,
Petr
