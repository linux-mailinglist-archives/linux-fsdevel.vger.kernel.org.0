Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78627797C1D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 20:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbjIGSlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 14:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjIGSle (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:41:34 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F84B92
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 11:41:30 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 387B4Ctx017865;
        Thu, 7 Sep 2023 06:04:12 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 387B4Avd017864;
        Thu, 7 Sep 2023 06:04:10 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 7 Sep 2023 06:04:09 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, gcc-patches@gcc.gnu.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <20230907110409.GH19790@gate.crashing.org>
References: <ZO9NK0FchtYjOuIH@infradead.org> <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net> <ZPkDLp0jyteubQhh@dread.disaster.area> <20230906215327.18a45c89@gandalf.local.home> <4af7c904-ac36-44c9-83c4-2cb30c732672@kadam.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4af7c904-ac36-44c9-83c4-2cb30c732672@kadam.mountain>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 07, 2023 at 12:48:25PM +0300, Dan Carpenter via Gcc-patches wrote:
> I started to hunt
> down all the Makefile which add a -Werror but there are a lot and
> eventually I got bored and gave up.

I have a patch stack for that, since 2014 or so.  I build Linux with
unreleased GCC versions all the time, so pretty much any new warning is
fatal if you unwisely use -Werror.

> Someone should patch GCC so there it checks an environment variable to
> ignore -Werror.  Somethine like this?

No.  You should patch your program, instead.  One easy way is to add a
-Wno-error at the end of your command lines.  Or even just -w if you
want or need a bigger hammer.

Or nicer, put it all in Kconfig, like powerpc already has for example.
There is a CONFIG_WERROR as well, so maybe use that in all places?

> +static bool
> +ignore_w_error(void)
> +{
> +  char *str;
> +
> +  str = getenv("IGNORE_WERROR");
> +  if (str && strcmp(str, "1") == 0)

space before (

>      case OPT_Werror:
> +      if (ignore_w_error())
> +	break;
>        dc->warning_as_error_requested = value;
>        break;
>  
>      case OPT_Werror_:
> -      if (lang_mask == CL_DRIVER)
> +     if (ignore_w_error())
> +	break;
> +     if (lang_mask == CL_DRIVER)
>  	break;

The new indentation is messed up.  And please don't move the existing
early-out to later, it make more sense earlier, the way it was.


Segher
