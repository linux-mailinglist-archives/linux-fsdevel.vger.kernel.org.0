Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E23CBDB5AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 20:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441218AbfJQSRQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 14:17:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36896 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438601AbfJQSRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:17:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22so3537102wmc.2;
        Thu, 17 Oct 2019 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XgooItt3yunwxCJxadoUen7+696jxS3yzALjSNjUwlM=;
        b=l1Hmfd7j/16bXUDYrMQfrgAM9KgZFGcfCEv2TrygM2pGHs/mVjXbKuN6kKcLeFCDvU
         grU+Qze05EbFLX0Xt5bzgt4aDLP07IayYVowHfDo9j+7dbhGZhO309axcijHpFQ0yd05
         Cb4wvYQds43buFxN55MXtIXFBoVqgwtFZLmOC7ab9R18dfAuTcqgg/kCzyV/4NXlVNu/
         igWR16tVws9TbjyyiVro1JCAdnsg2Cl7mUJYQdoZ2QLy3wOZv7YLWRDNyvQQsj5cvQOF
         0DP2sjOpN9fwIpaho7A3tppiGgX7NxOCLNc47fCTr7rk8P4gKS+lU6Z8s1azzNUIDiuQ
         f2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XgooItt3yunwxCJxadoUen7+696jxS3yzALjSNjUwlM=;
        b=BjGokvomXxUJ3ZVMour77hYk4NolWVMojkSi7EAG8TMGCc39WNYbzJJZgRC4oXaipY
         bzKdT3+hVxRk+usEfAJ0eSYYzBfTt3zm4/WOSkYxiViXPbf724ij4ftMgxR9q89MfrNm
         mZcStf3Zw1utx9eMZCMrp81fO1H3JLsvjSt/rAEYTOLbZl03rartURoT2TYpcCCNLQsd
         UQwUeVS2e6UOGHL3DnjLH9aiwpwKKdD1nszbl5pB5zv0PN2QYEWgb16WsCvVb4z+AUUl
         9ZX2/LC2qJ6PMGsl2u2nlz6Xr7vE3c0ffnvzxQryB/H7hpulem7xuEc1GHTsxkT+tUw8
         B6RQ==
X-Gm-Message-State: APjAAAWL8GJ4HvJz92khCRxZLPDK9MZv0v1seLB1qbOomPTtNV6FD4vm
        wc0jkk1hQWAghMR6JHA9BA==
X-Google-Smtp-Source: APXvYqzh/xO8OFskYgrKCuP+R6Vt2W+4+5BbANuANKbP4dDWLu3Fjs2M4FolW21d9sW4iFNBbJ7Y8A==
X-Received: by 2002:a7b:c1d2:: with SMTP id a18mr4064484wmj.7.1571336233230;
        Thu, 17 Oct 2019 11:17:13 -0700 (PDT)
Received: from avx2 ([46.53.250.235])
        by smtp.gmail.com with ESMTPSA id a14sm2504313wmm.44.2019.10.17.11.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 11:17:12 -0700 (PDT)
Date:   Thu, 17 Oct 2019 21:17:09 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        casey@schaufler-ca.com, christian@brauner.io,
        Kees Cook <keescook@chromium.org>, kent.overstreet@gmail.com,
        khlebnikov@yandex-team.ru, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, mhocko@suse.com,
        shakeelb@google.com, syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: KCSAN: data-race in task_dump_owner / task_dump_owner
Message-ID: <20191017181709.GA5312@avx2>
References: <000000000000328b2905951a7667@google.com>
 <CANpmjNPoBBJgMKLEAXs+bPhitF+WygseHgTkSJsuiK8WcsB==g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNPoBBJgMKLEAXs+bPhitF+WygseHgTkSJsuiK8WcsB==g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 02:56:47PM +0200, Marco Elver wrote:
> Hi,
> 
> On Thu, 17 Oct 2019 at 14:36, syzbot
> <syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    d724f94f x86, kcsan: Enable KCSAN for x86
> > git tree:       https://github.com/google/ktsan.git kcsan
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17884db3600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c0906aa620713d80
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e392f8008a294fdf8891
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in task_dump_owner / task_dump_owner
> >
> > write to 0xffff8881255bb7fc of 4 bytes by task 7804 on cpu 0:
> >   task_dump_owner+0xd8/0x260 fs/proc/base.c:1742
> >   pid_update_inode+0x3c/0x70 fs/proc/base.c:1818
> >   pid_revalidate+0x91/0xd0 fs/proc/base.c:1841
> >   d_revalidate fs/namei.c:765 [inline]
> >   d_revalidate fs/namei.c:762 [inline]
> >   lookup_fast+0x7cb/0x7e0 fs/namei.c:1613
> >   walk_component+0x6d/0xe80 fs/namei.c:1804
> >   link_path_walk.part.0+0x5d3/0xa90 fs/namei.c:2139
> >   link_path_walk fs/namei.c:2070 [inline]
> >   path_openat+0x14f/0x3530 fs/namei.c:3532
> >   do_filp_open+0x11e/0x1b0 fs/namei.c:3563
> >   do_sys_open+0x3b3/0x4f0 fs/open.c:1089
> >   __do_sys_open fs/open.c:1107 [inline]
> >   __se_sys_open fs/open.c:1102 [inline]
> >   __x64_sys_open+0x55/0x70 fs/open.c:1102
> >   do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
> >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > write to 0xffff8881255bb7fc of 4 bytes by task 7813 on cpu 1:
> >   task_dump_owner+0xd8/0x260 fs/proc/base.c:1742
> >   pid_update_inode+0x3c/0x70 fs/proc/base.c:1818
> >   pid_revalidate+0x91/0xd0 fs/proc/base.c:1841
> >   d_revalidate fs/namei.c:765 [inline]
> >   d_revalidate fs/namei.c:762 [inline]
> >   lookup_fast+0x7cb/0x7e0 fs/namei.c:1613
> >   walk_component+0x6d/0xe80 fs/namei.c:1804
> >   lookup_last fs/namei.c:2271 [inline]
> >   path_lookupat.isra.0+0x13a/0x5a0 fs/namei.c:2316
> >   filename_lookup+0x145/0x2d0 fs/namei.c:2346
> >   user_path_at_empty+0x4c/0x70 fs/namei.c:2606
> >   user_path_at include/linux/namei.h:60 [inline]
> >   vfs_statx+0xd9/0x190 fs/stat.c:187
> >   vfs_stat include/linux/fs.h:3188 [inline]
> >   __do_sys_newstat+0x51/0xb0 fs/stat.c:341
> >   __se_sys_newstat fs/stat.c:337 [inline]
> >   __x64_sys_newstat+0x3a/0x50 fs/stat.c:337
> >   do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
> >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 1 PID: 7813 Comm: ps Not tainted 5.3.0+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > ==================================================================
> 
> My understanding is, that for every access to /proc/<pid>,
> d_revalidate is called, and /proc-fs implementation simply says that
> pid_revalidate always revalidates by rewriting uid/gid because "owning
> task may have performed a setuid(), etc." presumably so every access
> to a /proc/<pid> entry always has the right uid/gid (in effect
> updating /proc/<pid> lazily via d_revalidate).
> 
> Is it possible that one of the tasks above could be preempted after
> doing its writes to *ruid/*rgid, another thread writing some other
> values (after setuid / seteuid), and then the preempted thread seeing
> the other values? Assertion here should never fail:
> === TASK 1 ===
> | seteuid(1000);
> | seteuid(0);
> | stat("/proc/<pid-of-task-1>", &fstat);
> | assert(fstat.st_uid == 0);
> === TASK 2 ===
> | stat("/proc/<pid-of-task-1>", ...);

Is it the same as
pid_revalidate() snapshots (uid,gid) correctly
but writeback is done in any order?
