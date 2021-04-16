Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB97362A3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 23:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244776AbhDPVZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 17:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235589AbhDPVZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618608302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TKRy1IG7OPwL6hb/OAIIdkCcfyxk1VBZfq/Tnz82kWE=;
        b=UaTHyylkdEnjASiceaE+4LT6C5l5pxXpvVDX4kwCOuYoXO3BRcVkaxATurCUQztxRCnaFx
        YIwv+6s/G9lJc23Nz5AJcrRMljN61tZ5wLUTyjUYDsSqX/jcaQgk5ODbvRqgU7kxJslF2c
        IMDjCyPBa2xl9/AF73QmD8Q7BPyF6FM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-MziAUdMdON65qhCCP-cy0A-1; Fri, 16 Apr 2021 17:25:00 -0400
X-MC-Unique: MziAUdMdON65qhCCP-cy0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD4256D582;
        Fri, 16 Apr 2021 21:24:59 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-117.rdu2.redhat.com [10.10.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E359107D5C3;
        Fri, 16 Apr 2021 21:24:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 045FF22054F; Fri, 16 Apr 2021 17:24:49 -0400 (EDT)
Date:   Fri, 16 Apr 2021 17:24:49 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Sergio Lopez <slp@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dax: Fix missed wakeup in put_unlocked_entry()
Message-ID: <20210416212449.GB1379987@redhat.com>
References: <20210416173524.GA1379987@redhat.com>
 <CAPcyv4h77oTMBQ50wg6eHLpkFMQ16oAHg2+D=d5zshT6iWgAfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h77oTMBQ50wg6eHLpkFMQ16oAHg2+D=d5zshT6iWgAfw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 12:56:05PM -0700, Dan Williams wrote:
> On Fri, Apr 16, 2021 at 10:35 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > I am seeing missed wakeups which ultimately lead to a deadlock when I am
> > using virtiofs with DAX enabled and running "make -j". I had to mount
> > virtiofs as rootfs and also reduce to dax window size to 32M to reproduce
> > the problem consistently.
> >
> > This is not a complete patch. I am just proposing this partial fix to
> > highlight the issue and trying to figure out how it should be fixed.
> > Should it be fixed in generic dax code or should filesystem (fuse/virtiofs)
> > take care of this.
> >
> > So here is the problem. put_unlocked_entry() wakes up waiters only
> > if entry is not null as well as !dax_is_conflict(entry). But if I
> > call multiple instances of invalidate_inode_pages2() in parallel,
> > then I can run into a situation where there are waiters on
> > this index but nobody will wait these.
> >
> > invalidate_inode_pages2()
> >   invalidate_inode_pages2_range()
> >     invalidate_exceptional_entry2()
> >       dax_invalidate_mapping_entry_sync()
> >         __dax_invalidate_entry() {
> >                 xas_lock_irq(&xas);
> >                 entry = get_unlocked_entry(&xas, 0);
> >                 ...
> >                 ...
> >                 dax_disassociate_entry(entry, mapping, trunc);
> >                 xas_store(&xas, NULL);
> >                 ...
> >                 ...
> >                 put_unlocked_entry(&xas, entry);
> >                 xas_unlock_irq(&xas);
> >         }
> >
> > Say a fault in in progress and it has locked entry at offset say "0x1c".
> > Now say three instances of invalidate_inode_pages2() are in progress
> > (A, B, C) and they all try to invalidate entry at offset "0x1c". Given
> > dax entry is locked, all tree instances A, B, C will wait in wait queue.
> >
> > When dax fault finishes, say A is woken up. It will store NULL entry
> > at index "0x1c" and wake up B. When B comes along it will find "entry=0"
> > at page offset 0x1c and it will call put_unlocked_entry(&xas, 0). And
> > this means put_unlocked_entry() will not wake up next waiter, given
> > the current code. And that means C continues to wait and is not woken
> > up.
> >
> > In my case I am seeing that dax page fault path itself is waiting
> > on grab_mapping_entry() and also invalidate_inode_page2() is
> > waiting in get_unlocked_entry() but entry has already been cleaned
> > up and nobody woke up these processes. Atleast I think that's what
> > is happening.
> >
> > This patch wakes up a process even if entry=0. And deadlock does not
> > happen. I am running into some OOM issues, that will debug.
> >
> > So my question is that is it a dax issue and should it be fixed in
> > dax layer. Or should it be handled in fuse to make sure that
> > multiple instances of invalidate_inode_pages2() on same inode
> > don't make progress in parallel and introduce enough locking
> > around it.
> >
> > Right now fuse_finish_open() calls invalidate_inode_pages2() without
> > any locking. That allows it to make progress in parallel to dax
> > fault path as well as allows multiple instances of invalidate_inode_pages2()
> > to run in parallel.
> >
> > Not-yet-signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/dax.c |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > Index: redhat-linux/fs/dax.c
> > ===================================================================
> > --- redhat-linux.orig/fs/dax.c  2021-04-16 12:50:40.141363317 -0400
> > +++ redhat-linux/fs/dax.c       2021-04-16 12:51:42.385926390 -0400
> > @@ -266,9 +266,10 @@ static void wait_entry_unlocked(struct x
> >
> >  static void put_unlocked_entry(struct xa_state *xas, void *entry)
> >  {
> > -       /* If we were the only waiter woken, wake the next one */
> > -       if (entry && !dax_is_conflict(entry))
> > -               dax_wake_entry(xas, entry, false);
> > +       if (dax_is_conflict(entry))
> > +               return;
> > +
> > +       dax_wake_entry(xas, entry, false);
> 

Hi Dan,

> How does this work if entry is NULL? dax_entry_waitqueue() will not
> know if it needs to adjust the index.

Wake waiters both at current index as well PMD adjusted index. It feels
little ugly though.

> I think the fix might be to
> specify that put_unlocked_entry() in the invalidate path needs to do a
> wake_up_all().

Doing a wake_up_all() when we invalidate an entry, sounds good. I will give
it a try.

Thanks
Vivek

