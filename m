Return-Path: <linux-fsdevel+bounces-43798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE71A5DD1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 13:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A552416DCAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4349C24290B;
	Wed, 12 Mar 2025 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XuY1ZjZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D4E7083C
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784040; cv=none; b=C8tJTPKVpyT22/VOG3rghbsrOJi5krUiPaa/OL7u7eNVvLR0hBIsGjjHOTMd8StyRTRrSHiT16XYKS6wZ2rwbuCvjPW6yDBQDhZkvdnQkH1fVyy2ri/B57pDF6myR0pa+wnbcHpcI2bs+/xRHPcjSTFx6rF+B/v375udBZ5BmLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784040; c=relaxed/simple;
	bh=XZsIJu8bz4lDB8R7rAzV+flzct3JsubeWgLQldRyo0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxG+GLdq1HB4PqN+wOOEbAna4bV3q4uyovtkEV2Vcy80sjdDGrjaRbw0Q7oWDEvXpHZgLPvvvg4WqTr7I2XhSs6g9k2FUhEZZ8IxvYnLyjE6q0xXnsJLJKMYuELcfHctu5dsnhecDL+p66xM49yp+6orbAgNVwHMVmY0SJnGSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XuY1ZjZW; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZCVth3M6fz157x;
	Wed, 12 Mar 2025 13:53:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741784028;
	bh=d/Fav/LCh9m71nPnVBm8/MdlP4cPzwHobh78/c6qUbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XuY1ZjZWO8HfyqvMytnouBx4dzX5kwQwsbbivtTrke9BhUQsD9tqZ1rwpAI65HNPd
	 NoSRY3SJlxOY8i0UDY1FtKTSvfxCSeuDNNFxq6FH2A0ZNmFzwMWQrxjllyWIR3XlFe
	 C5L2kQglQRxzFZ9ENLUdJZXROwDFTRdcdnAn12hQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZCVtg45d1zLXf;
	Wed, 12 Mar 2025 13:53:47 +0100 (CET)
Date: Wed, 12 Mar 2025 13:53:46 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Benjamin Berg <benjamin.berg@intel.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] um: hostfs: avoid issues on inode number reuse by host
Message-ID: <20250312.iph3EFiu5eef@digikod.net>
References: <20250214092822.1241575-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214092822.1241575-1-benjamin@sipsolutions.net>
X-Infomaniak-Routing: alpha

On Fri, Feb 14, 2025 at 10:28:22AM +0100, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Some file systems (e.g. ext4) may reuse inode numbers once the inode is
> not in use anymore. Usually hostfs will keep an FD open for each inode,
> but this is not always the case. In the case of sockets, this cannot
> even be done properly.
> 
> As such, the following sequence of events was possible:
>  * application creates and deletes a socket
>  * hostfs creates/deletes the socket on the host
>  * inode is still in the hostfs cache
>  * hostfs creates a new file
>  * ext4 on the outside reuses the inode number
>  * hostfs finds the socket inode for the newly created file
>  * application receives -ENXIO when opening the file
> 
> As mentioned, this can only happen if the deleted file is a special file
> that is never opened on the host (i.e. no .open fop).
> 
> As such, to prevent issues, it is sufficient to check that the inode
> has the expected type. That said, also add a check for the inode birth
> time, just to be on the safe side.
> 
> Fixes: 74ce793bcbde ("hostfs: Fix ephemeral inodes")
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Thanks!  This indeed fix an issue that is at least visible when running
Landlock kselftests with an UML kernel built with Landlock audit support
(probably because of a race condition now being more consistent):
https://lore.kernel.org/all/20250308184422.2159360-1-mic@digikod.net/
FYI, I plan to merge this patch series with v6.15

I guess this patch should fix some other use of UML anyway.  Please
merge it, if possible before v6.15 .

Reviewed-by: Mickaël Salaün <mic@digikod.net>
Tested-by: Mickaël Salaün <mic@digikod.net>

> ---
>  fs/hostfs/hostfs.h      |  2 +-
>  fs/hostfs/hostfs_kern.c |  7 ++++-
>  fs/hostfs/hostfs_user.c | 59 ++++++++++++++++++++++++-----------------
>  3 files changed, 41 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
> index 8b39c15c408c..15b2f094d36e 100644
> --- a/fs/hostfs/hostfs.h
> +++ b/fs/hostfs/hostfs.h
> @@ -60,7 +60,7 @@ struct hostfs_stat {
>  	unsigned int uid;
>  	unsigned int gid;
>  	unsigned long long size;
> -	struct hostfs_timespec atime, mtime, ctime;
> +	struct hostfs_timespec atime, mtime, ctime, btime;
>  	unsigned int blksize;
>  	unsigned long long blocks;
>  	struct {
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index e0741e468956..e6e247235728 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -33,6 +33,7 @@ struct hostfs_inode_info {
>  	struct inode vfs_inode;
>  	struct mutex open_mutex;
>  	dev_t dev;
> +	struct hostfs_timespec btime;
>  };
>  
>  static inline struct hostfs_inode_info *HOSTFS_I(struct inode *inode)
> @@ -547,6 +548,7 @@ static int hostfs_inode_set(struct inode *ino, void *data)
>  	}
>  
>  	HOSTFS_I(ino)->dev = dev;
> +	HOSTFS_I(ino)->btime = st->btime;
>  	ino->i_ino = st->ino;
>  	ino->i_mode = st->mode;
>  	return hostfs_inode_update(ino, st);
> @@ -557,7 +559,10 @@ static int hostfs_inode_test(struct inode *inode, void *data)
>  	const struct hostfs_stat *st = data;
>  	dev_t dev = MKDEV(st->dev.maj, st->dev.min);
>  
> -	return inode->i_ino == st->ino && HOSTFS_I(inode)->dev == dev;
> +	return inode->i_ino == st->ino && HOSTFS_I(inode)->dev == dev &&
> +	       (inode->i_mode & S_IFMT) == (st->mode & S_IFMT) &&
> +	       HOSTFS_I(inode)->btime.tv_sec == st->btime.tv_sec &&
> +	       HOSTFS_I(inode)->btime.tv_nsec == st->btime.tv_nsec;
>  }
>  
>  static struct inode *hostfs_iget(struct super_block *sb, char *name)
> diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
> index 97e9c40a9448..3bcd9f35e70b 100644
> --- a/fs/hostfs/hostfs_user.c
> +++ b/fs/hostfs/hostfs_user.c
> @@ -18,39 +18,48 @@
>  #include "hostfs.h"
>  #include <utime.h>
>  
> -static void stat64_to_hostfs(const struct stat64 *buf, struct hostfs_stat *p)
> +static void statx_to_hostfs(const struct statx *buf, struct hostfs_stat *p)
>  {
> -	p->ino = buf->st_ino;
> -	p->mode = buf->st_mode;
> -	p->nlink = buf->st_nlink;
> -	p->uid = buf->st_uid;
> -	p->gid = buf->st_gid;
> -	p->size = buf->st_size;
> -	p->atime.tv_sec = buf->st_atime;
> -	p->atime.tv_nsec = 0;
> -	p->ctime.tv_sec = buf->st_ctime;
> -	p->ctime.tv_nsec = 0;
> -	p->mtime.tv_sec = buf->st_mtime;
> -	p->mtime.tv_nsec = 0;
> -	p->blksize = buf->st_blksize;
> -	p->blocks = buf->st_blocks;
> -	p->rdev.maj = os_major(buf->st_rdev);
> -	p->rdev.min = os_minor(buf->st_rdev);
> -	p->dev.maj = os_major(buf->st_dev);
> -	p->dev.min = os_minor(buf->st_dev);
> +	p->ino = buf->stx_ino;
> +	p->mode = buf->stx_mode;
> +	p->nlink = buf->stx_nlink;
> +	p->uid = buf->stx_uid;
> +	p->gid = buf->stx_gid;
> +	p->size = buf->stx_size;
> +	p->atime.tv_sec = buf->stx_atime.tv_sec;
> +	p->atime.tv_nsec = buf->stx_atime.tv_nsec;
> +	p->ctime.tv_sec = buf->stx_ctime.tv_sec;
> +	p->ctime.tv_nsec = buf->stx_ctime.tv_nsec;
> +	p->mtime.tv_sec = buf->stx_mtime.tv_sec;
> +	p->mtime.tv_nsec = buf->stx_mtime.tv_nsec;
> +	if (buf->stx_mask & STATX_BTIME) {
> +		p->btime.tv_sec = buf->stx_btime.tv_sec;
> +		p->btime.tv_nsec = buf->stx_btime.tv_nsec;
> +	} else {
> +		memset(&p->btime, 0, sizeof(p->btime));
> +	}
> +	p->blksize = buf->stx_blksize;
> +	p->blocks = buf->stx_blocks;
> +	p->rdev.maj = buf->stx_rdev_major;
> +	p->rdev.min = buf->stx_rdev_minor;
> +	p->dev.maj = buf->stx_dev_major;
> +	p->dev.min = buf->stx_dev_minor;
>  }
>  
>  int stat_file(const char *path, struct hostfs_stat *p, int fd)
>  {
> -	struct stat64 buf;
> +	struct statx buf;
> +	int flags = AT_SYMLINK_NOFOLLOW;
>  
>  	if (fd >= 0) {
> -		if (fstat64(fd, &buf) < 0)
> -			return -errno;
> -	} else if (lstat64(path, &buf) < 0) {
> -		return -errno;
> +		flags |= AT_EMPTY_PATH;
> +		path = "";
>  	}
> -	stat64_to_hostfs(&buf, p);
> +
> +	if ((statx(fd, path, flags, STATX_BASIC_STATS | STATX_BTIME, &buf)) < 0)
> +		return -errno;
> +
> +	statx_to_hostfs(&buf, p);
>  	return 0;
>  }
>  
> -- 
> 2.48.1
> 

