Return-Path: <linux-fsdevel+bounces-39202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C43A1156A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 00:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF55F165A23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 23:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BFF223329;
	Tue, 14 Jan 2025 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOTKaqjJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE120214205;
	Tue, 14 Jan 2025 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897369; cv=none; b=lGpmnPwvBNbMkTbMWFGWoaDSwh0Iq+mH7PczH27RbOtS29mYzHVJRHmi4pVzUAJyIXGrcvzWZZU+fjzDzvW41gdbJxI5r7/BF1EIgSR9KW3Ro4c7TugX/wEVyO+JTk16/t2+CbL7XMQq+01GyXIejtdfWxFKht/qhfCIgSuOb5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897369; c=relaxed/simple;
	bh=OwCWqhf/Mpj3aVyQbPu2rjun0LztEbp5sh+fNnbflq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hobI71qxTUXOSYoiVuZglWa4YsxI2FZImdyk/uYNLLXvccSv32en55O5CuMAP4jvWe9N22or0wA8xtj2eNQ5gpO8Cx5YyDRA+Ruvp2KhNF5WyZUOPppocM9qgBmdFkyriiwpqnRu2Mxuqn9ACaAc1r6Q3AIjU+pcMX589f+4P74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOTKaqjJ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso8054547a91.1;
        Tue, 14 Jan 2025 15:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736897366; x=1737502166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCaaobGiol8e//yrAsLirZd8Q6hC8iuvQ7CH4dyYjPg=;
        b=FOTKaqjJLyM8YWwSZHef5b55dB7eUL2ZDZhIDxErbAAU2Bf4rXYb/YUFu5H7hUShul
         GWRSHbZNEHn7EwjwjBAu3C5RlhnGHravtfFPJ9oJAkOXntgoNoxBsKAIzFb6SBDPLIuh
         O2pEl677yBPo9F9Z2KqqE3pylUjXw94tLtrev4Ct/3jvz9dwywlNDGEEzThO0O1RY2Aw
         gJF44yPzZlBnNYGMBqYURl7EMcjrggKqpd6LmRfiV8AVyy6lSsizKHNMOidFGcxUNzQd
         VRini1DVVRVPv38d4X/P2XhRYmjZcbUP5XdRjeBMLjeHO7ZGQssqK/mEtjTbX9JH0kHt
         w9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736897366; x=1737502166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCaaobGiol8e//yrAsLirZd8Q6hC8iuvQ7CH4dyYjPg=;
        b=W91oPz2E6yD+RkZRZiem/cOFX8EhYMAa0fpuBIaWk508+DOq4xRwHzPIGckHeuCpUd
         UYXgyGHSpdkqkcCjHmGAauDg5LWv3PkAW+oBMtZhSaXWotnKw5ZOrcUthGXKfq3slU9n
         p+vlf2iGdvbJPbxu32qPtmnZprkaxxI4C9jLJn8+6j+sBtBdwxMA8ZSI20CokmC4y69B
         EJwxHrV4g/O1V1OizVjSHsU9e52sYosYbv/7nMkYcNtUJYtCZVv7BK0G5d3M8GN813HS
         7lOQ+k0xkhCoeKKpGNVqbL0spSQrkMN6H1gBgBOou6uGtUvuRer8IVbu8PmxEIor2ODG
         zlHw==
X-Forwarded-Encrypted: i=1; AJvYcCU7E6FomSx8Nu9RYWhQtZ85/AKdkvkdya3e3pI57bARnRQ7S1unTj7HTvHSnGYTgynR3H0rBcvnI65I@vger.kernel.org, AJvYcCVd+d8tE0nQJJ+YWciIsIRxJn51FHdtbA4eHLL4OweKp7oT+MBkGJtBOqMqzprWX1a2b2yaK36008zCPMBZZw==@vger.kernel.org, AJvYcCVyVN2VVUxIeuY3JrlV3jIX9YOTYZxiE7RC3dfADTNdi/HVv3uG8WhTn6KJLC2bPZKyR8fts98QBGUJYCQd@vger.kernel.org
X-Gm-Message-State: AOJu0YxjvPcCnHEZ6L4+YUOMFt7nowm/rLEscHFu95JfcBawDbm4Oto/
	+NZWSs7cUNDB3oqomgab7KqFq1YcAvYyYcF6xoWPQ7bh2oWYoMZsoB/4MAm6KrE5E7RTbgZpUMy
	jlypLF2Sxv4+g29bYPJ6VmQaivmk=
X-Gm-Gg: ASbGnctkR3kSehUefeEdNa0gY4AVQuug8OJ7GSbdzuMDos9gz1lC1+FVgYLxsN3rR97
	A/YmaEZiaO49HiaZuhrDC28iT5f2unGRxXvTC+g==
X-Google-Smtp-Source: AGHT+IG0hblGSZj4bNBqdrM01io5Zs+PLMurOA/UT8d+q+YQKYn9e8NZBJ+W/CPlF0QjlzqeFdAPum1z8N+trCWPNok=
X-Received: by 2002:a17:90b:254b:b0:2ee:74a1:fb92 with SMTP id
 98e67ed59e1d1-2f548ea5385mr34380611a91.6.1736897365760; Tue, 14 Jan 2025
 15:29:25 -0800 (PST)
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
In-Reply-To: <20250114215350.gkc2e2kcovj43hk7@pali>
From: ronnie sahlberg <ronniesahlberg@gmail.com>
Date: Wed, 15 Jan 2025 09:29:14 +1000
X-Gm-Features: AbW1kvaDHhIBtfqq3IndE6KcBXLFk3Stwgg-eqPDep6j4Qc0lTIJw8VzHSrB5LA
Message-ID: <CAN05THSXjmVtvYdFLB67kKOwGN5jsAiihtX57G=HT7fBb62yEw@mail.gmail.com>
Subject: Re: Immutable vs read-only for Windows compatibility
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2025 at 07:54, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Tuesday 14 January 2025 16:44:55 Chuck Lever wrote:
> > On 1/14/25 4:10 PM, Pali Roh=C3=A1r wrote:
> > > On Saturday 04 January 2025 10:30:26 Chuck Lever wrote:
> > > > On 1/4/25 3:52 AM, Christian Brauner wrote:
> > > > > On Thu, Jan 02, 2025 at 10:52:51AM -0500, Chuck Lever wrote:
> > > > > > On 1/2/25 9:37 AM, Jan Kara wrote:
> > > > > > > Hello!
> > > > > > >
> > > > > > > On Fri 27-12-24 13:15:08, Pali Roh=C3=A1r wrote:
> > > > > > > > Few months ago I discussed with Steve that Linux SMB client=
 has some
> > > > > > > > problems during removal of directory which has read-only at=
tribute set.
> > > > > > > >
> > > > > > > > I was looking what exactly the read-only windows attribute =
means, how it
> > > > > > > > is interpreted by Linux and in my opinion it is wrongly use=
d in Linux at
> > > > > > > > all.
> > > > > > > >
> > > > > > > > Windows filesystems NTFS and ReFS, and also exported over S=
MB supports
> > > > > > > > two ways how to present some file or directory as read-only=
. First
> > > > > > > > option is by setting ACL permissions (for particular or all=
 users) to
> > > > > > > > GENERIC_READ-only. Second option is by setting the read-onl=
y attribute.
> > > > > > > > Second option is available also for (ex)FAT filesystems (fi=
rst option via
> > > > > > > > ACL is not possible on (ex)FAT as it does not have ACLs).
> > > > > > > >
> > > > > > > > First option (ACL) is basically same as clearing all "w" bi=
ts in mode
> > > > > > > > and ACL (if present) on Linux. It enforces security permiss=
ion behavior.
> > > > > > > > Note that if the parent directory grants for user delete ch=
ild
> > > > > > > > permission then the file can be deleted. This behavior is s=
ame for Linux
> > > > > > > > and Windows (on Windows there is separate ACL for delete ch=
ild, on Linux
> > > > > > > > it is part of directory's write permission).
> > > > > > > >
> > > > > > > > Second option (Windows read-only attribute) means that the =
file/dir
> > > > > > > > cannot be opened in write mode, its metadata attribute cann=
ot be changed
> > > > > > > > and the file/dir cannot be deleted at all. But anybody who =
has
> > > > > > > > WRITE_ATTRIBUTES ACL permission can clear this attribute an=
d do whatever
> > > > > > > > wants.
> > > > > > >
> > > > > > > I guess someone with more experience how to fuse together Win=
dows & Linux
> > > > > > > permission semantics should chime in here but here are my tho=
ughts.
> > > > > > >
> > > > > > > > Linux filesystems has similar thing to Windows read-only at=
tribute
> > > > > > > > (FILE_ATTRIBUTE_READONLY). It is "immutable" bit (FS_IMMUTA=
BLE_FL),
> > > > > > > > which can be set by the "chattr" tool. Seems that the only =
difference
> > > > > > > > between Windows read-only and Linux immutable is that on Li=
nux only
> > > > > > > > process with CAP_LINUX_IMMUTABLE can set or clear this bit.=
 On Windows
> > > > > > > > it can be anybody who has write ACL.
> > > > > > > >
> > > > > > > > Now I'm thinking, how should be Windows read-only bit inter=
preted by
> > > > > > > > Linux filesystems drivers (FAT, exFAT, NTFS, SMB)? I see fe=
w options:
> > > > > > > >
> > > > > > > > 0) Simply ignored. Disadvantage is that over network fs, us=
er would not
> > > > > > > >       be able to do modify or delete such file, even as roo=
t.
> > > > > > > >
> > > > > > > > 1) Smartly ignored. Meaning that for local fs, it is ignore=
d and for
> > > > > > > >       network fs it has to be cleared before any write/modi=
fy/delete
> > > > > > > >       operation.
> > > > > > > >
> > > > > > > > 2) Translated to Linux mode/ACL. So the user has some abili=
ty to see it
> > > > > > > >       or change it via chmod. Disadvantage is that it mix A=
CL/mode.
> > > > > > >
> > > > > > > So this option looks sensible to me. We clear all write permi=
ssions in
> > > > > > > file's mode / ACL. For reading that is fully compatible, for =
mode
> > > > > > > modifications it gets a bit messy (probably I'd suggest to ju=
st clear
> > > > > > > FILE_ATTRIBUTE_READONLY on modification) but kind of close.
> > > > > >
> > > > > > IMO Linux should store the Windows-specific attribute informati=
on but
> > > > > > otherwise ignore it. Modifying ACLs based seems like a road to =
despair.
> > > > > > Plus there's no ACL representation for OFFLINE and some of the =
other
> > > > > > items that we'd like to be able to support.
> > > > > >
> > > > > >
> > > > > > If I were king-for-a-day (tm) I would create a system xattr nam=
espace
> > > > > > just for these items, and provide a VFS/statx API for consumers=
 like
> > > > > > Samba, ksmbd, and knfsd to set and get these items. Each local
> > > > > > filesystem can then implement storage with either the xattr or =
(eg,
> > > > > > ntfs) can store them directly.
> > > > >
> > > > > Introducing a new xattr namespace for this wouldn't be a problem =
imho.
> > > > > Why would this need a new statx() extension though? Wouldn't the =
regular
> > > > > xattr apis to set and get xattrs be enough?
> > > >
> > > > My thought was to have a consistent API to access these attributes,=
 and
> > > > let the filesystem implementers decide how they want to store them.=
 The
> > > > Linux implementation of ntfs, for example, probably wants to store =
these
> > > > on disk in a way that is compatible with the Windows implementation=
 of
> > > > NTFS.
> > > >
> > > > A common API would mean that consumers (like NFSD) wouldn't have to=
 know
> > > > those details.
> > > >
> > > >
> > > > --
> > > > Chuck Lever
> > >
> > > So, what about introducing new xattrs for every attribute with this p=
attern?
> > >
> > > system.attr.readonly
> > > system.attr.hidden
> > > system.attr.system
> > > system.attr.archive
> > > system.attr.temporary
> > > system.attr.offline
> > > system.attr.not_content_indexed
> >
> > Yes, all of them could be stored as xattrs for file systems that do
> > not already support these attributes.
> >
> > But I think we don't want to expose them directly to users, however.
> > Some file systems, like NTFS, might want to store these on-disk in a wa=
y
> > that is compatible with Windows.
> >
> > So I think we want to create statx APIs for consumers like user space
> > and knfsd, who do not care to know the specifics of how this informatio=
n
> > is stored by each file system.
> >
> > The xattrs would be for file systems that do not already have a way to
> > represent this information in their on-disk format.
> >
> >
> > > All those attributes can be set by user, I took names from SMB, which
> > > matches NTFS and which subsets are used by other filesystems like FAT=
,
> > > exFAT, NFS4, UDF, ...
> > >
> > > Every xattr would be in system.attr namespace and would contain eithe=
r
> > > value 0 or 1 based on that fact if is set or unset. If the filesystem
> > > does not support particular attribute then xattr get/set would return
> > > error that it does not exist.
> >
> > Or, if the xattr exists, then that means the equivalent Windows
> > attribute is asserted; and if it does not, the equivalent Windows
> > attribute is clear. But again, I think each file system should be
> > able to choose how they implement these, and that implementation is
> > then hidden by statx.
> >
> >
> > > This would be possible to use by existing userspace getfattr/setfattr
> > > tools and also by knfsd/ksmbd via accessing xattrs directly.
> >
> >
> > --
> > Chuck Lever
>
> With this xattr scheme I mean that API would be xattr between fs and
> vfs/userspace/knfsd/smbd. So NTFS would take that xattr request and
> translate it to its own NTFS attributes. Other non-windows fs stores
> them as xattrs.

I am not sure if for the cifs client doing this by emulating xattrs.
I have bad memories of the emulated xattrs.

What about extending ioctl(FS_IOC_GETFLAGS)? There are plenty of spare
flags there
and you even have NTFS.readonly ~=3D Linux.immutable so ... :-)

To me to feels like the flags you want to implement would fit
"somewhat naturally" there.

regards
ronnie s

>
> I think that you understood it quite differently as I thought because
> you are proposing statx() API for fetching them. I thought that they
> would be exported via getxattr()/setxattr().
>
> This is also a good idea, just would need to write new userspace tools
> for setting and gettting... And there is still one important thing. How
> to modify those attribute? Because statx() is GET-only API.
>

