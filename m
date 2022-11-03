Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93D4617B19
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 11:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiKCKxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 06:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKCKxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679F610FC2
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 03:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667472730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kIYRkx7Y9W9jKAKjm+1jgkpGJFLvVwfrjVD1dASHnIM=;
        b=E4EWZz70wbLCSkEcNhgP2x2zmehYqAALcC4yJvPcSLPzcgKGcezNq1U4GtueXH+ZHAy3oU
        ZphdQWt1BQTyvyPELd4jklGjf4Pukq+tmP8iLEs9gG6zFnNavyjmFPf8HfjhgqdDO8Wk7p
        FxXrewoq6CvEVYYTq13pIe1tFLLqgbg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-D6p5c_RAOp6FBGdBJetSWg-1; Thu, 03 Nov 2022 06:52:09 -0400
X-MC-Unique: D6p5c_RAOp6FBGdBJetSWg-1
Received: by mail-pj1-f69.google.com with SMTP id m2-20020a17090a730200b0021020cce6adso3396678pjk.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Nov 2022 03:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIYRkx7Y9W9jKAKjm+1jgkpGJFLvVwfrjVD1dASHnIM=;
        b=cG1Iv8djocG1ETwUAfEKufJt10lS0k+UcsMNAcEPJLAO3DrSHDp/seIm0LwucBMxm+
         ODydYoB0XDYRLU3UKkVBWYyRRsoWr/jtepjLMYdXy+oS7slt+56hREFp1fC+uEqeZU2g
         ThO7RKf0trprauPZA7d7V5KUAQLUrc5R0oKZx1nkmWKk8fjLIXS5eMPH4OJr7u5dpc9J
         5wTtkA/suSaaUs/6DwHTBPBHTg0+lUMNvcFyE2ldp2H9K+5SvuWGJLWxWj49Mgc/caNW
         dgm7h3lmFnTL7ZImOGkrp9YBmRya8HDzjnhCruX+PD2JoYK6/PuO+9e7uw9Q9lrecStc
         5axw==
X-Gm-Message-State: ACrzQf1qhJpeQ5i4A5sp+Eg9n7nQJxHeWHA1+4FLdHkl7azAb1RpMkgs
        q1s+k7FMYY9cpapr3tkMhDzqmblsc1xsZRTBUhnkz5WWNw/YpCi89W4FsUA4ePtXREI9WRMhEjW
        xh90CPZt1Av2Yfa7ijd8IW8UUSYZAPr2pud7ZVyskeg==
X-Received: by 2002:a17:902:ab45:b0:186:7b95:f767 with SMTP id ij5-20020a170902ab4500b001867b95f767mr30293344plb.107.1667472728481;
        Thu, 03 Nov 2022 03:52:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7s7znX4hyAsgjTBM4wVFx4O9ZyTZG5tNktnMvuG2E5V91rnNMU833toUePw5i7OC9qbOH0dlZoLSD+/0g/U08=
X-Received: by 2002:a17:902:ab45:b0:186:7b95:f767 with SMTP id
 ij5-20020a170902ab4500b001867b95f767mr30293310plb.107.1667472728194; Thu, 03
 Nov 2022 03:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220901152632.970018-1-omosnace@redhat.com> <20220905090811.ocnnc53y2bow7m3i@wittgenstein>
 <CAFqZXNu_jf0D8LQLc15+ZrFne5F5F5PFNbkT-EkfqXvNdSKKsQ@mail.gmail.com>
 <20220905153036.zzcovknz7ntgcn5f@wittgenstein> <20221102182451.aoos5udhf6rbb6us@wittgenstein>
 <CAFqZXNuG0gjRjSMpaMJQqmmwtqr5Yx1r6Eg0YpJ4DQ6u9CWqRA@mail.gmail.com> <20221103091227.mm2nzjj35dzv4dex@wittgenstein>
In-Reply-To: <20221103091227.mm2nzjj35dzv4dex@wittgenstein>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 3 Nov 2022 11:51:56 +0100
Message-ID: <CAFqZXNuC7c0Ukx_okYZ7rsKycQY5P1zpMPmmq_T5Qyzbg-x7yQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fs: fix capable() call in simple_xattr_list()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Vasily Averin <vvs@openvz.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>, rcu@vger.kernel.org,
        Martin Pitt <mpitt@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 3, 2022 at 10:12 AM Christian Brauner <brauner@kernel.org> wrote:
> On Thu, Nov 03, 2022 at 10:04:25AM +0100, Ondrej Mosnacek wrote:
> > On Wed, Nov 2, 2022 at 7:25 PM Christian Brauner <brauner@kernel.org> wrote:
> > > On Mon, Sep 05, 2022 at 05:30:36PM +0200, Christian Brauner wrote:
> > > > On Mon, Sep 05, 2022 at 12:15:01PM +0200, Ondrej Mosnacek wrote:
> > > > > On Mon, Sep 5, 2022 at 11:08 AM Christian Brauner <brauner@kernel.org> wrote:
> > > > > > On Thu, Sep 01, 2022 at 05:26:30PM +0200, Ondrej Mosnacek wrote:
> > > > > > > The goal of these patches is to avoid calling capable() unconditionally
> > > > > > > in simple_xattr_list(), which causes issues under SELinux (see
> > > > > > > explanation in the second patch).
> > > > > > >
> > > > > > > The first patch tries to make this change safer by converting
> > > > > > > simple_xattrs to use the RCU mechanism, so that capable() is not called
> > > > > > > while the xattrs->lock is held. I didn't find evidence that this is an
> > > > > > > issue in the current code, but it can't hurt to make that change
> > > > > > > either way (and it was quite straightforward).
> > > > > >
> > > > > > Hey Ondrey,
> > > > > >
> > > > > > There's another patchset I'd like to see first which switches from a
> > > > > > linked list to an rbtree to get rid of performance issues in this code
> > > > > > that can be used to dos tmpfs in containers:
> > > > > >
> > > > > > https://lore.kernel.org/lkml/d73bd478-e373-f759-2acb-2777f6bba06f@openvz.org
> > > > > >
> > > > > > I don't think Vasily has time to continue with this so I'll just pick it
> > > > > > up hopefully this or the week after LPC.
> > > > >
> > > > > Hm... does rbtree support lockless traversal? Because if not, that
> > > >
> > > > The rfc that Vasily sent didn't allow for that at least.
> > > >
> > > > > would make it impossible to fix the issue without calling capable()
> > > > > inside the critical section (or doing something complicated), AFAICT.
> > > > > Would rhashtable be a workable alternative to rbtree for this use
> > > > > case? Skimming <linux/rhashtable.h> it seems to support both lockless
> > > > > lookup and traversal using RCU. And according to its manpage,
> > > > > *listxattr(2) doesn't guarantee that the returned names are sorted.
> > > >
> > > > I've never used the rhashtable infrastructure in any meaningful way. All
> > > > I can say from looking at current users that it looks like it could work
> > > > well for us here:
> > > >
> > > > struct simple_xattr {
> > > >       struct rhlist_head rhlist_head;
> > > >       char *name;
> > > >       size_t size;
> > > >       char value[];
> > > > };
> > > >
> > > > static const struct rhashtable_params simple_xattr_rhashtable = {
> > > >       .head_offset = offsetof(struct simple_xattr, rhlist_head),
> > > >       .key_offset = offsetof(struct simple_xattr, name),
> > > >
> > > > or sm like this.
> > >
> > > I have a patch in rough shape that converts struct simple_xattr to use
> > > an rhashtable:
> > >
> > > https://gitlab.com/brauner/linux/-/commits/fs.xattr.simple.rework/
> > >
> > > Light testing, not a lot useful comments and no meaningful commit
> > > message as of yet but I'll get to that.
> >
> > Looks mostly good at first glance. I left comments for some minor
> > stuff I noticed.
> >
> > > Even though your issue is orthogonal to the performance issues I'm
> > > trying to fix I went back to your patch, Ondrej to apply it on top.
> > > But I think it has one problem.
> > >
> > > Afaict, by moving the capable() call from the top of the function into
> > > the actual traversal portion an unprivileged user can potentially learn
> > > whether a file has trusted.* xattrs set. At least if dmesg isn't
> > > restricted on the kernel. That may very well be the reason why the
> > > capable() call is on top.
> >
> > Technically it would be possible, for example with SELinux if the
> > audit daemon is dead. Not a likely situation, but I agree it's better
> > to be safe.
> >
> > > (Because the straightforward fix for this would be to just call
> > > capable() a single time if at least one trusted xattr is encountered and
> > > store the result. That's pretty easy to do by making turning the trusted
> > > variable into an int, setting it to -1, and only if it's -1 and a
> > > trusted xattr has been found call capable() and store the result.)
> >
> > That would also run into the conundrum of holding a lock while
> > (potentially) calling into the LSM subsystem. And would it even fix
> > the information leak? Unless I'm missing something it would only
> > prevent a leak of the trusted xattr count, but not the presence of any
> > trusted xattr.
>
> No it wouldn't. I just meant this to illustrate that with your patch we
> could've made it so that capable() would've only been called once.
>
> >
> > > One option to fix all of that is to switch simple_xattr_list() to use
> > >
> > >         ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)
> > >
> > > which doesn't generate an audit event.
> > >
> > > I think this is even the correct thing to do as listing xattrs isn't a
> > > targeted operation. IOW, if the the user had used getxattr() to request
> > > a trusted.* xattr then logging a denial makes sense as the user
> > > explicitly wanted to retrieve a trusted.* xattr. But if the user just
> > > requested to list all xattrs then silently skipping trusted without
> > > logging an explicit denial xattrs makes sense.
> > >
> > > Does that sound acceptable?
> >
> > Yes, I can't see any reason why that wouldn't be the best solution.
> > Why haven't I thought of that? :)
> >
> > I guess you will want to submit a patch for it along with your
> > rhashtable patch to avoid a conflict? Or would you like me to submit
> > it separately?
>
> I think you can send a patch for this separately as we don't need to
> massage the data structure for this.

Ok, will do.

> I think we can reasonably give this a
>
> Fixes: 38f38657444d ("xattr: extract simple_xattr code from tmpfs") # no backport
>
> But note the "# no backport" as imho it isn't worth backporting this to
> older kernels unless that's really desirable.

Actually, it would be valuable to have it backported to linux-stable
at least, since we have users encountering this on Fedora:
https://bugzilla.redhat.com/show_bug.cgi?id=2122888

In the end it's up to the backporter to assess each commit, but at
least I wouldn't want to outright discourage the backport in the
commit message.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

