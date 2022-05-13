Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E725269E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 21:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383555AbiEMTJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 15:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243213AbiEMTJ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 15:09:27 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF747377EB
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 12:09:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b18so16049995lfv.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbJzGXtyUp4FkqReU6sYBiDMNKWwFopa4KLMlmGZbuA=;
        b=GJx1FC6PGj6rP204JhO+MVJD1p9S4B+WG3Wu3TnyVIi0CzstjPqeEwc9SpcYJe1l2R
         TXfW9mAAliWx/XxYsTGa4JGZi1ldNXUsBVx/1fAKAjk52jHYQR53XvuCTMBvBpn6MgRR
         nvpW/IRmtZIRvLyMS+gjblxH1h5ebwHsII+gRQJhlnTz2JmCdju6VXzbxiZrzjAU0G8S
         qEZAkEjFjZm5uCyVG1A9FYdpEJXEIggJw4e8FDvUWWObJAj2ttke1r3VSENsFthwAaHE
         UD/Jt3UM0xd083pDPRmEB5Y8Wcl8Crk4Yp0PFs+XzKdG15jB7LAq0MZO7OESoHhu2wHG
         Klkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbJzGXtyUp4FkqReU6sYBiDMNKWwFopa4KLMlmGZbuA=;
        b=2V7xSTuZOx/+FhA0WOzEOdwaF2cr3W6XKcKHcbIyNm2K1oj3xOFALvH1iDwGz3sK3p
         gxVyec1efDaSkJAKdrChu2ru+j6LUt5SKHtr5YTfIc50WDodoI6vbZISKm8sf4V4pfr3
         yWaELr79X/jqR2RpRCNn3hd6b7cApZpd1ny8cRrQvz0Ho+nPqLwiqU5NACxDWp0VEY+h
         PMkJ6gNdhWP0UViWAOpQ4yQfshIzCLnIFNBqXk4sM5J1yq2CplFNf+bHMbFDGnUtzzHw
         +jGj2YcU5RfGzMYpb/YouLvpNAiSL3QnI+1b2FiGNL36CE/egUKfYG3JkL6gLSnhSIiY
         rUNA==
X-Gm-Message-State: AOAM532V5JutVP/YhIsGJEaGCP7gbVyarPFMh1AIpJENv9wpi/xGzVLc
        vHYidU70s1vO/UZeeazA5UkZW7G5KZ3h3+9Oc7BSwA==
X-Google-Smtp-Source: ABdhPJw2v+78PG9kRlrr2N0DSVUm9/qtjQv8JgVoDVhvaTi3qjv3ZFLpx/pOXFQCTgDrEl1P0PwYOBSHt4h+KgElKzY=
X-Received: by 2002:a05:6512:104a:b0:473:d38b:cdf with SMTP id
 c10-20020a056512104a00b00473d38b0cdfmr4633370lfb.554.1652468963837; Fri, 13
 May 2022 12:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com> <20220513083212.3537869-2-davidgow@google.com>
In-Reply-To: <20220513083212.3537869-2-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 13 May 2022 12:08:46 -0700
Message-ID: <CAGS_qxr54nYThsj6UhqX54JO5WnyJXVQURnNF1eCzGB+4GCKLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kunit: Taint the kernel when KUnit tests are run
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
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

On Fri, May 13, 2022 at 1:32 AM David Gow <davidgow@google.com> wrote:
>
> Make KUnit trigger the new TAINT_TEST taint when any KUnit test is run.
> Due to KUnit tests not being intended to run on production systems, and
> potentially causing problems (or security issues like leaking kernel
> addresses), the kernel's state should not be considered safe for
> production use after KUnit tests are run.
>
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Daniel Latypov <dlatypov@google.com>

Looks good to me.

There's an edge case where we might have 0 suites or 0 tests and we
still taint the kernel, but I don't think we need to deal with that.
At the start of kunit_run_tests() is the cleanest place to do this.

I wasn't quite sure where this applied, but I manually applied the changes here.
Without this patch, this command exits fine:
$ ./tools/testing/kunit/kunit.py run --kernel_args=panic_on_taint=0x40000

With it, I get
[12:03:31] Kernel panic - not syncing: panic_on_taint set ...
[12:03:31] CPU: 0 PID: 1 Comm: swapper Tainted: G                 N
5.17.0-00001-gea9ee5e7aed8-dirty #60

I'm a bit surprised that it prints 'G' and not 'N', but this does seem
to be the right mask
$ python3 -c 'print(hex(1<<18))'
0x40000
and it only takes effect when this patch is applied.
I'll chalk that up to my ignorance of how taint works.
