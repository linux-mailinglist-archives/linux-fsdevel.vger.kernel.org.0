Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98E33BAE11
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jul 2021 19:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhGDRc1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 13:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhGDRc1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 13:32:27 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F052C061574;
        Sun,  4 Jul 2021 10:29:51 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id m18-20020a9d4c920000b029048b4f23a9bcso3854551otf.9;
        Sun, 04 Jul 2021 10:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=utOMOZ5qE7hKQhLEGBCvyNpeZymNCBG8WQJUaRUgXWo=;
        b=Khjn75GpOAMKtm8eVPqoHLu8k2w+01mg7pTAF/13kTlj4bBfJSUIQueHbMaNTrD7Lm
         2FADilB7xgxU/C1E02pXSiespQudL2SB09mS+lq4Orjl6SGPebExzxMx58WTmLCR+imo
         slmZqBz6Cgs0wfyTTAYrAuIh4HJN02aX4mcuyZbA0KV5RJL7CcXltKfSkP2pUETlvAgr
         dBoPeUlbM93j3MRBPi21Y/vYQOOYBf6GFUYlVVZEd8efPX1DFKlPR5M+w9gXmFuStvqD
         wc4fwow6P+3+v6mJOFx2k09uFor8LKZVTyuxDMIL4imA4TA5hoAoAQeQeli5cFniH0pP
         whzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=utOMOZ5qE7hKQhLEGBCvyNpeZymNCBG8WQJUaRUgXWo=;
        b=M6I5Q+qFhPPznDb9/8D7alURz+mPWf7BaHvtF4fCPGq7VTW5staU+VvESDGZApZLcp
         lifEFBsLpB/7NrFF+dWTzbT9/ANPqsnVeubtTK74hphhx0PUg/rwT4CRCOwGo6yvyV/M
         jJr+jQw7TQa8pJJFS5PPXbb6fH38FyfVekDDp5IdWVVeOVxmjc7QnuyfOTuDR+tnAGTc
         iadkOvBOlH6J90y+5hDuk5GvjTcS6WNjFE01znDpV01Geu7vJltO8zVMJ0om8RwVJJfg
         QI8YExR+xPf1QY7GnwQoG417YvyYLEi5fWRAog1w5rgClZrGFdtLwcPXnSUF35pBPseE
         Qe2g==
X-Gm-Message-State: AOAM532HefmG+a5herWZw4maK1Q4SZ0T7ZxwcP9xWwuWBj24MIFNccmx
        OerL8ik3sRrHLhfvlYu7gGk=
X-Google-Smtp-Source: ABdhPJzpMXM9fzDvroQet1BKSgCQRamlFEmNnN9jXhHcNWmWui3LQal0gLKPCPtf1kk8Irupt3o/Gw==
X-Received: by 2002:a05:6830:245c:: with SMTP id x28mr7986541otr.169.1625419790960;
        Sun, 04 Jul 2021 10:29:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3sm1788970oob.1.2021.07.04.10.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 10:29:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 4 Jul 2021 10:29:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH] iov_iter: separate direction from flavour
Message-ID: <20210704172948.GA1730187@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu, Apr 22, 2021 at 02:50:39PM -0400, Al Viro wrote:
> Instead of having them mixed in iter->type, use separate ->iter_type
> and ->data_source (u8 and bool resp.)  And don't bother with (pseudo-)
> bitmap for the former - microoptimizations from being able to check
> if the flavour is one of two values are not worth the confusion for
> optimizer.  It can't prove that we never get e.g. ITER_IOVEC | ITER_PIPE,
> so we end up with extra headache.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

This patch results in the following runtime warning on nommu systems.

[    8.567154] Run /init as init process
[    8.572112] ------------[ cut here ]------------
[    8.572248] WARNING: CPU: 0 PID: 1 at lib/iov_iter.c:468 iov_iter_init+0x35/0x58
[    8.572484] CPU: 0 PID: 1 Comm: init Not tainted 5.13.0-09606-g303392fd5c16 #1
[    8.572695] Hardware name: MPS2 (Device Tree Support)
[    8.573278] [<2100ae75>] (unwind_backtrace) from [<2100a2bb>] (show_stack+0xb/0xc)
[    8.573594] [<2100a2bb>] (show_stack) from [<2100da03>] (__warn+0x5f/0x80)
[    8.573738] [<2100da03>] (__warn) from [<2100da55>] (warn_slowpath_fmt+0x31/0x60)
[    8.573886] [<2100da55>] (warn_slowpath_fmt) from [<210d8e1d>] (iov_iter_init+0x35/0x58)
[    8.574044] [<210d8e1d>] (iov_iter_init) from [<21059cab>] (vfs_read+0x89/0xc6)
[    8.574191] [<21059cab>] (vfs_read) from [<2105d92b>] (read_code+0x15/0x2e)
[    8.574329] [<2105d92b>] (read_code) from [<21085a8d>] (load_flat_file+0x341/0x4f0)
[    8.574481] [<21085a8d>] (load_flat_file) from [<21085e03>] (load_flat_binary+0x47/0x2dc)
[    8.574639] [<21085e03>] (load_flat_binary) from [<2105d581>] (bprm_execve+0x1fd/0x32c)
[    8.574797] [<2105d581>] (bprm_execve) from [<2105dbb3>] (kernel_execve+0xa3/0xac)
[    8.574947] [<2105dbb3>] (kernel_execve) from [<211e7095>] (kernel_init+0x31/0xb0)
[    8.575099] [<211e7095>] (kernel_init) from [<2100814d>] (ret_from_fork+0x11/0x24)
[    8.575287] Exception stack(0x21429fb0 to 0x21429ff8)
[    8.575433] 9fa0:                                     00000000 00000000 00000000 00000000
[    8.575593] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    8.575743] 9fe0: 00000000 00000000 00000000 00000000 00000000 00000000
[    8.575933] ---[ end trace ba15568c05035a77 ]---

This is with qemu's mps2-an385 emulation and and mps2_defconfig.
The same warning is also observed with m68k and mcf5208evb,
though the traceback isn't as nice.

WARNING: CPU: 0 PID: 1 at lib/iov_iter.c:468 0x40135e4e
...
Call Trace:
        [<402b0f42>] 0x402b0f42
 [<402b0fea>] 0x402b0fea
 [<40135e4e>] 0x40135e4e
 [<40135e4e>] 0x40135e4e
 [<4009c610>] 0x4009c610
...

Reverting this patch fixes the problem for both mps2-an385 and mcf5208evb.

Guenter
