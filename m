Return-Path: <linux-fsdevel+bounces-13273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4A686E1DB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102E1283CB8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DF86F50F;
	Fri,  1 Mar 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz1qZZAE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E46DCE8;
	Fri,  1 Mar 2024 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299006; cv=none; b=rOjElHv43wCrtuEmgVKEZ0eAvPPMy5UO01/NXbS28wo0NJ7D+1PlGcFI/NhEFlWOrmtqt8Lc2yUOVTEyOf7jngAqcd+wiG+pRDwqrYqO9lMoN80gjUQSscNjBVNFpd4TvbfDsHuLr7hqll9zdrFRMMkfhel4Vn3h2I6N3YiCl0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299006; c=relaxed/simple;
	bh=E1e1AmT0MoSVA9voUae0Wl2nSHZ/+XheTb1/Lfz8cCQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gXGMTIDVzT+0uCl9mDJyajVAi3VtAzN+OrYMENkXes3YKjVve3z2cCxF1+qKq9x4z+KD1m5fI8QK4EDQwQHzZJwZN1T1kdIAGgiMQixtxpzHbDbFMBCgAfka7UPXb+RTiFpEsxn8IoHVc/SyK01Bb+pw5OkUuu+uUugW9/XocIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz1qZZAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C01C433C7;
	Fri,  1 Mar 2024 13:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709299006;
	bh=E1e1AmT0MoSVA9voUae0Wl2nSHZ/+XheTb1/Lfz8cCQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bz1qZZAE4SmZRQoettyL/NGkPnCWGCgsC/mQvaou/VsA3qVL4Z2WCV/Exkxgety6c
	 rcJhyjXGw3pGMdmdudercztrTcVvuNEeue5UVCYzx1Y9sCq22oJwzuoNZ9UYgwYK3S
	 H9Jzw4wXY/4vhpQmQvNuEKBz1YVgZJN/ZhZb7VxM1w4E0567tNr28TIjBYyCRCo3fv
	 A39r66Yx8QYQyran0Oy1mL/97VPcnvdlYADV4M2i46HaBn6Mkt1A3Rea6CbAXtmDmT
	 8FXNGFqidChJiKuRZ6sc/LEextp3JbM1cJXsWhK/6q8CriJURL99sI4aQSQV1c4QQd
	 qOHhBHNw7BkUA==
Message-ID: <6a0e108a26b57402ed6ed0fc58fb640b5dadb400.camel@kernel.org>
Subject: Re: [PATCHSET v29.4 03/13] xfs: atomic file content exchanges
From: Jeff Layton <jlayton@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, hch@lst.de
Date: Fri, 01 Mar 2024 08:16:44 -0500
In-Reply-To: <20240227160658.GW616564@frogsfrogsfrogs>
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
	 <CAOQ4uxh-gKGuwrvuQnWKcKLKQe2j9s__Yx2T-gCrDJMUbm5ZYA@mail.gmail.com>
	 <4e29a0395b3963e6a48f916baaf16394acd017ca.camel@kernel.org>
	 <20240227160658.GW616564@frogsfrogsfrogs>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-27 at 08:06 -0800, Darrick J. Wong wrote:
> On Tue, Feb 27, 2024 at 05:53:46AM -0500, Jeff Layton wrote:
> > On Tue, 2024-02-27 at 11:23 +0200, Amir Goldstein wrote:
> > > On Tue, Feb 27, 2024 at 4:18=E2=80=AFAM Darrick J. Wong <djwong@kerne=
l.org> wrote:
> > > >=20
> > > > Hi all,
> > > >=20
> > > > This series creates a new FIEXCHANGE_RANGE system call to exchange
> > > > ranges of bytes between two files atomically.  This new functionali=
ty
> > > > enables data storage programs to stage and commit file updates such=
 that
> > > > reader programs will see either the old contents or the new content=
s in
> > > > their entirety, with no chance of torn writes.  A successful call
> > > > completion guarantees that the new contents will be seen even if th=
e
> > > > system fails.
> > > >=20
> > > > The ability to exchange file fork mappings between files in this ma=
nner
> > > > is critical to supporting online filesystem repair, which is built =
upon
> > > > the strategy of constructing a clean copy of a damaged structure an=
d
> > > > committing the new structure into the metadata file atomically.
> > > >=20
> > > > User programs will be able to update files atomically by opening an
> > > > O_TMPFILE, reflinking the source file to it, making whatever update=
s
> > > > they want to make, and exchange the relevant ranges of the temp fil=
e
> > > > with the original file.  If the updates are aligned with the file b=
lock
> > > > size, a new (since v2) flag provides for exchanging only the writte=
n
> > > > areas.  Callers can arrange for the update to be rejected if the
> > > > original file has been changed.
> > > >=20
> > > > The intent behind this new userspace functionality is to enable ato=
mic
> > > > rewrites of arbitrary parts of individual files.  For years, applic=
ation
> > > > programmers wanting to ensure the atomicity of a file update had to
> > > > write the changes to a new file in the same directory, fsync the ne=
w
> > > > file, rename the new file on top of the old filename, and then fsyn=
c the
> > > > directory.  People get it wrong all the time, and $fs hacks abound.
> > > > Here are the proposed manual pages:
> > > >=20
> >=20
> > This is a cool idea!  I've had some handwavy ideas about making a gated
> > write() syscall (i.e. only write if the change cookie hasn't changed),
> > but something like this may be a simpler lift initially.
>=20
> How /does/ userspace get at the change cookie nowadays?
>=20

Today, it doesn't. That would need to be exposed before we could make
that work.

> > > > IOCTL-XFS-EXCHANGE-RANGE(2System Calls ManuIOCTL-XFS-EXCHANGE-RANGE=
(2)
> > > >=20
> > > > NAME
> > > >        ioctl_xfs_exchange_range  -  exchange  the contents of parts=
 of
> > > >        two files
> > > >=20
> > > > SYNOPSIS
> > > >        #include <sys/ioctl.h>
> > > >        #include <xfs/xfs_fs_staging.h>
> > > >=20
> > > >        int   ioctl(int   file2_fd,   XFS_IOC_EXCHANGE_RANGE,    str=
uct
> > > >        xfs_exch_range *arg);
> > > >=20
> > > > DESCRIPTION
> > > >        Given  a  range  of bytes in a first file file1_fd and a sec=
ond
> > > >        range of bytes in a second file  file2_fd,  this  ioctl(2)  =
ex=E2=80=90
> > > >        changes the contents of the two ranges.
> > > >=20
> > > >        Exchanges  are  atomic  with  regards to concurrent file ope=
ra=E2=80=90
> > > >        tions, so no userspace-level locks need to be taken  to  obt=
ain
> > > >        consistent  results.  Implementations must guarantee that re=
ad=E2=80=90
> > > >        ers see either the old contents or the new  contents  in  th=
eir
> > > >        entirety, even if the system fails.
> > > >=20
> > > >        The  system  call  parameters are conveyed in structures of =
the
> > > >        following form:
> > > >=20
> > > >            struct xfs_exch_range {
> > > >                __s64    file1_fd;
> > > >                __s64    file1_offset;
> > > >                __s64    file2_offset;
> > > >                __s64    length;
> > > >                __u64    flags;
> > > >=20
> > > >                __u64    pad;
> > > >            };
> > > >=20
> > > >        The field pad must be zero.
> > > >=20
> > > >        The fields file1_fd, file1_offset, and length define the  fi=
rst
> > > >        range of bytes to be exchanged.
> > > >=20
> > > >        The fields file2_fd, file2_offset, and length define the sec=
ond
> > > >        range of bytes to be exchanged.
> > > >=20
> > > >        Both files must be from the same filesystem mount.  If the  =
two
> > > >        file  descriptors represent the same file, the byte ranges m=
ust
> > > >        not overlap.  Most  disk-based  filesystems  require  that  =
the
> > > >        starts  of  both ranges must be aligned to the file block si=
ze.
> > > >        If this is the case, the ends of the ranges  must  also  be =
 so
> > > >        aligned unless the XFS_EXCHRANGE_TO_EOF flag is set.
> > > >=20
> > > >        The field flags control the behavior of the exchange operati=
on.
> > > >=20
> > > >            XFS_EXCHRANGE_TO_EOF
> > > >                   Ignore  the length parameter.  All bytes in file1=
_fd
> > > >                   from file1_offset to EOF are moved to file2_fd,  =
and
> > > >                   file2's  size is set to (file2_offset+(file1_leng=
th-
> > > >                   file1_offset)).  Meanwhile, all bytes in file2  f=
rom
> > > >                   file2_offset  to  EOF are moved to file1 and file=
1's
> > > >                   size   is   set   to    (file1_offset+(file2_leng=
th-
> > > >                   file2_offset)).
> > > >=20
> > > >            XFS_EXCHRANGE_DSYNC
> > > >                   Ensure  that  all modified in-core data in both f=
ile
> > > >                   ranges and all metadata updates  pertaining  to  =
the
> > > >                   exchange operation are flushed to persistent stor=
age
> > > >                   before the call returns.  Opening  either  file  =
de=E2=80=90
> > > >                   scriptor  with  O_SYNC or O_DSYNC will have the s=
ame
> > > >                   effect.
> > > >=20
> > > >            XFS_EXCHRANGE_FILE1_WRITTEN
> > > >                   Only exchange sub-ranges of file1_fd that are  kn=
own
> > > >                   to  contain  data  written  by application softwa=
re.
> > > >                   Each sub-range may be  expanded  (both  upwards  =
and
> > > >                   downwards)  to  align with the file allocation un=
it.
> > > >                   For files on the data device, this is one filesys=
tem
> > > >                   block.   For  files  on the realtime device, this=
 is
> > > >                   the realtime extent size.  This facility can be u=
sed
> > > >                   to  implement  fast  atomic scatter-gather writes=
 of
> > > >                   any complexity for software-defined storage  targ=
ets
> > > >                   if  all  writes  are  aligned to the file allocat=
ion
> > > >                   unit.
> > > >=20
> > > >            XFS_EXCHRANGE_DRY_RUN
> > > >                   Check the parameters and the feasibility of the  =
op=E2=80=90
> > > >                   eration, but do not change anything.
> > > >=20
> > > > RETURN VALUE
> > > >        On  error, -1 is returned, and errno is set to indicate the =
er=E2=80=90
> > > >        ror.
> > > >=20
> > > > ERRORS
> > > >        Error codes can be one of, but are not limited to, the  foll=
ow=E2=80=90
> > > >        ing:
> > > >=20
> > > >        EBADF  file1_fd  is not open for reading and writing or is o=
pen
> > > >               for append-only writes; or  file2_fd  is  not  open  =
for
> > > >               reading and writing or is open for append-only writes=
.
> > > >=20
> > > >        EINVAL The  parameters  are  not correct for these files.  T=
his
> > > >               error can also appear if either file  descriptor  rep=
re=E2=80=90
> > > >               sents  a device, FIFO, or socket.  Disk filesystems g=
en=E2=80=90
> > > >               erally require the offset and  length  arguments  to =
 be
> > > >               aligned to the fundamental block sizes of both files.
> > > >=20
> > > >        EIO    An I/O error occurred.
> > > >=20
> > > >        EISDIR One of the files is a directory.
> > > >=20
> > > >        ENOMEM The  kernel  was unable to allocate sufficient memory=
 to
> > > >               perform the operation.
> > > >=20
> > > >        ENOSPC There is not enough free space  in  the  filesystem  =
ex=E2=80=90
> > > >               change the contents safely.
> > > >=20
> > > >        EOPNOTSUPP
> > > >               The filesystem does not support exchanging bytes betw=
een
> > > >               the two files.
> > > >=20
> > > >        EPERM  file1_fd or file2_fd are immutable.
> > > >=20
> > > >        ETXTBSY
> > > >               One of the files is a swap file.
> > > >=20
> > > >        EUCLEAN
> > > >               The filesystem is corrupt.
> > > >=20
> > > >        EXDEV  file1_fd and  file2_fd  are  not  on  the  same  moun=
ted
> > > >               filesystem.
> > > >=20
> > > > CONFORMING TO
> > > >        This API is XFS-specific.
> > > >=20
> > > > USE CASES
> > > >        Several  use  cases  are imagined for this system call.  In =
all
> > > >        cases, application software must coordinate updates to the f=
ile
> > > >        because the exchange is performed unconditionally.
> > > >=20
> > > >        The  first  is a data storage program that wants to commit n=
on-
> > > >        contiguous updates to a file atomically and  coordinates  wr=
ite
> > > >        access  to that file.  This can be done by creating a tempor=
ary
> > > >        file, calling FICLONE(2) to share the contents, and staging =
the
> > > >        updates into the temporary file.  The FULL_FILES flag is rec=
om=E2=80=90
> > > >        mended for this purpose.  The temporary file can be deleted =
 or
> > > >        punched out afterwards.
> > > >=20
> > > >        An example program might look like this:
> > > >=20
> > > >            int fd =3D open("/some/file", O_RDWR);
> > > >            int temp_fd =3D open("/some", O_TMPFILE | O_RDWR);
> > > >=20
> > > >            ioctl(temp_fd, FICLONE, fd);
> > > >=20
> > > >            /* append 1MB of records */
> > > >            lseek(temp_fd, 0, SEEK_END);
> > > >            write(temp_fd, data1, 1000000);
> > > >=20
> > > >            /* update record index */
> > > >            pwrite(temp_fd, data1, 600, 98765);
> > > >            pwrite(temp_fd, data2, 320, 54321);
> > > >            pwrite(temp_fd, data2, 15, 0);
> > > >=20
> > > >            /* commit the entire update */
> > > >            struct xfs_exch_range args =3D {
> > > >                .file1_fd =3D temp_fd,
> > > >                .flags =3D XFS_EXCHRANGE_TO_EOF,
> > > >            };
> > > >=20
> > > >            ioctl(fd, XFS_IOC_EXCHANGE_RANGE, &args);
> > > >=20
> > > >        The  second  is  a  software-defined  storage host (e.g. a d=
isk
> > > >        jukebox) which implements an atomic scatter-gather  write  c=
om=E2=80=90
> > > >        mand.   Provided the exported disk's logical block size matc=
hes
> > > >        the file's allocation unit size, this can be done by creatin=
g a
> > > >        temporary file and writing the data at the appropriate offse=
ts.
> > > >        It is recommended that the temporary file be truncated  to  =
the
> > > >        size  of  the  regular file before any writes are staged to =
the
> > > >        temporary file to avoid issues with zeroing during  EOF  ext=
en=E2=80=90
> > > >        sion.   Use  this  call with the FILE1_WRITTEN flag to excha=
nge
> > > >        only the file allocation units involved  in  the  emulated  =
de=E2=80=90
> > > >        vice's  write  command.  The temporary file should be trunca=
ted
> > > >        or punched out completely before being reused to stage  anot=
her
> > > >        write.
> > > >=20
> > > >        An example program might look like this:
> > > >=20
> > > >            int fd =3D open("/some/file", O_RDWR);
> > > >            int temp_fd =3D open("/some", O_TMPFILE | O_RDWR);
> > > >            struct stat sb;
> > > >            int blksz;
> > > >=20
> > > >            fstat(fd, &sb);
> > > >            blksz =3D sb.st_blksize;
> > > >=20
> > > >            /* land scatter gather writes between 100fsb and 500fsb =
*/
> > > >            pwrite(temp_fd, data1, blksz * 2, blksz * 100);
> > > >            pwrite(temp_fd, data2, blksz * 20, blksz * 480);
> > > >            pwrite(temp_fd, data3, blksz * 7, blksz * 257);
> > > >=20
> > > >            /* commit the entire update */
> > > >            struct xfs_exch_range args =3D {
> > > >                .file1_fd =3D temp_fd,
> > > >                .file1_offset =3D blksz * 100,
> > > >                .file2_offset =3D blksz * 100,
> > > >                .length       =3D blksz * 400,
> > > >                .flags        =3D XFS_EXCHRANGE_FILE1_WRITTEN |
> > > >                                XFS_EXCHRANGE_FILE1_DSYNC,
> > > >            };
> > > >=20
> > > >            ioctl(fd, XFS_IOC_EXCHANGE_RANGE, &args);
> > > >=20
> > > > NOTES
> > > >        Some  filesystems may limit the amount of data or the number=
 of
> > > >        extents that can be exchanged in a single call.
> > > >=20
> > > > SEE ALSO
> > > >        ioctl(2)
> > > >=20
> > > > XFS                           2024-02-10   IOCTL-XFS-EXCHANGE-RANGE=
(2)
> > > > IOCTL-XFS-COMMIT-RANGE(2) System Calls ManualIOCTL-XFS-COMMIT-RANGE=
(2)
> > > >=20
> > > > NAME
> > > >        ioctl_xfs_commit_range - conditionally exchange the contents=
 of
> > > >        parts of two files
> > > >=20
> > > > SYNOPSIS
> > > >        #include <sys/ioctl.h>
> > > >        #include <xfs/xfs_fs_staging.h>
> > > >=20
> > > >        int ioctl(int file2_fd, XFS_IOC_COMMIT_RANGE,  struct  xfs_c=
om=E2=80=90
> > > >        mit_range *arg);
> > > >=20
> > > > DESCRIPTION
> > > >        Given  a  range  of bytes in a first file file1_fd and a sec=
ond
> > > >        range of bytes in a second file  file2_fd,  this  ioctl(2)  =
ex=E2=80=90
> > > >        changes  the contents of the two ranges if file2_fd passes c=
er=E2=80=90
> > > >        tain freshness criteria.
> > > >=20
> > > >        After locking both files but before  exchanging  the  conten=
ts,
> > > >        the  supplied  file2_ino field must match file2_fd's inode n=
um=E2=80=90
> > > >        ber,   and   the   supplied   file2_mtime,    file2_mtime_ns=
ec,
> > > >        file2_ctime, and file2_ctime_nsec fields must match the modi=
fi=E2=80=90
> > > >        cation time and change time of file2.  If they  do  not  mat=
ch,
> > > >        EBUSY will be returned.
> > > >=20
> > >=20
> > > Maybe a stupid question, but under which circumstances would mtime
> > > change and ctime not change? Why are both needed?
> > >=20
> >=20
> > ctime should always change if the mtime does. An mtime update means tha=
t
> > the metadata was updated, so you also need to update the ctime.=20
>=20
> Exactly. :)
>=20
> > > And for a new API, wouldn't it be better to use change_cookie (a.k.a =
i_version)?
> > > Even if this API is designed to be hoisted out of XFS at some future =
time,
> > > Is there a real need to support it on filesystems that do not support
> > > i_version(?)
> > >=20
> > > Not to mention the fact that POSIX does not explicitly define how cti=
me should
> > > behave with changes to fiemap (uninitialized extent and all), so who =
knows
> > > how other filesystems may update ctime in those cases.
> > >=20
> > > I realize that STATX_CHANGE_COOKIE is currently kernel internal, but
> > > it seems that XFS_IOC_EXCHANGE_RANGE is a case where userspace
> > > really explicitly requests a bump of i_version on the next change.
> > >=20
> >=20
> >=20
> > I agree. Using an opaque change cookie would be a lot nicer from an API
> > standpoint, and shouldn't be subject to timestamp granularity issues.
>=20
> TLDR: No.
>=20
> > That said, XFS's change cookie is currently broken. Dave C. said he had
> > some patches in progress to fix that however.
>=20
> Dave says that about a lot of things.  I'm not willing to delay the
> online fsck project _even further_ for a bunch of vaporware that's not
> even out on linux-xfs for review.
>=20
> The difference in opinion between xfs and the rest of the kernel about
> i_version is 50% of why I didn't include it here.  The other 50% is the
> part where userspace can't access it, because I do not want to saddle my
> mostly internal project with YET ANOTHER ASK FROM RH PEOPLE FOR CORE
> CHANGES.

Ouch, point taken.

I just have grave concerns about using something as coarse-grained as
the  to gate changes to a file. With modern machines, a single timestamp
can represent a large number of different states of the file's contents.

Is that not a problem here?
--=20
Jeff Layton <jlayton@kernel.org>

