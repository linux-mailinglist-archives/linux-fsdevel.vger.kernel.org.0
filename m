Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF6574A729
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 00:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjGFWn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 18:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjGFWnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:43:25 -0400
Received: from out-28.mta0.migadu.com (out-28.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D841727
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 15:43:22 -0700 (PDT)
Date:   Thu, 6 Jul 2023 18:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688683399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RN9DhyE9hPilrdQzGYbv7H2UYstr1uDyg6AicBcRmHs=;
        b=NI7RxJ/Wjt0r++lVNTpW/4oQxDjn/+R5hOuM1i1Rry5M79vsUj7ch60FYlhy766cI0Sxcs
        fwTBrI300jaJVFWFGfS5P2WTcVfqV0yy5WZRwXT5cwRj4/XSh44MxmCTQ2b8bRmM++4FPF
        LT4P5GlpUgwDx5fPb4TD8Q423NPqBHY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, dchinner@redhat.com,
        sandeen@redhat.com, willy@infradead.org, tytso@mit.edu,
        bfoster@redhat.com, jack@suse.cz, andreas.gruenbacher@gmail.com,
        brauner@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230706224314.u5zbeld23uqur2ct@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
 <20230706211914.GB11476@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706211914.GB11476@frogsfrogsfrogs>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 06, 2023 at 02:19:14PM -0700, Darrick J. Wong wrote:
> TBH, so long as bcachefs is the only user of sixlocks and mean/variance,
> I don't really care what's in them, though they probably ought to live
> in fs/bcachefs/ until a second user arises.

I've been waiting for Linus to weigh in on those (and the rest of the
merge) since he had opinions a few weeks ago, but I have no real
objection there. I'd need to add an export for osq_lock, that's all.

> >  - d_mark_tmpfile(): trivial new helper, from pulling out part of
> >    d_tmpfile(). We need this because bcachefs handles the nlink count
> >    for tmpfiles earlier, in the btree transaction.
> 
> XFS might want this too, we also handle the nlink count for tmpfiles
> earlier, in a transaction, and end up playing stupid games with the
> refcount to fit the vfs function:
> 
> 	if (tmpfile) {
> 		/*
> 		 * The VFS requires that any inode fed to d_tmpfile must
> 		 * have nlink == 1 so that it can decrement the nlink in
> 		 * d_tmpfile.  However, we created the temp file with
> 		 * nlink == 0 because we're not allowed to put an inode
> 		 * with nlink > 0 on the unlinked list.  Therefore we
> 		 * have to set nlink to 1 so that d_tmpfile can
> 		 * immediately set it back to zero.
> 		 */
> 		set_nlink(inode, 1);
> 		d_tmpfile(tmpfile, inode);
> 	}

Yeah, that same game would technically work for bcachefs - but I'm
hoping we can just do the right thing here :)

> >    - Don't block on s_umount from __invalidate_super: this is a bugfix
> >      for a deadlock in generic/042 because of how we use sget(), the
> >      commit message goes into more detail.
> 
> If this is in reference to the earlier subthread about some io_uring
> thing causing unmount to hang -- my impressions of that were that yes,
> it's a bug, but no, it's not a bug in bcachefs itself.  I also wondered
> why (a) that hadn't split out as its own thread; and (b) is this really
> a bcachefs blocker?

No, this is completely unrelated. The io_uring thing hits on
generic/388 (and others) and just causes umount to fail with -EBUSY.
This one is an actual deadlock and it hits every time in generic/042.
It's specific to the loopback device and when it emits certain events,
and it hits every time so I really do need this fix included.

> /me shrugs, been on vacation and in hospitals for the last month or so.
> 
> >      bcachefs doesn't use sget() for mutual exclusion because a) sget()
> >      is insane, what we really want is the _block device_ to be opened
> >      exclusively (which we do), and we have our own block device opening
> >      path - which we need to, as we're a multi device filesystem.
> 
> ...and isn't jan kara already messing with this anyway?

The blkdev_get_handle() patchset? I like that, but I don't think that's
related - if there's something more related to sget() I haven't seen it
yet

> OTOH there's so many layers of tiny helper functions and macros that I
> have a really hard time making sense of all those pre-bcachefs changes.
> That's why I haven't weighed in.  Given all the weird problems we've had
> recently with new code colliding badly with under-documented optimized
> core code, I'm fearful of touching anything.

??? not sure what you're referring to here, are there specific patches
or recent issues you're thinking of?

I don't think any of the non-fs/bcachefs/ patches are remotely tricky
enough for any of this to be a concern.

> > You, the btrfs developers, got started when Linux filesystem teams were
> > quite a bit bigger than they are now: I was at Google when Google had a
> > bunch of people working on ext4, and that was when ZFS had recently come
> > out and there was recognition that Linux needed an answer to ZFS and you
> > were able to ride that excitement. It's been a bit harder for me to get
> > something equally ambitions going, to be honest.
> > 
> > But years ago when I realized I was onto something, I decided this
> > project was only going to fail if I let it fail - so I'm in it for the
> > long haul.
> > 
> > Right now what I'm hearing, in particular from Redhat, is that they want
> > it upstream in order to commit more resources. Which, I know, is not
> > what kernel people want to hear, but it's the chicken-and-the-egg
> > situation I'm in.
> 
> /me suspects mainline merging is necessary but not sufficient -- few
> non-developers want to deal with merging an out of tree filesystem, but
> that still doesn't mean anyone will commit real engineering resources.

Yeah, no doubt it will continue to be an uphill battle. But it's a
necessary step in the right direction, for sure.

> > > I am really, really wanting you to succeed here Kent.  If the general consensus
> > > is you need to have some idiot review fs/bcachefs I will happily carve out some
> > > time and dig in.
> > 
> > That would be much appreciated - I'll owe you some beers next time I see
> > you. But before jumping in, let's see if we can get people who have
> > already worked with the code to say something.
> > 
> > Something I've done in the past that might be helpful - instead (or in
> > addition to) having people read code in isolation, perhaps we could do a
> > group call/meeting where people can ask questions about the code, bring
> > up design issues they've seen in other filesystems, etc. - I've also
> > found that kind of setup great for identifying places in the code where
> > additional documentation would be useful.
> 
> "At this point I think Kent's QA efforts are at least as good as XFS's,
> just merge it and let's move on to the next thing."

high praise :)
