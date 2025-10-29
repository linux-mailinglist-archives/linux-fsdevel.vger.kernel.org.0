Return-Path: <linux-fsdevel+bounces-66299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE0CC1B871
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEBF66587B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EDA34DB7E;
	Wed, 29 Oct 2025 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPFJfb90"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3441B4257;
	Wed, 29 Oct 2025 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745102; cv=none; b=ZgOTtR6Bbt3DCxF8KhXQKgGX0JM3pJOwNiJHwKisEqe7a5ypai8qnP94NVqadyroqmps2UzkdQVxCB28X0GzjICM6P4vmiIKkvM2gGruUMDT/sTr27ng5lpGszjVxAVIt6mneX1gYUfYWd/lrfpaK/2XrI4iBuzu67ScogdEojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745102; c=relaxed/simple;
	bh=CadqGZee9ToJSza3WH/u5RJ7paC04w0P6yIHFg191SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EE9fikqPUSu53ErCCqeikPYq1rYsj+w8pG945047uQabG/IjZkAqzySQH2IgRnmdmCoBVauQUR/W2Nw18hIzfd3uJZR6oCJIdnBY/2qeIh+9gWVhHRotQu1QLEcw4fejuTYpxZPDgOStMt63EWzaQVgKearHpTb3iSsGyQXlTzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPFJfb90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB23C4CEF7;
	Wed, 29 Oct 2025 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761745101;
	bh=CadqGZee9ToJSza3WH/u5RJ7paC04w0P6yIHFg191SU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPFJfb90zQz8+c6F9lSms7AZf4qeA35v8vvyIuQL51lJ2oul5nMt4jQv0pXkUWy6D
	 ZspkpWKF5qUk957Fmgs15E22nG3RToq5SSDm5fXg7/7Oi7gZ9EUHOt6WbiJ3xV7sfm
	 d21z27cTBbbwLehHlkNmVwuSf9Y5VjOxAb/Mie1IVv4qpjvpQe0SazyiBKIoxNDVYO
	 l0pPwCtNdLLobu4lSDWvVbn8ksm36rdEYu8djEBggMb9zKdJikGoINEXmcnfHnUmcp
	 ysLPgGxniQFGkROA7D2o60KE8MyTR9bJFl3OqzRFRAPxTWWS3lmVFit0ZmQFttGOz+
	 Bd/dipKAF0X3w==
Date: Wed, 29 Oct 2025 14:38:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/13] vfs: recall-only directory delegations for knfsd
Message-ID: <20251029-scham-munkeln-53f3dd551a91@brauner>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>

On Tue, Oct 21, 2025 at 11:25:35AM -0400, Jeff Layton wrote:
> Behold, another version of directory delegations. This version contains
> support for recall-only delegations. Support for CB_NOTIFY will be
> forthcoming (once the client-side patches have caught up).
> 
> This main differences in this version are bugfixes, but the last patch
> adds a more formal API for userland to request a delegation. That
> support is optional. We can drop it and the rest of the series should be
> fine.
> 
> My main interest in making delegations available to userland is to allow
> testing this support without nfsd. I have an xfstest ready to submit for
> this if that support looks acceptable. If it is, then I'll also plan to
> submit an update for fcntl(2).
> 
> Christian, Chuck mentioned he was fine with you merging the nfsd bits
> too, if you're willing to take the whole pile.

This all looks good to me btw. The only thing I'm having issues with is:

 Base: base-commit d2ced3cadfab04c7e915adf0a73c53fcf1642719 not known, ignoring
 Base: attempting to guess base-commit...
 Base: tags/v6.18-rc1-23-g2c09630d09c6 (best guess, 21/27 blobs matched)
 Base: v6.18-rc1
Magic: Preparing a sparse worktree
Unable to cleanly apply series, see failure log below
---
Applying: filelock: push the S_ISREG check down to ->setlease handlers
Applying: vfs: add try_break_deleg calls for parents to vfs_{link,rename,unlink}
Applying: vfs: allow mkdir to wait for delegation break on parent
Applying: vfs: allow rmdir to wait for delegation break on parent
Patch failed at 0004 vfs: allow rmdir to wait for delegation break on parent
error: invalid object 100644 423dd102b51198ea7c447be2b9a0a5020c950dba for 'fs/nfsd/nfs4recover.c'
error: Repository lacks necessary blobs to fall back on 3-way merge.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"

That commit isn't in -next nor in any of my branches?
Can you resend on top of: vfs-6.19.directory.delegations please?

> 
> Thanks!
> Jeff
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v3:
> - Fix potential nfsd_file refcount leaks on GET_DIR_DELEGATION error
> - Add missing parent dir deleg break in vfs_symlink()
> - Add F_SETDELEG/F_GETDELEG support to fcntl()
> - Link to v2: https://lore.kernel.org/r/20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org
> 
> Changes in v2:
> - handle lease conflict resolution inside of nfsd
> - drop the lm_may_setlease lock_manager operation
> - just add extra argument to vfs_create() instead of creating wrapper
> - don't allocate fsnotify_mark for open directories
> - Link to v1: https://lore.kernel.org/r/20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org
> 
> ---
> Jeff Layton (13):
>       filelock: push the S_ISREG check down to ->setlease handlers
>       vfs: add try_break_deleg calls for parents to vfs_{link,rename,unlink}
>       vfs: allow mkdir to wait for delegation break on parent
>       vfs: allow rmdir to wait for delegation break on parent
>       vfs: break parent dir delegations in open(..., O_CREAT) codepath
>       vfs: make vfs_create break delegations on parent directory
>       vfs: make vfs_mknod break delegations on parent directory
>       vfs: make vfs_symlink break delegations on parent dir
>       filelock: lift the ban on directory leases in generic_setlease
>       nfsd: allow filecache to hold S_IFDIR files
>       nfsd: allow DELEGRETURN on directories
>       nfsd: wire up GET_DIR_DELEGATION handling
>       vfs: expose delegation support to userland
> 
>  drivers/base/devtmpfs.c    |   6 +-
>  fs/cachefiles/namei.c      |   2 +-
>  fs/ecryptfs/inode.c        |  10 +--
>  fs/fcntl.c                 |   9 +++
>  fs/fuse/dir.c              |   1 +
>  fs/init.c                  |   6 +-
>  fs/locks.c                 |  68 +++++++++++++++-----
>  fs/namei.c                 | 150 +++++++++++++++++++++++++++++++++++----------
>  fs/nfs/nfs4file.c          |   2 +
>  fs/nfsd/filecache.c        |  57 ++++++++++++-----
>  fs/nfsd/filecache.h        |   2 +
>  fs/nfsd/nfs3proc.c         |   2 +-
>  fs/nfsd/nfs4proc.c         |  22 ++++++-
>  fs/nfsd/nfs4recover.c      |   6 +-
>  fs/nfsd/nfs4state.c        | 103 ++++++++++++++++++++++++++++++-
>  fs/nfsd/state.h            |   5 ++
>  fs/nfsd/vfs.c              |  16 ++---
>  fs/nfsd/vfs.h              |   2 +-
>  fs/open.c                  |   2 +-
>  fs/overlayfs/overlayfs.h   |  10 +--
>  fs/smb/client/cifsfs.c     |   3 +
>  fs/smb/server/vfs.c        |   8 +--
>  fs/xfs/scrub/orphanage.c   |   2 +-
>  include/linux/filelock.h   |  12 ++++
>  include/linux/fs.h         |  13 ++--
>  include/uapi/linux/fcntl.h |  10 +++
>  net/unix/af_unix.c         |   2 +-
>  27 files changed, 425 insertions(+), 106 deletions(-)
> ---
> base-commit: d2ced3cadfab04c7e915adf0a73c53fcf1642719
> change-id: 20251013-dir-deleg-ro-d0fe19823b21
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

