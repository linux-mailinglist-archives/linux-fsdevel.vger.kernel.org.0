Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5574A332
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 19:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGFRil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 13:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjGFRii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:38:38 -0400
Received: from out-51.mta1.migadu.com (out-51.mta1.migadu.com [IPv6:2001:41d0:203:375::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295751732;
        Thu,  6 Jul 2023 10:38:27 -0700 (PDT)
Date:   Thu, 6 Jul 2023 13:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688665105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YPOKcZwXrZbw7hcE8OABRQeVGx3tlFUEMhTgtxl1zww=;
        b=PRkVlUje55bqODzIVgfQeS/9G5yvL6GJDElbJjHLC919HcwjlzfeEpGTTHmvpOzK1ekEDS
        rBUQ9cZiygK9bizbo46Lhp29YC4c5BfGOFst+sv5hG76L1ckgvMRGLsrZbeMqtwdg3H8z0
        AcD48bA7myiP7KI+k9KDgEiSokHuS+Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        djwong@kernel.org, dchinner@redhat.com, sandeen@redhat.com,
        willy@infradead.org, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706164055.GA2306489@perftesting>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 06, 2023 at 12:40:55PM -0400, Josef Bacik wrote:
> I've been watching this from the sidelines sort of busy with other things, but I
> realize that comments I made at LSFMMBPF have been sort of taken as the gospel
> truth and I want to clear some of that up.
> 
> I said this at LSFMMBPF, and I haven't said it on list before so I'll repeat it
> here.
> 
> I'm of the opinion that me and any other outsider reviewing the bcachefs code in
> bulk is largely useless.  I could probably do things like check for locking
> stuff and other generic things.

Yeah, agreed. And the generic things - that's what we've got automated
testing for; there's a reason I've been putting so much effort into
automated testing over (especially) the past year.

> You have patches that are outside of fs/bcachefs.  Get those merged and then do
> a pull with just fs/bcachefs, because again posting 90k loc is going to be
> unwieldy and the quality of review just simply will not make a difference.
>
> Alternatively rework your code to not have any dependencies outside of
> fs/bcachefs.  This is what btrfs did.  That merge didn't touch anything outside
> of fs/btrfs.

We've had other people saying, at multiple times in the past, that
patches that are only needed for bcachefs should be part of the initial
pull instead of going in separately.

I've already cut down the non-bcachefs pull quite a bit, even to the
point of making non-ideal engineering choices, and if I have to cut it
down more it's going to mean more ugly choices.

> This merge attempt has gone off the rails, for what appears to be a few common
> things.
> 
> 1) The external dependencies.  There's a reason I was really specific about what
> I said at LSFMMBPF, both this year and in 2022.  Get these patches merged first,
> the rest will be easier.  You are burning a lot of good will being combative
> with people over these dependencies.  This is not the hill to die on.  You want
> bcachefs in the kernel and to get back to bcachefs things.  Make the changes you
> need to make to get these dependencies in, or simply drop the need for them and
> come back to it later after bcachefs is merged.

Look, I'm not at all trying to be combative, I'm just trying to push
things forward.

The one trainwreck-y thread was regarding vmalloc_exec(), and posting
that patch needed to happen in order to figure out what was even going
to happen regarding the dynamic codegen going forward. It's been dropped
from the initial pull, and dynamic codegen is going to wait on a better
executable memory allocation API.

(and yes, that thread _was_ a trainwreck; it's not good when you have
maintainers claiming endlessly that something is broken and making
arguments to authority but _not able to explain why_. The thread on the
new executable memory allocator still needs something more concrete on
the issues with speculative execution from Andy or someone else).

Let me just lay out the non-bcachefs dependencies:

 - two lockdep patches: these could technically be dropped from the
   series, but that would mean dropping lockdep support entirely for
   btree node locks, and even Linus has said we need to get rid of
   lockdep_no_validate_class so I'm hoping to avoid that.

 - six locks: this shouldn't be blocking, we can move them to
   fs/bcachefs/ if Linus still feels they need more review - but Dave
   Chinner was wanting them and the locking people disliked exporting
   osq_lock so that's why I have them in kernel/locking.

 - mean_and_variance: this is some statistics library code that computes
   mean and standard deviation for time samples, both standard and
   exponentially weighted. Again, bcachefs is the first user so this
   pull request is the proper place for this code, and I'm intending to
   convert bcache to this code as well as use it for other kernel wide
   latency tracking (which I demod at LSF awhile back; I'll be posting
   it again once code tagging is upstreamed as part of the memory
   allocation work Suren and I are doing).

 - task_struct->faults_disabled_mapping: this adds a task_struct member
   that makes it possible to do strict page cache coherency.

   This is something I intend to push into the VFS, but it's going to be
   a big project - it needs a new type of lock (the one in bcachefs is
   good enough for an initial implementation, but the real version
   probably needs priority inheritence and other things). In the
   meantime, I've thoroughly documented what's going on and what the
   plan is in the commit message.

 - d_mark_tmpfile(): trivial new helper, from pulling out part of
   d_tmpfile(). We need this because bcachefs handles the nlink count
   for tmpfiles earlier, in the btree transaction.

 - copy_folio_from_iter_atomic(): obvious new helper, other filesystems
   will want this at some point as part of the ongoing folio conversion

 - block layer patches: we have

   - new exports: primarily because bcachefs has its own dio path and
     does not use iomap, also blk_status_to_str() for better error
     messages

   - bio_iov_iter_get_pages() with bio->bi_bdev unset: bcachefs builds
     up bios before we know which block device those bios will be
     issued to.

     There was something thrown out about "bi_bdev being required" - but
     that doesn't make a lot of sense here. The direction in the block
     layer back when I made it sane for stacking block drivers - i.e.
     enabling efficient splitting/cloning of bios - was towards bios
     being more just simple iterators over a scatter/gather list, and
     now we've got iov_iter which can point at a bio/bvec array - moving
     even more in that direction.

     Regardless, this patch is pretty trivial, it's not something that
     commits us to one particular approach. bio_iov_iter_get_pages() is
     here trying to return bios that are aligned to the block device's
     blocksize, but in our case we just want it aligned to the
     filesystem's blocksize.

   - bring back zero_fill_bio_iter() - I originally wrote this,
     Christoph deleted it without checking. It's just a more general
     version of zero_fill_bio().
 
   - Don't block on s_umount from __invalidate_super: this is a bugfix
     for a deadlock in generic/042 because of how we use sget(), the
     commit message goes into more detail.

     bcachefs doesn't use sget() for mutual exclusion because a) sget()
     is insane, what we really want is the _block device_ to be opened
     exclusively (which we do), and we have our own block device opening
     path - which we need to, as we're a multi device filesystem.

 - generic radix tree fixes: this is just fixes for code I already wrote
   for bcachefs and upstreamed previously, after converting existing
   users of flex-array.

 - move closures to lib/ - this is also code I wrote, now needs to be
   shared with bcache

 - small stuff:
   - export stack_trace_save_stack() - this is used for displaying stack
     traces in debugfs
   - export errname() - better error messages
   - string_get_size() - change it to return number of characters written
   - compiler attributes - add __flatten

If there are objections to any of these patches, please _be specific_.
Please remember that I am also incorporating feedback previous
discussions, and a generic "these patches need to go in separately" is
not something I can do anything with, as explained previously.

> 2) We already have recent examples of merge and disappear.  Yes of course you've
> been around for a long time, you aren't the NTFS developers.  But as you point
> out it's 90k of code.  When btrfs was merged there were 3 large contributors,
> Chris, myself, and Yanzheng.  If Chris got hit by a bus we could still drive the
> project forward.  Can the same be said for bachefs?  I know others have chimed
> in and done some stuff, but as it's been stated elsewhere it would be good to
> have somebody else in the MAINTAINERS file with you.

Yes, the bcachefs project needs to grow in terms of developers. The
unfortunate reality is that right now is a _hard_ time to growing teams
and budgets in this area; it's been an uphill battle.

You, the btrfs developers, got started when Linux filesystem teams were
quite a bit bigger than they are now: I was at Google when Google had a
bunch of people working on ext4, and that was when ZFS had recently come
out and there was recognition that Linux needed an answer to ZFS and you
were able to ride that excitement. It's been a bit harder for me to get
something equally ambitions going, to be honest.

But years ago when I realized I was onto something, I decided this
project was only going to fail if I let it fail - so I'm in it for the
long haul.

Right now what I'm hearing, in particular from Redhat, is that they want
it upstream in order to commit more resources. Which, I know, is not
what kernel people want to hear, but it's the chicken-and-the-egg
situation I'm in.

> I am really, really wanting you to succeed here Kent.  If the general consensus
> is you need to have some idiot review fs/bcachefs I will happily carve out some
> time and dig in.

That would be much appreciated - I'll owe you some beers next time I see
you. But before jumping in, let's see if we can get people who have
already worked with the code to say something.

Something I've done in the past that might be helpful - instead (or in
addition to) having people read code in isolation, perhaps we could do a
group call/meeting where people can ask questions about the code, bring
up design issues they've seen in other filesystems, etc. - I've also
found that kind of setup great for identifying places in the code where
additional documentation would be useful.
