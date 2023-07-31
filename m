Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B1A76A4D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 01:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGaXaN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 19:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjGaXaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:30:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68705120;
        Mon, 31 Jul 2023 16:30:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2C8561344;
        Mon, 31 Jul 2023 23:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8DDC433C7;
        Mon, 31 Jul 2023 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690846210;
        bh=h+nVrnZ3EwL9z2/wjMqeRh+TZcvZgeSC9RunILZcjsc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uK574GT9Hv1wx8rHLhXYMhgpc3iIDgND7lv8uy+uCyii7XDPm2dV3hd2QZkA7jsMu
         OK6tPuDy0O4lK/hZe862QUAzSBAmUdUJkTUQpY3jbjS+CtF8Mc4wPf+534gA2/X0vB
         bIUUNnsJslZFxGYP15z9sq7/tdF4Anbe/tw5DTqsoqv1C6/Lq35rncwfIIf0IcLXlj
         +sVuBks5BZgw4VYbX4+u7TU6kVvXjD18X6hnvIuX+lmeCn4E0mjBj8OGWNk2AiQ/MV
         w2YzUuWQ74sWj0Dd3WlGRX7ZmcE3oQZEET47CFXFXixDmynWBRTukirPzNvLY5vmBv
         9WEtZSXEP/g9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EC935CE1065; Mon, 31 Jul 2023 16:30:09 -0700 (PDT)
Date:   Mon, 31 Jul 2023 16:30:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     akpm@linux-foundation.org, adobriyan@gmail.com, mhiramat@kernel.org
Cc:     arnd@kernel.org, ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH RFC v2 bootconfig 0/3] Distinguish bootloader and embedded
 kernel parameters
Message-ID: <db98cbbf-2205-40d2-9fa1-f1c135cc151c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:35:10PM -0700, Paul E. McKenney wrote:
Hello!

This series provides a /proc interface parallel to /proc/cmdline that
provides only those kernel boot parameters that were provided by the
bootloader in a new /proc/cmdline_load.  This is especially important
when these parameters are presented to the boot loader by automation
that might gather them from diverse sources, and also when a kexec-based
reboot process pulls the kernel boot parameters from /proc.  If such a
reboot process uses /proc/cmdline, the kernel parameters from the image
are replicated on every reboot, which can be frustrating when the new
kernel has different embedded kernel boot parameters.

Why put these in /proc?  Because they is quite similar to /proc/cmdline,
so it makes sense to put it in the same place that /proc/cmdline is
located.

1.	Update /proc/cmdline documentation to include boot config.

2.	fs/proc: Add /proc/cmdline_load for boot loader arguments.

3.	Add /proc/bootconfig to proc.rst.

Changes since v1:

o	Dropped /proc/cmdline_image in favor of the existing
	/proc/bootconfig.

o	Pulled in fixes from Stephen and Arnd.

o	Added documentation for /proc/bootconfig.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/filesystems/proc.rst   |    2 ++
 b/Documentation/filesystems/proc.rst |    3 ++-
 b/fs/proc/cmdline.c                  |   13 +++++++++++++
 b/include/linux/init.h               |    3 ++-
 b/init/main.c                        |    2 +-
 5 files changed, 20 insertions(+), 3 deletions(-)
