Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D216D6FE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 00:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbjDDWHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 18:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDDWHt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:07:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E5B4227;
        Tue,  4 Apr 2023 15:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47406635A6;
        Tue,  4 Apr 2023 22:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE56C433EF;
        Tue,  4 Apr 2023 22:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680646066;
        bh=HyUaMz/ZoOz8dUzt6HmBjHdv4xt04lbld0m+gyj7fNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFcRgWeWxk7eQpi/P8RsvWaXrl77+MI4I4OBGqBM6aik7mV+XEyGcfczRR61rSKh7
         NJLMIPJndSbln4WChTvi94CXiASNBz3nB9bUFiTF/ZHPmWOTJe+0kSI0fQ2LzEEyEs
         bko6hP/MmPn9HSNTM+Z+d6WmZVpi9QRvCy45lghrupnKUnDe06SlRGHchf1p4z3KnK
         QcyaHipeUdVlrv9hrB9i6cVyhPtHfjEZETDBzLQmVyRUnyA/coPcmjN6dS0Lhw3062
         e4777/4DtuOhAJiWpRQ4ycuBwSy3NMCffaRWh+iqMiBoN9oDUxb6EHcxXhUiTYLZbV
         YZm/xJHmxYV9g==
Date:   Tue, 4 Apr 2023 15:07:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [BUG RESEND] [BISECTED]: selftest: ftracetest: memleak in
 vfs_write()
Message-ID: <20230404220744.GB1893@sol.localdomain>
References: <ca4dca01-66ce-c1a9-23cd-9d83b0d2c4b0@alu.unizg.hr>
 <76134d9f-a5ba-6a0d-37b3-28310b4a1e91@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76134d9f-a5ba-6a0d-37b3-28310b4a1e91@alu.unizg.hr>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mirsad,

On Tue, Apr 04, 2023 at 09:52:10PM +0200, Mirsad Goran Todorovac wrote:
>   backtrace:
>     [<ffffffffb4afb23c>] slab_post_alloc_hook+0x8c/0x3e0
>     [<ffffffffb4b02b19>] __kmem_cache_alloc_node+0x1d9/0x2a0
>     [<ffffffffb4a77785>] __kmalloc+0x55/0x160
>     [<ffffffffb493a913>] tracing_log_err+0x1a3/0x1d0
>     [<ffffffffb4959049>] append_filter_err.isra.13+0x119/0x190
>     [<ffffffffb495a89f>] create_filter+0xbf/0xe0
>     [<ffffffffb495ab10>] create_event_filter+0x10/0x20
>     [<ffffffffb495c040>] set_trigger_filter+0xa0/0x180
>     [<ffffffffb495d745>] event_trigger_parse+0xf5/0x160
>     [<ffffffffb495c889>] trigger_process_regex+0xc9/0x120
>     [<ffffffffb495c976>] event_trigger_write+0x86/0xf0
>     [<ffffffffb4b52dc2>] vfs_write+0xf2/0x520
>     [<ffffffffb4b533d8>] ksys_write+0x68/0xe0
>     [<ffffffffb4b5347e>] __x64_sys_write+0x1e/0x30
>     [<ffffffffb586619c>] do_syscall_64+0x5c/0x90
>     [<ffffffffb5a000ae>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> Please find the complete debug info at the URL:
> 
> https://domac.alu.unizg.hr/~mtodorov/linux/bugreports/ftracetest/
> 
> Bisect log is [edited]:
> 
> > git bisect good a92ce570c81dc0feaeb12a429b4bc65686d17967
> > # good: [c6f613e5f35b0e2154d5ca12f0e8e0be0c19be9a] ipmi/watchdog: use strscpy() to instead of strncpy()
> > git bisect good c6f613e5f35b0e2154d5ca12f0e8e0be0c19be9a
> > # good: [90b12f423d3c8a89424c7bdde18e1923dfd0941e] Merge tag 'for-linus-6.2-1' of https://github.com/cminyard/linux-ipmi
> > git bisect good 90b12f423d3c8a89424c7bdde18e1923dfd0941e
> > # first bad commit: [71946a25f357a51dcce849367501d7fb04c0465b] Merge tag 'mmc-v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
> > 
> > The commit was merged on December 13th 2022.
> 
> The amount of applied diffs in the culprit commit 71946a25f357a51dcce849367501d7fb04c0465b
> prevents me from bisecting further - I do not know which changes depend of which, and which
> can be tested independently.
> 
> Hopefully I might come up with a reproducer, but I need some feedback first. Maybe there
> are ways to narrow down the lines of code that could have caused the leaks, yet I am
> completely new to the kernel/trace subtree.
> 
> Apologies for not Cc:ing Ulf nine weeks ago, but it was an omission, not deliberate act.
> 

This looks like an issue with the tracing subsystem.  I appreciate that you've
now added the tracing maintainers to Cc.  I don't think your bisection to commit
71946a25f357 ("Merge tag 'mmc-v6.2' ...") is correct; that looks unrelated.

- Eric
