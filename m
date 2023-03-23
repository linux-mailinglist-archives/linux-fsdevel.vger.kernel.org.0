Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B2A6C654F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 11:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCWKj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 06:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCWKj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8A128875
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 03:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679567786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VhVooo4nst+piw+966WEP8+flU0JtuouwHqwDjEizd0=;
        b=N7/Od94co1OIEseIcGUZYApe1JD/Q6HrQhHon4i68Jjq20hA0sKcwnrpZJX26CF/2yNBUQ
        7Y6yjovKq0LZJogCZ8sCUZocq3YcUf6dVPhdEoSZY//9B3fx8btWqf+io6448FTHK8rd2o
        SSq3920EQrQAugL2U/J1s1xVvo0+s5M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-C8q_ApxOMh-rVZdsr9HRdg-1; Thu, 23 Mar 2023 06:36:23 -0400
X-MC-Unique: C8q_ApxOMh-rVZdsr9HRdg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3B473C0F673;
        Thu, 23 Mar 2023 10:36:22 +0000 (UTC)
Received: from localhost (ovpn-12-97.pek2.redhat.com [10.72.12.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D41F1121314;
        Thu, 23 Mar 2023 10:36:21 +0000 (UTC)
Date:   Thu, 23 Mar 2023 18:36:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v7 4/4] mm: vmalloc: convert vread() to vread_iter()
Message-ID: <ZBwroYh22pEqJYhv@MiWiFi-R3L-srv>
References: <cover.1679511146.git.lstoakes@gmail.com>
 <941f88bc5ab928e6656e1e2593b91bf0f8c81e1b.1679511146.git.lstoakes@gmail.com>
 <ZBu+2cPCQvvFF/FY@MiWiFi-R3L-srv>
 <ff630c2e-42ff-42ec-9abb-38922d5107ec@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff630c2e-42ff-42ec-9abb-38922d5107ec@lucifer.local>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/23/23 at 06:44am, Lorenzo Stoakes wrote:
> On Thu, Mar 23, 2023 at 10:52:09AM +0800, Baoquan He wrote:
> > On 03/22/23 at 06:57pm, Lorenzo Stoakes wrote:
> > > Having previously laid the foundation for converting vread() to an iterator
> > > function, pull the trigger and do so.
> > >
> > > This patch attempts to provide minimal refactoring and to reflect the
> > > existing logic as best we can, for example we continue to zero portions of
> > > memory not read, as before.
> > >
> > > Overall, there should be no functional difference other than a performance
> > > improvement in /proc/kcore access to vmalloc regions.
> > >
> > > Now we have eliminated the need for a bounce buffer in read_kcore_iter(),
> > > we dispense with it, and try to write to user memory optimistically but
> > > with faults disabled via copy_page_to_iter_nofault(). We already have
> > > preemption disabled by holding a spin lock. We continue faulting in until
> > > the operation is complete.
> >
> > I don't understand the sentences here. In vread_iter(), the actual
> > content reading is done in aligned_vread_iter(), otherwise we zero
> > filling the region. In aligned_vread_iter(), we will use
> > vmalloc_to_page() to get the mapped page and read out, otherwise zero
> > fill. While in this patch, fault_in_iov_iter_writeable() fault in memory
> > of iter one time and will bail out if failed. I am wondering why we
> > continue faulting in until the operation is complete, and how that is done.
> 
> This is refererrring to what's happening in kcore.c, not vread_iter(),
> i.e. the looped read/faultin.
> 
> The reason we bail out if failt_in_iov_iter_writeable() is that would
> indicate an error had occurred.
> 
> The whole point is to _optimistically_ try to perform the operation
> assuming the pages are faulted in. Ultimately we fault in via
> copy_to_user_nofault() which will either copy data or fail if the pages are
> not faulted in (will discuss this below a bit more in response to your
> other point).
> 
> If this fails, then we fault in, and try again. We loop because there could
> be some extremely unfortunate timing with a race on e.g. swapping out or
> migrating pages between faulting in and trying to write out again.
> 
> This is extremely unlikely, but to avoid any chance of breaking userland we
> repeat the operation until it completes. In nearly all real-world
> situations it'll either work immediately or loop once.

Thanks a lot for these helpful details with patience. I got it now. I was
mainly confused by the while(true) loop in KCORE_VMALLOC case of read_kcore_iter.

Now is there any chance that the faulted in memory is swapped out or
migrated again before vread_iter()? fault_in_iov_iter_writeable() will
pin the memory? I didn't find it from code and document. Seems it only
falults in memory. If yes, there's window between faluting in and
copy_to_user_nofault().

> 
> >
> > If we look into the failing point in vread_iter(), it's mainly coming
> > from copy_page_to_iter_nofault(), e.g page_copy_sane() checking failed,
> > i->data_source checking failed. If these conditional checking failed,
> > should we continue reading again and again? And this is not related to
> > memory faulting in. I saw your discussion with David, but I am still a
> > little lost. Hope I can learn it, thanks in advance.
> >
> 
> Actually neither of these are going to happen. page_copy_sane() checks the
> sanity of the _source_ pages, and the 'sanity' is defined by whether your
> offset and length sit within the (possibly compound) folio. Since we
> control this, we can arrange for it never to happen.
> 
> i->data_source is checking that it's an output iterator, however we would
> already have checked this when writing ELF headers at the bare minimum, so
> we cannot reach this point with an invalid iterator.
> 
> Therefore it is not possible either cause a failure. What could cause a
> failure, and what we are checking for, is specified in copyout_nofault()
> (in iov_iter.c) which we pass to the iterate_and_advance() macro. Now we
> have a fault-injection should_fail_usercopy() which would just trigger a
> redo, or copy_to_user_nofault() returning < 0 (e.g. -EFAULT).
> 
> This code is confusing as this function returns the number of bytes _not
> copied_ rather than copied. I have tested this to be sure by the way :)
> 
> Therefore the only way for a failure to occur is for memory to not be
> faulted in and thus the loop only triggers in this situation. If we fail to
> fault in pages for any reason, the whole operation aborts so this should
> cover all angles.
> 
> > ......
> > > diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> > > index 08b795fd80b4..25b44b303b35 100644
> > > --- a/fs/proc/kcore.c
> > > +++ b/fs/proc/kcore.c
> > ......
> > > @@ -507,13 +503,30 @@ read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
> > >
> > >  		switch (m->type) {
> > >  		case KCORE_VMALLOC:
> > > -			vread(buf, (char *)start, tsz);
> > > -			/* we have to zero-fill user buffer even if no read */
> > > -			if (copy_to_iter(buf, tsz, iter) != tsz) {
> > > -				ret = -EFAULT;
> > > -				goto out;
> > > +		{
> > > +			const char *src = (char *)start;
> > > +			size_t read = 0, left = tsz;
> > > +
> > > +			/*
> > > +			 * vmalloc uses spinlocks, so we optimistically try to
> > > +			 * read memory. If this fails, fault pages in and try
> > > +			 * again until we are done.
> > > +			 */
> > > +			while (true) {
> > > +				read += vread_iter(iter, src, left);
> > > +				if (read == tsz)
> > > +					break;
> > > +
> > > +				src += read;
> > > +				left -= read;
> > > +
> > > +				if (fault_in_iov_iter_writeable(iter, left)) {
> > > +					ret = -EFAULT;
> > > +					goto out;
> > > +				}
> > >  			}
> > >  			break;
> > > +		}
> > >  		case KCORE_USER:
> > >  			/* User page is handled prior to normal kernel page: */
> > >  			if (copy_to_iter((char *)start, tsz, iter) != tsz) {
> >
> 

