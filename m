Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FB24DE15B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 19:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbiCRSuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 14:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbiCRSuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:50:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72163220FC;
        Fri, 18 Mar 2022 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DELhSJBPZGfDBsWOFD3hh/9WKqk4TqD5Ijyu+KpKTXo=; b=n2J/zIERaaXYlpHf3zgcUq7dVQ
        fRQDMCLt3OOvI6c3+1cZL8tLSZnMum46u3H6dVQ+bTfDnc1f+LdOSYur9428k52HcB1aRersuyd85
        HN/AGurfzwqNzYlC+Iig/gMAQhKHuqUXMGm8ckmmj+ZvpIZ20Z/C8TP1gqQBXokhygwtm1jvmEQiV
        +VaHe+JoZZiIIk8ACUQgxFBWRkr0SbTox2eZb8yhmuNZc/yEhLHDHTDqMk0xA/I/quP/puvy68VmX
        zJ8Upi26DD7IxyonDfdGj63fdLsavSotncQXimFfKl+Hq/xeZQBm1dLPfoTN4u7isMg2BNkKv8ctd
        3bkwU46Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVHds-008CVS-SX; Fri, 18 Mar 2022 18:48:04 +0000
Date:   Fri, 18 Mar 2022 18:48:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        songliubraving@fb.com, riel@surriel.com, ziy@nvidia.com,
        akpm@linux-foundation.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        darrick.wong@oracle.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 0/8] Make khugepaged collapse readonly FS THP more
 consistent
Message-ID: <YjTT5Meqdn8fiuC2@casper.infradead.org>
References: <20220317234827.447799-1-shy828301@gmail.com>
 <20220318012948.GE1544202@dread.disaster.area>
 <YjP+oyoT9Y2SFt8L@casper.infradead.org>
 <CAHbLzkonVj63+up4-BCPm29yjaf_29asMFJHpXiZp96UjGGNSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkonVj63+up4-BCPm29yjaf_29asMFJHpXiZp96UjGGNSg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 18, 2022 at 11:04:29AM -0700, Yang Shi wrote:
> I agree once page cache huge page is fully supported,
> READ_ONLY_THP_FOR_FS could be deprecated. But actually this patchset
> makes khugepaged collapse file THP more consistently. It guarantees
> the THP could be collapsed as long as file THP is supported and
> configured properly and there is suitable file vmas, it is not
> guaranteed by the current code. So it should be useful even though
> READ_ONLY_THP_FOR_FS is gone IMHO.

I don't know if it's a good thing or not.  Experiments with 64k
PAGE_SIZE on arm64 shows some benchmarks improving and others regressing.
Just because we _can_ collapse a 2MB range of pages into a single 2MB
page doesn't mean we _should_.  I suspect the right size folio for any
given file will depend on the access pattern.  For example, dirtying a
few bytes in a folio will result in the entire folio being written back.
Is that what you want?  Maybe!  It may prompt the filesystem to defragment
that range, which would be good.  On the other hand, if you're bandwidth
limited, it may decrease your performance.  And if your media has limited
write endurance, it may result in your drive wearing out more quickly.

Changing the heuristics should come with data.  Preferably from a wide
range of systems and use cases.  I know that's hard to do, but how else
can we proceed?

And I think you ignored my point that READ_ONLY_THP_FOR_FS required
no changes to filesystems.  It was completely invisible to them, by
design.  Now this patchset requires each filesystem to do something.
That's not a great step.

P.S. khugepaged currently does nothing if a range contains a compound
page.  It assumes that the page is compound because it's now a THP.
Large folios break that assumption, so khugepaged will now never
collapse a range which includes large folios.  Thanks to commit
    mm/filemap: Support VM_HUGEPAGE for file mappings
we'll always try to bring in PMD-sized pages for MADV_HUGEPAGE, so
it _probably_ doesn't matter.  But it's something we should watch
for as filesystems grow support for large folios.
