Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C359770275
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 16:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjHDOCJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjHDOCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:02:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBC4171D;
        Fri,  4 Aug 2023 07:02:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 523FC68AA6; Fri,  4 Aug 2023 16:02:01 +0200 (CEST)
Date:   Fri, 4 Aug 2023 16:02:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+2faac0423fdc9692822b@syzkaller.appspotmail.com>,
        jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in
 test_bdev_super_fc
Message-ID: <20230804140201.GA27600@lst.de>
References: <00000000000058d58e06020c1cab@google.com> <20230804101408.GA23274@lst.de> <20230804-abstieg-behilflich-eda2ce9c2c0f@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804-abstieg-behilflich-eda2ce9c2c0f@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:20:45PM +0200, Christian Brauner wrote:
> On Fri, Aug 04, 2023 at 12:14:08PM +0200, Christoph Hellwig wrote:
> > FYI, I can reproduce this trivially locally, but even after spending a
> > significant time with the trace I'm still puzzled at what is going
> > on.  I've started trying to make sense of the lockdep report about
> > returning to userspace with s_umount held, originall locked in
> > get_tree_bdev and am still missing how it could happen.
> 
> So in the old scheme:
> 
> s = alloc_super()
> -> down_write_nested(&s->s_umount, SINGLE_DEPTH_NESTING);
> 
> and assume you're not finding an old one immediately afterwards you'd
> 
> -> spin_lock(&sb_lock)
> 
> static int set_bdev_super(struct super_block *s, void *data)
> {
>         s->s_bdev = data;
>         s->s_dev = s->s_bdev->bd_dev;
>         s->s_bdi = bdi_get(s->s_bdev->bd_disk->bdi);
> 
>         if (bdev_stable_writes(s->s_bdev))
>                 s->s_iflags |= SB_I_STABLE_WRITES;
>         return 0;
> }
> 
> -> spin_unlock(&sb_lock)
> 
> in the new scheme you're doing:
> 
> s = alloc_super()
> -> down_write_nested(&s->s_umount, SINGLE_DEPTH_NESTING);
> 
> and assume you're not finding an old one immediately afterwards you'd
> 
> up_write(&s->s_umount);
> 
> error = setup_bdev_super(s, fc->sb_flags, fc);
> -> spin_lock(&sb_lock);
>    sb->s_bdev = bdev;
>    sb->s_bdi = bdi_get(bdev->bd_disk->bdi);
>    if (bdev_stable_writes(bdev))
>            sb->s_iflags |= SB_I_STABLE_WRITES;
> -> spin_unlock(&sb_lock);
> 
> down_write(&s->s_umount);
> 
> Which looks like the lock ordering here is changed?

Yes, that none only should be safe, but more importantly should not
lead to a return to userspace with s_umount held.

Anyway, debugging a regression in mainline right now so I'm taking a
break from this one.
