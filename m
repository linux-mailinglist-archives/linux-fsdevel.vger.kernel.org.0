Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DFF581E51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 05:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbiG0Dgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 23:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiG0Dgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:36:51 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0489192A5
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 20:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Oa1vOBaaBEtwNhNP9abvXdigvNJgyBKQb6oD7fN7bAo=; b=UqZpYRgZwOHkx+aW5AoQhiWp+G
        2MgE8L3oj70D8uqFdtiFwR4J/hsRmSQwagrwhjZrWpgbuFfMdXSnTHj9XyAIDQJt3DrafxHh/PsT+
        k7UU0zHZz5HrSvBWBankakPZcqK2xQPUVvYWURZQ0M/Bk2ysp8WgwlVaAtBCHRFACJSZXWqAJYMmp
        GmrPSoLgQNGw8Eqv71qmIapZgTzPJPwhztS+7uj1V0SLCDkN+z9NnpGJIIotWBZm0QtJBySrXGueA
        Ya+BEBh1oA6aV0Ooj2QjbtS/lK7+xCXR09xJGzWgnvz35qbFI3J4ucWeZMZavFX0tkJYI4neUGI/n
        3N5HBchQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oGXqr-00GEYX-BF;
        Wed, 27 Jul 2022 03:36:49 +0000
Date:   Wed, 27 Jul 2022 04:36:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/4] fs/dcache: Split __d_lookup_done()
Message-ID: <YuCy0Zzt/mq3IBz7@ZenIV>
References: <20220613140712.77932-1-bigeasy@linutronix.de>
 <20220613140712.77932-3-bigeasy@linutronix.de>
 <YuCxiWkbfWTT+p1f@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuCxiWkbfWTT+p1f@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 27, 2022 at 04:31:21AM +0100, Al Viro wrote:
> On Mon, Jun 13, 2022 at 04:07:10PM +0200, Sebastian Andrzej Siewior wrote:
> > __d_lookup_done() wakes waiters on dentry::d_wait inside a preemption
> > disabled region. This violates the PREEMPT_RT constraints as the wake up
> > acquires wait_queue_head::lock which is a "sleeping" spinlock on RT.
> 
> I'd probably turn that into something like
> 
> __d_lookup_done() wakes waiters on dentry->d_wait.  On PREEMPT_RT we are
> not allowed to do that with preemption disabled, since the wakeup
> acquired wait_queue_head::lock, which is a "sleeping" spinlock on RT.
> 
> Calling it under dentry->d_lock is not a problem, since that is also
> a "sleeping" spinlock on the same configs.  Unfortunately, two of
> its callers (__d_add() and __d_move()) are holding more than just ->d_lock
> and that needs to be dealt with.
> 
> The key observation is that wakeup can be moved to any point before
> dropping ->d_lock.
> 
> > As a first step to solve this, move the wake up outside of the
> > hlist_bl_lock() held section.
> > 
> > This is safe because:
> > 
> >   1) The whole sequence including the wake up is protected by dentry::lock.
> > 
> >   2) The waitqueue head is allocated by the caller on stack and can't go
> >      away until the whole callchain completes.
> 
> 	That's too vague and in one case simply incorrect - the call
> of d_alloc_parallel() in nfs_call_unlink() does *not* have wq in stack
> frame of anything in the callchain.  Incidentally, another unusual caller
> (d_add_ci()) has a bug (see below).  What really matters is that we can't
> reach destruction of wq without __d_lookup_done() under ->d_lock.
> 
> Waiters get inserted into ->d_wait only after they'd taken ->d_lock
> and observed DCACHE_PAR_LOOKUP in flags.  As long as they are
> woken up (and evicted from the queue) between the moment __d_lookup_done()
> has removed DCACHE_PAR_LOOKUP and dropping ->d_lock, we are safe,
> since the waitqueue ->d_wait points to won't get destroyed without
> having __d_lookup_done(dentry) called (under ->d_lock).
> 
> ->d_wait is set only by d_alloc_parallel() and only in case when
> it returns a freshly allocated in-lookup dentry.  Whenever that happens,
> we are guaranteed that __d_lookup_done() will be called for resulting
> dentry (under ->d_lock) before the wq in question gets destroyed.
> 
> With two exceptions wq lives in call frame of the caller of
> d_alloc_parallel() and we have an explicit d_lookup_done() on the
> resulting in-lookup dentry before we leave that frame.
> 
> One of those exceptions is nfs_call_unlink(), where wq is embedded into
> (dynamically allocated) struct nfs_unlinkdata.  It is destroyed in
> nfs_async_unlink_release() after an explicit d_lookup_done() on the
> dentry wq went into.
> 
> Remaining exception is d_add_ci().  There wq is what we'd found in
> ->d_wait of d_add_ci() argument.  Callers of d_add_ci() are two
> instances of ->d_lookup() and they must have been given an in-lookup
> dentry.  Which means that they'd been called by __lookup_slow() or
> lookup_open(), with wq in the call frame of one of those.
> 
> [[[
> Result of d_alloc_parallel() in d_add_ci() is fed to
> d_splice_alias(), which *NORMALLY* feeds it to __d_add() or
> __d_move() in a way that will have __d_lookup_done() applied to it.
> 
> 	However, there is a nasty possibility - d_splice_alias() might
> legitimately fail without having marked the sucker not in-lookup.  dentry
> will get dropped by d_add_ci(), so ->d_wait won't end up pointing to freed
> object, but it's still a bug - retain_dentry() will scream bloody murder
> upon seeing that, and for a good reason; we'll get hash chain corrupted.
> It's impossible to hit without corrupted fs image (ntfs or case-insensitive
> xfs), but it's a bug.  Fix is a one-liner (add d_lookup_done(found);
> right after
>         res = d_splice_alias(inode, found);
> 	if (res) {
> in d_add_ci()) and with that done the last sentence about d_add_ci() turns
> into
> ]]]
> 
> Result of d_alloc_parallel() in d_add_ci() is fed to
> d_splice_alias(), which either returns non-NULL (and d_add_ci() does
> d_lookup_done()) or feeds dentry to __d_add() that will do
> __d_lookup_done() under ->d_lock.  That concludes the analysis.
> 
> 
> PS: I'm not sure we need to do this migration of wakeup in stages;
> lift it into the caller of __d_lookup_done() as the first step,
> then move the damn thing all the way to end_dir_add().  Analysis
> can go into either...

PPS: I'm OK with the series in its current form; resplit mentioned above
is a matter of taste and if you prefer to keep the commit boundaries
as-is, I'm fine with that.  Commit message really needs to be changed,
though.  Would you be OK with the changes as above?
