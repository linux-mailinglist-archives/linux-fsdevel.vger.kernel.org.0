Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBF52991B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784669AbgJZQCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 12:02:10 -0400
Received: from casper.infradead.org ([90.155.50.34]:44296 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773903AbgJZQCA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8TVIxK2IWHpuqHBc4eLrHU3NsRBpnzeQBP922ubxUsY=; b=ThBdvIzzZaCa3Dx9qeQ/RMuIrV
        YxcSthJvRwgK6//jhlniyzDTttj/bb1s0R7A+Non8lS7NnSx8n6JuV6djMUXUb5Drq2SX7GwZN+rC
        +nJ8RjYgn61A3WTyOF3MWyiowabi2n295+OwN+D6dWMMR8aym4aRViWY6Aas2S5AVh3PDBvKZjxtK
        w/Toe4KXEDwzlmkRoo6LllzoXnsFdGb6aajoewcbEwIvsSAEioTTR2rQBGT0+oftUAehBSQOyJo/Q
        WVkeKxrqyt0ZUub6POVvN636iIwGT5r/veP0bNScYarjIgtcz2G9sny8tSFKCAQsLgrELajFJWfAo
        E1pAQo7w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX4wI-0000Pc-Uy; Mon, 26 Oct 2020 16:01:43 +0000
Date:   Mon, 26 Oct 2020 16:01:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 07/19] mm/hugetlb: Free the vmemmap pages associated
 with each hugetlb page
Message-ID: <20201026160142.GT20115@casper.infradead.org>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
 <20201026145114.59424-8-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026145114.59424-8-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:51:02PM +0800, Muchun Song wrote:
> +static void split_vmemmap_pmd(pmd_t *pmd, pte_t *pte_p, unsigned long addr)
> +{
> +	struct mm_struct *mm = &init_mm;
> +	struct page *page;
> +	pmd_t old_pmd, _pmd;
> +	int i;
> +
> +	old_pmd = READ_ONCE(*pmd);
> +	page = pmd_page(old_pmd);
> +	pmd_populate_kernel(mm, &_pmd, pte_p);
> +
> +	for (i = 0; i < VMEMMAP_HPAGE_NR; i++, addr += PAGE_SIZE) {
> +		pte_t entry, *pte;
> +
> +		entry = mk_pte(page + i, PAGE_KERNEL);

I'd be happier if that were:

	pgprot_t pgprot = PAGE_KERNEL;
...
	for (i = 0; i < VMEMMAP_HPAGE_NR; i++, addr += PAGE_SIZE) {
		pte_t entry, *pte;

		entry = mk_pte(page + i, pgprot);
		pgprot = PAGE_KERNEL_RO;

so that all subsequent tail pages are mapped read-only.

