Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E0D51EF5E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 21:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbiEHSBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 14:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbiEHRM1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 13:12:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3B3B7EC;
        Sun,  8 May 2022 10:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rCdXSvZjp6F8gmuuM1Bzn/n/1RjrsEENuke5qJWo6Ik=; b=ZITLMC7DKkB4Trwc7bNWRzlWiR
        uT0nYzvCip831JpgQyklirM6W5ZtBvwI/rbUgZG25OXn37GktTQvcDVwZvekFIFN3RlwQjbeMxQNZ
        t8svRibUKtQ5pSma7ZHwD4rhYKKSKUMuCXUudxB/lKBTjcYTiXuIP90H0LBavuHykOSLAYZBR0n+N
        xlbmj9fmytKxcHJHrhHJQrB6rfhARHN0rdqB7mMnuDA1ZrH+oqN64jvGi1P+6adiJ4DRVajMHBRqD
        xcUx+jC59ig3ERAVQ/K3bOHlarpWldz6ZU9Jf6bS+1+KW5lZVKfkttKna9E0jBro6nPjtg4Fm6//P
        zy6sUqmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnkOI-002foo-RN; Sun, 08 May 2022 17:08:18 +0000
Date:   Sun, 8 May 2022 18:08:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        mike.kravetz@oracle.com, akpm@linux-foundation.org, sj@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/3] Introduce new huge_ptep_get_access_flags()
 interface
Message-ID: <Ynf5Aje8FXlPdOSl@casper.infradead.org>
References: <cover.1651998586.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651998586.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 08, 2022 at 04:58:51PM +0800, Baolin Wang wrote:
> As Mike pointed out [1], the huge_ptep_get() will only return one specific
> pte value for the CONT-PTE or CONT-PMD size hugetlb on ARM64 system, which
> will not take into account the subpages' dirty or young bits of a CONT-PTE/PMD
> size hugetlb page. That will make us miss dirty or young flags of a CONT-PTE/PMD
> size hugetlb page for those functions that want to check the dirty or
> young flags of a hugetlb page. For example, the gather_hugetlb_stats() will
> get inaccurate dirty hugetlb page statistics, and the DAMON for hugetlb monitoring
> will also get inaccurate access statistics.
> 
> To fix this issue, one approach is that we can define an ARM64 specific huge_ptep_get()
> implementation, which will take into account any subpages' dirty or young bits.
> However we should add a new parameter for ARM64 specific huge_ptep_get() to check
> how many continuous PTEs or PMDs in this CONT-PTE/PMD size hugetlb, that means we
> should convert all the places using huge_ptep_get(), meanwhile most places using
> huge_ptep_get() did not care about the dirty or young flags at all.
> 
> So instead of changing the prototype of huge_ptep_get(), this patch set introduces
> a new huge_ptep_get_access_flags() interface and define an ARM64 specific implementation,
> that will take into account any subpages' dirty or young bits for CONT-PTE/PMD size
> hugetlb page. And we can only change to use huge_ptep_get_access_flags() for those
> functions that care about the dirty or young flags of a hugetlb page.

I question whether this is the right approach.  I understand that
different hardware implementations have different requirements here,
but at least one that I'm aware of (AMD Zen 2/3) requires that all
PTEs that are part of a contig PTE must have identical A/D bits.  Now,
you could say that's irrelevant because it's x86 and we don't currently
support contPTE on x86, but I wouldn't be surprised to see that other
hardware has the same requirement.

So what if we make that a Linux requirement?  Setting a contPTE dirty or
accessed becomes a bit more expensive (although still one/two cachelines,
so not really much more expensive than a single write).  Then there's no
need to change the "get" side of things because they're always identical.

It does mean that we can't take advantage of hardware setting A/D bits,
unless hardware can be persuaded to behave this way.  I don't have any
ARM specs in front of me to check.

I don't have a hard objection to your approach, I just want to discuss
other possibilities.
