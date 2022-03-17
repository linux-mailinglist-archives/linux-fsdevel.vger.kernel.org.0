Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68934DC7E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 14:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiCQNxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 09:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiCQNxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E31C1AA48F
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647525108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iKbILpPpnN7imRoozJjDZNfBKXeUG41cjQ9Ij+ryjFs=;
        b=JX4CQiur9VENPXm8LctI5LxdHFNWpedw3/pMQpRQED0VmExxTdrBwHZR71RBWSmIhThUDV
        I/jHOKCuDNwEKGDtufT+qAiAjxh79gPX/Z8fsOLOmFgolEbezHqyvGDSJb3zsT+Xe+wJX1
        7UMALL2BFgtsFlSysnkSsmKOUkcDkdU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-z5KTlTxAMOSQ2F5OHWXZ_A-1; Thu, 17 Mar 2022 09:51:47 -0400
X-MC-Unique: z5KTlTxAMOSQ2F5OHWXZ_A-1
Received: by mail-qt1-f199.google.com with SMTP id cb11-20020a05622a1f8b00b002e06f729debso3570177qtb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 06:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iKbILpPpnN7imRoozJjDZNfBKXeUG41cjQ9Ij+ryjFs=;
        b=52F/VNpMA0J+qstF7MRMe55pRQsbhizDcjAy63pHNEWMxVxWLWG9wjdGg7KeIXuWng
         YRkPgat4thd2mt9AONZafV/tSYMvh46/6awG0PSSbSzTw4KhU3mMZD5m2M75toBG9yoi
         pEgpFYVbjH7JpAaltIfu76GZfc6oHxFoS3YwSURzLTlOKqXs8+g2lVuwyWcy1uQpGqqM
         kzbHHmrs5ahquRR2PDl61tLWccs6w5ZwuRy122WkCQpshZ4xwjcE+EG15lIf2QuoV0NF
         JM9v0s2OeiUoxywj9Pj0KqK1nkweCt7CtoxN4Me51/LpGhGNNoQV3nGKXwCOjh0i95bE
         6tgA==
X-Gm-Message-State: AOAM531njmP3afnWmsTRVdspUw2A2TM5ieNoHjeuwwVW3mAFgieVnms4
        FcQFne1CUXbPlXdbFER6pPlT25WH9f3Yb2Tpm8vxXwU0DCLN5sgGND4gfrX2cD5/6fsOH9PKWy2
        du3xHAvEjDo3njzGmfDFmLh68BQ==
X-Received: by 2002:ad4:5961:0:b0:435:a1d7:c243 with SMTP id eq1-20020ad45961000000b00435a1d7c243mr3626408qvb.46.1647525106850;
        Thu, 17 Mar 2022 06:51:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHAjc6UV88TAeKq6mZK5HSi6uYRrD+GMZuSbCOJEerxC44fv/M9qQ6MPpP+40UZpQszOE3AQ==
X-Received: by 2002:ad4:5961:0:b0:435:a1d7:c243 with SMTP id eq1-20020ad45961000000b00435a1d7c243mr3626378qvb.46.1647525106578;
        Thu, 17 Mar 2022 06:51:46 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id s19-20020a05622a179300b002e1ceeb21d0sm3585520qtk.97.2022.03.17.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 06:51:46 -0700 (PDT)
Date:   Thu, 17 Mar 2022 09:51:44 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <YjM88OwoccZOKp86@bfoster>
References: <YjDj3lvlNJK/IPiU@bfoster>
 <YjJPu/3tYnuKK888@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjJPu/3tYnuKK888@casper.infradead.org>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 08:59:39PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 15, 2022 at 03:07:10PM -0400, Brian Foster wrote:
> > What seems to happen is that the majority of the fsync calls end up
> > waiting on writeback of a particular page, the wakeup of the writeback
> > bit on that page wakes a task that immediately resets PG_writeback on
> > the page such that N other folio_wait_writeback() waiters see the bit
> > still set and immediately place themselves back onto the tail of the
> > wait queue.  Meanwhile the waker task spins in the WQ_FLAG_BOOKMARK loop
> > in folio_wake_bit() (backing off the lock for a cycle or so in each
> > iteration) only to find the same bunch of tasks in the queue. This
> > process repeats for a long enough amount of time to trigger the soft
> > lockup warning. I've confirmed this spinning behavior with a tracepoint
> > in the bookmark loop that indicates we're stuck for many hundreds of
> > thousands of iterations (at least) of this loop when the soft lockup
> > warning triggers.
> 
> [...]
> 
> > I've run a few quick experiments to try and corroborate this analysis.
> > The problem goes away completely if I either back out the loop change in
> > folio_wait_writeback() or bump WAITQUEUE_WALK_BREAK_CNT to something
> > like 128 (i.e. greater than the total possible number of waiter tasks in
> > this test). I've also played a few games with bookmark behavior mostly
> > out of curiosity, but usually end up introducing other problems like
> > missed wakeups, etc.
> 
> As I recall, the bookmark hack was introduced in order to handle
> lock_page() problems.  It wasn't really supposed to handle writeback,
> but nobody thought it would cause any harm (and indeed, it didn't at the
> time).  So how about we only use bookmarks for lock_page(), since
> lock_page() usually doesn't have the multiple-waker semantics that
> writeback has?
> 

Oh, interesting. I wasn't aware of the tenuous status of the bookmark
code. This is indeed much nicer than anything I was playing with. I
suspect it will address the problem, but I'll throw it at my test env
for a while and follow up.. thanks!

Brian

> (this is more in the spirit of "minimal patch" -- I think initialising
> the bookmark should be moved to folio_unlock()).
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b2728eb52407..9ee3c5f1f489 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1146,26 +1146,28 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
>  	return (flags & WQ_FLAG_EXCLUSIVE) != 0;
>  }
>  
> -static void folio_wake_bit(struct folio *folio, int bit_nr)
> +static void folio_wake_bit(struct folio *folio, int bit_nr,
> +		wait_queue_entry_t *bookmark)
>  {
>  	wait_queue_head_t *q = folio_waitqueue(folio);
>  	struct wait_page_key key;
>  	unsigned long flags;
> -	wait_queue_entry_t bookmark;
>  
>  	key.folio = folio;
>  	key.bit_nr = bit_nr;
>  	key.page_match = 0;
>  
> -	bookmark.flags = 0;
> -	bookmark.private = NULL;
> -	bookmark.func = NULL;
> -	INIT_LIST_HEAD(&bookmark.entry);
> +	if (bookmark) {
> +		bookmark->flags = 0;
> +		bookmark->private = NULL;
> +		bookmark->func = NULL;
> +		INIT_LIST_HEAD(&bookmark->entry);
> +	}
>  
>  	spin_lock_irqsave(&q->lock, flags);
> -	__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark);
> +	__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, bookmark);
>  
> -	while (bookmark.flags & WQ_FLAG_BOOKMARK) {
> +	while (bookmark && (bookmark->flags & WQ_FLAG_BOOKMARK)) {
>  		/*
>  		 * Take a breather from holding the lock,
>  		 * allow pages that finish wake up asynchronously
> @@ -1175,7 +1177,7 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
>  		spin_unlock_irqrestore(&q->lock, flags);
>  		cpu_relax();
>  		spin_lock_irqsave(&q->lock, flags);
> -		__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark);
> +		__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, bookmark);
>  	}
>  
>  	/*
> @@ -1204,7 +1206,7 @@ static void folio_wake(struct folio *folio, int bit)
>  {
>  	if (!folio_test_waiters(folio))
>  		return;
> -	folio_wake_bit(folio, bit);
> +	folio_wake_bit(folio, bit, NULL);
>  }
>  
>  /*
> @@ -1554,12 +1556,15 @@ static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem
>   */
>  void folio_unlock(struct folio *folio)
>  {
> +	wait_queue_entry_t bookmark;
> +
>  	/* Bit 7 allows x86 to check the byte's sign bit */
>  	BUILD_BUG_ON(PG_waiters != 7);
>  	BUILD_BUG_ON(PG_locked > 7);
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> +
>  	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio, 0)))
> -		folio_wake_bit(folio, PG_locked);
> +		folio_wake_bit(folio, PG_locked, &bookmark);
>  }
>  EXPORT_SYMBOL(folio_unlock);
>  
> @@ -1578,7 +1583,7 @@ void folio_end_private_2(struct folio *folio)
>  {
>  	VM_BUG_ON_FOLIO(!folio_test_private_2(folio), folio);
>  	clear_bit_unlock(PG_private_2, folio_flags(folio, 0));
> -	folio_wake_bit(folio, PG_private_2);
> +	folio_wake_bit(folio, PG_private_2, NULL);
>  	folio_put(folio);
>  }
>  EXPORT_SYMBOL(folio_end_private_2);
> 

