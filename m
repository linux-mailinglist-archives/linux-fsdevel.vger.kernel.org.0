Return-Path: <linux-fsdevel+bounces-12929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D9A868C16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 10:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A251F21AD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75711136658;
	Tue, 27 Feb 2024 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYIp6su9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E169136648;
	Tue, 27 Feb 2024 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025833; cv=none; b=Zb7Uc7uOV2FOhCZSEm4PEhriU8ofv7t8+lTA0cPatY1lpcsBVejspN9nA/EGe5yTfk6ax3vhyj+GPWAZ3480kzU+nyyfhUJzwQnm76pFpkNcABlEnyN4g3ijA3z11Xp0hgyCLwpZ3Ob5qZ2FMTZ5J6Ss9HQPPQXdyowkCrEx/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025833; c=relaxed/simple;
	bh=5XZVLo/2hJlwkQK3vexJ0RKlVvUzSfwyIlaRuHNXpMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1Efe+AD6v1g4gt6VIxCUh1mNh3uEjwq2A45k3IAubGJlto8NKaPbcLsLw7pFF3WgwnTb3Or4JjHySGeUQJpt/JQnJGFx6boCSN1Mw8LVvzJcMjDQBiah8ozbgu6O7jUlrtmfXSRk61sFl2dpUuMEr4pnsMGw/dKatYJ6LRd2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYIp6su9; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-607cd210962so36475987b3.2;
        Tue, 27 Feb 2024 01:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709025831; x=1709630631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUmNgfXMh4BT14Bhora2ejr31JWyme77iZVtpTzl7Vw=;
        b=jYIp6su9YIJ2UGGnbgwiiK7NEvh1fEfZ0sqkWcaIbKy4kJINbmuqeZ0pdzPLujtIm3
         4rBi1/j6E0yEsJbsaf3dBbmJg+7BIypPbHG9sgMO5AxYEIrPpMJBihLljnKfD6YBAwmG
         rzufArLu48+6C390gp8FQ5C4ZRIblGmkB7oxIya/F77IRTqK6u7ABH4h/5sA34jo2u4U
         weEbtZD6Q+3sWmStQeUfVru2tsh9JNjDDErvGngj50G5oXHCu4L6Ap5sNOc/vwzAY8u2
         Jsr/WzaxLb3zISKgFApu8Q1P9wn/jn1ZkB+8e4DZf2Ub4VULSeOoTHO32lDk1iWaaCZx
         /d8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709025831; x=1709630631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUmNgfXMh4BT14Bhora2ejr31JWyme77iZVtpTzl7Vw=;
        b=h/hlHaTN0911Qjk6jG0Vz7ytUPEgKju2DWyQt9ATjS5D4XygqapueCD6epx7jEIrgJ
         NHjeWwEgT60VkoXO0AUxwGOuS5zySkswL0NLuEB2y050Or5Tw/Eejl4Vvw1MbmFiuqBZ
         5254bDs2OVvzuLCA8bKSwIvUj3xJMwKlkNf/SaS0GGuLFrkMslPp+Jf81qFGOLSCy/tl
         h5GebZ4RJ3fXUC17pO6KaUvxnSVcyj9UOhgwoWstpswcpVR1cmnoYjunLcs5uTb6R8kX
         VS9P1VQAtPteqI158oWE0LCOMfD/pZ0iah9LqY/rSVY+aySIUjTkt2hrYf16gvQJHfkK
         vINw==
X-Forwarded-Encrypted: i=1; AJvYcCUrs9F0SBEKYB9aZU7Sej5/eKsENpqHosCYHfoSyoAD63tqqTENKfhyP5GkgMvLGuHE4+dpxYll9RYIZJIMctyW+rKxKaVqnnZK
X-Gm-Message-State: AOJu0YyaYH1494xWKJPpow175NtAGL46vbdqCIHW4GbVqM9wQIUEMs1S
	Yuti0aDBGVvDPexpoU28HcK3umH0ffyKA2RCYNU+IFqwSCFT0wFjGA0aA3aKnW59yFc8OlDv6dN
	0BflhRpsqWIK17g0Re/R69YyZZ+EFubMWmOo=
X-Google-Smtp-Source: AGHT+IHIMbmNWBMf5SlCGU3bXVWaa3gvGwBJ1J5AC6XHlTjSkTdqmDKlJeMbQ5NWOflqX5/trEcFOzSNlfN27BFCKFA=
X-Received: by 2002:a81:ef09:0:b0:604:a9c2:2a17 with SMTP id
 o9-20020a81ef09000000b00604a9c22a17mr1596483ywm.45.1709025830940; Tue, 27 Feb
 2024 01:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
In-Reply-To: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 27 Feb 2024 11:23:39 +0200
Message-ID: <CAOQ4uxh-gKGuwrvuQnWKcKLKQe2j9s__Yx2T-gCrDJMUbm5ZYA@mail.gmail.com>
Subject: Re: [PATCHSET v29.4 03/13] xfs: atomic file content exchanges
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:18=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> Hi all,
>
> This series creates a new FIEXCHANGE_RANGE system call to exchange
> ranges of bytes between two files atomically.  This new functionality
> enables data storage programs to stage and commit file updates such that
> reader programs will see either the old contents or the new contents in
> their entirety, with no chance of torn writes.  A successful call
> completion guarantees that the new contents will be seen even if the
> system fails.
>
> The ability to exchange file fork mappings between files in this manner
> is critical to supporting online filesystem repair, which is built upon
> the strategy of constructing a clean copy of a damaged structure and
> committing the new structure into the metadata file atomically.
>
> User programs will be able to update files atomically by opening an
> O_TMPFILE, reflinking the source file to it, making whatever updates
> they want to make, and exchange the relevant ranges of the temp file
> with the original file.  If the updates are aligned with the file block
> size, a new (since v2) flag provides for exchanging only the written
> areas.  Callers can arrange for the update to be rejected if the
> original file has been changed.
>
> The intent behind this new userspace functionality is to enable atomic
> rewrites of arbitrary parts of individual files.  For years, application
> programmers wanting to ensure the atomicity of a file update had to
> write the changes to a new file in the same directory, fsync the new
> file, rename the new file on top of the old filename, and then fsync the
> directory.  People get it wrong all the time, and $fs hacks abound.
> Here are the proposed manual pages:
>
> IOCTL-XFS-EXCHANGE-RANGE(2System Calls ManuIOCTL-XFS-EXCHANGE-RANGE(2)
>
> NAME
>        ioctl_xfs_exchange_range  -  exchange  the contents of parts of
>        two files
>
> SYNOPSIS
>        #include <sys/ioctl.h>
>        #include <xfs/xfs_fs_staging.h>
>
>        int   ioctl(int   file2_fd,   XFS_IOC_EXCHANGE_RANGE,    struct
>        xfs_exch_range *arg);
>
> DESCRIPTION
>        Given  a  range  of bytes in a first file file1_fd and a second
>        range of bytes in a second file  file2_fd,  this  ioctl(2)  ex=E2=
=80=90
>        changes the contents of the two ranges.
>
>        Exchanges  are  atomic  with  regards to concurrent file opera=E2=
=80=90
>        tions, so no userspace-level locks need to be taken  to  obtain
>        consistent  results.  Implementations must guarantee that read=E2=
=80=90
>        ers see either the old contents or the new  contents  in  their
>        entirety, even if the system fails.
>
>        The  system  call  parameters are conveyed in structures of the
>        following form:
>
>            struct xfs_exch_range {
>                __s64    file1_fd;
>                __s64    file1_offset;
>                __s64    file2_offset;
>                __s64    length;
>                __u64    flags;
>
>                __u64    pad;
>            };
>
>        The field pad must be zero.
>
>        The fields file1_fd, file1_offset, and length define the  first
>        range of bytes to be exchanged.
>
>        The fields file2_fd, file2_offset, and length define the second
>        range of bytes to be exchanged.
>
>        Both files must be from the same filesystem mount.  If the  two
>        file  descriptors represent the same file, the byte ranges must
>        not overlap.  Most  disk-based  filesystems  require  that  the
>        starts  of  both ranges must be aligned to the file block size.
>        If this is the case, the ends of the ranges  must  also  be  so
>        aligned unless the XFS_EXCHRANGE_TO_EOF flag is set.
>
>        The field flags control the behavior of the exchange operation.
>
>            XFS_EXCHRANGE_TO_EOF
>                   Ignore  the length parameter.  All bytes in file1_fd
>                   from file1_offset to EOF are moved to file2_fd,  and
>                   file2's  size is set to (file2_offset+(file1_length-
>                   file1_offset)).  Meanwhile, all bytes in file2  from
>                   file2_offset  to  EOF are moved to file1 and file1's
>                   size   is   set   to    (file1_offset+(file2_length-
>                   file2_offset)).
>
>            XFS_EXCHRANGE_DSYNC
>                   Ensure  that  all modified in-core data in both file
>                   ranges and all metadata updates  pertaining  to  the
>                   exchange operation are flushed to persistent storage
>                   before the call returns.  Opening  either  file  de=E2=
=80=90
>                   scriptor  with  O_SYNC or O_DSYNC will have the same
>                   effect.
>
>            XFS_EXCHRANGE_FILE1_WRITTEN
>                   Only exchange sub-ranges of file1_fd that are  known
>                   to  contain  data  written  by application software.
>                   Each sub-range may be  expanded  (both  upwards  and
>                   downwards)  to  align with the file allocation unit.
>                   For files on the data device, this is one filesystem
>                   block.   For  files  on the realtime device, this is
>                   the realtime extent size.  This facility can be used
>                   to  implement  fast  atomic scatter-gather writes of
>                   any complexity for software-defined storage  targets
>                   if  all  writes  are  aligned to the file allocation
>                   unit.
>
>            XFS_EXCHRANGE_DRY_RUN
>                   Check the parameters and the feasibility of the  op=E2=
=80=90
>                   eration, but do not change anything.
>
> RETURN VALUE
>        On  error, -1 is returned, and errno is set to indicate the er=E2=
=80=90
>        ror.
>
> ERRORS
>        Error codes can be one of, but are not limited to, the  follow=E2=
=80=90
>        ing:
>
>        EBADF  file1_fd  is not open for reading and writing or is open
>               for append-only writes; or  file2_fd  is  not  open  for
>               reading and writing or is open for append-only writes.
>
>        EINVAL The  parameters  are  not correct for these files.  This
>               error can also appear if either file  descriptor  repre=E2=
=80=90
>               sents  a device, FIFO, or socket.  Disk filesystems gen=E2=
=80=90
>               erally require the offset and  length  arguments  to  be
>               aligned to the fundamental block sizes of both files.
>
>        EIO    An I/O error occurred.
>
>        EISDIR One of the files is a directory.
>
>        ENOMEM The  kernel  was unable to allocate sufficient memory to
>               perform the operation.
>
>        ENOSPC There is not enough free space  in  the  filesystem  ex=E2=
=80=90
>               change the contents safely.
>
>        EOPNOTSUPP
>               The filesystem does not support exchanging bytes between
>               the two files.
>
>        EPERM  file1_fd or file2_fd are immutable.
>
>        ETXTBSY
>               One of the files is a swap file.
>
>        EUCLEAN
>               The filesystem is corrupt.
>
>        EXDEV  file1_fd and  file2_fd  are  not  on  the  same  mounted
>               filesystem.
>
> CONFORMING TO
>        This API is XFS-specific.
>
> USE CASES
>        Several  use  cases  are imagined for this system call.  In all
>        cases, application software must coordinate updates to the file
>        because the exchange is performed unconditionally.
>
>        The  first  is a data storage program that wants to commit non-
>        contiguous updates to a file atomically and  coordinates  write
>        access  to that file.  This can be done by creating a temporary
>        file, calling FICLONE(2) to share the contents, and staging the
>        updates into the temporary file.  The FULL_FILES flag is recom=E2=
=80=90
>        mended for this purpose.  The temporary file can be deleted  or
>        punched out afterwards.
>
>        An example program might look like this:
>
>            int fd =3D open("/some/file", O_RDWR);
>            int temp_fd =3D open("/some", O_TMPFILE | O_RDWR);
>
>            ioctl(temp_fd, FICLONE, fd);
>
>            /* append 1MB of records */
>            lseek(temp_fd, 0, SEEK_END);
>            write(temp_fd, data1, 1000000);
>
>            /* update record index */
>            pwrite(temp_fd, data1, 600, 98765);
>            pwrite(temp_fd, data2, 320, 54321);
>            pwrite(temp_fd, data2, 15, 0);
>
>            /* commit the entire update */
>            struct xfs_exch_range args =3D {
>                .file1_fd =3D temp_fd,
>                .flags =3D XFS_EXCHRANGE_TO_EOF,
>            };
>
>            ioctl(fd, XFS_IOC_EXCHANGE_RANGE, &args);
>
>        The  second  is  a  software-defined  storage host (e.g. a disk
>        jukebox) which implements an atomic scatter-gather  write  com=E2=
=80=90
>        mand.   Provided the exported disk's logical block size matches
>        the file's allocation unit size, this can be done by creating a
>        temporary file and writing the data at the appropriate offsets.
>        It is recommended that the temporary file be truncated  to  the
>        size  of  the  regular file before any writes are staged to the
>        temporary file to avoid issues with zeroing during  EOF  exten=E2=
=80=90
>        sion.   Use  this  call with the FILE1_WRITTEN flag to exchange
>        only the file allocation units involved  in  the  emulated  de=E2=
=80=90
>        vice's  write  command.  The temporary file should be truncated
>        or punched out completely before being reused to stage  another
>        write.
>
>        An example program might look like this:
>
>            int fd =3D open("/some/file", O_RDWR);
>            int temp_fd =3D open("/some", O_TMPFILE | O_RDWR);
>            struct stat sb;
>            int blksz;
>
>            fstat(fd, &sb);
>            blksz =3D sb.st_blksize;
>
>            /* land scatter gather writes between 100fsb and 500fsb */
>            pwrite(temp_fd, data1, blksz * 2, blksz * 100);
>            pwrite(temp_fd, data2, blksz * 20, blksz * 480);
>            pwrite(temp_fd, data3, blksz * 7, blksz * 257);
>
>            /* commit the entire update */
>            struct xfs_exch_range args =3D {
>                .file1_fd =3D temp_fd,
>                .file1_offset =3D blksz * 100,
>                .file2_offset =3D blksz * 100,
>                .length       =3D blksz * 400,
>                .flags        =3D XFS_EXCHRANGE_FILE1_WRITTEN |
>                                XFS_EXCHRANGE_FILE1_DSYNC,
>            };
>
>            ioctl(fd, XFS_IOC_EXCHANGE_RANGE, &args);
>
> NOTES
>        Some  filesystems may limit the amount of data or the number of
>        extents that can be exchanged in a single call.
>
> SEE ALSO
>        ioctl(2)
>
> XFS                           2024-02-10   IOCTL-XFS-EXCHANGE-RANGE(2)
> IOCTL-XFS-COMMIT-RANGE(2) System Calls ManualIOCTL-XFS-COMMIT-RANGE(2)
>
> NAME
>        ioctl_xfs_commit_range - conditionally exchange the contents of
>        parts of two files
>
> SYNOPSIS
>        #include <sys/ioctl.h>
>        #include <xfs/xfs_fs_staging.h>
>
>        int ioctl(int file2_fd, XFS_IOC_COMMIT_RANGE,  struct  xfs_com=E2=
=80=90
>        mit_range *arg);
>
> DESCRIPTION
>        Given  a  range  of bytes in a first file file1_fd and a second
>        range of bytes in a second file  file2_fd,  this  ioctl(2)  ex=E2=
=80=90
>        changes  the contents of the two ranges if file2_fd passes cer=E2=
=80=90
>        tain freshness criteria.
>
>        After locking both files but before  exchanging  the  contents,
>        the  supplied  file2_ino field must match file2_fd's inode num=E2=
=80=90
>        ber,   and   the   supplied   file2_mtime,    file2_mtime_nsec,
>        file2_ctime, and file2_ctime_nsec fields must match the modifi=E2=
=80=90
>        cation time and change time of file2.  If they  do  not  match,
>        EBUSY will be returned.
>

Maybe a stupid question, but under which circumstances would mtime
change and ctime not change? Why are both needed?

And for a new API, wouldn't it be better to use change_cookie (a.k.a i_vers=
ion)?
Even if this API is designed to be hoisted out of XFS at some future time,
Is there a real need to support it on filesystems that do not support
i_version(?)

Not to mention the fact that POSIX does not explicitly define how ctime sho=
uld
behave with changes to fiemap (uninitialized extent and all), so who knows
how other filesystems may update ctime in those cases.

I realize that STATX_CHANGE_COOKIE is currently kernel internal, but
it seems that XFS_IOC_EXCHANGE_RANGE is a case where userspace
really explicitly requests a bump of i_version on the next change.

Thanks,
Amir.

