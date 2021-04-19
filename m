Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE5B364B43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 22:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhDSUk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 16:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232217AbhDSUk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 16:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618864798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HTvQplBtlnSAuxCl+GaMhVm2KFbeKbpYfjP9TAu31xU=;
        b=S4srcdvLAGBNCBjBG1/+CT2xHWIUUJkqcQHkoAM0+hDxgCCb7DU4nJyBVtBAS0nrY8B1uf
        uZoXA4wySw5hc5JG+fAfYyk3HEXILTNPvgLegF1ZrgBB5iTgJMXfcxhjGufke9KNoAl2YW
        q+KcEh5i9lhAxPrhmRUDZIy/hDX4KwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-AR-euLuYN9KJREk7kmR0Gw-1; Mon, 19 Apr 2021 16:39:56 -0400
X-MC-Unique: AR-euLuYN9KJREk7kmR0Gw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F6048030A0;
        Mon, 19 Apr 2021 20:39:54 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-35.rdu2.redhat.com [10.10.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98D231002EE6;
        Mon, 19 Apr 2021 20:39:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 37EEE22054F; Mon, 19 Apr 2021 16:39:47 -0400 (EDT)
Date:   Mon, 19 Apr 2021 16:39:47 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Sergio Lopez <slp@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][v2] dax: Fix missed wakeup during dax entry invalidation
Message-ID: <20210419203947.GG1472665@redhat.com>
References: <20210419184516.GC1472665@redhat.com>
 <CAPcyv4jR5d+-99wVMm9SHxNBOsp0FUi7wzDNsefkZ1oqUZ7joQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jR5d+-99wVMm9SHxNBOsp0FUi7wzDNsefkZ1oqUZ7joQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 12:48:58PM -0700, Dan Williams wrote:
> On Mon, Apr 19, 2021 at 11:45 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > This is V2 of the patch. Posted V1 here.
> >
> > https://lore.kernel.org/linux-fsdevel/20210416173524.GA1379987@redhat.com/
> >
> > Based on feedback from Dan and Jan, modified the patch to wake up
> > all waiters when dax entry is invalidated. This solves the issues
> > of missed wakeups.
> 
> Care to send a formal patch with this commentary moved below the --- line?
> 
> One style fixup below...
> 
> >
> > I am seeing missed wakeups which ultimately lead to a deadlock when I am
> > using virtiofs with DAX enabled and running "make -j". I had to mount
> > virtiofs as rootfs and also reduce to dax window size to 256M to reproduce
> > the problem consistently.
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
> > This patch fixes the issue by waking up all waiters when a dax entry
> > has been invalidated. This seems to fix the deadlock I am facing
> > and I can make forward progress.
> >
> > Reported-by: Sergio Lopez <slp@redhat.com>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/dax.c |   12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > Index: redhat-linux/fs/dax.c
> > ===================================================================
> > --- redhat-linux.orig/fs/dax.c  2021-04-16 14:16:44.332140543 -0400
> > +++ redhat-linux/fs/dax.c       2021-04-19 11:24:11.465213474 -0400
> > @@ -264,11 +264,11 @@ static void wait_entry_unlocked(struct x
> >         finish_wait(wq, &ewait.wait);
> >  }
> >
> > -static void put_unlocked_entry(struct xa_state *xas, void *entry)
> > +static void put_unlocked_entry(struct xa_state *xas, void *entry, bool wake_all)
> >  {
> >         /* If we were the only waiter woken, wake the next one */
> >         if (entry && !dax_is_conflict(entry))
> > -               dax_wake_entry(xas, entry, false);
> > +               dax_wake_entry(xas, entry, wake_all);
> >  }
> >
> >  /*
> > @@ -622,7 +622,7 @@ struct page *dax_layout_busy_page_range(
> >                         entry = get_unlocked_entry(&xas, 0);
> >                 if (entry)
> >                         page = dax_busy_page(entry);
> > -               put_unlocked_entry(&xas, entry);
> > +               put_unlocked_entry(&xas, entry, false);
> 
> I'm not a fan of raw true/false arguments because if you read this
> line in isolation you need to go read put_unlocked_entry() to recall
> what that argument means. So lets add something like:
> 
> /**
>  * enum dax_entry_wake_mode: waitqueue wakeup toggle
>  * @WAKE_NEXT: entry was not mutated
>  * @WAKE_ALL: entry was invalidated, or resized
>  */
> enum dax_entry_wake_mode {
>         WAKE_NEXT,
>         WAKE_ALL,
> }
> 
> ...and use that as the arg for dax_wake_entry(). So I'd expect this to
> be a 3 patch series, introduce dax_entry_wake_mode for
> dax_wake_entry(), introduce the argument for put_unlocked_entry()
> without changing the logic, and finally this bug fix. Feel free to add
> 'Fixes: ac401cc78242 ("dax: New fault locking")' in case you feel this
> needs to be backported.

Hi Dan,

I will make changes as you suggested and post another version.

I am wondering what to do with dax_wake_entry(). It also has a boolean
parameter wake_all. Should that be converted as well to make use of
enum dax_entry_wake_mode?

Thanks
Vivek

