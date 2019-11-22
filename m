Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD89107796
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 19:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfKVSrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 13:47:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48512 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfKVSrz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:47:55 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYDyC-0003Ny-OB; Fri, 22 Nov 2019 18:47:53 +0000
Date:   Fri, 22 Nov 2019 18:47:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Meng Xu <mengxu.gatech@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: Possible data race on file->f_mode between __fget() and
 generic_fadvise()
Message-ID: <20191122184752.GF26530@ZenIV.linux.org.uk>
References: <CAAwBoOKor7qvLs0OaXQ0-CLUpCssukdkfamTQN5c6OQiD2vY3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAwBoOKor7qvLs0OaXQ0-CLUpCssukdkfamTQN5c6OQiD2vY3w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 18, 2019 at 09:02:31PM -0500, Meng Xu wrote:
>                     __fget
>                       [READ] if (file->f_mode & mask)
> 
> [Thread 2: SYS_fadvise64]
> __do_sys_fadvise64
>   ksys_fadvise64_64
>     vfs_fadvise
>       generic_fadvise
>         [WRITE] file->f_mode &= ~FMODE_RANDOM;
> 
> However, in this particular case, there is no issues caused as the
> mask passed in __fget() is always 0 and hence, does not matter what
> the [WRITE] statement is doing.

Or FMODE_PATH.  Other readers in the same area look at FMODE_ATOMIC_POS
as well.  And neither FMODE_PATH nor FMODE_ATOMIC_POS is ever modified
after the time struct file instance is set up - certainly not after the
time it's present in descriptor table.

Barriers to look at:
        rcu_assign_pointer(fdt->fd[fd], file);
on the insertion side (__fd_install()),
                return rcu_dereference_raw(fdt->fd[fd]);
on the fetch side (fcheck_files()).  All stores to *file done
prior to putting it into descriptor table should be visible
to everyone who fetches file from there.

If your struct file reaches the reader via some other mechanism, the barriers
are up to that other mechanism.  These are for descriptor tables.  In case of
transmission by SCM_RIGHTS datagrams, for example, we have a RELEASE/ACQUIRE
pair provided by queue lock of the AF_UNIX socket involved, etc.

Generally, if another thread could find a struct file instance, but fail to
observe the stores done by do_dentry_open(), we would be very deep in trouble;
that would include the stores done by ->open(), setting of ->f_op, etc.
So anything that makes struct file visible in shared data structures ought
to take care with barriers, with (minimal) cooperation of those who fetch it
from those.  Pretty much any kind of locks will do it automatically (all
stores prior to unlock are visible to everone doing lock later); lockless
mechanisms need to take some care.

In any case, these bits of ->f_mode fall into the same category as ->f_path,
->f_op, etc. - set prior to return from the function that sets the struct
file instance up and never changed afterwards.  All flags that can be
changed later are protected by ->f_lock; actually, right now it's
FMODE_RANDOM alone, but that can change.
