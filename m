Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1055617984
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 10:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiKCJNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 05:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiKCJMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:12:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53580DF0C;
        Thu,  3 Nov 2022 02:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BF15B82680;
        Thu,  3 Nov 2022 09:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785AAC43470;
        Thu,  3 Nov 2022 09:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667466752;
        bh=h4rD3vVxeaaA5b2KcNeNlSt7tcbzEcaWs1xTxa/6b5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m5HZpgVVrkXMFVeFGK6HhpyLpeErlrBKoSuJdp3WNBEG+cfALg4wbFMWBmG6jscQp
         K9oj+BXci0SiS39eJT/dG7iCeX9upXYItDbu4WWX1Oc6hGilV7A0Xbr5NJSwS8yOV9
         eifhgnSKbCNPVjEfU2VnIWvQl0aFsRoMzDsUQLvhUiXwIeek5zLt5IIWisw3+VH7a1
         nSl0S8iTfuWg8lx+ocOW1vEItnvphIZkfE6T3tFvOsK3FIyIjulkuS+5KwKull5Wy0
         3yaUinLvNAPLrAWOh8dIkCLnQxdQVqMvugkQpK+nef91K9EaddA4RHzZ2Ja1DgSE4D
         YOfBYuiBUJtjA==
Date:   Thu, 3 Nov 2022 10:12:27 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Vasily Averin <vvs@openvz.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>, rcu@vger.kernel.org,
        Martin Pitt <mpitt@redhat.com>
Subject: Re: [PATCH 0/2] fs: fix capable() call in simple_xattr_list()
Message-ID: <20221103091227.mm2nzjj35dzv4dex@wittgenstein>
References: <20220901152632.970018-1-omosnace@redhat.com>
 <20220905090811.ocnnc53y2bow7m3i@wittgenstein>
 <CAFqZXNu_jf0D8LQLc15+ZrFne5F5F5PFNbkT-EkfqXvNdSKKsQ@mail.gmail.com>
 <20220905153036.zzcovknz7ntgcn5f@wittgenstein>
 <20221102182451.aoos5udhf6rbb6us@wittgenstein>
 <CAFqZXNuG0gjRjSMpaMJQqmmwtqr5Yx1r6Eg0YpJ4DQ6u9CWqRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFqZXNuG0gjRjSMpaMJQqmmwtqr5Yx1r6Eg0YpJ4DQ6u9CWqRA@mail.gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:04:25AM +0100, Ondrej Mosnacek wrote:
> On Wed, Nov 2, 2022 at 7:25 PM Christian Brauner <brauner@kernel.org> wrote:
> > On Mon, Sep 05, 2022 at 05:30:36PM +0200, Christian Brauner wrote:
> > > On Mon, Sep 05, 2022 at 12:15:01PM +0200, Ondrej Mosnacek wrote:
> > > > On Mon, Sep 5, 2022 at 11:08 AM Christian Brauner <brauner@kernel.org> wrote:
> > > > > On Thu, Sep 01, 2022 at 05:26:30PM +0200, Ondrej Mosnacek wrote:
> > > > > > The goal of these patches is to avoid calling capable() unconditionally
> > > > > > in simple_xattr_list(), which causes issues under SELinux (see
> > > > > > explanation in the second patch).
> > > > > >
> > > > > > The first patch tries to make this change safer by converting
> > > > > > simple_xattrs to use the RCU mechanism, so that capable() is not called
> > > > > > while the xattrs->lock is held. I didn't find evidence that this is an
> > > > > > issue in the current code, but it can't hurt to make that change
> > > > > > either way (and it was quite straightforward).
> > > > >
> > > > > Hey Ondrey,
> > > > >
> > > > > There's another patchset I'd like to see first which switches from a
> > > > > linked list to an rbtree to get rid of performance issues in this code
> > > > > that can be used to dos tmpfs in containers:
> > > > >
> > > > > https://lore.kernel.org/lkml/d73bd478-e373-f759-2acb-2777f6bba06f@openvz.org
> > > > >
> > > > > I don't think Vasily has time to continue with this so I'll just pick it
> > > > > up hopefully this or the week after LPC.
> > > >
> > > > Hm... does rbtree support lockless traversal? Because if not, that
> > >
> > > The rfc that Vasily sent didn't allow for that at least.
> > >
> > > > would make it impossible to fix the issue without calling capable()
> > > > inside the critical section (or doing something complicated), AFAICT.
> > > > Would rhashtable be a workable alternative to rbtree for this use
> > > > case? Skimming <linux/rhashtable.h> it seems to support both lockless
> > > > lookup and traversal using RCU. And according to its manpage,
> > > > *listxattr(2) doesn't guarantee that the returned names are sorted.
> > >
> > > I've never used the rhashtable infrastructure in any meaningful way. All
> > > I can say from looking at current users that it looks like it could work
> > > well for us here:
> > >
> > > struct simple_xattr {
> > >       struct rhlist_head rhlist_head;
> > >       char *name;
> > >       size_t size;
> > >       char value[];
> > > };
> > >
> > > static const struct rhashtable_params simple_xattr_rhashtable = {
> > >       .head_offset = offsetof(struct simple_xattr, rhlist_head),
> > >       .key_offset = offsetof(struct simple_xattr, name),
> > >
> > > or sm like this.
> >
> > I have a patch in rough shape that converts struct simple_xattr to use
> > an rhashtable:
> >
> > https://gitlab.com/brauner/linux/-/commits/fs.xattr.simple.rework/
> >
> > Light testing, not a lot useful comments and no meaningful commit
> > message as of yet but I'll get to that.
> 
> Looks mostly good at first glance. I left comments for some minor
> stuff I noticed.
> 
> > Even though your issue is orthogonal to the performance issues I'm
> > trying to fix I went back to your patch, Ondrej to apply it on top.
> > But I think it has one problem.
> >
> > Afaict, by moving the capable() call from the top of the function into
> > the actual traversal portion an unprivileged user can potentially learn
> > whether a file has trusted.* xattrs set. At least if dmesg isn't
> > restricted on the kernel. That may very well be the reason why the
> > capable() call is on top.
> 
> Technically it would be possible, for example with SELinux if the
> audit daemon is dead. Not a likely situation, but I agree it's better
> to be safe.
> 
> > (Because the straightforward fix for this would be to just call
> > capable() a single time if at least one trusted xattr is encountered and
> > store the result. That's pretty easy to do by making turning the trusted
> > variable into an int, setting it to -1, and only if it's -1 and a
> > trusted xattr has been found call capable() and store the result.)
> 
> That would also run into the conundrum of holding a lock while
> (potentially) calling into the LSM subsystem. And would it even fix
> the information leak? Unless I'm missing something it would only
> prevent a leak of the trusted xattr count, but not the presence of any
> trusted xattr.

No it wouldn't. I just meant this to illustrate that with your patch we
could've made it so that capable() would've only been called once.

> 
> > One option to fix all of that is to switch simple_xattr_list() to use
> >
> >         ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)
> >
> > which doesn't generate an audit event.
> >
> > I think this is even the correct thing to do as listing xattrs isn't a
> > targeted operation. IOW, if the the user had used getxattr() to request
> > a trusted.* xattr then logging a denial makes sense as the user
> > explicitly wanted to retrieve a trusted.* xattr. But if the user just
> > requested to list all xattrs then silently skipping trusted without
> > logging an explicit denial xattrs makes sense.
> >
> > Does that sound acceptable?
> 
> Yes, I can't see any reason why that wouldn't be the best solution.
> Why haven't I thought of that? :)
> 
> I guess you will want to submit a patch for it along with your
> rhashtable patch to avoid a conflict? Or would you like me to submit
> it separately?

I think you can send a patch for this separately as we don't need to
massage the data structure for this.

I think we can reasonably give this a

Fixes: 38f38657444d ("xattr: extract simple_xattr code from tmpfs") # no backport

But note the "# no backport" as imho it isn't worth backporting this to
older kernels unless that's really desirable.
