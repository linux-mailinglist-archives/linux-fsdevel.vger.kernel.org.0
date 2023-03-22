Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202FA6C4B51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 14:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjCVNJl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 09:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCVNJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1020574C9
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679490532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sOkHuOKT5TrdMbQ7ausoErRO6DBZAgZjkwk79qxntJo=;
        b=YsO3NO5D31n2aM7/sZswjc+hfWhCFyjx+5128q63iKv8i/uRAF5ytkTulE01ZkwzEfRW48
        E6UavHw8CHTSO9TI/sY73P8Rlg6rA5HaJoC/RD4EHtZrvQATAaProO9b52qRHtV9KstCsz
        Ok8ZQ/970O61AJiMJ4APqEL5KeQkAFc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-iG2ZqcGGOo2BI97vMjqxrQ-1; Wed, 22 Mar 2023 09:08:51 -0400
X-MC-Unique: iG2ZqcGGOo2BI97vMjqxrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD6CE886466;
        Wed, 22 Mar 2023 13:08:50 +0000 (UTC)
Received: from localhost (ovpn-13-195.pek2.redhat.com [10.72.13.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B9A01731B;
        Wed, 22 Mar 2023 13:08:49 +0000 (UTC)
Date:   Wed, 22 Mar 2023 21:08:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 3/4] iov_iter: add copy_page_to_iter_atomic()
Message-ID: <ZBr93qtCxRXl7o0V@MiWiFi-R3L-srv>
References: <cover.1679431886.git.lstoakes@gmail.com>
 <31482908634cbb68adafedb65f0b21888c194a1b.1679431886.git.lstoakes@gmail.com>
 <ZBrVtcqATRybF/hW@MiWiFi-R3L-srv>
 <a961ab9c-1ced-4db4-a76f-d886bd01c715@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a961ab9c-1ced-4db4-a76f-d886bd01c715@lucifer.local>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/22/23 at 10:32am, Lorenzo Stoakes wrote:
> On Wed, Mar 22, 2023 at 06:17:25PM +0800, Baoquan He wrote:
> > On 03/21/23 at 08:54pm, Lorenzo Stoakes wrote:
> > > Provide an atomic context equivalent for copy_page_to_iter(). This eschews
> > > the might_fault() check copies memory in the same way that
> > > copy_page_from_iter_atomic() does.
> > >
> > > This functions assumes a non-compound page, however this mimics the
> > > existing behaviour of copy_page_from_iter_atomic(). I am keeping the
> > > behaviour consistent between the two, deferring any such change to an
> > > explicit folio-fication effort.
> > >
> > > This is being added in order that an iteratable form of vread() can be
> > > implemented with known prefaulted pages to avoid the need for mutex
> > > locking.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > > ---
> > >  include/linux/uio.h |  2 ++
> > >  lib/iov_iter.c      | 28 ++++++++++++++++++++++++++++
> > >  2 files changed, 30 insertions(+)
> > >
> > > diff --git a/include/linux/uio.h b/include/linux/uio.h
> > > index 27e3fd942960..fab07103090f 100644
> > > --- a/include/linux/uio.h
> > > +++ b/include/linux/uio.h
> > > @@ -154,6 +154,8 @@ static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
> > >
> > >  size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
> > >  				  size_t bytes, struct iov_iter *i);
> > > +size_t copy_page_to_iter_atomic(struct page *page, unsigned offset,
> > > +				size_t bytes, struct iov_iter *i);
> > >  void iov_iter_advance(struct iov_iter *i, size_t bytes);
> > >  void iov_iter_revert(struct iov_iter *i, size_t bytes);
> > >  size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t bytes);
> > > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > > index 274014e4eafe..48ca1c5dfc04 100644
> > > --- a/lib/iov_iter.c
> > > +++ b/lib/iov_iter.c
> > > @@ -821,6 +821,34 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t byt
> > >  }
> > >  EXPORT_SYMBOL(copy_page_from_iter_atomic);
> > >
> > > +size_t copy_page_to_iter_atomic(struct page *page, unsigned offset, size_t bytes,
> > > +				struct iov_iter *i)
> > > +{
> > > +	char *kaddr = kmap_local_page(page);
> >
> > I am a little confused about the name of this new function. In its
> > conterpart, copy_page_from_iter_atomic(), kmap_atomic()/kunmpa_atomic()
> > are used. With them, if CONFIG_HIGHMEM=n, it's like below:
> 
> The reason for this is that:-
> 
> 1. kmap_atomic() explicitly states that it is now deprecated and must no longer
>    be used, and kmap_local_page() should be used instead:-
> 
>  * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
> 
>  * Do not use in new code. Use kmap_local_page() instead.
> 
> 2. kmap_local_page() explicitly states that it can be used in any context:-
> 
>  * Can be invoked from any context, including interrupts.

Yeah, I saw that stated in document too. With my understanding, it's the
page mapping itself will be guaranteed and can be used in any context
when kmap_local_page() is taken. However, here kmap_local_page() is used
to make the code block atomic, it could be not achieved.

> 
> I wanted follow this advice as strictly as I could, hence the change. However,
> we do need preemption/pagefaults explicitly disabled in this context (we are
> happy to fail if the faulted in pages are unmapped in meantime), and I didn't
> check the internals to make sure.
> 
> So I think for safety it is better to use k[un]map_atomic() here, I'll respin
> and put that back in, good catch!
> 
> >
> > static inline void *kmap_atomic(struct page *page)
> > {
> >         if (IS_ENABLED(CONFIG_PREEMPT_RT))
> >                 migrate_disable();
> >         else
> >                 preempt_disable();
> >         pagefault_disable();
> >         return page_address(page);
> > }
> >
> > But kmap_local_page() is only having page_address(), the code block
> > between kmap_local_page() and kunmap_local() is also atomic, it's a
> > little messy in my mind.
> >
> > static inline void *kmap_local_page(struct page *page)
> > {
> >         return page_address(page);
> > }
> >
> > > +	char *p = kaddr + offset;
> > > +	size_t copied = 0;
> > > +
> > > +	if (!page_copy_sane(page, offset, bytes) ||
> > > +	    WARN_ON_ONCE(i->data_source))
> > > +		goto out;
> > > +
> > > +	if (unlikely(iov_iter_is_pipe(i))) {
> > > +		copied = copy_page_to_iter_pipe(page, offset, bytes, i);
> > > +		goto out;
> > > +	}
> > > +
> > > +	iterate_and_advance(i, bytes, base, len, off,
> > > +		copyout(base, p + off, len),
> > > +		memcpy(base, p + off, len)
> > > +	)
> > > +	copied = bytes;
> > > +
> > > +out:
> > > +	kunmap_local(kaddr);
> > > +	return copied;
> > > +}
> > > +EXPORT_SYMBOL(copy_page_to_iter_atomic);
> > > +
> > >  static void pipe_advance(struct iov_iter *i, size_t size)
> > >  {
> > >  	struct pipe_inode_info *pipe = i->pipe;
> > > --
> > > 2.39.2
> > >
> >
> 

