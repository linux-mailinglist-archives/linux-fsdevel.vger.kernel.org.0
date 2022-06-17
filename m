Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF5154FD0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 20:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiFQSp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 14:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbiFQSp5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:45:57 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2DC35DD3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 11:45:55 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id u99so8634023ybi.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 11:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t69yZaPZyOhoI5m6h+4mPKQ2+aXLu7liL3vlg7ZXpvc=;
        b=il8crSULlGQz05QE0HJEASQXvn2qoQaLFQqAZUe7KNy6sLCxE8wtDxs+T6w2gbX6is
         xu4hhOXS31wdIAe9JqlRtHPQEpAEpBMND7jnjl3F6RxZgU1tni39UrjlYB+9+OZshOxV
         gn5FRvwxzv2L7JtZU8K4T/Rq/ANecNK7c6E8M51aYccHSCxybwT7GnTTc4PtagYeFIMz
         ofPkhAAg7Jequ1qj2VsN9cL32C786s0dZzkJjsYRpxaNKvFVQlFIiibMWdOkSO2+SjK4
         Wnjs/DB5a7STrpHaH/QviUh02rHBTybRFMBjm5LBZG12neLP6iIXzkrHFpN5KN8H0y1A
         dTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t69yZaPZyOhoI5m6h+4mPKQ2+aXLu7liL3vlg7ZXpvc=;
        b=UC2tc0dsPGXe5KnU23B01bS1pd9EDCWCG//Lomot2KrVr2YoFHKz8gHsQSjwkJgJQd
         EovsrIr96Hzc0L2yfVsqfYB2ddVly2Ii+ums971og7V/tmDFyEBkQv0le9VWCvf4ObZ3
         Cd+vebOEt1PO+zCPpZnANWeL+bSU0YvYR8R8kt6R1W5SwzixnnjC9uAsUYZoZlO+ZuWp
         ZEbTBqN7pBuKw4WyPbTDfCHehPcLMY4MbZZjGUzj0IhffstzsnJU9InpOcmuJVqy9tGF
         RBjxGD95iu6bd9fPEIY9N0bF6VVFC2u91xUFcfqu+p6UYLYN4CLdDG4sV/yrntBqj3S8
         8CvQ==
X-Gm-Message-State: AJIora+AZCOB9viw204hkjEwqXpAnqy+b5MsjSptAid05nsQw7Ia+BlG
        OatgATHfLw9wcHcJ2FKKvkxE2JDvgIAEm/WUFdB3YKxNrto=
X-Google-Smtp-Source: AGRyM1vLqXiU6LvN9FeRt4QHUJN+8f1GRm6wQZeNYfa8yd42zjW3EX03bOZwFIL3249pJprqq7jSL3T03lYmRq54NE4=
X-Received: by 2002:a25:207:0:b0:668:6a4a:609 with SMTP id 7-20020a250207000000b006686a4a0609mr10829294ybc.326.1655491554504;
 Fri, 17 Jun 2022 11:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220616211016.4037482-1-dylanbhatch@google.com> <941e0991-eb3e-f988-8262-3d51ff8badad@linuxfoundation.org>
In-Reply-To: <941e0991-eb3e-f988-8262-3d51ff8badad@linuxfoundation.org>
From:   Dylan Hatch <dylanbhatch@google.com>
Date:   Fri, 17 Jun 2022 11:45:43 -0700
Message-ID: <CADBMgpwt2ALzBTtEm7v6DLL_9pjUhVLDpBLHXn1b0bvVf2BSvg@mail.gmail.com>
Subject: Re: [PATCH] selftests/proc: Fix proc-pid-vm for vsyscall=xonly.
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 16, 2022 at 4:01 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 6/16/22 3:10 PM, Dylan Hatch wrote:
> > This test would erroneously fail the /proc/$PID/maps case if
> > vsyscall=xonly since the existing probe of the vsyscall page only
> > succeeds if the process has read permissions. Fix this by checking for
> > either no vsyscall mapping OR an execute-only vsyscall mapping in the
> > case were probing the vsyscall page segfaults.
> >
>
> Does this fix include skipping the test with a clear message that
> says why test is skipped?
>
> > Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
> > ---
> >   tools/testing/selftests/proc/proc-pid-vm.c | 20 +++++++++++++++-----
> >   1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
> > index 28604c9f805c..5ca85520131f 100644
> > --- a/tools/testing/selftests/proc/proc-pid-vm.c
> > +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> > @@ -213,9 +213,12 @@ static int make_exe(const uint8_t *payload, size_t len)
> >
> >   static bool g_vsyscall = false;
> >
> > -static const char str_vsyscall[] =
> > +static const char str_vsyscall_rx[] =
> >   "ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
> >
> > +static const char str_vsyscall_x[] =
> > +"ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n";
> > +
> >   #ifdef __x86_64__
> >   static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
> >   {
> > @@ -261,6 +264,7 @@ int main(void)
> >       int exec_fd;
> >
> >       vsyscall();
> > +     const char *str_vsyscall = g_vsyscall ? str_vsyscall_rx : str_vsyscall_x;
> >
> >       atexit(ate);
> >
> > @@ -314,7 +318,8 @@ int main(void)
> >
> >       /* Test /proc/$PID/maps */
> >       {
> > -             const size_t len = strlen(buf0) + (g_vsyscall ? strlen(str_vsyscall) : 0);
> > +             const size_t len_buf0 = strlen(buf0);
> > +             const size_t len_vsys = strlen(str_vsyscall);
> >               char buf[256];
> >               ssize_t rv;
> >               int fd;
> > @@ -325,11 +330,16 @@ int main(void)
> >                       return 1;
> >               }
> >               rv = read(fd, buf, sizeof(buf));
> > -             assert(rv == len);
> > -             assert(memcmp(buf, buf0, strlen(buf0)) == 0);
> >               if (g_vsyscall) {
> > -                     assert(memcmp(buf + strlen(buf0), str_vsyscall, strlen(str_vsyscall)) == 0);
> > +                     assert(rv == len_buf0 + len_vsys);
> > +             } else {
> > +                     /* If vsyscall isn't readable, it's either x-only or not mapped at all */
> > +                     assert(rv == len_buf0 + len_vsys || rv == len_buf0);
> >               }
> > +             assert(memcmp(buf, buf0, len_buf0) == 0);
> > +             /* Check for vsyscall mapping if buf is long enough */
> > +             if (rv == len_buf0 + len_vsys)
> > +                     assert(memcmp(buf + len_buf0, str_vsyscall, len_vsys) == 0);
> >       }
> >
> >       /* Test /proc/$PID/smaps */
> >
>
> The change looks good to me. Doesn't look like it skips the test though?

Instead of skipping the test, it changes the passing condition to
accept both cases of an unmapped vsyscall page and an x-only vsyscall
page. Differentiating between these two cases without relying on
/proc/$PID/maps would involve both checking the kernel command line
for vsyscall=xonly and having a special ifdef block for
CONFIG_VSYSCALL_XONLY, so accepting both as passing conditions seems
like a simpler solution.

Thanks,
Dylan
