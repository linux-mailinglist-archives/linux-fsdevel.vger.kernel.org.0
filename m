Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2E76EA3D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 08:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDUG2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 02:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDUG2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:28:44 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7BB6181
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 23:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hcTpsrTtmH+lGipKTKfMbMIVbOoUOUkMsc0nQJdFKu8=; b=VUpCDATBjykhiceXWcFnEsetAF
        PfJ/f1Ox/v4MUjlBUbliKEJMFwzDZ88rupMG2IhzvojjmZUh2ieEe4Hgf058nN0Mcs4gH0WAI8C5w
        v2oH240IZQIwm0T5deCWk/aWwTNHAaIUp4SDLHKutmiVe6rX+fcEEL27hFERdHGRS8xIY9vcHK1OI
        Ls4SxX8KRY5ZHoItYdBJF8r0VSmJMHvBlt3VD8+3fGTjr2h/FS+ZmBlVjYZ2W6WZa8l+9YFJgQbsY
        VbdxhJQkOGLCcGSQsSTQhnLBUv40SYSx+UOWVkzU1SPgub0JtwRNMjoCTBI4y0wlOY22H+AetI0NX
        OhXxB1uQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppkG6-00B6BV-3C;
        Fri, 21 Apr 2023 06:28:39 +0000
Date:   Fri, 21 Apr 2023 07:28:38 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Seth Forshee <sforshee@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 3/5] fs: fix __lookup_mnt() documentation
Message-ID: <20230421062838.GD3390869@ZenIV>
References: <20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org>
 <20230202-fs-move-mount-replace-v1-3-9b73026d5f10@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202-fs-move-mount-replace-v1-3-9b73026d5f10@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 18, 2023 at 04:51:59PM +0100, Christian Brauner wrote:
> The comment on top of __lookup_mnt() states that it finds the first
> mount implying that there could be multiple mounts mounted at the same
> dentry with the same parent.
> 
> This was true on old kernels where __lookup_mnt() could encounter a
> stack of child mounts such that each child had the same parent mount and
> was mounted at the same dentry. These were called "shadow mounts" and
> were created during mount propagation. So back then if a mount @m in the
> destination propagation tree already had a child mount @p mounted at
> @mp then any mount @n we propagated to @m at the same @mp would be
> appended after the preexisting mount @p in @mount_hashtable.
> 
> This hasn't been the case for quite a while now and I don't see an
> obvious way how such mount stacks could be created in another way.

Not quite, actually - there's a nasty corner case where mnt_change_mountpoint()
would create those.  And your subsequent patch steps into the same fun.
Look: suppose the root of the tree you are feeding to attach_recursive_mnt()
has managed to grow a mount right on top of its root.  The same will be
reproduced in all its copies created by propagate_mnt().  Now, suppose
one of the slaves of the place where we are trying to mount it on already
has something mounted on it.  Well, we hit this:
                q = __lookup_mnt(&child->mnt_parent->mnt,
				 child->mnt_mountpoint);
		if (q)
			mnt_change_mountpoint(child, smp, q);
which will tuck the child (a copy we'd made) under q (existing mount on
top of the place that copy is for).  Result: 'q' overmounts the root of
'child' now.  So does the copy of whatever had been overmounting the
root of 'source_mnt'...

And yes, it can happen.  Consider e.g. do_loopback(); we have looked
up the mountpoint ('path'), we have looked up the subtree to copy
('old_path'), we had lock_mount(path) made sure that namespace_sem
is held *and* path is not overmounted (followed into whatever
overmounts that might have happened since we looked the mountpoint
up).  Now, think what happens if 'old_path' is also overmounted while
we are trying to get namespace_sem...

A similar scenario exists for do_move_mount(), and there it's in
a sense worse - there we have to cope with the possibility that
from_dfd is an O_PATH descriptor created by fsmount().  And I'm
not at all convinced that we can't arrange for automount point
to be there and be triggered by the time of move_mount(2)...
The reason it's worse is that here we can't just follow mounts
all the way down - we want to take the entire mount tree associated
with that descriptor.

> And
> if that's possible it would invalidate assumptions made in other parts
> of the code.

Details?  I'm not saying it's impossible - we might have a real bug in
that area.
