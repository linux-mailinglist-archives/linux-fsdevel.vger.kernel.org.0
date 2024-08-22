Return-Path: <linux-fsdevel+bounces-26849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3685995C1A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 01:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3062284A8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 23:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB4C187334;
	Thu, 22 Aug 2024 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU8PhVij"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB0F17E006;
	Thu, 22 Aug 2024 23:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371001; cv=none; b=B+SDVileO1FOPmDOkknvP2nzQDa3R3sgG6zgKaraXjFhva7hnYwO+8x00xsTwtyrIuu5dH4qkKD52dopu9I3uxHqgcHXsFlIsXvp0YuCkDoIi2/t5b8Sf0eplHRkYkcSUYiXMh12JxqSdkEv3G05pP1eCfs9OJ7wphkXgrVRcEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371001; c=relaxed/simple;
	bh=rHWfO6nEgYMGFOkwQ+Pc/RcOYwp7qfV7kIugckAj3QM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUpBNQPQStdFz0aMulnbscUFz+WkfpASQglzYjhnVrkkYK4wSop4d6ctq1HzyFubO+RJNDU+hPmuakRgr9N1xaiJFDqmw5gfQzbTvjogXmbc83AvrNZHmadyuP5KdqTqLzo8A6MylKv3/v6PUTzDdBSd91OVEl+YAv7ofj6qrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU8PhVij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3DCC32782;
	Thu, 22 Aug 2024 23:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724371001;
	bh=rHWfO6nEgYMGFOkwQ+Pc/RcOYwp7qfV7kIugckAj3QM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XU8PhVijhoh8LwwlPFLLUnXc/PutEDw4bn9Pg2og7LuqcIHeHhe5ma07RFx2tcx0i
	 9+TCxmVLqJj/dV55EVO5qU+cw8gZiZLn/UBsjThQqwNDlxAx7PvZ9RPfthT/86V/d2
	 oKvPCCMlOPBhgPKm4dibv4kDBydxSDtnwbzyX3+Qcfo/1yYQeraJLeiLba4qnycLOP
	 W5sTTrYgTD3zgGTMyfopxrDrY+ZPSKsNo4EizCBxn3F5FZmXnQHBu4GzdQ4LvkZrPD
	 1KmABt3z9dkKk3QZDFNtoxergGp4BUf70ZIC0bY43pL4ZiCPcxq9lkJEwg8zsgcbQ7
	 cUOzMm39dJiiA==
Date: Thu, 22 Aug 2024 16:56:41 -0700
Subject: [PATCHSET v31.0 02/10] xfs: atomic file content commits
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: hch@lst.de, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <172437084258.57211.13522832162579952916.stgit@frogsfrogsfrogs>
In-Reply-To: <20240822235230.GJ6043@frogsfrogsfrogs>
References: <20240822235230.GJ6043@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi all,

This series creates XFS_IOC_START_COMMIT and XFS_IOC_COMMIT_RANGE ioctls
to perform the exchange only if the target file has not been changed
since a given sampling point.

This new functionality uses the mechanism underlying EXCHANGE_RANGE to
stage and commit file updates such that reader programs will see either
the old contents or the new contents in their entirety, with no chance
of torn writes.  A successful call completion guarantees that the new
contents will be seen even if the system fails.  The pair of ioctls
allows userspace to perform what amounts to a compare and exchange
operation on entire file contents.

Note that there are ongoing arguments in the community about how best to
implement some sort of file data write counter that nfsd could also use
to signal invalidations to clients.  Until such a thing is implemented,
this patch will rely on ctime/mtime updates.

Here are the proposed manual pages:

IOCTL-XFS-COMMIT-RANGE(2) System Calls ManualIOCTL-XFS-COMMIT-RANGE(2)

NAME
       ioctl_xfs_start_commit  -  prepare  to exchange the contents of
       two files ioctl_xfs_commit_range - conditionally  exchange  the
       contents of parts of two files

SYNOPSIS
       #include <sys/ioctl.h>
       #include <xfs/xfs_fs.h>

       int  ioctl(int  file2_fd, XFS_IOC_START_COMMIT, struct xfs_com‐
       mit_range *arg);

       int ioctl(int file2_fd, XFS_IOC_COMMIT_RANGE,  struct  xfs_com‐
       mit_range *arg);

DESCRIPTION
       Given  a  range  of bytes in a first file file1_fd and a second
       range of bytes in a second file  file2_fd,  this  ioctl(2)  ex‐
       changes  the contents of the two ranges if file2_fd passes cer‐
       tain freshness criteria.

       Before exchanging the  contents,  the  program  must  call  the
       XFS_IOC_START_COMMIT   ioctl   to  sample  freshness  data  for
       file2_fd.  If the sampled metadata  does  not  match  the  file
       metadata  at  commit  time,  XFS_IOC_COMMIT_RANGE  will  return
       EBUSY.

       Exchanges are atomic with regards  to  concurrent  file  opera‐
       tions.   Implementations must guarantee that readers see either
       the old contents or the new contents in their entirety, even if
       the system fails.

       The  system  call  parameters are conveyed in structures of the
       following form:

           struct xfs_commit_range {
               __s32    file1_fd;
               __u32    pad;
               __u64    file1_offset;
               __u64    file2_offset;
               __u64    length;
               __u64    flags;
               __u64    file2_freshness[5];
           };

       The field pad must be zero.

       The fields file1_fd, file1_offset, and length define the  first
       range of bytes to be exchanged.

       The fields file2_fd, file2_offset, and length define the second
       range of bytes to be exchanged.

       The field file2_freshness is an opaque field whose contents are
       determined  by  the  kernel.  These file attributes are used to
       confirm that file2_fd has not changed by another  thread  since
       the current thread began staging its own update.

       Both  files must be from the same filesystem mount.  If the two
       file descriptors represent the same file, the byte ranges  must
       not  overlap.   Most  disk-based  filesystems  require that the
       starts of both ranges must be aligned to the file  block  size.
       If  this  is  the  case, the ends of the ranges must also be so
       aligned unless the XFS_EXCHANGE_RANGE_TO_EOF flag is set.

       The field flags control the behavior of the exchange operation.

           XFS_EXCHANGE_RANGE_TO_EOF
                  Ignore the length parameter.  All bytes in  file1_fd
                  from  file1_offset to EOF are moved to file2_fd, and
                  file2's size is set to  (file2_offset+(file1_length-
                  file1_offset)).   Meanwhile, all bytes in file2 from
                  file2_offset to EOF are moved to file1  and  file1's
                  size    is   set   to   (file1_offset+(file2_length-
                  file2_offset)).

           XFS_EXCHANGE_RANGE_DSYNC
                  Ensure that all modified in-core data in  both  file
                  ranges  and  all  metadata updates pertaining to the
                  exchange operation are flushed to persistent storage
                  before  the  call  returns.  Opening either file de‐
                  scriptor with O_SYNC or O_DSYNC will have  the  same
                  effect.

           XFS_EXCHANGE_RANGE_FILE1_WRITTEN
                  Only  exchange sub-ranges of file1_fd that are known
                  to contain data  written  by  application  software.
                  Each  sub-range  may  be  expanded (both upwards and
                  downwards) to align with the file  allocation  unit.
                  For files on the data device, this is one filesystem
                  block.  For files on the realtime  device,  this  is
                  the realtime extent size.  This facility can be used
                  to implement fast atomic  scatter-gather  writes  of
                  any  complexity for software-defined storage targets
                  if all writes are aligned  to  the  file  allocation
                  unit.

           XFS_EXCHANGE_RANGE_DRY_RUN
                  Check  the parameters and the feasibility of the op‐
                  eration, but do not change anything.

RETURN VALUE
       On error, -1 is returned, and errno is set to indicate the  er‐
       ror.

ERRORS
       Error  codes can be one of, but are not limited to, the follow‐
       ing:

       EBADF  file1_fd is not open for reading and writing or is  open
              for  append-only  writes;  or  file2_fd  is not open for
              reading and writing or is open for append-only writes.

       EBUSY  The file2 inode number and timestamps  supplied  do  not
              match file2_fd.

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
       This API is XFS-specific.

USE CASES
       Several use cases are imagined for this system call.  Coordina‐
       tion between multiple threads is performed by the kernel.

       The first is a filesystem defragmenter, which copies  the  con‐
       tents  of  a  file into another file and wishes to exchange the
       space mappings of the two files,  provided  that  the  original
       file has not changed.

       An example program might look like this:

           int fd = open("/some/file", O_RDWR);
           int temp_fd = open("/some", O_TMPFILE | O_RDWR);
           struct stat sb;
           struct xfs_commit_range args = {
               .flags = XFS_EXCHANGE_RANGE_TO_EOF,
           };

           /* gather file2's freshness information */
           ioctl(fd, XFS_IOC_START_COMMIT, &args);
           fstat(fd, &sb);

           /* make a fresh copy of the file with terrible alignment to avoid reflink */
           clone_file_range(fd, NULL, temp_fd, NULL, 1, 0);
           clone_file_range(fd, NULL, temp_fd, NULL, sb.st_size - 1, 0);

           /* commit the entire update */
           args.file1_fd = temp_fd;
           ret = ioctl(fd, XFS_IOC_COMMIT_RANGE, &args);
           if (ret && errno == EBUSY)
               printf("file changed while defrag was underway
");

       The  second is a data storage program that wants to commit non-
       contiguous updates to a file atomically.  This  program  cannot
       coordinate updates to the file and therefore relies on the ker‐
       nel to reject the COMMIT_RANGE command if the file has been up‐
       dated  by  someone else.  This can be done by creating a tempo‐
       rary file, calling FICLONE(2) to share the contents, and  stag‐
       ing  the  updates into the temporary file.  The FULL_FILES flag
       is recommended for this purpose.  The  temporary  file  can  be
       deleted or punched out afterwards.

       An example program might look like this:

           int fd = open("/some/file", O_RDWR);
           int temp_fd = open("/some", O_TMPFILE | O_RDWR);
           struct xfs_commit_range args = {
               .flags = XFS_EXCHANGE_RANGE_TO_EOF,
           };

           /* gather file2's freshness information */
           ioctl(fd, XFS_IOC_START_COMMIT, &args);

           ioctl(temp_fd, FICLONE, fd);

           /* append 1MB of records */
           lseek(temp_fd, 0, SEEK_END);
           write(temp_fd, data1, 1000000);

           /* update record index */
           pwrite(temp_fd, data1, 600, 98765);
           pwrite(temp_fd, data2, 320, 54321);
           pwrite(temp_fd, data2, 15, 0);

           /* commit the entire update */
           args.file1_fd = temp_fd;
           ret = ioctl(fd, XFS_IOC_COMMIT_RANGE, &args);
           if (ret && errno == EBUSY)
               printf("file changed before commit; will roll back
");

NOTES
       Some  filesystems may limit the amount of data or the number of
       extents that can be exchanged in a single call.

SEE ALSO
       ioctl(2)

XFS                           2024-02-18     IOCTL-XFS-COMMIT-RANGE(2)

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=atomic-file-commits

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=atomic-file-commits

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=atomic-file-commits
---
Commits in this patchset:
 * xfs: introduce new file range commit ioctls
---
 fs/xfs/libxfs/xfs_fs.h |   26 +++++++++
 fs/xfs/xfs_exchrange.c |  143 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_exchrange.h |   16 +++++
 fs/xfs/xfs_ioctl.c     |    4 +
 fs/xfs/xfs_trace.h     |   57 +++++++++++++++++++
 5 files changed, 243 insertions(+), 3 deletions(-)


