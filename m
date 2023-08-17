Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABBF77F9BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352355AbjHQOyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352408AbjHQOyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:54:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2851E42
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:54:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39E576737B
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 14:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F75C433C7;
        Thu, 17 Aug 2023 14:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692284076;
        bh=a0WixMQ191OP3FgX2Ha1TGbjaLM+cCuuyIYqTM9xB3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eNYVjya10/uuxD9hXULMNgxUHHWcD+IBCG7VPMTjjKq7EoAaciR8EXNw80aI6BiKG
         3lyNgWcbRUw5EpzPVonsavWPxmcjKUC+8NuY1daFgLxe581hp+YxRjZC8qR/lN1bvJ
         ++Gq/P8lFnE//WaeAO0Cxed2ATFK+fAnx8MsSvQyg1YEkrn9QZZA2YgAMKUH02sd2e
         p9Sya5HQRCeubYahXCqjexAb1R+r5mekwwMv74qFxqqPTr6fg0luh9Mw6Ab6P4CdFK
         OkGoXdWd0p0qa8Jcrldesmwghslk3gTAZZBT7rSD/lU5KlQqd8FHqLu2Fgn8rEIxfm
         Bh/xyagxpx9Vg==
Date:   Thu, 17 Aug 2023 16:54:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] super: wait until we passed kill super
Message-ID: <20230817-fachkenntnis-reaktion-cb4b87702365@brauner>
References: <20230817-vfs-super-fixes-v3-v1-0-06ddeca7059b@kernel.org>
 <20230817-vfs-super-fixes-v3-v1-3-06ddeca7059b@kernel.org>
 <20230817143736.u22c5o5sesojlo3y@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230817143736.u22c5o5sesojlo3y@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 17, 2023 at 04:37:36PM +0200, Jan Kara wrote:
> On Thu 17-08-23 12:47:44, Christian Brauner wrote:
> > Recent rework moved block device closing out of sb->put_super() and into
> > sb->kill_sb() to avoid deadlocks as s_umount is held in put_super() and
> > blkdev_put() can end up taking s_umount again.
> > 
> > That means we need to move the removal of the superblock from @fs_supers
> > out of generic_shutdown_super() and into deactivate_locked_super() to
> > ensure that concurrent mounters don't fail to open block devices that
> > are still in use because blkdev_put() in sb->kill_sb() hasn't been
> > called yet.
> > 
> > We can now do this as we can make iterators through @fs_super and
> > @super_blocks wait without holding s_umount. Concurrent mounts will wait
> > until a dying superblock is fully dead so until sb->kill_sb() has been
> > called and SB_DEAD been set. Concurrent iterators can already discard
> > any SB_DYING superblock.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/super.c         | 71 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  include/linux/fs.h |  1 +
> >  2 files changed, 66 insertions(+), 6 deletions(-)
> 
> <snip>
> 
> > @@ -456,6 +497,25 @@ void deactivate_locked_super(struct super_block *s)
> >  		list_lru_destroy(&s->s_dentry_lru);
> >  		list_lru_destroy(&s->s_inode_lru);
> >  
> > +		/*
> > +		 * Remove it from @fs_supers so it isn't found by new
> > +		 * sget{_fc}() walkers anymore. Any concurrent mounter still
> > +		 * managing to grab a temporary reference is guaranteed to
> > +		 * already see SB_DYING and will wait until we notify them about
> > +		 * SB_DEAD.
> > +		 */
> > +		spin_lock(&sb_lock);
> > +		hlist_del_init(&s->s_instances);
> > +		spin_unlock(&sb_lock);
> > +
> > +		/*
> > +		 * Let concurrent mounts know that this thing is really dead.
> > +		 * We don't need @sb->s_umount here as every concurrent caller
> > +		 * will see SB_DYING and either discard the superblock or wait
> > +		 * for SB_DEAD.
> > +		 */
> > +		super_wake(s, SB_DEAD);
> > +
> >  		put_filesystem(fs);
> >  		put_super(s);
> >  	} else {
> > @@ -638,15 +698,14 @@ void generic_shutdown_super(struct super_block *sb)
> >  			spin_unlock(&sb->s_inode_list_lock);
> >  		}
> >  	}
> > -	spin_lock(&sb_lock);
> > -	/* should be initialized for __put_super_and_need_restart() */
> > -	hlist_del_init(&sb->s_instances);
> > -	spin_unlock(&sb_lock);
> 
> OK, but we have several checks of hlist_unhashed(&sb->s_instances) in the
> code whose meaning is now subtly changed. We have:

If by changed meaning you mean they can be dropped, then yes.
That's what I understand you as saying given the following list.

>   trylock_super() - needs SB_DYING check instead of s_instances check
>   __iterate_supers() - probably we should add SB_DYING check to not block
>     emergency operations on s_umount unnecessarily and drop s_instances
>     check
>   iterate_supers() - we can drop s_instances check
>   get_super() - we can drop s_instances check
>   get_active_super() - we can drop s_instances check
>   user_get_super() - we can drop s_instances check

But does this otherwise look reasonable?

(Btw, just because I noticed it, do you prefer suse.cz or suse.com?)
