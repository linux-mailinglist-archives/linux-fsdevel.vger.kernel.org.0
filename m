Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05D51F9DD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 18:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgFOQt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 12:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730135AbgFOQtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:49:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E08C061A0E;
        Mon, 15 Jun 2020 09:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n620I7g8s0ql3gucyNnlL3uEs5vKKJIkLLIGCJ4euQw=; b=eNhf/BhIvn8pYbemVSAiSjA/JZ
        iXqySeDGZfIbwf9fT/SY5bBfu7OQRFSYkfS9e4Y0FVCz63AoyHTz+N3CBl5y0NFrsJuccGd8k0Dgy
        o/Sx3cdSQmjqJVX0JsUcJdQiXsWr7ZucHORRgvzK9dOP/uBpS6DzNmBoR1CzYMO9NC7B8ohmbdsr4
        n8AvZacMhjTtha924isarfSKWwp+WtWtqo32fj4Imsvrh/sC8aakdJOd64DxWZp7rV1v41pLT+xh7
        O2ST0Dv0/RHo7KSvxM3ZsxpAfRBp0xOEP54o+Akj7V2GjZfY/+1hog9WluhcM/oQQ9AtMgWWfSdi1
        KvBi239g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jksIA-0008NW-6G; Mon, 15 Jun 2020 16:49:02 +0000
Date:   Mon, 15 Jun 2020 09:49:02 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Waiman Long <longman@redhat.com>,
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
Message-ID: <20200615164902.GV8681@bombadil.infradead.org>
References: <000000000000760d0705a270ad0c@google.com>
 <69818a6c-7025-8950-da4b-7fdc065d90d6@redhat.com>
 <CACT4Y+brpePBoR7EUwPiSvGAgo6bhvpKvLTiCaCfRSadzn6yRw@mail.gmail.com>
 <88c172af-46df-116e-6f22-b77f98803dcb@redhat.com>
 <20200611142214.GI2531@hirez.programming.kicks-ass.net>
 <b405aca6-a3b2-cf11-a482-2b4af1e548bd@redhat.com>
 <20200611235526.GC94665@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200612070101.GA879624@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612070101.GA879624@tardis>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 03:01:01PM +0800, Boqun Feng wrote:
> On the archs using QUEUED_RWLOCKS, read_lock() is not always a recursive
> read lock, actually it's only recursive if in_interrupt() is true. So
> change the annotation accordingly to catch more deadlocks.

[...]

> +#ifdef CONFIG_LOCKDEP
> +/*
> + * read_lock() is recursive if:
> + * 1. We force lockdep think this way in selftests or
> + * 2. The implementation is not queued read/write lock or
> + * 3. The locker is at an in_interrupt() context.
> + */
> +static inline bool read_lock_is_recursive(void)
> +{
> +	return force_read_lock_recursive ||
> +	       !IS_ENABLED(CONFIG_QUEUED_RWLOCKS) ||
> +	       in_interrupt();
> +}

I'm a bit uncomfortable with having the _lockdep_ definition of whether
a read lock is recursive depend on what the _implementation_ is.
The locking semantics should be the same, no matter which architecture
you're running on.  If we rely on read locks being recursive in common
code then we have a locking bug on architectures which don't use queued
rwlocks.

I don't know whether we should just tell the people who aren't using
queued rwlocks that they have a new requirement or whether we should
say that read locks are never recursive, but having this inconsistency
is not a good idea!
