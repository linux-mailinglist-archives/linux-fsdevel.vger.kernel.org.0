Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF88A774EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 01:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfGZXWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 19:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfGZXWK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:22:10 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1138822BE8;
        Fri, 26 Jul 2019 23:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564183329;
        bh=xZCsGQBcnTpWVW9JP/BUO/9vB+I+O251akBSutWP4a8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BFxWE/pI683Fjxg2Ui8ufJCnzeRtwusslCY9xyT2yn2JsAOXJfGPcGPjleE+qoOcz
         qaBX19N4SIbbwll9coIJwwUmMGwCRMrVM4IYWaewmluBgJfXFayljAeQuuDHWjTz7w
         ObXKy8cwWfL8WnnVLA450L9XU6pkSLdTl5vOPpwI=
Date:   Fri, 26 Jul 2019 16:22:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Azat Khuzhin <azat@libevent.org>, Eric Wong <e@80x24.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/14] epoll: support pollable epoll from userspace
Message-Id: <20190726162208.0a9a244d41d9384fb94d9210@linux-foundation.org>
In-Reply-To: <20190611145458.9540-1-rpenyaev@suse.de>
References: <20190611145458.9540-1-rpenyaev@suse.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 11 Jun 2019 16:54:44 +0200 Roman Penyaev <rpenyaev@suse.de> wrote:

> Hi all,
> 
> This is v4 which introduces pollable epoll from userspace.

A nicely presented patchset.

>
> ...
>
> ** Measurements
> 
> In order to measure polling from userspace libevent was modified [1] and
> bench_http benchmark (client and server) was used:
> 
>  o EPOLLET, original epoll:
> 
>     20000 requests in 0.551306 sec. (36277.49 throughput)
>     Each took about 5.54 msec latency
>     1600000bytes read. 0 errors.
> 
>  o EPOLLET + polling from userspace:
> 
>     20000 requests in 0.475585 sec. (42053.47 throughput)
>     Each took about 4.78 msec latency
>     1600000bytes read. 0 errors.

It would be useful to include some words which describe the
significance of this to real-world userspace.  If a real application is
sped up 0.000000001% then this isn't very exciting ;)

>
> ...
>
>    epoll_create2(EPOLL_USERPOLL, max_items_nr);

So a manpage update is due.  It would be useful to send this along
while people are reviewing the code changes.  Please cc Michael Kerrisk
and linux-man@vger.kernel.org on everything.

> 
>  arch/alpha/kernel/syscalls/syscall.tbl        |   2 +
>  arch/arm/tools/syscall.tbl                    |   1 +
>  arch/arm64/include/asm/unistd.h               |   2 +-
>  arch/arm64/include/asm/unistd32.h             |   2 +
>  arch/ia64/kernel/syscalls/syscall.tbl         |   2 +
>  arch/m68k/kernel/syscalls/syscall.tbl         |   2 +
>  arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl     |   2 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl     |   2 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl     |   2 +
>  arch/parisc/kernel/syscalls/syscall.tbl       |   2 +
>  arch/powerpc/kernel/syscalls/syscall.tbl      |   2 +
>  arch/s390/kernel/syscalls/syscall.tbl         |   2 +
>  arch/sh/kernel/syscalls/syscall.tbl           |   2 +
>  arch/sparc/kernel/syscalls/syscall.tbl        |   2 +
>  arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
>  fs/eventpoll.c                                | 925 ++++++++++++++++--

Wow.

>  include/linux/syscalls.h                      |   1 +
>  include/uapi/asm-generic/unistd.h             |   4 +-
>  include/uapi/linux/eventpoll.h                |  47 +-
>  kernel/sys_ni.c                               |   1 +
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/uepoll/.gitignore     |   1 +
>  tools/testing/selftests/uepoll/Makefile       |  16 +
>  .../uepoll/atomic-builtins-support.c          |  13 +
>  tools/testing/selftests/uepoll/uepoll-test.c  | 603 ++++++++++++

There's a lot to look at here.  I guess now would be a good time to
refresh and resend.

