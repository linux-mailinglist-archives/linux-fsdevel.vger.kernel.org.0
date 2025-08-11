Return-Path: <linux-fsdevel+bounces-57354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9D3B20AB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F7E18C259C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D761719DF5F;
	Mon, 11 Aug 2025 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvTKhn7+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE5192D8A;
	Mon, 11 Aug 2025 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920207; cv=none; b=FMIzsLm3WKF7XLH8xKoAftNBckaenGqtubUYoWWChyTsdFTVMu+Sgv5VpPQzmf8ZyJ6HiBFYATdZCMmdkKQ77ynS03fvlIyI68iLYelVnZMpB5UuXx27dKGFIln9rAKpDumbkM9pHzHoOYTx9sUrDJWoQnk3uimLPEJIUlzwEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920207; c=relaxed/simple;
	bh=Q3wRFljT1RqYBoMrZp5hrUr0ZoeqxaR44aa4gXoxX18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASmFbVnRlZP218XwE5Z9Sg9c9/FALaGiLb9xDkPDzhnjgpVhbEcqsqbU0lfS7rQkcfHdARcTRWd7+aTyNdO4BQdX8u/IHGwBnAIKV7tjTQqWXTVVb4NO8BKndIOwO57Cf+uw+98R/DfjYvhzaZvDcVRSPe+YbCo5ioYuGCrFVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvTKhn7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE867C4CEED;
	Mon, 11 Aug 2025 13:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754920206;
	bh=Q3wRFljT1RqYBoMrZp5hrUr0ZoeqxaR44aa4gXoxX18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvTKhn7+/cg26lCF8iufQgaAZVGIt+1RdEg5ca3bkwvmjm/9zzFu+dpLh/NCYBaxq
	 nB2bTrKZqQ/0OeKeh3VfXOLlguf5zCFD/XBeN0O+Ojx77pzkVbUFdT6sdbXTnxn1bY
	 zBjBU1oGDe/FhG6AE/y10dKDMSvhEZSkJ9UV29botVq4qVLDZDwUWlCotJfcREW79t
	 nSHSFqUznSu7YT+x2o0HXBEwiWwXSBodYrWcVrwieTmvPbupRBDfrUn3Nbqv8v7z95
	 YbYHe4zWfam2qOco0imx51oYaBBJdiBfllh27S16Yt7xZJG6fV+P/IZBI6vUwMumAL
	 uoX8g4EiAZLaA==
Date: Mon, 11 Aug 2025 15:50:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	ntfs3@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] vfs: exclude ntfs3 from file mode validation in
 may_open()
Message-ID: <20250811-geteilt-sprudeln-f09e6ec25c0c@brauner>
References: <fb3888fb-11b8-481b-86a6-766bbbab5c81@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb3888fb-11b8-481b-86a6-766bbbab5c81@I-love.SAKURA.ne.jp>

On Mon, Aug 11, 2025 at 04:05:51PM +0900, Tetsuo Handa wrote:
> Since ntfs_read_mft() not only accepts file modes which may_open() accepts
> but also accepts
> 
>   (fname && fname->home.low == cpu_to_le32(MFT_REC_EXTEND) &&
>    fname->home.seq == cpu_to_le16(MFT_REC_EXTEND)
> 
> case when the file mode is none of
> S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/S_IFIFO/S_IFSOCK, may_open() cannot
> unconditionally expect IS_ANON_FILE(inode) when the file mode is none of
> S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/S_IFIFO/S_IFSOCK.
> 
> Treat as if S_IFREG when the inode is for NTFS3 filesystem.
> 
> Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
> Fixes: af153bb63a33 ("vfs: catch invalid modes in may_open()")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Is it possible to handle this problem on the NTFS3 side?

Ugh, this is annoying.
@Konstantin, why do you leave a zero mode for these files?
Let's just make them regular files?

> 
>   --- a/fs/ntfs3/inode.c
>   +++ b/fs/ntfs3/inode.c
>   @@ -470,8 +470,9 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>           } else if (fname && fname->home.low == cpu_to_le32(MFT_REC_EXTEND) &&
>                      fname->home.seq == cpu_to_le16(MFT_REC_EXTEND)) {
>                   /* Records in $Extend are not a files or general directories. */
>                   inode->i_op = &ntfs_file_inode_operations;
>   +               mode = S_IFREG;
>           } else {
>                   err = -EINVAL;
>                   goto out;
>           }
> 
> I don't know what breaks if we pretend as if S_IFREG...
> 
>  fs/namei.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index cd43ff89fbaa..a66599754394 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3471,6 +3471,12 @@ static int may_open(struct mnt_idmap *idmap, const struct path *path,
>  			return -EACCES;
>  		break;
>  	default:
> +		/* Special handling for ntfs_read_mft() case. */
> +		if (inode->i_sb->s_magic == 0x7366746e) {
> +			if ((acc_mode & MAY_EXEC) && path_noexec(path))
> +				return -EACCES;

That's really unacceptable. We either need to drop the assert which
would be a shame because it keeps finding bugs or we fix that in ntfs3
which is my preferred solution...

> +			break;
> +		}
>  		VFS_BUG_ON_INODE(!IS_ANON_FILE(inode), inode);
>  	}
>  
> -- 
> 2.50.1

