Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B578797492
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 17:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbjIGPkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 11:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245715AbjIGPaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:30:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD941BF9
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 08:29:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c5c06e8bbso1072646f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Sep 2023 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100538; x=1694705338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WfXAsmoB4WfS+F7T1nJonWeYIccVQBht5j3GC7Xo5VQ=;
        b=l12NoQaADeX1wQV8OPkhENU1v8u3+chj038uXBn6ovKUuBAE9+3CcRJ8DE7RB3TuzZ
         Nm2rqXQhRUriBG/ECojNfdFZD7ul1Ecdx/+3sMvJXurNmnZ4THV547wq/NwqNCPmlMIZ
         BCVbpFmoTBlNFH/L9uw7ssW8lXkFI6rkDfjgPKKQVQsSUq4m51M05/HhPbyFBajOaWsT
         jk4YpipTaFnZnpKUIPPwFDw5drDJyboR8jJ5CGwtefnMP4SPR0Wr3ugkYZE3iGk7ltjR
         AJNuZRsysZnGJgFU9oANMnpqSyvM+fU7Opk774hKsBiapQdBsmstSOrqtn4bhhqfiwWH
         XVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100538; x=1694705338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfXAsmoB4WfS+F7T1nJonWeYIccVQBht5j3GC7Xo5VQ=;
        b=E5BdT0vSZc1weFb3R3SOCc0otmZKlxJjicj6akQrHQF1nFn9FJxtONgL/Zszp23sWj
         KyNiCN8wlgkBIkK7Alw9mL/STWI32Nfn8GwumsEww7gyQGDt1I5On3aIb8HJm0iky7MK
         ApVfB+r4YPW2jxWHGUUCTFmpM7oLCOEbk1oM+N0UR68oOehewl4pgTSX5ijGXSwKQm+J
         m2N4DFQKIZXAhG0TUtv2CuNxHOvFgHGrQkZwc1X118GxdBhboAL3HDl7OSZVtXlY6Ak4
         UbOMlu7h7XutJcE6rE0FVZGWty4VD1O2yH0b/QA2ti4lWlIMmgVFlowGeOOS2pDrwpN4
         mMPA==
X-Gm-Message-State: AOJu0YySi9lJAKX/RQdtd3DAqDD4gHfMmc6p8jTRkqNlwdJNdqn4l5lB
        2ZLFg3/SA7XYjtgD6Mw0i/4mduPSUT3mpI3QCgo=
X-Google-Smtp-Source: AGHT+IG5FsrtNwEQuNvPmbB9vmAGew+7DEruqR4J6dlaEKAvYhDUHjzzZrxVYkb/967NrsZmUgv7Jw==
X-Received: by 2002:a05:600c:1d09:b0:402:eaae:e6e0 with SMTP id l9-20020a05600c1d0900b00402eaaee6e0mr2224356wms.8.1694085783074;
        Thu, 07 Sep 2023 04:23:03 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y25-20020a7bcd99000000b0040210a27e29sm2221206wmj.32.2023.09.07.04.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 04:23:02 -0700 (PDT)
Date:   Thu, 7 Sep 2023 14:23:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, gcc-patches@gcc.gnu.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <bd1fb81a-6bb7-4ab4-9f8c-55307f3e9590@kadam.mountain>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
 <20230906215327.18a45c89@gandalf.local.home>
 <4af7c904-ac36-44c9-83c4-2cb30c732672@kadam.mountain>
 <20230907110409.GH19790@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907110409.GH19790@gate.crashing.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 07, 2023 at 06:04:09AM -0500, Segher Boessenkool wrote:
> On Thu, Sep 07, 2023 at 12:48:25PM +0300, Dan Carpenter via Gcc-patches wrote:
> > I started to hunt
> > down all the Makefile which add a -Werror but there are a lot and
> > eventually I got bored and gave up.
> 
> I have a patch stack for that, since 2014 or so.  I build Linux with
> unreleased GCC versions all the time, so pretty much any new warning is
> fatal if you unwisely use -Werror.
> 
> > Someone should patch GCC so there it checks an environment variable to
> > ignore -Werror.  Somethine like this?
> 
> No.  You should patch your program, instead.

There are 2930 Makefiles in the kernel source.

> One easy way is to add a
> -Wno-error at the end of your command lines.  Or even just -w if you
> want or need a bigger hammer.

I tried that.  Some of the Makefiles check an environemnt variable as
well if you want to turn off -Werror.  It's not a complete solution at
all.  I have no idea what a complete solution looks like because I gave
up.

> 
> Or nicer, put it all in Kconfig, like powerpc already has for example.
> There is a CONFIG_WERROR as well, so maybe use that in all places?

That's a good idea but I'm trying to compile old kernels and not the
current kernel.

regards,
dan carpenter

