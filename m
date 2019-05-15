Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0FC1EA3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 10:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfEOIgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 04:36:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:35490 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfEOIgL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 04:36:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A3C9AF95;
        Wed, 15 May 2019 08:36:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7DEF41E3CA1; Wed, 15 May 2019 10:36:07 +0200 (CEST)
Date:   Wed, 15 May 2019 10:36:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] Sort out fsnotify_nameremove() mess
Message-ID: <20190515083607.GE11965@quack2.suse.cz>
References: <20190514221901.29125-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514221901.29125-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Wed 15-05-19 01:18:57, Amir Goldstein wrote:
> I started out working on your suggestion [1] of annotating
> simple_unlink/rmdir_notify() callers when I realized we could
> do better (IMO).
> 
> Please see this RFC. If you like the idea, I can split patches 3-4
> to per filesystem patches and a final patch to make the switch from
> fsnotify_nameremove() to fsnotify_remove().
> 
> I audited all the d_delete() call sites that will NOT generate
> fsnotify events after these changes and noted to myself why that
> makes sense.  I will include those notes in next posting if this
> works out for you.
> 
> Note that configfs got a special treatment, because its helpers
> that call simple_unlink/rmdir() are called from both vfs_XXX code
> path and non vfs_XXX code path.

Thanks for working on this! I like the series. I would structure it
somewhat differently - see my comments to individual patches - but the end
result looks OK to me. And yes, notes about d_delete() call sites would
make it easier to verify that we didn't miss anything :) so I'd be happy if
you posted them.

								Honza

> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20190513163309.GE13297@quack2.suse.cz/
> 
> Amir Goldstein (4):
>   fs: create simple_remove() helper
>   fsnotify: add empty fsnotify_remove() hook
>   fs: convert filesystems to use simple_remove() helper
>   fsnotify: move fsnotify_nameremove() hook out of d_delete()
> 
>  arch/s390/hypfs/inode.c            |  9 ++-----
>  drivers/infiniband/hw/qib/qib_fs.c |  3 +--
>  fs/afs/dir_silly.c                 |  5 ----
>  fs/btrfs/ioctl.c                   |  4 ++-
>  fs/configfs/dir.c                  |  3 +++
>  fs/dcache.c                        |  2 --
>  fs/debugfs/inode.c                 | 20 +++------------
>  fs/devpts/inode.c                  |  1 +
>  fs/libfs.c                         | 25 ++++++++++++++++++
>  fs/namei.c                         |  2 ++
>  fs/nfs/unlink.c                    |  6 -----
>  fs/notify/fsnotify.c               | 41 ------------------------------
>  fs/tracefs/inode.c                 | 23 +++--------------
>  include/linux/fs.h                 |  1 +
>  include/linux/fsnotify.h           | 18 +++++++++++++
>  include/linux/fsnotify_backend.h   |  4 ---
>  net/sunrpc/rpc_pipe.c              | 16 ++----------
>  security/apparmor/apparmorfs.c     |  6 +----
>  18 files changed, 67 insertions(+), 122 deletions(-)
> 
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
