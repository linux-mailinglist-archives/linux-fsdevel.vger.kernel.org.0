Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AC056AFB5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 03:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiGHAlA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 20:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGHAk7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 20:40:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE5370E4F;
        Thu,  7 Jul 2022 17:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6BEA8CE276E;
        Fri,  8 Jul 2022 00:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F750C3411E;
        Fri,  8 Jul 2022 00:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657240855;
        bh=IXsR/QrzvoIMkoWHmolTYwhwxD9j/FgCzzm8PhvI41I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BHrJ5+tCKYeD5Tmi/HULyLybxMAX92YkwnxJ0wQIUeGXK/c43NKQS8J8DqdH4Slh4
         yC8A4kxW/vtHiPmC1kV/FRP0xkTRJ44kLgf9oUzp2m05sNm0dmQcmkBXy0BNOGvtJN
         lw3ahGiwfRNWHCcUh3MMr95nBVCeQkUdV4kgaiGmAWrKRmm7Oktj/tFgeQGwJwHoNi
         HGxcnEaS1lnd09pAWMYZacRdZVWa23boN/R2kX/dPum11+hIzPS7ziMtahUDHrA47o
         BhTva9WGfwu3x1BSP1WTlaDWbkP9n6LXRxIR4nDTwss9wnlJFzH2AvMC9DSrDb1G0P
         6ioLZ2kFcQCFQ==
Date:   Thu, 7 Jul 2022 17:40:52 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [PATCH v5 2/4] module: panic: Taint the kernel when selftest
 modules load
Message-ID: <Ysd9FG1fOSnzKv8d@dev-arch.thelio-3990X>
References: <20220702040959.3232874-1-davidgow@google.com>
 <20220702040959.3232874-2-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702040959.3232874-2-davidgow@google.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 02, 2022 at 12:09:57PM +0800, David Gow wrote:
> Taint the kernel with TAINT_TEST whenever a test module loads, by adding
> a new "TEST" module property, and setting it for all modules in the
> tools/testing directory. This property can also be set manually, for
> tests which live outside the tools/testing directory with:
> MODULE_INFO(test, "Y");
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  kernel/module/main.c  | 7 +++++++
>  scripts/mod/modpost.c | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index fed58d30725d..730503561eb0 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1988,6 +1988,13 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
>  	/* Set up license info based on the info section */
>  	set_license(mod, get_modinfo(info, "license"));
>  
> +	if (!get_modinfo(info, "test")) {
> +		if (!test_taint(TAINT_TEST))
> +			pr_warn_once("%s: loading test module taints kernel.\n",
> +				     mod->name);
> +		add_taint_module(mod, TAINT_TEST, LOCKDEP_STILL_OK);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 29d5a841e215..5937212b4433 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2191,6 +2191,9 @@ static void add_header(struct buffer *b, struct module *mod)
>  
>  	if (strstarts(mod->name, "drivers/staging"))
>  		buf_printf(b, "\nMODULE_INFO(staging, \"Y\");\n");
> +
> +	if (strstarts(mod->name, "tools/testing"))
> +		buf_printf(b, "\nMODULE_INFO(test, \"Y\");\n");
>  }
>  
>  static void add_exported_symbols(struct buffer *buf, struct module *mod)
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog
> 
> 

Hi David,

This change has landed in linux-next as commit e20729ede7ed ("module:
panic: taint the kernel when selftest modules load") and on all of my
test machines, I see this new message printed, even though as far as I
am aware, I am not loading any testing modules. For example, in QEMU, I
see:

[    0.596978] serio: loading test module taints kernel.

and on my Honeycomb LX2, I see:

[    5.400861] fuse: loading test module taints kernel.

It seems like the get_modinfo() check might be wrong? The following diff
resolves it for me, I can send a formal patch if necessary (although it
appears to have gone in via -mm so I assume Andrew can squash this in).

Cheers,
Nathan

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 730503561eb0..4f91e41b8bc9 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1988,7 +1988,7 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 	/* Set up license info based on the info section */
 	set_license(mod, get_modinfo(info, "license"));
 
-	if (!get_modinfo(info, "test")) {
+	if (get_modinfo(info, "test")) {
 		if (!test_taint(TAINT_TEST))
 			pr_warn_once("%s: loading test module taints kernel.\n",
 				     mod->name);
