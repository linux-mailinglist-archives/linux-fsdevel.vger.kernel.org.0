Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66506306D25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 06:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhA1F6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 00:58:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229709AbhA1F6L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 00:58:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A87961492;
        Thu, 28 Jan 2021 05:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611813450;
        bh=tkmtX+dK1acIF/V8vLO4Zz9EhD8ThQEJ94dsj2/XvNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tr90wUH6j79pbhc4xcWnqvj3+95HpXolmXg3M9kao2ljsCTFGWldwU398cwpzHOgQ
         4rsPkF898piXzONLgzjiR/EOiLUO/A2+p4p+8WrOkXMfbI2T08S0s1Sm/dK1UA3oXW
         NZW+IF8P492CbWizuprbQ8EzzZ2Iv+uiqFTUHFmkP1MEgj6I/cQ0I/+SsHRBggv5Fx
         TC06VolCb8/tvr7HVrSTelh8fXQdoPX1c3eQ79yO6dpdGtmkUeDbmTvEFF0XxhMzn8
         l3cgyIbVg1L08EDRfHhYJrQ+XlcVC/PJLw/xZ68/OpV8QkggiKb14FRFo9yvRO4ZZB
         uCahBq7Zj9iuw==
Date:   Wed, 27 Jan 2021 21:57:26 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Luis Lozano <llozano@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: generic_copy_file_checks: Do not adjust count based
 on file size
Message-ID: <20210128055726.GF7695@magnolia>
References: <20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid>
 <20210126233840.GG4626@dread.disaster.area>
 <CANMq1KBcs+S02T=76V6YMwTprUx6ucTK8d+ZKG2VmekbXPBZnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANMq1KBcs+S02T=76V6YMwTprUx6ucTK8d+ZKG2VmekbXPBZnA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 08:46:04AM +0800, Nicolas Boichat wrote:
> On Wed, Jan 27, 2021 at 7:38 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Tue, Jan 26, 2021 at 01:50:22PM +0800, Nicolas Boichat wrote:
> > > copy_file_range (which calls generic_copy_file_checks) uses the
> > > inode file size to adjust the copy count parameter. This breaks
> > > with special filesystems like procfs/sysfs, where the file size
> > > appears to be zero, but content is actually returned when a read
> > > operation is performed.
> > >
> > > This commit ignores the source file size, and makes copy_file_range
> > > match the end of file behaviour documented in POSIX's "read",
> > > where 0 is returned to mark EOF. This would allow "cp" and other
> > > standard tools to make use of copy_file_range with the exact same
> > > behaviour as they had in the past.
> > >
> > > Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
> > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> >
> > Nack.
> 
> Thanks Dave and Al for the detailed explanations.
> 
> >
> > As I've explained, this is intentional and bypassing it is not a
> > work around for enabling cfr on filesystems that produce ephemeral,
> > volatile read-once data using seq-file pipes that masquerade as
> > regular files with zero size. These files are behaving like pipes
> > and only work because the VFS has to support read() and friends from
> > pipes that don't publish the amount of data they contain to the VFS
> > inode.
> >
> > copy_file_range() does not support such behaviour.
> >
> > copy_file_range() -writes- data, so we have to check that those
> > writes do not extend past boundaries that the destination inode
> > imposes on the operation. e.g. maximum offset limits, whether the
> > ranges overlap in the same file, etc.
> >
> > Hence we need to know how much data there is present to copy before
> > we can check if it is safe to perform the -write- of the data we are
> > going to read. Hence we cannot safely support data sources that
> > cannot tell us how much data is present before we start the copy
> > operation.
> >
> > IOWs, these source file EOF restrictions are required by the write
> > side of copy_file_range(), not the read side.
> >
> > > ---
> > > This can be reproduced with this simple test case:
> > >  #define _GNU_SOURCE
> > >  #include <fcntl.h>
> > >  #include <stdio.h>
> > >  #include <stdlib.h>
> > >  #include <sys/stat.h>
> > >  #include <unistd.h>
> > >
> > >  int
> > >  main(int argc, char **argv)
> > >  {
> > >    int fd_in, fd_out;
> > >    loff_t ret;
> > >
> > >    fd_in = open("/proc/version", O_RDONLY);
> > >    fd_out = open("version", O_CREAT | O_WRONLY | O_TRUNC, 0644);
> > >
> > >    do {
> > >      ret = copy_file_range(fd_in, NULL, fd_out, NULL, 1024, 0);
> > >      printf("%d bytes copied\n", (int)ret);
> > >    } while (ret > 0);
> > >
> > >    return 0;
> > >  }
> > >
> > > Without this patch, `version` output file is empty, and no bytes
> > > are copied:
> > > 0 bytes copied
> >
> > $ ls -l /proc/version
> > -r--r--r-- 1 root root 0 Jan 20 17:25 /proc/version
> > $
> >
> > It's a zero length file.
> >
> > sysfs does this just fine - it's regular files have a size of
> > at least PAGE_SIZE rather than zero, and so copy_file_range works
> > just fine on them:
> >
> > $ ls -l /sys/block/nvme0n1/capability
> > -r--r--r-- 1 root root 4096 Jan 27 08:41 /sys/block/nvme0n1/capability
> > $ cat /sys/block/nvme0n1/capability
> > 50
> > $ xfs_io -f -c "copy_range -s 0 -d 0 -l 4096 /sys/block/nvme0n1/capability" /tmp/foo
> > $ sudo cat /tmp/foo
> > 50
> >
> > And the behaviour is exactly as you'd expect a read() loop to copy
> > the file to behave:
> >
> > openat(AT_FDCWD, "/tmp/foo", O_RDWR|O_CREAT, 0600) = 3
> > ....
> > openat(AT_FDCWD, "/sys/block/nvme0n1/capability", O_RDONLY) = 4
> > copy_file_range(4, [0], 3, [0], 4096, 0) = 3
> > copy_file_range(4, [3], 3, [3], 4093, 0) = 0
> > close(4)
> >
> > See? Inode size of 4096 means there's a maximum of 4kB of data that
> > can be read from this file.  copy_file_range() now behaves exactly
> > as read() would, returning a short copy and then 0 bytes to indicate
> > EOF.
> 
> Unless the content happens to be larger than PAGE_SIZE, then
> copy_file_range would only copy the beginning of the file. And as Al
> explained, this will still break in case of short writes.
> 
> >
> > If you want ephemeral data pipes masquerading as regular files to
> > work with copy_file_range, then the filesystem implementation needs
> > to provide the VFS with a data size that indicates the maximum
> > amount of data that the pipe can produce in a continuous read loop.
> > Otherwise we cannot validate the range of the write we may be asked
> > to perform...
> >
> > > Under the hood, Go 1.15 uses `copy_file_range` syscall to optimize the
> > > copy operation. However, that fails to copy any content when the input
> > > file is from sysfs/tracefs, with an apparent size of 0 (but there is
> > > still content when you `cat` it, of course).
> >
> > Libraries using copy_file_range() must be prepared for it to fail
> > and fall back to normal copy mechanisms.
> 
> How is userspace suppose to detect that? (checking for 0 file size
> won't work with the example above)
> 
> > Of course, with these
> > special zero length files that contain ephemeral data, userspace can't
> > actually tell that they contain data from userspace using stat(). So
> > as far as userspace is concerned, copy_file_range() correctly
> > returned zero bytes copied from a zero byte long file and there's
> > nothing more to do.
> >
> > This zero length file behaviour is, fundamentally, a kernel
> > filesystem implementation bug, not a copy_file_range() bug.
> 
> Okay, so, based on this and Al's reply, I see 2 things we can do:
>  1. Go should probably not use copy_file_range in a common library
> function, as I don't see any easy way to detect this scenario
> currently (detect 0 size? sure, but that won't work with the example
> you provide above). And the man page should document this behaviour
> more explicitly to prevent further incorrect usage.
>  2. Can procfs/sysfs/debugfs and friends explicitly prevent usage of
> copy_file_range? (based on Al's reply, there seems to be no way to
> implement it correctly as seeking in such files will not work in case
> of short writes)

One /could/ make those three provide a phony CFR implementation that
would return -EOPNOTSUPP, though like others have said, it's weird to
have regular files that aren't quite regular.  Not sure where that
leaves them, though...

--D

> 
> Thanks,
> 
> >
> > Cheers,
> >
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
