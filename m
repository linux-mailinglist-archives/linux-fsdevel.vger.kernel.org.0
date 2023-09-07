Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4D5797813
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 18:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbjIGQlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 12:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240010AbjIGQlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:41:20 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BEF284CE
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 08:47:40 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bcb54226e7so13117391fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Sep 2023 08:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694101585; x=1694706385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+/xavPfeHKkM5Edb1Fs57Ak7muWryzIAsBFEjQC6YKw=;
        b=slHYvwBz5rr519lRAazUqONDu3ppRmtQZwq0h7L2Nz1JBxeTRKNGTPk+7TNtZS1+LK
         0aU5KQinc8M5WSQx7X6bp3eHuaIxS+7O26tp2sIJfudpwD6119EOHigQuNyoGm7dpvO2
         wTjRmvqY/Zj7KDSOwfBUAHSwQEBpbkNXLotZqurPm5Cj9c+s63gkmKfeBErAf/vwo0Tq
         waFEesnN3NPkyxptcGo38ZiZ7xVsWv1hXC4GPyM+/JObmUcmPa0sXC372KRqdB52vPlr
         3Qf8XeU94dNaxneieH2LeHsDfYcFgs1EZcIzPyyiOXZurw9oM3T26k3uL3A1j73oMyRI
         C7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101585; x=1694706385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/xavPfeHKkM5Edb1Fs57Ak7muWryzIAsBFEjQC6YKw=;
        b=A6/x7VnhAP8p31FOrJA6cUWXawBHyoGrOuTGACbx3TQT3ZlRWPNa/j1kh3pdKE2GPx
         Z5z2sBzyd1qjWLEHH+WDaZvwcHSzeji+4pdMt5gRA00C7LNuw6vjp7swu/8Jfh0TAek+
         1fmjDaBwkJpo2dqJB8EsqHPlFN5tEl9r4fZm4JM80zdliZLb6l/Ist4jcmdawCJFAxiZ
         BKOoq/KHe543nryvFvW9NlrhWnxwbi7TOWyeKKn0FKzC6X+FjM8PoMLJOrknyrFAwell
         ga11lernXCQrzG3J0eufeZKhu/bI4NnAON6cwWZSMcZ8immP6Mi0+vZ2RxrsxfrYU0nY
         Cl9A==
X-Gm-Message-State: AOJu0YwqtqnFp+H3a9mSz/5phzUcfU62EpGX0avGtj3kQXpRwIZb9u6c
        NWW4sWN9dDC3uAg0jzTaK/bNyyQBuk5SjGWfCiw=
X-Google-Smtp-Source: AGHT+IECB9k1RoR69ENUNhn2CpFuTYnYdpxvNiieJ33Nc1+rYNTbtaD4fi9Kzgag3CTTMvD+59exlg==
X-Received: by 2002:a05:600c:492f:b0:401:431e:2d03 with SMTP id f47-20020a05600c492f00b00401431e2d03mr1584782wmp.14.1694080109945;
        Thu, 07 Sep 2023 02:48:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c218600b003fe1c332810sm1971573wme.33.2023.09.07.02.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:48:29 -0700 (PDT)
Date:   Thu, 7 Sep 2023 12:48:25 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, gcc-patches@gcc.gnu.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <4af7c904-ac36-44c9-83c4-2cb30c732672@kadam.mountain>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
 <20230906215327.18a45c89@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906215327.18a45c89@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 09:53:27PM -0400, Steven Rostedt wrote:
> On Thu, 7 Sep 2023 08:54:38 +1000
> Dave Chinner <david@fromorbit.com> wrote:
> 
> > And let's not forget: removing a filesystem from the kernel is not
> > removing end user support for extracting data from old filesystems.
> > We have VMs for that - we can run pretty much any kernel ever built
> > inside a VM, so users that need to extract data from a really old
> > filesystem we no longer support in a modern kernel can simply boot
> > up an old distro that did support it and extract the data that way.
> 
> Of course there's the case of trying to recreate a OS that can run on a
> very old kernel. Just building an old kernel is difficult today because
> today's compilers will refuse to build them (I've hit issues in bisections
> because of that!)

Yeah.  I can't run Smatch on obsolete kernels because I can't build the
tools/ directory etc.  For example, it would be interesting to look at
really ancient kernels to see how buggy they are.  I started to hunt
down all the Makefile which add a -Werror but there are a lot and
eventually I got bored and gave up.

Someone should patch GCC so there it checks an environment variable to
ignore -Werror.  Somethine like this?

diff --git a/gcc/opts.cc b/gcc/opts.cc
index ac81d4e42944..2de69300d4fe 100644
--- a/gcc/opts.cc
+++ b/gcc/opts.cc
@@ -2598,6 +2598,17 @@ print_help (struct gcc_options *opts, unsigned int lang_mask,
 			 lang_mask);
 }
 
+static bool
+ignore_w_error(void)
+{
+  char *str;
+
+  str = getenv("IGNORE_WERROR");
+  if (str && strcmp(str, "1") == 0)
+    return true;
+  return false;
+}
+
 /* Handle target- and language-independent options.  Return zero to
    generate an "unknown option" message.  Only options that need
    extra handling need to be listed here; if you simply want
@@ -2773,11 +2784,15 @@ common_handle_option (struct gcc_options *opts,
       break;
 
     case OPT_Werror:
+      if (ignore_w_error())
+	break;
       dc->warning_as_error_requested = value;
       break;
 
     case OPT_Werror_:
-      if (lang_mask == CL_DRIVER)
+     if (ignore_w_error())
+	break;
+     if (lang_mask == CL_DRIVER)
 	break;
 
       enable_warning_as_error (arg, value, lang_mask, handlers,
