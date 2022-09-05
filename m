Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3BC5AD696
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 17:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbiIEPcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 11:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239022AbiIEPb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:31:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0ED62AB6;
        Mon,  5 Sep 2022 08:30:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A987B611AE;
        Mon,  5 Sep 2022 15:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38C1C433D6;
        Mon,  5 Sep 2022 15:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662391842;
        bh=FBB3egLAbT/Wars2QJ98mK1mQITaziItgBSg6v71lRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkn0FggiODveo+KmJCKDg8hZYAdT5D/8egABC8FrKyAGQdYZGgCibJCzCf387xhha
         qftckA5y5+dMU4Qs7yGwRCk3BvqYtmzosjp/gMVdSpubLZ0DY6lO8jFUTuIbPuMEiI
         AU1yzxxcw1qAssDMma4+kQz1GMDuuR+HWdfe6tdyS2o8sbSEKptl7yW9vyBe3uAOX4
         lO0g06poGpspSzs5YCzhUqfGyxPE+KsP94QMWPgYDsnvan5cKLREGg6e3/xv6sCUqA
         2LbVxGfrpMoAM/TLNgZChnmaw6l2Ve5PTQQDNpeZUNyYbix+ckfibEYMZfMYT6/jKp
         ymLsYHLtqdrEw==
Date:   Mon, 5 Sep 2022 17:30:36 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>, rcu@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Martin Pitt <mpitt@redhat.com>, Vasily Averin <vvs@openvz.org>
Subject: Re: [PATCH 0/2] fs: fix capable() call in simple_xattr_list()
Message-ID: <20220905153036.zzcovknz7ntgcn5f@wittgenstein>
References: <20220901152632.970018-1-omosnace@redhat.com>
 <20220905090811.ocnnc53y2bow7m3i@wittgenstein>
 <CAFqZXNu_jf0D8LQLc15+ZrFne5F5F5PFNbkT-EkfqXvNdSKKsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFqZXNu_jf0D8LQLc15+ZrFne5F5F5PFNbkT-EkfqXvNdSKKsQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 05, 2022 at 12:15:01PM +0200, Ondrej Mosnacek wrote:
> On Mon, Sep 5, 2022 at 11:08 AM Christian Brauner <brauner@kernel.org> wrote:
> > On Thu, Sep 01, 2022 at 05:26:30PM +0200, Ondrej Mosnacek wrote:
> > > The goal of these patches is to avoid calling capable() unconditionally
> > > in simple_xattr_list(), which causes issues under SELinux (see
> > > explanation in the second patch).
> > >
> > > The first patch tries to make this change safer by converting
> > > simple_xattrs to use the RCU mechanism, so that capable() is not called
> > > while the xattrs->lock is held. I didn't find evidence that this is an
> > > issue in the current code, but it can't hurt to make that change
> > > either way (and it was quite straightforward).
> >
> > Hey Ondrey,
> >
> > There's another patchset I'd like to see first which switches from a
> > linked list to an rbtree to get rid of performance issues in this code
> > that can be used to dos tmpfs in containers:
> >
> > https://lore.kernel.org/lkml/d73bd478-e373-f759-2acb-2777f6bba06f@openvz.org
> >
> > I don't think Vasily has time to continue with this so I'll just pick it
> > up hopefully this or the week after LPC.
> 
> Hm... does rbtree support lockless traversal? Because if not, that

The rfc that Vasily sent didn't allow for that at least.

> would make it impossible to fix the issue without calling capable()
> inside the critical section (or doing something complicated), AFAICT.
> Would rhashtable be a workable alternative to rbtree for this use
> case? Skimming <linux/rhashtable.h> it seems to support both lockless
> lookup and traversal using RCU. And according to its manpage,
> *listxattr(2) doesn't guarantee that the returned names are sorted.

I've never used the rhashtable infrastructure in any meaningful way. All
I can say from looking at current users that it looks like it could work
well for us here:

struct simple_xattr {
	struct rhlist_head rhlist_head;
	char *name;
	size_t size;
	char value[];
};

static const struct rhashtable_params simple_xattr_rhashtable = {
	.head_offset = offsetof(struct simple_xattr, rhlist_head),
	.key_offset = offsetof(struct simple_xattr, name),

or sm like this.
