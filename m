Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C2F1FA1D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 22:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbgFOUlM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 16:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbgFOUlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:41:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592B6C061A0E;
        Mon, 15 Jun 2020 13:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kK+1jIWxN5k17bJ7A2t/Kwz+X4qUhI2qmBIqCreK+hE=; b=Kb4G8CJtwr0WDiJri9s7FgMVUJ
        oiI15ebm0aDGuPyAfOapazyLDysYpOzrndj7dnBhbdgeNcnIqHtHZVo0t/4uEU+eyI6dswGndaUDk
        4XJ6tej2Gn71BSyUz+hpN56kJ/6OhX3EPuGYYjQKqLAHfh7G6u+jFhpqscG1Gf55AFtH7P5mG0Lvv
        a3KIc2/KEt2SvdYnl3p9XoL4NdSN8Sv6li4ozPs+G3ddTfDboY2AU2LANoH9/fDBj/ZXSe2LN/Ixm
        guRiw2uzxsNV9xr1w2kqr18qlBlChoGXFD4ARWH1UGXvq2GLSxRUrZElH5QKaqIe5y1Wlh7gbOUpW
        uvRzR69g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkvuQ-000891-O1; Mon, 15 Jun 2020 20:40:46 +0000
Date:   Mon, 15 Jun 2020 13:40:46 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, allison@lohutok.net,
        areber@redhat.com, aubrey.li@linux.intel.com,
        Andrei Vagin <avagin@gmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        Christian Brauner <christian@brauner.io>, cyphar@cyphar.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, guro@fb.com,
        Jeff Layton <jlayton@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>, linmiaohe@huawei.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, sargun@sargun.me,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: possible deadlock in send_sigio
Message-ID: <20200615204046.GW8681@bombadil.infradead.org>
References: <000000000000760d0705a270ad0c@google.com>
 <69818a6c-7025-8950-da4b-7fdc065d90d6@redhat.com>
 <CACT4Y+brpePBoR7EUwPiSvGAgo6bhvpKvLTiCaCfRSadzn6yRw@mail.gmail.com>
 <88c172af-46df-116e-6f22-b77f98803dcb@redhat.com>
 <20200611142214.GI2531@hirez.programming.kicks-ass.net>
 <b405aca6-a3b2-cf11-a482-2b4af1e548bd@redhat.com>
 <20200611235526.GC94665@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200612070101.GA879624@tardis>
 <20200615164902.GV8681@bombadil.infradead.org>
 <0c854a69-9b89-9e45-f2c1-e60e2a9d3f1c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c854a69-9b89-9e45-f2c1-e60e2a9d3f1c@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 01:13:51PM -0400, Waiman Long wrote:
> On 6/15/20 12:49 PM, Matthew Wilcox wrote:
> > On Fri, Jun 12, 2020 at 03:01:01PM +0800, Boqun Feng wrote:
> > > On the archs using QUEUED_RWLOCKS, read_lock() is not always a recursive
> > > read lock, actually it's only recursive if in_interrupt() is true. So
> > > change the annotation accordingly to catch more deadlocks.
> > [...]
> > 
> > > +#ifdef CONFIG_LOCKDEP
> > > +/*
> > > + * read_lock() is recursive if:
> > > + * 1. We force lockdep think this way in selftests or
> > > + * 2. The implementation is not queued read/write lock or
> > > + * 3. The locker is at an in_interrupt() context.
> > > + */
> > > +static inline bool read_lock_is_recursive(void)
> > > +{
> > > +	return force_read_lock_recursive ||
> > > +	       !IS_ENABLED(CONFIG_QUEUED_RWLOCKS) ||
> > > +	       in_interrupt();
> > > +}
> > I'm a bit uncomfortable with having the _lockdep_ definition of whether
> > a read lock is recursive depend on what the _implementation_ is.
> > The locking semantics should be the same, no matter which architecture
> > you're running on.  If we rely on read locks being recursive in common
> > code then we have a locking bug on architectures which don't use queued
> > rwlocks.
> > 
> > I don't know whether we should just tell the people who aren't using
> > queued rwlocks that they have a new requirement or whether we should
> > say that read locks are never recursive, but having this inconsistency
> > is not a good idea!
> 
> Actually, qrwlock is more restrictive. It is possible that systems with
> qrwlock may hit deadlock which doesn't happens in other systems that use
> recursive rwlock. However, the current lockdep code doesn't detect those
> cases.

Oops.  I misread.  Still, my point stands; we should have the same
definition of how you're allowed to use locks from the lockdep point of
view, even if the underlying implementation won't deadlock on a particular
usage model.


So I'd be happy with:

+	return lockdep_pretend_in_interrupt || in_interrupt();

to allow the test-suite to test that it works as expected, without
actually disabling interrupts while the testsuite runs.

