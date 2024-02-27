Return-Path: <linux-fsdevel+bounces-12973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387E6869B95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6BF289B21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993D01474C9;
	Tue, 27 Feb 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYVIhTdu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52C14690D;
	Tue, 27 Feb 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050020; cv=none; b=VdpxZsgoLdv6aQ6Jd1jYrcTXR8tk5FiCGu+1Lz8Ro5fud1/0abW7AB3NhAecVNnx6vtjRMAHWLaVLwaZPYxsL/YV+ytgPHteOnTh8FbezxCWEW7T3MlH4e9RU87+0NT1debD29A5gXNShs1D7l/5x2YYpfRk/4p8jdDL7LHZQpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050020; c=relaxed/simple;
	bh=QUGf92Bq/XJnLyHnVoX0OTap8dq5F5Twz3DaC49LQAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4APUuOxbnZJyU94cM6yvzGnKE+18PqkbvcxABP6K8E+UEiizeaxQT+ac8Cb12RCG4GvUosfr8m6Hz1Lb+vVMqpQbjW/AH1u2dhTrVez9+vq2+D+/acfRXRkxF/hbLZYrsye7QCs4akiqKF9iYVDAP0gVbe5F4Uzx5uwrVD6EkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYVIhTdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D5DC433F1;
	Tue, 27 Feb 2024 16:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709050019;
	bh=QUGf92Bq/XJnLyHnVoX0OTap8dq5F5Twz3DaC49LQAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYVIhTdurYr6wFmEjN8kAsPPmQT5YhRCcCxDBeDxi+ip7NEkMHf1UjlgFuTfKuKPE
	 yNQkZ5OmQpGAChYxFUlAOV095BQbf175b9NBK7CjDsNX5ZZF6Zxx/AkUqmH9g0MCVi
	 eV350ll1hv02i9F3gDAyYhQ1hxCxFyo2JmNQu64NP+YJbb1UxEihcT1dNMMlz1ifMi
	 2m9FEU8GW508ICiIQU+/l84hU+fwwr7DSi1BeQa+uv4IM0ATM7BqDyw7XG7GqgdaYx
	 xHn4rMKUZpGYrVHssqP92vr9S75D9w6Of9Se+Wo2xBkgMFVxHvsywhINIZD4wyNbe3
	 Ti0Zxk/y4R+SQ==
Date: Tue, 27 Feb 2024 08:06:58 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, hch@lst.de
Subject: Re: [PATCHSET v29.4 03/13] xfs: atomic file content exchanges
Message-ID: <20240227160658.GW616564@frogsfrogsfrogs>
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
 <CAOQ4uxh-gKGuwrvuQnWKcKLKQe2j9s__Yx2T-gCrDJMUbm5ZYA@mail.gmail.com>
 <4e29a0395b3963e6a48f916baaf16394acd017ca.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e29a0395b3963e6a48f916baaf16394acd017ca.camel@kernel.org>

On Tue, Feb 27, 2024 at 05:53:46AM -0500, Jeff Layton wrote:
> On Tue, 2024-02-27 at 11:23 +0200, Amir Goldstein wrote:
> > On Tue, Feb 27, 2024 at 4:18 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > 
> > > Hi all,
> > > 
> > > This series creates a new FIEXCHANGE_RANGE system call to exchange
> > > ranges of bytes between two files atomically.  This new functionality
> > > enables data storage programs to stage and commit file updates such that
> > > reader programs will see either the old contents or the new contents in
> > > their entirety, with no chance of torn writes.  A successful call
> > > completion guarantees that the new contents will be seen even if the
> > > system fails.
> > > 
> > > The ability to exchange file fork mappings between files in this manner
> > > is critical to supporting online filesystem repair, which is built upon
> > > the strategy of constructing a clean copy of a damaged structure and
> > > committing the new structure into the metadata file atomically.
> > > 
> > > User programs will be able to update files atomically by opening an
> > > O_TMPFILE, reflinking the source file to it, making whatever updates
> > > they want to make, and exchange the relevant ranges of the temp file
> > > with the original file.  If the updates are aligned with the file block
> > > size, a new (since v2) flag provides for exchanging only the written
> > > areas.  Callers can arrange for the update to be rejected if the
> > > original file has been changed.
> > > 
> > > The intent behind this new userspace functionality is to enable atomic
> > > rewrites of arbitrary parts of individual files.  For years, application
> > > programmers wanting to ensure the atomicity of a file update had to
> > > write the changes to a new file in the same directory, fsync the new
> > > file, rename the new file on top of the old filename, and then fsync the
> > > directory.  People get it wrong all the time, and $fs hacks abound.
> > > Here are the proposed manual pages:
> > > 
> 
> This is a cool idea!  I've had some handwavy ideas about making a gated
> write() syscall (i.e. only write if the change cookie hasn't changed),
> but something like this may be a simpler lift initially.

How /does/ userspace get at the change cookie nowadays?

> > > IOCTL-XFS-EXCHANGE-RANGE(2System Calls ManuIOCTL-XFS-EXCHANGE-RANGE(2)
> > > 
> > > NAME
> > >        ioctl_xfs_exchange_range  -  exchange  the contents of parts of
> > >        two files
> > > 
> > > SYNOPSIS
> > >        #include <sys/ioctl.h>
> > >        #include <xfs/xfs_fs_staging.h>
> > > 
> > >        int   ioctl(int   file2_fd,   XFS_IOC_EXCHANGE_RANGE,    struct
> > >        xfs_exch_range *arg);
> > > 
> > > DESCRIPTION
> > >        Given  a  range  of bytes in a first file file1_fd and a second
> > >        range of bytes in a second file  file2_fd,  this  ioctl(2)  ex‐
> > >        changes the contents of the two ranges.
> > > 
> > >        Exchanges  are  atomic  with  regards to concurrent file opera‐
> > >        tions, so no userspace-level locks need to be taken  to  obtain
> > >        consistent  results.  Implementations must guarantee that read‐
> > >        ers see either the old contents or the new  contents  in  their
> > >        entirety, even if the system fails.
> > > 
> > >        The  system  call  parameters are conveyed in structures of the
> > >        following form:
> > > 
> > >            struct xfs_exch_range {
> > >                __s64    file1_fd;
> > >                __s64    file1_offset;
> > >                __s64    file2_offset;
> > >                __s64    length;
> > >                __u64    flags;
> > > 
> > >                __u64    pad;
> > >            };
> > > 
> > >        The field pad must be zero.
> > > 
> > >        The fields file1_fd, file1_offset, and length define the  first
> > >        range of bytes to be exchanged.
> > > 
> > >        The fields file2_fd, file2_offset, and length define the second
> > >        range of bytes to be exchanged.
> > > 
> > >        Both files must be from the same filesystem mount.  If the  two
> > >        file  descriptors represent the same file, the byte ranges must
> > >        not overlap.  Most  disk-based  filesystems  require  that  the
> > >        starts  of  both ranges must be aligned to the file block size.
> > >        If this is the case, the ends of the ranges  must  also  be  so
> > >        aligned unless the XFS_EXCHRANGE_TO_EOF flag is set.
> > > 
> > >        The field flags control the behavior of the exchange operation.
> > > 
> > >            XFS_EXCHRANGE_TO_EOF
> > >                   Ignore  the length parameter.  All bytes in file1_fd
> > >                   from file1_offset to EOF are moved to file2_fd,  and
> > >                   file2's  size is set to (file2_offset+(file1_length-
> > >                   file1_offset)).  Meanwhile, all bytes in file2  from
> > >                   file2_offset  to  EOF are moved to file1 and file1's
> > >                   size   is   set   to    (file1_offset+(file2_length-
> > >                   file2_offset)).
> > > 
> > >            XFS_EXCHRANGE_DSYNC
> > >                   Ensure  that  all modified in-core data in both file
> > >                   ranges and all metadata updates  pertaining  to  the
> > >                   exchange operation are flushed to persistent storage
> > >                   before the call returns.  Opening  either  file  de‐
> > >                   scriptor  with  O_SYNC or O_DSYNC will have the same
> > >                   effect.
> > > 
> > >            XFS_EXCHRANGE_FILE1_WRITTEN
> > >                   Only exchange sub-ranges of file1_fd that are  known
> > >                   to  contain  data  written  by application software.
> > >                   Each sub-range may be  expanded  (both  upwards  and
> > >                   downwards)  to  align with the file allocation unit.
> > >                   For files on the data device, this is one filesystem
> > >                   block.   For  files  on the realtime device, this is
> > >                   the realtime extent size.  This facility can be used
> > >                   to  implement  fast  atomic scatter-gather writes of
> > >                   any complexity for software-defined storage  targets
> > >                   if  all  writes  are  aligned to the file allocation
> > >                   unit.
> > > 
> > >            XFS_EXCHRANGE_DRY_RUN
> > >                   Check the parameters and the feasibility of the  op‐
> > >                   eration, but do not change anything.
> > > 
> > > RETURN VALUE
> > >        On  error, -1 is returned, and errno is set to indicate the er‐
> > >        ror.
> > > 
> > > ERRORS
> > >        Error codes can be one of, but are not limited to, the  follow‐
> > >        ing:
> > > 
> > >        EBADF  file1_fd  is not open for reading and writing or is open
> > >               for append-only writes; or  file2_fd  is  not  open  for
> > >               reading and writing or is open for append-only writes.
> > > 
> > >        EINVAL The  parameters  are  not correct for these files.  This
> > >               error can also appear if either file  descriptor  repre‐
> > >               sents  a device, FIFO, or socket.  Disk filesystems gen‐
> > >               erally require the offset and  length  arguments  to  be
> > >               aligned to the fundamental block sizes of both files.
> > > 
> > >        EIO    An I/O error occurred.
> > > 
> > >        EISDIR One of the files is a directory.
> > > 
> > >        ENOMEM The  kernel  was unable to allocate sufficient memory to
> > >               perform the operation.
> > > 
> > >        ENOSPC There is not enough free space  in  the  filesystem  ex‐
> > >               change the contents safely.
> > > 
> > >        EOPNOTSUPP
> > >               The filesystem does not support exchanging bytes between
> > >               the two files.
> > > 
> > >        EPERM  file1_fd or file2_fd are immutable.
> > > 
> > >        ETXTBSY
> > >               One of the files is a swap file.
> > > 
> > >        EUCLEAN
> > >               The filesystem is corrupt.
> > > 
> > >        EXDEV  file1_fd and  file2_fd  are  not  on  the  same  mounted
> > >               filesystem.
> > > 
> > > CONFORMING TO
> > >        This API is XFS-specific.
> > > 
> > > USE CASES
> > >        Several  use  cases  are imagined for this system call.  In all
> > >        cases, application software must coordinate updates to the file
> > >        because the exchange is performed unconditionally.
> > > 
> > >        The  first  is a data storage program that wants to commit non-
> > >        contiguous updates to a file atomically and  coordinates  write
> > >        access  to that file.  This can be done by creating a temporary
> > >        file, calling FICLONE(2) to share the contents, and staging the
> > >        updates into the temporary file.  The FULL_FILES flag is recom‐
> > >        mended for this purpose.  The temporary file can be deleted  or
> > >        punched out afterwards.
> > > 
> > >        An example program might look like this:
> > > 
> > >            int fd = open("/some/file", O_RDWR);
> > >            int temp_fd = open("/some", O_TMPFILE | O_RDWR);
> > > 
> > >            ioctl(temp_fd, FICLONE, fd);
> > > 
> > >            /* append 1MB of records */
> > >            lseek(temp_fd, 0, SEEK_END);
> > >            write(temp_fd, data1, 1000000);
> > > 
> > >            /* update record index */
> > >            pwrite(temp_fd, data1, 600, 98765);
> > >            pwrite(temp_fd, data2, 320, 54321);
> > >            pwrite(temp_fd, data2, 15, 0);
> > > 
> > >            /* commit the entire update */
> > >            struct xfs_exch_range args = {
> > >                .file1_fd = temp_fd,
> > >                .flags = XFS_EXCHRANGE_TO_EOF,
> > >            };
> > > 
> > >            ioctl(fd, XFS_IOC_EXCHANGE_RANGE, &args);
> > > 
> > >        The  second  is  a  software-defined  storage host (e.g. a disk
> > >        jukebox) which implements an atomic scatter-gather  write  com‐
> > >        mand.   Provided the exported disk's logical block size matches
> > >        the file's allocation unit size, this can be done by creating a
> > >        temporary file and writing the data at the appropriate offsets.
> > >        It is recommended that the temporary file be truncated  to  the
> > >        size  of  the  regular file before any writes are staged to the
> > >        temporary file to avoid issues with zeroing during  EOF  exten‐
> > >        sion.   Use  this  call with the FILE1_WRITTEN flag to exchange
> > >        only the file allocation units involved  in  the  emulated  de‐
> > >        vice's  write  command.  The temporary file should be truncated
> > >        or punched out completely before being reused to stage  another
> > >        write.
> > > 
> > >        An example program might look like this:
> > > 
> > >            int fd = open("/some/file", O_RDWR);
> > >            int temp_fd = open("/some", O_TMPFILE | O_RDWR);
> > >            struct stat sb;
> > >            int blksz;
> > > 
> > >            fstat(fd, &sb);
> > >            blksz = sb.st_blksize;
> > > 
> > >            /* land scatter gather writes between 100fsb and 500fsb */
> > >            pwrite(temp_fd, data1, blksz * 2, blksz * 100);
> > >            pwrite(temp_fd, data2, blksz * 20, blksz * 480);
> > >            pwrite(temp_fd, data3, blksz * 7, blksz * 257);
> > > 
> > >            /* commit the entire update */
> > >            struct xfs_exch_range args = {
> > >                .file1_fd = temp_fd,
> > >                .file1_offset = blksz * 100,
> > >                .file2_offset = blksz * 100,
> > >                .length       = blksz * 400,
> > >                .flags        = XFS_EXCHRANGE_FILE1_WRITTEN |
> > >                                XFS_EXCHRANGE_FILE1_DSYNC,
> > >            };
> > > 
> > >            ioctl(fd, XFS_IOC_EXCHANGE_RANGE, &args);
> > > 
> > > NOTES
> > >        Some  filesystems may limit the amount of data or the number of
> > >        extents that can be exchanged in a single call.
> > > 
> > > SEE ALSO
> > >        ioctl(2)
> > > 
> > > XFS                           2024-02-10   IOCTL-XFS-EXCHANGE-RANGE(2)
> > > IOCTL-XFS-COMMIT-RANGE(2) System Calls ManualIOCTL-XFS-COMMIT-RANGE(2)
> > > 
> > > NAME
> > >        ioctl_xfs_commit_range - conditionally exchange the contents of
> > >        parts of two files
> > > 
> > > SYNOPSIS
> > >        #include <sys/ioctl.h>
> > >        #include <xfs/xfs_fs_staging.h>
> > > 
> > >        int ioctl(int file2_fd, XFS_IOC_COMMIT_RANGE,  struct  xfs_com‐
> > >        mit_range *arg);
> > > 
> > > DESCRIPTION
> > >        Given  a  range  of bytes in a first file file1_fd and a second
> > >        range of bytes in a second file  file2_fd,  this  ioctl(2)  ex‐
> > >        changes  the contents of the two ranges if file2_fd passes cer‐
> > >        tain freshness criteria.
> > > 
> > >        After locking both files but before  exchanging  the  contents,
> > >        the  supplied  file2_ino field must match file2_fd's inode num‐
> > >        ber,   and   the   supplied   file2_mtime,    file2_mtime_nsec,
> > >        file2_ctime, and file2_ctime_nsec fields must match the modifi‐
> > >        cation time and change time of file2.  If they  do  not  match,
> > >        EBUSY will be returned.
> > > 
> > 
> > Maybe a stupid question, but under which circumstances would mtime
> > change and ctime not change? Why are both needed?
> > 
> 
> ctime should always change if the mtime does. An mtime update means that
> the metadata was updated, so you also need to update the ctime. 

Exactly. :)

> > And for a new API, wouldn't it be better to use change_cookie (a.k.a i_version)?
> > Even if this API is designed to be hoisted out of XFS at some future time,
> > Is there a real need to support it on filesystems that do not support
> > i_version(?)
> > 
> > Not to mention the fact that POSIX does not explicitly define how ctime should
> > behave with changes to fiemap (uninitialized extent and all), so who knows
> > how other filesystems may update ctime in those cases.
> > 
> > I realize that STATX_CHANGE_COOKIE is currently kernel internal, but
> > it seems that XFS_IOC_EXCHANGE_RANGE is a case where userspace
> > really explicitly requests a bump of i_version on the next change.
> > 
> 
> 
> I agree. Using an opaque change cookie would be a lot nicer from an API
> standpoint, and shouldn't be subject to timestamp granularity issues.

TLDR: No.

> That said, XFS's change cookie is currently broken. Dave C. said he had
> some patches in progress to fix that however.

Dave says that about a lot of things.  I'm not willing to delay the
online fsck project _even further_ for a bunch of vaporware that's not
even out on linux-xfs for review.

The difference in opinion between xfs and the rest of the kernel about
i_version is 50% of why I didn't include it here.  The other 50% is the
part where userspace can't access it, because I do not want to saddle my
mostly internal project with YET ANOTHER ASK FROM RH PEOPLE FOR CORE
CHANGES.

--D

> -- 
> Jeff Layton <jlayton@kernel.org>
> 

