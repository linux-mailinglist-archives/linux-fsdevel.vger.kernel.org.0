Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397D71DA3CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 23:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgESVp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 17:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgESVp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 17:45:27 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DADC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 14:45:26 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jbA36-00C29k-Eg; Tue, 19 May 2020 21:45:20 +0000
Date:   Tue, 19 May 2020 22:45:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Thiago Macieira <thiago.macieira@intel.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fcntl(F_DUPFD) causing apparent file descriptor table corruption
Message-ID: <20200519214520.GS23230@ZenIV.linux.org.uk>
References: <1645568.el9gB4U55B@tjmaciei-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645568.el9gB4U55B@tjmaciei-mobl1>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 02:03:03PM -0700, Thiago Macieira wrote:

> On my machine, /proc/sys/fs/nr_open is 1073741816 and I have 32 GB of RAM (if 
> the problem is related to memory consumption).
> 
> The problem only occurs when growing the table.
> 
> strace shows something like:
> fcntl(2, F_DUPFD, 1024)                 = 1024
> close(1024)                             = 0
> fcntl(2, F_DUPFD, 2048)                 = 2048
> close(2048)                             = 0
> fcntl(2, F_DUPFD, 4096)                 = 4096
> close(4096)                             = 0
> fcntl(2, F_DUPFD, 8192)                 = 8192
> close(8192)                             = 0
> fcntl(2, F_DUPFD, 16384)                = 16384
> close(16384)                            = 0
> fcntl(2, F_DUPFD, 32768)                = 32768
> close(32768)                            = 0
> fcntl(2, F_DUPFD, 65536)                = 65536
> close(65536)                            = 0
> fcntl(2, F_DUPFD, 131072)               = 131072
> close(131072)                           = 0
> fcntl(2, F_DUPFD, 262144)               = 262144
> close(262144)                           = 0
> fcntl(2, F_DUPFD, 524288)               = 524288
> close(524288)                           = 0
> fcntl(2, F_DUPFD, 1048576)              = 1048576
> close(1048576)                          = 0
> fcntl(2, F_DUPFD, 2097152)              = 2097152
> close(2097152)                          = 0
> fcntl(2, F_DUPFD, 4194304)              = 4194304
> close(4194304)                          = 0
> fcntl(2, F_DUPFD, 8388608)              = 8388608
> close(8388608)                          = 0
> fcntl(2, F_DUPFD, 16777216)             = 16777216
> close(16777216)                         = 0
> fcntl(2, F_DUPFD, 33554432)             = 33554432
> close(33554432)                         = 0
> fcntl(2, F_DUPFD, 67108864)             = 67108864
> close(67108864)                         = 0
> fcntl(2, F_DUPFD, 134217728)            = 134217728
> close(134217728)                        = 0
> fcntl(2, F_DUPFD, 536870912)            = 536870912
> close(536870912)                        = 0
> write(1, "success\n", 8)                = EBADF

Er...  It's going by powers of two, isn't it?  So where's
268435456 between 134217728 and 536870912?  And, assuming
it's a 64bit box, 536870912 pointers is 4Gb, which suggests
that we are running into 32bit overflow on calculating
some size...  Let's see -
static int expand_fdtable(struct files_struct *files, unsigned int nr)
...
        cur_fdt = files_fdtable(files);
        BUG_ON(nr < cur_fdt->max_fds);
        copy_fdtable(new_fdt, cur_fdt);
so we probably want copy_fdtable().
static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
{
        unsigned int cpy, set;

        BUG_ON(nfdt->max_fds < ofdt->max_fds);

        cpy = ofdt->max_fds * sizeof(struct file *);

Right, here's your multiplication overflow.

        set = (nfdt->max_fds - ofdt->max_fds) * sizeof(struct file *);
        memcpy(nfdt->fd, ofdt->fd, cpy);
... and here's not getting the things copied.  Which means that pointer
is left uninitialized and the damn thing might very well be a security
problem - you'd lucked out and ran into NULL, but had there been a pointer
to something, you would've gotten a memory corruptor.

The obvious fix would be to turn cpy and set into size_t - as in
ed fs/file.c <<'EOF'
/copy_fdtable/+2s/unsigned int/size_t/
w
q
EOF

On size_t overflow you would've failed allocation before getting to that
point - see sysctl_nr_open_max initializer.  Overflow in alloc_fdtable()
(nr is unsigned int there) also can't happen, AFAICS - the worst you
can get is 1U<<31, which will fail sysctl_nr_open comparison.

I really wonder about the missing couple of syscalls in your strace, though;
could you verify that they _are_ missing and see what the fix above does to
your testcase?
