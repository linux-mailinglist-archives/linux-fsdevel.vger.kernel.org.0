Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B914C24D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 08:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiBXH6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 02:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiBXH6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 02:58:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C892919E0B0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 23:58:01 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id r10so463629wma.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 23:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtzSwTIySprFheuwZwGUu3DRqfq3ROnIz/hEw/VyeOs=;
        b=PlvEKJ6U6dNbAZoPtYjyOPPdpGW28Nt7e224dPSAh+Vl1g+XQfE0cYtHoSzX80+r7d
         5+gwXjjL7ryHv9T/RcZwu99pAyvpvpV2aPyZczkF2mD0Bby3CVeB4sDTtPXd8Nf8Ft5u
         /DwHvSbUbnom3LEaNXlFD20K+OyOrf4DNRKb9cfFyuCTY7qq6RFw9NKz987Ps84iXdgD
         lTymQD0ajyeFkp6BBr+58ydf6xvlkay935tpt8g6AVbYCoykMQ8WvGcb3a5Z7rriZFw8
         XzWjdJhWhRr392Asz4f4X8tassSGBY7ddCzmUz3Bd4LEwXTI/ngByTvJTlZfr+b5FxLo
         aAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtzSwTIySprFheuwZwGUu3DRqfq3ROnIz/hEw/VyeOs=;
        b=WgVCDrViVkYMV5P3OtRAERCgjRcKNca0VI5QZHN2WeEVCfY7GpdmJymxRPkIpBoCqy
         qyQH5mQJcD+jE/86nQAI10Tnld55J7p6gg0AiAVvrFXKYFIuMFZ9Q2WcFauGRg19hbt8
         HHdSFaTi8GJPfOX8VkGJ4FDEMwoU0KVy+9O5q8SZOU8x5AcQZyZvRMg6kDj2GLUAPFtQ
         EfjQZCjueeC+mMQUjbMtg1Nneh/ctrGIsk/H83T9q0AiiiGzcz2UGQrjpHtcMr/Xlpqy
         4dRf8vSH+ot9iBejOZkqAW5KUDU1kEZQlX3OWKxWYohX0rRTM/jocTnvjveN2nbK+q8c
         vR/g==
X-Gm-Message-State: AOAM531q9cZOa6mC6jQHQKn28X2RPK9GIVeA1F17lrdY8gjGPIvi8aik
        vYsWGUR1NhA2A5sgJDSyt93csC0rXBTSeP92+U6xfw==
X-Google-Smtp-Source: ABdhPJwstWV6h+t5B7WVOea3jws4B9FQilLbjX0xjgg+LYQw2wLhUJRT9vLXtuqh4rgUop6VzHO+MPL/WZwAFTP7Vk4=
X-Received: by 2002:a05:600c:4e8a:b0:37d:1c28:20fc with SMTP id
 f10-20020a05600c4e8a00b0037d1c2820fcmr1206743wmq.166.1645689480009; Wed, 23
 Feb 2022 23:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20220224054332.1852813-1-keescook@chromium.org>
 <CAGS_qxp8cjG5jCX-7ziqHcy2gq_MqL8kU01-joFD_W9iPG08EA@mail.gmail.com> <202202232208.B416701@keescook>
In-Reply-To: <202202232208.B416701@keescook>
From:   David Gow <davidgow@google.com>
Date:   Thu, 24 Feb 2022 15:57:48 +0800
Message-ID: <CABVgOS=3-as5VqOP=5fKTQhyYwEv0ZFM=ykHkW-wU8_WEEZW4g@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf: Introduce KUnit test
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWFnbnVzIEdyb8Of?= <magnus.gross@rwth-aachen.de>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e3e55e05d8bef0bd"
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

--000000000000e3e55e05d8bef0bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 2:13 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Feb 23, 2022 at 10:07:04PM -0800, Daniel Latypov wrote:
> > On Wed, Feb 23, 2022 at 9:43 PM Kees Cook <keescook@chromium.org> wrote=
:
> > >
> > > Adds simple KUnit test for some binfmt_elf internals: specifically a
> > > regression test for the problem fixed by commit 8904d9cd90ee ("ELF:
> > > fix overflow in total mapping size calculation").
> > >
> > > Cc: Eric Biederman <ebiederm@xmission.com>
> > > Cc: David Gow <davidgow@google.com>
> > > Cc: Alexey Dobriyan <adobriyan@gmail.com>
> > > Cc: "Magnus Gro=C3=9F" <magnus.gross@rwth-aachen.de>
> > > Cc: kunit-dev@googlegroups.com
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > I'm exploring ways to mock copy_to_user() for more tests in here.
> > > kprobes doesn't seem to let me easily hijack a function...
> >
> > Yeah, there doesn't seem to be a good way to do so. It seems more
> > feasible if one is willing to write arch-specific code, but I'm not
> > quite sure if that works either.
>
> Yeah, I'm hoping maybe Steven has some ideas.
>
> Steven, I want to do fancy live-patch kind or things to replace functions=
,
> but it doesn't need to be particularly fancy because KUnit tests (usually=
)
> run single-threaded, etc. It looks like kprobes could almost do it, but
> I don't see a way to have it _avoid_ making a function call.
>
> > https://kunit.dev/mocking.html has some thoughts on this.
> > Not sure if there's anything there that would be useful to you, but
> > perhaps it can give you some ideas.
>
> Yeah, I figure a small refactoring to use a passed task_struct can avoid
> the "current" uses in load_elf_binary(), etc, but the copy_to_user() is
> more of a problem. I have considered inverting the Makefile logic,
> though, and having binfmt_elf_test.c include binfmt_elf.c and have it
> just use a #define to redirect copy_to_user, kind of how all the compat
> handling is already done. But it'd be nice to have a "cleaner" mocking
> solution...
>

I think inverting the Makefile makes some sense here, even if it leads
to some code-duplication #define ugliness. Unfortunately, there just
doesn't seem to be a "clean" way of mocking out functions which is
also safe (particularly for something like copy_to_user(), which might
be running in a different thread concurrently with a test) and
performant. If there is a way to refactor the code to avoid the need
for mocking, that's always nice, but can lead to a lot of extraneous
exported functions / interfaces and other code churn.

> >
> > > ---
> > >  fs/Kconfig.binfmt      | 17 +++++++++++
> > >  fs/binfmt_elf.c        |  4 +++
> > >  fs/binfmt_elf_test.c   | 64 ++++++++++++++++++++++++++++++++++++++++=
++
> > >  fs/compat_binfmt_elf.c |  2 ++
> > >  4 files changed, 87 insertions(+)
> > >  create mode 100644 fs/binfmt_elf_test.c
> > >
> > > diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> > > index 4d5ae61580aa..8e14589ee9cc 100644
> > > --- a/fs/Kconfig.binfmt
> > > +++ b/fs/Kconfig.binfmt
> > > @@ -28,6 +28,23 @@ config BINFMT_ELF
> > >           ld.so (check the file <file:Documentation/Changes> for loca=
tion and
> > >           latest version).
> > >
> > > +config BINFMT_ELF_KUNIT_TEST
> > > +       bool "Build KUnit tests for ELF binary support" if !KUNIT_ALL=
_TESTS
> > > +       depends on KUNIT=3Dy && BINFMT_ELF=3Dy
> > > +       default KUNIT_ALL_TESTS
> > > +       help
> > > +         This builds the ELF loader KUnit tests.
> > > +
> > > +         KUnit tests run during boot and output the results to the d=
ebug log
> > > +         in TAP format (https://testanything.org/). Only useful for =
kernel devs
> >
> > Tangent: should we update the kunit style guide to not refer to TAP
> > anymore as it's not accurate?
> > The KTAP spec is live on kernel.org at
> > https://www.kernel.org/doc/html/latest/dev-tools/ktap.html
> >
> > We can leave this patch as-is and update later, or have it be the
> > guinea pig for the new proposed wording.
>
> Oops, good point. I was actually thinking it doesn't make too much sense
> to keep repeating the same long boilerplate generally.
>

The KUnit style guide actually never referred to TAP in its example
Kconfig entry, though a number of existing tests did:
https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html#test-kcon=
fig-entries

> > (I'm personally in favor of people not copy-pasting these paragraphs
> > in the first place, but that is what the style-guide currently
> > recommends)
>
> Let's change the guide? :)
>

I don't think the actual text recommended in the guide is a problem:
it basically just points to the KUnit documentation, but I can send a
patch to soften the wording from "you MUST describe KUnit in the help
text" (or remove it entirely) if people really don't like it.

> >
> > > +         running KUnit test harness and are not for inclusion into a
> > > +         production build.
> > > +
> > > +         For more information on KUnit and unit tests in general ple=
ase refer
> > > +         to the KUnit documentation in Documentation/dev-tools/kunit=
/.
> > > +
> > > +         If unsure, say N.
> > > +
> > >  config COMPAT_BINFMT_ELF
> > >         def_bool y
> > >         depends on COMPAT && BINFMT_ELF
> > > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > > index 76ff2af15ba5..9bea703ed1c2 100644
> > > --- a/fs/binfmt_elf.c
> > > +++ b/fs/binfmt_elf.c
> > > @@ -2335,3 +2335,7 @@ static void __exit exit_elf_binfmt(void)
> > >  core_initcall(init_elf_binfmt);
> > >  module_exit(exit_elf_binfmt);
> > >  MODULE_LICENSE("GPL");
> > > +
> > > +#ifdef CONFIG_BINFMT_ELF_KUNIT_TEST
> > > +#include "binfmt_elf_test.c"
> > > +#endif
> > > diff --git a/fs/binfmt_elf_test.c b/fs/binfmt_elf_test.c
> > > new file mode 100644
> > > index 000000000000..486ad419f763
> > > --- /dev/null
> > > +++ b/fs/binfmt_elf_test.c
> > > @@ -0,0 +1,64 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +#include <kunit/test.h>
> > > +
> > > +static void total_mapping_size_test(struct kunit *test)
> > > +{
> > > +       struct elf_phdr empty[] =3D {
> > > +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0, .p_memsz =3D 0=
, },
> > > +               { .p_type =3D PT_INTERP, .p_vaddr =3D 10, .p_memsz =
=3D 999999, },
> > > +       };
> > > +       /*
> > > +        * readelf -lW /bin/mount | grep '^  .*0x0' | awk '{print "\t=
\t{ .p_type =3D PT_" \
> > > +        *                              $1 ", .p_vaddr =3D " $3 ", .p=
_memsz =3D " $6 ", },"}'
> > > +        */
> > > +       struct elf_phdr mount[] =3D {
> > > +               { .p_type =3D PT_PHDR, .p_vaddr =3D 0x00000040, .p_me=
msz =3D 0x0002d8, },
> > > +               { .p_type =3D PT_INTERP, .p_vaddr =3D 0x00000318, .p_=
memsz =3D 0x00001c, },
> > > +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x00000000, .p_me=
msz =3D 0x0033a8, },
> > > +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x00004000, .p_me=
msz =3D 0x005c91, },
> > > +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x0000a000, .p_me=
msz =3D 0x0022f8, },
> > > +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x0000d330, .p_me=
msz =3D 0x000d40, },
> > > +               { .p_type =3D PT_DYNAMIC, .p_vaddr =3D 0x0000d928, .p=
_memsz =3D 0x000200, },
> > > +               { .p_type =3D PT_NOTE, .p_vaddr =3D 0x00000338, .p_me=
msz =3D 0x000030, },
> > > +               { .p_type =3D PT_NOTE, .p_vaddr =3D 0x00000368, .p_me=
msz =3D 0x000044, },
> > > +               { .p_type =3D PT_GNU_PROPERTY, .p_vaddr =3D 0x0000033=
8, .p_memsz =3D 0x000030, },
> > > +               { .p_type =3D PT_GNU_EH_FRAME, .p_vaddr =3D 0x0000b49=
0, .p_memsz =3D 0x0001ec, },
> > > +               { .p_type =3D PT_GNU_STACK, .p_vaddr =3D 0x00000000, =
.p_memsz =3D 0x000000, },
> > > +               { .p_type =3D PT_GNU_RELRO, .p_vaddr =3D 0x0000d330, =
.p_memsz =3D 0x000cd0, },
> > > +       };
> > > +       size_t mount_size =3D 0xE070;
> > > +       /* https://lore.kernel.org/lkml/YfF18Dy85mCntXrx@fractal.loca=
ldomain */
> >
> > Slight nit, it looks like that message wasn't sent to lkml.
> > lore gives a suggestion to change to
> > https://lore.kernel.org/linux-fsdevel/YfF18Dy85mCntXrx@fractal.localdom=
ain/
>
> Ah, thank you. I was replacing the /r/ that used to be in that URL, and
> got lost. :)
>
> --
> Kees Cook

--000000000000e3e55e05d8bef0bd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCs
WFw6IjlTP+oNmws6QGvsZCR3WRZk9iW7sazkpiADeTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAyMjQwNzU4MDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAVnV+QiayILcefI+u3Qkz
2M621RV+SUXznv/oagA/5XZKfVig+/9Z4DHa8uxNOvsbzcNdZd4f7VtdibIb2QTZt6G6oYZZGq+z
M0LZOQs2SWN3P+0A2tqsimwp3CSt+G5d0zCHIhkQRHN1XoAhWOcNCZIk5CmkyShfx6jCTjP1SpWV
3e51WwPEqCsYHMpR9PNfG4LswP+HbzLovRlJV7SgWryyTUjDuRWuj6x6SAsk9HQJZoM2UA4e7FjF
PE3Ab7OEtaCNWxo1bBTWq69um+bDNHLAUzdsZdOW+N6w/+OaayNek76T9IReftmyvRzLfrdbvTXB
6ii3Hhg9BcvI6vNLxQ==
--000000000000e3e55e05d8bef0bd--
