Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B91F768065
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjG2Plu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jul 2023 11:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjG2Plt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jul 2023 11:41:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C37D2D71;
        Sat, 29 Jul 2023 08:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDAF560C75;
        Sat, 29 Jul 2023 15:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280D1C433C7;
        Sat, 29 Jul 2023 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690645307;
        bh=gnQbp0RMH6stdptOKUe8S/aXAQhToOtVZJFSFaQElig=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qUfzp3WRPjsDOut42q/54kj4DHV+lhx3h4vCJ9DofebJb/aDWWY8uUWfCcDZyEODr
         dOAnRt6aOCc2nmUvSnGnIPZIj05h4XTbikjEX+UpsQvbkmWYeSPDCvCe1KFAH6zBvT
         d4zv+PFBdJCK5mADrUumt3awnbE/OEVRlDt00d6jk71QZirl4aAa9Ib2rjk1BJxxud
         lgB721z9i2Z5K9Kw2vBHbFPpeaglAz3uu8+59YVi0TwxP+ECChSdU2f2FHWwFVtWEJ
         9bWHKaPnEzZMPc9RuJWmrXdtWSvFSKKfyA7VjYuBbM2J8Ty45exGOogvmzAFmuVq6s
         JxnKZ43cn0EyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A917ACE0AD3; Sat, 29 Jul 2023 08:41:46 -0700 (PDT)
Date:   Sat, 29 Jul 2023 08:41:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com, arnd@kernel.org,
        ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 2/2] fs/proc: Add /proc/cmdline_image for
 embedded arguments
Message-ID: <5f3e1c5e-9456-4aa4-ae0b-6353357045d7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
 <20230728033701.817094-2-paulmck@kernel.org>
 <20230729232346.a09a94e5586942aeda5df188@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729232346.a09a94e5586942aeda5df188@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 29, 2023 at 11:23:46PM +0900, Masami Hiramatsu wrote:
> Hi Paul,
> 
> On Thu, 27 Jul 2023 20:37:01 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will show
> > all kernel boot parameters, both those supplied by the boot loader and
> > those embedded in the kernel image.  This works well for those who just
> > want to see all of the kernel boot parameters, but is not helpful to those
> > who need to see only those parameters that were embedded into the kernel
> > image.  This is especially important in situations where there are many
> > kernel images for different kernel versions and kernel configurations,
> > all of which opens the door to a great deal of human error.
> 
> There is /proc/bootconfig file which shows all bootconfig entries and is
> formatted as easily filter by grep (or any other line-based commands).
> (e.g. `grep ^kernel\\. /proc/cmdline` will filter all kernel cmdline
> parameters in the bootconfig)
> Could you clarify the reason why you need a dump of bootconfig file?

Because I was unaware of /proc/bootconfig?  ;-)

So how about if I replace this patch of mine with the following?

And thank you for pointing me at /proc/bootconfig.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 98c43c5ef1ee..832d66d4e396 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -684,6 +684,7 @@ files are there, and which are missing.
  File         Content
  ============ ===============================================================
  apm          Advanced power management info
+ bootconfig   Kernel command line obtained from boot config	(5.5)
  buddyinfo    Kernel memory allocator information (see text)	(2.5)
  bus          Directory containing bus specific information
  cmdline      Kernel command line, both from bootloader and embedded
