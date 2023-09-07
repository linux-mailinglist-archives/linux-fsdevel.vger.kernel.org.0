Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85536797A6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 19:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245280AbjIGRjr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 13:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245279AbjIGRj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:39:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096BB2132
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 10:38:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C61C116B3;
        Thu,  7 Sep 2023 10:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694082594;
        bh=I5vny7qUROC8Da2C/sZSRv3leB/a+ax29yWPx9758F4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MPlMhsBhxY6IznKAllq8kKKqCPS+RMZDae+Un2tI2ha9ad1+XrIf7WmMAupPDvust
         pPO7oTgT3hMVfZev/0mYFKR9Nvvz3x+tEiuARbkcWNASKYECIdZ4A/K0rEaAMe9Chk
         dle9qLwhtYZQyBybrQXD/CWL2Pt8p9wC4B+HJwhnREM0KuZJVjv1EGWc+txnz4T4av
         nqjrXoFpLkY4X+Z8U8AENiMyJ/MbRHDuEeI+F4i23Z/unxixaPw5IV21/KfZrZlSmV
         1kJHwSfSS7PcVaw/klxM3DD2PStv/KungQqhtPquqVJL4NhqUN12/nXoXGMMCFRcSH
         Wksx9WSBC07xg==
Date:   Thu, 7 Sep 2023 12:29:50 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <20230907-kauern-kopfkissen-d8147fb40469@brauner>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
 <20230906215327.18a45c89@gandalf.local.home>
 <ZPkz86RRLaYOkmx+@dread.disaster.area>
 <20230906225139.6ffe953c@gandalf.local.home>
 <ZPlC0pf2XA1ZGr6j@casper.infradead.org>
 <c89ebbb2-1249-49f3-b80f-0b08711bc29b@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c89ebbb2-1249-49f3-b80f-0b08711bc29b@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> So why can't that work similarly for unmaintained file systems? We could
> even establish the rule that Linus should only apply patches to some
> parts of the kernel if the test suite for unmaintained file systems
> succeeded without regressions. And only accept new file system code if a

Reading this mail scared me. The list of reiserfs bugs alone is crazy.
And syzbot keeps piling them on. It can't even succeed an xfstests run
without splatting all over the place last I checked. And there's no
maintainer for it. We'll pick up patches if we get sent them but none of
the vfs maintainers and reviewers has the bandwith to take care of
rotting filesystems and their various ailments.

Yes, we should have a discussion under what circumstances we can remove
a filesystem. I think that's absolutely what we should do and we should
nudge userspace to stop compiling known orphaned filesystems. If most
distros have stopped compiling support for a filesystem then I think
that's a good indication that we can at least start to talk about
how to remove it. And we should probably tell distros that a filesystem
is orphaned and unmaintained more aggressively.

But even if we decide or it is decided for us that we have to keep such
old filesystems in tree forever then the contract with userspaces must
be that such filesystems are zombies. They should however not become an
even bigger burden or obstacle to improve actively maintained
filesystems or the vfs than they are already.

I think it's also worth clarifying something:
Right now, everyone who does fs wide changes does their absolute best to
account for every filesytem that's in the tree. And for people not
familiar or even refusing to care about any other filesystems the
maintainers and reviewers will remind them about consequences for other
filesystems as far as they have that knowledge. And that's already a
major task.

For every single fs/ wide change we try to make absolutely sure that if
it regresses anything - even the deadest-of-dead filesystems - it will
be fixed as soon as we get a report. That's what we did for the
superblock rework this cycle, the posix acl rework last cycles, the
timestamp patches, the freezing patches.

But it is very scary to think that we might be put even more under the
yoke of dead filesystems. They put enough of a burden on us by not just
having to keep the filesystems itself around but quite often legacy
infrastructure and hacks in various places.

The burden of unmaintained filesystems is very very real. fs/ wide
changes are very costly in development time.

> test suite that is easy to integrate in CI systems exists (e.g.
> something smaller and faster than what the ext4 and xfs developers run
> regularly, but smaller and faster should likely be good enough here).

The big question of course is who is going to do that? We have a large
number of filesystems. And only a subset of them is integrated or even
integratable with xfstests. And xfstests is the standard for fs testing.

So either a filesystem is integrated with xfstests and we can test it or
it isn't and we can't. And if a legacy filesystem becomes integrated
then someone needs to do the work to determine what the baseline of
tests is that need to pass and then fix all bugs to get to a clean
baseline run.

That'll be a fulltime job for quite a while I would expect.

Imho, mounting an unmaintained filesystem that isn't integrated with
xfstests is a gamble with your data.

(And what really I would rather see happen before that is that we get
stuff like vfs.git to be auto-integrated with xfstests runs/CI at some
point.)
