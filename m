Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97172A8011
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 14:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbgKENzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 08:55:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:40580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgKENzI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:55:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DDE1FAAF1;
        Thu,  5 Nov 2020 13:55:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 39B271E130F; Thu,  5 Nov 2020 14:55:06 +0100 (CET)
Date:   Thu, 5 Nov 2020 14:55:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, miklos <miklos@szeredi.hu>,
        amir73il <amir73il@gmail.com>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        charliecgxu <charliecgxu@tencent.com>
Subject: Re: [RFC PATCH v2 2/8] ovl: implement ->writepages operation
Message-ID: <20201105135506.GF32718@quack2.suse.cz>
References: <20201025034117.4918-1-cgxu519@mykernel.net>
 <20201025034117.4918-3-cgxu519@mykernel.net>
 <20201102171741.GE23988@quack2.suse.cz>
 <175933181cc.ed06c3957114.1028981429730337490@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175933181cc.ed06c3957114.1028981429730337490@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-11-20 20:18:16, Chengguang Xu wrote:
>  ---- 在 星期二, 2020-11-03 01:17:41 Jan Kara <jack@suse.cz> 撰写 ----
>  > On Sun 25-10-20 11:41:11, Chengguang Xu wrote:
>  > > Implement overlayfs' ->writepages operation so that
>  > > we can sync dirty data/metadata to upper filesystem.
>  > > 
>  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > > ---
>  > >  fs/overlayfs/inode.c | 26 ++++++++++++++++++++++++++
>  > >  1 file changed, 26 insertions(+)
>  > > 
>  > > diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
>  > > index b584dca845ba..f27fc5be34df 100644
>  > > --- a/fs/overlayfs/inode.c
>  > > +++ b/fs/overlayfs/inode.c
>  > > @@ -11,6 +11,7 @@
>  > >  #include <linux/posix_acl.h>
>  > >  #include <linux/ratelimit.h>
>  > >  #include <linux/fiemap.h>
>  > > +#include <linux/writeback.h>
>  > >  #include "overlayfs.h"
>  > >  
>  > >  
>  > > @@ -516,7 +517,32 @@ static const struct inode_operations ovl_special_inode_operations = {
>  > >      .update_time    = ovl_update_time,
>  > >  };
>  > >  
>  > > +static int ovl_writepages(struct address_space *mapping,
>  > > +              struct writeback_control *wbc)
>  > > +{
>  > > +    struct inode *upper_inode = ovl_inode_upper(mapping->host);
>  > > +    struct ovl_fs *ofs =  mapping->host->i_sb->s_fs_info;
>  > > +    struct writeback_control tmp_wbc = *wbc;
>  > > +
>  > > +    if (!ovl_should_sync(ofs))
>  > > +        return 0;
>  > > +
>  > > +    /*
>  > > +     * for sync(2) writeback, it has a separate external IO
>  > > +     * completion path by checking PAGECACHE_TAG_WRITEBACK
>  > > +     * in pagecache, we have to set for_sync to 0 in thie case,
>  > > +     * let writeback waits completion after syncing individual
>  > > +     * dirty inode, because we haven't implemented overlayfs'
>  > > +     * own pagecache yet.
>  > > +     */
>  > > +    if (wbc->for_sync && (wbc->sync_mode == WB_SYNC_ALL))
>  > > +        tmp_wbc.for_sync = 0;
>  > 
>  > This looks really hacky as it closely depends on the internal details of
>  > writeback implementation. I'd be more open to say export wait_sb_inodes()
>  > for overlayfs use... Because that's what I gather you need in your
>  > overlayfs ->syncfs() implementation.
>  > 
> 
> Does  that mean we gather synced overlay's inode into a new waiting list(overlay's) and
> do the waiting behavior in overlay's ->syncfs() ?

My idea was that you'd just use the standard writeback logic which ends up
gathering upper_sb inodes in the upper_sb->s_inodes_wb and then wait for
them in overlay's ->syncfs(). Maybe we'll end up waiting for more inodes
than strictly necessary but it shouldn't be too bad I'd say...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
