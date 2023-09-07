Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C75797C1C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 20:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbjIGSle (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 14:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbjIGSlc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:41:32 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 11:41:28 PDT
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41D4D91
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 11:41:28 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 387CUHJ4021715;
        Thu, 7 Sep 2023 07:30:17 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 387CUGIJ021714;
        Thu, 7 Sep 2023 07:30:16 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 7 Sep 2023 07:30:16 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, gcc-patches@gcc.gnu.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <20230907123016.GJ19790@gate.crashing.org>
References: <ZO9NK0FchtYjOuIH@infradead.org> <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net> <ZPkDLp0jyteubQhh@dread.disaster.area> <20230906215327.18a45c89@gandalf.local.home> <4af7c904-ac36-44c9-83c4-2cb30c732672@kadam.mountain> <20230907110409.GH19790@gate.crashing.org> <bd1fb81a-6bb7-4ab4-9f8c-55307f3e9590@kadam.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1fb81a-6bb7-4ab4-9f8c-55307f3e9590@kadam.mountain>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 07, 2023 at 02:23:00PM +0300, Dan Carpenter wrote:
> On Thu, Sep 07, 2023 at 06:04:09AM -0500, Segher Boessenkool wrote:
> > On Thu, Sep 07, 2023 at 12:48:25PM +0300, Dan Carpenter via Gcc-patches wrote:
> > > I started to hunt
> > > down all the Makefile which add a -Werror but there are a lot and
> > > eventually I got bored and gave up.
> > 
> > I have a patch stack for that, since 2014 or so.  I build Linux with
> > unreleased GCC versions all the time, so pretty much any new warning is
> > fatal if you unwisely use -Werror.
> > 
> > > Someone should patch GCC so there it checks an environment variable to
> > > ignore -Werror.  Somethine like this?
> > 
> > No.  You should patch your program, instead.
> 
> There are 2930 Makefiles in the kernel source.

Yes.  And you need patches to about thirty.  Or a bit more, if you want
to do it more cleanly.  This isn't a guess.

> > One easy way is to add a
> > -Wno-error at the end of your command lines.  Or even just -w if you
> > want or need a bigger hammer.
> 
> I tried that.  Some of the Makefiles check an environemnt variable as
> well if you want to turn off -Werror.  It's not a complete solution at
> all.  I have no idea what a complete solution looks like because I gave
> up.

A solution can not involve changing the compiler.  That is just saying
the kernel doesn't know how to fix its own problems, so let's give the
compiler some more unnecessary problems.

> > Or nicer, put it all in Kconfig, like powerpc already has for example.
> > There is a CONFIG_WERROR as well, so maybe use that in all places?
> 
> That's a good idea but I'm trying to compile old kernels and not the
> current kernel.

You can patch older kernels, too, you know :-)

If you need to not make any changes to your source code for some crazy
reason (political perhaps?), just use a shell script or shell function
instead of invoking the compiler driver directly?


Segher

Segher
