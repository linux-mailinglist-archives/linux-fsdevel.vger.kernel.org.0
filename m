Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AAD767767
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 23:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjG1VF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 17:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjG1VF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:05:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32D144B5;
        Fri, 28 Jul 2023 14:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 550436220B;
        Fri, 28 Jul 2023 21:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE97C433C8;
        Fri, 28 Jul 2023 21:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690578319;
        bh=7qOs7TnG/8tF9E4QPJWYx9tCPCwzVufdhmnJ191LcHY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=frguYMS9LYFIXpkA2hQ4p752eTEDDRN028mZ8JSp9Cp/XV5nhamo2EG7gQEP+dyvb
         +7mkpatxWOaRzYliEvatZBbe/w4r1lApI3B185bTcw3KyT9wSPO6z81FUK1ai7+HzV
         F7WdIFqzzHzqrNonUugUSKfgvyCdEvS7oYdZV248BVIbdWI8uiEdZBUPwx1lIvYXWJ
         pMavPk7jwjm1bLwVgzVn0CFmSgAuej6JtKv0IV+kBsKd6MnNt3/Mx3L7oJWKr+y+Cz
         F1jBiQj8T+/CXbwSEJCF0Dbrb/TuNLpzbpD+TugjjQ9x0fWhcXBlPxbosdn+jaGOI8
         XJDxvgQ9Ku19w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2CEE6CE0A13; Fri, 28 Jul 2023 14:05:19 -0700 (PDT)
Date:   Fri, 28 Jul 2023 14:05:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        mhiramat@kernel.org, arnd@kernel.org, ndesaulniers@google.com,
        sfr@canb.auug.org.au, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig 0/2] Distinguish bootloader and embedded
 kernel parameters
Message-ID: <2007473f-cdf3-4f15-bee9-470e4b30bb16@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
 <cc9ba6e9-1154-ad84-0fef-d67834169110@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc9ba6e9-1154-ad84-0fef-d67834169110@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 09:25:06PM -0700, Randy Dunlap wrote:
> 
> 
> On 7/27/23 20:35, Paul E. McKenney wrote:
> > Hello!
> > 
> > This series provides /proc interfaces parallel to /proc/cmdline that
> > provide only those kernel boot parameters that were provided by the
> > bootloader (/proc/cmdline_load) and only those parameters that were
> > embedded in the kernel image (/proc/cmdline_image, in boot-config format).
> > This is especially important when these parameters are presented to the
> > boot loader by automation that might gather them from diverse sources,
> > and also when a kexec-based reboot process pulls the kernel boot
> > parameters from /proc.  If such a reboot process uses /proc/cmdline,
> > the kernel parameters from the image are replicated on every reboot,
> > which can be frustrating when the new kernel has different embedded
> > kernel boot parameters.
> > 
> > Why put these in /proc?  Because they is quite similar to /proc/cmdline,
> > so it makes sense to put it in the same place that /proc/cmdline is
> > located.
> > 
> > 1.	fs/proc: Add /proc/cmdline_load for boot loader arguments.
> > 
> > 2.	fs/proc: Add /proc/cmdline_image for embedded arguments.
> > 
> > 						Thanx, Paul
> > 
> 
> Hi Paul,
> 
> This series seems to be missing updates to
> Documentation/filesystems/proc.rst.
> 
> Please add them.

Good catch, thank you!

I will fold the diff below into the three respective commits on my next
rebase, but in the meantime, please let me know what you think.

							Thanx, Paul

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 7897a7dafcbc..98c43c5ef1ee 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -686,7 +686,10 @@ files are there, and which are missing.
  apm          Advanced power management info
  buddyinfo    Kernel memory allocator information (see text)	(2.5)
  bus          Directory containing bus specific information
- cmdline      Kernel command line
+ cmdline      Kernel command line, both from bootloader and embedded
+ 	      in the kernel image
+ cmdline_image Kernel command line obtained from boot loader	(6.6)
+ cmdline_load Kernel command line obtained from kernel image	(6.6)
  cpuinfo      Info about the CPU
  devices      Available devices (block and character)
  dma          Used DMS channels
