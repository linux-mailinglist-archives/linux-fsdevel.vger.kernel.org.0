Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1443F4A77EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 19:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241190AbiBBS2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 13:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiBBS2q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:28:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95560C061714;
        Wed,  2 Feb 2022 10:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DHt+NoiQ/xSDzcu85V4cS/XqDEmzCog6ySkjKbfn9Y4=; b=Pc3z+/fGMsWFz6LsSLIIQE5noH
        /S4+fwoYEH0STHqc5Vh9NnnAMQBL07imdXuFR+SlwylTbKodsNxhP1pZb3tp5bCXn19LzDITTKcxB
        cQlQhPLSrCxeywyWBe+ajFd4uB40UM3qdNMAPxmMDdvinodcuT+Ht9LsP5DYBK81MYUEaxV6oRQc4
        cNRR7p3wDwukXXid0UOM8DAEOUHQuQapC60F0vFAdw/vJyYkW1FjqtG4SxJXbUOrMRNYS/OdXxHNX
        r/94W6wRKoMP0UBjr26/YURhqnOfzagiNzzKT4gm1is+U63mxHPiwfmxyp6IyE0EMSZaMGJdCD3eU
        5AvLNsew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFKMk-00FbFv-Pl; Wed, 02 Feb 2022 18:28:26 +0000
Date:   Wed, 2 Feb 2022 18:28:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     dan.j.williams@intel.com, jack@suse.cz, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, apopple@nvidia.com, shy828301@gmail.com,
        rcampbell@nvidia.com, hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com
Subject: Re: [PATCH v2 3/6] mm: page_vma_mapped: support checking if a pfn is
 mapped into a vma
Message-ID: <YfrNSvttbQgLKKwj@casper.infradead.org>
References: <20220202143307.96282-1-songmuchun@bytedance.com>
 <20220202143307.96282-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202143307.96282-4-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 02, 2022 at 10:33:04PM +0800, Muchun Song wrote:
> page_vma_mapped_walk() is supposed to check if a page is mapped into a vma.
> However, not all page frames (e.g. PFN_DEV) have a associated struct page
> with it. There is going to be some duplicate codes similar with this function
> if someone want to check if a pfn (without a struct page) is mapped into a
> vma. So add support for checking if a pfn is mapped into a vma. In the next
> patch, the dax will use this new feature.

I'm coming to more or less the same solution for fixing the bug in
page_mapped_in_vma().  If you call it with a head page, it will look
for any page in the THP instead of the precise page.  I think we can do
a fairly significant simplification though, so I'm going to go off
and work on that next ...

