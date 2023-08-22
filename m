Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9EB784972
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 20:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjHVSe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 14:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHVSe5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E2CCE6;
        Tue, 22 Aug 2023 11:34:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 405E464F6B;
        Tue, 22 Aug 2023 18:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766C1C433C7;
        Tue, 22 Aug 2023 18:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1692729294;
        bh=DBkztqkcpz432shRdIYR5aanQAPEFzUzG/jzNRqN3vI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n8Lxd7b9P+s1lKpKDb7uBLQm7y9OONZzwqxv9VRxVK+g3OWyotOUf9adWcgG1nZmv
         aQOfHDk+Guc/HWHa3IeKrNGUz2zS70eTzhZhQNxuLF/AF73Gc2+I2cC8Qr3PBYmn13
         oqqyis1f7PDRZ/RJgNmF5ZVKWfGkC/V6ahXjPkGY=
Date:   Tue, 22 Aug 2023 11:34:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@openvz.org>
Subject: Re: [PATCH v2] procfs: Fix /proc/self/maps output for 32-bit kernel
 and compat tasks
Message-Id: <20230822113453.acc69f8540bed25cde79e675@linux-foundation.org>
In-Reply-To: <ZOR95DiR8tdcHDfq@p100>
References: <ZOR95DiR8tdcHDfq@p100>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 22 Aug 2023 11:20:36 +0200 Helge Deller <deller@gmx.de> wrote:

> On a 32-bit kernel addresses should be shown with 8 hex digits, e.g.:
> 
> root@debian:~# cat /proc/self/maps
> 00010000-00019000 r-xp 00000000 08:05 787324     /usr/bin/cat
> 00019000-0001a000 rwxp 00009000 08:05 787324     /usr/bin/cat
> 0001a000-0003b000 rwxp 00000000 00:00 0          [heap]
> f7551000-f770d000 r-xp 00000000 08:05 794765     /usr/lib/hppa-linux-gnu/libc.so.6
> f770d000-f770f000 r--p 001bc000 08:05 794765     /usr/lib/hppa-linux-gnu/libc.so.6
> f770f000-f7714000 rwxp 001be000 08:05 794765     /usr/lib/hppa-linux-gnu/libc.so.6
> f7d39000-f7d68000 r-xp 00000000 08:05 794759     /usr/lib/hppa-linux-gnu/ld.so.1
> f7d68000-f7d69000 r--p 0002f000 08:05 794759     /usr/lib/hppa-linux-gnu/ld.so.1
> f7d69000-f7d6d000 rwxp 00030000 08:05 794759     /usr/lib/hppa-linux-gnu/ld.so.1
> f7ea9000-f7eaa000 r-xp 00000000 00:00 0          [vdso]
> f8565000-f8587000 rwxp 00000000 00:00 0          [stack]
> 
> But since commmit 0e3dc0191431 ("procfs: add seq_put_hex_ll to speed up
> /proc/pid/maps") even on native 32-bit kernels the output looks like this:
> 
> root@debian:~# cat /proc/self/maps
> 0000000010000-0000000019000 r-xp 00000000 000000008:000000005 787324  /usr/bin/cat
> 0000000019000-000000001a000 rwxp 000000009000 000000008:000000005 787324  /usr/bin/cat
> 000000001a000-000000003b000 rwxp 00000000 00:00 0  [heap]
> 00000000f73d1000-00000000f758d000 r-xp 00000000 000000008:000000005 794765  /usr/lib/hppa-linux-gnu/libc.so.6
> 00000000f758d000-00000000f758f000 r--p 000000001bc000 000000008:000000005 794765  /usr/lib/hppa-linux-gnu/libc.so.6
> 00000000f758f000-00000000f7594000 rwxp 000000001be000 000000008:000000005 794765  /usr/lib/hppa-linux-gnu/libc.so.6
> 00000000f7af9000-00000000f7b28000 r-xp 00000000 000000008:000000005 794759  /usr/lib/hppa-linux-gnu/ld.so.1
> 00000000f7b28000-00000000f7b29000 r--p 000000002f000 000000008:000000005 794759  /usr/lib/hppa-linux-gnu/ld.so.1
> 00000000f7b29000-00000000f7b2d000 rwxp 0000000030000 000000008:000000005 794759  /usr/lib/hppa-linux-gnu/ld.so.1
> 00000000f7e0c000-00000000f7e0d000 r-xp 00000000 00:00 0  [vdso]
> 00000000f9061000-00000000f9083000 rwxp 00000000 00:00 0  [stack]
> 
> This patch brings back the old default 8-hex digit output for
> 32-bit kernels and compat tasks.
> 
> Fixes: 0e3dc0191431 ("procfs: add seq_put_hex_ll to speed up /proc/pid/maps")

That was five years ago.  Given there is some risk of breaking existing
parsers, is it worth fixing this?

