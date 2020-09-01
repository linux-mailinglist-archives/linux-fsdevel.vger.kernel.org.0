Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5F9258E44
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 14:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgIAMfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 08:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgIAMfP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:35:15 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B778C061244;
        Tue,  1 Sep 2020 05:34:54 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD5Ut-008fhS-6Y; Tue, 01 Sep 2020 12:34:47 +0000
Date:   Tue, 1 Sep 2020 13:34:47 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+c282923e5da93549fa27@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in __fput (3)
Message-ID: <20200901123447.GG1236603@ZenIV.linux.org.uk>
References: <000000000000438ab305ae347ac4@google.com>
 <20200901023547.14976-1-hdanton@sina.com>
 <20200901084309.9528-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901084309.9528-1-hdanton@sina.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 01, 2020 at 04:43:09PM +0800, Hillf Danton wrote:

> Below is my 2c for making it safe to access the rbtree entry and the
> file tucked in it by bumping up the file count before adding epi into
> rbtree.

NAK.  epitems, by design, do *NOT* pin files down.  That's what
eventpoll_release() is about - those references are not counting and
epitems can be taken out by the final close.

It's a user-visible aspect of API.  And the problem Marc's patch was
trying to solve had nothing to do with that - at the root it's
the lack of suitable exclusion and the atrocious way loop prevention
and reverse path count checks are done on watch insertion.

What happens there is that files that would have paths added by
EPOLL_CTL_ADD (including those via several intermediate epoll files)
are collected into a temporary list and then checked for excessive
reverse paths.  The list is emptied before epoll_ctl() returns.

And that's _the_ list - if epoll_ctl decides to go there in the
first place, it grabs a system-wide mutex and holds it as long as
it's playing around.  Everything would've worked, if not for the
fact that
	* the bloody list goes through struct file instances.  It's
a bad decision, for a lot of reasons.
	* in particular, files can go away while epoll_ctl() is playing
around.  The same system-wide mutex would've blocked their freeing (modulo
a narrow race in eventpoll_release()) *IF* they remained attached to
epitems.  However, explicit EPOLL_CTL_DEL removing such a beast
in the middle of EPOLL_CTL_ADD checks will remove such epitems without
touching the same mutex.

Marc's patch tried to brute-force the protection of files in that
temporary list; what it had missed was the fact that a file on it could
have already been committed to getting killed - f_count already zero,
just hadn't gotten through the __fput() yet.  In such cases we don't
want to do any reverse path checks for that sucker - it *is* going
away, so there's no point considering it.  We can't blindly bump the
refcount, though, for obvious reasons.

That struct file can't get freed right under the code inserting it into
the list - the locks held at the moment (ep->mtx) are more than enough.
It's what can happen to it while on the list that is a problem.

Of course, as a long-term solution we want to have that crap with
temporary list going through struct file instances taken out and
moved to epitems themselves; the check does scan all epitems for
every file in the set and we bloody well could gather those into
the list at once.  Then we'd only need to protect the list walking
vs. removals (with a spinlock, for all we care).

It's too invasive a change for -stable, though, and I'm still digging
through fs/eventpoll.c locking - it's much too convoluted and it
got no attention for a decade ;-/
