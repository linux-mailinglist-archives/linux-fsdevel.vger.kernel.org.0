Return-Path: <linux-fsdevel+bounces-39507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93962A155DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 999727A400C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814481A2395;
	Fri, 17 Jan 2025 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAbGG5zy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46D820B20;
	Fri, 17 Jan 2025 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737135541; cv=none; b=k6ptn1sBhRfVSu2iGf37Ci/+Vr7wgN5jwD/u0G9NHL55daUTz6bIXkop9BqzG3rdbTOFlhqEi/FZ47NIEQ7qrqgMPBeEUd1tcg0I1ic15ZqS0Fu7KImidu9HJGVqD4X7u+Iy2JR6rVZQi7AEbCC9A0AYvYNlaBPb4AHq1J/CCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737135541; c=relaxed/simple;
	bh=2wqN55K1pEiRZltxhyqpGKKoEI2pee9ie+kcvkhkjfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyZRO6VUWYvzeg8W0gsoclVvLijKxuBFdO2OYU+DEtthqFT4Df0JIttYgH3M2zz5NYSmO+S+TtAW4ddL6epPF/9PLHrhxIFKvoeGjpcsWkrYTAcaE+1rbOcRz5+rPdk+i3llcLETwpSx4CfpBMgA1hwg1ddNgBOKui96N0MCQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAbGG5zy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4584FC4CEE2;
	Fri, 17 Jan 2025 17:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737135541;
	bh=2wqN55K1pEiRZltxhyqpGKKoEI2pee9ie+kcvkhkjfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAbGG5zygA1I5HTS/zjL3XFXgW8VGYmL1ZcarvY887LGlOBaLkuUZktVcZOxst9ee
	 bimYb1udMq1rlNyTL2gYrmY8uiLQNHEKy1BcAwX76ApWyRGY9YvGMbh55X9xmloPW4
	 VQEArp9fEBWHp+1RcDaipa2i8C3/pldD9Mamos/gXRXBvaLVuwyKT7d3RK7BrrYvKI
	 RTnnxSM8xPEiv0N0QIYYJJNrq60CNA3YLyz6TP7vqiKze6fswwJXZHu1UZXNRKs3e6
	 ykn5yRxbXq5Y/Wto/mQ4B+fx6ZdoPMATRrjrJddEpwqAkl4cJ/dn8ACM/+f8p2q+Ko
	 H1WLzBqkbge5w==
Date: Fri, 17 Jan 2025 09:39:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <20250117173900.GN3557553@frogsfrogsfrogs>
References: <28f0aa2e-58d7-4b56-bc19-b1b3aa284d8f@oracle.com>
 <20250104-bonzen-brecheisen-8f7088db32b0@brauner>
 <cf0b8342-8a4b-4485-a5d1-0da20e6d14e7@oracle.com>
 <20250114211050.iwvxh7fon7as7sty@pali>
 <0659dfe1-e160-40fd-b95a-5d319ca3504f@oracle.com>
 <20250114215350.gkc2e2kcovj43hk7@pali>
 <CAN05THSXjmVtvYdFLB67kKOwGN5jsAiihtX57G=HT7fBb62yEw@mail.gmail.com>
 <20250114235547.ncqaqcslerandjwf@pali>
 <20250114235925.GC3561231@frogsfrogsfrogs>
 <CAOQ4uxjj3XUNh6p3LLp_4YCJQ+cQHu7dj8uM3gCiU61L3CQRpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjj3XUNh6p3LLp_4YCJQ+cQHu7dj8uM3gCiU61L3CQRpA@mail.gmail.com>

On Fri, Jan 17, 2025 at 05:53:34PM +0100, Amir Goldstein wrote:
> On Wed, Jan 15, 2025 at 12:59 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Jan 15, 2025 at 12:55:47AM +0100, Pali Rohár wrote:
> > > On Wednesday 15 January 2025 09:29:14 ronnie sahlberg wrote:
> > > > On Wed, 15 Jan 2025 at 07:54, Pali Rohár <pali@kernel.org> wrote:
> > > > >
> > > > > On Tuesday 14 January 2025 16:44:55 Chuck Lever wrote:
> > > > > > On 1/14/25 4:10 PM, Pali Rohár wrote:
> > > > > > > On Saturday 04 January 2025 10:30:26 Chuck Lever wrote:
> > > > > > > > On 1/4/25 3:52 AM, Christian Brauner wrote:
> > > > > > > > > On Thu, Jan 02, 2025 at 10:52:51AM -0500, Chuck Lever wrote:
> > > > > > > > > > On 1/2/25 9:37 AM, Jan Kara wrote:
> > > > > > > > > > > Hello!
> > > > > > > > > > >
> > > > > > > > > > > On Fri 27-12-24 13:15:08, Pali Rohár wrote:
> > > > > > > > > > > > Few months ago I discussed with Steve that Linux SMB client has some
> > > > > > > > > > > > problems during removal of directory which has read-only attribute set.
> > > > > > > > > > > >
> > > > > > > > > > > > I was looking what exactly the read-only windows attribute means, how it
> > > > > > > > > > > > is interpreted by Linux and in my opinion it is wrongly used in Linux at
> > > > > > > > > > > > all.
> > > > > > > > > > > >
> > > > > > > > > > > > Windows filesystems NTFS and ReFS, and also exported over SMB supports
> > > > > > > > > > > > two ways how to present some file or directory as read-only. First
> > > > > > > > > > > > option is by setting ACL permissions (for particular or all users) to
> > > > > > > > > > > > GENERIC_READ-only. Second option is by setting the read-only attribute.
> > > > > > > > > > > > Second option is available also for (ex)FAT filesystems (first option via
> > > > > > > > > > > > ACL is not possible on (ex)FAT as it does not have ACLs).
> > > > > > > > > > > >
> > > > > > > > > > > > First option (ACL) is basically same as clearing all "w" bits in mode
> > > > > > > > > > > > and ACL (if present) on Linux. It enforces security permission behavior.
> > > > > > > > > > > > Note that if the parent directory grants for user delete child
> > > > > > > > > > > > permission then the file can be deleted. This behavior is same for Linux
> > > > > > > > > > > > and Windows (on Windows there is separate ACL for delete child, on Linux
> > > > > > > > > > > > it is part of directory's write permission).
> > > > > > > > > > > >
> > > > > > > > > > > > Second option (Windows read-only attribute) means that the file/dir
> > > > > > > > > > > > cannot be opened in write mode, its metadata attribute cannot be changed
> > > > > > > > > > > > and the file/dir cannot be deleted at all. But anybody who has
> > > > > > > > > > > > WRITE_ATTRIBUTES ACL permission can clear this attribute and do whatever
> > > > > > > > > > > > wants.
> > > > > > > > > > >
> > > > > > > > > > > I guess someone with more experience how to fuse together Windows & Linux
> > > > > > > > > > > permission semantics should chime in here but here are my thoughts.
> > > > > > > > > > >
> > > > > > > > > > > > Linux filesystems has similar thing to Windows read-only attribute
> > > > > > > > > > > > (FILE_ATTRIBUTE_READONLY). It is "immutable" bit (FS_IMMUTABLE_FL),
> > > > > > > > > > > > which can be set by the "chattr" tool. Seems that the only difference
> > > > > > > > > > > > between Windows read-only and Linux immutable is that on Linux only
> > > > > > > > > > > > process with CAP_LINUX_IMMUTABLE can set or clear this bit. On Windows
> > > > > > > > > > > > it can be anybody who has write ACL.
> > > > > > > > > > > >
> > > > > > > > > > > > Now I'm thinking, how should be Windows read-only bit interpreted by
> > > > > > > > > > > > Linux filesystems drivers (FAT, exFAT, NTFS, SMB)? I see few options:
> > > > > > > > > > > >
> > > > > > > > > > > > 0) Simply ignored. Disadvantage is that over network fs, user would not
> > > > > > > > > > > >       be able to do modify or delete such file, even as root.
> > > > > > > > > > > >
> > > > > > > > > > > > 1) Smartly ignored. Meaning that for local fs, it is ignored and for
> > > > > > > > > > > >       network fs it has to be cleared before any write/modify/delete
> > > > > > > > > > > >       operation.
> > > > > > > > > > > >
> > > > > > > > > > > > 2) Translated to Linux mode/ACL. So the user has some ability to see it
> > > > > > > > > > > >       or change it via chmod. Disadvantage is that it mix ACL/mode.
> > > > > > > > > > >
> > > > > > > > > > > So this option looks sensible to me. We clear all write permissions in
> > > > > > > > > > > file's mode / ACL. For reading that is fully compatible, for mode
> > > > > > > > > > > modifications it gets a bit messy (probably I'd suggest to just clear
> > > > > > > > > > > FILE_ATTRIBUTE_READONLY on modification) but kind of close.
> > > > > > > > > >
> > > > > > > > > > IMO Linux should store the Windows-specific attribute information but
> > > > > > > > > > otherwise ignore it. Modifying ACLs based seems like a road to despair.
> > > > > > > > > > Plus there's no ACL representation for OFFLINE and some of the other
> > > > > > > > > > items that we'd like to be able to support.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > If I were king-for-a-day (tm) I would create a system xattr namespace
> > > > > > > > > > just for these items, and provide a VFS/statx API for consumers like
> > > > > > > > > > Samba, ksmbd, and knfsd to set and get these items. Each local
> > > > > > > > > > filesystem can then implement storage with either the xattr or (eg,
> > > > > > > > > > ntfs) can store them directly.
> > > > > > > > >
> > > > > > > > > Introducing a new xattr namespace for this wouldn't be a problem imho.
> > > > > > > > > Why would this need a new statx() extension though? Wouldn't the regular
> > > > > > > > > xattr apis to set and get xattrs be enough?
> > > > > > > >
> > > > > > > > My thought was to have a consistent API to access these attributes, and
> > > > > > > > let the filesystem implementers decide how they want to store them. The
> > > > > > > > Linux implementation of ntfs, for example, probably wants to store these
> > > > > > > > on disk in a way that is compatible with the Windows implementation of
> > > > > > > > NTFS.
> > > > > > > >
> > > > > > > > A common API would mean that consumers (like NFSD) wouldn't have to know
> > > > > > > > those details.
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Chuck Lever
> > > > > > >
> > > > > > > So, what about introducing new xattrs for every attribute with this pattern?
> > > > > > >
> > > > > > > system.attr.readonly
> > > > > > > system.attr.hidden
> > > > > > > system.attr.system
> > > > > > > system.attr.archive
> > > > > > > system.attr.temporary
> > > > > > > system.attr.offline
> > > > > > > system.attr.not_content_indexed
> > > > > >
> > > > > > Yes, all of them could be stored as xattrs for file systems that do
> > > > > > not already support these attributes.
> > > > > >
> > > > > > But I think we don't want to expose them directly to users, however.
> > > > > > Some file systems, like NTFS, might want to store these on-disk in a way
> > > > > > that is compatible with Windows.
> > > > > >
> > > > > > So I think we want to create statx APIs for consumers like user space
> > > > > > and knfsd, who do not care to know the specifics of how this information
> > > > > > is stored by each file system.
> > > > > >
> > > > > > The xattrs would be for file systems that do not already have a way to
> > > > > > represent this information in their on-disk format.
> > > > > >
> > > > > >
> > > > > > > All those attributes can be set by user, I took names from SMB, which
> > > > > > > matches NTFS and which subsets are used by other filesystems like FAT,
> > > > > > > exFAT, NFS4, UDF, ...
> > > > > > >
> > > > > > > Every xattr would be in system.attr namespace and would contain either
> > > > > > > value 0 or 1 based on that fact if is set or unset. If the filesystem
> > > > > > > does not support particular attribute then xattr get/set would return
> > > > > > > error that it does not exist.
> > > > > >
> > > > > > Or, if the xattr exists, then that means the equivalent Windows
> > > > > > attribute is asserted; and if it does not, the equivalent Windows
> > > > > > attribute is clear. But again, I think each file system should be
> > > > > > able to choose how they implement these, and that implementation is
> > > > > > then hidden by statx.
> > > > > >
> > > > > >
> > > > > > > This would be possible to use by existing userspace getfattr/setfattr
> > > > > > > tools and also by knfsd/ksmbd via accessing xattrs directly.
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Chuck Lever
> > > > >
> > > > > With this xattr scheme I mean that API would be xattr between fs and
> > > > > vfs/userspace/knfsd/smbd. So NTFS would take that xattr request and
> > > > > translate it to its own NTFS attributes. Other non-windows fs stores
> > > > > them as xattrs.
> > > >
> > > > I am not sure if for the cifs client doing this by emulating xattrs.
> > > > I have bad memories of the emulated xattrs.
> > > >
> > > > What about extending ioctl(FS_IOC_GETFLAGS)? There are plenty of spare
> > > > flags there
> > >
> > > Are FS_IOC_GETFLAGS/FS_IOC_SETFLAGS flags preserved across regular
> > > "cp -a" or "rsync -someflag" commands? I'm just worried to not invent
> >
> > No, none of them are.  We should perhaps talk to the util-linux folks
> > about fixing cp.
> >
> 
> I don't think it is a good idea to start copying these attributes with existing
> cp -a without any opt-in with mount option or new cp command line option.
> 
> After all, smb client already exports the virtual xattr "smb3.dosattrib", but
> it is not listed by listxattr, so cp -a does not pick it up anyway.
> 
> You could just as well define a standard virtual xattr "system.fs.fsxattr"
> that implements an alternative interface for FS_IOC_FS[GS]ETXATTR
> but it would have to be opt-in to show up in listxattr().
> 
> > > new way how to get or set flags which would not be understood by
> > > existing backup or regular "copy" applications. Because the worst thing
> > > which can happen is adding new API which nobody would use and basically
> > > will not gain those benefits which should have them... Like if I move or
> > > copy file from one filesystem to another to not loose all those
> > > attributes.
> > >
> > > > and you even have NTFS.readonly ~= Linux.immutable so ... :-)
> > >
> > > I know it :-) I have not explicitly written it in the email, but put
> > > this information into one of the options what can be possible to do.
> > > The bad thing about this option for remote filesystems is that
> > > Linux.immutable can be cleared only by root (or process which privilege
> > > which nobody does not normally have), but on Windows system (and also
> > > when exported over SMB) it can be cleared by anybody who can modify file
> > > (based on ACL). So with this Linux will start blocking to do some
> > > operation with file, which Windows fully allows. And this very user
> > > unfriendly, specially if also wine wants to benefit from it, as wine
> > > normally is not going to be run under root (or special capabilities).
> > >
> > > > To me to feels like the flags you want to implement would fit
> > > > "somewhat naturally" there.
> > >
> > > So thank you and others for this FS_IOC_GETFLAGS opinion. Maybe this
> > > looks like a better solution?
> >
> > FS_IOC_FS[GS]ETXATTR captures a superset of file attributes from
> > FS_IOC_[GS]ETFLAGS, please use the former if available.
> >
> 
> I agree. Flags that you define in the FS_XFLAG_* namespace,
> should also be defined in the STATX_ATTR_* namepsace.
> 
> Looking at the FILE_ATTRIBUTE_* flags defined in SMB protocol
>  (fs/smb/common/smb2pdu.h) I wonder how many of them will be
> needed for applications beyond the obvious ones that were listed.

Well they only asked for seven of them. ;)

I chatted with Ted about this yesterday, and ... some of the attributes
(like read only) imply that you'd want the linux server to enforce no
writing to the file; some like archive seem a little superfluous since
on linux you can compare cmtime from the backup against what's in the
file now; and still others (like hidden/system) might just be some dorky
thing that could be hidden in some xattr because a unix filesystem won't
care.

And then there are other attrs like "integrity stream" where someone
with more experience with windows would have to tell me if fsverity
provides sufficient behaviors or not.

But maybe we should start by plumbing one of those bits in?  I guess the
gross part is that implies an ondisk inode format change or (gross)
xattr lookups in the open path.

(This is the point where I declare that except for applying a mandatory
Thunderbolt firmware update a month ago I haven't touched Windows since
2002, and this is the extent of my interest in the topic.)

--D

> Thanks,
> Amir.

