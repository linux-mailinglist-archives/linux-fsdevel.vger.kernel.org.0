Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF3977072D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 19:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjHDRde (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 13:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjHDRdd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0459D4C02;
        Fri,  4 Aug 2023 10:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 719F6620D1;
        Fri,  4 Aug 2023 17:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC59AC433C8;
        Fri,  4 Aug 2023 17:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691170408;
        bh=nlkIEx1KzJm50LRClCa9/AP0mjR7clvVLXYwDLue/k8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QEwRbPUpFUR4NbdcRfrDFCIpFCTPkty5T2CIZMihCwYUeDWrruLNf2r+06F8l91nn
         ifNoiMJsFWH3xo9rZxgAMFPGhuu3FCRrif0tABAOILSi/5OUyC0if+z06oX4edNGIx
         g+865ek8wKaRtUxG+Ll+Zj1Q1POtdbXq1nZ5BQSJ0QoqkXHRD0REpS4yZBeNzopljb
         Fuwg0oQKbFQ7Udez9li9X9aTnf5e7KeGyb7Ncp7o1ZgL4AJ9IlG878CI5OLC9G5RrM
         GxpjmuOR2wB4yLMVSkpbeXvITScS8Lo5L1jS5vZ77ZkpWZhoyDQlCnKGCPRifVpABa
         7zvn1iZkjgTUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5E4EBCE0591; Fri,  4 Aug 2023 10:33:28 -0700 (PDT)
Date:   Fri, 4 Aug 2023 10:33:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, mhiramat@kernel.org, arnd@kernel.org,
        ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 2/2] fs/proc: Add /proc/cmdline_image for
 embedded arguments
Message-ID: <8de1aca1-81bf-4c4b-b5b7-16f76640fdb1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
 <20230728033701.817094-2-paulmck@kernel.org>
 <aff81f30-e20d-40a0-adb3-893781459475@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aff81f30-e20d-40a0-adb3-893781459475@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 04, 2023 at 08:28:08PM +0300, Alexey Dobriyan wrote:
> On Thu, Jul 27, 2023 at 08:37:01PM -0700, Paul E. McKenney wrote:
> > In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will show
> > all kernel boot parameters, both those supplied by the boot loader and
> > those embedded in the kernel image.  This works well for those who just
> > want to see all of the kernel boot parameters, but is not helpful to those
> > who need to see only those parameters that were embedded into the kernel
> > image.  This is especially important in situations where there are many
> > kernel images for different kernel versions and kernel configurations,
> > all of which opens the door to a great deal of human error.
> > 
> > Therefore, provide a /proc/cmdline_image file that shows only those kernel
> > boot parameters that were embedded in the kernel image.  The output
> > is in boot-image format, which allows easy reconcilation against the
> > boot-config source file.
> > 
> > Why put this in /proc?  Because it is quite similar to /proc/cmdline, so
> > it makes sense to put it in the same place that /proc/cmdline is located.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Alexey Dobriyan <adobriyan@gmail.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: <linux-fsdevel@vger.kernel.org>
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  fs/proc/cmdline.c    | 12 ++++++++++++
> >  include/linux/init.h | 11 ++++++-----
> >  init/main.c          |  9 +++++++++
> 
> Same thing,
> 
> Please if possible put /proc/x into fs/proc/x.c so that it is easier to
> find source. Not all /proc follows this convention but still.
> 
> I don't like this name too (but less than the other one).
> Is it Boot Image Format (BIF). If yes, maybe add it as /proc/cmdline.bif ?
> 
> I don't know what's the good name.

It turns out that the already existing /proc/bootconfig makes this
new /proc/bootconfig_image unnecessary, so I have dropped this patch.
Imagine my embarrassment upon learning that /proc/bootconfig has been
around since v5.5!  ;-)

							Thanx, Paul
