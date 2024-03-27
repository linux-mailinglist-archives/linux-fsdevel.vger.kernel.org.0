Return-Path: <linux-fsdevel+bounces-15371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D966488D3D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 02:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083ED1C23C82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 01:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B167D1CFA9;
	Wed, 27 Mar 2024 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2ziZiY6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA23FD4;
	Wed, 27 Mar 2024 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711504042; cv=none; b=go0Ypeytjk8Hq/0/q9JaB5N8sn0id7QDo8cEjypOBxjv0cLenlHjDrxxIOTFHeVTI64tUVgoHOeoyYZyS75LSqAkECKNm2bCZoFG9WZBTY4VjVJRsK0bGB1R1qDqltDjid+76JoDqzrXXxvAV9nbF4furruRR9uaWpdvU0zYikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711504042; c=relaxed/simple;
	bh=9rXP2Olv+gSoD3SN2DWXwnChSPMtm6XbABFMurtfH3A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZUazP8NFt5e+5QEzs4vIn3QA0siw79Yuiq2WZwc1vxOgqLg2UVdoHyq7xOhb6psGnsYQZyjXj3bp6rfI/ULm0sDkOkqVEuplpGpDKLt71qp/SW2zKbJ2c22FPW3M6iYj4PqZPv/7XOBubOzOo6uUYU1wZnQqDZtAR+xelanGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2ziZiY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9FAC433F1;
	Wed, 27 Mar 2024 01:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711504041;
	bh=9rXP2Olv+gSoD3SN2DWXwnChSPMtm6XbABFMurtfH3A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=E2ziZiY6fazPKE1KM5eoSA2Kf0OuVKSICFPUigea+/hYLHBd0hzGhHzosa8WR505t
	 3c6EUdgvgqw3EspqavqFcbjVtaGqBuyqhqh4tcjDVCBTFxAXKEN1ID/Z4EHb7+pUCy
	 3pEi8jQR3zXIiY5jIFY0Ylpe9+jXh9NuUXcgh/4DQzp3ZcAwUCzV3W0r38PjdGcTtN
	 X9WDfxZYfoj+DaZoZdEq7fGL1SUd5Cp2VVh6DI8E781HqCxg1SiRR1ZO5lGV9Ev5+W
	 GLCImyNA5GP/hR4RhHdRw+HpeqBBxARY+Rjyxom/rpyG+strUjnLwWr6dROBc/svN8
	 Nj6DrPdhTMyPA==
Date: Tue, 26 Mar 2024 18:47:21 -0700
Subject: [PATCHSET v30.1 04/15] xfs: atomic file content exchanges
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, hch@lst.de,
 linux-xfs@vger.kernel.org
Message-ID: <171150380628.3216674.10385855831925961243.stgit@frogsfrogsfrogs>
In-Reply-To: <20240327014040.GU6390@frogsfrogsfrogs>
References: <20240327014040.GU6390@frogsfrogsfrogs>
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

This series creates a new XFS_IOC_EXCHANGE_RANGE ioctl to exchange
ranges of bytes between two files atomically, and later adds
XFS_IOC_START_COMMIT and XFS_IOC_COMMIT_RANGE ioctls to perform the
exchange only if the target file has not been changed since a given
sampling point.

This new functionality enables data storage programs to stage and commit
file updates such that reader programs will see either the old contents
or the new contents in their entirety, with no chance of torn writes.  A
successful call completion guarantees that the new contents will be seen
even if the system fails.

The ability to exchange file fork mappings between files in this manner
is critical to supporting online filesystem repair, which is built upon
the strategy of constructing a clean copy of a damaged structure and
committing the new structure into the metadata file atomically.  The
ioctls exist to facilitate testing of the new functionality and to
enable future application program designs.

User programs will be able to update files atomically by opening an
O_TMPFILE, reflinking the source file to it, making whatever updates
they want to make, and exchange the relevant ranges of the temp file
with the original file.  If the updates are aligned with the file block
size, a new (since v2) flag provides for exchanging only the written
areas.

This mechanism solves the clunkiness of two existing atomic file update
mechanisms: for O_TRUNC + rewrite, this eliminates the brief period
where other programs can see an empty file.  For create tempfile +
rename, the need to copy file attributes and extended attributes for
each file update is eliminated.

However, this method introduces its own awkwardness -- any program
initiating an exchange now needs to have a way to signal to other
programs that the file contents have changed.  For file access mediated
via read and write, fanotify or inotify are probably sufficient.  For
mmaped files, that may not be fast enough.

Here are the proposed manual pages:

IOCTL-XFS-EXCHANGE-RANGE(2System Calls ManuIOCTL-XFS-EXCHANGE-RANGE(2)

NAME
       ioctl_xfs_exchange_range  -  exchange  the contents of parts of
       two files

SYNOPSIS
       #include <sys/ioctl.h>
       #include <xfs/xfs_fs_staging.h>

       int ioctl(int file2_fd, XFS_IOC_EXCHANGE_RANGE, struct  xfs_ex‐
       change_range *arg);

DESCRIPTION
       Given  a  range  of bytes in a first file file1_fd and a second
       range of bytes in a second file  file2_fd,  this  ioctl(2)  ex‐
       changes the contents of the two ranges.

       Exchanges  are  atomic  with  regards to concurrent file opera‐
       tions.  Implementations must guarantee that readers see  either
       the old contents or the new contents in their entirety, even if
       the system fails.

       The system call parameters are conveyed in  structures  of  the
       following form:

           struct xfs_exchange_range {
               __s32    file1_fd;
               __u32    pad;
               __u64    file1_offset;
               __u64    file2_offset;
               __u64    length;
               __u64    flags;
           };

       The field pad must be zero.

       The  fields file1_fd, file1_offset, and length define the first
       range of bytes to be exchanged.

       The fields file2_fd, file2_offset, and length define the second
       range of bytes to be exchanged.

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

       EINVAL The parameters are not correct for  these  files.   This
              error  can  also appear if either file descriptor repre‐
              sents a device, FIFO, or socket.  Disk filesystems  gen‐
              erally  require  the  offset  and length arguments to be
              aligned to the fundamental block sizes of both files.

       EIO    An I/O error occurred.

       EISDIR One of the files is a directory.

       ENOMEM The kernel was unable to allocate sufficient  memory  to
              perform the operation.

       ENOSPC There  is  not  enough  free space in the filesystem ex‐
              change the contents safely.

       EOPNOTSUPP
              The filesystem does not support exchanging bytes between
              the two files.

       EPERM  file1_fd or file2_fd are immutable.

       ETXTBSY
              One of the files is a swap file.

       EUCLEAN
              The filesystem is corrupt.

       EXDEV  file1_fd  and  file2_fd  are  not  on  the  same mounted
              filesystem.

CONFORMING TO
       This API is XFS-specific.

USE CASES
       Several use cases are imagined for this system  call.   In  all
       cases, application software must coordinate updates to the file
       because the exchange is performed unconditionally.

       The first is a data storage program that wants to  commit  non-
       contiguous  updates  to a file atomically and coordinates write
       access to that file.  This can be done by creating a  temporary
       file, calling FICLONE(2) to share the contents, and staging the
       updates into the temporary file.  The FULL_FILES flag is recom‐
       mended  for this purpose.  The temporary file can be deleted or
       punched out afterwards.

       An example program might look like this:

           int fd = open("/some/file", O_RDWR);
           int temp_fd = open("/some", O_TMPFILE | O_RDWR);

           ioctl(temp_fd, FICLONE, fd);

           /* append 1MB of records */
           lseek(temp_fd, 0, SEEK_END);
           write(temp_fd, data1, 1000000);

           /* update record index */
           pwrite(temp_fd, data1, 600, 98765);
           pwrite(temp_fd, data2, 320, 54321);
           pwrite(temp_fd, data2, 15, 0);

           /* commit the entire update */
           struct xfs_exchange_range args = {
               .file1_fd = temp_fd,
               .flags = XFS_EXCHANGE_RANGE_TO_EOF,
           };

           ioctl(fd, XFS_IOC_EXCHANGE_RANGE, &args);

       The second is a software-defined  storage  host  (e.g.  a  disk
       jukebox)  which  implements an atomic scatter-gather write com‐
       mand.  Provided the exported disk's logical block size  matches
       the file's allocation unit size, this can be done by creating a
       temporary file and writing the data at the appropriate offsets.
       It  is  recommended that the temporary file be truncated to the
       size of the regular file before any writes are  staged  to  the
       temporary  file  to avoid issues with zeroing during EOF exten‐
       sion.  Use this call with the FILE1_WRITTEN  flag  to  exchange
       only  the  file  allocation  units involved in the emulated de‐
       vice's write command.  The temporary file should  be  truncated
       or  punched out completely before being reused to stage another
       write.

       An example program might look like this:

           int fd = open("/some/file", O_RDWR);
           int temp_fd = open("/some", O_TMPFILE | O_RDWR);
           struct stat sb;
           int blksz;

           fstat(fd, &sb);
           blksz = sb.st_blksize;

           /* land scatter gather writes between 100fsb and 500fsb */
           pwrite(temp_fd, data1, blksz * 2, blksz * 100);
           pwrite(temp_fd, data2, blksz * 20, blksz * 480);
           pwrite(temp_fd, data3, blksz * 7, blksz * 257);

           /* commit the entire update */
           struct xfs_exchange_range args = {
               .file1_fd = temp_fd,
               .file1_offset = blksz * 100,
               .file2_offset = blksz * 100,
               .length       = blksz * 400,
               .flags        = XFS_EXCHANGE_RANGE_FILE1_WRITTEN |
                               XFS_EXCHANGE_RANGE_FILE1_DSYNC,
           };

           ioctl(fd, XFS_IOC_EXCHANGE_RANGE, &args);

NOTES
       Some filesystems may limit the amount of data or the number  of
       extents that can be exchanged in a single call.

SEE ALSO
       ioctl(2)

XFS                           2024-02-10   IOCTL-XFS-EXCHANGE-RANGE(2)
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

The reference implementation in XFS creates a new log incompat feature
and log intent items to track high level progress of swapping ranges of
two files and finish interrupted work if the system goes down.  Sample
code can be found in the corresponding changes to xfs_io to exercise the
use case mentioned above.

Note that this function is /not/ the O_DIRECT atomic untorn file writes
concept that has also been floating around for years.  It is also not
the RWF_ATOMIC patchset that has been shared.  This RFC is constructed
entirely in software, which means that there are no limitations other
than the general filesystem limits.

As a side note, the original motivation behind the kernel functionality
is online repair of file-based metadata.  The atomic file content
exchange is implemented as an atomic exchange of file fork mappings,
which means that we can implement online reconstruction of extended
attributes and directories by building a new one in another inode and
exchanging the contents.

Subsequent patchsets adapt the online filesystem repair code to use
atomic file exchanges.  This enables repair functions to construct a
clean copy of a directory, xattr information, symbolic links, realtime
bitmaps, and realtime summary information in a temporary inode.  If this
completes successfully, the new contents can be committed atomically
into the inode being repaired.  This is essential to avoid making
corruption problems worse if the system goes down in the middle of
running repair.

For userspace, this series also includes the userspace pieces needed to
test the new functionality, and a sample implementation of atomic file
updates.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
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
Commits in this patchset:
 * vfs: export remap and write check helpers
 * xfs: introduce new file range exchange ioctl
 * xfs: create a log incompat flag for atomic file mapping exchanges
 * xfs: introduce a file mapping exchange log intent item
 * xfs: create deferred log items for file mapping exchanges
 * xfs: bind together the front and back ends of the file range exchange code
 * xfs: add error injection to test file mapping exchange recovery
 * xfs: condense extended attributes after a mapping exchange operation
 * xfs: condense directories after a mapping exchange operation
 * xfs: condense symbolic links after a mapping exchange operation
 * xfs: make file range exchange support realtime files
 * xfs: support non-power-of-two rtextsize with exchange-range
 * docs: update swapext -> exchmaps language
 * xfs: introduce new file range commit ioctls
 * xfs: enable logged file mapping exchange feature
---
 .../filesystems/xfs/xfs-online-fsck-design.rst     |  259 ++--
 fs/read_write.c                                    |    1 
 fs/remap_range.c                                   |    4 
 fs/xfs/Makefile                                    |    3 
 fs/xfs/libxfs/xfs_defer.c                          |    6 
 fs/xfs/libxfs/xfs_defer.h                          |    2 
 fs/xfs/libxfs/xfs_errortag.h                       |    4 
 fs/xfs/libxfs/xfs_exchmaps.c                       | 1237 ++++++++++++++++++++
 fs/xfs/libxfs/xfs_exchmaps.h                       |  123 ++
 fs/xfs/libxfs/xfs_format.h                         |   16 
 fs/xfs/libxfs/xfs_fs.h                             |   70 +
 fs/xfs/libxfs/xfs_log_format.h                     |   64 +
 fs/xfs/libxfs/xfs_log_recover.h                    |    2 
 fs/xfs/libxfs/xfs_sb.c                             |    3 
 fs/xfs/libxfs/xfs_symlink_remote.c                 |   47 +
 fs/xfs/libxfs/xfs_symlink_remote.h                 |    1 
 fs/xfs/libxfs/xfs_trans_space.h                    |    4 
 fs/xfs/xfs_error.c                                 |    3 
 fs/xfs/xfs_exchmaps_item.c                         |  599 ++++++++++
 fs/xfs/xfs_exchmaps_item.h                         |   64 +
 fs/xfs/xfs_exchrange.c                             |  882 ++++++++++++++
 fs/xfs/xfs_exchrange.h                             |   50 +
 fs/xfs/xfs_ioctl.c                                 |  126 ++
 fs/xfs/xfs_log_recover.c                           |    2 
 fs/xfs/xfs_mount.h                                 |    5 
 fs/xfs/xfs_super.c                                 |   19 
 fs/xfs/xfs_symlink.c                               |   49 -
 fs/xfs/xfs_trace.c                                 |    2 
 fs/xfs/xfs_trace.h                                 |  382 ++++++
 include/linux/fs.h                                 |    1 
 30 files changed, 3855 insertions(+), 175 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_exchmaps.c
 create mode 100644 fs/xfs/libxfs/xfs_exchmaps.h
 create mode 100644 fs/xfs/xfs_exchmaps_item.c
 create mode 100644 fs/xfs/xfs_exchmaps_item.h
 create mode 100644 fs/xfs/xfs_exchrange.c
 create mode 100644 fs/xfs/xfs_exchrange.h


