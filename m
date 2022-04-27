Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D26451242E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 22:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbiD0VCm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 17:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbiD0VCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:02:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3376C1083;
        Wed, 27 Apr 2022 13:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cQesnUHvsevqj8LCTS5dD+iCwEbXRZtgTgIlz/6PQHA=; b=dQ/6BATy3PF81w6PED0XHEp3gD
        kftx4U8C6qeWcvUH3ZKLbETVaFKpz7FcHnukq3jsRdRmXaJ3r/HcJdMVHGCtDtet9lICy7bFrw2CH
        7P1R4PbKuS2+j+Hu/UXuNt6L5qEW4K640a1xv6gaizmtryGaJn5dxYM6UZu+6WkxB1T79alvJLP17
        ytqPbxhBOxof5c40hsU7nvWGc2MJ/RMqKLBegO27btlO9otBrgkzXRjr1oM4NocCYa00HKxMMXUOh
        otBgFrlO6ytA+LZJDnD/9BidfUlhByUgAtaZ/npUnHuR6v7XK0bYK439224eqgIOHu6lLgiFau7Db
        Za00Ud2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njokM-00Atky-89; Wed, 27 Apr 2022 20:58:50 +0000
Date:   Wed, 27 Apr 2022 21:58:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>, Zi Yan <ziy@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 0/8] Make khugepaged collapse readonly FS THP more
 consistent
Message-ID: <YmmuivdOWcr46oNC@casper.infradead.org>
References: <20220404200250.321455-1-shy828301@gmail.com>
 <YkuKbMbSecBVsa1k@casper.infradead.org>
 <CAHbLzkoWPN+ahrvu2JrvoDpf8J_QGR6Ug6BbPnC11C82Lb-NaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoWPN+ahrvu2JrvoDpf8J_QGR6Ug6BbPnC11C82Lb-NaA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 04, 2022 at 05:48:49PM -0700, Yang Shi wrote:
> When khugepaged collapses file THPs, its behavior is not consistent.
> It is kind of "random luck" for khugepaged to see the file vmas (see
> report: https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/)
> since currently the vmas are registered to khugepaged when:
>   - Anon huge pmd page fault
>   - VMA merge
>   - MADV_HUGEPAGE
>   - Shmem mmap
> 
> If the above conditions are not met, even though khugepaged is enabled
> it won't see any file vma at all.  MADV_HUGEPAGE could be specified
> explicitly to tell khugepaged to collapse this area, but when
> khugepaged mode is "always" it should scan suitable vmas as long as
> VM_NOHUGEPAGE is not set.

I don't see that as being true at all.  The point of this hack was that
applications which really knew what they were doing could enable it.
It makes no sense to me that setting "always" by the sysadmin for shmem
also force-enables ROTHP, even for applications which aren't aware of it.

Most telling, I think, is that Song Liu hasn't weighed in on this at
all.  It's clearly not important to the original author.
