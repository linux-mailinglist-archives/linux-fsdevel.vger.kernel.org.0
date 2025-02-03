Return-Path: <linux-fsdevel+bounces-40672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B3FA26645
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 23:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABC316339C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA5520FA80;
	Mon,  3 Feb 2025 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjElYM2T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2411E1FECC5;
	Mon,  3 Feb 2025 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738620003; cv=none; b=cXrkBxunqg4XJrUaYZZjBybQ5Adv5Ww/cyE63qV8ONRJt881flaWwtV998ebC8x5CBGWFGtW874DUnMFTnPbVvNxAZWlqkNTVGpd9r6+eH0XXRe3P+NtV+M4HnePHJY7sfVdaZXsPvlImayvDsdvmwsmIxis8LeyaB7kIt8ZdA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738620003; c=relaxed/simple;
	bh=nKbdvlknh9xvuHEj2EHobhDIpXP98S9iujf6sQqrlzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORHtf0EojqY2+aXDH1/IOV8ZAhR9i7N2+yVHFpHlfIdNj814PUJv8kHj9waSC50wRuXbyBQqJmz03ZGX0iiQPYUYnn4MK9bgAn+oIEoN9AhgH/K94qdI6QmwF17e2To1MkCJHX1GGVmcMcAEPu8h9W33smR+dLiOAWjlp7kiZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjElYM2T; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so7843077a12.1;
        Mon, 03 Feb 2025 14:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738619999; x=1739224799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtsGW9PB1wpCiIIPEt1wXd6qbNcB38wF7JGWRe3Braw=;
        b=FjElYM2T6BfBoRrNEr8gCXWwbCmppsgjV+7dqXRYWccQlzWXkoxGLk7KXZ90RfW8UR
         frQgPtAuHmh1osScX5Y3o114R6/31m1KJIkvnjdYn8beYXdkz7frh6ESyMWeuhLoZcpB
         A1GiuYAQvb733TnmlW28OBfBrIo2zIZ6pN3g7xYxeda4Vge2SZ27OraqRz8hb6eH3vlW
         RTikJq5vF9FDQzpetiJILWTjQoy5j1scHv7Z0nxg3Fsia8XycuAYJZ318autuZEfXt1f
         at6NMCXohwd5evaLh++cUV71ilIqAIUL5eTNY9k1t7ckpFghvZLi56W4tngK427TV8Lb
         tCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738619999; x=1739224799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtsGW9PB1wpCiIIPEt1wXd6qbNcB38wF7JGWRe3Braw=;
        b=bGAvKlJI+kHNLwkQBuKJ7Ik/rw7xpjABN3zVbYU0ftgNbRq09JEoipFvSEqhbdMtJc
         /fo/KTw6p05MN3CjGjNyghLBdrGs18PDryBJvP1eDnMb0wdgsXMDBIzO9e5rhtfylESs
         VB+KPDC/xXV6vMuGadfLHk5rTnxE13WJrZnQPml+ptX/Wqkv+DW/q13pSrjvp6ebZzMb
         CbO7KRRftHINxBP1oeJZp8txrFAJGMVbwNZ3yFuuMrKzBGscEPtBJBMlq14DV3G2M/u/
         bU5dZlwjtwYuXtOt831fXMDgQqAKaoZ9c2GMrWmTiQoy/9muYniDOS+2wW0iGik7DX63
         ONpg==
X-Forwarded-Encrypted: i=1; AJvYcCVF1TrExf3rjzDeQELlpbZgXZ50YagKJ91y9pCqmJbqaPn2v3pyDP5uYOOikx4RCbjbWbMrfFuORNqy0I35Rg==@vger.kernel.org, AJvYcCWLqOWURR2GFX4G+eOp+LcRCOVhVVxwWByHPpLJINQOpnekeZdj1lmlXQS+gHST2qRe7jvZHKp4JzKWABub@vger.kernel.org, AJvYcCX88NaR7F2CAMBcXNBp5gxerbsE95nJxf6IL50KrEAoo0T3wLsgQ1xzFeNgUuiYoLQyxXYZBQWVxMoz@vger.kernel.org
X-Gm-Message-State: AOJu0YxUmngXp4XnsaNF9t3eamBiHZGZwhRjxmcX1Dxhx8zER/VEwBeH
	4L95N20SaSHjVbkpXZ1vFLwfd7cp3yAAGFnknYO1m0856H+c/F0SQg5P+MaTUQmgONf9NalYKXB
	nebIoMbyR9l3Gm7cTXMEEfhxAq7s=
X-Gm-Gg: ASbGncszjXwDODb1Q2Gb34MZat1ZUH8/y2XZqST8ieCT7XrIFvoSo0mlRiyhcsWrcdL
	Sq6aw1YcAq2MjpzlmbOGUVQmTRwQxNGXgSPT6XWjEA17ro0VKlmSedCW3us3MFatbGeNedVWl
X-Google-Smtp-Source: AGHT+IE0KNpGmPjxMRKW7eAgI8PDwZGzZJy+s1RFjEaudwm4Ci/el7pY+Fb3fUoUosAWpev3xlHPenZ8UXSKhWChZtE=
X-Received: by 2002:a05:6402:e96:b0:5dc:74f1:8a32 with SMTP id
 4fb4d7f45d1cf-5dc74f18bebmr19468036a12.28.1738619998707; Mon, 03 Feb 2025
 13:59:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114211050.iwvxh7fon7as7sty@pali> <0659dfe1-e160-40fd-b95a-5d319ca3504f@oracle.com>
 <20250114215350.gkc2e2kcovj43hk7@pali> <CAN05THSXjmVtvYdFLB67kKOwGN5jsAiihtX57G=HT7fBb62yEw@mail.gmail.com>
 <20250114235547.ncqaqcslerandjwf@pali> <20250114235925.GC3561231@frogsfrogsfrogs>
 <CAOQ4uxjj3XUNh6p3LLp_4YCJQ+cQHu7dj8uM3gCiU61L3CQRpA@mail.gmail.com>
 <20250117173900.GN3557553@frogsfrogsfrogs> <CAOQ4uxhh1LDz5zXzqFENPhJ9k851AL3E7Xc2d7pSVVYX4Fu9Jw@mail.gmail.com>
 <20250117185947.ylums2dhmo3j6hol@pali> <20250202152343.ahy4hnzbfuzreirz@pali>
In-Reply-To: <20250202152343.ahy4hnzbfuzreirz@pali>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 3 Feb 2025 22:59:46 +0100
X-Gm-Features: AWEUYZkxitPsbJ_xWnv6ezksvTaV6VVg1DBYY48BrZ4ODZ3H29B40-qR5P69PMs
Message-ID: <CAOQ4uxgjbHTyQ53u=abWhyQ81ATL4cqSeWKDfOjz-EaR0NGmug@mail.gmail.com>
Subject: Re: Immutable vs read-only for Windows compatibility
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 4:23=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> wr=
ote:
>
> On Friday 17 January 2025 19:59:47 Pali Roh=C3=A1r wrote:
> > On Friday 17 January 2025 19:46:30 Amir Goldstein wrote:
> > > > > Looking at the FILE_ATTRIBUTE_* flags defined in SMB protocol
> > > > >  (fs/smb/common/smb2pdu.h) I wonder how many of them will be
> > > > > needed for applications beyond the obvious ones that were listed.
> > > >
> > > > Well they only asked for seven of them. ;)
> > > >
> > > > I chatted with Ted about this yesterday, and ... some of the attrib=
utes
> > > > (like read only) imply that you'd want the linux server to enforce =
no
> > > > writing to the file; some like archive seem a little superfluous si=
nce
> > > > on linux you can compare cmtime from the backup against what's in t=
he
> > > > file now; and still others (like hidden/system) might just be some =
dorky
> > > > thing that could be hidden in some xattr because a unix filesystem =
won't
> > > > care.
> > > >
> > > > And then there are other attrs like "integrity stream" where someon=
e
> > > > with more experience with windows would have to tell me if fsverity
> > > > provides sufficient behaviors or not.
> > > >
> > > > But maybe we should start by plumbing one of those bits in?  I gues=
s the
> > > > gross part is that implies an ondisk inode format change or (gross)
> > > > xattr lookups in the open path.
> > > >
> > >
> > > I may be wrong, but I think there is a confusion in this thread.
> > > I don't think that Pali was looking for filesystems to implement
> > > storing those attributes. I read his email as a request to standardiz=
e
> > > a user API to get/set those attributes for the filesystems that
> > > already support them and possibly for vfs to enforce some of them
> > > (e.g. READONLY) in generic code.
> >
> > Yes, you understood it correctly. I was asking for standardizing API ho=
w
> > to get/set these attributes from userspace. And Chuck wrote that would
> > like to have also standardized it for kernel consumers like nfsd or
> > ksmbd. Which makes sense.
> >
> > > Nevertheless, I understand the confusion because I know there
> > > is also demand for storing those attributes by file servers in a
> > > standard way and for vfs to respect those attributes on the host.
> >
> > Userspace fileserver, like Samba, would just use that standardized
> > userspace API for get/set attributes. And in-kernel fileservers like
> > nfsd or ksmbd would like to use that API too.
> >
> > And there were some proposals how filesystems without native
> > support for these attributes could store and preserve these attributes.
> > So this can be a confusion in this email thread discussion.
>
> So to recap, for set-API there are possible options:
>
> 1) extending FS_IOC_FSSETXATTR / FS_IOC_SETFLAGS for each individual bit
>
> 2) creating one new xattr in system namespace which will contain all bit
>    flags in one structure
>
> 3) creating new xattr in system namespace for each individual flag
>
> Disadvantages for option 1) is that "cp -a" or "rsync -a" does not
> preserve them. If in option 2) or 3) those xattrs would be visible in
> listxattr() call then this can be advantage, as all flags are properly
> preserved when doing "archive" backup.
>
> Do you have any preference which of those options should be used?
>

Darrick said in this thread twice:
statx/FS_IOC_FSGETXATTR to retrieve and FS_IOC_FSSETXATTR to set.
(NOT FS_IOC_SETFLAGS)
and I wrote that I agree with him.

I suggest that you let go of the cp -a out-of-the-box requirement.
It is not going to pass muster - maybe for a specific filesystem but
as a filesystem agnostic feature, unless you change cp tool.

>
> And how many bit flags are needed? I have done some investigation. Lets
> start with table which describes all 32 possible bit flags which are
> used by Windows system and also by filesystems FAT / exFAT / NTFS / ReFS
> and also by SMB over network:
>
> bit / attrib.exe flag / SDK constant / description
>
>  0 - R - FILE_ATTRIBUTE_READONLY              - writing to file or deleti=
ng it is disallowed
>  1 - H - FILE_ATTRIBUTE_HIDDEN                - inode is hidden
>  2 - S - FILE_ATTRIBUTE_SYSTEM                - inode is part of operatin=
g system
>  3 -   - FILE_ATTRIBUTE_VOLUME                - inode is the disk volume =
label entry
>  4 -   - FILE_ATTRIBUTE_DIRECTORY             - inode is directory
>  5 - A - FILE_ATTRIBUTE_ARCHIVE               - inode was not archived ye=
t (when set)
>  6 -   - FILE_ATTRIBUTE_DEVICE                - inode represents  in-memo=
ry device (e.g. C:\), flag not stored on filesystem
>  7 -   - FILE_ATTRIBUTE_NORMAL                - no other flag is set (val=
ue 0 means to not change flags, bit 7 means to clear all flags)
>  8 -   - FILE_ATTRIBUTE_TEMPORARY             - inode data do not have to=
 be flushed to disk
>  9 -   - FILE_ATTRIBUTE_SPARSE_FILE           - file is sparse with holes
> 10 -   - FILE_ATTRIBUTE_REPARSE_POINT         - inode has attached repars=
e point (symlink is also reparse point)
> 11 -   - FILE_ATTRIBUTE_COMPRESSED            - file is compressed, for d=
irectories it means that newly created inodes would have this flag set
> 12 - O - FILE_ATTRIBUTE_OFFLINE               - HSM - inode is used by HS=
M
> 13 - I - FILE_ATTRIBUTE_NOT_CONTENT_INDEXED   - inode will not be indexed=
 by content indexing service
> 14 -   - FILE_ATTRIBUTE_ENCRYPTED             - file is encrypted, for di=
rectories it means that newly created inodes would have this flag set
> 15 - V - FILE_ATTRIBUTE_INTEGRITY_STREAM      - fs does checksumming of d=
ata and metadata when reading inode, read-only
> 16 -   - FILE_ATTRIBUTE_VIRTUAL               - inode is in %LocalAppData=
%\VirtualStore, flag not stored on filesystem
> 17 - X - FILE_ATTRIBUTE_NO_SCRUB_DATA         - do not use scrubber (proa=
ctive background data integrity scanner) on this file, for directories it m=
eans that newly created inodes would have this flag set
> 18 -   - FILE_ATTRIBUTE_EA                    - inode has xattrs, (not in=
 readdir output, shares same bit with FILE_ATTRIBUTE_RECALL_ON_OPEN)
> 18 -   - FILE_ATTRIBUTE_RECALL_ON_OPEN        - HSM - inode is not stored=
 locally (only in readdir output, shares same bit with FILE_ATTRIBUTE_EA)
> 19 - P - FILE_ATTRIBUTE_PINNED                - HSM - inode data content =
must be always stored on locally
> 20 - U - FILE_ATTRIBUTE_UNPINNED              - HSM - inode data content =
can be removed from local storage
> 21 -   -                                      - reserved
> 22 -   - FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS - HSM - inode data content =
is not stored locally
> 23 -   -                                      - reserved
> 24 -   -                                      - reserved
> 25 -   -                                      - reserved
> 26 -   -                                      - reserved
> 27 -   -                                      - reserved
> 28 -   -                                      - reserved
> 29 - B - FILE_ATTRIBUTE_STRICTLY_SEQUENTIAL   - SMR Blob, unknown meaning=
, read-only
> 30 -   -                                      - reserved
> 31 -   -                                      - reserved
>

I suspect that we need to reserve expansion for more than 7 bits if we
design a proper API.
The fsx_xflags field is already too crowded for adding so many flags
We can use the padding at the end of fsxattr to add __u32 fsx_dosattrib
or fsx_dosflags field.

> (HSM means Hierarchical Storage Management software, which uses reparse
> points to make some remote file/folder available on the local
> filesystem, for example OneDrive or DropBox)
>

I am quite interested in supporting those HSM flags for fanotify.

> From above list only following bit flags are suitable for modification
> over some Linux API:
> - FILE_ATTRIBUTE_READONLY
> - FILE_ATTRIBUTE_HIDDEN
> - FILE_ATTRIBUTE_SYSTEM
> - FILE_ATTRIBUTE_ARCHIVE
> - FILE_ATTRIBUTE_TEMPORARY
> - FILE_ATTRIBUTE_COMPRESSED
> - FILE_ATTRIBUTE_OFFLINE
> - FILE_ATTRIBUTE_NOT_CONTENT_INDEXED
> - FILE_ATTRIBUTE_ENCRYPTED
> - FILE_ATTRIBUTE_NO_SCRUB_DATA
> - FILE_ATTRIBUTE_PINNED
> - FILE_ATTRIBUTE_UNPINNED
>
> And if I'm looking correctly the FILE_ATTRIBUTE_COMPRESSED can be
> already mapped to Linux FS_COMPR_FL / STATX_ATTR_COMPRESSED, which has
> same meaning. Also FILE_ATTRIBUTE_ENCRYPTED can be mapped to
> FS_ENCRYPT_FL / STATX_ATTR_ENCRYPTED. Note that these two flags cannot
> be set over WinAPI or SMB directly and it is required to use special
> WinAPI or SMB ioctl.
>

There is a standard way to map from fileattr::flags
to fileattr::fsx_xflags, so that you could set/get COMPR,ENCRYPT using
FS_IOC_FS[GS]ETXATTR ioctl.
see fileattr_fill_flags/fileattr_fill_xflags.
but I think that xfs_fileattr_set() will need to have a supported xflags ma=
sk
check if you start adding xflags that xfs does not currently support and
other filesystems do support.

> So totally are needed 10 new bit flags. And for future there are 9
> reserved bits which could be introduced by MS in future.
>
> Additionally there are get-only attributes which can be useful for statx
> purposes (for example exported by cifs.ko SMB client):
> - FILE_ATTRIBUTE_REPARSE_POINT
> - FILE_ATTRIBUTE_INTEGRITY_STREAM
> - FILE_ATTRIBUTE_RECALL_ON_OPEN
> - FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS
> - FILE_ATTRIBUTE_STRICTLY_SEQUENTIAL
>
> From the above list of flags suitable for modification, following bit
> flags have no meaning for kernel and it is up to userspace how will use
> them. What is needed from kernel and/or filesystem driver is to preserve
> those bit flags.
> - FILE_ATTRIBUTE_HIDDEN
> - FILE_ATTRIBUTE_SYSTEM
> - FILE_ATTRIBUTE_ARCHIVE
> - FILE_ATTRIBUTE_NOT_CONTENT_INDEXED
>
> Following are bit flags which kernel / VFS / fsdriver would have to
> handle specially, to provide enforcement or correct behavior of them:
> - FILE_ATTRIBUTE_READONLY - enforce that data modification or unlink is d=
isallowed when set
> - FILE_ATTRIBUTE_COMPRESSED - enforce compression on filesystem when set
> - FILE_ATTRIBUTE_ENCRYPTED - enforce encryption on filesystem when set
>
> Then there are HSM flags which for local filesystem would need some
> cooperation with userspace synchronization software. For network
> filesystems (SMB / NFS4) they need nothing special, just properly
> propagating them over network:
> - FILE_ATTRIBUTE_OFFLINE
> - FILE_ATTRIBUTE_PINNED
> - FILE_ATTRIBUTE_UNPINNED
>
> About following 2 flags, I'm not sure if the kernel / VFS / fs driver
> has to do something or it can just store bits to fs:
> - FILE_ATTRIBUTE_TEMPORARY
> - FILE_ATTRIBUTE_NO_SCRUB_DATA
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> And there is still unresolved issue with FILE_ATTRIBUTE_READONLY.
> Its meaning is similar to existing Linux FS_IMMUTABLE_FL, just
> FILE_ATTRIBUTE_READONLY does not require root / CAP_LINUX_IMMUTABLE.
>
> I think that for proper support, to enforce FILE_ATTRIBUTE_READONLY
> functionality, it is needed to introduce new flag e.g.
> FS_IMMUTABLE_FL_USER to allow setting / clearing it also for normal
> users without CAP_LINUX_IMMUTABLE. Otherwise it would be unsuitable for
> any SMB client, SMB server or any application which would like to use
> it, for example wine.
>
> Just to note that FreeBSD has two immutable flags SF_IMMUTABLE and
> UF_IMMUTABLE, one settable only by superuser and second for owner.
>
> Any opinion?

For filesystems that already support FILE_ATTRIBUTE_READONLY,
can't you just set S_IMMUTABLE on the inode and vfs will do the correct
enforcement?

The vfs does not control if and how S_IMMUTABLE is set by filesystems,
so if you want to remove this vfs flag without CAP_LINUX_IMMUTABLE
in smb client, there is nothing stopping you (I think).

How about tackling this one small step at a time, not in that order
necessarily:

1. Implement the standard API with FS_IOC_FS[GS]ETXATTR ioctl
    and with statx to get/set some non-controversial dosattrib flags on
    ntfs/smb/vfat
2. Wire some interesting dosattrib flags (e.g. compr/enrypt) to local
    filesystems that already support storing those bits
3. Wire network servers (e.g. Samba) to use the generic API if supported
4. Add on-disk support for storing the dosattrib flags to more local fs
5. Update S_IMMUTABLE inode flag if either FS_XFLAG_IMMUTABLE
    or FS_DOSATTRIB_READONLY are set on the file

Thoughts?

Thanks,
Amir.

