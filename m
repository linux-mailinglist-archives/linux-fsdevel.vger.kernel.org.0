Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BC833C3DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 18:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhCOROm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 13:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233615AbhCOROL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:14:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BA3A64DE4;
        Mon, 15 Mar 2021 17:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615828451;
        bh=Zn0NuoF4FDwqU755pbTGkJmqJF85FYrm/Q6GdL4fBMM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EPa3+rhd80ZnlpYMaP4pX9n8jH+PLz+QOIvn1NMqsduGnTdJbSa/P7hExiVt+bBpG
         KXQ2jwDbwhkXu2hvaEyAv05jXLIa/JIC9bSANLBOmZHnezsF9mNSU1HMQOh3GbFKEC
         aPAx13ZG+83VbUIUnNW/O63NUqJb8xfnLzgFbUKaZYOz7dXXc6J+qyp0K5Bvp5pstG
         L1USJJoMG72jNI0Ms7tAnfAMLdPh+/VDaXhGNHQjEUMDXQ3vpMLcvmvHkqlYm/WxB2
         glQ1SeorO0gDYgMPptYN3BPiSqRY0grj2Q4kNDDYB5r62r6N2wEaP0BwLOxNqeeyDU
         ujKyv6WcVXU/w==
Message-ID: <cc056c4aed853cfc99f6a5555beae528f3a30c9b.camel@kernel.org>
Subject: Re: [PATCH v2 14/15] 9p: missing chunk of "fs/9p: Don't update file
 type when updating file attributes"
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Richard Weinberger <richard@nod.at>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Mar 2021 13:14:09 -0400
In-Reply-To: <20210313043824.1283821-14-viro@zeniv.linux.org.uk>
References: <YExBLBEbJRXDV19F@zeniv-ca.linux.org.uk>
         <20210313043824.1283821-1-viro@zeniv.linux.org.uk>
         <20210313043824.1283821-14-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2021-03-13 at 04:38 +0000, Al Viro wrote:
> In commit 45089142b149 Aneesh had missed one (admittedly, very unlikely
> to hit) case in v9fs_stat2inode_dotl().  However, the same considerations
> apply there as well - we have no business whatsoever to change ->i_rdev
> or the file type.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/9p/vfs_inode_dotl.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index df0b87b05c42..e1c0240b51c0 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -663,14 +663,10 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
>  		if (stat->st_result_mask & P9_STATS_NLINK)
>  			set_nlink(inode, stat->st_nlink);
>  		if (stat->st_result_mask & P9_STATS_MODE) {
> -			inode->i_mode = stat->st_mode;
> -			if ((S_ISBLK(inode->i_mode)) ||
> -						(S_ISCHR(inode->i_mode)))
> -				init_special_inode(inode, inode->i_mode,
> -								inode->i_rdev);
> +			mode = stat->st_mode & S_IALLUGO;
> +			mode |= inode->i_mode & ~S_IALLUGO;
> +			inode->i_mode = mode;
>  		}
> -		if (stat->st_result_mask & P9_STATS_RDEV)
> -			inode->i_rdev = new_decode_dev(stat->st_rdev);
>  		if (!(flags & V9FS_STAT2INODE_KEEP_ISIZE) &&
>  		    stat->st_result_mask & P9_STATS_SIZE)
>  			v9fs_i_size_write(inode, stat->st_size);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

