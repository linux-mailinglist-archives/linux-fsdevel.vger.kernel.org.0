Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA1F1EC5C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 01:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgFBXbC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 19:31:02 -0400
Received: from albireo.enyo.de ([37.24.231.21]:55286 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgFBXbC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:31:02 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jgGN0-0005GC-1l; Tue, 02 Jun 2020 23:30:58 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jgGMz-0001Se-VB; Wed, 03 Jun 2020 01:30:57 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, fweimer@redhat.com, jannh@google.com,
        oleg@redhat.com, arnd@arndb.de, shuah@kernel.org,
        dhowells@redhat.com, ldv@altlinux.org
Subject: Re: [PATCH v5 1/3] open: add close_range()
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
        <20200602204219.186620-2-christian.brauner@ubuntu.com>
Date:   Wed, 03 Jun 2020 01:30:57 +0200
In-Reply-To: <20200602204219.186620-2-christian.brauner@ubuntu.com> (Christian
        Brauner's message of "Tue, 2 Jun 2020 22:42:17 +0200")
Message-ID: <87d06hdozy.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Christian Brauner:

> The performance is striking. For good measure, comparing the following
> simple close_all_fds() userspace implementation that is essentially just
> glibc's version in [6]:
>
> static int close_all_fds(void)
> {
>         int dir_fd;
>         DIR *dir;
>         struct dirent *direntp;
>
>         dir = opendir("/proc/self/fd");
>         if (!dir)
>                 return -1;
>         dir_fd = dirfd(dir);
>         while ((direntp = readdir(dir))) {
>                 int fd;
>                 if (strcmp(direntp->d_name, ".") == 0)
>                         continue;
>                 if (strcmp(direntp->d_name, "..") == 0)
>                         continue;
>                 fd = atoi(direntp->d_name);
>                 if (fd == dir_fd || fd == 0 || fd == 1 || fd == 2)
>                         continue;
>                 close(fd);
>         }
>         closedir(dir);
>         return 0;
> }
>

> [6]: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/grantpt.c;h=2030e07fa6e652aac32c775b8c6e005844c3c4eb;hb=HEAD#l17
>      Note that this is an internal implementation that is not exported.
>      Currently, libc seems to not provide an exported version of this
>      because of missing kernel support to do this.

Just to be clear, this code is not compiled into glibc anymore in
typical configurations.  I have posted a patch to turn grantpt into a
no-op: <https://sourceware.org/pipermail/libc-alpha/2020-May/114379.html>

I'm not entirely convinced that it's safe to keep iterating over
/proc/self/fd while also closing descriptors.  Ideally, I think an
application should call getdents64, process the file names for
descriptors in the buffer, and if any have been closed, seek to zero
before the next getdents64 call.  Maybe procfs is different, but with
other file systems, unlinking files can trigger directory reordering,
and then you get strange effects.  The d_ino behavior for
/proc/self/fd is a bit strange as well (it's not consistently
descriptor plus 3).
