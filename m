Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFCC70F81C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 15:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbjEXN4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 09:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbjEXN4u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 09:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CE59E
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684936564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zqvJBcdP4jWNQEKJ2URv+kldtu3J4d9i0mGEu6ibPxU=;
        b=JMbT6qonp/G+zvFzenSapH5UyWMPOPSSebXTSleDyWEuBAZzAb+bkOzMhmWZ/WRhczr5xg
        Pp9nVj4/8C96NNG2brEvO+dBH1HO00rbMYfsghfZLT4KaTUwYpL3wpZsiCNkzO1kSqXymI
        jjnf8/EZb41YOME4/d/ES2G6iZobF2o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-fJh_siYaNSqbrlqSq6H0KQ-1; Wed, 24 May 2023 09:56:03 -0400
X-MC-Unique: fJh_siYaNSqbrlqSq6H0KQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-624a29df9feso1909426d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 06:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684936563; x=1687528563;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqvJBcdP4jWNQEKJ2URv+kldtu3J4d9i0mGEu6ibPxU=;
        b=kGQVRvkntowsxMpQ3rvI7uG5SWPH4iR/ZwOdwpFEXFAMeXnxzNdSVU60rwKF9iBFsB
         UDcx3D/7ZR7vRGwpK4/crdu6tro9Esa0U9GO1owQxq0RPmQDkYMPdfbIwh4NYEyyaIzr
         R0pEieRTayGRYYjhH84y70F/OAD2rpLGQXXYPz0oImH2PMfUZu8jN+TWzIWzp0xGRK3y
         1TemwrU5pjWvg5qQp7sA+qsk7qzBK/9jiyX5oPioiiJ/HHnXKlr4zX+ZF2DPrNKGnwxB
         dshk5I3BC0JhR2w1hXH7j1snCf1kxnBvtcxRXgUzGZE3JGAa02rdJ5jtnf00ni5OQyLo
         vqqw==
X-Gm-Message-State: AC+VfDwqJ79OBA4BKqCsMjLXkrFyFrYblyuuCOJf02En78hDfhC8lt9O
        UDOXjVExqyLaRrxWRsiUue0iLDTh3CyORsUePy6HrZlcxJbmf6jYhs5W7Y0cAlq1Vi9FUxZ/O79
        ixsT2ZDtDmDVEq0fXBNJ2Nl8i4w==
X-Received: by 2002:a05:6214:3016:b0:624:dcc5:819f with SMTP id ke22-20020a056214301600b00624dcc5819fmr18149956qvb.1.1684936563052;
        Wed, 24 May 2023 06:56:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4pBPX7+qaDYGxlQoeY6OyplIaXhpMsb5ATbOBD7baiqgZdqLz61HHPSv2R+xgeCMZ81/JTEw==
X-Received: by 2002:a05:6214:3016:b0:624:dcc5:819f with SMTP id ke22-20020a056214301600b00624dcc5819fmr18149935qvb.1.1684936562709;
        Wed, 24 May 2023 06:56:02 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id v16-20020a0ccd90000000b00604ee171d99sm3516206qvm.106.2023.05.24.06.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 06:56:01 -0700 (PDT)
Date:   Wed, 24 May 2023 09:55:59 -0400
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
Message-ID: <ZG4Xb3rYK0p8BoB9@x1n>
References: <20230420060156.895881-1-usama.anjum@collabora.com>
 <20230420060156.895881-3-usama.anjum@collabora.com>
 <fd9ddd43-6737-88bd-4054-3d5b94534271@collabora.com>
 <ZEkxh6dbnAOuYuJj@x1n>
 <ff17a13f-ccc2-fc39-7731-6d794c7dd980@collabora.com>
 <0edfaf12-66f2-86d3-df1c-f5dff10fb743@collabora.com>
 <ZG0XUZSBI2I3/3bY@x1n>
 <a2615158-a0a6-9c2f-b04a-964dfa932aec@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2615158-a0a6-9c2f-b04a-964dfa932aec@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 04:26:33PM +0500, Muhammad Usama Anjum wrote:
> On 5/24/23 12:43 AM, Peter Xu wrote:
> > Hi, Muhammad,
> > 
> > On Mon, May 22, 2023 at 04:26:07PM +0500, Muhammad Usama Anjum wrote:
> >> On 5/22/23 3:24 PM, Muhammad Usama Anjum wrote:
> >>> On 4/26/23 7:13 PM, Peter Xu wrote:
> >>>> Hi, Muhammad,
> >>>>
> >>>> On Wed, Apr 26, 2023 at 12:06:23PM +0500, Muhammad Usama Anjum wrote:
> >>>>> On 4/20/23 11:01 AM, Muhammad Usama Anjum wrote:
> >>>>>> +/* Supported flags */
> >>>>>> +#define PM_SCAN_OP_GET	(1 << 0)
> >>>>>> +#define PM_SCAN_OP_WP	(1 << 1)
> >>>>> We have only these flag options available in PAGEMAP_SCAN IOCTL.
> >>>>> PM_SCAN_OP_GET must always be specified for this IOCTL. PM_SCAN_OP_WP can
> >>>>> be specified as need. But PM_SCAN_OP_WP cannot be specified without
> >>>>> PM_SCAN_OP_GET. (This was removed after you had asked me to not duplicate
> >>>>> functionality which can be achieved by UFFDIO_WRITEPROTECT.)
> >>>>>
> >>>>> 1) PM_SCAN_OP_GET | PM_SCAN_OP_WP
> >>>>> vs
> >>>>> 2) UFFDIO_WRITEPROTECT
> >>>>>
> >>>>> After removing the usage of uffd_wp_range() from PAGEMAP_SCAN IOCTL, we are
> >>>>> getting really good performance which is comparable just like we are
> >>>>> depending on SOFT_DIRTY flags in the PTE. But when we want to perform wp,
> >>>>> PM_SCAN_OP_GET | PM_SCAN_OP_WP is more desirable than UFFDIO_WRITEPROTECT
> >>>>> performance and behavior wise.
> >>>>>
> >>>>> I've got the results from someone else that UFFDIO_WRITEPROTECT block
> >>>>> pagefaults somehow which PAGEMAP_IOCTL doesn't. I still need to verify this
> >>>>> as I don't have tests comparing them one-to-one.
> >>>>>
> >>>>> What are your thoughts about it? Have you thought about making
> >>>>> UFFDIO_WRITEPROTECT perform better?
> >>>>>
> >>>>> I'm sorry to mention the word "performance" here. Actually we want better
> >>>>> performance to emulate Windows syscall. That is why we are adding this
> >>>>> functionality. So either we need to see what can be improved in
> >>>>> UFFDIO_WRITEPROTECT or can I please add only PM_SCAN_OP_WP back in
> >>>>> pagemap_ioctl?
> >>>>
> >>>> I'm fine if you want to add it back if it works for you.  Though before
> >>>> that, could you remind me why there can be a difference on performance?
> >>> I've looked at the code again and I think I've found something. Lets look
> >>> at exact performance numbers:
> >>>
> >>> I've run 2 different tests. In first test UFFDIO_WRITEPROTECT is being used
> >>> for engaging WP. In second test PM_SCAN_OP_WP is being used. I've measured
> >>> the average write time to the same memory which is being WP-ed and total
> >>> time of execution of these APIs:
> > 
> > What is the steps of the test?  Is it as simple as "writeprotect",
> > "unprotect", then write all pages in a single thread?
> > 
> > Is UFFDIO_WRITEPROTECT sent in one range covering all pages?
> > 
> > Maybe you can attach the test program here too.
> 
> I'd not attached the test earlier as I thought that you wouldn't be
> interested in running the test. I've attached it now. The test has multiple

Thanks.  No plan to run it, just to make sure I understand why such a
difference.

> threads where one thread tries to get status of flags and reset them, while
> other threads write to that memory. In main(), we call the pagemap_scan
> ioctl to get status of flags and reset the memory area as well. While in N
> threads, the memory is written.
> 
> I usually run the test by following where memory area is of 100000 * pages:
> ./win2_linux 8 100000 1 1 0
> 
> I'm running tests on real hardware. The results are pretty consistent. I'm
> also testing only on x86_64. PM_SCAN_OP_WP wins every time as compared to
> UFFDIO_WRITEPROTECT.

If it's multi-threaded test especially when the ioctl runs together with
the writers, then I'd assume it's caused by writers frequently need to
flush tlb (when writes during UFFDIO_WRITEPROTECT), the flush target could
potentially also include the core running the main thread who is also
trying to reprotect because they run on the same mm.

This makes me think that your current test case probably is the worst case
of Nadav's patch 6ce64428d6 because (1) the UFFDIO_WRITEPROTECT covers a
super large range, and (2) there're a _lot_ of concurrent writers during
the ioctl, so all of them will need to trigger a tlb flush, and that tlb
flush will further slow down the ioctl sender.

While I think that's the optimal case sometimes, of having minimum tlb
flush on the ioctl(UFFDIO_WRITEPROTECT), so maybe it makes sense somewhere
else where concurrent writers are not that much. I'll need to rethink a bit
on all these to find out whether we can have a good way for both..

For now, if your workload is mostly exactly like your test case, maybe you
can have your pagemap version of WP-only op there, making sure tlb flush is
within the pgtable lock critical section (so you should be safe even
without Nadav's patch).  If so, I'd appreciate you can add some comment
somewhere about such difference of using pagemap WP-only and
ioctl(UFFDIO_WRITEPROTECT), though.  In short, functional-wise they should
be the same, but trivial detail difference on performance as TBD (maybe one
day we can have a good approach for all and make them aligned again, but
maybe that also doesn't need to block your work).

-- 
Peter Xu

