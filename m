Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CC737B5FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 08:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhELGWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 02:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhELGWl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 02:22:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A7F061421;
        Wed, 12 May 2021 06:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620800492;
        bh=7GrAGogiNytLpw09dpjSrM02BltUbgcUqUxsXxMrOgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hqOXed+ZNVysnq02BAG9rpTbLROUqpbcJsttKvmCQ/1rwrXaE0YACEq6GthHulXWW
         RVJHrOwG6o7RZAYYiLjnV/2RvmxV41+8xQtVW0V2ecHyr7+eLC0BxqWvgTyV3zR0UZ
         Q8cGcpUYD+jxZkyum59QfxLVsyUGlCmw9qhcKRg8=
Date:   Wed, 12 May 2021 08:21:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Tejun Heo <tj@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] kernfs: proposed locking and concurrency
 improvement
Message-ID: <YJtz6mmgPIwEQNgD@kroah.com>
References: <162077975380.14498.11347675368470436331.stgit@web.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162077975380.14498.11347675368470436331.stgit@web.messagingengine.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 08:38:35AM +0800, Ian Kent wrote:
> There have been a few instances of contention on the kernfs_mutex during
> path walks, a case on very large IBM systems seen by myself, a report by
> Brice Goglin and followed up by Fox Chen, and I've since seen a couple
> of other reports by CoreOS users.
> 
> The common thread is a large number of kernfs path walks leading to
> slowness of path walks due to kernfs_mutex contention.
> 
> The problem being that changes to the VFS over some time have increased
> it's concurrency capabilities to an extent that kernfs's use of a mutex
> is no longer appropriate. There's also an issue of walks for non-existent
> paths causing contention if there are quite a few of them which is a less
> common problem.
> 
> This patch series is relatively straight forward.
> 
> All it does is add the ability to take advantage of VFS negative dentry
> caching to avoid needless dentry alloc/free cycles for lookups of paths
> that don't exit and change the kernfs_mutex to a read/write semaphore.
> 
> The patch that tried to stay in VFS rcu-walk mode during path walks has
> been dropped for two reasons. First, it doesn't actually give very much
> improvement and, second, if there's a place where mistakes could go
> unnoticed it would be in that path. This makes the patch series simpler
> to review and reduces the likelihood of problems going unnoticed and
> popping up later.
> 
> The patch to use a revision to identify if a directory has changed has
> also been dropped. If the directory has changed the dentry revision
> needs to be updated to avoid subsequent rb tree searches and after
> changing to use a read/write semaphore the update also requires a lock.
> But the d_lock is the only lock available at this point which might
> itself be contended.
> 
> Changes since v3:
> - remove unneeded indirection when referencing the super block.
> - check if inode attribute update is actually needed.
> 
> Changes since v2:
> - actually fix the inode attribute update locking.
> - drop the patch that tried to stay in rcu-walk mode.
> - drop the use a revision to identify if a directory has changed patch.
> 
> Changes since v1:
> - fix locking in .permission() and .getattr() by re-factoring the attribute
>   handling code.
> ---
> 
> Ian Kent (5):
>       kernfs: move revalidate to be near lookup
>       kernfs: use VFS negative dentry caching
>       kernfs: switch kernfs to use an rwsem
>       kernfs: use i_lock to protect concurrent inode updates
>       kernfs: add kernfs_need_inode_refresh()
> 
> 
>  fs/kernfs/dir.c             | 170 ++++++++++++++++++++----------------
>  fs/kernfs/file.c            |   4 +-
>  fs/kernfs/inode.c           |  45 ++++++++--
>  fs/kernfs/kernfs-internal.h |   5 +-
>  fs/kernfs/mount.c           |  12 +--
>  fs/kernfs/symlink.c         |   4 +-
>  include/linux/kernfs.h      |   2 +-
>  7 files changed, 147 insertions(+), 95 deletions(-)
> 
> --
> Ian
> 

Any benchmark numbers that you ran that are better/worse with this patch
series?  That woul dbe good to know, otherwise you aren't changing
functionality here, so why would we take these changes?  :)

thanks,

greg k-h
