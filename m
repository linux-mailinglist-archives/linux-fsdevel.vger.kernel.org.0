Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27176432D79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 07:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhJSF4I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 01:56:08 -0400
Received: from out0.migadu.com ([94.23.1.103]:61843 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhJSF4H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:56:07 -0400
Date:   Tue, 19 Oct 2021 14:53:47 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634622834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4dWiSpMB3su/IESmjRL9fRWxwQYhjK9579FgEZKcS4I=;
        b=A0/6loa1p9FRmwRzqhbsm8QrH6BBJf9nkZgU0CxtGvqAJ6LiwXLLnNYnw0Lu6cOiP0bedJ
        fr5TblLT+aB33aqHu3gpS/vn32FiGNoctPXoZm9XYpursNMQwFfGESUzbrrqQA7BcXe2pV
        72TlY8xAryiUGrRvLeL37EFWvSFCT0I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v4 PATCH 0/6] Solve silent data loss caused by poisoned
 page cache (shmem/tmpfs)
Message-ID: <20211019055347.GD2268449@u2004>
References: <20211014191615.6674-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014191615.6674-1-shy828301@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 14, 2021 at 12:16:09PM -0700, Yang Shi wrote:
> 
> When discussing the patch that splits page cache THP in order to offline the
> poisoned page, Noaya mentioned there is a bigger problem [1] that prevents this
> from working since the page cache page will be truncated if uncorrectable
> errors happen.  By looking this deeper it turns out this approach (truncating
> poisoned page) may incur silent data loss for all non-readonly filesystems if
> the page is dirty.  It may be worse for in-memory filesystem, e.g. shmem/tmpfs
> since the data blocks are actually gone.
> 
> To solve this problem we could keep the poisoned dirty page in page cache then
> notify the users on any later access, e.g. page fault, read/write, etc.  The
> clean page could be truncated as is since they can be reread from disk later on.
> 
> The consequence is the filesystems may find poisoned page and manipulate it as
> healthy page since all the filesystems actually don't check if the page is
> poisoned or not in all the relevant paths except page fault.  In general, we
> need make the filesystems be aware of poisoned page before we could keep the
> poisoned page in page cache in order to solve the data loss problem.
> 
> To make filesystems be aware of poisoned page we should consider:
> - The page should be not written back: clearing dirty flag could prevent from
>   writeback.
> - The page should not be dropped (it shows as a clean page) by drop caches or
>   other callers: the refcount pin from hwpoison could prevent from invalidating
>   (called by cache drop, inode cache shrinking, etc), but it doesn't avoid
>   invalidation in DIO path.
> - The page should be able to get truncated/hole punched/unlinked: it works as it
>   is.
> - Notify users when the page is accessed, e.g. read/write, page fault and other
>   paths (compression, encryption, etc).
> 
> The scope of the last one is huge since almost all filesystems need do it once
> a page is returned from page cache lookup.  There are a couple of options to
> do it:
> 
> 1. Check hwpoison flag for every path, the most straightforward way.
> 2. Return NULL for poisoned page from page cache lookup, the most callsites
>    check if NULL is returned, this should have least work I think.  But the
>    error handling in filesystems just return -ENOMEM, the error code will incur
>    confusion to the users obviously.
> 3. To improve #2, we could return error pointer, e.g. ERR_PTR(-EIO), but this
>    will involve significant amount of code change as well since all the paths
>    need check if the pointer is ERR or not just like option #1.
> 
> I did prototype for both #1 and #3, but it seems #3 may require more changes
> than #1.  For #3 ERR_PTR will be returned so all the callers need to check the
> return value otherwise invalid pointer may be dereferenced, but not all callers
> really care about the content of the page, for example, partial truncate which
> just sets the truncated range in one page to 0.  So for such paths it needs
> additional modification if ERR_PTR is returned.  And if the callers have their
> own way to handle the problematic pages we need to add a new FGP flag to tell
> FGP functions to return the pointer to the page.
> 
> It may happen very rarely, but once it happens the consequence (data corruption)
> could be very bad and it is very hard to debug.  It seems this problem had been
> slightly discussed before, but seems no action was taken at that time. [2]
> 
> As the aforementioned investigation, it needs huge amount of work to solve
> the potential data loss for all filesystems.  But it is much easier for
> in-memory filesystems and such filesystems actually suffer more than others
> since even the data blocks are gone due to truncating.  So this patchset starts
> from shmem/tmpfs by taking option #1.

Thank you for the work. I have a few comment on todo...

> 
> TODO:
> * The unpoison has been broken since commit 0ed950d1f281 ("mm,hwpoison: make
>   get_hwpoison_page() call get_any_page()"), and this patch series make
>   refcount check for unpoisoning shmem page fail.

It's OK to leave unpoison unsolved now. I'm working on this now (revising
v1 patch [1]), but I'm facing some race issue cauisng kernel panic with kernel
mode page fault, so I need to solve it.

[1] https://lore.kernel.org/linux-mm/20210614021212.223326-1-nao.horiguchi@gmail.com/

> * Expand to other filesystems.  But I haven't heard feedback from filesystem
>   developers yet.

I think that hugetlbfs can be a good next target because it's similar to
shmem in that it's in-memory filesystem.

Thanks,
Naoya Horiguchi
