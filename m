Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDEC4C23E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 07:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiBXGHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 01:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiBXGHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:07:48 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB8CF47E2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 22:07:19 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gb39so2148141ejc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 22:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kP+89y0hoRnShyoLp/hNYbJCaD/1tG2cQQ5MHA+Qy84=;
        b=kwRnAaTapnRDvQFCX4erZ72wwBBIgT9aehZ1b407m0CDNloA8vSdFrLuPx0M7uHYYr
         Z4d8Zd7Ous/XLZ8pl5j/P95yQwa+vGnhnb0m4OBf2SnigJ2PLxaxpoOyRTLQix2L0Asg
         XYnk1fboddBNDJUconnfgW0y4b/X7ndWiQqqUijhrsavc2KBKbfLjeSxvPIIAsjDiJka
         BuxkiqUPVTDxcaMSe/uXpFUpdvLe+w1G5O/PIPAmLnOpno7mwOz3Jq+isx3Us0w6nlld
         Qvrdpj32vpP2hwfT8X0rAuyHIySqL92HKUgwwRGlnQ26VcMxzOtw2jvTEfASqrT5ZJFS
         kABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kP+89y0hoRnShyoLp/hNYbJCaD/1tG2cQQ5MHA+Qy84=;
        b=G13VDrjet+hDIoBcPSiDIt4/3jFrZODot3ipsnP9EhXP6+mzoxjuChtDj2VJfmOmrz
         oOc1KVGsh9Hmj1BlKJBqNLxu3Jsva+pjtZ1XuNj9UtUXXLbvrMTXs1dDWkUY76ALgy9U
         /JsQSFzFrh3RpCmfo+Qx2Hpa8y1NIMmw+ZQ780xPLzDJp5vjfLuNdRk693jdmayg4ICc
         h9zGQqTTNP25bsInlfD2a5/6Khw5rDo1jHv59DwJZ/lwc0T3+FIgrZ0oTww5Ak+XM4lc
         Xohl7gqiSwtqaRFtDzPptgHC6qXmsoxgHYWX5hmS1lYIR7uQSlGNpe1q7tSiQekyc0MJ
         l8VQ==
X-Gm-Message-State: AOAM532ebeVWK8YH0p+J+zQHi6q7C3XyGgNW24pyjLGFUDcR9tBQCrPB
        CQRjH38Jrkvx1+DgrfR4CbhLngHiCY2kZWRAwH378w==
X-Google-Smtp-Source: ABdhPJzZgf+9TEGQb6iMcXtXFm9emtSA5v0uMfoaoiwA1lFfvD2e9TdWMjBamDP38FG17rD1IP935MHFoxCFr7G2kCA=
X-Received: by 2002:a17:906:c12:b0:6cc:ec90:31f3 with SMTP id
 s18-20020a1709060c1200b006ccec9031f3mr961140ejf.369.1645682837863; Wed, 23
 Feb 2022 22:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20220224054332.1852813-1-keescook@chromium.org>
In-Reply-To: <20220224054332.1852813-1-keescook@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 23 Feb 2022 22:07:04 -0800
Message-ID: <CAGS_qxp8cjG5jCX-7ziqHcy2gq_MqL8kU01-joFD_W9iPG08EA@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf: Introduce KUnit test
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        David Gow <davidgow@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWFnbnVzIEdyb8Of?= <magnus.gross@rwth-aachen.de>,
        kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 9:43 PM Kees Cook <keescook@chromium.org> wrote:
>
> Adds simple KUnit test for some binfmt_elf internals: specifically a
> regression test for the problem fixed by commit 8904d9cd90ee ("ELF:
> fix overflow in total mapping size calculation").
>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: "Magnus Gro=C3=9F" <magnus.gross@rwth-aachen.de>
> Cc: kunit-dev@googlegroups.com
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> I'm exploring ways to mock copy_to_user() for more tests in here.
> kprobes doesn't seem to let me easily hijack a function...

Yeah, there doesn't seem to be a good way to do so. It seems more
feasible if one is willing to write arch-specific code, but I'm not
quite sure if that works either.

https://kunit.dev/mocking.html has some thoughts on this.
Not sure if there's anything there that would be useful to you, but
perhaps it can give you some ideas.

> ---
>  fs/Kconfig.binfmt      | 17 +++++++++++
>  fs/binfmt_elf.c        |  4 +++
>  fs/binfmt_elf_test.c   | 64 ++++++++++++++++++++++++++++++++++++++++++
>  fs/compat_binfmt_elf.c |  2 ++
>  4 files changed, 87 insertions(+)
>  create mode 100644 fs/binfmt_elf_test.c
>
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index 4d5ae61580aa..8e14589ee9cc 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -28,6 +28,23 @@ config BINFMT_ELF
>           ld.so (check the file <file:Documentation/Changes> for location=
 and
>           latest version).
>
> +config BINFMT_ELF_KUNIT_TEST
> +       bool "Build KUnit tests for ELF binary support" if !KUNIT_ALL_TES=
TS
> +       depends on KUNIT=3Dy && BINFMT_ELF=3Dy
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the ELF loader KUnit tests.
> +
> +         KUnit tests run during boot and output the results to the debug=
 log
> +         in TAP format (https://testanything.org/). Only useful for kern=
el devs

Tangent: should we update the kunit style guide to not refer to TAP
anymore as it's not accurate?
The KTAP spec is live on kernel.org at
https://www.kernel.org/doc/html/latest/dev-tools/ktap.html

We can leave this patch as-is and update later, or have it be the
guinea pig for the new proposed wording.

(I'm personally in favor of people not copy-pasting these paragraphs
in the first place, but that is what the style-guide currently
recommends)

> +         running KUnit test harness and are not for inclusion into a
> +         production build.
> +
> +         For more information on KUnit and unit tests in general please =
refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  config COMPAT_BINFMT_ELF
>         def_bool y
>         depends on COMPAT && BINFMT_ELF
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 76ff2af15ba5..9bea703ed1c2 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -2335,3 +2335,7 @@ static void __exit exit_elf_binfmt(void)
>  core_initcall(init_elf_binfmt);
>  module_exit(exit_elf_binfmt);
>  MODULE_LICENSE("GPL");
> +
> +#ifdef CONFIG_BINFMT_ELF_KUNIT_TEST
> +#include "binfmt_elf_test.c"
> +#endif
> diff --git a/fs/binfmt_elf_test.c b/fs/binfmt_elf_test.c
> new file mode 100644
> index 000000000000..486ad419f763
> --- /dev/null
> +++ b/fs/binfmt_elf_test.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <kunit/test.h>
> +
> +static void total_mapping_size_test(struct kunit *test)
> +{
> +       struct elf_phdr empty[] =3D {
> +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0, .p_memsz =3D 0, },
> +               { .p_type =3D PT_INTERP, .p_vaddr =3D 10, .p_memsz =3D 99=
9999, },
> +       };
> +       /*
> +        * readelf -lW /bin/mount | grep '^  .*0x0' | awk '{print "\t\t{ =
.p_type =3D PT_" \
> +        *                              $1 ", .p_vaddr =3D " $3 ", .p_mem=
sz =3D " $6 ", },"}'
> +        */
> +       struct elf_phdr mount[] =3D {
> +               { .p_type =3D PT_PHDR, .p_vaddr =3D 0x00000040, .p_memsz =
=3D 0x0002d8, },
> +               { .p_type =3D PT_INTERP, .p_vaddr =3D 0x00000318, .p_mems=
z =3D 0x00001c, },
> +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x00000000, .p_memsz =
=3D 0x0033a8, },
> +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x00004000, .p_memsz =
=3D 0x005c91, },
> +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x0000a000, .p_memsz =
=3D 0x0022f8, },
> +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x0000d330, .p_memsz =
=3D 0x000d40, },
> +               { .p_type =3D PT_DYNAMIC, .p_vaddr =3D 0x0000d928, .p_mem=
sz =3D 0x000200, },
> +               { .p_type =3D PT_NOTE, .p_vaddr =3D 0x00000338, .p_memsz =
=3D 0x000030, },
> +               { .p_type =3D PT_NOTE, .p_vaddr =3D 0x00000368, .p_memsz =
=3D 0x000044, },
> +               { .p_type =3D PT_GNU_PROPERTY, .p_vaddr =3D 0x00000338, .=
p_memsz =3D 0x000030, },
> +               { .p_type =3D PT_GNU_EH_FRAME, .p_vaddr =3D 0x0000b490, .=
p_memsz =3D 0x0001ec, },
> +               { .p_type =3D PT_GNU_STACK, .p_vaddr =3D 0x00000000, .p_m=
emsz =3D 0x000000, },
> +               { .p_type =3D PT_GNU_RELRO, .p_vaddr =3D 0x0000d330, .p_m=
emsz =3D 0x000cd0, },
> +       };
> +       size_t mount_size =3D 0xE070;
> +       /* https://lore.kernel.org/lkml/YfF18Dy85mCntXrx@fractal.localdom=
ain */

Slight nit, it looks like that message wasn't sent to lkml.
lore gives a suggestion to change to
https://lore.kernel.org/linux-fsdevel/YfF18Dy85mCntXrx@fractal.localdomain/
