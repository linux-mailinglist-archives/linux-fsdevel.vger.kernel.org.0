Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809CA74B23F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 15:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGGNxC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 09:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjGGNwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:52:50 -0400
Received: from out-9.mta1.migadu.com (out-9.mta1.migadu.com [95.215.58.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02441FE8
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 06:52:47 -0700 (PDT)
Date:   Fri, 7 Jul 2023 09:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688737966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PYGaz3tsGre2YQId5W/WNn6D8n5IoYheTvK03OWWAb4=;
        b=DHtVLxloStQhHAezJb+IjS7xDwKmA6M79VjaLK/v0EmuiMqELhkInyNsdiePvEFvZbrWR4
        322F1wIxRK8y02XP3I4on4OAx6rZevrokOo47VMDjdGLOG1uhCEiBE/GNaG2BeowhTv4Ko
        cFYfKOUnvgBQNhR9e5Q/YwJttgeuGq4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        tytso@mit.edu, bfoster@redhat.com, andreas.gruenbacher@gmail.com,
        brauner@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230707135240.6asq2nzxnec6gjo6@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
 <20230706211914.GB11476@frogsfrogsfrogs>
 <20230706224314.u5zbeld23uqur2ct@moria.home.lan>
 <20230707131306.2wdgtuafc3unjetu@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707131306.2wdgtuafc3unjetu@quack3>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 07, 2023 at 03:13:06PM +0200, Jan Kara wrote:
> On Thu 06-07-23 18:43:14, Kent Overstreet wrote:
> > On Thu, Jul 06, 2023 at 02:19:14PM -0700, Darrick J. Wong wrote:
> > > /me shrugs, been on vacation and in hospitals for the last month or so.
> > > 
> > > >      bcachefs doesn't use sget() for mutual exclusion because a) sget()
> > > >      is insane, what we really want is the _block device_ to be opened
> > > >      exclusively (which we do), and we have our own block device opening
> > > >      path - which we need to, as we're a multi device filesystem.
> > > 
> > > ...and isn't jan kara already messing with this anyway?
> > 
> > The blkdev_get_handle() patchset? I like that, but I don't think that's
> > related - if there's something more related to sget() I haven't seen it
> > yet
> 
> There's a series on top of that that also modifies how sget() works [1].
> Christian wants that bit to be merged separately from the bdev handle stuff
> and Christoph chimed in with some other related cleanups so he'll now take
> care of that change.
> 
> Anyhow we should have sget() that does not exclusively claim the bdev
> unless it needs to create a new superblock soon.

Thanks for the link

sget() felt a bit odd in bcachefs because we have our own bch2_fs_open()
path that, completely separately from the VFS opens a list of block
devices and returns a fully constructed filesystem handle.

We need this because it's also used in userspace, where we don't have
the VFS and it wouldn't make much sense to lift sget(), for e.g. fsck
and other tools.

IOW, we really do need to own the whole codepath that opens the actual
block devices; our block device open path does things like parse the
opts struct to decide whether to open the block device in write mode or
exclusive mode...

So the way around this in bcachefs is we call sget() twice - first in
"find an existing sb but don't create one" mode, then if that fails we
call bch2_fs_open() and call sget() again in "create a super_block and
attach it to this bch_fs" - a bit awkward but it works.

Not sure if this has come up in other filesystems, but here's the
relevant bcachefs code:
https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/fs.c#n1756
