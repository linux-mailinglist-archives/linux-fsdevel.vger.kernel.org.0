Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B627AD838
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 14:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjIYMsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 08:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjIYMsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:48:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42002103
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 05:48:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7558EC433C8;
        Mon, 25 Sep 2023 12:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695646079;
        bh=xEzUWpxdpxDLFGdAOLXyF8mvCulJHKo60CFRsd+bafo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3JYTjMAmkYZzbYOqHOpqf3PI7U5DNq40sDrQfcsgwRWyZcKpjFrA+ZD6FMcrut/U
         AjA20FV6TfWsVTBqrzsRut5hunvB+JnXNMql86gdXXiOhCEtyTtzaIzMHJwYxOw58W
         a8pRP1aOpHDi8+x3SV1czvber2Ba8//3jazmpCeft5b4p1sVmU7TEmrOWrG52Rh6hA
         5TsMy+bfmJWuCzs8XqTBmb6FqgkFuaYXeEQl+safsYIFY0rdQXajxk+XK1oBidWEWP
         5npVQTL0pWm6jQSKzfjAuPKfo7iWOl2rt17XikL4y/1gD4CWg59+IEhuzy09j1ZWYD
         p4l1XvZG3ZmQA==
Date:   Mon, 25 Sep 2023 14:47:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Reuben Hawkins <reubenhwk@gmail.com>, amir73il@gmail.com,
        chrubis@suse.cz, mszeredi@redhat.com, lkp@intel.com,
        linux-fsdevel@vger.kernel.org, oliver.sang@intel.com,
        viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev,
        ltp@lists.linux.it, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] vfs: fix readahead(2) on block devices
Message-ID: <20230925-altbekannt-beunruhigen-972926d9d89f@brauner>
References: <20230924050846.2263-1-reubenhwk@gmail.com>
 <ZQ/hGr+o61X1mik9@casper.infradead.org>
 <20230924-umliegenden-qualifizieren-4d670d00e775@brauner>
 <ZRBJJgwFl/0NwQ6W@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRBJJgwFl/0NwQ6W@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 24, 2023 at 03:35:18PM +0100, Matthew Wilcox wrote:
> On Sun, Sep 24, 2023 at 12:30:30PM +0200, Christian Brauner wrote:
> > > This ad-hoc approach to testing syscalls is probably not the best idea.
> > > Have the LTP considered a more thorough approach where we have a central
> > > iterator that returns a file descriptor of various types (the ones listed
> > > above, plus block devices, and regular files), and individual syscall
> > > testcases can express whether this syscall should pass/fail for each type
> > > of fd?  That would give us one central place to add new fd types, and we
> > > wouldn't be relying on syzbot to try fds at random until something fails.
> > > 
> > > Or something.  I'm not an expert on the LTP or testing in general; it
> > > just feels like we could do better here.
> > 
> > I honestly would love to see such tests all go into xfstests. IOW,
> > general VFS and fs-specific tests should be in one location. That's why
> > I added src/vfs/ under xfstests. Having to run multiple test-suites for
> > one subsystem isn't ideal. I mean, I'm doing it but I don't love it...
> 
> This may well be a subject on which reasonable people can disagree.

Oh it sure is.

> I'm going to lay out what I believe the positions of the various
> parties are here, and plese feel free to speak up if you feel I'm
> mischaracterising anyone.
> 
> The LTP people see it as their mandate to test all syscalls.  They focus
> on getting the correct error code, checking corner cases of the API, etc.
> 
> The xfstests people see it as their mandate to test filesystems.
> They focus on testing the corner cases of the filesystem.
> 
> These are quite different things, and I'm not sure that forcing them

Yes, I agree that they are different things.
But the lines are quite often rather blurry as most vfs changes have an
immediate impact on fs testing and testing them involves validating the
vfs interface and the fses implementing them.

I've mostly just described my ideal world where the two things would be
tightly coupled even during testing.
