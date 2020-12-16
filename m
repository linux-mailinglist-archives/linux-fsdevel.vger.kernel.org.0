Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8805C2DC803
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 21:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgLPU4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 15:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgLPU4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:56:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17490C061794;
        Wed, 16 Dec 2020 12:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vyA4GqkbuOPJ0kE51LkK+fuqRgR4xg+ZNtUrpfeL2d8=; b=ripwhSiWanG7+V1PW+YSN34+R0
        vO9BGGaMCZ+0oDRvyhUEWZ7ezO/vnUIGC/syxD9yp424VfW397Ne+Mnr/vHexfeoBwRAQOkzfF1X8
        Jl6D+vXthAlFMzChnzrAKLcjhfWe8Yl689sSTtUK1gzeCgAnGit566sGDA0BHeOiD2n8d8iOFhnIx
        XlL/C/R9xfeom4zFujjtm8wxy/ppo2MgUfjOSvFY1AORFXxnNVpV8fPfSt0DKGQXbxnRRrgt/Cxx4
        gKK8tV0MU503xfsce2+ZE/he96d10qY6zQhcIJRmYPTlJwenqrTJxdE+SLFllcYyjbwyVAxiIh/w8
        gpZC6lYw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpdpg-00086q-Ni; Wed, 16 Dec 2020 20:55:36 +0000
Date:   Wed, 16 Dec 2020 20:55:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+51ce7a5794c3b12a70d1@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: WARNING: suspicious RCU usage in count
Message-ID: <20201216205536.GX2443@casper.infradead.org>
References: <0000000000009867cb05b699f5b6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009867cb05b699f5b6@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 16, 2020 at 11:34:10AM -0800, syzbot wrote:
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+51ce7a5794c3b12a70d1@syzkaller.appspotmail.com
> 
> =============================
> WARNING: suspicious RCU usage
> 5.10.0-rc7-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/core.c:7270 Illegal context switch in RCU-bh read-side critical section!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 0
> no locks held by udevd/9038.
> 
> stack backtrace:
> CPU: 3 PID: 9038 Comm: udevd Not tainted 5.10.0-rc7-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:118
>  ___might_sleep+0x220/0x2b0 kernel/sched/core.c:7270
>  count.constprop.0+0x164/0x270 fs/exec.c:449
>  do_execveat_common+0x2fd/0x7c0 fs/exec.c:1893
>  do_execve fs/exec.c:1983 [inline]
>  __do_sys_execve fs/exec.c:2059 [inline]
>  __se_sys_execve fs/exec.c:2054 [inline]
>  __x64_sys_execve+0x8f/0xc0 fs/exec.c:2054
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46

This must be the victim of something else.  There's no way this call
trace took the RCU read lock.
