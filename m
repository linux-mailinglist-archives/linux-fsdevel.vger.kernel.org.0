Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD87619264
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 09:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiKDIE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 04:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiKDIEY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:04:24 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC7B2657A;
        Fri,  4 Nov 2022 01:04:21 -0700 (PDT)
Received: from letrec.thunk.org (guestnat-104-133-8-97.corp.google.com [104.133.8.97] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2A484ICK021299
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Nov 2022 04:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1667549060; bh=moS+CuyFo/iNk12/7L0jlf5OeXKrD4AexiQVcA1f9j8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=F5gcCLGTqiRzwEO8tX435sMMUO98xjBKvM80PtzwWZs3D/7CuiM3KJrcIhJroylM+
         hETcagEc7uki9CRXr6ne5RPJ7g7j89zCPnu+GSH34zHhRnU0us/3AU846Oh5KUs4yU
         e7BWTRcDyDUcl6Orss+5CiucFdctGXdCJ3LIGT9czozzvYW3+3zL/i/9gXWfRVdeAm
         l6TUAzRkLkCFNJC5ofnSvt9OtAVXuFdFpG7ye75vFxa1QUeAcWAztVOavq38gEUdck
         YXYOqgQ4APZz25TmDvqRK2PQGUEu4ZAZIKrcRlJ6FuUZDsL9md82/5eL53TMb2/kGd
         muvJp/zA1/JrA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id AFB0F8C0031; Fri,  4 Nov 2022 04:04:17 -0400 (EDT)
Date:   Fri, 4 Nov 2022 04:04:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com
Subject: Re: [QUESTION] {start,stop}_this_handle() and lockdep annotations
Message-ID: <Y2THgc9xgnUJg0Io@mit.edu>
References: <1667541392-16270-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667541392-16270-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Note: in the future, I'd recommend looking at the MAINTAINERS to
figure out a smaller list of people to ask this question, instead of
spamming everyone who has ever expressed interest in DEPT.


On Fri, Nov 04, 2022 at 02:56:32PM +0900, Byungchul Park wrote:
> Peterz (commit 34a3d1e8370870 lockdep: annotate journal_start()) and
> the commit message quoted what Andrew Morton said. It was like:
> 
> > Except lockdep doesn't know about journal_start(), which has ranking
> > requirements similar to a semaphore.
> 
> Could anyone tell what the ranking requirements in the journal code
> exactly means and what makes {start,stop}_this_handle() work for the
> requirements?

The comment from include/linux/jbd2.h may be helpful:

#ifdef CONFIG_DEBUG_LOCK_ALLOC
	/**
	 * @j_trans_commit_map:
	 *
	 * Lockdep entity to track transaction commit dependencies. Handles
	 * hold this "lock" for read, when we wait for commit, we acquire the
	 * "lock" for writing. This matches the properties of jbd2 journalling
	 * where the running transaction has to wait for all handles to be
	 * dropped to commit that transaction and also acquiring a handle may
	 * require transaction commit to finish.
	 */
	struct lockdep_map	j_trans_commit_map;
#endif

And the reason why this isn't a problem is because start_this_handle()
can be passed a special handle which is guaranteed to not block
(because we've reserved journal credits for it).  Hence, there is no
risk that in _this_ call path start_this_handle() will block for a
commit:

> <4>[   43.124442 ] stacktrace:
> <4>[   43.124443 ]       start_this_handle+0x557/0x620
> <4>[   43.124445 ]       jbd2_journal_start_reserved+0x4d/0x1b0
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> <4>[   43.124448 ]       __ext4_journal_start_reserved+0x6d/0x190
> <4>[   43.124450 ]       ext4_convert_unwritten_io_end_vec+0x22/0xd0
> <4>[   43.124453 ]       ext4_end_io_rsv_work+0xe4/0x190
> <4>[   43.124455 ]       process_one_work+0x301/0x660
> <4>[   43.124458 ]       worker_thread+0x3a/0x3c0
> <4>[   43.124459 ]       kthread+0xef/0x120
> <4>[   43.124462 ]       ret_from_fork+0x22/0x30


The comment for this function from fs/jbd2/transaction.c:

/**
 * jbd2_journal_start_reserved() - start reserved handle
 * @handle: handle to start
 * @type: for handle statistics
 * @line_no: for handle statistics
 *
 * Start handle that has been previously reserved with jbd2_journal_reserve().
 * This attaches @handle to the running transaction (or creates one if there's
 * not transaction running). Unlike jbd2_journal_start() this function cannot
 * block on journal commit, checkpointing, or similar stuff. It can block on
 * memory allocation or frozen journal though.
 *
 * Return 0 on success, non-zero on error - handle is freed in that case.
 */

And this is why this will never be a problem in real life, or flagged
by Lockdep, since Lockdep is a dynamic checker.  The deadlock which
the static DEPT checker has imagined can never, ever, ever happen.

For more context, also from fs/jbd2/transaction.c:

/**
 * jbd2_journal_start() - Obtain a new handle.
 * @journal: Journal to start transaction on.
 * @nblocks: number of block buffer we might modify
 *
 * We make sure that the transaction can guarantee at least nblocks of
 * modified buffers in the log.  We block until the log can guarantee
 * that much space. Additionally, if rsv_blocks > 0, we also create another
 * handle with rsv_blocks reserved blocks in the journal. This handle is
 * stored in h_rsv_handle. It is not attached to any particular transaction
 * and thus doesn't block transaction commit. If the caller uses this reserved
 * handle, it has to set h_rsv_handle to NULL as otherwise jbd2_journal_stop()
 * on the parent handle will dispose the reserved one. Reserved handle has to
 * be converted to a normal handle using jbd2_journal_start_reserved() before
 * it can be used.
 *
 * Return a pointer to a newly allocated handle, or an ERR_PTR() value
 * on failure.
 */

To be clear, I don't blame DEPT for not being able to figure this out;
it would require human-level intelligence to understand why in *this*
call path, we never end up waiting.  But this is why I am very
skeptical of static analyzers which are *sure* that anything they flag
is definitely a bug.  We definitely will need a quick and easy way to
tell DEPT, "go home, you're drunk".

Hope this helps,

					- Ted


P.S.  Note: the actual function names are a bit misleading.  It looks
like the functions got refactored, and the documentation wasn't
updated to match.  Sigh... fortuantely the concepts are accurate; it's
just that function names needs to be fixed up.  For example, creating
a reserved handle is no longer done via jbd2_journal_start(), but
rather jbd2__journal_start().  

