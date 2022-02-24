Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BD74C23F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 07:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiBXGN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 01:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiBXGN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:13:57 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB96234022
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 22:13:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id s1so814259plg.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 22:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Asma8WNQQUT3FBNGCvGXdievYO+L9dWKrHZUkqpLwYo=;
        b=YP0hTw4BhQTutsHE3lgb2hwfeMrAAi2vjHqX4ZmQJDQvgozj5g8q/QqqcI09WdFnPd
         sD3El4ySr3YOjFuLIb49Bd1UUSdf60EoRhU0SNdE7vvX3rGUTe17TFup32D3dKf11GqR
         BCjntqEmhiz32jfO4BE5StMUcD6q3Zr8fLQE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Asma8WNQQUT3FBNGCvGXdievYO+L9dWKrHZUkqpLwYo=;
        b=AIVz9rGgvvUZ26nvrZzITyIH2+f4HU5R+rUdCB83oFD4U4fWTi1Cn4Fa+0a/rPFYwg
         IIJ9F0S+3iIDtNx7KEbXbFOTZ39YNnTPrv6tMV8w8Xcp8f5ngDlW0ZjAOgTUj8VHnNvV
         yqMKtNvm8JDnrJR3il9Qzaf3S2fTbO2/Nr289VXd3/1c4byFuCkn3nU02hSh5woLSTAQ
         Fvnm55Ddlsj8jD7hjQwHzuk/MuNVaRFyyYb8baN8pKzJJotAcLB0Uk/gzltenQxuC+h0
         HeBFnnXZr0fwBU7RCUOzlUP7IXH0F3C6ZEKQh5VjifSQ5rZjyEQcudCEuj2lHm1PGTCB
         37mQ==
X-Gm-Message-State: AOAM533EcuwJja3N7+zoM8BFLJqiLlV6Drs8Yag4JziBZLL1PPdDTHRA
        mR8xKftL5/1SgInqGFmz50GDgg==
X-Google-Smtp-Source: ABdhPJyRPCtuqkCcj9377exCaz5pyA9MMqZh33gOYt1MVstAjPz3jqClc+zk9NooYp5PwP7tqlaPNA==
X-Received: by 2002:a17:90a:a78d:b0:1bc:d11c:ad40 with SMTP id f13-20020a17090aa78d00b001bcd11cad40mr24287pjq.246.1645683206850;
        Wed, 23 Feb 2022 22:13:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 142sm1830697pfy.11.2022.02.23.22.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 22:13:26 -0800 (PST)
Date:   Wed, 23 Feb 2022 22:13:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Latypov <dlatypov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        David Gow <davidgow@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Magnus =?iso-8859-1?Q?Gro=DF?= <magnus.gross@rwth-aachen.de>,
        kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: Introduce KUnit test
Message-ID: <202202232208.B416701@keescook>
References: <20220224054332.1852813-1-keescook@chromium.org>
 <CAGS_qxp8cjG5jCX-7ziqHcy2gq_MqL8kU01-joFD_W9iPG08EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGS_qxp8cjG5jCX-7ziqHcy2gq_MqL8kU01-joFD_W9iPG08EA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:07:04PM -0800, Daniel Latypov wrote:
> On Wed, Feb 23, 2022 at 9:43 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Adds simple KUnit test for some binfmt_elf internals: specifically a
> > regression test for the problem fixed by commit 8904d9cd90ee ("ELF:
> > fix overflow in total mapping size calculation").
> >
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Alexey Dobriyan <adobriyan@gmail.com>
> > Cc: "Magnus Groﬂ" <magnus.gross@rwth-aachen.de>
> > Cc: kunit-dev@googlegroups.com
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > I'm exploring ways to mock copy_to_user() for more tests in here.
> > kprobes doesn't seem to let me easily hijack a function...
> 
> Yeah, there doesn't seem to be a good way to do so. It seems more
> feasible if one is willing to write arch-specific code, but I'm not
> quite sure if that works either.

Yeah, I'm hoping maybe Steven has some ideas.

Steven, I want to do fancy live-patch kind or things to replace functions,
but it doesn't need to be particularly fancy because KUnit tests (usually)
run single-threaded, etc. It looks like kprobes could almost do it, but
I don't see a way to have it _avoid_ making a function call.

> https://kunit.dev/mocking.html has some thoughts on this.
> Not sure if there's anything there that would be useful to you, but
> perhaps it can give you some ideas.

Yeah, I figure a small refactoring to use a passed task_struct can avoid
the "current" uses in load_elf_binary(), etc, but the copy_to_user() is
more of a problem. I have considered inverting the Makefile logic,
though, and having binfmt_elf_test.c include binfmt_elf.c and have it
just use a #define to redirect copy_to_user, kind of how all the compat
handling is already done. But it'd be nice to have a "cleaner" mocking
solution...

> 
> > ---
> >  fs/Kconfig.binfmt      | 17 +++++++++++
> >  fs/binfmt_elf.c        |  4 +++
> >  fs/binfmt_elf_test.c   | 64 ++++++++++++++++++++++++++++++++++++++++++
> >  fs/compat_binfmt_elf.c |  2 ++
> >  4 files changed, 87 insertions(+)
> >  create mode 100644 fs/binfmt_elf_test.c
> >
> > diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> > index 4d5ae61580aa..8e14589ee9cc 100644
> > --- a/fs/Kconfig.binfmt
> > +++ b/fs/Kconfig.binfmt
> > @@ -28,6 +28,23 @@ config BINFMT_ELF
> >           ld.so (check the file <file:Documentation/Changes> for location and
> >           latest version).
> >
> > +config BINFMT_ELF_KUNIT_TEST
> > +       bool "Build KUnit tests for ELF binary support" if !KUNIT_ALL_TESTS
> > +       depends on KUNIT=y && BINFMT_ELF=y
> > +       default KUNIT_ALL_TESTS
> > +       help
> > +         This builds the ELF loader KUnit tests.
> > +
> > +         KUnit tests run during boot and output the results to the debug log
> > +         in TAP format (https://testanything.org/). Only useful for kernel devs
> 
> Tangent: should we update the kunit style guide to not refer to TAP
> anymore as it's not accurate?
> The KTAP spec is live on kernel.org at
> https://www.kernel.org/doc/html/latest/dev-tools/ktap.html
> 
> We can leave this patch as-is and update later, or have it be the
> guinea pig for the new proposed wording.

Oops, good point. I was actually thinking it doesn't make too much sense
to keep repeating the same long boilerplate generally.

> (I'm personally in favor of people not copy-pasting these paragraphs
> in the first place, but that is what the style-guide currently
> recommends)

Let's change the guide? :)

> 
> > +         running KUnit test harness and are not for inclusion into a
> > +         production build.
> > +
> > +         For more information on KUnit and unit tests in general please refer
> > +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> > +
> > +         If unsure, say N.
> > +
> >  config COMPAT_BINFMT_ELF
> >         def_bool y
> >         depends on COMPAT && BINFMT_ELF
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 76ff2af15ba5..9bea703ed1c2 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -2335,3 +2335,7 @@ static void __exit exit_elf_binfmt(void)
> >  core_initcall(init_elf_binfmt);
> >  module_exit(exit_elf_binfmt);
> >  MODULE_LICENSE("GPL");
> > +
> > +#ifdef CONFIG_BINFMT_ELF_KUNIT_TEST
> > +#include "binfmt_elf_test.c"
> > +#endif
> > diff --git a/fs/binfmt_elf_test.c b/fs/binfmt_elf_test.c
> > new file mode 100644
> > index 000000000000..486ad419f763
> > --- /dev/null
> > +++ b/fs/binfmt_elf_test.c
> > @@ -0,0 +1,64 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <kunit/test.h>
> > +
> > +static void total_mapping_size_test(struct kunit *test)
> > +{
> > +       struct elf_phdr empty[] = {
> > +               { .p_type = PT_LOAD, .p_vaddr = 0, .p_memsz = 0, },
> > +               { .p_type = PT_INTERP, .p_vaddr = 10, .p_memsz = 999999, },
> > +       };
> > +       /*
> > +        * readelf -lW /bin/mount | grep '^  .*0x0' | awk '{print "\t\t{ .p_type = PT_" \
> > +        *                              $1 ", .p_vaddr = " $3 ", .p_memsz = " $6 ", },"}'
> > +        */
> > +       struct elf_phdr mount[] = {
> > +               { .p_type = PT_PHDR, .p_vaddr = 0x00000040, .p_memsz = 0x0002d8, },
> > +               { .p_type = PT_INTERP, .p_vaddr = 0x00000318, .p_memsz = 0x00001c, },
> > +               { .p_type = PT_LOAD, .p_vaddr = 0x00000000, .p_memsz = 0x0033a8, },
> > +               { .p_type = PT_LOAD, .p_vaddr = 0x00004000, .p_memsz = 0x005c91, },
> > +               { .p_type = PT_LOAD, .p_vaddr = 0x0000a000, .p_memsz = 0x0022f8, },
> > +               { .p_type = PT_LOAD, .p_vaddr = 0x0000d330, .p_memsz = 0x000d40, },
> > +               { .p_type = PT_DYNAMIC, .p_vaddr = 0x0000d928, .p_memsz = 0x000200, },
> > +               { .p_type = PT_NOTE, .p_vaddr = 0x00000338, .p_memsz = 0x000030, },
> > +               { .p_type = PT_NOTE, .p_vaddr = 0x00000368, .p_memsz = 0x000044, },
> > +               { .p_type = PT_GNU_PROPERTY, .p_vaddr = 0x00000338, .p_memsz = 0x000030, },
> > +               { .p_type = PT_GNU_EH_FRAME, .p_vaddr = 0x0000b490, .p_memsz = 0x0001ec, },
> > +               { .p_type = PT_GNU_STACK, .p_vaddr = 0x00000000, .p_memsz = 0x000000, },
> > +               { .p_type = PT_GNU_RELRO, .p_vaddr = 0x0000d330, .p_memsz = 0x000cd0, },
> > +       };
> > +       size_t mount_size = 0xE070;
> > +       /* https://lore.kernel.org/lkml/YfF18Dy85mCntXrx@fractal.localdomain */
> 
> Slight nit, it looks like that message wasn't sent to lkml.
> lore gives a suggestion to change to
> https://lore.kernel.org/linux-fsdevel/YfF18Dy85mCntXrx@fractal.localdomain/

Ah, thank you. I was replacing the /r/ that used to be in that URL, and
got lost. :)

-- 
Kees Cook
