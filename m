Return-Path: <linux-fsdevel+bounces-38388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5A0A0140E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 12:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF37E163D96
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C2A19F49E;
	Sat,  4 Jan 2025 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJRSn0WS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59321487E9;
	Sat,  4 Jan 2025 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735989151; cv=none; b=sAJAmwx+vQfXsBPt+fZKObmW1OIX3OWp6DPAFZuWvvlbRJGoKfF1KC51F0+F+yraH6d3fCms+PHpV3VoJtE+Ao33doQKv6ZP8BJ2fdess28hDBdIi6QLwCeXFKS1JqsQu7h/X6E6Dm/CpfqyCUd4+Ka3Efgp9WYke/LJtJFWVsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735989151; c=relaxed/simple;
	bh=vaAWRBYNw/3s4ojn553OSZTdNS1n1Z4ivOB7n3/trTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS73xcj+vizFkEmPJY09QePyzzYNFI129Tp0r3uthj+5uT0vyaWia+kNKqtrQo1hW6WMG76picFEOgJgvMihVSzEz/DfEa0zVfkLpibUkhgpGfmgOZqp6741FjBdEmrnZcmpRIlDrXCgtw30dVCnq4Fm5X51baVuLq4vm2zYIB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJRSn0WS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CD4C4CED1;
	Sat,  4 Jan 2025 11:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735989150;
	bh=vaAWRBYNw/3s4ojn553OSZTdNS1n1Z4ivOB7n3/trTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJRSn0WS4sACoS0UrDzruF3RdlU0gZyg8e1/MOZWKJ2zp7ucpxp1YFpbgMmml75oH
	 m3KhdxSVVDk6w00qc4kznp1YZYpWhWm2BEuH5ZlIQ7PUFt2d6d/TTzXECui0CSUXkB
	 WdYFYY7wVkwwy50C7zKPM9AavEFGlM9GkWe8hmyM7ha9YGsvZGClbiBE1w7IP7Cl/X
	 SZsq6K98fKny0xisP1XG3N3s99Oh7LGOXRS/Wf3f643R1Pwnh+F7mGzWDh9b9dc37q
	 qYfnYj3VTHhF+htGzsSLHgxvUnj/AJH45WiKVg6D8C5lBIi88NWia7UXIDP1ngK/0r
	 8IMmjNWoaABrQ==
Received: by pali.im (Postfix)
	id 4D0B1790; Sat,  4 Jan 2025 12:12:19 +0100 (CET)
Date: Sat, 4 Jan 2025 12:12:19 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <20250104111219.5qd7co6qtsdiko4i@pali>
References: <20241227121508.nofy6bho66pc5ry5@pali>
 <ckqak3zq72lapwz5eozkob7tcbamrvafqxm4mp5rmevz7zsxh5@xytjbpuj6izz>
 <28f0aa2e-58d7-4b56-bc19-b1b3aa284d8f@oracle.com>
 <20250104-bonzen-brecheisen-8f7088db32b0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250104-bonzen-brecheisen-8f7088db32b0@brauner>
User-Agent: NeoMutt/20180716

On Saturday 04 January 2025 09:52:44 Christian Brauner wrote:
> On Thu, Jan 02, 2025 at 10:52:51AM -0500, Chuck Lever wrote:
> > On 1/2/25 9:37 AM, Jan Kara wrote:
> > > Hello!
> > > 
> > > On Fri 27-12-24 13:15:08, Pali Rohár wrote:
> > > > Few months ago I discussed with Steve that Linux SMB client has some
> > > > problems during removal of directory which has read-only attribute set.
> > > > 
> > > > I was looking what exactly the read-only windows attribute means, how it
> > > > is interpreted by Linux and in my opinion it is wrongly used in Linux at
> > > > all.
> > > > 
> > > > Windows filesystems NTFS and ReFS, and also exported over SMB supports
> > > > two ways how to present some file or directory as read-only. First
> > > > option is by setting ACL permissions (for particular or all users) to
> > > > GENERIC_READ-only. Second option is by setting the read-only attribute.
> > > > Second option is available also for (ex)FAT filesystems (first option via
> > > > ACL is not possible on (ex)FAT as it does not have ACLs).
> > > > 
> > > > First option (ACL) is basically same as clearing all "w" bits in mode
> > > > and ACL (if present) on Linux. It enforces security permission behavior.
> > > > Note that if the parent directory grants for user delete child
> > > > permission then the file can be deleted. This behavior is same for Linux
> > > > and Windows (on Windows there is separate ACL for delete child, on Linux
> > > > it is part of directory's write permission).
> > > > 
> > > > Second option (Windows read-only attribute) means that the file/dir
> > > > cannot be opened in write mode, its metadata attribute cannot be changed
> > > > and the file/dir cannot be deleted at all. But anybody who has
> > > > WRITE_ATTRIBUTES ACL permission can clear this attribute and do whatever
> > > > wants.
> > > 
> > > I guess someone with more experience how to fuse together Windows & Linux
> > > permission semantics should chime in here but here are my thoughts.
> > > 
> > > > Linux filesystems has similar thing to Windows read-only attribute
> > > > (FILE_ATTRIBUTE_READONLY). It is "immutable" bit (FS_IMMUTABLE_FL),
> > > > which can be set by the "chattr" tool. Seems that the only difference
> > > > between Windows read-only and Linux immutable is that on Linux only
> > > > process with CAP_LINUX_IMMUTABLE can set or clear this bit. On Windows
> > > > it can be anybody who has write ACL.
> > > > 
> > > > Now I'm thinking, how should be Windows read-only bit interpreted by
> > > > Linux filesystems drivers (FAT, exFAT, NTFS, SMB)? I see few options:
> > > > 
> > > > 0) Simply ignored. Disadvantage is that over network fs, user would not
> > > >     be able to do modify or delete such file, even as root.
> > > > 
> > > > 1) Smartly ignored. Meaning that for local fs, it is ignored and for
> > > >     network fs it has to be cleared before any write/modify/delete
> > > >     operation.
> > > > 
> > > > 2) Translated to Linux mode/ACL. So the user has some ability to see it
> > > >     or change it via chmod. Disadvantage is that it mix ACL/mode.
> > > 
> > > So this option looks sensible to me. We clear all write permissions in
> > > file's mode / ACL. For reading that is fully compatible, for mode
> > > modifications it gets a bit messy (probably I'd suggest to just clear
> > > FILE_ATTRIBUTE_READONLY on modification) but kind of close.
> > 
> > IMO Linux should store the Windows-specific attribute information but
> > otherwise ignore it. Modifying ACLs based seems like a road to despair.
> > Plus there's no ACL representation for OFFLINE and some of the other
> > items that we'd like to be able to support.
> > 
> > 
> > If I were king-for-a-day (tm) I would create a system xattr namespace
> > just for these items, and provide a VFS/statx API for consumers like
> > Samba, ksmbd, and knfsd to set and get these items. Each local
> > filesystem can then implement storage with either the xattr or (eg,
> > ntfs) can store them directly.
> 
> Introducing a new xattr namespace for this wouldn't be a problem imho.
> Why would this need a new statx() extension though? Wouldn't the regular
> xattr apis to set and get xattrs be enough?

I can imagine that alternative application to "ls -l" or "stat" could
want to show some of those new flags. So to prevent storm of stat and
getxattr syscalls, there can be one syscall (e.g. part of the statx)
which could serve all information. But this is just my imagination...

Anyway, there is already such application and it is wine. WinAPI
functions which are equivalent to Linux stat function are already
returning all those flags.

In the same way flags are part of the basic SMB stat operation, so Samba
or ksmbd would have to always ask for all of them.

