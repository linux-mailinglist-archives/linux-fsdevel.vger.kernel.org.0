Return-Path: <linux-fsdevel+bounces-39180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC20A112BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C473A3DEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6FE20E30A;
	Tue, 14 Jan 2025 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXcalPSR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB2B8493;
	Tue, 14 Jan 2025 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889062; cv=none; b=Qt5VXcONPlQ2SGGt6V21TLLJlwW95PPhx/egzPw/hWNwQPhB/OB5xyGP4EBJGtutq/7n/1Xg0YDMvYHqlBACe24X27VLKxx7UDkNOe3qvKIhmhs6N7J7gCe7c0gX6fhlOllNL+xq7Pc74cyGIzZRqVhNe/J4rwXw751NkrbHcOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889062; c=relaxed/simple;
	bh=h2PtMVFX77nlJqvXqeOFV/GzyWRU78lPj2Sn/joTiRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXBYFVZ07oueoBsqTFrZS5FmByyaJgq7Tm9ML16onNCW4zdai0AqnqW3kXiLZKdGWZyyqqh/9LeGkWEqFRm0Qr8lbLuwjcT/f8Ah/yxk++JHA9lR6UWJThrQJq1Wak7BNixFPvWqIveQcDdW6p1A7xRiwKvBcCiqmbaKX1CIWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXcalPSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03C8C4CEDD;
	Tue, 14 Jan 2025 21:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736889062;
	bh=h2PtMVFX77nlJqvXqeOFV/GzyWRU78lPj2Sn/joTiRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXcalPSRuaBVgdrzfdCijIu40QeAsuymP/1Kab0o6dxceR6uwZgrVLurJOBeCLI6R
	 5C8CnffxXrcNUWO+SXXPzCV8eAw9nwNZY1TLhVpHBMbKFlxPXqSmDVQ84ZsS8agdpC
	 G8cFhnjN4gXZcnuqteqNM1lqHMf7ukaGdEX8Nepp7PJaTmDmATblwN3/o73MO5ou2+
	 +IYZv9WmparHN/wqh+9sdxx2lex7a8qaeKABYHBWca/rpcmpjqgA0k6M2uiMv6N9sr
	 srb0O1/e1F7aigVHkRzMEcu7OwC0oGTGBSKJdeVfhKJN2GVYFtyqiyFrhjG8nFapzi
	 zNnhLk9e/7vZw==
Received: by pali.im (Postfix)
	id 958D84B4; Tue, 14 Jan 2025 22:10:50 +0100 (CET)
Date: Tue, 14 Jan 2025 22:10:50 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <20250114211050.iwvxh7fon7as7sty@pali>
References: <20241227121508.nofy6bho66pc5ry5@pali>
 <ckqak3zq72lapwz5eozkob7tcbamrvafqxm4mp5rmevz7zsxh5@xytjbpuj6izz>
 <28f0aa2e-58d7-4b56-bc19-b1b3aa284d8f@oracle.com>
 <20250104-bonzen-brecheisen-8f7088db32b0@brauner>
 <cf0b8342-8a4b-4485-a5d1-0da20e6d14e7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf0b8342-8a4b-4485-a5d1-0da20e6d14e7@oracle.com>
User-Agent: NeoMutt/20180716

On Saturday 04 January 2025 10:30:26 Chuck Lever wrote:
> On 1/4/25 3:52 AM, Christian Brauner wrote:
> > On Thu, Jan 02, 2025 at 10:52:51AM -0500, Chuck Lever wrote:
> > > On 1/2/25 9:37 AM, Jan Kara wrote:
> > > > Hello!
> > > > 
> > > > On Fri 27-12-24 13:15:08, Pali Rohár wrote:
> > > > > Few months ago I discussed with Steve that Linux SMB client has some
> > > > > problems during removal of directory which has read-only attribute set.
> > > > > 
> > > > > I was looking what exactly the read-only windows attribute means, how it
> > > > > is interpreted by Linux and in my opinion it is wrongly used in Linux at
> > > > > all.
> > > > > 
> > > > > Windows filesystems NTFS and ReFS, and also exported over SMB supports
> > > > > two ways how to present some file or directory as read-only. First
> > > > > option is by setting ACL permissions (for particular or all users) to
> > > > > GENERIC_READ-only. Second option is by setting the read-only attribute.
> > > > > Second option is available also for (ex)FAT filesystems (first option via
> > > > > ACL is not possible on (ex)FAT as it does not have ACLs).
> > > > > 
> > > > > First option (ACL) is basically same as clearing all "w" bits in mode
> > > > > and ACL (if present) on Linux. It enforces security permission behavior.
> > > > > Note that if the parent directory grants for user delete child
> > > > > permission then the file can be deleted. This behavior is same for Linux
> > > > > and Windows (on Windows there is separate ACL for delete child, on Linux
> > > > > it is part of directory's write permission).
> > > > > 
> > > > > Second option (Windows read-only attribute) means that the file/dir
> > > > > cannot be opened in write mode, its metadata attribute cannot be changed
> > > > > and the file/dir cannot be deleted at all. But anybody who has
> > > > > WRITE_ATTRIBUTES ACL permission can clear this attribute and do whatever
> > > > > wants.
> > > > 
> > > > I guess someone with more experience how to fuse together Windows & Linux
> > > > permission semantics should chime in here but here are my thoughts.
> > > > 
> > > > > Linux filesystems has similar thing to Windows read-only attribute
> > > > > (FILE_ATTRIBUTE_READONLY). It is "immutable" bit (FS_IMMUTABLE_FL),
> > > > > which can be set by the "chattr" tool. Seems that the only difference
> > > > > between Windows read-only and Linux immutable is that on Linux only
> > > > > process with CAP_LINUX_IMMUTABLE can set or clear this bit. On Windows
> > > > > it can be anybody who has write ACL.
> > > > > 
> > > > > Now I'm thinking, how should be Windows read-only bit interpreted by
> > > > > Linux filesystems drivers (FAT, exFAT, NTFS, SMB)? I see few options:
> > > > > 
> > > > > 0) Simply ignored. Disadvantage is that over network fs, user would not
> > > > >      be able to do modify or delete such file, even as root.
> > > > > 
> > > > > 1) Smartly ignored. Meaning that for local fs, it is ignored and for
> > > > >      network fs it has to be cleared before any write/modify/delete
> > > > >      operation.
> > > > > 
> > > > > 2) Translated to Linux mode/ACL. So the user has some ability to see it
> > > > >      or change it via chmod. Disadvantage is that it mix ACL/mode.
> > > > 
> > > > So this option looks sensible to me. We clear all write permissions in
> > > > file's mode / ACL. For reading that is fully compatible, for mode
> > > > modifications it gets a bit messy (probably I'd suggest to just clear
> > > > FILE_ATTRIBUTE_READONLY on modification) but kind of close.
> > > 
> > > IMO Linux should store the Windows-specific attribute information but
> > > otherwise ignore it. Modifying ACLs based seems like a road to despair.
> > > Plus there's no ACL representation for OFFLINE and some of the other
> > > items that we'd like to be able to support.
> > > 
> > > 
> > > If I were king-for-a-day (tm) I would create a system xattr namespace
> > > just for these items, and provide a VFS/statx API for consumers like
> > > Samba, ksmbd, and knfsd to set and get these items. Each local
> > > filesystem can then implement storage with either the xattr or (eg,
> > > ntfs) can store them directly.
> > 
> > Introducing a new xattr namespace for this wouldn't be a problem imho.
> > Why would this need a new statx() extension though? Wouldn't the regular
> > xattr apis to set and get xattrs be enough?
> 
> My thought was to have a consistent API to access these attributes, and
> let the filesystem implementers decide how they want to store them. The
> Linux implementation of ntfs, for example, probably wants to store these
> on disk in a way that is compatible with the Windows implementation of
> NTFS.
> 
> A common API would mean that consumers (like NFSD) wouldn't have to know
> those details.
> 
> 
> -- 
> Chuck Lever

So, what about introducing new xattrs for every attribute with this pattern?

system.attr.readonly
system.attr.hidden
system.attr.system
system.attr.archive
system.attr.temporary
system.attr.offline
system.attr.not_content_indexed

All those attributes can be set by user, I took names from SMB, which
matches NTFS and which subsets are used by other filesystems like FAT,
exFAT, NFS4, UDF, ...

Every xattr would be in system.attr namespace and would contain either
value 0 or 1 based on that fact if is set or unset. If the filesystem
does not support particular attribute then xattr get/set would return
error that it does not exist.

This would be possible to use by existing userspace getfattr/setfattr
tools and also by knfsd/ksmbd via accessing xattrs directly.

