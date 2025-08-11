Return-Path: <linux-fsdevel+bounces-57351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE2B20A7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327F82A31A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871692DECBA;
	Mon, 11 Aug 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YrRN6BWV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F82DEA76;
	Mon, 11 Aug 2025 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919536; cv=none; b=VMdBqcmI/RTz1X7rw4Jx9xq8j26FpBgDk1OhE1/XOjoARlBVYo65eJZy8ehRvifa8yNYLQwO9VSboAfV+LCAoSpXHoKQXD9F8ok9MWmWdBSEsK4snqXHIYVVRLyDxOdqRkSaLpcaKxXRLIpB/3wvlVWXrF3JMrT+rxCETMpLw9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919536; c=relaxed/simple;
	bh=NTxLN/OIxdavvXriPAMpsQ/MGWkSJkBk6dizUl8lFio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8L/ydHYEgRpqTesJvXmoMhDe3rA8bHaQv+mp1DBE1dCWcpPOXMSFYUuy/az4VWw7WKXHNIvvauMl84VojmtW8l++xHZb8GhGmtF+DTUgqYjf0DHoisZ5O1A5SQ8+TDxSm1egV5kIL4UzadNqOst86QdXdBIXBoLQvBvJyPebTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YrRN6BWV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZpQwJb5N9DB6xXQvZYGJMUsct3O7Ai+ocYqxGIM0vSk=; b=YrRN6BWVo93BdrvTMPbddp9LK5
	B5YtER7BRP33UvwIdaC4KYrEI0T1O6A9iOXgJrpYb9/E93HYrmnrFK+X6sq1iV+RQpq5ZZwHPm+Ze
	JfJz6A5T31t3lEzJJhiMpltBvWmqbdh2VwmJeI8L1yXn86r/ZJaSSP4jp7WwQsB5aUA2YRSv2wRIT
	lPDmHXpY+IasxZrQ6pyP2fq5BWEX/uqZvBSkgqnScZVMKVKzMPOKei2RRCwHp+SRRwXegFn/g7de8
	ffUsXh46HjYGaKTIdpma4N0YDBxq/U1AuACimlqGDUCm0i2Vf12QYSdZMmS8ivZOuZauIs+nY6XP5
	FN0Y6rYA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSjg-0000000147G-1Sic;
	Mon, 11 Aug 2025 13:38:48 +0000
Date: Mon, 11 Aug 2025 14:38:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	ntfs3@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] vfs: exclude ntfs3 from file mode validation in
 may_open()
Message-ID: <20250811133848.GR222315@ZenIV>
References: <fb3888fb-11b8-481b-86a6-766bbbab5c81@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb3888fb-11b8-481b-86a6-766bbbab5c81@I-love.SAKURA.ne.jp>
Sender: Al Viro <viro@ftp.linux.org.uk>

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
> +			break;
> +		}
>  		VFS_BUG_ON_INODE(!IS_ANON_FILE(inode), inode);
>  	}
>  

Bravo, but that's several months late - would be lovely for an AFD posting.
In the current form the patch is obviously unacceptable; if we do that
kind of special-casing, the proper place is in register_filesystem() where
we clearly ought to compare fs->name with "ntfs" and return an error.

All jokes aside, this kind of stuff is a non-starter.  Blacklist it on
syzbot side or fix fs/ntfs3; VFS is *NOT* the place for this kind of
special-casing.

