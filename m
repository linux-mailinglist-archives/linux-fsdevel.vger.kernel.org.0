Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C027B4168A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 02:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243603AbhIXAAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 20:00:47 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:37070 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243594AbhIXAAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 20:00:47 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Sep 2021 20:00:47 EDT
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id E8CF81A56019; Thu, 23 Sep 2021 16:49:17 -0700 (PDT)
Date:   Thu, 23 Sep 2021 16:49:17 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
References: <20210923233105.4045080-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923233105.4045080-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 04:31:05PM -0700, Kees Cook wrote:
> The /proc/$pid/wchan file has been broken by default on x86_64 for 4
> years now[1]. As this remains a potential leak of either kernel
> addresses (when symbolization fails) or limited observation of kernel
> function progress, just remove the contents for good.
> 
> Unconditionally set the contents to "0" and also mark the wchan
> field in /proc/$pid/stat with 0.
> 
> This leaves kernel/sched/fair.c as the only user of get_wchan(). But
> again, since this was broken for 4 years, was this profiling logic
> actually doing anything useful?
> 
> [1] https://lore.kernel.org/lkml/20210922001537.4ktg3r2ky3b3r6yp@treble/
> 
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Vito Caputo <vcaputo@pengaru.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
<snip>


Please don't deliberately break WCHANs wholesale.  This is a very
useful tool for sysadmins to get a vague sense of where processes are
spending time in the kernel on production systems without affecting
performance or having to restart things under instrumentation.

I don't see how providing the symbol name of a given task's kernel
function, especially if shallow near the user->kernel entrypoint, is a
worrisome information leak.  Just make sure it's not failing open with
addresses like my original report documented seems to happen
spuriously as-is w/kallsyms.

When I worked full-time as a sysadmin WCHAN's were regularly the first
thing to look at in `ps -o stat,wchan | grep D` when things were
falling over.  e.g.:

```
root@shells:/root# ps -o stat,wchan | grep D
D    io_schedule
```

Furthermore this is a well documented on dead trees and understood
*nix/posix system observation technique.  Even the POSIX ps(1) man
page documents it:

https://pubs.opengroup.org/onlinepubs/9699919799/utilities/ps.html

Frankly I'm a bit mortified that I have to write this email.

Today I'm hoping to test Josh's patch @
https://lore.kernel.org/all/20210831083625.59554-1-zhengqi.arch@bytedance.com/

Thanks,
Vito Caputo
