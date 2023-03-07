Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF19B6AD72D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 07:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjCGGMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 01:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjCGGMk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:12:40 -0500
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEA675841
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 22:12:36 -0800 (PST)
Date:   Tue, 7 Mar 2023 01:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678169553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mecGPRXZZUU/NFzmTsFsVuhuHoeMLy8muOA4DSdwrhA=;
        b=VJwLGSf6FcLtD1ND94MAJ5h1tiOaFHf2fDiIP/V2XI5LN+13zDABYejgz361lJmWol+RpB
        kSyUtLgfPx6XglZyugm0fS2EKa1dqcO8cqabLYTAvMSJB/NNBoFmq0RmUXHWBO7sQS0ZBh
        mZcq2fga5Wp3lL0/1/Q0NXXtw3uPpIE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] bcachefs
Message-ID: <ZAbVztUAfEIWqhcY@moria.home.lan>
References: <Y/ZxFwCasnmPLUP6@moria.home.lan>
 <20230307050146.GA1637838@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307050146.GA1637838@frogsfrogsfrogs>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 06, 2023 at 09:01:46PM -0800, Darrick J. Wong wrote:
> On Wed, Feb 22, 2023 at 02:46:31PM -0500, Kent Overstreet wrote:
> > Hi, I'd like to give an update on bcachefs progress and talk about
> > upstreaming.
> > 
> > There's been a lot of activity over the past year or so:
> >  - allocator rewrite
> >  - cycle detector for deadlock avoidance
> 
> XFS has rather a lot of locks and no ability to unwind a transaction
> that has already dirtied incore state.  I bet you and I could have some
> very interesting discussions about how to implement robust tx undo in a
> filesystem.

Yeah, the main basic idea in bcachefs is that in any filesystem metadata
operation (say a create, or a chmod), we do it entirely within a
bcachefs btree transaction, and then only update vfs metadata (icache,
dcache) after a succesful transaction commit (and with btree locks still
held).

Not exactly the usual way of doing things - lots of the standard utility
code (e.g. posix_acl_chmod(), IIRC) wants to use the VFS inode as the
source of truth and the place to do the mutation. We don't want to do
that; we want to lock the inode in the btree, do the mutation, and then
update the VFS inode after transaction commit.

But the end result is really clean, and a lot of awkwardness in terms of
locking and error paths goes away with this model.

> (Not sure the /rest/ of the lsf crowd are going to care, but I do.)
> 
> >  - backpointers
> >  - test infrastructure!
> 
> <cough> "test dashboard that we can all share" ?

Possibly :) Getting a good CI going where I can just chuck code at it
and get results for the entire test suite (fstests and more) in a timely
manner (~20 minutes) has been huge for my productivity, and I'd really
love for others to be able to make use of this too.

Right now though the test results collector needs to be more scalable -
I should've gone with a database for test results from the start like
you did :) But if that happens, then yeah, I'd love to add more servers
to the cluster and have a big CI cluster for all of us filesystem
developers.

Having 10 or 20 of these 80 core arm64 servers (right now I'm renting 3)
so they all immediately start testing our git repos as we push would be
_huge_.

> >  - starting to integrate rust code (!)
> 
> I'm curious to hear about this topic, because I look at rust, and I look
> at supercomplex filesystem code and wonder how in the world we're ever
> going to port a (VERY SIMPLE) filesystem to Rust.  Now that I'm nearly
> done with online repair for XFS, there's a lot of stupid crap about C
> that I would like to start worrying about less because some other
> language added enough guard rails to avoid the stupid.

God yes, I can't wait to be writing new code in Rust instead of C. I
_like_ C, it's my mother tongue, but I'm ready for something better and
it's going to make for _drastically_ more maintainable code with less
debugging in the future.

Fully writing or rewriting any existing filesystem in Rust might take
another decade, but with bcachefs since we've got the btree/database
API, we've got a pretty small surface we can create a safe Rust wrapper
for, and then there's huge swaths of code that we can immediately start
incrementally converting.

I've already got the safe btree interface started, and I just merged the
first rewrite of existing C code - the 'bcachefs list' debug tool:

https://evilpiepirate.org/git/bcachefs-tools.git/tree/rust-src/src/cmd_list.rs

compare with the old C version:

https://evilpiepirate.org/git/bcachefs-tools.git/tree/cmd_list.c?id=0206d42daf4c4bd3bbcfa15a2bef34319524db49

Baby steps! but it's happening.

Some of the things I'm really fond of:
 - the Ord trait, which makes comparisons much more readable

 - the Display trait, which means we can pass _any object we want_ to
   the Rust equivalent of printf/printk!

 - Error handling! Result and ? are amazing.

 - No more iterator invalidation bugs! After you advance an iterator,
   the borrow checker _will not let you_ try to use the key peek()
   previously returned.

   The next step in the Rust btree wrapper is to teach the borrow
   checker about the semantics of bch2_trans_unlock() and
   bch2_trans_begin(). Good stuff.

I've been writing lots of random things in Rust lately - assorted
tooling, parts of ktest, and I'm just really fond of the language. I
can't emphasize enough how much thoughtfulness has gone into the
language; I haven't seen another language where it seems like they've
stolen every single good idea out there and not a single bad one.
(Idris, perhaps? I need to dig into that one, dependent types are
another thing that's going to be big in the future).

The Rust transition isn't the main thing I'm spending my time on right
now (that would be erasure coding) - but it really is the thing I'm most
excited about.

Fun times...
