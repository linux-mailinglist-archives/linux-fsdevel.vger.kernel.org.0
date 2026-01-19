Return-Path: <linux-fsdevel+bounces-74417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAB4D3A2AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 10:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E5213045CC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C224352F89;
	Mon, 19 Jan 2026 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW9dEtDk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9252737E0;
	Mon, 19 Jan 2026 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814082; cv=none; b=rGsGO+2xuqgNNwoJKNo8tmmM8WoJ4lkI59KF0B7WW5zAyhzJleZ7MbQ0ygOL85Nn8nJEbxAaU5b9bkEK4/tYVN9xX0ha8ut7k+UU/HCXz0neKZvYeSbcn8/5NLCq+iyvTAtB1suUHdhxfWii3+42r8Bpzqz91kbGaJ4DDaHztuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814082; c=relaxed/simple;
	bh=pX4uDcgtHDdV8miUnyhWv81vdKepaoYGzkVu5dlWD0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zvqhd9VnJyanXvxwrzAf7PaPHNg77yolswIfdxtYkFMgXoAbEiAmZZlDVXppATeAUADEmr1/3GLL5eB+iDjRwdPP3pXmW2oSquXtibaLhKmgHlS5bTMQr4K0kKAQK/bvLaiJPn9Bhe7VXcIQI7RFMLm9WoJnT7Ua9n5qcf79cKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW9dEtDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7F8C116C6;
	Mon, 19 Jan 2026 09:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768814081;
	bh=pX4uDcgtHDdV8miUnyhWv81vdKepaoYGzkVu5dlWD0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QW9dEtDknuaO2ulrpJangKho+7jzfU88tNf4rFNl41ak1ecQxAlI3hOCImLd5Nn9L
	 Cf4szvgs07R5k5F0Got6cdMJsLv1FN/g6EbQSocaiO7bv5YsXRAd3LVMmL2nRnKW3O
	 3PnbZyONtawcuToeb8DFNkbynSbPmmpiS83zj7V4nxbHtdN7q7pYganrN9qMA6uhZS
	 OZUxDuEzjxG3griQ5ieBB+sguD4xM/iwaO8CRy6xl4yvKdjQ6jbHGC9VXT91nxgoQp
	 9pm62PTtXUfo/0E56yD58Qxv2/Rp4apqw3bqgMNsO7+7cTgVUcxF6o0/GnodhSkL89
	 m4t1LLacvvULw==
Date: Mon, 19 Jan 2026 10:14:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
Message-ID: <20260119-reingehen-gelitten-a5e364f704fa@brauner>
References: <cover.1768573690.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768573690.git.bcodding@hammerspace.com>

On Fri, Jan 16, 2026 at 09:32:10AM -0500, Benjamin Coddington wrote:
> The following series enables the linux NFS server to add a Message
> Authentication Code (MAC) to the filehandles it gives to clients.  This
> provides additional protection to the exported filesystem against filehandle
> guessing attacks.
> 
> Filesystems generate their own filehandles through the export_operation
> "encode_fh" and a filehandle provides sufficient access to open a file
> without needing to perform a lookup.  An NFS client holding a valid
> filehandle can remotely open and read the contents of the file referred to
> by the filehandle.
> 
> In order to acquire a filehandle, you must perform lookup operations on the
> parent directory(ies), and the permissions on those directories may
> prohibit you from walking into them to find the files within.  This would
> normally be considered sufficient protection on a local filesystem to
> prohibit users from accessing those files, however when the filesystem is
> exported via NFS those files can still be accessed by guessing the correct,
> valid filehandles.
> 

I really like this concept (I think Lennart has talked about support for
this before?).

Fwiw, I would really like if nsfs and pidfs file handles were signed
specifically because they're not supposed to persist across reboot. But
we can't do that in a backward compatbile way because userspace accesses
the file handle directly to get e.g., the inode number out of it.

But for new types of file handles for such pseudo-fses I think this
would be very lovely to have. It would probably mean generating a
per-boot key that is used to sign such file handles.

For nfs I understand that you probably outsource the problem to
userspace how to generate and share the key.

> Filehandles are easy to guess because they are well-formed.  The
> open_by_handle_at(2) man page contains an example C program
> (t_name_to_handle_at.c) that can display a filehandle given a path.  Here's
> an example filehandle from a fairly modern XFS:
> 
> # ./t_name_to_handle_at /exports/foo 
> 57
> 12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c
> 
>           ^---------  filehandle  ----------^
>           ^------- inode -------^ ^-- gen --^
> 
> This filehandle consists of a 64-bit inode number and 32-bit generation
> number.  Because the handle is well-formed, its easy to fabricate
> filehandles that match other files within the same filesystem.  You can
> simply insert inode numbers and iterate on the generation number.
> Eventually you'll be able to access the file using open_by_handle_at(2).
> For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, which
> protects against guessing attacks by unprivileged users.

Fyi, it's not so simple. For some filesystems like pidfs and nsfs they
have custom permission checks and are available to unprivileged users.
But they also don't do any path lookup ofc.

> 
> In contrast to a local user using open_by_handle(2), the NFS server must
> permissively allow remote clients to open by filehandle without being able
> to check or trust the remote caller's access. Therefore additional
> protection against this attack is needed for NFS case.  We propose to sign
> filehandles by appending an 8-byte MAC which is the siphash of the
> filehandle from a key set from the nfs-utilities.  NFS server can then
> ensure that guessing a valid filehandle+MAC is practically impossible
> without knowledge of the MAC's key.  The NFS server performs optional
> signing by possessing a key set from userspace and having the "sign_fh"
> export option.
> 
> Because filehandles are long-lived, and there's no method for expiring them,
> the server's key should be set once and not changed.  It also should be
> persisted across restarts.  The methods to set the key allow only setting it

Right, otherwise you break a ton of stuff that relies on stable file
handles across reboots.

> once, afterward it cannot be changed.  A separate patchset for nfs-utils
> contains the userspace changes required to set the server's key.
> 
> I had a previous attempt to solve this problem by encrypting filehandles,
> which turned out to be a problematic, poor solution.  The discussion on
> that previous attempt is here:
> https://lore.kernel.org/linux-nfs/510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com/T/#t
> 
> There are some changes from that version:
> 	- sign filehandles instead of encrypt them (Eric Biggers)
> 	- fix the NFSEXP_ macros, specifically NFSEXP_ALLFLAGS (NeilBrown)
> 	- rebase onto cel/nfsd-next (Chuck Lever)
> 	- condensed/clarified problem explantion (thanks Chuck Lever)
> 	- add nfsctl file "fh_key" for rpc.nfsd to also set the key
> 
> I plan on adding additional work to enable the server to check whether the
> 8-byte MAC will overflow maximum filehandle length for the protocol at
> export time.  There could be some filesystems with 40-byte fileid and
> 24-byte fsid which would break NFSv3's 64-byte filehandle maximum with an
> 8-byte MAC appended.  The server should refuse to export those filesystems
> when "sign_fh" is requested.
> 
> Thanks for any comments and critique.
> 
> Benjamin Coddington (4):
>   nfsd: Convert export flags to use BIT() macro
>   nfsd: Add a key for signing filehandles
>   NFSD/export: Add sign_fh export option
>   NFSD: Sign filehandles
> 
>  Documentation/netlink/specs/nfsd.yaml | 12 ++++
>  fs/nfsd/export.c                      |  5 +-
>  fs/nfsd/netlink.c                     | 15 +++++
>  fs/nfsd/netlink.h                     |  1 +
>  fs/nfsd/netns.h                       |  2 +
>  fs/nfsd/nfs3xdr.c                     | 20 +++---
>  fs/nfsd/nfs4xdr.c                     | 12 ++--
>  fs/nfsd/nfsctl.c                      | 87 ++++++++++++++++++++++++++-
>  fs/nfsd/nfsfh.c                       | 72 +++++++++++++++++++++-
>  fs/nfsd/nfsfh.h                       | 22 +++++++
>  fs/nfsd/trace.h                       | 19 ++++++
>  include/linux/sunrpc/svc.h            |  1 +
>  include/uapi/linux/nfsd/export.h      | 38 ++++++------
>  include/uapi/linux/nfsd_netlink.h     |  2 +
>  14 files changed, 272 insertions(+), 36 deletions(-)
> 
> 
> base-commit: bfd453acb5637b5df881cef4b21803344aa9e7ac
> -- 
> 2.50.1
> 

