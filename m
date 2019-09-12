Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1289BB0738
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 05:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfILDlt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 23:41:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfILDlt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 23:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7EwQtG2hwlINClUDNZab/A4gQX9VeexXatbSrvMQs9I=; b=Fnr+FH0Iq5wsSebY0xIvcvz3a
        ARsc+bxbp6X4Wqlhor8mTnGmujrqXxtXRHIZ14oZo77yUethMpwVRQi9ulUznP7ifhisPFAWNfhU6
        hzezfQxpYC1iIJHL3c0LAHn644O20BB0hxpJOQ0acyTjBM0ix6/zhnCHRGKH12WLpeIQQMnFaYSar
        ZaDp293HOeh3fUq01D9vYyp1fr1pcDMt5A02u4FPasLEsD7Mf30jcvwR+M3cyarD08JgU7LqVqR4K
        q+vvN827RZdUkJ8BrqdcgENp3zgvAY8FpMpyAkf0nj51CsJn7gCJVX6WOjIerx1fRtAGvXbKE321s
        7CufzKEVQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8FzL-0002e3-4X; Thu, 12 Sep 2019 03:41:43 +0000
Date:   Wed, 11 Sep 2019 20:41:43 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 5/5] hugetlbfs: Limit wait time when trying to share huge
 PMD
Message-ID: <20190912034143.GJ29434@bombadil.infradead.org>
References: <20190911150537.19527-1-longman@redhat.com>
 <20190911150537.19527-6-longman@redhat.com>
 <ae7edcb8-74e5-037c-17e7-01b3cf9320af@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7edcb8-74e5-037c-17e7-01b3cf9320af@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 11, 2019 at 08:26:52PM -0700, Mike Kravetz wrote:
> All this got me wondering if we really need to take i_mmap_rwsem in write
> mode here.  We are not changing the tree, only traversing it looking for
> a suitable vma.
> 
> Unless I am missing something, the hugetlb code only ever takes the semaphore
> in write mode; never read.  Could this have been the result of changing the
> tree semaphore to read/write?  Instead of analyzing all the code, the easiest
> and safest thing would have been to take all accesses in write mode.

I was wondering the same thing.  It was changed here:

commit 83cde9e8ba95d180eaefefe834958fbf7008cf39
Author: Davidlohr Bueso <dave@stgolabs.net>
Date:   Fri Dec 12 16:54:21 2014 -0800

    mm: use new helper functions around the i_mmap_mutex
    
    Convert all open coded mutex_lock/unlock calls to the
    i_mmap_[lock/unlock]_write() helpers.

and a subsequent patch said:

    This conversion is straightforward.  For now, all users take the write
    lock.

There were subsequent patches which changed a few places
c8475d144abb1e62958cc5ec281d2a9e161c1946
1acf2e040721564d579297646862b8ea3dd4511b
d28eb9c861f41aa2af4cfcc5eeeddff42b13d31e
874bfcaf79e39135cd31e1cfc9265cf5222d1ec3
3dec0ba0be6a532cac949e02b853021bf6d57dad

but I don't know why this one wasn't changed.

(I was also wondering about caching a potentially sharable page table
in the address_space to avoid having to walk the VMA tree at all if that
one happened to be sharable).
