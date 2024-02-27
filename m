Return-Path: <linux-fsdevel+bounces-12965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BE1869AEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51DA1F266E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 15:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC64314830F;
	Tue, 27 Feb 2024 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvtIVdV/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1A3148307;
	Tue, 27 Feb 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048727; cv=none; b=s1qeXQLY82ipd8hlXicudDC9czWNaUg3Si9Fz2w1C5l0HyEaB9UxpPXZL20hO9mi0W2UcYI7GM4ySIUtk7B5oUJH+L/IidZd67cF/N4Rb+pmx8OaJnjeTpe9SgVzJ90CCQS79ZwOWfPidSBuoA5PIbxp2uEsBH3FnZt1nkTST1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048727; c=relaxed/simple;
	bh=s905O6yDwMtfS//kZ7A5P33D1/Cz4yCWrKueUv6+4Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLVlZ1YAv/RWKBob5d54vqDTDoaJx5PfmL27mFHryZiy9yT3Ke2C2T3+x5vSjjeASvlTmiz2WONH/+zhHqnc5tYORBaCpBwXE3zcgBe3hZ+M7V+Ai/S8nhFtHF3NoHqWpZJlyoevrKJCRQlh0dTfrWQQJOuMwErwKoP6U4CpN4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvtIVdV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566D8C433C7;
	Tue, 27 Feb 2024 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709048726;
	bh=s905O6yDwMtfS//kZ7A5P33D1/Cz4yCWrKueUv6+4Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nvtIVdV/TG4matq2IZvHq0tulM94nRk/vFtut7W5aw2XAKNa6dkJY2Hmvywa66Izo
	 VYqgzCA4O7tmrAaO/GfzMAUDJKvs27R+b3wBO1UWY+J/GiMcXOY3qUJWSpWc/NRA74
	 ewvik/stdQQ6i97Z97uBdt0N5jj/vVxdCO1nstpEDfz0SDslYVkGtyZHgg/kEgYYsZ
	 7RID2CNhA9lpV6lV5NqWwO+JUFa5ZJ8JUaa3aPX4dJJglfWMymEtd0AMbBT7v7ID/Q
	 vx3PknvLamUh3niX5brBVCpoJFlxSL7K4P2JD33EKKhgwh80t5tFugKIdgfwtOU6jI
	 1ny+BO2MACCqA==
Date: Tue, 27 Feb 2024 07:45:25 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCHSET v29.4 03/13] xfs: atomic file content exchanges
Message-ID: <20240227154525.GV616564@frogsfrogsfrogs>
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
 <CAOQ4uxh-gKGuwrvuQnWKcKLKQe2j9s__Yx2T-gCrDJMUbm5ZYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh-gKGuwrvuQnWKcKLKQe2j9s__Yx2T-gCrDJMUbm5ZYA@mail.gmail.com>

On Tue, Feb 27, 2024 at 11:23:39AM +0200, Amir Goldstein wrote:
> On Tue, Feb 27, 2024 at 4:18 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > Hi all,
> >
> > This series creates a new FIEXCHANGE_RANGE system call to exchange
> > ranges of bytes between two files atomically.  This new functionality
> > enables data storage programs to stage and commit file updates such that
> > reader programs will see either the old contents or the new contents in
> > their entirety, with no chance of torn writes.  A successful call
> > completion guarantees that the new contents will be seen even if the
> > system fails.
> >
> > The ability to exchange file fork mappings between files in this manner
> > is critical to supporting online filesystem repair, which is built upon
> > the strategy of constructing a clean copy of a damaged structure and
> > committing the new structure into the metadata file atomically.
> >
> > User programs will be able to update files atomically by opening an
> > O_TMPFILE, reflinking the source file to it, making whatever updates
> > they want to make, and exchange the relevant ranges of the temp file
> > with the original file.  If the updates are aligned with the file block
> > size, a new (since v2) flag provides for exchanging only the written
> > areas.  Callers can arrange for the update to be rejected if the
> > original file has been changed.
> >
> > The intent behind this new userspace functionality is to enable atomic
> > rewrites of arbitrary parts of individual files.  For years, application
> > programmers wanting to ensure the atomicity of a file update had to
> > write the changes to a new file in the same directory, fsync the new
> > file, rename the new file on top of the old filename, and then fsync the
> > directory.  People get it wrong all the time, and $fs hacks abound.
> > Here are the proposed manual pages:
> >
> > IOCTL-XFS-EXCHANGE-RANGE(2System Calls ManuIOCTL-XFS-EXCHANGE-RANGE(2)
> >
> > NAME
> >        ioctl_xfs_exchange_range  -  exchange  the contents of parts of
> >        two files
> >
> > SYNOPSIS
> >        #include <sys/ioctl.h>
> >        #include <xfs/xfs_fs_staging.h>
> >
> >        int   ioctl(int   file2_fd,   XFS_IOC_EXCHANGE_RANGE,    struct
> >        xfs_exch_range *arg);
> >
> > DESCRIPTION
> >        Given  a  range  of bytes in a first file file1_fd and a second
> >        range of bytes in a second file  file2_fd,  this  ioctl(2)  ex‐
> >        changes the contents of the two ranges.
> >
> >        Exchanges  are  atomic  with  regards to concurrent file opera‐
> >        tions, so no userspace-level locks need to be taken  to  obtain
> >        consistent  results.  Implementations must guarantee that read‐
> >        ers see either the old contents or the new  contents  in  their
> >        entirety, even if the system fails.
> >
> >        The  system  call  parameters are conveyed in structures of the
> >        following form:
> >
> >            struct xfs_exch_range {
> >                __s64    file1_fd;
> >                __s64    file1_offset;
> >                __s64    file2_offset;
> >                __s64    length;
> >                __u64    flags;
> >
> >                __u64    pad;
> >            };
> >
> >        The field pad must be zero.
> >
> >        The fields file1_fd, file1_offset, and length define the  first
> >        range of bytes to be exchanged.
> >
> >        The fields file2_fd, file2_offset, and length define the second
> >        range of bytes to be exchanged.
> >
> >        Both files must be from the same filesystem mount.  If the  two
> >        file  descriptors represent the same file, the byte ranges must
> >        not overlap.  Most  disk-based  filesystems  require  that  the
> >        starts  of  both ranges must be aligned to the file block size.
> >        If this is the case, the ends of the ranges  must  also  be  so
> >        aligned unless the XFS_EXCHRANGE_TO_EOF flag is set.
> >
> >        The field flags control the behavior of the exchange operation.
> >
> >            XFS_EXCHRANGE_TO_EOF
> >                   Ignore  the length parameter.  All bytes in file1_fd
> >                   from file1_offset to EOF are moved to file2_fd,  and
> >                   file2's  size is set to (file2_offset+(file1_length-
> >                   file1_offset)).  Meanwhile, all bytes in file2  from
> >                   file2_offset  to  EOF are moved to file1 and file1's
> >                   size   is   set   to    (file1_offset+(file2_length-
> >                   file2_offset)).
> >
> >            XFS_EXCHRANGE_DSYNC
> >                   Ensure  that  all modified in-core data in both file
> >                   ranges and all metadata updates  pertaining  to  the
> >                   exchange operation are flushed to persistent storage
> >                   before the call returns.  Opening  either  file  de‐
> >                   scriptor  with  O_SYNC or O_DSYNC will have the same
> >                   effect.
> >
> >            XFS_EXCHRANGE_FILE1_WRITTEN
> >                   Only exchange sub-ranges of file1_fd that are  known
> >                   to  contain  data  written  by application software.
> >                   Each sub-range may be  expanded  (both  upwards  and
> >                   downwards)  to  align with the file allocation unit.
> >                   For files on the data device, this is one filesystem
> >                   block.   For  files  on the realtime device, this is
> >                   the realtime extent size.  This facility can be used
> >                   to  implement  fast  atomic scatter-gather writes of
> >                   any complexity for software-defined storage  targets
> >                   if  all  writes  are  aligned to the file allocation
> >                   unit.
> >
> >            XFS_EXCHRANGE_DRY_RUN
> >                   Check the parameters and the feasibility of the  op‐
> >                   eration, but do not change anything.
> >
> > RETURN VALUE
> >        On  error, -1 is returned, and errno is set to indicate the er‐
> >        ror.
> >
> > ERRORS
> >        Error codes can be one of, but are not limited to, the  follow‐
> >        ing:
> >
> >        EBADF  file1_fd  is not open for reading and writing or is open
> >               for append-only writes; or  file2_fd  is  not  open  for
> >               reading and writing or is open for append-only writes.
> >
> >        EINVAL The  parameters  are  not correct for these files.  This
> >               error can also appear if either file  descriptor  repre‐
> >               sents  a device, FIFO, or socket.  Disk filesystems gen‐
> >               erally require the offset and  length  arguments  to  be
> >               aligned to the fundamental block sizes of both files.
> >
> >        EIO    An I/O error occurred.
> >
> >        EISDIR One of the files is a directory.
> >
> >        ENOMEM The  kernel  was unable to allocate sufficient memory to
> >               perform the operation.
> >
> >        ENOSPC There is not enough free space  in  the  filesystem  ex‐
> >               change the contents safely.
> >
> >        EOPNOTSUPP
> >               The filesystem does not support exchanging bytes between
> >               the two files.
> >
> >        EPERM  file1_fd or file2_fd are immutable.
> >
> >        ETXTBSY
> >               One of the files is a swap file.
> >
> >        EUCLEAN
> >               The filesystem is corrupt.
> >
> >        EXDEV  file1_fd and  file2_fd  are  not  on  the  same  mounted
> >               filesystem.
> >
> > CONFORMING TO
> >        This API is XFS-specific.
> >
> > USE CASES
> >        Several  use  cases  are imagined for this system call.  In all
> >        cases, application software must coordinate updates to the file
> >        because the exchange is performed unconditionally.
> >
> >        The  first  is a data storage program that wants to commit non-
> >        contiguous updates to a file atomically and  coordinates  write
> >        access  to that file.  This can be done by creating a temporary
> >        file, calling FICLONE(2) to share the contents, and staging the
> >        updates into the temporary file.  The FULL_FILES flag is recom‐
> >        mended for this purpose.  The temporary file can be deleted  or
> >        punched out afterwards.
> >
> >        An example program might look like this:
> >
> >            int fd = open("/some/file", O_RDWR);
> >            int temp_fd = open("/some", O_TMPFILE | O_RDWR);
> >
> >            ioctl(temp_fd, FICLONE, fd);
> >
> >            /* append 1MB of records */
> >            lseek(temp_fd, 0, SEEK_END);
> >            write(temp_fd, data1, 1000000);
> >
> >            /* update record index */
> >            pwrite(temp_fd, data1, 600, 98765);
> >            pwrite(temp_fd, data2, 320, 54321);
> >            pwrite(temp_fd, data2, 15, 0);
> >
> >            /* commit the entire update */
> >            struct xfs_exch_range args = {
> >                .file1_fd = temp_fd,
> >                .flags = XFS_EXCHRANGE_TO_EOF,
> >            };
> >
> >            ioctl(fd, XFS_IOC_EXCHANGE_RANGE, &args);
> >
> >        The  second  is  a  software-defined  storage host (e.g. a disk
> >        jukebox) which implements an atomic scatter-gather  write  com‐
> >        mand.   Provided the exported disk's logical block size matches
> >        the file's allocation unit size, this can be done by creating a
> >        temporary file and writing the data at the appropriate offsets.
> >        It is recommended that the temporary file be truncated  to  the
> >        size  of  the  regular file before any writes are staged to the
> >        temporary file to avoid issues with zeroing during  EOF  exten‐
> >        sion.   Use  this  call with the FILE1_WRITTEN flag to exchange
> >        only the file allocation units involved  in  the  emulated  de‐
> >        vice's  write  command.  The temporary file should be truncated
> >        or punched out completely before being reused to stage  another
> >        write.
> >
> >        An example program might look like this:
> >
> >            int fd = open("/some/file", O_RDWR);
> >            int temp_fd = open("/some", O_TMPFILE | O_RDWR);
> >            struct stat sb;
> >            int blksz;
> >
> >            fstat(fd, &sb);
> >            blksz = sb.st_blksize;
> >
> >            /* land scatter gather writes between 100fsb and 500fsb */
> >            pwrite(temp_fd, data1, blksz * 2, blksz * 100);
> >            pwrite(temp_fd, data2, blksz * 20, blksz * 480);
> >            pwrite(temp_fd, data3, blksz * 7, blksz * 257);
> >
> >            /* commit the entire update */
> >            struct xfs_exch_range args = {
> >                .file1_fd = temp_fd,
> >                .file1_offset = blksz * 100,
> >                .file2_offset = blksz * 100,
> >                .length       = blksz * 400,
> >                .flags        = XFS_EXCHRANGE_FILE1_WRITTEN |
> >                                XFS_EXCHRANGE_FILE1_DSYNC,
> >            };
> >
> >            ioctl(fd, XFS_IOC_EXCHANGE_RANGE, &args);
> >
> > NOTES
> >        Some  filesystems may limit the amount of data or the number of
> >        extents that can be exchanged in a single call.
> >
> > SEE ALSO
> >        ioctl(2)
> >
> > XFS                           2024-02-10   IOCTL-XFS-EXCHANGE-RANGE(2)
> > IOCTL-XFS-COMMIT-RANGE(2) System Calls ManualIOCTL-XFS-COMMIT-RANGE(2)
> >
> > NAME
> >        ioctl_xfs_commit_range - conditionally exchange the contents of
> >        parts of two files
> >
> > SYNOPSIS
> >        #include <sys/ioctl.h>
> >        #include <xfs/xfs_fs_staging.h>
> >
> >        int ioctl(int file2_fd, XFS_IOC_COMMIT_RANGE,  struct  xfs_com‐
> >        mit_range *arg);
> >
> > DESCRIPTION
> >        Given  a  range  of bytes in a first file file1_fd and a second
> >        range of bytes in a second file  file2_fd,  this  ioctl(2)  ex‐
> >        changes  the contents of the two ranges if file2_fd passes cer‐
> >        tain freshness criteria.
> >
> >        After locking both files but before  exchanging  the  contents,
> >        the  supplied  file2_ino field must match file2_fd's inode num‐
> >        ber,   and   the   supplied   file2_mtime,    file2_mtime_nsec,
> >        file2_ctime, and file2_ctime_nsec fields must match the modifi‐
> >        cation time and change time of file2.  If they  do  not  match,
> >        EBUSY will be returned.
> >
> 
> Maybe a stupid question, but under which circumstances would mtime
> change and ctime not change? Why are both needed?

It's the other way 'round -- mtime doesn't change but ctime does.  The
race I'm trying to protect against is:

Thread 0			Thread 1
<snapshot fd cmtime>
<start writing tempfd>
				<fstat fd>
				<write to fd>
				<futimens to reset mtime>
<commitrange>

mtime is controllable by "attackers" but ctime isn't.  I think we only
need to capture ctime, but ye olde swapext ioctl (from which this
derives) did both.

> And for a new API, wouldn't it be better to use change_cookie (a.k.a i_version)?

Seeing as iversion (as the vfs and/or jlayton seems to want it) doesn't
work in the intended manner in XFS, no.

> Even if this API is designed to be hoisted out of XFS at some future time,
> Is there a real need to support it on filesystems that do not support
> i_version(?)

Given the way the iversion discussions have gone (file data write
counter) I don't think there's a way to support commitrange on
non-iversion filesystems.

I withdrew any plans to make this more than an XFS-specific ioctl last
year after giving up on ever getting through fsdevel review.  I think
the last reply I got was from viro back in 2021...

> Not to mention the fact that POSIX does not explicitly define how ctime should
> behave with changes to fiemap (uninitialized extent and all), so who knows
> how other filesystems may update ctime in those cases.

...and given the lack of interest from any other filesystem developers
in porting it to !xfs, I'm not likely to take this up ever again.  To be
fair, I think the only filesystems that could possibly support
EXCHANGE_RANGE are /maybe/ btrfs and /probably/ bcachefs.

> I realize that STATX_CHANGE_COOKIE is currently kernel internal, but
> it seems that XFS_IOC_EXCHANGE_RANGE is a case where userspace
> really explicitly requests a bump of i_version on the next change.

Another way I could've structured this (and still could!) would be to
declare the entire freshness region as an untyped u64 fresh[4] blob and
add a START_COMMIT ioctl to fill it out.  Then the kernel fs drivers
gets to determine what goes in there.

That at least would be less work for userspace to do.

I don't want userspace API wrangling to hold up online repair **yet
again**.  I only made EXCHANGE_RANGE so that I could test the functionality
that fsck relies on.  If there was another way to test it then I would
have gladly done that.  Further down the line, COMMIT_RANGE will get us
out of trouble with the xfs defrag tool.

--D

> Thanks,
> Amir.
> 

