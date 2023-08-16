Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E82177DEE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 12:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbjHPKhA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 06:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243744AbjHPKgw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:36:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7729210D;
        Wed, 16 Aug 2023 03:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C14762DEA;
        Wed, 16 Aug 2023 10:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853AEC433C7;
        Wed, 16 Aug 2023 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692182209;
        bh=nerAJyXVA4ES+ImnKfKNxEoNOi7kbivPUxasJMkEbc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=en3E4xG6nS6HIpteeuySupeYvX3QsSNgau+7VSHan2zdiskHNLK73Ky4hw4qGhmkU
         KAokV0FKTgaz6IDGGpRxIfbPpI9ejAZ6FdbxkqFarTN6cRu+kNANexxXSclOw/pRdQ
         jong+JtTWGuVYfdxKQZu7lwkgPrGnQvF2kr3LU703Gpjy2ZegAoI5pxXtkKHQxlA8M
         EWLiuwT1kO8IR1Kc9HFHmKWkQvldh7vxfAWdKSmi6hTpWwwSDB1DzBJU3XrsE1z+k2
         kEo8AHeF2wq8T8oAa9/awX68QdgSi/Vb5QpgP/Vv1he3CKvsrHG3EzLr0NwLBq61sp
         +6NoGJCT4/d9Q==
Date:   Wed, 16 Aug 2023 12:36:45 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] fs: Allow user to lock mount attributes with
 mount_setattr
Message-ID: <20230816-covern-kronzeuge-6d60381f598c@brauner>
References: <20230810090044.1252084-1-sargun@sargun.me>
 <20230810090044.1252084-2-sargun@sargun.me>
 <20230815-ableisten-offiziell-9b4de6357f7c@brauner>
 <CAMp4zn_RM+X8PBkAxXSuXrxbLTb2ndzVNXt10eaWj4uyWna30w@mail.gmail.com>
 <20230816-gauner-ehrung-95dc455055a0@brauner>
 <20230816.081541-lush.apricots.naughty.importer-1AIDZGMF3bd@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230816.081541-lush.apricots.naughty.importer-1AIDZGMF3bd@cyphar.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 16, 2023 at 06:56:25PM +1000, Aleksa Sarai wrote:
> On 2023-08-16, Christian Brauner <brauner@kernel.org> wrote:
> > On Tue, Aug 15, 2023 at 06:46:33AM -0700, Sargun Dhillon wrote:
> > > On Tue, Aug 15, 2023 at 2:30 AM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Thu, Aug 10, 2023 at 02:00:43AM -0700, Sargun Dhillon wrote:
> > > > > We support locking certain mount attributes in the kernel. This API
> > > > > isn't directly exposed to users. Right now, users can lock mount
> > > > > attributes by going through the process of creating a new user
> > > > > namespaces, and when the mounts are copied to the "lower privilege"
> > > > > domain, they're locked. The mount can be reopened, and passed around
> > > > > as a "locked mount".
> > > >
> > > > Not sure if that's what you're getting at but you can actually fully
> > > > create these locked mounts already:
> > > >
> > > > P1                                                 P2
> > > > # init userns + init mountns                       # init userns + init mountns
> > > > sudo mount --bind /foo /bar
> > > > sudo mount --bind -o ro,nosuid,nodev,noexec /bar
> > > >
> > > > # unprivileged userns + unprivileged mountns
> > > > unshare --mount --user --map-root
> > > >
> > > > mount --bind -oremount
> > > >
> > > > fd = open_tree(/bar, OPEN_TREE_CLONE)
> > > >
> > > > send(fd_send, P2);
> > > >
> > > >                                                    recv(&fd_recv, P1)
> > > >
> > > >                                                    move_mount(fd_recv, /locked-mnt);
> > > >
> > > > and now you have a fully locked mount on the host for P2. Did you mean that?
> > > >
> > > 
> > > Yep. Doing this within a program without clone / fork is awkward. Forking and
> > > unsharing in random C++ programs doesn't always go super well, so in my
> > > mind it'd be nice to have an API to do this directly.
> > > 
> > > In addition, having the superblock continue to be owned by the userns that
> > > its mounted in is nice because then they can toggle the other mount attributes
> > > (nodev, nosuid, noexec are the ones we care about).
> > > 
> > > > >
> > > > > Locked mounts are useful, for example, in container execution without
> > > > > user namespaces, where you may want to expose some host data as read
> > > > > only without allowing the container to remount the mount as mutable.
> > > > >
> > > > > The API currently requires that the given privilege is taken away
> > > > > while or before locking the flag in the less privileged position.
> > > > > This could be relaxed in the future, where the user is allowed to
> > > > > remount the mount as read only, but once they do, they cannot make
> > > > > it read only again.
> > > >
> > > > s/read only/read write/
> > > >
> > > > >
> > > > > Right now, this allows for all flags that are lockable via the
> > > > > userns unshare trick to be locked, other than the atime related
> > > > > ones. This is because the semantics of what the "less privileged"
> > > > > position is around the atime flags is unclear.
> > > >
> > > > I think that atime stuff doesn't really make sense to expose to
> > > > userspace. That seems a bit pointless imho.
> > > >
> > > > >
> > > > > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > > > > ---
> > > > >  fs/namespace.c             | 40 +++++++++++++++++++++++++++++++++++---
> > > > >  include/uapi/linux/mount.h |  2 ++
> > > > >  2 files changed, 39 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > > > index 54847db5b819..5396e544ac84 100644
> > > > > --- a/fs/namespace.c
> > > > > +++ b/fs/namespace.c
> > > > > @@ -78,6 +78,7 @@ static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> > > > >  struct mount_kattr {
> > > > >       unsigned int attr_set;
> > > > >       unsigned int attr_clr;
> > > > > +     unsigned int attr_lock;
> > > >
> > > > So when I originally noted down this crazy idea
> > > > https://github.com/uapi-group/kernel-features
> > > > I didn't envision a new struct member but rather a flag that could be
> > > > raised in attr_set like MOUNT_ATTR_LOCK that would indicate for the
> > > > other flags in attr_set to become locked.
> > > >
> > > > So if we could avoid growing the struct pointlessly I'd prefer that. Is
> > > > there a reason that wouldn't work?
> > > No reason. The semantics were just a little more awkward, IMHO.
> > > Specifically:
> > > * This attr could never be cleared, only set, which didn't seem to follow
> > > the attr_set / attr_clr semantics
> > > * If we ever introduced a mount_getattr call, you'd want to expose
> > > each of the locked bits independently, I'd think, and exposing
> > > that through one flag wouldn't give you the same fidelity.
> > 
> > Hm, right. So it's either new flags or a new member. @Aleksa?
> 
> I like ->attr_lock more tbh, especially since they cannot be cleared.
> They are implemented as mount flags internally, but conceptually locking
> flags is a separate thing to setting them.

Ok, it'd be neat if could do the sanity review of this api then as you
know the eventual users probably best.
