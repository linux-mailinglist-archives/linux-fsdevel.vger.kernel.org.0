Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24C43453D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 01:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhCWA2d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 20:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230455AbhCWA2W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:28:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 096A3619AC;
        Tue, 23 Mar 2021 00:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616459302;
        bh=kB1iKyIkVp+5of0jUhEAoDEu5yIkWwoMlSfclhSGwyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CWJXQe7XWyhMgIjZQMz16RzEXK5ydEp+vSb3pGCFZnLiGIti+FJ1dL1WsCLZcE6rs
         fy41lk7J90/UqRKOip/L1Lsbdc6RF1ViMzCqkp9QXJYFd2ym9gD9B0gkipOGTx4c3e
         xvvuHI7jM8qQ/j8GjRchJqE+UwlF0dSlLj0OC9PNKZcjihg96fvNeRbdvD+uTlc8n3
         zDVgLw2ol3SJIlYGPEC6R5IL5p0/aCj1O5HGvcCWZBI3AQLRORjCxVUKUtniN65fSZ
         vAPooZ0OIOh4mp26pn31tQpAHpQK5s4F1uxNTNNjQm+4QY8aOnfGEXKc/cgukjjOMF
         mn3LuONP7x6kA==
Date:   Mon, 22 Mar 2021 17:28:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 07/18] f2fs: convert to miscattr
Message-ID: <YFk2JPmc7X7GFXni@gmail.com>
References: <20210203124112.1182614-1-mszeredi@redhat.com>
 <20210203124112.1182614-8-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203124112.1182614-8-mszeredi@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 03, 2021 at 01:41:01PM +0100, Miklos Szeredi wrote:
> @@ -3071,123 +3012,54 @@ static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
>  }
>  #endif
>  
> -/* FS_IOC_FSGETXATTR and FS_IOC_FSSETXATTR support */
> -
> -/*
> - * To make a new on-disk f2fs i_flag gettable via FS_IOC_FSGETXATTR and settable
> - * via FS_IOC_FSSETXATTR, add an entry for it to f2fs_xflags_map[], and add its
> - * FS_XFLAG_* equivalent to F2FS_SUPPORTED_XFLAGS.
> - */
> -
> -static const struct {
> -	u32 iflag;
> -	u32 xflag;
> -} f2fs_xflags_map[] = {
> -	{ F2FS_SYNC_FL,		FS_XFLAG_SYNC },
> -	{ F2FS_IMMUTABLE_FL,	FS_XFLAG_IMMUTABLE },
> -	{ F2FS_APPEND_FL,	FS_XFLAG_APPEND },
> -	{ F2FS_NODUMP_FL,	FS_XFLAG_NODUMP },
> -	{ F2FS_NOATIME_FL,	FS_XFLAG_NOATIME },
> -	{ F2FS_PROJINHERIT_FL,	FS_XFLAG_PROJINHERIT },
> -};

There's another comment just above which talks about FS_IOC_GETFLAGS and
FS_IOC_SETFLAGS:

	/* FS_IOC_GETFLAGS and FS_IOC_SETFLAGS support */

	/*
	 * To make a new on-disk f2fs i_flag gettable via FS_IOC_GETFLAGS, add an entry
	 * for it to f2fs_fsflags_map[], and add its FS_*_FL equivalent to
	 * F2FS_GETTABLE_FS_FL.  To also make it settable via FS_IOC_SETFLAGS, also add
	 * its FS_*_FL equivalent to F2FS_SETTABLE_FS_FL.
	 */

This patch seems to make that outdated, since now both FS_IOC_[GS]ETFLAGS and
FS_IOC_[GS]ETFSXATTR are handled together.

Can you please update the comment to properly describe what's going on?

- Eric
