Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722CF70E5E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 21:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbjEWToH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 15:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238304AbjEWToH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 15:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40AC126
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684870998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nVYTJz+ohmzpkMyzlI3AmODU2ocVBa7FPjYPfOIXS4Y=;
        b=Ca2SMUQwAZjnmIlpLFf24pLEiidJ+SPdwmNRN2q+BBE9dFUReFyakLunYD80AX5EmpDMhK
        dexjt6Kd8kOS9NyXslrUFOOxXrmLb/jNDFbPV75kKppd/llVbn9h0Cm4ilrT91xxD8MZb0
        s6Ny/HEhCNLLUGoJiDBi83CsX/ITX3g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-dxur-7QUO-uBPusYDddxeg-1; Tue, 23 May 2023 15:43:16 -0400
X-MC-Unique: dxur-7QUO-uBPusYDddxeg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f386bb966cso83491cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 12:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870996; x=1687462996;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVYTJz+ohmzpkMyzlI3AmODU2ocVBa7FPjYPfOIXS4Y=;
        b=idmyn463KnDLTw+whHK+1T7EUc5qhGEkySIf+xytXCJ/Phnd6mskCCBUljBmwQXcTw
         EonZDThYxgLsMWwgPdrJq1ianOhFmIBFwFTcCOfJVpU5YbGrlJBTGTMmyaQy+H3s4oSH
         DwYyJ/6Ybi7SW8HT3hYkFcuwiTIBEQQuxB98b1ZqLbSrgcD3SC9JQZ/+QEEqTxcJB19/
         z9ucI7iB5G77Mbn96DqkLe5Qf+7wlL2did4VLXJ2TThwYlK4x9BrvIKLZHESq7rrae22
         CXQJ1pLFJK7HVW9cYd2mqvtf/rkGlNSmBpM3R2O0PwX2R2Mj/yqpuG9fs15O8G+WEgB/
         ek3A==
X-Gm-Message-State: AC+VfDwl1UDhN30TL2/sYzVZPjOLIZXh0Q+WfQBPtrmdedEcewRDvKDy
        x6e8aib/QNR5frlddMFovRyi7MowXGII5pW1ikfyq6WS6CIOM4iBdT6bfSEG2BrJDLA0ZecAMP0
        u2yEfTlKUJN0b2SuTJBKK1FyV3A==
X-Received: by 2002:a05:622a:1802:b0:3e3:c889:ecf9 with SMTP id t2-20020a05622a180200b003e3c889ecf9mr388740qtc.1.1684870996310;
        Tue, 23 May 2023 12:43:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5WPyPlIU7Z5o5ojcdnyYSYz4FQtg+28gg19z5Uhb8BtRa2nhggXZCu6QGD9c50PH29b6aRwg==
X-Received: by 2002:a05:622a:1802:b0:3e3:c889:ecf9 with SMTP id t2-20020a05622a180200b003e3c889ecf9mr388715qtc.1.1684870995947;
        Tue, 23 May 2023 12:43:15 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id ch13-20020a05622a40cd00b003ef573e24cfsm1919236qtb.12.2023.05.23.12.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 12:43:15 -0700 (PDT)
Date:   Tue, 23 May 2023 15:43:13 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     linux-mm@kvack.org, Paul Gofman <pgofman@codeweavers.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH RESEND v15 2/5] fs/proc/task_mmu: Implement IOCTL to get
 and optionally clear info about PTEs
Message-ID: <ZG0XUZSBI2I3/3bY@x1n>
References: <20230420060156.895881-1-usama.anjum@collabora.com>
 <20230420060156.895881-3-usama.anjum@collabora.com>
 <fd9ddd43-6737-88bd-4054-3d5b94534271@collabora.com>
 <ZEkxh6dbnAOuYuJj@x1n>
 <ff17a13f-ccc2-fc39-7731-6d794c7dd980@collabora.com>
 <0edfaf12-66f2-86d3-df1c-f5dff10fb743@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0edfaf12-66f2-86d3-df1c-f5dff10fb743@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Muhammad,

On Mon, May 22, 2023 at 04:26:07PM +0500, Muhammad Usama Anjum wrote:
> On 5/22/23 3:24 PM, Muhammad Usama Anjum wrote:
> > On 4/26/23 7:13 PM, Peter Xu wrote:
> >> Hi, Muhammad,
> >>
> >> On Wed, Apr 26, 2023 at 12:06:23PM +0500, Muhammad Usama Anjum wrote:
> >>> On 4/20/23 11:01 AM, Muhammad Usama Anjum wrote:
> >>>> +/* Supported flags */
> >>>> +#define PM_SCAN_OP_GET	(1 << 0)
> >>>> +#define PM_SCAN_OP_WP	(1 << 1)
> >>> We have only these flag options available in PAGEMAP_SCAN IOCTL.
> >>> PM_SCAN_OP_GET must always be specified for this IOCTL. PM_SCAN_OP_WP can
> >>> be specified as need. But PM_SCAN_OP_WP cannot be specified without
> >>> PM_SCAN_OP_GET. (This was removed after you had asked me to not duplicate
> >>> functionality which can be achieved by UFFDIO_WRITEPROTECT.)
> >>>
> >>> 1) PM_SCAN_OP_GET | PM_SCAN_OP_WP
> >>> vs
> >>> 2) UFFDIO_WRITEPROTECT
> >>>
> >>> After removing the usage of uffd_wp_range() from PAGEMAP_SCAN IOCTL, we are
> >>> getting really good performance which is comparable just like we are
> >>> depending on SOFT_DIRTY flags in the PTE. But when we want to perform wp,
> >>> PM_SCAN_OP_GET | PM_SCAN_OP_WP is more desirable than UFFDIO_WRITEPROTECT
> >>> performance and behavior wise.
> >>>
> >>> I've got the results from someone else that UFFDIO_WRITEPROTECT block
> >>> pagefaults somehow which PAGEMAP_IOCTL doesn't. I still need to verify this
> >>> as I don't have tests comparing them one-to-one.
> >>>
> >>> What are your thoughts about it? Have you thought about making
> >>> UFFDIO_WRITEPROTECT perform better?
> >>>
> >>> I'm sorry to mention the word "performance" here. Actually we want better
> >>> performance to emulate Windows syscall. That is why we are adding this
> >>> functionality. So either we need to see what can be improved in
> >>> UFFDIO_WRITEPROTECT or can I please add only PM_SCAN_OP_WP back in
> >>> pagemap_ioctl?
> >>
> >> I'm fine if you want to add it back if it works for you.  Though before
> >> that, could you remind me why there can be a difference on performance?
> > I've looked at the code again and I think I've found something. Lets look
> > at exact performance numbers:
> > 
> > I've run 2 different tests. In first test UFFDIO_WRITEPROTECT is being used
> > for engaging WP. In second test PM_SCAN_OP_WP is being used. I've measured
> > the average write time to the same memory which is being WP-ed and total
> > time of execution of these APIs:

What is the steps of the test?  Is it as simple as "writeprotect",
"unprotect", then write all pages in a single thread?

Is UFFDIO_WRITEPROTECT sent in one range covering all pages?

Maybe you can attach the test program here too.

> > 
> > **avg write time:**
> > | No of pages            | 2000 | 8192 | 100000 | 500000 |
> > |------------------------|------|------|--------|--------|
> > | UFFDIO_WRITEPROTECT    | 2200 | 2300 | 4100   | 4200   |
> > | PM_SCAN_OP_WP          | 2000 | 2300 | 2500   | 2800   |
> > 
> > **Execution time measured in rdtsc:**
> > | No of pages            | 2000 | 8192  | 100000 | 500000 |
> > |------------------------|------|-------|--------|--------|
> > | UFFDIO_WRITEPROTECT    | 3200 | 14000 | 59000  | 58000  |
> > | PM_SCAN_OP_WP          | 1900 | 7000  | 38000  | 40000  |
> > 
> > Avg write time for UFFDIO_WRITEPROTECT is 1.3 times slow. The execution
> > time is 1.5 times slower in the case of UFFDIO_WRITEPROTECT. So
> > UFFDIO_WRITEPROTECT is making writes slower to the pages and execution time
> > is also slower.
> > 
> > This proves that PM_SCAN_OP_WP is better than UFFDIO_WRITEPROTECT. Although
> > PM_SCAN_OP_WP and UFFDIO_WRITEPROTECT have been implemented differently. We
> > should have seen no difference in performance. But we have quite a lot of
> > difference in performance here. PM_SCAN_OP_WP takes read mm lock, uses
> > walk_page_range() to walk over pages which finds VMAs from address ranges
> > to walk over them and pagemap_scan_pmd_entry() is handling most of the work
> > including tlb flushing. UFFDIO_WRITEPROTECT is also taking the mm lock and
> > iterating from all the different page directories until a pte is found and
> > then flags are updated there and tlb is flushed for every pte.
> > 
> > My next deduction would be that we are getting worse performance as we are
> > flushing tlb for one page at a time in case of UFFDIO_WRITEPROTECT. While
> > we flush tlb for 512 pages (moslty) at a time in case of PM_SCAN_OP_WP.
> > I've just verified this by adding some logs to the change_pte_range() and
> > pagemap_scan_pmd_entry(). Logs are attached. I've allocated memory of 1000
> > pages and write-protected it with UFFDIO_WRITEPROTECT and PM_SCAN_OP_WP.
> > The logs show that UFFDIO_WRITEPROTECT has flushed tlb 1000 times of size 1
> > page each time. While PM_SCAN_OP_WP has flushed only 3 times of bigger
> > sizes. I've learned over my last experience that tlb flush is very
> > expensive. Probably this is what we need to improve if we don't want to add
> > PM_SCAN_OP_WP?
> > 
> > The UFFDIO_WRITEPROTECT uses change_pte_range() which is very generic
> > function and I'm not sure if can try to not do tlb flushes if uffd_wp is
> > true. We can try to do flush somewhere else and hopefully we should do only
> > one flush if possible. It will not be so straight forward to move away from
> > generic fundtion. Thoughts?
> I've just tested this theory of not doing per pte flushes and only did one
> flush on entire range in uffd_wp_range(). But it didn't improve the
> situation either. I was wrong that tlb flushes may be the cause.

I had a feeling that you were trapping tlb_flush_pte_range(), which is
actually not really sending any TLB flushes but updating mmu_gather object
for the addr range for future invalidations.

That's probably why it didn't show an effect when you comment it out.

I am not sure whether the wr-protect path difference can be caused by the
arch hooks, namely arch_enter_lazy_mmu_mode() / arch_leave_lazy_mmu_mode().

On x86 I saw that it's actually hooked onto some PV calls.  I had a feeling
that this is for optimization only, but maybe it's still a good idea you
also take that into your new code:

static inline void arch_enter_lazy_mmu_mode(void)
{
	PVOP_VCALL0(mmu.lazy_mode.enter);
}

The other thing is I think you're flushing tlb outside pgtable lock in your
new code.  IIUC that's racy, see:

commit 6ce64428d62026a10cb5d80138ff2f90cc21d367
Author: Nadav Amit <namit@vmware.com>
Date:   Fri Mar 12 21:08:17 2021 -0800

    mm/userfaultfd: fix memory corruption due to writeprotect

So you may want to put it at least into pgtable lock critical section, or
IIUC you can also do inc_tlb_flush_pending() then dec_tlb_flush_pending()
just like __tlb_gather_mmu(), to make sure do_wp_page() will properly flush
the page when unluckily hit some of the page.

That's also the spot (the flush_tlb_page() in 6ce64428d) that made me think
on whether it caused the slowness on writting to those pages.  But it
really depends on your test program, e.g. if it's a single threaded I don't
think it'll trigger because when writting mm_tlb_flush_pending() should
start to return 0 already, so the tlb should logically not be needed.  If
you want maybe you can double check that.

So in short, I had a feeling that the new PM_SCAN_OP_WP just misses
something here and there so it's faster - it means even if it's faster it
may also be prone to race conditions etc so we'd better figure it out..

Thanks,

-- 
Peter Xu

