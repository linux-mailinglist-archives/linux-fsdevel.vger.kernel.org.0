Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8637940EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 18:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbjIFQAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 12:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjIFQAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:00:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5B4DD
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 09:00:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D06C433C9;
        Wed,  6 Sep 2023 16:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694016003;
        bh=dZ5my9TAuX/OYnlZCtWUqmfy0KGE9lep3a9aHl0MuaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISaZahRQ06srea3mCxWntnBOW54cPwl7Rbi+3fKt6yF0IpmlpwzTkfuWWLdQ0Ctfr
         Ly93cVTCnCDgD9qon3ojwcA6M3IvADttAssmQCaq8ZUiT24t/poGHxMpQhNQkLErCG
         oL6n+w0jsFHA/JqvJV9bLw8T7ya2TPvAhHRQGAeQofROw7CktylCkBwUzHHa0hruUc
         e7dbLIT3qdXnxN5I//XKIG64z24gZPlSwFXKJPgT2cB4osO/wUkXbkURbfCvn4msZd
         1L2154ZJPbAYEvVQfMcao7tBWEsEDGNvd6gab0tzlgzorrYdj/lkqGxELAgkdb17aa
         4ZAX2dzuzKfaw==
Date:   Wed, 6 Sep 2023 17:59:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <20230906-halbrund-gesaugt-41a7c283eb8e@brauner>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
 <ZPffYYnVMIkuCK9x@dread.disaster.area>
 <20230906-wildhasen-vorkehrungen-6ecb4ee012f1@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230906-wildhasen-vorkehrungen-6ecb4ee012f1@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:06:29PM +0200, Christian Brauner wrote:
> On Wed, Sep 06, 2023 at 12:09:37PM +1000, Dave Chinner wrote:
> > On Wed, Sep 06, 2023 at 12:23:22AM +0100, Matthew Wilcox wrote:
> > > On Wed, Sep 06, 2023 at 09:06:21AM +1000, Dave Chinner wrote:
> > > > > Part 2: unmaintained file systems
> > > > > 
> > > > > A lot of our file system drivers are either de facto or formally
> > > > > unmaintained.  If we want to move the kernel forward by finishing
> > > > > API transitions (new mount API, buffer_head removal for the I/O path,
> > > > > ->writepage removal, etc) these file systems need to change as well
> > > > > and need some kind of testing.  The easiest way forward would be
> > > > > to remove everything that is not fully maintained, but that would
> > > > > remove a lot of useful features.
> > > > 
> > > > Linus has explicitly NACKed that approach.
> > > > 
> > > > https://lore.kernel.org/linux-fsdevel/CAHk-=wg7DSNsHY6tWc=WLeqDBYtXges_12fFk1c+-No+fZ0xYQ@mail.gmail.com/
> > > > 
> > > > Which is a problem, because historically we've taken code into
> > > > the kernel without requiring a maintainer, or the people who
> > > > maintained the code have moved on, yet we don't have a policy for
> > > > removing code that is slowly bit-rotting to uselessness.
> > > > 
> > > > > E.g. the hfsplus driver is unmaintained despite collecting odd fixes.
> > > > > It collects odd fixes because it is really useful for interoperating
> > > > > with MacOS and it would be a pity to remove it.  At the same time
> > > > > it is impossible to test changes to hfsplus sanely as there is no
> > > > > mkfs.hfsplus or fsck.hfsplus available for Linux.  We used to have
> > > > > one that was ported from the open source Darwin code drops, and
> > > > > I managed to get xfstests to run on hfsplus with them, but this
> > > > > old version doesn't compile on any modern Linux distribution and
> > > > > new versions of the code aren't trivially portable to Linux.
> > > > > 
> > > > > Do we have volunteers with old enough distros that we can list as
> > > > > testers for this code?  Do we have any other way to proceed?
> > > > >
> > > > > If we don't, are we just going to untested API changes to these
> > > > > code bases, or keep the old APIs around forever?
> > > > 
> > > > We do slowly remove device drivers and platforms as the hardware,
> > > > developers and users disappear. We do also just change driver APIs
> > > > in device drivers for hardware that no-one is actually able to test.
> > > > The assumption is that if it gets broken during API changes,
> > > > someone who needs it to work will fix it and send patches.
> > > > 
> > > > That seems to be the historical model for removing unused/obsolete
> > > > code from the kernel, so why should we treat unmaintained/obsolete
> > > > filesystems any differently?  i.e. Just change the API, mark it
> > > > CONFIG_BROKEN until someone comes along and starts fixing it...
> > > 
> > > Umm.  If I change ->write_begin and ->write_end to take a folio,
> > > convert only the filesystems I can test via Luis' kdevops and mark the
> > > rest as CONFIG_BROKEN, I can guarantee you that Linus will reject that
> > > pull request.
> > 
> > No, that's not what I was suggesting. I suggest that we -change all
> > the API users when we need to, but in doing so we also need to 
> > formalise the fact we do not know if the filesystems nobody can/will
> > maintain function correctly or not.
> > 
> > Reflect that with CONFIG_BROKEN or some other mechanism that
> > forces people to acknowledge that the filesystem implementation is
> > not fit for purpose before they attempt to use it. e.g.
> > write some code that emits a log warning about the filesystem being
> > unmaintained at mount time and should not be used in situations
> > where stability, security or data integrity guarantees are required.
> 
> In addition to this e need to involve low-level userspace. We already
> started this a while ago.
> 
> util-linux has already implemented X-mount.auto-fstypes which we
> requested. For example, X-mount.auto-fstypes="ext4,xfs" accepts only
> ext4 and xfs, and X-mount.auto-fstypes="novfat,reiserfs" accepts all
> filesystems except vfat and reiserfs.
> 
> https://github.com/util-linux/util-linux/commit/1592425a0a1472db3168cd9247f001d7c5dd84b6
> 
> IOW,
>         mount -t X-mount.auto-fstypes="ext4,xfs,btrfs,erofs" /dev/bla /mnt
> would only mount these for filesystems and refuse the rest.
> 
> Of course, that's optional so if userspace only uses
>         mount /dev/bla /mnt
> then libmount will currently happily mount anything that's on /dev/bla.
> 
> So adding another RFE to libmount to add support for a global allowlist
> or denylist of filesystems and refuse to mount anything else might also
> be a good thing. Actually, might go and do this now.

https://github.com/util-linux/util-linux/issues/2478
