Return-Path: <linux-fsdevel+bounces-66297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADB5C1B559
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25CA664748
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155BE34405B;
	Wed, 29 Oct 2025 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNOSdOAy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2388426980B;
	Wed, 29 Oct 2025 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744242; cv=none; b=jcSG4fBZnuzVCe8PvQZ86zf6SxWS7YVFx1LmPg4uAgJcOEnxshLmr/MoG7PhW58t/F6IpNGIIJhyCpF4g6tjfku5xuPv6X6Fd32unoT2dGtMOau/RLIDIkKCqUKve5AeRMa9ndbHBAPviJzHPR+Tre3xkgTvB29ueEroRWfWDHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744242; c=relaxed/simple;
	bh=tnQ7CAQ/zrazskDouHnus3UXop3oRcNTaKyJpkol4Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmK0kP8LQU4GmWIZDJmzyevRGghMm7y8XwjMTPHmoX/1BtGj5X07LGW9/p0E/J+VjjHCSTZO7l5PuFhUlJgij5VQIopwx9ihQcbMyB8/DoabRbRvCDDksYlMU+cL6dsoNLOCIqMSowEB5hA8Hb5LnpbYjKlwdFYA4cp5ZcJ2R1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNOSdOAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA982C4CEF7;
	Wed, 29 Oct 2025 13:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761744240;
	bh=tnQ7CAQ/zrazskDouHnus3UXop3oRcNTaKyJpkol4Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNOSdOAyHbR1VT/fF2/pkmXxetdEzzrKRuVqgkh1vAl0cw2TE7FbX9LXe+xQVy0Wd
	 GHUxzdoNjbJ8DOnGyUjAHVcDWHzV0x/OQbJOcRGPBj/H6KHrK9wk8lKPRz3oRlA8yZ
	 1iRW3c8Eg11hR3E1tPmdtpRpZUaIu4Fv1o+wPwlkTgoxO95Wmdr4m6yMNIY/mhk4SG
	 Y1+B+pJfTPYKuUbD/AWB5VoYivRdvEKKcMYRrnYlFJ0djwF9QuFkIy5mVfS7+uWKjy
	 EmYOnbWmT1O185HtStSd04ZYpyopo4on0Ta9FEFVGNQ8vvit3zJfVgXinV0wo0cEKZ
	 5BCqVzBhaNuLQ==
Date: Wed, 29 Oct 2025 14:23:49 +0100
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
Subject: Re: [PATCH v3 06/13] vfs: make vfs_create break delegations on
 parent directory
Message-ID: <20251029-lenken-scham-0cf009d5a7dd@brauner>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
 <20251021-dir-deleg-ro-v3-6-a08b1cde9f4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021-dir-deleg-ro-v3-6-a08b1cde9f4c@kernel.org>

On Tue, Oct 21, 2025 at 11:25:41AM -0400, Jeff Layton wrote:
> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
> 
> Add a delegated_inode parameter to vfs_create. Most callers are
> converted to pass in NULL, but do_mknodat() is changed to wait for a
> delegation break if there is one.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ecryptfs/inode.c      |  2 +-
>  fs/namei.c               | 26 +++++++++++++++++++-------
>  fs/nfsd/nfs3proc.c       |  2 +-
>  fs/nfsd/vfs.c            |  3 +--
>  fs/open.c                |  2 +-
>  fs/overlayfs/overlayfs.h |  2 +-
>  fs/smb/server/vfs.c      |  2 +-
>  include/linux/fs.h       |  2 +-
>  8 files changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 88631291b32535f623a3fbe4ea9b6ed48a306ca0..661709b157ce854c3bfdfdb13f7c10435fad9756 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -189,7 +189,7 @@ ecryptfs_do_create(struct inode *directory_inode,
>  	rc = lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
>  	if (!rc)
>  		rc = vfs_create(&nop_mnt_idmap, lower_dir,
> -				lower_dentry, mode, true);
> +				lower_dentry, mode, true, NULL);

Starts to look like we should epxlore whether a struct create_args (or
some other name) similar to struct renamedata I did some years ago would
help make the code a bit more legible in the future.

