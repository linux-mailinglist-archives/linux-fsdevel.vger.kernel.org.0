Return-Path: <linux-fsdevel+bounces-61094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E709B552AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 17:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E632D189DFCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3DE221D87;
	Fri, 12 Sep 2025 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggZNCJzA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B5928373;
	Fri, 12 Sep 2025 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689556; cv=none; b=eN6YxvLK3uJ7G6EZYhn6rwqk7nR3DpL5ML9UbmFTmLbQxFej72EtODs5kpZhcHbydwz7XAwuo+WvcPYa0qM/c3gZ6bWo/4WZ66fE/Ru4yjx2ygbppGriD484feDruwbyxUqnKIMNi87yj6WllURpQbKtYaPyRlN4axlnBQNdUoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689556; c=relaxed/simple;
	bh=FEMpsaKNILw1LWW9PgrPUEjyVRdy+lNTf4a93hFSDCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GivpWuhkcRKL7lhFFO2FQUgokPHAPN2Fn6Jjccn9OEG9v85+AEebWBmYqR1kExf0Gx+Z6Yy80OM94LxtnNzmGUSysoxPRnU2uoKBTcnGqG0ncXR+S+wNb2qZPSQVcB+2vMFB8VHoNa3ovTysvuMfpwMBt/OEfJgYSISD+/+i91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggZNCJzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DEEC4CEF1;
	Fri, 12 Sep 2025 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757689555;
	bh=FEMpsaKNILw1LWW9PgrPUEjyVRdy+lNTf4a93hFSDCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ggZNCJzAWraLvntXfeMfeiDI2AQwKSi/CMv4LAcRqcyZdoffP96etlBbO+MYrQfqM
	 uANsl9/UKx2G30zOXwChThSt5p/S5fE5/oq4rHaHh6O6XDgvzZ1s6zgtnX8udGrU6o
	 QQJ03wlo81mVR9YjY0q+rDdFvYc5SUl92asEqV1guQxQzsdX7SXYuMzcLEi+wx1hwn
	 0Bi+kRaO6+gJHsJnaQ9lG4Mnpk9jw//Us3nnQ/hHirYmPCPt5vLmgVmcZHitFv80lk
	 ZbvCFzo64rAGwDMkcYRULl4daHKpDZPLzcSL1BAQhhIsZIXOExU3J6h2U5Fd5iRx/f
	 fzRQSzX6+MT9g==
Date: Fri, 12 Sep 2025 08:05:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH (REPOST)] jfs: Verify inode mode when loading from disk
Message-ID: <20250912150555.GI1587915@frogsfrogsfrogs>
References: <1cd51309-096d-497f-8c5e-b0c9cca102fc@I-love.SAKURA.ne.jp>
 <dce0adb2-a592-44d8-b208-d939415b8d54@I-love.SAKURA.ne.jp>
 <a471c731-e6ae-408d-b8b8-94f3045b2966@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a471c731-e6ae-408d-b8b8-94f3045b2966@I-love.SAKURA.ne.jp>

On Fri, Sep 12, 2025 at 11:18:44PM +0900, Tetsuo Handa wrote:
> The inode mode loaded from corrupted disk can be invalid. Do like what
> commit 0a9e74051313 ("isofs: Verify inode mode when loading from disk")
> does.
> 
> Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> This fix is similar to fixes for other filesystems, but got no response.
> Do we have to wait for Ack from Dave Kleikamp for another month?

Let's hope not, this is a validation issue...

>  fs/jfs/inode.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
> index fcedeb514e14..21f3d029da7d 100644
> --- a/fs/jfs/inode.c
> +++ b/fs/jfs/inode.c
> @@ -59,9 +59,15 @@ struct inode *jfs_iget(struct super_block *sb, unsigned long ino)
>  			 */
>  			inode->i_link[inode->i_size] = '\0';
>  		}
> -	} else {
> +	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
> +		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
>  		inode->i_op = &jfs_file_inode_operations;
>  		init_special_inode(inode, inode->i_mode, inode->i_rdev);
> +	} else {
> +		printk(KERN_DEBUG "JFS: Invalid file type 0%04o for inode %lu.\n",
> +		       inode->i_mode, inode->i_ino);
> +		iget_failed(inode);
> +		return ERR_PTR(-EIO);

...but how about EFSCORRUPTED instead of EIO here?  Several filesystems
(xfs, ext*, erofs, f2fs, fuse, ocfs2, udf) return that for corrupt
metadata.

--D

>  	}
>  	unlock_new_inode(inode);
>  	return inode;
> -- 
> 2.51.0
> 
> 

