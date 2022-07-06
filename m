Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A7B569399
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 22:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiGFUv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 16:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiGFUv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:51:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E07B1DA76
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jul 2022 13:51:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r18so20723270edb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jul 2022 13:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VmZUiPaBEY+cXoKQEoYr43kUreC3uQvFIkJqH2JKuKw=;
        b=QD1S/pElGHXVUsbOmqKCJB4tIT2LfKNYBwHeoK3ZI0DUMJILHVe6a82Q51su0piYKu
         wuNjrhR6iGEs41/j83fS0VOXdLGDC6asG7vO4XB5AOJHml40d/7E81YUshGRRsZLp7yK
         YgqESFS3mE58ornuH7MKbtS1MNrDqi8gLHYc0cJ10T1Vjl8lFv/u/9nVoNAzXNq2yu5d
         KKY+GZniHeVduR4B1nopMwBhJcXsqDnVKsx/9Nkcv1kOzPPl0sgrgRyDMbTdTHSRX5nL
         ZDmD6e+7ToOKGWtMTrJ9o4Zr6WB6gnClrjpkjlWmxx2lI5hXctf5yaGv4ROswY0vcywN
         Jgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmZUiPaBEY+cXoKQEoYr43kUreC3uQvFIkJqH2JKuKw=;
        b=b/fP+4K5VsLR0UmIrMaSch49WE+GSPxNEtAIHiozkwIYsIGYTLIhksxgfYO5K/eT6Y
         y9fAoBCstn7/Tzwx0O16BLqsn9wV60Nku8yrHqsL9imJTOsZEU9GUckU8UJYCs1ZWBFz
         SRCztVveSR5oXfeMzxmIH+w2TWiZtah3XoF2nV2iGhopsq2PXBqnnZ+IoWIDfcY3IKgT
         zLZv12RO/kDFRgOQGB8yedx/BBr1jc5g81DRIwmUPLJtUYetBBUHozX75cHJ0Q5vzAvR
         U8dGxJjJo3deuO0DrfNjG6V3BJlhsomdnhG+VGpjJj0DP+LxdYvAtHepgqAtbjoLFohL
         eAvQ==
X-Gm-Message-State: AJIora9AzDerwClKyHd4x9g0DiQRVIlNAtmhMffc+EoLs6lBDUU4W5Lu
        cdDIQ9JvbTng9TYjvsZJIOf1cqJ0FG/Na4nBOwXocg==
X-Google-Smtp-Source: AGRyM1uXmEISRIAhzaxjULC8UcUDmf4l9YHviL80jd8DC+UnXMdhKjYQ9ycbYK2+NxJjLT6FGvT1yqEgJqWM6jd2Bvk=
X-Received: by 2002:a05:6402:43c4:b0:43a:6309:6c9b with SMTP id
 p4-20020a05640243c400b0043a63096c9bmr23105912edc.91.1657140713645; Wed, 06
 Jul 2022 13:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220702040959.3232874-1-davidgow@google.com> <20220702040959.3232874-4-davidgow@google.com>
In-Reply-To: <20220702040959.3232874-4-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 16:51:42 -0400
Message-ID: <CAFd5g44q5EPS=v_DDUxBJnO1htMSyB=GNXpP0KkVNuOapehk-A@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] selftest: Taint kernel when test module loaded
To:     David Gow <davidgow@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Jul 2, 2022 at 12:10 AM David Gow <davidgow@google.com> wrote:
>
> Make any kselftest test module (using the kselftest_module framework)
> taint the kernel with TAINT_TEST on module load.
>
> Also mark the module as a test module using MODULE_INFO(test, "Y") so
> that other tools can tell this is a test module. We can't rely solely
> on this, though, as these test modules are also often built-in.
>
> Finally, update the kselftest documentation to mention that the kernel
> should be tainted, and how to do so manually (as below).
>
> Note that several selftests use kernel modules which are not based on
> the kselftest_module framework, and so will not automatically taint the
> kernel.
>
> This can be done in two ways:
> - Moving the module to the tools/testing directory. All modules under
>   this directory will taint the kernel.
> - Adding the 'test' module property with:
>   MODULE_INFO(test, "Y")
>
> Similarly, selftests which do not load modules into the kernel generally
> should not taint the kernel (or possibly should only do so on failure),
> as it's assumed that testing from user-space should be safe. Regardless,
> they can write to /proc/sys/kernel/tainted if required.
>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
