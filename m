Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CE5563300
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 13:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiGALzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 07:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiGALzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:55:23 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D075823BD;
        Fri,  1 Jul 2022 04:55:22 -0700 (PDT)
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mx0.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LZDCt0kflzDqJx;
        Fri,  1 Jul 2022 11:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1656676522; bh=OmDfSiag79ufUXArN30LVk+EOWL3+NU7HJfkYVWwnEs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bQmFDRdMJzvZTv/048CChDzvcBkOHgUQrFztw2zatFqVCRWgxr+6Z9hGp2H+K6qo6
         DurzcHXdVEd4pPQAZD68gGbXIIYqjtd/FcDmnpEhG4uniXrUNj6zKPVQGTLEysMJ0h
         zLj4E9Eu+i6/9dq5kkXZcD+X+PEg1RMqQW6yxIhE=
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LZDCr1fmPz9tBq;
        Fri,  1 Jul 2022 11:55:20 +0000 (UTC)
X-Riseup-User-ID: 58664E14B2D373C4C74D8CFBD14FDC6AA3184A3116830436C65DB32C22F59FC5
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LZDCg5zQxz5vw3;
        Fri,  1 Jul 2022 11:55:11 +0000 (UTC)
Message-ID: <f361c4b7-12b8-0513-2025-4ed8025a67d1@riseup.net>
Date:   Fri, 1 Jul 2022 08:55:07 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/4] kunit: Taint the kernel when KUnit tests are run
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20220701084744.3002019-1-davidgow@google.com>
 <20220701084744.3002019-3-davidgow@google.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220701084744.3002019-3-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/1/22 05:47, 'David Gow' via KUnit Development wrote:
> Make KUnit trigger the new TAINT_TEST taint when any KUnit test is run.
> Due to KUnit tests not being intended to run on production systems, and
> potentially causing problems (or security issues like leaking kernel
> addresses), the kernel's state should not be considered safe for
> production use after KUnit tests are run.
> 
> This both marks KUnit modules as test modules using MODULE_INFO() and
> manually taints the kernel when tests are run (which catches builtin
> tests).
> 
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> Tested-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---

Tested with DRM KUnit tests on x86_64.

Tested-By: Maíra Canal <mairacanal@riseup.net>

Best Regards
- Maíra Canal

> 
> Changes since v3:
> https://lore.kernel.org/lkml/20220513083212.3537869-2-davidgow@google.com/
> - Use MODULE_INFO() for KUnit modules.
>   - This is technically redundant, as the KUnit executor will taint the
>     kernel when _any_ KUnit tests are run, but may be useful if some
>     other tool will parse the 'test' property.
> - Add {Acked,Tested,Reviewed}-by tags.
> 
> ---
>  include/kunit/test.h | 3 ++-
>  lib/kunit/test.c     | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 8ffcd7de9607..ccae848720dc 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -277,7 +277,8 @@ static inline int kunit_run_all_tests(void)
>  	{								\
>  		return __kunit_test_suites_exit(__suites);		\
>  	}								\
> -	module_exit(kunit_test_suites_exit)
> +	module_exit(kunit_test_suites_exit)				\
> +	MODULE_INFO(test, "Y");
>  #else
>  #define kunit_test_suites_for_module(__suites)
>  #endif /* MODULE */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index a5053a07409f..8b11552dc215 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -11,6 +11,7 @@
>  #include <kunit/test-bug.h>
>  #include <linux/kernel.h>
>  #include <linux/moduleparam.h>
> +#include <linux/panic.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched.h>
>  
> @@ -501,6 +502,9 @@ int kunit_run_tests(struct kunit_suite *suite)
>  	struct kunit_result_stats suite_stats = { 0 };
>  	struct kunit_result_stats total_stats = { 0 };
>  
> +	/* Taint the kernel so we know we've run tests. */
> +	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
> +
>  	if (suite->suite_init) {
>  		suite->suite_init_err = suite->suite_init(suite);
>  		if (suite->suite_init_err) {
