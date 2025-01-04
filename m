Return-Path: <linux-fsdevel+bounces-38382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 888BBA01367
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 09:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89C018849D9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9524157A46;
	Sat,  4 Jan 2025 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPdScDLU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084C328FD;
	Sat,  4 Jan 2025 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735980767; cv=none; b=jwb47x5qVDBx5UYw3E3OXb2zjApZvMTw62y/bJ14nfd24Os4rIz8QBhyfqH4fcVE2H3hqTeHvZxmTP4Kt8YLC3pz6toCoU5+JmERFJmMLQ3tHOjQkEP1EgdN9ljHmPhT9CBfriWyncvfFimezoxm2NRWndkhSGXdKM2E60VpBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735980767; c=relaxed/simple;
	bh=KV4LRhXV1cLTdL3DC8lI4dNZMZC1Vz1wdSyOTDNZmHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kumq4PCPswDy1h5hUHx7eqFEpxmK2UoI5wv/IqDtCkvq/7/+J45l8Qz/m0Tgu5EB+oasGP+g5cbq40MdSxpm0g8nZ9cBcu25FIH3a7x59GjWXMam2ezOZhPOEW+oRBEAkLf0eHBCv3MhlRQBEwLmYpBAj3Cw3EB2D7LjHYR/HAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPdScDLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01618C4CED1;
	Sat,  4 Jan 2025 08:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735980766;
	bh=KV4LRhXV1cLTdL3DC8lI4dNZMZC1Vz1wdSyOTDNZmHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPdScDLUdVAUDJdcU8G/7XPP2/4eBln680kEmCsVnMWpaTT04fsLTka8eY32BMf60
	 w0moxa+Nxwc9Q8WvL3KjHs/EbX7JX3psKWfmFasikPrKL3bUnATG68gsDmb8nC1/os
	 uwPcQbZRzjBCgO9dpK+ynB5p85d0izX7hncMMiFZp9hahNuMFndBCqs9qbDyVxgssh
	 UmBi76JbWDATBrfSOR8O6p4wcL+qEZKb5KXymkngNjr13/5pAWH8WkLDdgoajWGbgn
	 /qJILPyEf2gesJd+PwbyeRfz2sh+CWkuZiuQ9ED+pk1mCesJFKkQnGzliJcvT31lt8
	 6diZVyChExhXw==
Date: Sat, 4 Jan 2025 09:52:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jan Kara <jack@suse.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <20250104-bonzen-brecheisen-8f7088db32b0@brauner>
References: <20241227121508.nofy6bho66pc5ry5@pali>
 <ckqak3zq72lapwz5eozkob7tcbamrvafqxm4mp5rmevz7zsxh5@xytjbpuj6izz>
 <28f0aa2e-58d7-4b56-bc19-b1b3aa284d8f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28f0aa2e-58d7-4b56-bc19-b1b3aa284d8f@oracle.com>

On Thu, Jan 02, 2025 at 10:52:51AM -0500, Chuck Lever wrote:
> On 1/2/25 9:37 AM, Jan Kara wrote:
> > Hello!
> > 
> > On Fri 27-12-24 13:15:08, Pali Rohár wrote:
> > > Few months ago I discussed with Steve that Linux SMB client has some
> > > problems during removal of directory which has read-only attribute set.
> > > 
> > > I was looking what exactly the read-only windows attribute means, how it
> > > is interpreted by Linux and in my opinion it is wrongly used in Linux at
> > > all.
> > > 
> > > Windows filesystems NTFS and ReFS, and also exported over SMB supports
> > > two ways how to present some file or directory as read-only. First
> > > option is by setting ACL permissions (for particular or all users) to
> > > GENERIC_READ-only. Second option is by setting the read-only attribute.
> > > Second option is available also for (ex)FAT filesystems (first option via
> > > ACL is not possible on (ex)FAT as it does not have ACLs).
> > > 
> > > First option (ACL) is basically same as clearing all "w" bits in mode
> > > and ACL (if present) on Linux. It enforces security permission behavior.
> > > Note that if the parent directory grants for user delete child
> > > permission then the file can be deleted. This behavior is same for Linux
> > > and Windows (on Windows there is separate ACL for delete child, on Linux
> > > it is part of directory's write permission).
> > > 
> > > Second option (Windows read-only attribute) means that the file/dir
> > > cannot be opened in write mode, its metadata attribute cannot be changed
> > > and the file/dir cannot be deleted at all. But anybody who has
> > > WRITE_ATTRIBUTES ACL permission can clear this attribute and do whatever
> > > wants.
> > 
> > I guess someone with more experience how to fuse together Windows & Linux
> > permission semantics should chime in here but here are my thoughts.
> > 
> > > Linux filesystems has similar thing to Windows read-only attribute
> > > (FILE_ATTRIBUTE_READONLY). It is "immutable" bit (FS_IMMUTABLE_FL),
> > > which can be set by the "chattr" tool. Seems that the only difference
> > > between Windows read-only and Linux immutable is that on Linux only
> > > process with CAP_LINUX_IMMUTABLE can set or clear this bit. On Windows
> > > it can be anybody who has write ACL.
> > > 
> > > Now I'm thinking, how should be Windows read-only bit interpreted by
> > > Linux filesystems drivers (FAT, exFAT, NTFS, SMB)? I see few options:
> > > 
> > > 0) Simply ignored. Disadvantage is that over network fs, user would not
> > >     be able to do modify or delete such file, even as root.
> > > 
> > > 1) Smartly ignored. Meaning that for local fs, it is ignored and for
> > >     network fs it has to be cleared before any write/modify/delete
> > >     operation.
> > > 
> > > 2) Translated to Linux mode/ACL. So the user has some ability to see it
> > >     or change it via chmod. Disadvantage is that it mix ACL/mode.
> > 
> > So this option looks sensible to me. We clear all write permissions in
> > file's mode / ACL. For reading that is fully compatible, for mode
> > modifications it gets a bit messy (probably I'd suggest to just clear
> > FILE_ATTRIBUTE_READONLY on modification) but kind of close.
> 
> IMO Linux should store the Windows-specific attribute information but
> otherwise ignore it. Modifying ACLs based seems like a road to despair.
> Plus there's no ACL representation for OFFLINE and some of the other
> items that we'd like to be able to support.
> 
> 
> If I were king-for-a-day (tm) I would create a system xattr namespace
> just for these items, and provide a VFS/statx API for consumers like
> Samba, ksmbd, and knfsd to set and get these items. Each local
> filesystem can then implement storage with either the xattr or (eg,
> ntfs) can store them directly.

Introducing a new xattr namespace for this wouldn't be a problem imho.
Why would this need a new statx() extension though? Wouldn't the regular
xattr apis to set and get xattrs be enough?

