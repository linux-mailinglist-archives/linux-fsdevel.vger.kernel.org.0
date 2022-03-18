Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1283A4DDB5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 15:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbiCROP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 10:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbiCROP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC88E21C079
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647612847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xVu+mDTPb464jas0MF+N3kLKCYSGhLNWfvQBrQWtjhY=;
        b=NSY5k6CrS8NF8HFBKTnG+8GFRBrwAErF/DHleHCqD9lBEDh9abUURtB/fALHIP26pbNPJJ
        5BnpYl52BQW/AjTYxf2lsaIcsZOGp4H4YuIeXB8yy+fbjB1Uzg+pqxl/8WHj4OFr5VEtkN
        EqsHLSJWVSAc0A1K3cztr3yCg+BiYSU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-38IljzVeON2u0DynbMRKhg-1; Fri, 18 Mar 2022 10:14:06 -0400
X-MC-Unique: 38IljzVeON2u0DynbMRKhg-1
Received: by mail-qv1-f71.google.com with SMTP id g1-20020ad446c1000000b00440c9327221so6322538qvw.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 07:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xVu+mDTPb464jas0MF+N3kLKCYSGhLNWfvQBrQWtjhY=;
        b=63DkmdFyBmT3qlTKQ5PnEGregzE2jC2AHDkU+USCyPNtFUCXi6qydTTbSwzRHK2rk3
         dUVYOgB19tgzhKgjfnKXKGcWuzf+CqeRzj3sZYVCTka8gDq8iZvcGuhXAt4SIEea5mYX
         JYPCIAv/zZmVYEe1Jvr/G7QZ2JmwlNGH7Ol7pgsHpswL41k0+BW5OgRtsYPmpx0QjPjs
         F1iUhWYNvDY3vsRNj08Zkzs4QylnigKT9ks+skswMCO99VLlp4eGM9DiSiHOvMT1Ic8r
         baZgP1irxgLw6iIc1wFVX1a9rkN+wlwJ3spwJ/9QWdW11/JYSVWekWlWHsaPg31ykyHe
         FtgA==
X-Gm-Message-State: AOAM533s+eA5WhkVds/hTZV0/hxBgeLynjqnd8cr8cBH9+3k9v11jJD/
        U8STbmGcZ9HYB1w+Xs2ZaRPGZC5EzEIt9u3ejZVbJZMb7EKdn+5fUkPoxSnVteAPkgu4JHR+jUS
        VlY6D5JzzzPu2Qi2vLJ9VudLyhQ==
X-Received: by 2002:a37:a4f:0:b0:67c:a5c0:1648 with SMTP id 76-20020a370a4f000000b0067ca5c01648mr5972311qkk.192.1647612845796;
        Fri, 18 Mar 2022 07:14:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2yd4wU7zf90tU0xLYFOAIwdyNu2ueVxqX0kLDNar2X3NKO47u2vgSd0dj8IEeVgx4GnlF4w==
X-Received: by 2002:a37:a4f:0:b0:67c:a5c0:1648 with SMTP id 76-20020a370a4f000000b0067ca5c01648mr5972289qkk.192.1647612845370;
        Fri, 18 Mar 2022 07:14:05 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id f17-20020ac87f11000000b002e1e831366asm5760454qtk.77.2022.03.18.07.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 07:14:05 -0700 (PDT)
Date:   Fri, 18 Mar 2022 10:14:03 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <YjSTq4roN/LJ7Xsy@bfoster>
References: <YjDj3lvlNJK/IPiU@bfoster>
 <YjJPu/3tYnuKK888@casper.infradead.org>
 <YjM88OwoccZOKp86@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjM88OwoccZOKp86@bfoster>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 09:51:44AM -0400, Brian Foster wrote:
> On Wed, Mar 16, 2022 at 08:59:39PM +0000, Matthew Wilcox wrote:
> > On Tue, Mar 15, 2022 at 03:07:10PM -0400, Brian Foster wrote:
> > > What seems to happen is that the majority of the fsync calls end up
> > > waiting on writeback of a particular page, the wakeup of the writeback
> > > bit on that page wakes a task that immediately resets PG_writeback on
> > > the page such that N other folio_wait_writeback() waiters see the bit
> > > still set and immediately place themselves back onto the tail of the
> > > wait queue.  Meanwhile the waker task spins in the WQ_FLAG_BOOKMARK loop
> > > in folio_wake_bit() (backing off the lock for a cycle or so in each
> > > iteration) only to find the same bunch of tasks in the queue. This
> > > process repeats for a long enough amount of time to trigger the soft
> > > lockup warning. I've confirmed this spinning behavior with a tracepoint
> > > in the bookmark loop that indicates we're stuck for many hundreds of
> > > thousands of iterations (at least) of this loop when the soft lockup
> > > warning triggers.
> > 
> > [...]
> > 
> > > I've run a few quick experiments to try and corroborate this analysis.
> > > The problem goes away completely if I either back out the loop change in
> > > folio_wait_writeback() or bump WAITQUEUE_WALK_BREAK_CNT to something
> > > like 128 (i.e. greater than the total possible number of waiter tasks in
> > > this test). I've also played a few games with bookmark behavior mostly
> > > out of curiosity, but usually end up introducing other problems like
> > > missed wakeups, etc.
> > 
> > As I recall, the bookmark hack was introduced in order to handle
> > lock_page() problems.  It wasn't really supposed to handle writeback,
> > but nobody thought it would cause any harm (and indeed, it didn't at the
> > time).  So how about we only use bookmarks for lock_page(), since
> > lock_page() usually doesn't have the multiple-waker semantics that
> > writeback has?
> > 
> 
> Oh, interesting. I wasn't aware of the tenuous status of the bookmark
> code. This is indeed much nicer than anything I was playing with. I
> suspect it will address the problem, but I'll throw it at my test env
> for a while and follow up.. thanks!
> 

So I'm not clear on where we're at with this patch vs. something that
moves (or drops) the wb wait loop vs. the wait and set thing (which
seems more invasive and longer term), but FWIW.. this patch survived
over 10k iterations of the reproducer test yesterday (the problem
typically reproduces in ~1k or so iterations on average) and an
overnight fstests run without regression.

Brian

> Brian
> 
> > (this is more in the spirit of "minimal patch" -- I think
> > initialising the bookmark should be moved to folio_unlock()).
> > 
> > diff --git a/mm/filemap.c b/mm/filemap.c index
> > b2728eb52407..9ee3c5f1f489 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1146,26 +1146,28 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
> >  	return (flags & WQ_FLAG_EXCLUSIVE) != 0;
> >  }
> >  
> > -static void folio_wake_bit(struct folio *folio, int bit_nr)
> > +static void folio_wake_bit(struct folio *folio, int bit_nr,
> > +		wait_queue_entry_t *bookmark)
> >  {
> >  	wait_queue_head_t *q = folio_waitqueue(folio);
> >  	struct wait_page_key key;
> >  	unsigned long flags;
> > -	wait_queue_entry_t bookmark;
> >  
> >  	key.folio = folio;
> >  	key.bit_nr = bit_nr;
> >  	key.page_match = 0;
> >  
> > -	bookmark.flags = 0;
> > -	bookmark.private = NULL;
> > -	bookmark.func = NULL;
> > -	INIT_LIST_HEAD(&bookmark.entry);
> > +	if (bookmark) {
> > +		bookmark->flags = 0;
> > +		bookmark->private = NULL;
> > +		bookmark->func = NULL;
> > +		INIT_LIST_HEAD(&bookmark->entry);
> > +	}
> >  
> >  	spin_lock_irqsave(&q->lock, flags);
> > -	__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark);
> > +	__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, bookmark);
> >  
> > -	while (bookmark.flags & WQ_FLAG_BOOKMARK) {
> > +	while (bookmark && (bookmark->flags & WQ_FLAG_BOOKMARK)) {
> >  		/*
> >  		 * Take a breather from holding the lock,
> >  		 * allow pages that finish wake up asynchronously
> > @@ -1175,7 +1177,7 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
> >  		spin_unlock_irqrestore(&q->lock, flags);
> >  		cpu_relax();
> >  		spin_lock_irqsave(&q->lock, flags);
> > -		__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark);
> > +		__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, bookmark);
> >  	}
> >  
> >  	/*
> > @@ -1204,7 +1206,7 @@ static void folio_wake(struct folio *folio, int bit)
> >  {
> >  	if (!folio_test_waiters(folio))
> >  		return;
> > -	folio_wake_bit(folio, bit);
> > +	folio_wake_bit(folio, bit, NULL);
> >  }
> >  
> >  /*
> > @@ -1554,12 +1556,15 @@ static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem
> >   */
> >  void folio_unlock(struct folio *folio)
> >  {
> > +	wait_queue_entry_t bookmark;
> > +
> >  	/* Bit 7 allows x86 to check the byte's sign bit */
> >  	BUILD_BUG_ON(PG_waiters != 7);
> >  	BUILD_BUG_ON(PG_locked > 7);
> >  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> > +
> >  	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio, 0)))
> > -		folio_wake_bit(folio, PG_locked);
> > +		folio_wake_bit(folio, PG_locked, &bookmark);
> >  }
> >  EXPORT_SYMBOL(folio_unlock);
> >  
> > @@ -1578,7 +1583,7 @@ void folio_end_private_2(struct folio *folio)
> >  {
> >  	VM_BUG_ON_FOLIO(!folio_test_private_2(folio), folio);
> >  	clear_bit_unlock(PG_private_2, folio_flags(folio, 0));
> > -	folio_wake_bit(folio, PG_private_2);
> > +	folio_wake_bit(folio, PG_private_2, NULL);
> >  	folio_put(folio);
> >  }
> >  EXPORT_SYMBOL(folio_end_private_2);
> > 

