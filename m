Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BEC77033A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjHDOg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 10:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjHDOg4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:36:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A209849CB;
        Fri,  4 Aug 2023 07:36:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 364EB62056;
        Fri,  4 Aug 2023 14:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B61C433C7;
        Fri,  4 Aug 2023 14:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691159813;
        bh=UGhPfacMbRAO/lKAFHEUnYispo56TB5sRURJt2YhJQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mpmg0Lgj6UTu9mzmGMaXEoKghX61CQcLZjiIJJi0ITZ8GVSumLzKJAlF2MWB4sN/w
         RHjrOXupIq56qjIPM2JLYS/gvOtuDco1ZQY6djFdKYtsg+1dFfGSBSKLWAeuI0HsHb
         oGkHGBjQ/uJ+OJwp7FQ0lclQtMsq4+cHLVkE7xkHd7jWypsmhg7VUj3MA/ipK/eO4F
         7ctCpwMMZDXSUFlt3EwHCFO3BljrmpmFACzaZ8Wld6tiOwaEgu44HGtbvwi74pBPxQ
         YTPX8Y483ZV/uQueja6g/4cpzbTVpqPTRy05hI+m0CTmlBjrpcg70Om6Nk/nhbJFde
         +2VD5Ox4lVjzw==
Date:   Fri, 4 Aug 2023 16:36:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     syzbot <syzbot+2faac0423fdc9692822b@syzkaller.appspotmail.com>,
        jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in
 test_bdev_super_fc
Message-ID: <20230804-allheilmittel-teleobjektiv-a0351a653d31@brauner>
References: <00000000000058d58e06020c1cab@google.com>
 <20230804101408.GA23274@lst.de>
 <20230804-abstieg-behilflich-eda2ce9c2c0f@brauner>
 <20230804140201.GA27600@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230804140201.GA27600@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:02:01PM +0200, Christoph Hellwig wrote:
> On Fri, Aug 04, 2023 at 03:20:45PM +0200, Christian Brauner wrote:
> > On Fri, Aug 04, 2023 at 12:14:08PM +0200, Christoph Hellwig wrote:
> > > FYI, I can reproduce this trivially locally, but even after spending a
> > > significant time with the trace I'm still puzzled at what is going
> > > on.  I've started trying to make sense of the lockdep report about
> > > returning to userspace with s_umount held, originall locked in
> > > get_tree_bdev and am still missing how it could happen.
> > 
> > So in the old scheme:
> > 
> > s = alloc_super()
> > -> down_write_nested(&s->s_umount, SINGLE_DEPTH_NESTING);
> > 
> > and assume you're not finding an old one immediately afterwards you'd
> > 
> > -> spin_lock(&sb_lock)
> > 
> > static int set_bdev_super(struct super_block *s, void *data)
> > {
> >         s->s_bdev = data;
> >         s->s_dev = s->s_bdev->bd_dev;
> >         s->s_bdi = bdi_get(s->s_bdev->bd_disk->bdi);
> > 
> >         if (bdev_stable_writes(s->s_bdev))
> >                 s->s_iflags |= SB_I_STABLE_WRITES;
> >         return 0;
> > }
> > 
> > -> spin_unlock(&sb_lock)
> > 
> > in the new scheme you're doing:
> > 
> > s = alloc_super()
> > -> down_write_nested(&s->s_umount, SINGLE_DEPTH_NESTING);
> > 
> > and assume you're not finding an old one immediately afterwards you'd
> > 
> > up_write(&s->s_umount);
> > 
> > error = setup_bdev_super(s, fc->sb_flags, fc);
> > -> spin_lock(&sb_lock);
> >    sb->s_bdev = bdev;
> >    sb->s_bdi = bdi_get(bdev->bd_disk->bdi);
> >    if (bdev_stable_writes(bdev))
> >            sb->s_iflags |= SB_I_STABLE_WRITES;
> > -> spin_unlock(&sb_lock);
> > 
> > down_write(&s->s_umount);
> > 
> > Which looks like the lock ordering here is changed?
> 
> Yes, that none only should be safe, but more importantly should not
> lead to a return to userspace with s_umount held.
> 
> Anyway, debugging a regression in mainline right now so I'm taking a
> break from this one.

FFS

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index c59b230d55b4..96023fac1ed8 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -590,10 +590,7 @@ static void romfs_kill_sb(struct super_block *sb)
        }
 #endif
 #ifdef CONFIG_ROMFS_ON_BLOCK
-       if (sb->s_bdev) {
-               kill_block_super(sb);
-               return;
-       }
+       kill_block_super(sb);
 #endif
 }
