Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 111EA113C93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 08:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfLEHpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 02:45:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfLEHpl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:45:41 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0B09205F4;
        Thu,  5 Dec 2019 07:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575531941;
        bh=ifbaeIoJpLRIvxZ4GbFj0GwuxwpkNX2lyM72QJGHXeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YSqXt3Zi8p11o6bjxCkGZ09oHU42ylrGURXipbaQh9jJlV04nJ+el7v4gLvbVzzwL
         xRemKqPXiO1xzqZgKMV8yjUj7Vssd7Pk1ESjnSShxlyIZ7U0lmYCRJWyBzLRTYNCon
         kkm16HQeVq/2sEuIOIoGTGHS5LkhZd6Pw/jUnx3s=
Date:   Wed, 4 Dec 2019 23:45:39 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        syzbot <syzbot+838eb0878ffd51f27c41@syzkaller.appspotmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in pipe_write
Message-ID: <20191205074539.GB3237@sol.localdomain>
References: <000000000000a6324b0598b2eb59@google.com>
 <000000000000d6c9870598bdf090@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d6c9870598bdf090@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Mon, Dec 02, 2019 at 11:54:00AM -0800, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit a194dfe6e6f6f7205eea850a420f2bc6a1541209
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri Sep 20 15:32:19 2019 +0000
> 
>     pipe: Rearrange sequence in pipe_write() to preallocate slot
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16085abce00000
> start commit:   b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15085abce00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11085abce00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
> dashboard link: https://syzkaller.appspot.com/bug?extid=838eb0878ffd51f27c41
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146a9f86e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1791d82ae00000
> 
> Reported-by: syzbot+838eb0878ffd51f27c41@syzkaller.appspotmail.com
> Fixes: a194dfe6e6f6 ("pipe: Rearrange sequence in pipe_write() to
> preallocate slot")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 

It looks like the 'mask' variable in pipe_write() is not being updated after the
pipe mutex was dropped in pipe_wait(), to take into account the pipe size
possibly having been changed in the mean time.

BTW, I see that the pipe changes were not in linux-next before being sent to
Linus.  Please do this next time so that syzbot can find the obvious bugs before
they reach mainline.  It's annoying having my system crash on latest mainline
during normal use, due to a bug easily found in < 1 day by an automated system.

- Eric
