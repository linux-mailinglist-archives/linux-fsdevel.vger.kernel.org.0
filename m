Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CC82DD571
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 17:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgLQQpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 11:45:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59228 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgLQQpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:45:14 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kpwOF-0006Gd-2d; Thu, 17 Dec 2020 16:44:31 +0000
Date:   Thu, 17 Dec 2020 17:44:29 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     syzbot <syzbot+96cfd2b22b3213646a93@syzkaller.appspotmail.com>
Cc:     gscrivan@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: KASAN: null-ptr-deref Read in filp_close
Message-ID: <20201217164429.ms6c5csz6wl5ruzg@wittgenstein>
References: <000000000000a3962305b6ab0077@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000a3962305b6ab0077@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 07:54:09AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5e60366d Merge tag 'fallthrough-fixes-clang-5.11-rc1' of g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f15413500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=db720fe37a6a41d8
> dashboard link: https://syzkaller.appspot.com/bug?extid=96cfd2b22b3213646a93
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e1a00b500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1128e41f500000
> 
> The issue was bisected to:
> 
> commit 582f1fb6b721facf04848d2ca57f34468da1813e
> Author: Giuseppe Scrivano <gscrivan@redhat.com>
> Date:   Wed Nov 18 10:47:45 2020 +0000
> 
>     fs, close_range: add flag CLOSE_RANGE_CLOEXEC
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e85613500000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15e85613500000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e85613500000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+96cfd2b22b3213646a93@syzkaller.appspotmail.com
> Fixes: 582f1fb6b721 ("fs, close_range: add flag CLOSE_RANGE_CLOEXEC")

Ok, I think the bug is simply that max_fd is not correctly updated when
CLOSE_RANGE_UNSHARE is combined with CLOSE_RANGE_CLOEXEC.
I'll write a patch for syszbot to chew on.

Christian
