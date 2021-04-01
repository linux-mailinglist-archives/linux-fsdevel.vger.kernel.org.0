Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67468350B80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhDABIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhDABIr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:08:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EC5E61057;
        Thu,  1 Apr 2021 01:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239327;
        bh=HwWCq6SxvUfuy5a9dDVIH4MpXqTQrl97cM0rg3ExtiM=;
        h=Subject:From:To:Cc:Date:From;
        b=Yl5HamVNGOnj3haG2U2nvOySfjLHPBzAhMEHhQmph/+dSqFd3VvjzNOUTYeYvKHVM
         b9bsUc2ZXAv1nim06P6QLD1yCKuZBXy2MpxAWxu0Cx2qsTKCn3YcD9K7p3doqLMBIY
         gsrCCRCPe7Jroi3dnbouV7CVBW36DyD7sSLIvhgv7kcRkM5jILZZET5Xw03EGMbu87
         IZLx415HF19SY2xfG4dYo7FuFSOwmpE35lGd7lWr8PATBr6L/zjCQclxy/A9/vDCqH
         WAsmHGAU5oaz7CsI07qtv2R7UTUI3s18rBoG54N38PPOTu+IURMV8qZFDQ+ncQz0zn
         6xO5exBs+N4ag==
Subject: [PATCHSET RFC v3 00/18] xfs: atomic file updates
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:08:46 -0700
Message-ID: <161723932606.3149451.12366114306150243052.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This series creates a new FIEXCHANGE_RANGE system call to exchange
ranges of bytes between two files atomically.  This new functionality
enables data storage programs to stage and commit file updates such that
reader programs will see either the old contents or the new contents in
their entirety, with no chance of torn writes.  A successful call
completion guarantees that the new contents will be seen even if the
system fails.

User programs will be able to update files atomically by opening an
O_TMPFILE, reflinking the source file to it, making whatever updates
they want to make, and exchange the relevant ranges of the temp file
with the original file.  If the updates are aligned with the file block
size, a new (since v2) flag provides for exchanging only the written
areas.  Callers can arrange for the update to be rejected if the
original file has been changed.

The intent behind this new userspace functionality is to enable atomic
rewrites of arbitrary parts of individual files.  For years, application
programmers wanting to ensure the atomicity of a file update had to
write the changes to a new file in the same directory, fsync the new
file, rename the new file on top of the old filename, and then fsync the
directory.  People get it wrong all the time, and $fs hacks abound.
Here is the proposed manual page:

IOCTL-FIEXCHANGE_RANGE(Linux Programmer's ManIOCTL-FIEXCHANGE_RANGE(2)

NAME
       ioctl_fiexchange_range  - exchange the contents of parts of two
       files

SYNOPSIS
       #include <sys/ioctl.h>
       #include <linux/fiexchange.h>

       int    ioctl(int     file2_fd,     FIEXCHANGE_RANGE,     struct
       file_xchg_range *arg);

DESCRIPTION
       Given  a  range  of bytes in a first file file1_fd and a second
       range of bytes in a second file  file2_fd,  this  ioctl(2)  ex‐
       changes the contents of the two ranges.

       Exchanges  are  atomic  with  regards to concurrent file opera‐
       tions, so no userspace-level locks need to be taken  to  obtain
       consistent  results.  Implementations must guarantee that read‐
       ers see either the old contents or the new  contents  in  their
       entirety, even if the system fails.

       The exchange parameters are conveyed in a structure of the fol‐
       lowing form:

           struct file_xchg_range {
               __s64    file1_fd;
               __s64    file1_offset;
               __s64    file2_offset;
               __s64    length;

               __u64    flags;

               __s64    file2_ino;
               __s64    file2_mtime;
               __s64    file2_ctime;
               __s32    file2_mtime_nsec;
               __s32    file2_ctime_nsec;

               __u64    pad[6];
           };

       The field pad must be zero.

       The fields file1_fd, file1_offset, and length define the  first
       range of bytes to be exchanged.

       The fields file2_fd, file2_offset, and length define the second
       range of bytes to be exchanged.

       Both files must be from the same filesystem mount.  If the  two
       file  descriptors represent the same file, the byte ranges must
       not overlap.  Most  disk-based  filesystems  require  that  the
       starts  of  both ranges must be aligned to the file block size.
       If this is the case, the ends of the ranges  must  also  be  so
       aligned unless the FILE_XCHG_RANGE_TO_EOF flag is set.

       The field flags control the behavior of the exchange operation.

           FILE_XCHG_RANGE_FILE2_FRESH
                  Check  the  freshness  of file2_fd after locking the
                  file but before exchanging the contents.   The  sup‐
                  plied  file2_ino field must match file2's inode num‐
                  ber, and the supplied file2_mtime, file2_mtime_nsec,
                  file2_ctime,  and file2_ctime_nsec fields must match
                  the modification time and change time of file2.   If
                  they do not match, EBUSY will be returned.

           FILE_XCHG_RANGE_TO_EOF
                  Ignore  the length parameter.  All bytes in file1_fd
                  from file1_offset to EOF are moved to file2_fd,  and
                  file2's  size is set to (file2_offset+(file1_length-
                  file1_offset)).  Meanwhile, all bytes in file2  from
                  file2_offset  to  EOF are moved to file1 and file1's
                  size   is   set   to    (file1_offset+(file2_length-
                  file2_offset)).   This option is not compatible with
                  FILE_XCHG_RANGE_FULL_FILES.

           FILE_XCHG_RANGE_FSYNC
                  Ensure that all modified in-core data in  both  file
                  ranges  and  all  metadata updates pertaining to the
                  exchange operation are flushed to persistent storage
                  before  the  call  returns.  Opening either file de‐
                  scriptor with O_SYNC or O_DSYNC will have  the  same
                  effect.

           FILE_XCHG_RANGE_SKIP_FILE1_HOLES
                  Skip  sub-ranges  of  file1_fd that are known not to
                  contain data.  This facility can be used  to  imple‐
                  ment  atomic scatter-gather writes of any complexity
                  for software-defined storage targets.

           FILE_XCHG_RANGE_DRY_RUN
                  Check the parameters and the feasibility of the  op‐
                  eration, but do not change anything.

           FILE_XCHG_RANGE_COMMIT
                  This      flag      is      a     combination     of
                  FILE_XCHG_RANGE_FILE2_FRESH |  FILE_XCHG_RANGE_FSYNC
                  and  can  be  used  to commit changes to file2_fd to
                  persistent storage if and  only  if  file2  has  not
                  changed.

           FILE_XCHG_RANGE_FULL_FILES
                  Require that file1_offset and file2_offset are zero,
                  and that the length field  matches  the  lengths  of
                  both  files.   If  not, EDOM will be returned.  This
                  option      is       not       compatible       with
                  FILE_XCHG_RANGE_TO_EOF.

           FILE_XCHG_RANGE_NONATOMIC
                  This  flag  relaxes the requirement that readers see
                  only the old contents or the new contents  in  their
                  entirety.   If  the system fails before all modified
                  in-core data and metadata updates are  persisted  to
                  disk,  the contents of both file ranges after recov‐
                  ery are not defined and may be a mix of both.

                  Do not use this flag unless  the  contents  of  both
                  ranges  are  known  to be identical and there are no
                  other writers.

RETURN VALUE
       On error, -1 is returned, and errno is set to indicate the  er‐
       ror.

ERRORS
       Error  codes can be one of, but are not limited to, the follow‐
       ing:

       EBADF  file1_fd is not open for reading and writing or is  open
              for  append-only  writes;  or  file2_fd  is not open for
              reading and writing or is open for append-only writes.

       EBUSY  The inode number and timestamps supplied  do  not  match
              file2_fd  and  FILE_XCHG_RANGE_FILE2_FRESH  was  set  in
              flags.

       EDOM   The ranges do not cover the entirety of both files,  and
              FILE_XCHG_RANGE_FULL_FILES was set in flags.

       EINVAL The  parameters  are  not correct for these files.  This
              error can also appear if either file  descriptor  repre‐
              sents  a device, FIFO, or socket.  Disk filesystems gen‐
              erally require the offset and  length  arguments  to  be
              aligned to the fundamental block sizes of both files.

       EIO    An I/O error occurred.

       EISDIR One of the files is a directory.

       ENOMEM The  kernel  was unable to allocate sufficient memory to
              perform the operation.

       ENOSPC There is not enough free space  in  the  filesystem  ex‐
              change the contents safely.

       EOPNOTSUPP
              The filesystem does not support exchanging bytes between
              the two files.

       EPERM  file1_fd or file2_fd are immutable.

       ETXTBSY
              One of the files is a swap file.

       EUCLEAN
              The filesystem is corrupt.

       EXDEV  file1_fd and  file2_fd  are  not  on  the  same  mounted
              filesystem.

CONFORMING TO
       This API is Linux-specific.

USE CASES
       Three use cases are imagined for this system call.

       The  first  is a filesystem defragmenter, which copies the con‐
       tents of a file into another file and wishes  to  exchange  the
       space  mappings  of  the  two files, provided that the original
       file has not changed.  The flags NONATOMIC and FILE2_FRESH  are
       recommended for this application.

       The  second is a data storage program that wants to commit non-
       contiguous updates to a file atomically.  This can be  done  by
       creating a temporary file, calling FICLONE(2) to share the con‐
       tents, and staging the updates into the temporary file.  Either
       of  the  FULL_FILES or TO_EOF flags are recommended, along with
       FSYNC.  Depending on  the  application's  locking  design,  the
       flags FILE2_FRESH or COMMIT may be applicable here.  The tempo‐
       rary file can be deleted or punched out afterwards.

       The third is a software-defined storage host (e.g. a disk juke‐
       box)  which  implements an atomic scatter-gather write command.
       Provided the exported disk's logical  block  size  matches  the
       file's  allocation  unit  size,  this can be done by creating a
       temporary file and writing the data at the appropriate offsets.
       Use  this  call  with  the SKIP_HOLES flag to exchange only the
       blocks involved in the write command.  The  use  of  the  FSYNC
       flag is recommended here.  The temporary file should be deleted
       or punched out completely before being reused to stage  another
       write.

NOTES
       Some  filesystems may limit the amount of data or the number of
       extents that can be exchanged in a single call.

SEE ALSO
       ioctl(2)

Linux                         2021-04-01     IOCTL-FIEXCHANGE_RANGE(2)

The reference implementation in XFS creates a new log incompat feature
and log intent items to track high level progress of swapping ranges of
two files and finish interrupted work if the system goes down.  Sample
code can be found in the corresponding changes to xfs_io to exercise the
use case mentioned above.

Note that this function is /not/ the O_DIRECT atomic file writes concept
that has also been floating around for years.  This RFC is constructed
entirely in software, which means that there are no limitations other
than the general filesystem limits.

As a side note, the original motivation behind the kernel functionality
is online repair of file-based metadata.  The atomic file swap is
implemented as an atomic inode fork swap, which means that we can
implement online reconstruction of extended attributes and directories
by building a new one in another inode and atomically swap the contents.

Subsequent patchsets adapt the online filesystem repair code to use
atomic extent swapping.  This enables repair functions to construct a
clean copy of a directory, xattr information, realtime bitmaps, and
realtime summary information in a temporary inode.  If this completes
successfully, the new contents can be swapped atomically into the inode
being repaired.  This is essential to avoid making corruption problems
worse if the system goes down in the middle of running repair.

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=atomic-file-updates

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=atomic-file-updates

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=atomic-file-updates

xfsdocs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-documentation.git/log/?h=atomic-file-updates
---
 Documentation/filesystems/vfs.rst |   16 +
 fs/ioctl.c                        |   42 ++
 fs/remap_range.c                  |  283 ++++++++++
 fs/xfs/Makefile                   |    3 
 fs/xfs/libxfs/xfs_bmap.h          |    4 
 fs/xfs/libxfs/xfs_defer.c         |   49 +-
 fs/xfs/libxfs/xfs_defer.h         |   11 
 fs/xfs/libxfs/xfs_errortag.h      |    4 
 fs/xfs/libxfs/xfs_format.h        |   37 +
 fs/xfs/libxfs/xfs_fs.h            |    2 
 fs/xfs/libxfs/xfs_log_format.h    |   63 ++
 fs/xfs/libxfs/xfs_log_recover.h   |    4 
 fs/xfs/libxfs/xfs_sb.c            |    2 
 fs/xfs/libxfs/xfs_shared.h        |    6 
 fs/xfs/libxfs/xfs_swapext.c       | 1030 +++++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_swapext.h       |   89 +++
 fs/xfs/xfs_bmap_item.c            |   13 
 fs/xfs/xfs_bmap_util.c            |  611 ----------------------
 fs/xfs/xfs_bmap_util.h            |    3 
 fs/xfs/xfs_error.c                |    3 
 fs/xfs/xfs_extfree_item.c         |    2 
 fs/xfs/xfs_file.c                 |   49 ++
 fs/xfs/xfs_inode.c                |   13 
 fs/xfs/xfs_inode.h                |    1 
 fs/xfs/xfs_ioctl.c                |  102 +---
 fs/xfs/xfs_ioctl.h                |    4 
 fs/xfs/xfs_ioctl32.c              |    8 
 fs/xfs/xfs_log.c                  |   65 ++
 fs/xfs/xfs_log.h                  |    3 
 fs/xfs/xfs_log_priv.h             |    3 
 fs/xfs/xfs_log_recover.c          |   57 ++
 fs/xfs/xfs_mount.c                |  110 ++++
 fs/xfs/xfs_mount.h                |    2 
 fs/xfs/xfs_refcount_item.c        |    2 
 fs/xfs/xfs_rmap_item.c            |    2 
 fs/xfs/xfs_super.c                |   17 +
 fs/xfs/xfs_swapext_item.c         |  649 +++++++++++++++++++++++
 fs/xfs/xfs_swapext_item.h         |   61 ++
 fs/xfs/xfs_trace.c                |    1 
 fs/xfs/xfs_trace.h                |  196 +++++++
 fs/xfs/xfs_trans.c                |   14 -
 fs/xfs/xfs_xchgrange.c            |  772 ++++++++++++++++++++++++++++
 fs/xfs/xfs_xchgrange.h            |   30 +
 include/linux/fs.h                |   14 -
 include/uapi/linux/fiexchange.h   |  101 ++++
 45 files changed, 3807 insertions(+), 746 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_swapext.c
 create mode 100644 fs/xfs/libxfs/xfs_swapext.h
 create mode 100644 fs/xfs/xfs_swapext_item.c
 create mode 100644 fs/xfs/xfs_swapext_item.h
 create mode 100644 fs/xfs/xfs_xchgrange.c
 create mode 100644 fs/xfs/xfs_xchgrange.h
 create mode 100644 include/uapi/linux/fiexchange.h

