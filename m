Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95D7768366
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jul 2023 03:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjG3B4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jul 2023 21:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG3B4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jul 2023 21:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5122115;
        Sat, 29 Jul 2023 18:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FA6E60281;
        Sun, 30 Jul 2023 01:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B84C433C8;
        Sun, 30 Jul 2023 01:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690682162;
        bh=WmIX/oNZC4zCelNw3YcY9OzgIWnMX4OG6p9fKSNA9zc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SfAOvaPn/Ps2ruKdP7oZsoeZ2VS30Um1/J6XR8NCQ7Vkx60doQZDIVNbGf9Cc/8Yi
         NmPKM3PDTMkjpCjZuwjsz5kjO1BzQ2sldxKwNBkDRicDsZmYmGGGQqk6IxDLGmPWMk
         ab9G4rc4GBG6LOgjUDcChqqTDalNIzNjXByzbFJIMdS7kjuwQJrmqo2pr3AvToWmt3
         9JgL3UbbXe1Rh0Y1XkslZ/4ioXQ2PMsR1bnHae7S7mHAQjBxqLZAhAYxf5/ZhgSsIq
         I6wEzHTsPfS7qeE/XUzh0DJ5ZRdr2uWN+PnjdG6fgslDJYCCKPnbpjLgI6/TWSQLEP
         KIUWbg+hqq0ww==
Date:   Sun, 30 Jul 2023 10:55:58 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com, arnd@kernel.org,
        ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 2/2] fs/proc: Add /proc/cmdline_image
 for embedded arguments
Message-Id: <20230730105558.58a279d40e0d92eccd8ccb73@kernel.org>
In-Reply-To: <5f3e1c5e-9456-4aa4-ae0b-6353357045d7@paulmck-laptop>
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
        <20230728033701.817094-2-paulmck@kernel.org>
        <20230729232346.a09a94e5586942aeda5df188@kernel.org>
        <5f3e1c5e-9456-4aa4-ae0b-6353357045d7@paulmck-laptop>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 29 Jul 2023 08:41:46 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Sat, Jul 29, 2023 at 11:23:46PM +0900, Masami Hiramatsu wrote:
> > Hi Paul,
> > 
> > On Thu, 27 Jul 2023 20:37:01 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will show
> > > all kernel boot parameters, both those supplied by the boot loader and
> > > those embedded in the kernel image.  This works well for those who just
> > > want to see all of the kernel boot parameters, but is not helpful to those
> > > who need to see only those parameters that were embedded into the kernel
> > > image.  This is especially important in situations where there are many
> > > kernel images for different kernel versions and kernel configurations,
> > > all of which opens the door to a great deal of human error.
> > 
> > There is /proc/bootconfig file which shows all bootconfig entries and is
> > formatted as easily filter by grep (or any other line-based commands).
> > (e.g. `grep ^kernel\\. /proc/cmdline` will filter all kernel cmdline
> > parameters in the bootconfig)
> > Could you clarify the reason why you need a dump of bootconfig file?
> 
> Because I was unaware of /proc/bootconfig?  ;-)

Oh :)

> 
> So how about if I replace this patch of mine with the following?

Yes, I missed to update the proc.rst. Thanks!

> 
> And thank you for pointing me at /proc/bootconfig.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 98c43c5ef1ee..832d66d4e396 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -684,6 +684,7 @@ files are there, and which are missing.
>   File         Content
>   ============ ===============================================================
>   apm          Advanced power management info
> + bootconfig   Kernel command line obtained from boot config	(5.5)
>   buddyinfo    Kernel memory allocator information (see text)	(2.5)
>   bus          Directory containing bus specific information
>   cmdline      Kernel command line, both from bootloader and embedded


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
