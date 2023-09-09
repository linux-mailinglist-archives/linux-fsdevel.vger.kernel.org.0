Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8677999C0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Sep 2023 18:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbjIIQZj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Sep 2023 12:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346481AbjIIPou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Sep 2023 11:44:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3CE13D
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 Sep 2023 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=xuPeY+0dATQb0iL1lRtdifrHerzxF/MyEgbxOLJ4WK0=; b=Q3qNrFYSyINsJppt/D+Z6XmqR6
        A3f/kf/nS+a/an64YWd2GCAsJpC6J13/pzgHb0ZPqLXV3XyeBuyYUHZnfhFxR1X/30idc+wCQgIvV
        u7rTlZnDGGF/vanmttKtsakhAeYQY+ftS1vw82DdqbwFwhz0Fa2I9lUn99yD+II+Bq4GzEQo7janc
        pCgBPUUS0npAi9Nt9ilg8wpwmEWi/nk8PgEVWK5ytqNcXkiKQ8xnG8v6UixziDCaLDvIilS2kZiRA
        xpuQE2G5RhUry3801HyeDcHFLcCyzhyJFhj7jUHz6b2u86lMyhHMjqlEpxmPgw+3NoiXxXYOqbDup
        nfe7UYCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qf08O-006zFi-Jl; Sat, 09 Sep 2023 15:44:32 +0000
Date:   Sat, 9 Sep 2023 16:44:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPyS4J55gV8DBn8x@casper.infradead.org>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
 <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 09, 2023 at 08:50:39AM -0400, James Bottomley wrote:
> On Wed, 2023-09-06 at 00:23 +0100, Matthew Wilcox wrote:
> > On Wed, Sep 06, 2023 at 09:06:21AM +1000, Dave Chinner wrote:
> [...]
> > > > E.g. the hfsplus driver is unmaintained despite collecting odd
> > > > fixes. It collects odd fixes because it is really useful for
> > > > interoperating with MacOS and it would be a pity to remove it. 
> > > > At the same time it is impossible to test changes to hfsplus
> > > > sanely as there is no mkfs.hfsplus or fsck.hfsplus available for
> > > > Linux.  We used to have one that was ported from the open source
> > > > Darwin code drops, and I managed to get xfstests to run on
> > > > hfsplus with them, but this old version doesn't compile on any
> > > > modern Linux distribution and new versions of the code aren't
> > > > trivially portable to Linux.
> > > > 
> > > > Do we have volunteers with old enough distros that we can list as
> > > > testers for this code?  Do we have any other way to proceed?
> > > > 
> > > > If we don't, are we just going to untested API changes to these
> > > > code bases, or keep the old APIs around forever?
> > > 
> > > We do slowly remove device drivers and platforms as the hardware,
> > > developers and users disappear. We do also just change driver APIs
> > > in device drivers for hardware that no-one is actually able to
> > > test. The assumption is that if it gets broken during API changes,
> > > someone who needs it to work will fix it and send patches.
> > > 
> > > That seems to be the historical model for removing unused/obsolete
> > > code from the kernel, so why should we treat unmaintained/obsolete
> > > filesystems any differently?  i.e. Just change the API, mark it
> > > CONFIG_BROKEN until someone comes along and starts fixing it...
> > 
> > Umm.  If I change ->write_begin and ->write_end to take a folio,
> > convert only the filesystems I can test via Luis' kdevops and mark
> > the rest as CONFIG_BROKEN, I can guarantee you that Linus will reject
> > that pull request.
> 
> I think really everyone in this debate needs to recognize two things:
> 
>    1. There are older systems out there that have an active group of
>       maintainers and which depend on some of these older filesystems
>    2. Data image archives will ipso facto be in older formats and
>       preserving access to them is a historical necessity.

I don't understand why you think people don't recognise those things.

> So the problem of what to do with older, less well maintained,
> filesystems isn't one that can be solved by simply deleting them and we
> have to figure out a way to move forward supporting them (obviously for
> some value of the word "support"). 
> 
> By the way, people who think virtualization is the answer to this
> should remember that virtual hardware is evolving just as fast as
> physical hardware.

I think that's a red herring.  Of course there are advances in virtual
hardware for those who need the best performance.  But there's also
qemu's ability to provide to you a 1981-vintage PC (or more likely a
2000-era PC).  That's not going away.

> > I really feel we're between a rock and a hard place with our
> > unmaintained filesystems.  They have users who care passionately, but
> > not the ability to maintain them.
> 
> So why is everybody making this a hard either or? The volunteer
> communities that grow around older things like filesystems are going to
> be enthusiastic, but not really acquainted with the technical
> intricacies of the modern VFS and mm. Requiring that they cope with all
> the new stuff like iomap and folios is building an unbridgeable chasm
> they're never going to cross. Give them an easier way and they might
> get there.

Spoken like someone who has been paying no attention at all to what's
going on in filesystems.  The newer APIs are easier to use.  The problem
is understanding what the hell the old filesystems are doing with the
old APIs.

Nobody's interested.  That's the problem.  The number of filesystem
developers we have is shrinking.  There hasn't been an HFS maintainer
since 2011, and it wasn't a problem until syzbot decreed that every
filesystem bug is a security bug.  And now, who'd want to be a fs
maintainer with the automated harassment?

Burnout amongst fs maintainers is a real problem.  I have no idea how
to solve it.
