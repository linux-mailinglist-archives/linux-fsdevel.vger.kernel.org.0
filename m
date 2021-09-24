Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB3941697A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 03:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243764AbhIXBfm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 21:35:42 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:38040 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXBfm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:35:42 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id C77451A56019; Thu, 23 Sep 2021 18:34:08 -0700 (PDT)
Date:   Thu, 23 Sep 2021 18:34:08 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Message-ID: <20210924013408.mqw42x4lhqeq5ios@shells.gnugeneration.com>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109231814.FD09DBAD3@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 06:16:16PM -0700, Kees Cook wrote:
> On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> > Instead of unwinding stacks maybe the kernel should be sticking an
> > entrypoint address in the current task struct for get_wchan() to
> > access, whenever userspace enters the kernel?
> 
> wchan is supposed to show where the kernel is at the instant the
> get_wchan() happens. (i.e. recording it at syscall entry would just
> always show syscall entry.)
> 

And you have the syscall # onhand when performing the syscall entry,
no?

The point is, if the alternative is to always get 0 from
/proc/PID/wchan when a process is sitting in ioctl(), I'd be perfectly
happy to get back sys_ioctl.  I'm under the impression there's quite a
bit of vendor-specific flexibility here in terms of how precise WCHAN
is.

If it's possible to preserve the old WCHAN precision I'm all for it.
But if we've become so paranoid about leaking anything about the
kernel to userspace that this is untenable, even if it just spits out
the syscall being performed that has value.

Regards,
Vito Caputo
