Return-Path: <linux-fsdevel+bounces-40731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E833A270AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067DF163DBC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF13420D4E5;
	Tue,  4 Feb 2025 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx5ryWCT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8320B1EF;
	Tue,  4 Feb 2025 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670058; cv=none; b=J2Bxv2y+Qz8LffOcqvG2n1xKb+UmBH/SjeKWrP1SFI3oVJiX7GAhHAkWd0eF+stBtsiPvOV89hyqVNTMEKFhOpkxXGzxpUJgDPVc1xzm0UPEXyMsO5pb6+CZ/30mqiQfU9ZOj/afpTm+GUwlGgFhx7Pk8Hm3Coolp4ZF0IzieY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670058; c=relaxed/simple;
	bh=+G4mNhWiT+ci4rOxyjFZNtFgtURnGmod8bMP6KgZgt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/hj5prqfDkMcI6M6K5mA0VxROlBIFmplFbPdh7PpaDKvFc/mtwGC3xRrsJgejMoAnCE2YMP+96oS8TfIlhYU1IMZSzBMmQGV3ktU1y5eEnlHtQBTVa8R9S08j1TsO70sb0FhkjB03bBtjAr/oml5kzJTn66IPqsFrIOo1hUb4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx5ryWCT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso12137948a12.0;
        Tue, 04 Feb 2025 03:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738670054; x=1739274854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpelHPSpUyZCtriaXRTxy2mndPsQGy5YQitEVsIDiHI=;
        b=fx5ryWCTXXs9sDtiU9MOt+8o+cDnMEdjpoksg0dg/Up2F0tLDFdj7h50FKJWYEEUdj
         v9Lj7a9r2pDIz+gRN+O7G0h8/TzNqhXRPyGIWbCa4096Z8oRLtMTbrcEQkvh+Smf5974
         o3IvuDc325ojiVtNrAbmBUdIoC5/A1eXwRP6hUUpcAGG8+lqUjJR6I04OHbfRljD+G25
         J9iAZYW7jqCishkuzKqbp8/cp2N0e6aYKUsLNetLUmMyamAJSpFLHX2jjEkk3HvBss82
         iIXJLogROdjyxM2eOOU4zGJxn/aMRhBny57tDJl7fgt8YqyNivlXrWWTxqxE1/+1yVRp
         s+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738670054; x=1739274854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpelHPSpUyZCtriaXRTxy2mndPsQGy5YQitEVsIDiHI=;
        b=dlXQ9G5QEeayq1Upyga8GuDe7miGj8FXzmmo7o91RGwMPLOXQEK+MjBxQ1KDso3xjJ
         qkVqahq/qulafqtpp9nx9cSEgaMJv4AcbyywExQfEAbqi0WvFj4ua0IYqKkzy9ALCJvV
         jrjW3dexmyVI0EUHPqmhYY+WEkKvK166X0v3GZuINR6iXH3tzozQNyr5aD18Lf5n9FBC
         kaHBbHxV17TLkLbqjgdhB7AynehH7HwDUejudvA23vZjwGGPxBqidxYb9aLpo0Svlavs
         UeAkt98cpA7QN7iruqtki6xTvJ9q+aSOZ7L4wvSbZvwTE3sgh9+1hTxseEiVdr08GU5W
         87eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbi4reqAP3rJVsrZwjgBSnP+aUyh6jwG9Ky6n3pGKW/9+mfMHwNy7wPp2N6T3d7I2Lv5mVzBE53rDQ5Zalhg==@vger.kernel.org, AJvYcCVSXWLLnvjUWsA9gWtgt/8PaDbJPRRq9vbZbBGgIvrU/Mr5gaR0xJv0kgErxVOrb2kDSb5gllWOZJqCzelD@vger.kernel.org, AJvYcCXohO6o2hsoJGWxd1M+2mh7rIc8XSh65E+HRg3S1oaPzuiSTT+15N6M5MexKZsbj0+nRA13/IYzauxp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4yMRU7C5e15I0VRRD05jotFAMpeyw1EP8FKzvyroSoISVHnf8
	jz0bPrrQTHX+No5xuC02q8dSYmzpLkHT0c2dkGyuiv8oQ7MO1MBusTo5iHTQK6qCUV4ibr/uxBi
	3b/tJtaAWuVwFl9YpHXz4qa3l3AX9BPSLYEM=
X-Gm-Gg: ASbGnctwr4R5YNsCelexzM5gn1lVOp1pCeSsKlxneJAy6EZCSPfGxiR6YNsAu2oDL+8
	cPK82riZSnHurafcJXzKCbtcb8ad2HUgraAVFAaGp4qN5BE1gEOP7fVLghczvM/VVzU2xjf72
X-Google-Smtp-Source: AGHT+IH68WMlSMfCAZbeBbjciGK7DT0WNd60UdpYf9jvwEdRXuFku9AMwYwEvXzVcRY6St6682JOqGQ7uzpkESF78lk=
X-Received: by 2002:a17:907:97c8:b0:ab7:462d:77a5 with SMTP id
 a640c23a62f3a-ab7483f9eecmr296200266b.7.1738670053665; Tue, 04 Feb 2025
 03:54:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114235547.ncqaqcslerandjwf@pali> <20250114235925.GC3561231@frogsfrogsfrogs>
 <CAOQ4uxjj3XUNh6p3LLp_4YCJQ+cQHu7dj8uM3gCiU61L3CQRpA@mail.gmail.com>
 <20250117173900.GN3557553@frogsfrogsfrogs> <CAOQ4uxhh1LDz5zXzqFENPhJ9k851AL3E7Xc2d7pSVVYX4Fu9Jw@mail.gmail.com>
 <20250117185947.ylums2dhmo3j6hol@pali> <20250202152343.ahy4hnzbfuzreirz@pali>
 <CAOQ4uxgjbHTyQ53u=abWhyQ81ATL4cqSeWKDfOjz-EaR0NGmug@mail.gmail.com>
 <20250203221955.bgvlkp273o3wnzmf@pali> <CAOQ4uxhkB6oTJm7DvQxFbxkQ1u_KMUFEL0eWKVYf39hnuYrnfQ@mail.gmail.com>
 <20250203233403.5a5pcgl5xylj47nb@pali>
In-Reply-To: <20250203233403.5a5pcgl5xylj47nb@pali>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 4 Feb 2025 12:54:01 +0100
X-Gm-Features: AWEUYZnbC7klBvozKl8s6Znx3JkOPgc5GrWX3NBv4QmDXiATtidNp0zL3l-uoyk
Message-ID: <CAOQ4uxisXgDOuE1oDH6qtLYoiFeG55kjpUJaXDxZ+tp2ck++Sg@mail.gmail.com>
Subject: Re: Immutable vs read-only for Windows compatibility
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 12:34=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> On Tuesday 04 February 2025 00:02:44 Amir Goldstein wrote:
> > On Mon, Feb 3, 2025 at 11:20=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.or=
g> wrote:
> > >
> > > On Monday 03 February 2025 22:59:46 Amir Goldstein wrote:
> > > > On Sun, Feb 2, 2025 at 4:23=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel=
.org> wrote:
> > > > > And there is still unresolved issue with FILE_ATTRIBUTE_READONLY.
> > > > > Its meaning is similar to existing Linux FS_IMMUTABLE_FL, just
> > > > > FILE_ATTRIBUTE_READONLY does not require root / CAP_LINUX_IMMUTAB=
LE.
> > > > >
> > > > > I think that for proper support, to enforce FILE_ATTRIBUTE_READON=
LY
> > > > > functionality, it is needed to introduce new flag e.g.
> > > > > FS_IMMUTABLE_FL_USER to allow setting / clearing it also for norm=
al
> > > > > users without CAP_LINUX_IMMUTABLE. Otherwise it would be unsuitab=
le for
> > > > > any SMB client, SMB server or any application which would like to=
 use
> > > > > it, for example wine.
> > > > >
> > > > > Just to note that FreeBSD has two immutable flags SF_IMMUTABLE an=
d
> > > > > UF_IMMUTABLE, one settable only by superuser and second for owner=
.
> > > > >
> > > > > Any opinion?
> > > >
> > > > For filesystems that already support FILE_ATTRIBUTE_READONLY,
> > > > can't you just set S_IMMUTABLE on the inode and vfs will do the cor=
rect
> > > > enforcement?
> > > >
> > > > The vfs does not control if and how S_IMMUTABLE is set by filesyste=
ms,
> > > > so if you want to remove this vfs flag without CAP_LINUX_IMMUTABLE
> > > > in smb client, there is nothing stopping you (I think).
> > >
> > > Function fileattr_set_prepare() checks for CAP_LINUX_IMMUTABLE when
> > > trying to change FS_IMMUTABLE_FL bit. This function is called from
> > > ioctl(FS_IOC_SETFLAGS) and also from ioctl(FS_IOC_FSSETXATTR).
> > > And when function fileattr_set_prepare() fails then .fileattr_set
> > > callback is not called at all. So I think that it is not possible to
> > > remove the IMMUTABLE flag from userspace without capability for smb
> > > client.
> > >
> >
> > You did not understand what I meant.
> >
> > You cannot relax the CAP_LINUX_IMMUTABLE for setting FS_IMMUTABLE_FL
> > and there is no reason that you will need to relax it.
> >
> > The vfs does NOT enforce permissions according to FS_IMMUTABLE_FL
> > The vfs enforces permissions according to the S_IMMUTABLE in-memory
> > inode flag.
> >
> > There is no generic vfs code that sets S_IMMUTABLE inode flags, its
> > the filesystems that translate the on-disk FS_IMMUTABLE_FL to
> > in-memory S_IMMUTABLE inode flag.
> >
> > So if a filesystem already has an internal DOSATTRIB flags set, this
> > filesystem can set the in-memory S_IMMUTABLE inode flag according
> > to its knowledge of the DOSATTRIB_READONLY flag and the
> > CAP_LINUX_IMMUTABLE rules do not apply to the DOSATTRIB_READONLY
> > flag, which is NOT the same as the FS_IMMUTABLE_FL flag.
> >
> > > And it would not solve this problem for local filesystems (ntfs or ex=
t4)
> > > when Samba server or wine would want to set this bit.
> > >
> >
> > The Samba server would use the FS_IOC_FS[GS]ETXATTR ioctl
> > API to get/set dosattrib, something like this:
> >
> > struct fsxattr fsxattr;
> > ret =3D ioctl_get_fsxattr(fd, &fsxattr);
> > if (!ret && fsxattr.fsx_xflags & FS_XFLAG_HASDOSATTR) {
> >     fsxattr.fsx_dosattr |=3D fs_dosattrib_readonly;
> >     ret =3D ioctl_set_fsxattr(fd, &fsxattr);
> > }
>
> Thanks for more explanation. First time I really did not understood it.
> But now I think I understood it. So basically there would be two flags
> which would result in setting S_IMMUTABLE on inode. One is the existing
> FS_IMMUTABLE_FL which requires the capability and some new flag (e.g.
> FS_XFLAG_HASDOSATTR) which would not require it and can be implemented
> for cifs, vfat, ntfs, ... Right?
>

Well, almost right.
The flag that would correspond to FILE_ATTRIBUTE_READONLY
is FS_DOSATTRIB_READONLY from the new field fsx_dosattrib
(see below)

--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -145,7 +145,8 @@ struct fsxattr {
        __u32           fsx_nextents;   /* nextents field value (get)   */
        __u32           fsx_projid;     /* project identifier (get/set) */
        __u32           fsx_cowextsize; /* CoW extsize field value (get/set=
)*/
-       unsigned char   fsx_pad[8];
+       __u32           fsx_dosattrib;  /* dosattrib field value (get/set) =
*/
+       unsigned char   fsx_pad[4];
 };

 /*
@@ -167,7 +168,16 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM    0x00004000      /* use filestream allocator=
 */
 #define FS_XFLAG_DAX           0x00008000      /* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE    0x00010000      /* CoW extent size
allocator hint */
-#define FS_XFLAG_HASATTR       0x80000000      /* no DIFLAG for this   */
+#define FS_XFLAG_HASATTR       0x80000000      /* has extended attributes =
*/
+
+/*
+ * Flags for the fsx_dosattrib field
+ */
+#define FS_DOSATTRIB_READONLY  0x00000001      /* R - read-only */
+#define FS_DOSATTRIB_HIDDEN    0x00000002      /* H - hidden */
+#define FS_DOSATTRIB_SYSTEM    0x00000004      /* S - system */
+#define FS_DOSATTRIB_ARCHIVE   0x00000020      /* A - archive */
+#define FS_DOSATTRIB_HASATTR   0x80000000      /* has dos attributes */

This last special flag is debatable and I am not really sure that we need i=
t.

It is needed for proper backward compat with existing userspace tools.
For example, if there was a backup tool storing the fsxattr blob result of
FS_IOC_FSGETXATTR and sets it later during restore with
FS_IOC_FSSETXATTR, then it would be better to ignore a zero
value of fsx_dosattrib instead of resetting all of the on-disk dosattrib fl=
ags
if the restore happens after ntfs gained support for setting dosattrib flag=
s
via FS_IOC_FSSETXATTR.

When using the standard tools to set fsxattr (chattr and xfs_io -c chattr)
the tool does FS_IOC_FSGETXATTR + modify + FS_IOC_FSSETXATTR,
so those tools are expected to leave new bits in fsx_dosattrib at their
value if ntfs gains support for get/set fsx_dosattrib.

Setting the auxiliary FS_DOSATTRIB_HASATTR flag can help the
kernel/fs to explicitly state that the values returned in fsx_dosattrib
are valid and the tool to state that values set in fsx_dosattrib are valid.
But using a single flag will not help expanding ntfs support for more
fsx_dosattrib flags later, so I am not sure if it is useful (?).


> > For ntfs/ext4, you will need to implement on-disk support for
> > set/get the dosattrib flags.
>
> ntfs has already on-disk support for FILE_ATTRIBUTE_READONLY.
>

This is interesting.

fat/ntfs both already have a mount option sys_immutable to map
FILE_ATTRIBUTE_SYSTEM to S_IMMUTABLE in-memory.

fat does not support fileattr_set(), but has a proprietary ioctl
FAT_IOCTL_SET_ATTRIBUTES which enforces
CAP_LINUX_IMMUTABLE for changing S_IMMUTABLE.

ntfs also maps FILE_ATTRIBUTE_SYSTEM to S_IMMUTABLE
and it allows changing FILE_ATTRIBUTE_SYSTEM via ntfs_setxattr
of system.{dos,ntfs}_attrib without enforcing CAP_LINUX_IMMUTABLE,
or any other permissions at all (?)
This does not change S_IMMUTABLE in-memory, so change will
only apply on the next time inode is loaded from disk.
Bottom line: seems like *any user at all* can change the READONLY
and SYSTEM attributes on ntfs.

OTOH, ntfs does support fileattr_set() - it allows changing
S_IMMUTABLE and S_APPEND in-memory, but as far as I can
tell, this change is not stored on-disk (?).

Also in ntfs, FILE_ATTRIBUTE_READONLY is mapped
to not having posix write permissions on-disk:
                /* Linux 'w' -> Windows 'ro'. */
                if (0222 & inode->i_mode)
                        ni->std_fa &=3D ~FILE_ATTRIBUTE_READONLY;
                else
                        ni->std_fa |=3D FILE_ATTRIBUTE_READONLY;

So for ntfs, S_IMMUTABLE could be updated depending on three
independent flags: SYSTEM, READONLY and  FS_XFLAG_IMMUTABLE.

Having ntfs treat FILE_ATTRIBUTE_READONLY as S_IMMUTABLE
internally, is completely confined to ntfs and has nothing to do with vfs
or with a new standard API.

> On-disk support for ext4 and other linux filesystems can be discussed
> later. I think that this could be more controversial.
>

Obviously there are existing users that need this.
Samba has its own xattr user.DOSATTRIB and if people really want
to be able to export those attributes in a standard way, I doubt there
will be objection to adding on-disk support (e.g. to ext4/xfs).
But somebody has to do the work and adding new on-disk support
is not so easy.

I can help with that when the time comes.
First thing first, try to propose patches to extend fsx_dosattrib and
support them in ntfs/fat/smb.

> > I can certainly not change the meaning of existing on-disk
> > flag of FS_IMMUTABLE_FL to a flag that can be removed
> > without CAP_LINUX_IMMUTABLE. that changes the meaning
> > of the flag.
> >
> > If ext4 maintainers agrees, you may be able to reuse some
> > old unused on-disk flags (e.g.  EXT4_UNRM_FL) as storage
> > place for FS_DOSATTRIB_READONLY, but that would be
> > quite hackish.
> >
> > > > How about tackling this one small step at a time, not in that order
> > > > necessarily:
> > > >
> > > > 1. Implement the standard API with FS_IOC_FS[GS]ETXATTR ioctl
> > > >     and with statx to get/set some non-controversial dosattrib flag=
s on
> > > >     ntfs/smb/vfat
> > > > 2. Wire some interesting dosattrib flags (e.g. compr/enrypt) to loc=
al
> > > >     filesystems that already support storing those bits
> > > > 3. Wire network servers (e.g. Samba) to use the generic API if supp=
orted
> > > > 4. Add on-disk support for storing the dosattrib flags to more loca=
l fs
> > > > 5. Update S_IMMUTABLE inode flag if either FS_XFLAG_IMMUTABLE
> > > >     or FS_DOSATTRIB_READONLY are set on the file
> > > >
> > > > Thoughts?
> > > >
> >
> > Anything wrong with the plan above?
> > It seems that you are looking for shortcuts and I don't think that
> > it is a good way to make progress.
> >
> > Thanks,
> > Amir.
>
> If other developers agree that the FS_IOC_FS[GS]ETXATTR ioctl is the
> right direction then for me it looks good.

This thread has been going on for a while.
I did not see any objections to this idea that Darrick proposed,
so I think next step for you is to post patches, because some
developers will only engage when there are patches to discuss.

Thanks,
Amir.

