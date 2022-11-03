Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C9E6173F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 02:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiKCB7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 21:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKCB7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:59:42 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6795D5F69;
        Wed,  2 Nov 2022 18:59:40 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id A30B8AB3; Wed,  2 Nov 2022 20:59:38 -0500 (CDT)
Date:   Wed, 2 Nov 2022 20:59:38 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Vasily Averin <vvs@openvz.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>, rcu@vger.kernel.org,
        Martin Pitt <mpitt@redhat.com>
Subject: Re: [PATCH 0/2] fs: fix capable() call in simple_xattr_list()
Message-ID: <20221103015938.GA27053@mail.hallyn.com>
References: <20220901152632.970018-1-omosnace@redhat.com>
 <20220905090811.ocnnc53y2bow7m3i@wittgenstein>
 <CAFqZXNu_jf0D8LQLc15+ZrFne5F5F5PFNbkT-EkfqXvNdSKKsQ@mail.gmail.com>
 <20220905153036.zzcovknz7ntgcn5f@wittgenstein>
 <20221102182451.aoos5udhf6rbb6us@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102182451.aoos5udhf6rbb6us@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 07:24:51PM +0100, Christian Brauner wrote:
> On Mon, Sep 05, 2022 at 05:30:36PM +0200, Christian Brauner wrote:
> > On Mon, Sep 05, 2022 at 12:15:01PM +0200, Ondrej Mosnacek wrote:
> > > On Mon, Sep 5, 2022 at 11:08 AM Christian Brauner <brauner@kernel.org> wrote:
> > > > On Thu, Sep 01, 2022 at 05:26:30PM +0200, Ondrej Mosnacek wrote:
> > > > > The goal of these patches is to avoid calling capable() unconditionally
> > > > > in simple_xattr_list(), which causes issues under SELinux (see
> > > > > explanation in the second patch).
> > > > >
> > > > > The first patch tries to make this change safer by converting
> > > > > simple_xattrs to use the RCU mechanism, so that capable() is not called
> > > > > while the xattrs->lock is held. I didn't find evidence that this is an
> > > > > issue in the current code, but it can't hurt to make that change
> > > > > either way (and it was quite straightforward).
> > > >
> > > > Hey Ondrey,
> > > >
> > > > There's another patchset I'd like to see first which switches from a
> > > > linked list to an rbtree to get rid of performance issues in this code
> > > > that can be used to dos tmpfs in containers:
> > > >
> > > > https://lore.kernel.org/lkml/d73bd478-e373-f759-2acb-2777f6bba06f@openvz.org
> > > >
> > > > I don't think Vasily has time to continue with this so I'll just pick it
> > > > up hopefully this or the week after LPC.
> > > 
> > > Hm... does rbtree support lockless traversal? Because if not, that
> > 
> > The rfc that Vasily sent didn't allow for that at least.
> > 
> > > would make it impossible to fix the issue without calling capable()
> > > inside the critical section (or doing something complicated), AFAICT.
> > > Would rhashtable be a workable alternative to rbtree for this use
> > > case? Skimming <linux/rhashtable.h> it seems to support both lockless
> > > lookup and traversal using RCU. And according to its manpage,
> > > *listxattr(2) doesn't guarantee that the returned names are sorted.
> > 
> > I've never used the rhashtable infrastructure in any meaningful way. All
> > I can say from looking at current users that it looks like it could work
> > well for us here:
> > 
> > struct simple_xattr {
> > 	struct rhlist_head rhlist_head;
> > 	char *name;
> > 	size_t size;
> > 	char value[];
> > };
> > 
> > static const struct rhashtable_params simple_xattr_rhashtable = {
> > 	.head_offset = offsetof(struct simple_xattr, rhlist_head),
> > 	.key_offset = offsetof(struct simple_xattr, name),
> > 
> > or sm like this.
> 
> I have a patch in rough shape that converts struct simple_xattr to use
> an rhashtable:
> 
> https://gitlab.com/brauner/linux/-/commits/fs.xattr.simple.rework/
> 
> Light testing, not a lot useful comments and no meaningful commit
> message as of yet but I'll get to that.
> 
> Even though your issue is orthogonal to the performance issues I'm
> trying to fix I went back to your patch, Ondrej to apply it on top.
> But I think it has one problem.
> 
> Afaict, by moving the capable() call from the top of the function into
> the actual traversal portion an unprivileged user can potentially learn
> whether a file has trusted.* xattrs set. At least if dmesg isn't
> restricted on the kernel. That may very well be the reason why the
> capable() call is on top.
> (Because the straightforward fix for this would be to just call
> capable() a single time if at least one trusted xattr is encountered and
> store the result. That's pretty easy to do by making turning the trusted
> variable into an int, setting it to -1, and only if it's -1 and a
> trusted xattr has been found call capable() and store the result.)
> 
> One option to fix all of that is to switch simple_xattr_list() to use
> 
>         ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)
> 
> which doesn't generate an audit event.
> 
> I think this is even the correct thing to do as listing xattrs isn't a
> targeted operation. IOW, if the the user had used getxattr() to request
> a trusted.* xattr then logging a denial makes sense as the user
> explicitly wanted to retrieve a trusted.* xattr. But if the user just
> requested to list all xattrs then silently skipping trusted without
> logging an explicit denial xattrs makes sense.
> 
> Does that sound acceptable?

Agreed, auditing that seems like unwanted noise.
