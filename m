Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0BE54A733
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 04:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355343AbiFNC7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 22:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351488AbiFNC6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:58:14 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCB4B22
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 19:51:27 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f65so7283346pgc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 19:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9f3QGTquyPNqt5Y0ehbeYkFH6SxKJFf9weR2+dr9JWE=;
        b=P1BYcRUky4pTlBCXgymwrbeyuxVeejqaqw+JSs0ELqecgtAA8S1wQVXLUSyIUEfVnh
         QvMMpYuen89Ix6WBpHx6Kn6lpOsQnahN1rKirs2nmFI1OBmwttSk7YBJoDBo69aI4mVu
         Fia2AXw9sK523hRAkVZ0hak767LdTjO9ysOgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9f3QGTquyPNqt5Y0ehbeYkFH6SxKJFf9weR2+dr9JWE=;
        b=TiZcnf9uWOULwLTz1r7bTpBe74oJbrWSE1cRLGX4Czk49L89Z+YnYSORGhWlPPq6Yu
         sLZ21speo2Err8IJt7gN+2moHQyWXPzXYdOVSIM1oXN9YIA8MJm6nuzlT3POuAYzDEsR
         tsw2g9onP3Wi9GSulTuhqZ3UEgwNav0w0BN+1F35JIO8aSoT/9o6M70BrQACvp/MP3oi
         /cxm7wc7B9qJ5UJDPbKB3w2gHBDKNcD6iSkwtsK4806WTPxlWW3QrT02oWP4ghMpU5J1
         TpNsFrVKAQQJUXEyWCcKw/vFsN9+V9fwtSBhfskaHfc5cR8Q7bJtoFRwB6a3jZl1EYqC
         IakA==
X-Gm-Message-State: AOAM530MwfqPQe7zLteocFsCaz3jrA8y0xjs9hdk2GGShNueMd9U7QmU
        72gae0jcUaOanGYbHAes+9q+2A==
X-Google-Smtp-Source: ABdhPJylGhOEry1IwuOWykOk7USTnbbJcg+B07vWOeXChI+8gMoxe5N2wMpODJvV4Ll+IIRjj6BF5w==
X-Received: by 2002:a63:89c1:0:b0:3fc:6001:e871 with SMTP id v184-20020a6389c1000000b003fc6001e871mr2528817pgd.14.1655175086959;
        Mon, 13 Jun 2022 19:51:26 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:580a:28cf:a82b:5610])
        by smtp.gmail.com with ESMTPSA id a10-20020a62d40a000000b0051b416c065esm6147718pfh.8.2022.06.13.19.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 19:51:26 -0700 (PDT)
Date:   Tue, 14 Jun 2022 11:51:19 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     sunjunchao2870@gmail.com, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, maco@android.com, hch@lst.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Subject: Re: [BUG] rockpro64 board hangs in console_init() after commit
 10e14073107d
Message-ID: <Yqf3pxG16lQcacUA@google.com>
References: <Yqdry+IghSWnJ6pe@monolith.localdoman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqdry+IghSWnJ6pe@monolith.localdoman>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (22/06/13 17:54), Alexandru Elisei wrote:
[..]
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
> [    0.000001] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
> [    0.005107] Console: colour dummy device 80x25
> [    0.005549] printk: console [tty0] enabled
> [    0.005956] printk: bootconsole [uart0] disabled
> 
> Config can be found at [1] (expires after 6 months). I've also built the
> kernel with gcc 10.3.1 [2] (aarch64-none-linux-gnu), same issue.
> 
> I've bisected the build failure to commit 10e14073107d ("writeback: Fix
> inode->i_io_list not be protected by inode->i_lock error"); I've confirmed
> that that commit is responsible by successfully booting the board with a
> kernel built from v5.19-rc2 + the above commit reverted.

Hmm, interesting and puzzling.

If you disable console kthreads (__printk_fallback_preferred_direct) and
keep 10e14073107d, are you able to successfully boot the board or does it
boot to a panic?

> I tried to do some investigating, it seems that the kernel is stuck at
> printk.c::console_init() -> drivers/tty/vt/vt.c::con_init() ->
> printk.c::register_console() -> unregister_console() -> console_lock().

Is it console lock (console_kthreads_block() -> mutex_lock(&con->lock))
that we cannot grab or is it console semaphore?
