Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDF4659C8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 22:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiL3VvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 16:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3VvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:51:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26F216598
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 13:51:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D00361C18
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 21:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D02C433D2;
        Fri, 30 Dec 2022 21:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672437061;
        bh=e44eKerxWmiOiXSV7kcffHCoBiXXUWVAXm8LhSN0RqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDhaHlzjM9ZYnYVbUUX+vwKWflqB+Eyh1B0NXl9dwntlhH/8eyNRtQkZIjaH8kSO/
         cyjGlgGo2x97JAq4k186IPznCciHu1Kv2s22GrAiHIK/4GOd+b/ej4+oFn1fTpoWYy
         FJYhEG911rXwdAc4/0UfRTtPAnVGq7Z2NOSlXW0mwmYcprsFHFsTuOf0GJBt3NEl1N
         fvI7CZUruoBRKc8pkeyUhVQHafZlwfwI4OLz3ooPi4lpkuPXjgbUj2eLOQpFk//nkH
         IOjTdUxO1u+z6Jg+jgtQcnaEkVafhKKbnc1067pG8fkj+QDm6RS90lKidfUDcng3ZF
         IpGScP8AjR9zQ==
Date:   Fri, 30 Dec 2022 13:51:00 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [Question] Unlinking original file of bind mounted file.
Message-ID: <Y69dRHaTLqgY+vLG@sol.localdomain>
References: <CAM7-yPQOZx85f3KxKO1feSPcwYTZGRNNVEgqn4D_+nhhXvqQzQ@mail.gmail.com>
 <Y67EPM+fIu41hlCO@casper.infradead.org>
 <CAM7-yPROANYjeGn3ECfqmn0sLzEQPUpzCyU5zSN3-mJv3UA4CA@mail.gmail.com>
 <CAM7-yPSDZG6Sd9pcm+5zXteMfKYujZ8bjpywwJV4whrmRr+ELQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPSDZG6Sd9pcm+5zXteMfKYujZ8bjpywwJV4whrmRr+ELQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 30, 2022 at 08:16:19PM +0900, Yun Levi wrote:
> > No, that's not correct.  Here's how to think about Unix files (not just
> > ext4, going all the way back to the 1970s).  Each inode has a reference
> > count.  All kinds of things hold a reference count to an inode; some of
> > the more common ones are a name in a directory, an open file, a mmap of
> > that open file, passing a file descriptor through a unix socket, etc, etc.
> >
> > Unlink removes a name from a directory.  That causes the reference count
> > to be decreased, but the inode will only be released if that causes the
> > reference count to drop to 0.  If the file is open, or it has multiple
> > names, it won't be removed.
> >
> > mount --bind obviously isn't traditional Unix, but it fits in the same
> > paradigm.  It causes a new reference count to be taken on the inode.
> > So you can remove the original name that was used to create the link,
> > and that causes i_nlink to drop to 0, but the in-memory refcount is
> > still positive, so the inode will not be reused.
> >
> 
> Actually, when the bind mount happens on the some file, it doesn't
> increase the inode->i_count,
> Instead of that, it increases dentry's refcount.
> So, If we do "mount --bind a b"
> it just increases the reference of dentry of a, not i_count of a.

Sure, but the dentry pins the inode.

> So, when rm -f a, it just put the reference of dentry

No, it doesn't change the refcount of the dentry.  The unlink does temporarily
increment, and then decrement, the refcount.  However, there is still another
reference that's held by the bind mount.  For that reason, the dentry's inode is
not released yet; instead, the dentry is just made unavailable to lookups.

> When the unlink on b, finally the dentry is killed and free the inode.

You can't actually do that, because the unlink fails with EBUSY.  And even if
you could, it would be a different dentry (b instead of a).

> Here is What I saw via crash

If you have a reproducer for an actual crash, please provide it.  (And if you do
indeed have an actual crash, please consider that its root cause may be
completely unrelated to the theory that you've described...)

- Eric
