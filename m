Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A35E52CF21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 11:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiESJOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 05:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiESJOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 05:14:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBEBA5028;
        Thu, 19 May 2022 02:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCF27B82397;
        Thu, 19 May 2022 09:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8CFC34100;
        Thu, 19 May 2022 09:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652951681;
        bh=TAmLjhtfKyTqHdWCAxE9xi89WgIOWlJdQAIS4rJUevQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=snAweLXtTQun4KLBiKzJxrqRcWHW9DbAaOg5AxSk/k2EJfQk2sSg7Q0Xp3JP9Iqab
         5GtAaHbl0wjL7XrGW8guqNfOZnTHfsUTi8RgaFjpdoYW0aVMaSaxofVfIIfQFh5OQo
         akBTvUIDT/wMOHdHmKWxQw2D3LJDPI9QEQl+5+PboTzHOowDqzFFdZ3WygQQZD+Wpk
         vCxa6VNsNm7i1UrQQfbW1ZzI4q0HR+VXCl2WRyZuPUQPqmeNet2pgrm/pifn4nSaJy
         HaTyKvo67SSvumoVA28nJjpEdY7TLMKemAZqXwQr04U54loxlSKP0L9KnY5fl5E7s7
         Sb4uWEh/qReLQ==
Date:   Thu, 19 May 2022 11:14:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Message-ID: <20220519091435.ycdvix3drsr5tl24@wittgenstein>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ymn05eNgOnaYy36R@zeniv-ca.linux.org.uk>
 <Ymn4xPXXWe4LFhPZ@zeniv-ca.linux.org.uk>
 <626A08DA.3060802@fujitsu.com>
 <YmoAp+yWBpH5T8rt@zeniv-ca.linux.org.uk>
 <YmoGHrNVtfXsl6vM@zeniv-ca.linux.org.uk>
 <YmoOMz+3ul5uHclV@zeniv-ca.linux.org.uk>
 <20220428093434.yc7hjjplvicugfqs@wittgenstein>
 <6285A58F.3070700@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6285A58F.3070700@fujitsu.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 01:03:12AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2022/4/28 17:34, Christian Brauner wrote:
> > On Thu, Apr 28, 2022 at 03:46:59AM +0000, Al Viro wrote:
> >> On Thu, Apr 28, 2022 at 03:12:30AM +0000, Al Viro wrote:
> >>
> >>>> Note, BTW, that while XFS has inode_fsuid_set() on the non-inode_init_owner()
> >>>> path, it doesn't have inode_fsgid_set() there.  Same goes for ext4, while
> >>>> ext2 doesn't bother with either in such case...
> >>>>
> >>>> Let's try to separate the issues here.  Jann, could you explain what makes
> >>>> empty sgid files dangerous?
> >>>
> >>> Found the original thread in old mailbox, and the method of avoiding the
> >>> SGID removal on modification is usable.  Which answers the question above...
> >>
> >> OK, what do we want for grpid mounts?  Aside of "don't forget inode_fsuid_set(),
> >> please", that is.  We don't want inode_fsgid_set() there (whatever went for
> >> the parent directory should be the right value for the child).  Same "strip
> >
> > Exactly. You sounded puzzled why we don't call that in an earlier mail.
> >
> >> SGID from non-directory child, unless we are in the resulting group"?
> >
> > Honestly, I think we should try and see if we can't use the same setgid
> > inheritance enforcement of the new mode_strip_sgid() helper for the
> > grpid mount option as well. Iow, just don't give the grpid mount option
> > a separate setgid treatment and try it with the current approach.
> >
> > It'll allow us to move things into vfs proper which I think is a robust
> > solution with clear semantics. It also gives us a uniform ordering wrt
> > to umask stripping and POSIX ACLs.
> >
> > Yes, as we've pointed out in the thread this carries a non-zero
> > regression risk. But so does the whole patch series. But this might end
> > up being a big win security wise and makes maintenance way easier going
> > forward.
> >
> > The current setgid situation is thoroughly messy though and we keep
> > plugging holes. Even writing tests for the current situation is an
> > almost herculean task let alone reviewing it.
> 
> Sorry for the late reply.
> I am agree with these. So what should I do in next step?

I'd say we try to go forward with the original approach and not
special-casing the grpid option.

> 
> ps:I also think I may send test case to xfstests for posix acl and umask 
> ASAP, then xfstests can merge these test and so more people will notice 
> this problem.

The big refactoring of the idmapped mounts testsuite into a generic
vfstest refactoring is sitting in for-next of xfstests so make sure to
base your patches on that because you really won't enjoy having to
rebase them...
