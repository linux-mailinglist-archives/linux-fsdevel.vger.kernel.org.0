Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51AA61A39D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 20:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDISaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 14:30:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52278 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgDISaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:30:12 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMbwG-00FMnw-TE; Thu, 09 Apr 2020 18:30:09 +0000
Date:   Thu, 9 Apr 2020 19:30:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] proc/mounts: add cursor
Message-ID: <20200409183008.GG23230@ZenIV.linux.org.uk>
References: <20200409141619.GF28467@miu.piliscsaba.redhat.com>
 <20200409165048.GE23230@ZenIV.linux.org.uk>
 <20200409165446.GF23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409165446.GF23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 05:54:46PM +0100, Al Viro wrote:
> On Thu, Apr 09, 2020 at 05:50:48PM +0100, Al Viro wrote:
> > On Thu, Apr 09, 2020 at 04:16:19PM +0200, Miklos Szeredi wrote:
> > > Solve this by adding a cursor entry for each open instance.  Taking the
> > > global namespace_sem for write seems excessive, since we are only dealing
> > > with a per-namespace list.  Instead add a per-namespace spinlock and use
> > > that together with namespace_sem taken for read to protect against
> > > concurrent modification of the mount list.  This may reduce parallelism of
> > > is_local_mountpoint(), but it's hardly a big contention point.  We could
> > > also use RCU freeing of cursors to make traversal not need additional
> > > locks, if that turns out to be neceesary.
> > 
> > Umm...  That can do more than reduction of parallelism - longer lists take
> > longer to scan and moving cursors dirties cachelines in a bunch of struct
> > mount instances.  And I'm not convinced that your locking in m_next() is
> > correct.
> > 
> > What's to stop umount_tree() from removing the next entry from the list
> > just as your m_next() tries to move the cursor?  I don't see any common
> > locks for those two...
> 
> Ah, you still have namespace_sem taken (shared) by m_start().  Nevermind
> that one, then...  Let me get through mnt_list users and see if I can
> catch anything.

OK...  Locking is safe, but it's not obvious.  And your changes do make it
scarier.   There are several kinds of lists that can be threaded through
->mnt_list and your code depends upon never having those suckers appear
in e.g. anon namespace ->list.  It is true (AFAICS), but...

Another fun question is ns->mounts rules - it used to be "the number of
entries in ns->list", now it's "the number of non-cursor entries there".
Incidentally, we might have a problem with that logics wrt count_mount().
Sigh...  The damn thing has grown much too convoluted over years ;-/

I'm still not happy with that patch; at the very least it needs a lot more
detailed analysis to go along with it.
