Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD5A4979B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 08:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbiAXHlz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 02:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiAXHly (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:41:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4294C06173B;
        Sun, 23 Jan 2022 23:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z1SKDv0bpVZtdYt8dV9PbGHjlVKjS9CGxhne7lpfIKs=; b=HDx06FnTRYyxKVIj4EE9rnXWHR
        oiX3X8ki7OsTBxHU1B468OnIK+t4wbC2mMm+eTg1RE1Izzbtpqk0hEtjppLoUoqXaQVd41SRDycBE
        o+BiRhtMnaVtuAO9mTsT5Co0aSry0x+9DqkE+zoKL2SJg1Kj0UBTHJneqpktcKNdpv0TAw5ehKiou
        Zvhgb22eFOr37nP7j4O8ajg6sgJPLGl8n/kzGFjYxVHF4iJ33mXda1kT1rFtYgKBhc2dB9e4yj5nQ
        +9Nqr1bFfaONIt0aAIpaYOmF+m8p/jHzpk5Z1axhAkUP4gIhwWaHwb2f/zHoww7EzcNMzYFJiZKGi
        qKbQdIww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBtyv-002VxD-Ad; Mon, 24 Jan 2022 07:41:41 +0000
Date:   Sun, 23 Jan 2022 23:41:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/5] dax: fix missing writeprotect the pte entry
Message-ID: <Ye5YNbBbVymwfPB0@infradead.org>
References: <20220121075515.79311-1-songmuchun@bytedance.com>
 <20220121075515.79311-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121075515.79311-4-songmuchun@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 21, 2022 at 03:55:14PM +0800, Muchun Song wrote:
> Reuse some infrastructure of page_mkclean_one() to let DAX can handle
> similar case to fix this issue.

Can you split out some of the infrastructure changes into proper
well-documented preparation patches?

> +	pgoff_t pgoff_end = pgoff_start + npfn - 1;
>  
>  	i_mmap_lock_read(mapping);
> -	vma_interval_tree_foreach(vma, &mapping->i_mmap, index, index) {
> -		struct mmu_notifier_range range;
> -		unsigned long address;
> -
> +	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff_start, pgoff_end) {

Please avoid the overly long lines here.  Just using start and end
might be an easy option.

