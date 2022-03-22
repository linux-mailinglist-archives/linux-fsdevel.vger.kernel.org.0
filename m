Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C2B4E3AB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 09:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiCVIgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 04:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiCVIgC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:36:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2391D48312;
        Tue, 22 Mar 2022 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bK/bRjCsilG76Zx9QpWZl8IsADdDvzITYegWrnMZgG0=; b=gE2vwGiPaE3Z2US+L37e/vcT2p
        rHT9WE4N73NfIlMrU8r8c4AaKabWtlJ50gnKyY1mhXEYAUTNLLhjj+HPiso+4RmMhnat95t3cNiA2
        6aQZXw1bIzH3CG0CVnJpDUewhqu6ZZaN/8A1Jlg3I1hEuyoz+u2bVru4NstDMT2Jt6ayxtR5lzrQJ
        ALLBwtWUrna/ZifwObcrzMwXWMnKajr1BwhefRL8t63QbkrVvVc654Bgoc9RyKkShKAQnPFHrVGb7
        0Qor9R86d4qZWpuF2rNU2ZbzPX5Jd7AmRsBRxGsnGq2ezTnMvieMFT1lRZGNp1kblipiyEsXqxUIE
        zgqbGdcA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWZyC-00AQxs-Q8; Tue, 22 Mar 2022 08:34:24 +0000
Date:   Tue, 22 Mar 2022 01:34:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v5 2/6] dax: fix cache flush on PMD-mapped pages
Message-ID: <YjmKEEK3fz8a93iN@infradead.org>
References: <20220318074529.5261-1-songmuchun@bytedance.com>
 <20220318074529.5261-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318074529.5261-3-songmuchun@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 18, 2022 at 03:45:25PM +0800, Muchun Song wrote:
> The flush_cache_page() only remove a PAGE_SIZE sized range from the cache.
> However, it does not cover the full pages in a THP except a head page.
> Replace it with flush_cache_range() to fix this issue.  This is just a
> documentation issue with the respect to properly documenting the expected
> usage of cache flushing before modifying the pmd.  However, in practice
> this is not a problem due to the fact that DAX is not available on
> architectures with virtually indexed caches per:
> 
>   commit d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> 
> Fixes: f729c8c9b24f ("dax: wrprotect pmd_t in dax_mapping_entry_mkclean")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
