Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9EAEEF4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 06:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbfD3EAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 00:00:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38260 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfD3EAp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 00:00:45 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hLJwh-00071y-Ft; Tue, 30 Apr 2019 04:00:43 +0000
Date:   Tue, 30 Apr 2019 05:00:43 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] sorting out RCU-delayed stuff in
 ->destroy_inode()
Message-ID: <20190430040043.GH23075@ZenIV.linux.org.uk>
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
 <CAHk-=wh6cSEztastk6-A0HUSLtJT=9W38xMN5ht-OOAnL80jxg@mail.gmail.com>
 <20190430030914.GF23075@ZenIV.linux.org.uk>
 <CAHk-=wiMvCR0iENUVorfU-3EMC7G8RNSeHSQrz9tndP1uSg2BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiMvCR0iENUVorfU-3EMC7G8RNSeHSQrz9tndP1uSg2BQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 29, 2019 at 08:37:29PM -0700, Linus Torvalds wrote:
> On Mon, Apr 29, 2019, 20:09 Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> >
> > ... except that this callback can (and always could) get executed after
> > freeing struct super_block.
> >
> 
> Ugh.
> 
> That food looks nasty. Shouldn't the super block freeing wait for the
> filesystem to be all done instead? Do a rcu synchronization or something?
> 
> Adding that pointer looks really wrong to me. I'd much rather delay the sb
> freeing. Is there some reason that can't be done that I'm missing?

Where would you put that synchronize_rcu()?  Doing that before ->put_super()
is too early - inode references might be dropped in there.  OTOH, doing
that after that point means that while struct super_block itself will be
there, any number of data structures hanging from it might be not.

So we are still very limited in what we can do inside ->free_inode()
instance *and* we get bunch of synchronize_rcu() for no good reason.

Note that for normal lockless accesses (lockless ->d_revalidate(), ->d_hash(),
etc.) we are just fine with having struct super_block freeing RCU-delayed
(along with any data structures we might need) - the superblock had
been seen at some point after we'd taken rcu_read_lock(), so its
freeing won't happen until we drop it.  So we don't need synchronize_rcu()
for that.

Here the problem is that we are dealing with another RCU callback;
synchronize_rcu() would be needed for it, but it will only protect that
intermediate dereference of ->i_sb; any rcu-delayed stuff scheduled
from inside ->put_super() would not be ordered wrt ->free_inode().
And if we are doing that just for the sake of that one dereference,
we might as well do it before scheduling i_callback().

PS: we *are* guaranteed that module will still be there (unregister_filesystem()
does synchronize_rcu() and rcu_barrier() is done before kmem_cache_destroy()
in assorted exit_foo_fs()).
