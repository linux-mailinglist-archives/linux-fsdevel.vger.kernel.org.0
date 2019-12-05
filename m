Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA17113B60
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 06:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfLEFk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 00:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfLEFk0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 00:40:26 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF37B2077B;
        Thu,  5 Dec 2019 05:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575524425;
        bh=NujaaeWvZ0P2hcz5OsZ39CpYtXidgPweiJoxl73fyUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvB2tL6v7Ee4BS0XKsYXEh42CTHxh6hs9naKPosuKhU2wdpCq4dPvKHnZ1joXt171
         CrCFCfFB5pt8A5NX0VynS3Dpmt1dUxOdKhf6UBMCQKkhGpGevL/jXr2MslgtXxZJpN
         RqLYxkEui9/aPKDp40CAAZFUB6WXS4uzriDFF0gA=
Date:   Wed, 4 Dec 2019 21:40:23 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     dhowells@redhat.com
Cc:     amit@kernel.org, arnd@arndb.de,
        syzbot <syzbot+d37abaade33a934f16f2@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, jannh@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        virtualization@lists.linux-foundation.org, willy@infradead.org
Subject: Re: kernel BUG at fs/pipe.c:LINE!
Message-ID: <20191205054023.GA772@sol.localdomain>
References: <000000000000a376820598b2eb97@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a376820598b2eb97@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David,

On Sun, Dec 01, 2019 at 10:45:08PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1387ab12e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
> dashboard link: https://syzkaller.appspot.com/bug?extid=d37abaade33a934f16f2
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12945c41e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161e202ee00000
> 
> The bug was bisected to:
> 
> commit 8cefc107ca54c8b06438b7dc9cc08bc0a11d5b98
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri Nov 15 13:30:32 2019 +0000
> 
>     pipe: Use head and tail pointers for the ring, not cursor and length
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=118cce96e00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=138cce96e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=158cce96e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d37abaade33a934f16f2@syzkaller.appspotmail.com
> Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not
> cursor and length")
> 
> ------------[ cut here ]------------
> kernel BUG at fs/pipe.c:582!

This same BUG_ON() crashed my system during normal use, no syzkaller involved at
all, on mainline 937d6eefc7.  Can you please take a look?  This syzbot report
has a reproducer so that might be the easiest place to start.

- Eric
