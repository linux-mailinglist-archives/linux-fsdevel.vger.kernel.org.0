Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAE2416930
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 03:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243736AbhIXBD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 21:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243729AbhIXBD0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:03:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2917C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 18:01:53 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id n18so8120885pgm.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 18:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R0TVEFcTo2DWYNC/Ty6kIV1DRidb4aV2ukSxlWruSY0=;
        b=Cc6bMFq/ABedDQ1YzC/XdDZv/spMWPp/hh2aQu0AWPUtdFU+pDQ2RfUJcArNTuc3L9
         YpvOF13QFoVaXT/zT7J7wQkyQYbwvtRMnut5ixcpE36ZNymppWEwd2zsKT3GYU3t8vL7
         NY+q/rhK2I15ufekXaQLQpuxl65puFdTvPnwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R0TVEFcTo2DWYNC/Ty6kIV1DRidb4aV2ukSxlWruSY0=;
        b=6KBeD8mxY8Mz/5iKvtptxU4Tu7/ecl67Hl6TYIhvMRnrAzwduDFp40Kpy66/aK34lw
         UXIx/FcKbSpO5SDLRolP8UCh3AxDqWmvNBkBrlIvicIqnmr6H8tidZ6QRipI4/FNjMMc
         canxiJMHPZtowBIlQOO9UAfWfeBzfAnJ5285Va0Zxm+bEr2pPVREz0nHUhjqPYejKzkg
         lC//n58r699Agd1XGDHzhPVVlPrwocVc4iWVRZx41jlPyI/UtlUvlGren0WFJbTgzQ2k
         e7XB/Jyu6d50D9yjJ3T4g8bKDAcLhHfaEmJNye7MkQyIqKAg3dL5bZPcgPtEoGaLFNMo
         kYMg==
X-Gm-Message-State: AOAM533oo50Be4AIvX2M9tcm9chPjAJ+AO5Epzmk6wDfMU5wf30JNVmb
        wY/7VNWU7FNCcggxqqwYItFjWQ==
X-Google-Smtp-Source: ABdhPJwMFns0SIvz1MLq43HUOigRve27DNoneF2kjwjje+necuiiSQxwV3fefmt7ZBxJihxs7+TLEQ==
X-Received: by 2002:a62:4dc5:0:b0:438:8133:fcef with SMTP id a188-20020a624dc5000000b004388133fcefmr7089386pfb.44.1632445313339;
        Thu, 23 Sep 2021 18:01:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g12sm10204673pja.28.2021.09.23.18.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:01:52 -0700 (PDT)
Date:   Thu, 23 Sep 2021 18:01:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Helge Deller <deller@gmx.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, stable@vger.kernel.org
Subject: /proc/$pid/chan kernel address exposures (was Re: [proc/wchan]
 30a3a19273:
 leaking-addresses.proc.wchan./proc/bus/input/devices:B:KEY=1000000000007ff980000000007fffebeffdfffeffffffffffffffffffffe)
Message-ID: <202109231746.7B4C306CEC@keescook>
References: <20210103142726.GC30643@xsang-OptiPlex-9020>
 <d15378c8-8702-47ba-65b7-450f728793ed@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d15378c8-8702-47ba-65b7-450f728793ed@gmx.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 03, 2021 at 07:25:36PM +0100, Helge Deller wrote:
> On 1/3/21 3:27 PM, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: 30a3a192730a997bc4afff5765254175b6fb64f3 ("[PATCH] proc/wchan: Use printk format instead of lookup_symbol_name()")
> > url: https://github.com/0day-ci/linux/commits/Helge-Deller/proc-wchan-Use-printk-format-instead-of-lookup_symbol_name/20201218-010048
> > base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 09162bc32c880a791c6c0668ce0745cf7958f576
> >
> > in testcase: leaking-addresses
> > version: leaking-addresses-x86_64-4f19048-1_20201111
> > [...]
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> I don't see anything wrong with the wchan patch (30a3a192730a997bc4afff5765254175b6fb64f3),
> or that it could have leaked anything.
> 
> Maybe the kernel test robot picked up the wchan patch by mistake ?
>
> > [...]
> > [2 wchan] 0xffffc9000000003c
       ^^^^^

As the root cause of a kernel address exposure, Jann pointed out[2]
commit 152c432b128c, which I've tracked to here, only to discover this
regression was, indeed, reported. :(

So, we have a few things:

1) wchan has been reporting "0" in the default x86 config (ORC unwinder)
   for 4 years now.

2) non-x86 or non-ORC, wchan has been leaking raw kernel addresses since
   commit 152c432b128c (v5.12).

3) the output of scripts/leaking_addresses.pl is hard to read. :)

We can fix 1 and 2 with:
   https://lore.kernel.org/lkml/20210923233105.4045080-1-keescook@chromium.org/
(though that will need a Cc: stable now...)

If we don't do that, we still need to revert 152c432b128c in v5.12 and
later.

We should likely make leaking_addresses.pl a little more readable while
we're at it.

-Kees

[1] https://lore.kernel.org/lkml/20210921193249.el476vlhg5k6lfcq@shells.gnugeneration.com/
[2] https://lore.kernel.org/lkml/CAG48ez2zC=+PuNgezH53HBPZ8CXU5H=vkWx7nJs60G8RXt3w0Q@mail.gmail.com/

-- 
Kees Cook
