Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC577FB49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 17:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjHQPze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 11:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353461AbjHQPzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:55:24 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3139B35A6
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 08:54:55 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-643909db8f4so5230146d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692287693; x=1692892493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdyk/H9C92iJ/nBsFz7KxfsAvK+nt2wqCERHewxGWDU=;
        b=cSQl7yt9otQXr+oR1mB0nAUMSggLBbl+x+yeuUh1BRvaPLY+5BVUHA9XY5vpaXnLwQ
         I+HaTYsLWZHnC7qtaOHGmjwLl2/5BHmdv59N00yHP6YIcH7jJklGoMStSDd1TVKHohCi
         pampRnwpD239s80gaLdHchFzC+a0w1oyAyFF1jWVzncrcQ0lgekpayKIU84Rd1wDjF4I
         2/9khJ3u2ek6tzpqBd6IcgbZJC/89kWqNXeD8h1HeTAz3F/rP/W+L+zXszK4BEOLJ0b4
         3bbWj4Gz0sm0DQOMRz2udncq5GAXL9t8Thff9BLCqlRWq9CksSuetZI7++mKz8RzoAHd
         WVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692287693; x=1692892493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdyk/H9C92iJ/nBsFz7KxfsAvK+nt2wqCERHewxGWDU=;
        b=em+bprtbzVxz6sRgcjdSqiPMOONHUvx5Ir1Zin8BhcWsf11UH6cmOYjp8eDRwnpTdH
         Gj66+nz6MXMsW/csByE+bhIo6h5MmrFUUeCAZ0uznwbmcEt3D6CBQ45z1B6EuWJmrbUO
         vQAPBZiuqJVX42yfnJ6tK9a+6sL4W+isrqvXRBQCh/eLwn/oqxQIEyJgsSo5DELBHZhn
         YUZJywxhcFTe1gHdWtNEv3PwKfyDO2TPwEP+cfH2/1B830YvpVkfxwnzAO/7Hpc8mQka
         8/ki+D9TVEVB85PO6p/R5oLjrHtUvqYfVRzNbTl1ZWg9EPkyzxpFzv9Atg68IZuyaN3b
         G6ww==
X-Gm-Message-State: AOJu0Yy4UXNOQbbcnDfd+jDTo9zGxe1z1hOoevDsgT8LF/g7eCvGcLoy
        yRCb969XHJP3yNwOX4/pX0VBuPkBO8yqAa11oKo4+Q==
X-Google-Smtp-Source: AGHT+IHBoKIXOzw8g/P24SXKwipUqCn2o2dUKOdGE5ZCNm3euEjtUFmlPq+7vYSmTIjnuxYVtNffFqtgOHvxVmtNMww=
X-Received: by 2002:a0c:e094:0:b0:61b:65f4:2a15 with SMTP id
 l20-20020a0ce094000000b0061b65f42a15mr4345292qvk.12.1692287692656; Thu, 17
 Aug 2023 08:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvFD-kE0+EGWkwcnR1DXRxh7p7OwQThJ6KWxYWVROJ4+A@mail.gmail.com>
In-Reply-To: <CA+G9fYvFD-kE0+EGWkwcnR1DXRxh7p7OwQThJ6KWxYWVROJ4+A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 17 Aug 2023 08:54:41 -0700
Message-ID: <CAKwvOd=h4aFisiY0w0awKkxk+i-aJM5+QbExYnboqzojLigx1Q@mail.gmail.com>
Subject: Re: landlock: fs_test: fs_test.c:4524:9: error: initializer element
 is not a compile-time constant
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 17, 2023 at 3:51=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> While building selftests landlock following warnings / errors noticed on =
the
> Linux next with clang-17.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Build errors:
> ------------
> landlock/fs_test
> fs_test.c:4524:9: error: initializer element is not a compile-time consta=
nt

Hi Naresh,
Can you tell me more about your specific version of clang-17?

I believe a fix of mine to clang should address this. It landed in
clang-18, and was backported to clang-17 recently.
https://github.com/llvm/llvm-project-release-prs/commit/0b2d5b967d983757938=
97295d651f58f6fbd3034

I suspect your clang-17 might need a rebuild.  Thanks for the report.

>  4524 |         .mnt =3D mnt_tmp,
>       |                ^~~~~~~
> 1 error generated.
>
> Links:
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2U69ue7AaypfY7e=
RU4UUygecrDx/
>
> Steps to reproduce:
> tuxmake --runtime podman --target-arch arm64 --toolchain clang-17
> --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2U69ue7A=
aypfY7eRU4UUygecrDx/config
> LLVM=3D1 LLVM_IAS=3D1 dtbs dtbs-legacy headers kernel kselftest modules
>
> --
> Linaro LKFT
> https://lkft.linaro.org
>


--=20
Thanks,
~Nick Desaulniers
