Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46071766276
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 05:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjG1DfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 23:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjG1DfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:35:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DAB271E;
        Thu, 27 Jul 2023 20:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E445461F71;
        Fri, 28 Jul 2023 03:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367D9C433C7;
        Fri, 28 Jul 2023 03:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690515311;
        bh=YsPGLotLiq3ZDtYso7Nm9Hr1y+5naXdx1RmexdOkaC4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=FJpu+5sO6ijbdbzJ+chrgTH7WRx/oxwu/DSLSQjt0gSUPB36k2XvuutP7UYsPKtYe
         NeUAnlDWxfeVPLoo7h1SpIg9LWurRTye4g9nvMGf61bL2c43Pd36FHoRRyk34imgu8
         bAfC7MnI1leR+g8mUdG9ztRQx1+SMeiRHJDQLulIZFosB+daxSOPqxnXsaRc458QVI
         FozDb+MlGnZmV5z+SZv5xKzizLJw0VxkNtxMFXmpIG0Fi9eL7IHB5Y1QljIFGl2yUC
         lv0qxk574hF4rYSHJKzp4NNrbf9hEQ1/BcSmrg+T2jFzVEet06F5BeTYgQJsV100GQ
         IOZSf/rUro3Aw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B9AD5CE0AD7; Thu, 27 Jul 2023 20:35:10 -0700 (PDT)
Date:   Thu, 27 Jul 2023 20:35:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     akpm@linux-foundation.org, adobriyan@gmail.com, mhiramat@kernel.org
Cc:     arnd@kernel.org, ndesaulniers@google.com, paulmck@kernel.org,
        sfr@canb.auug.org.au, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH RFC bootconfig 0/2] Distinguish bootloader and embedded
 kernel parameters
Message-ID: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

This series provides /proc interfaces parallel to /proc/cmdline that
provide only those kernel boot parameters that were provided by the
bootloader (/proc/cmdline_load) and only those parameters that were
embedded in the kernel image (/proc/cmdline_image, in boot-config format).
This is especially important when these parameters are presented to the
boot loader by automation that might gather them from diverse sources,
and also when a kexec-based reboot process pulls the kernel boot
parameters from /proc.  If such a reboot process uses /proc/cmdline,
the kernel parameters from the image are replicated on every reboot,
which can be frustrating when the new kernel has different embedded
kernel boot parameters.

Why put these in /proc?  Because they is quite similar to /proc/cmdline,
so it makes sense to put it in the same place that /proc/cmdline is
located.

1.	fs/proc: Add /proc/cmdline_load for boot loader arguments.

2.	fs/proc: Add /proc/cmdline_image for embedded arguments.

						Thanx, Paul

------------------------------------------------------------------------

 b/fs/proc/cmdline.c    |   13 +++++++++++++
 b/include/linux/init.h |    3 ++-
 b/init/main.c          |    2 +-
 fs/proc/cmdline.c      |   12 ++++++++++++
 include/linux/init.h   |   11 ++++++-----
 init/main.c            |    9 +++++++++
 6 files changed, 43 insertions(+), 7 deletions(-)
