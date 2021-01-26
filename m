Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DBC305133
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 05:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbhA0Ep7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 23:45:59 -0500
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:34517 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389878AbhA0ALA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 19:11:00 -0500
Received: from dread.disaster.area (pa49-180-243-77.pa.nsw.optusnet.com.au [49.180.243.77])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 78DCF1AD7A5;
        Wed, 27 Jan 2021 10:38:41 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l4Xuy-002mdZ-4S; Wed, 27 Jan 2021 10:38:40 +1100
Date:   Wed, 27 Jan 2021 10:38:40 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Luis Lozano <llozano@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: generic_copy_file_checks: Do not adjust count based
 on file size
Message-ID: <20210126233840.GG4626@dread.disaster.area>
References: <20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=juxvdbeFDU67v5YkIhU0sw==:117 a=juxvdbeFDU67v5YkIhU0sw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=cm27Pg_UAAAA:8 a=7-415B0cAAAA:8
        a=VJ0WtSx9crlLxiufMhEA:9 a=CjuIK1q_8ugA:10 a=xmb-EsYY8bH0VWELuYED:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 01:50:22PM +0800, Nicolas Boichat wrote:
> copy_file_range (which calls generic_copy_file_checks) uses the
> inode file size to adjust the copy count parameter. This breaks
> with special filesystems like procfs/sysfs, where the file size
> appears to be zero, but content is actually returned when a read
> operation is performed.
> 
> This commit ignores the source file size, and makes copy_file_range
> match the end of file behaviour documented in POSIX's "read",
> where 0 is returned to mark EOF. This would allow "cp" and other
> standard tools to make use of copy_file_range with the exact same
> behaviour as they had in the past.
> 
> Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Nack.

As I've explained, this is intentional and bypassing it is not a
work around for enabling cfr on filesystems that produce ephemeral,
volatile read-once data using seq-file pipes that masquerade as
regular files with zero size. These files are behaving like pipes
and only work because the VFS has to support read() and friends from
pipes that don't publish the amount of data they contain to the VFS
inode.

copy_file_range() does not support such behaviour.

copy_file_range() -writes- data, so we have to check that those
writes do not extend past boundaries that the destination inode
imposes on the operation. e.g. maximum offset limits, whether the
ranges overlap in the same file, etc.

Hence we need to know how much data there is present to copy before
we can check if it is safe to perform the -write- of the data we are
going to read. Hence we cannot safely support data sources that
cannot tell us how much data is present before we start the copy
operation.

IOWs, these source file EOF restrictions are required by the write
side of copy_file_range(), not the read side.

> ---
> This can be reproduced with this simple test case:
>  #define _GNU_SOURCE
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <sys/stat.h>
>  #include <unistd.h>
> 
>  int
>  main(int argc, char **argv)
>  {
>    int fd_in, fd_out;
>    loff_t ret;
> 
>    fd_in = open("/proc/version", O_RDONLY);
>    fd_out = open("version", O_CREAT | O_WRONLY | O_TRUNC, 0644);
> 
>    do {
>      ret = copy_file_range(fd_in, NULL, fd_out, NULL, 1024, 0);
>      printf("%d bytes copied\n", (int)ret);
>    } while (ret > 0);
> 
>    return 0;
>  }
> 
> Without this patch, `version` output file is empty, and no bytes
> are copied:
> 0 bytes copied

$ ls -l /proc/version
-r--r--r-- 1 root root 0 Jan 20 17:25 /proc/version
$

It's a zero length file.

sysfs does this just fine - it's regular files have a size of
at least PAGE_SIZE rather than zero, and so copy_file_range works
just fine on them:

$ ls -l /sys/block/nvme0n1/capability
-r--r--r-- 1 root root 4096 Jan 27 08:41 /sys/block/nvme0n1/capability
$ cat /sys/block/nvme0n1/capability
50
$ xfs_io -f -c "copy_range -s 0 -d 0 -l 4096 /sys/block/nvme0n1/capability" /tmp/foo
$ sudo cat /tmp/foo
50

And the behaviour is exactly as you'd expect a read() loop to copy
the file to behave:

openat(AT_FDCWD, "/tmp/foo", O_RDWR|O_CREAT, 0600) = 3
....
openat(AT_FDCWD, "/sys/block/nvme0n1/capability", O_RDONLY) = 4
copy_file_range(4, [0], 3, [0], 4096, 0) = 3
copy_file_range(4, [3], 3, [3], 4093, 0) = 0
close(4)

See? Inode size of 4096 means there's a maximum of 4kB of data that
can be read from this file.  copy_file_range() now behaves exactly
as read() would, returning a short copy and then 0 bytes to indicate
EOF.

If you want ephemeral data pipes masquerading as regular files to
work with copy_file_range, then the filesystem implementation needs
to provide the VFS with a data size that indicates the maximum
amount of data that the pipe can produce in a continuous read loop.
Otherwise we cannot validate the range of the write we may be asked
to perform...

> Under the hood, Go 1.15 uses `copy_file_range` syscall to optimize the
> copy operation. However, that fails to copy any content when the input
> file is from sysfs/tracefs, with an apparent size of 0 (but there is
> still content when you `cat` it, of course).

Libraries using copy_file_range() must be prepared for it to fail
and fall back to normal copy mechanisms. Of course, with these
special zero length files that contain ephemeral data, userspace can't
actually tell that they contain data from userspace using stat(). So
as far as userspace is concerned, copy_file_range() correctly
returned zero bytes copied from a zero byte long file and there's
nothing more to do.

This zero length file behaviour is, fundamentally, a kernel
filesystem implementation bug, not a copy_file_range() bug.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
