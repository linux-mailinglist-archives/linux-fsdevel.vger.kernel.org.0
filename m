Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C776B42D303
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 08:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhJNG4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 02:56:44 -0400
Received: from out2.migadu.com ([188.165.223.204]:52962 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhJNG4o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:56:44 -0400
Date:   Thu, 14 Oct 2021 15:54:32 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634194478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N/aD5fWtoSotnmi+BFKZ86QWaol2dougMlY39ccGabg=;
        b=HRDs9CMbOaq5Jz299llyEDwwLkvDBBltsjUdXbjpqAfB13u56yrVQq2rx15S0W8fZ2bsFM
        BFuf8ueb0kdZNa1VIVOWCYefpxNDVyAGUbhMmPXwK+XzeTt5DqhCXFbbTHurRt4Z8Zu33v
        T8Z4oeCCl4NOzOUEzsrS8lvN2bYtztU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Peter Xu <peterx@redhat.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <20211014065432.GB2017714@u2004>
References: <20210930215311.240774-3-shy828301@gmail.com>
 <YV4Dz3y4NXhtqd6V@t490s>
 <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
 <CAHbLzkqm_Os8TLXgbkL-oxQVsQqRbtmjdMdx0KxNke8mUF1mWA@mail.gmail.com>
 <YWTc/n4r6CJdvPpt@t490s>
 <YWTobPkBc3TDtMGd@t490s>
 <CAHbLzkrOsNygu5x8vbMHedv+P3dEqOxOC6=O6ACSm1qKzmoCng@mail.gmail.com>
 <YWYHukJIo8Ol2sHN@t490s>
 <CAHbLzkp3UXKs_NP9XD_ws=CSSFzUPk7jRxj0K=gvOqoi+GotmA@mail.gmail.com>
 <YWZMDTwCCZWX5/sQ@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWZMDTwCCZWX5/sQ@t490s>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:01:33AM +0800, Peter Xu wrote:
> On Tue, Oct 12, 2021 at 07:48:39PM -0700, Yang Shi wrote:
> > On Tue, Oct 12, 2021 at 3:10 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Tue, Oct 12, 2021 at 11:02:09AM -0700, Yang Shi wrote:
> > > > On Mon, Oct 11, 2021 at 6:44 PM Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > On Mon, Oct 11, 2021 at 08:55:26PM -0400, Peter Xu wrote:
> > > > > > Another thing is I noticed soft_offline_in_use_page() will still ignore file
> > > > > > backed split.  I'm not sure whether it means we'd better also handle that case
> > > > > > as well, so shmem thp can be split there too?
> > > > >
> > > > > Please ignore this paragraph - I somehow read "!PageHuge(page)" as
> > > > > "PageAnon(page)"...  So I think patch 5 handles soft offline too.
> > > >
> > > > Yes, exactly. And even though the split is failed (or file THP didn't
> > > > get split before patch 5/5), soft offline would just return -EBUSY
> > > > instead of calling __soft_offline_page->page_handle_poison(). So
> > > > page_handle_poison() should not see THP at all.
> > >
> > > I see, so I'm trying to summarize myself on what I see now with the new logic..
> > >
> > > I think the offline code handles hwpoison differently as it sets PageHWPoison
> > > at the end of the process, IOW if anything failed during the offline process
> > > the hwpoison bit is not set.
> > >
> > > That's different from how the memory failure path is handling this, as in that
> > > case the hwpoison bit on the subpage is set firstly, e.g. before split thp.  I
> > > believe that's also why memory failure requires the extra sub-page-hwpoison bit
> > > while offline code shouldn't need to: because for soft offline split happens
> > > before setting hwpoison so we just won't ever see a "poisoned file thp", while
> > > for memory failure it could happen, and the sub-page-hwpoison will be a temp
> > > bit anyway only exist for a very short period right after we set hwpoison on
> > > the small page but before we split the thp.
> > >
> > > Am I right above?
> > 
> > Yeah, you are right. I noticed this too, only successfully migrated
> > page is marked as hwpoison. But TBH I'm not sure why it does this way.
> 
> My wild guess is that unlike memory failures, soft offline is best-effort. Say,
> the data on the page is still consistent, so even if offline failed for some
> reason we shouldn't stop the program from execution.  That's not true for
> memory failures via MCEs, afaict, as the execution could read/write wrong data
> and that'll be a serious mistake, so we set hwpoison 1st there first before
> doing anything else, making sure "this page is broken" message delivered and
> user app won't run with risk.
> 
> But yeah it'll be great if Naoya could help confirm that.

Yes, these descriptions are totally correct, how PG_hwpoison flag is set
is different between hwpoison/soft-offline mechanisms from the beginning.

Thanks,
Naoya Horiguchi
