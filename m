Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A019E7ACA08
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 16:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjIXOfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 10:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjIXOfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:35:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BA8FB
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M5pObT5z3Mwip+WvbK3iOt6865GE12uJP5gsebp/nnQ=; b=AwwueGpZKCnMTC75hg8M4rqwUv
        sl51v7yKGpM6sivDirVYrWXe+pyUwwFfBeigYQse2mVBdmcllpAZ7WgHEwAepL/S1VhA67XPmWK38
        Ly7/T0glDgOiDMQK14E593EZcPiJScsCLmJ5oQHx6y1737mCIO31EUzbbUs4vgfz2dT4Cv9OXJV9s
        ROhEACJ0VA/Wt1y3TDzV9z8rUwKgoFyRO+9I1jO8+NLdfmNYxwpWphOAzmZucZfVdWB6DxU5Y10ef
        6dV+yQ+Bi/QHGZFJS5uHEA5JJDvArnqFiXqmhhpf2BK86fplrjNGMZSWBTRyjxemI+MmMVfb9b9DG
        YTGoaS+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qkQCc-00DSFC-34; Sun, 24 Sep 2023 14:35:18 +0000
Date:   Sun, 24 Sep 2023 15:35:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Reuben Hawkins <reubenhwk@gmail.com>, amir73il@gmail.com,
        chrubis@suse.cz, mszeredi@redhat.com, lkp@intel.com,
        linux-fsdevel@vger.kernel.org, oliver.sang@intel.com,
        viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev,
        ltp@lists.linux.it, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] vfs: fix readahead(2) on block devices
Message-ID: <ZRBJJgwFl/0NwQ6W@casper.infradead.org>
References: <20230924050846.2263-1-reubenhwk@gmail.com>
 <ZQ/hGr+o61X1mik9@casper.infradead.org>
 <20230924-umliegenden-qualifizieren-4d670d00e775@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924-umliegenden-qualifizieren-4d670d00e775@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 24, 2023 at 12:30:30PM +0200, Christian Brauner wrote:
> > This ad-hoc approach to testing syscalls is probably not the best idea.
> > Have the LTP considered a more thorough approach where we have a central
> > iterator that returns a file descriptor of various types (the ones listed
> > above, plus block devices, and regular files), and individual syscall
> > testcases can express whether this syscall should pass/fail for each type
> > of fd?  That would give us one central place to add new fd types, and we
> > wouldn't be relying on syzbot to try fds at random until something fails.
> > 
> > Or something.  I'm not an expert on the LTP or testing in general; it
> > just feels like we could do better here.
> 
> I honestly would love to see such tests all go into xfstests. IOW,
> general VFS and fs-specific tests should be in one location. That's why
> I added src/vfs/ under xfstests. Having to run multiple test-suites for
> one subsystem isn't ideal. I mean, I'm doing it but I don't love it...

This may well be a subject on which reasonable people can disagree.
I'm going to lay out what I believe the positions of the various
parties are here, and plese feel free to speak up if you feel I'm
mischaracterising anyone.

The LTP people see it as their mandate to test all syscalls.  They focus
on getting the correct error code, checking corner cases of the API, etc.

The xfstests people see it as their mandate to test filesystems.
They focus on testing the corner cases of the filesystem.

These are quite different things, and I'm not sure that forcing them
together or moving test-cases from one test-suite to the other makes
sense.  I think it's reasonable to have two separate test suites for you
(and the various bots) to run, even though it's slightly more work.

At the end of the day, I don't much care, it doesn't significantly affect
my life.  If I could see a clear advantage to converting one to the other,
I'd be all for it, but I don't see a compelling reason to put much work
in here.
