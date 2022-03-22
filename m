Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC844E3AC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 09:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiCVIjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 04:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiCVIjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:39:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD37F6AA4D;
        Tue, 22 Mar 2022 01:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dM4Devf9AxYRsJbry+GdljYWNC1RVwNRs/wmrQdV5X0=; b=F7D+qgEn0hYzxLExaBQdxlCTo7
        +Nzq36CHgpBmxsqxnHpmCLkzUrhOvePCCPAWtfbSGjKobx5cSHnL74IWm0cFRv8z+kJaFY0fDCbPD
        XmS2uP+/64IE9eeKEUHpwXN3RTN0Epc9SfCmR81EfmjgDaG6RdRPh4zbxoC4/kuEv/C+wS0KpGpof
        PllcHUQ46QDdKv/LYXQggc87GTszPdWrb5EEkEcVllPvuBFDNbdQzl7SzFECUcQ+XfE4qpFlCBV7X
        WFSz3lzoTDVpRPg+1VXBTlioMvfgERhyIoFAmmDcPo4TyCPy9aeGsKAZ06Kv2hUubDr5goafl6Lq8
        jPxEabuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWa1J-00ARWh-66; Tue, 22 Mar 2022 08:37:37 +0000
Date:   Tue, 22 Mar 2022 01:37:37 -0700
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
Subject: Re: [PATCH v5 5/6] dax: fix missing writeprotect the pte entry
Message-ID: <YjmK0aaCu/FI/t7T@infradead.org>
References: <20220318074529.5261-1-songmuchun@bytedance.com>
 <20220318074529.5261-6-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318074529.5261-6-songmuchun@bytedance.com>
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

> +static void dax_entry_mkclean(struct address_space *mapping, unsigned long pfn,
> +			      unsigned long npfn, pgoff_t start)
>  {
>  	struct vm_area_struct *vma;
> +	pgoff_t end = start + npfn - 1;
>  
>  	i_mmap_lock_read(mapping);
> +	vma_interval_tree_foreach(vma, &mapping->i_mmap, start, end) {
> +		pfn_mkclean_range(pfn, npfn, start, vma);
>  		cond_resched();
>  	}
>  	i_mmap_unlock_read(mapping);


Is there any point in even keeping this helper vs just open coding it
in the only caller below?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
