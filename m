Return-Path: <linux-fsdevel+bounces-39503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778B4A15500
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 17:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A16188A1E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 16:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFE61A23AF;
	Fri, 17 Jan 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuTtOgMg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C412B19F47E;
	Fri, 17 Jan 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132832; cv=none; b=li/plrFHHPZeT3W8AWOC04BospvDnsmCdUEUw2z3HZU5YzHMb2XyzfPiSd9RoVSshx7sJKdtK663aQtyIny0DGLl5bGtApG2DRlJiNz4rqwlo1oGa2WSSvpaWEWyURPyX4Z6vwmbdqN4Y7DTBVY9ZYUhknx3lmFhLmxcDemb0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132832; c=relaxed/simple;
	bh=hmaLS8kuDGNmqGOs7pm8xleBcHE16IVKOzPXlkl7kZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKtMWtWn0019+voCHtZbJyF8SPPyIXaDfbPBjOPhwfTMDqpubVh30YvjuCBF8cVXFqzqchoiU1AUjIa2HOkmibZoPk9nJkkTP9uZy3kT328tHUsmi0XS7x6I32D1NnTim94TyLz7XnAuiPDtcDh4m7Lq7soesUxlg01MZhJdqkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuTtOgMg; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso3528375a12.3;
        Fri, 17 Jan 2025 08:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737132829; x=1737737629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtjVLiRTziusjYNBejGW7DraWbM4PTQdJe8LTGDHlIE=;
        b=HuTtOgMgBMUpTVMXjCV5SfVhw4zw9NRjkmVYZjLI9DxR/Cf+wYt3pT/ND0Y6bFyZhg
         vcdAAsxnM2TCoLg3LeB3wrhSwT8chUtz2UugH5qFbVR+2/KbsNinQgZblG5eamicIjGI
         YLzZi3RN4k/WBPce0pPXOxlvrRbOyKY0ei2OuIy4/HR5ePWOjWTmtfkVYZufRNut8a5t
         lJ0+/yKLR9HSGi536ueN3k1EvAL92SYzy1KhFcNEbBjIHhNT6aBR80s7OVDT7wM8YelH
         qzTrIQTwCMiTW00R2EMfevG38I6QNi5C8khuvLE8XiC1TY/+PscHo3s4ywQZzidFBAyu
         Fu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737132829; x=1737737629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtjVLiRTziusjYNBejGW7DraWbM4PTQdJe8LTGDHlIE=;
        b=E1CT0sNNulgQ/9RVynIFQLDL+516i/wMkwJnNX3BWfo1yca/wN9ppTAjYaIhMsBACH
         ig/uBuw4p96Yx78OMB8D20LkQWkWpNqNJoIFeJWpTrnEShQGJEhRsgR3Y8i/kmviBmgH
         wjK6z0vTnFY+cTKDN/D8ZHdy51nLi/jLolQr4Lm59IaCDtJqGq90SDFceQW83/cdwund
         ZimArlvJN4F+5NvnHDBJ9pFC+RF7hN1zsrt/T0ENI/nuwdepMQJqlEnZk7GNx2VCc73x
         Ghs2Ttvwo8Zt0zXFa95dxKlOfif7rebNvOCyQ8MKPj70f07dZUcRK8UV2Gbeu90HAJQ3
         jh7w==
X-Forwarded-Encrypted: i=1; AJvYcCUrzZaIqL8CiTkAe4Ub2He72cEjkKf6FcvbSbnKd+74HIcegf8bA3XKSD6efhAkgW+OgXA7kujlmAba@vger.kernel.org, AJvYcCVLNdqns+r8LXGPDJohS5tnAhUNJYCOzLjvHbyV4VBGY7oZ/dz3XzXKDCU0MzJWH9Yce+ee9FMeTqxqQ8+O6Q==@vger.kernel.org, AJvYcCX/U+ZGeBc5JQXkkYe5Qmtva0NsBi32RnwrhxUmg0JUC+O9gQ+0gkYWnwtrnrM0uxsCfgXPwAOUnWXbv9td@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9RELV46uK6V4rSSVEa30sFjaHzYOfDrsL0H5rQ1mdO2L5NvGx
	W/JEN5mwjk36DDc+kAjvOpVmaOXzczkoXaL1CQS2fp2B7Vucg1UmBiHIGty6vxT/5rI0tByiYLj
	ARupvXkOz49kPfwjonsHoVblF5l6kz5pfG0g=
X-Gm-Gg: ASbGncuGhhEcsbEkRUVvvRLyJEXoG199/xKivAoIzJenn7Ml4apAOyFwr8peYRixHw7
	ptmlba81fMxSRcM9AmWlYsRzek8umzkmf13HGsQ==
X-Google-Smtp-Source: AGHT+IEMcOrrQ14r5o1H8IuH8SMxyLXMN3cpvmG3Oy+UGaBJVNEXvqBnEHPuKhRn81kA2/YxIELqLTu0qOeOemzmBHQ=
X-Received: by 2002:a05:6402:51c9:b0:5d9:a54:f8b4 with SMTP id
 4fb4d7f45d1cf-5db7d2f88b1mr3206919a12.11.1737132827311; Fri, 17 Jan 2025
 08:53:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241227121508.nofy6bho66pc5ry5@pali> <ckqak3zq72lapwz5eozkob7tcbamrvafqxm4mp5rmevz7zsxh5@xytjbpuj6izz>
 <28f0aa2e-58d7-4b56-bc19-b1b3aa284d8f@oracle.com> <20250104-bonzen-brecheisen-8f7088db32b0@brauner>
 <cf0b8342-8a4b-4485-a5d1-0da20e6d14e7@oracle.com> <20250114211050.iwvxh7fon7as7sty@pali>
 <0659dfe1-e160-40fd-b95a-5d319ca3504f@oracle.com> <20250114215350.gkc2e2kcovj43hk7@pali>
 <CAN05THSXjmVtvYdFLB67kKOwGN5jsAiihtX57G=HT7fBb62yEw@mail.gmail.com>
 <20250114235547.ncqaqcslerandjwf@pali> <20250114235925.GC3561231@frogsfrogsfrogs>
In-Reply-To: <20250114235925.GC3561231@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 17 Jan 2025 17:53:34 +0100
X-Gm-Features: AbW1kvbYc67E_AXaqt8CfQ_SYNuIgNzmzmSJ17Sb6q06A7GkNT7gYB3kM4f_vRE
Message-ID: <CAOQ4uxjj3XUNh6p3LLp_4YCJQ+cQHu7dj8uM3gCiU61L3CQRpA@mail.gmail.com>
Subject: Re: Immutable vs read-only for Windows compatibility
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 12:59=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Wed, Jan 15, 2025 at 12:55:47AM +0100, Pali Roh=C3=A1r wrote:
> > On Wednesday 15 January 2025 09:29:14 ronnie sahlberg wrote:
> > > On Wed, 15 Jan 2025 at 07:54, Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
> > > >
> > > > On Tuesday 14 January 2025 16:44:55 Chuck Lever wrote:
> > > > > On 1/14/25 4:10 PM, Pali Roh=C3=A1r wrote:
> > > > > > On Saturday 04 January 2025 10:30:26 Chuck Lever wrote:
> > > > > > > On 1/4/25 3:52 AM, Christian Brauner wrote:
> > > > > > > > On Thu, Jan 02, 2025 at 10:52:51AM -0500, Chuck Lever wrote=
:
> > > > > > > > > On 1/2/25 9:37 AM, Jan Kara wrote:
> > > > > > > > > > Hello!
> > > > > > > > > >
> > > > > > > > > > On Fri 27-12-24 13:15:08, Pali Roh=C3=A1r wrote:
> > > > > > > > > > > Few months ago I discussed with Steve that Linux SMB =
client has some
> > > > > > > > > > > problems during removal of directory which has read-o=
nly attribute set.
> > > > > > > > > > >
> > > > > > > > > > > I was looking what exactly the read-only windows attr=
ibute means, how it
> > > > > > > > > > > is interpreted by Linux and in my opinion it is wrong=
ly used in Linux at
> > > > > > > > > > > all.
> > > > > > > > > > >
> > > > > > > > > > > Windows filesystems NTFS and ReFS, and also exported =
over SMB supports
> > > > > > > > > > > two ways how to present some file or directory as rea=
d-only. First
> > > > > > > > > > > option is by setting ACL permissions (for particular =
or all users) to
> > > > > > > > > > > GENERIC_READ-only. Second option is by setting the re=
ad-only attribute.
> > > > > > > > > > > Second option is available also for (ex)FAT filesyste=
ms (first option via
> > > > > > > > > > > ACL is not possible on (ex)FAT as it does not have AC=
Ls).
> > > > > > > > > > >
> > > > > > > > > > > First option (ACL) is basically same as clearing all =
"w" bits in mode
> > > > > > > > > > > and ACL (if present) on Linux. It enforces security p=
ermission behavior.
> > > > > > > > > > > Note that if the parent directory grants for user del=
ete child
> > > > > > > > > > > permission then the file can be deleted. This behavio=
r is same for Linux
> > > > > > > > > > > and Windows (on Windows there is separate ACL for del=
ete child, on Linux
> > > > > > > > > > > it is part of directory's write permission).
> > > > > > > > > > >
> > > > > > > > > > > Second option (Windows read-only attribute) means tha=
t the file/dir
> > > > > > > > > > > cannot be opened in write mode, its metadata attribut=
e cannot be changed
> > > > > > > > > > > and the file/dir cannot be deleted at all. But anybod=
y who has
> > > > > > > > > > > WRITE_ATTRIBUTES ACL permission can clear this attrib=
ute and do whatever
> > > > > > > > > > > wants.
> > > > > > > > > >
> > > > > > > > > > I guess someone with more experience how to fuse togeth=
er Windows & Linux
> > > > > > > > > > permission semantics should chime in here but here are =
my thoughts.
> > > > > > > > > >
> > > > > > > > > > > Linux filesystems has similar thing to Windows read-o=
nly attribute
> > > > > > > > > > > (FILE_ATTRIBUTE_READONLY). It is "immutable" bit (FS_=
IMMUTABLE_FL),
> > > > > > > > > > > which can be set by the "chattr" tool. Seems that the=
 only difference
> > > > > > > > > > > between Windows read-only and Linux immutable is that=
 on Linux only
> > > > > > > > > > > process with CAP_LINUX_IMMUTABLE can set or clear thi=
s bit. On Windows
> > > > > > > > > > > it can be anybody who has write ACL.
> > > > > > > > > > >
> > > > > > > > > > > Now I'm thinking, how should be Windows read-only bit=
 interpreted by
> > > > > > > > > > > Linux filesystems drivers (FAT, exFAT, NTFS, SMB)? I =
see few options:
> > > > > > > > > > >
> > > > > > > > > > > 0) Simply ignored. Disadvantage is that over network =
fs, user would not
> > > > > > > > > > >       be able to do modify or delete such file, even =
as root.
> > > > > > > > > > >
> > > > > > > > > > > 1) Smartly ignored. Meaning that for local fs, it is =
ignored and for
> > > > > > > > > > >       network fs it has to be cleared before any writ=
e/modify/delete
> > > > > > > > > > >       operation.
> > > > > > > > > > >
> > > > > > > > > > > 2) Translated to Linux mode/ACL. So the user has some=
 ability to see it
> > > > > > > > > > >       or change it via chmod. Disadvantage is that it=
 mix ACL/mode.
> > > > > > > > > >
> > > > > > > > > > So this option looks sensible to me. We clear all write=
 permissions in
> > > > > > > > > > file's mode / ACL. For reading that is fully compatible=
, for mode
> > > > > > > > > > modifications it gets a bit messy (probably I'd suggest=
 to just clear
> > > > > > > > > > FILE_ATTRIBUTE_READONLY on modification) but kind of cl=
ose.
> > > > > > > > >
> > > > > > > > > IMO Linux should store the Windows-specific attribute inf=
ormation but
> > > > > > > > > otherwise ignore it. Modifying ACLs based seems like a ro=
ad to despair.
> > > > > > > > > Plus there's no ACL representation for OFFLINE and some o=
f the other
> > > > > > > > > items that we'd like to be able to support.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > If I were king-for-a-day (tm) I would create a system xat=
tr namespace
> > > > > > > > > just for these items, and provide a VFS/statx API for con=
sumers like
> > > > > > > > > Samba, ksmbd, and knfsd to set and get these items. Each =
local
> > > > > > > > > filesystem can then implement storage with either the xat=
tr or (eg,
> > > > > > > > > ntfs) can store them directly.
> > > > > > > >
> > > > > > > > Introducing a new xattr namespace for this wouldn't be a pr=
oblem imho.
> > > > > > > > Why would this need a new statx() extension though? Wouldn'=
t the regular
> > > > > > > > xattr apis to set and get xattrs be enough?
> > > > > > >
> > > > > > > My thought was to have a consistent API to access these attri=
butes, and
> > > > > > > let the filesystem implementers decide how they want to store=
 them. The
> > > > > > > Linux implementation of ntfs, for example, probably wants to =
store these
> > > > > > > on disk in a way that is compatible with the Windows implemen=
tation of
> > > > > > > NTFS.
> > > > > > >
> > > > > > > A common API would mean that consumers (like NFSD) wouldn't h=
ave to know
> > > > > > > those details.
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Chuck Lever
> > > > > >
> > > > > > So, what about introducing new xattrs for every attribute with =
this pattern?
> > > > > >
> > > > > > system.attr.readonly
> > > > > > system.attr.hidden
> > > > > > system.attr.system
> > > > > > system.attr.archive
> > > > > > system.attr.temporary
> > > > > > system.attr.offline
> > > > > > system.attr.not_content_indexed
> > > > >
> > > > > Yes, all of them could be stored as xattrs for file systems that =
do
> > > > > not already support these attributes.
> > > > >
> > > > > But I think we don't want to expose them directly to users, howev=
er.
> > > > > Some file systems, like NTFS, might want to store these on-disk i=
n a way
> > > > > that is compatible with Windows.
> > > > >
> > > > > So I think we want to create statx APIs for consumers like user s=
pace
> > > > > and knfsd, who do not care to know the specifics of how this info=
rmation
> > > > > is stored by each file system.
> > > > >
> > > > > The xattrs would be for file systems that do not already have a w=
ay to
> > > > > represent this information in their on-disk format.
> > > > >
> > > > >
> > > > > > All those attributes can be set by user, I took names from SMB,=
 which
> > > > > > matches NTFS and which subsets are used by other filesystems li=
ke FAT,
> > > > > > exFAT, NFS4, UDF, ...
> > > > > >
> > > > > > Every xattr would be in system.attr namespace and would contain=
 either
> > > > > > value 0 or 1 based on that fact if is set or unset. If the file=
system
> > > > > > does not support particular attribute then xattr get/set would =
return
> > > > > > error that it does not exist.
> > > > >
> > > > > Or, if the xattr exists, then that means the equivalent Windows
> > > > > attribute is asserted; and if it does not, the equivalent Windows
> > > > > attribute is clear. But again, I think each file system should be
> > > > > able to choose how they implement these, and that implementation =
is
> > > > > then hidden by statx.
> > > > >
> > > > >
> > > > > > This would be possible to use by existing userspace getfattr/se=
tfattr
> > > > > > tools and also by knfsd/ksmbd via accessing xattrs directly.
> > > > >
> > > > >
> > > > > --
> > > > > Chuck Lever
> > > >
> > > > With this xattr scheme I mean that API would be xattr between fs an=
d
> > > > vfs/userspace/knfsd/smbd. So NTFS would take that xattr request and
> > > > translate it to its own NTFS attributes. Other non-windows fs store=
s
> > > > them as xattrs.
> > >
> > > I am not sure if for the cifs client doing this by emulating xattrs.
> > > I have bad memories of the emulated xattrs.
> > >
> > > What about extending ioctl(FS_IOC_GETFLAGS)? There are plenty of spar=
e
> > > flags there
> >
> > Are FS_IOC_GETFLAGS/FS_IOC_SETFLAGS flags preserved across regular
> > "cp -a" or "rsync -someflag" commands? I'm just worried to not invent
>
> No, none of them are.  We should perhaps talk to the util-linux folks
> about fixing cp.
>

I don't think it is a good idea to start copying these attributes with exis=
ting
cp -a without any opt-in with mount option or new cp command line option.

After all, smb client already exports the virtual xattr "smb3.dosattrib", b=
ut
it is not listed by listxattr, so cp -a does not pick it up anyway.

You could just as well define a standard virtual xattr "system.fs.fsxattr"
that implements an alternative interface for FS_IOC_FS[GS]ETXATTR
but it would have to be opt-in to show up in listxattr().

> > new way how to get or set flags which would not be understood by
> > existing backup or regular "copy" applications. Because the worst thing
> > which can happen is adding new API which nobody would use and basically
> > will not gain those benefits which should have them... Like if I move o=
r
> > copy file from one filesystem to another to not loose all those
> > attributes.
> >
> > > and you even have NTFS.readonly ~=3D Linux.immutable so ... :-)
> >
> > I know it :-) I have not explicitly written it in the email, but put
> > this information into one of the options what can be possible to do.
> > The bad thing about this option for remote filesystems is that
> > Linux.immutable can be cleared only by root (or process which privilege
> > which nobody does not normally have), but on Windows system (and also
> > when exported over SMB) it can be cleared by anybody who can modify fil=
e
> > (based on ACL). So with this Linux will start blocking to do some
> > operation with file, which Windows fully allows. And this very user
> > unfriendly, specially if also wine wants to benefit from it, as wine
> > normally is not going to be run under root (or special capabilities).
> >
> > > To me to feels like the flags you want to implement would fit
> > > "somewhat naturally" there.
> >
> > So thank you and others for this FS_IOC_GETFLAGS opinion. Maybe this
> > looks like a better solution?
>
> FS_IOC_FS[GS]ETXATTR captures a superset of file attributes from
> FS_IOC_[GS]ETFLAGS, please use the former if available.
>

I agree. Flags that you define in the FS_XFLAG_* namespace,
should also be defined in the STATX_ATTR_* namepsace.

Looking at the FILE_ATTRIBUTE_* flags defined in SMB protocol
 (fs/smb/common/smb2pdu.h) I wonder how many of them will be
needed for applications beyond the obvious ones that were listed.

Thanks,
Amir.

