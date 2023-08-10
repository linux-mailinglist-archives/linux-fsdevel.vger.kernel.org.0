Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125C7778386
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 00:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjHJWQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 18:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHJWQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:16:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D9A2717;
        Thu, 10 Aug 2023 15:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kZPovxlvK/roVyxwyrIHXjZdgR6OfruTG8lx5laTMjE=; b=Wu9JD/vLovqSrk7O9Ir9t5qFsz
        B7QVo0bG4GprbraPb6elzFPJ3NE/0hGrj9rgwFwVX0NDoTwdn5+NFUTNBSqdhXrTeSAegMaRIfYS3
        sBlOmjAdS7vP+kUu7bSDI8NMwxfhWi0JJ6PeN1v0CCn1P9iRRp1bNjkboCR6gCltj0pWY2RPXoqir
        tzEbcfCPZm/LCQ50fGWMeFvYFV7mNpl1EQZOQC1XHuGqWbUk4gkZ7IYoX3rgb94KtusmIUVxgv1kp
        30OyN/78yXUBl3imywAb+maKp42gUxHzQxhb0MVHJ0rrbZWzqjQOSRMDTeHddGq8L6aUWWwHyjyhy
        RMI8I8aQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUDwr-00F0qE-VO; Thu, 10 Aug 2023 22:16:06 +0000
Date:   Thu, 10 Aug 2023 23:16:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, peterx@redhat.com, ying.huang@intel.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
Message-ID: <ZNVhpeejqGkEqqSr@casper.infradead.org>
References: <20230630211957.1341547-1-surenb@google.com>
 <a34a418a-9a6c-9d9a-b7a3-bde8013bf86c@redhat.com>
 <CAJuCfpGCWekMdno=L=4m7ujWTYMr0Wv77oYzXWT5RXnx+fWe0w@mail.gmail.com>
 <CAJuCfpGMvYxu-g9kVH40UDGnpF2kxctH7AazhvmwhWWq1Rn1sA@mail.gmail.com>
 <CAJuCfpHA78vxOBcaB3m7S7=CoBLMXTzRWego+jZM7JvUm3rEaQ@mail.gmail.com>
 <0ab6524a-6917-efe2-de69-f07fb5cdd9d2@redhat.com>
 <CAJuCfpEs2k8mHM+9uq05vmcOYCfkNnOb4s3xPSoWheizPkcwLA@mail.gmail.com>
 <CAJuCfpERuCx6QvfejUkS-ysMxbzp3mFfhCbH=rDtt2UGzbwtyg@mail.gmail.com>
 <CAJuCfpH-drRnwqUqynTnvgqSjs=_Fwc0H_7h6nzsdztRef0oKw@mail.gmail.com>
 <CAJuCfpH8ucOkCFYrVZafUAppi5+mVhy=uD+BK6-oYX=ysQv5qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH8ucOkCFYrVZafUAppi5+mVhy=uD+BK6-oYX=ysQv5qQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 06:24:15AM +0000, Suren Baghdasaryan wrote:
> Ok, I think I found the issue.  wp_page_shared() ->
> fault_dirty_shared_page() can drop mmap_lock (see the comment saying
> "Drop the mmap_lock before waiting on IO, if we can...", therefore we
> have to ensure we are not doing this under per-VMA lock.

... or we could change maybe_unlock_mmap_for_io() the same way
that we changed folio_lock_or_retry():

+++ b/mm/internal.h
@@ -706,7 +706,7 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
        if (fault_flag_allow_retry_first(flags) &&
            !(flags & FAULT_FLAG_RETRY_NOWAIT)) {
                fpin = get_file(vmf->vma->vm_file);
-               mmap_read_unlock(vmf->vma->vm_mm);
+               release_fault_lock(vmf);
        }
        return fpin;
 }

What do you think?

> I think what happens is that this path is racing with another page
> fault which took mmap_lock for read. fault_dirty_shared_page()
> releases this lock which was taken by another page faulting thread and
> that thread generates an assertion when it finds out the lock it just
> took got released from under it.

I'm confused that our debugging didn't catch this earlier.  lockdep
should always catch this.
