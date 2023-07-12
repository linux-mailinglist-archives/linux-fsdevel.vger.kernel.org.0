Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF29174FD52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 04:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjGLCzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 22:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGLCzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:55:12 -0400
Received: from out-44.mta1.migadu.com (out-44.mta1.migadu.com [IPv6:2001:41d0:203:375::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEE092
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 19:55:10 -0700 (PDT)
Date:   Tue, 11 Jul 2023 22:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689130508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TTgHrkQbrOC29sIfg7iHJUorOfkvxKlboJsQf7mIrxU=;
        b=mTmqTlC5d94/roVOtTFLQXurZA6y6KmI52x4dfnpPlRTta7KCLo2TIlwd+9GlLG0GNGgSI
        MpwFDiVwHDFQpFlpRmLJkehzAEvV1y2djUkQA6yU4B8SbIGFV+Ptuek0VRnEB+0qzgcEWr
        oWGkBjhHacreUf5IrFnMRgWnm63fJMY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706155602.mnhsylo3pnief2of@moria.home.lan>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So: looks like we missed the merge window. Boo :)

Summing up discussions from today's cabal meeting, other off list
discussions, and this thread:

 - bcachefs is now marked EXPERIMENTAL

 - Brian Foster will be listed as a reviewer

 - Josef's stepping up to do some code review, focusing on vfs-interacty
   bits. I'm hoping to do at least some of this in a format where Josef
   peppers me with questions and we turn that into new code
   documentation, so others can directly benefit: if anyone has an area
   they work on and would like to see documented in bcachefs, we'll take
   a look at that too.

 - Prereq patch series has been pruned down a bit more; also Mike
   Snitzer suggested putting those patches in their own branch:

   https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-prereqs

   "iov_iter: copy_folio_from_iter_atomic()" was dropped and replaced
   with willy's "iov_iter: Handle compound highmem pages in
   copy_page_from_iter_atomic()"; he said he'd try to send this for -rc4
   since it's technically a bug fix; in the meantime, it'll be getting
   more testing from my users.

   The two lockdep patches have been dropped for now; the
   bcachefs-for-upstream branch is switched back to
   lockdep_set_novalidate_class() for btree node locks. 

   six locks, mean and variance have been moved into fs/bcachefs/ for
   now; this means there's a new prereq patch to export
   osq_(lock|unlock)

   The remaining prereq patches are pretty trivial, with the exception
   of "block: Don't block on s_umount from __invalidate_super()". I
   would like to get a reviewed-by for that patch, and it wouldn't hurt
   for others.

   previously posting:
   https://lore.kernel.org/linux-bcachefs/20230509165657.1735798-1-kent.overstreet@linux.dev/T/#m34397a4d39f5988cc0b635e29f70a6170927746f

 - Code review was talked about a bit earlier in the thread: for the
   moment I'm just posting big stuff, but I'd like to aim for making
   sure all patches (including mine) hit the linux-bcachefs mailing list
   in the future:

   https://lore.kernel.org/linux-bcachefs/20230709171551.2349961-1-kent.overstreet@linux.dev/T/

 - We also talked quite a bit about the QA process. I'm going to work on
   finally publishing ktest/ktestci, which is my test infrastructure
   that myself and a few other people are using - I'd like to see it
   used more widely.

   For now, here's the test dashboard for the bcachefs-for-upstream
   branch:
   https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-for-upstream

 - Also: not directly related to upstreaming, but relevant for the
   community: we talked about getting together a meeting with some of
   the btrfs people to gather design input, ideas, and lessons learned.

   If anyone would be interested in working on and improving the multi
   device capabilities of bcachefs in particular, this would be a great
   time to get involved. That stuff is in good shape and seeing a lot of
   active use - it's one of bcachefs's major drawing points - and I want
   it to be even better.

And here's the branch I intend to re-submit next merge window, as it
currently sits:
https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-for-upstream

Please chime in if I forgot anything important... :)

Cheers,
Kent
