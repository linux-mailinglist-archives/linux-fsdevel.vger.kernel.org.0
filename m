Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3E2B0815
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 06:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfILEkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 00:40:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:56478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbfILEkN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 00:40:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84889AB6D;
        Thu, 12 Sep 2019 04:40:11 +0000 (UTC)
Date:   Wed, 11 Sep 2019 21:40:02 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 5/5] hugetlbfs: Limit wait time when trying to share huge
 PMD
Message-ID: <20190912044002.xp3c7jbpbmq4dbz6@linux-p48b>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20190911150537.19527-1-longman@redhat.com>
 <20190911150537.19527-6-longman@redhat.com>
 <ae7edcb8-74e5-037c-17e7-01b3cf9320af@oracle.com>
 <20190912034143.GJ29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190912034143.GJ29434@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 11 Sep 2019, Matthew Wilcox wrote:

>On Wed, Sep 11, 2019 at 08:26:52PM -0700, Mike Kravetz wrote:
>> All this got me wondering if we really need to take i_mmap_rwsem in write
>> mode here.  We are not changing the tree, only traversing it looking for
>> a suitable vma.
>>
>> Unless I am missing something, the hugetlb code only ever takes the semaphore
>> in write mode; never read.  Could this have been the result of changing the
>> tree semaphore to read/write?  Instead of analyzing all the code, the easiest
>> and safest thing would have been to take all accesses in write mode.
>
>I was wondering the same thing.  It was changed here:
>
>commit 83cde9e8ba95d180eaefefe834958fbf7008cf39
>Author: Davidlohr Bueso <dave@stgolabs.net>
>Date:   Fri Dec 12 16:54:21 2014 -0800
>
>    mm: use new helper functions around the i_mmap_mutex
>
>    Convert all open coded mutex_lock/unlock calls to the
>    i_mmap_[lock/unlock]_write() helpers.
>
>and a subsequent patch said:
>
>    This conversion is straightforward.  For now, all users take the write
>    lock.
>
>There were subsequent patches which changed a few places
>c8475d144abb1e62958cc5ec281d2a9e161c1946
>1acf2e040721564d579297646862b8ea3dd4511b
>d28eb9c861f41aa2af4cfcc5eeeddff42b13d31e
>874bfcaf79e39135cd31e1cfc9265cf5222d1ec3
>3dec0ba0be6a532cac949e02b853021bf6d57dad
>
>but I don't know why this one wasn't changed.

I cannot recall why huge_pmd_share() was not changed along with the other
callers that don't modify the interval tree. By looking at the function,
I agree that this could be shared, in fact this lock is much less involved
than it's anon_vma counterpart, last I checked (perhaps with the exception
of take_rmap_locks().

>
>(I was also wondering about caching a potentially sharable page table
>in the address_space to avoid having to walk the VMA tree at all if that
>one happened to be sharable).

I also think that the right solution is within the mm instead of adding
a new api to rwsem and the extra complexity/overhead to osq _just_ for this
case. We've managed to not need timeout extensions in our locking primitives
thus far, which is a good thing imo.

Thanks,
Davidlohr
