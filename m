Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EBB615F56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 10:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiKBJPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 05:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiKBJOe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:14:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0D427143
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N5xkihfiIAm5OQbHmLx0EWGK5BIbM+DxZNz/QBUlxYg=; b=RtVNh1IE7sd1+/zLX57ev7rqZQ
        gVZ5mlxmRsrC7toNkpdi+jHHFmoWz5vyLbS5hXLhndtcdZqC66ilROfwmJrueCBTFho4FJQM1Pxxp
        OtlnmSC3Gla2lOz4F0WkxwwUSYae0RyisqXje7O5IXJAHn/YM3hdYuBPAK+DK5tZIM9SLop6GfjzT
        V3JxCqkp1qdWBuYNwR0WDkV4sSXPwXK9zhmrZp2iGbPo3Yesop8LDpIZ7A5U3D8Law2NqZ6klulCe
        qjeIAmssBKxK/FC8ydKQP8o9QK4D+Y7OCyF4Aq+udQaV5EuEEgRU/Wdvj7ocZsZcn2T0kxzm7o/e3
        Fxuyi3sA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oq9oA-00A4D2-6z; Wed, 02 Nov 2022 09:13:14 +0000
Date:   Wed, 2 Nov 2022 02:13:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Uladzislau Rezki <urezki@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2 2/2] mm: Add folio_map_local()
Message-ID: <Y2I0qiQaSHyL3kqW@infradead.org>
References: <20221101201828.1170455-1-willy@infradead.org>
 <20221101201828.1170455-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101201828.1170455-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +void *vm_map_folio(struct folio *folio)
> +{
> +	size_t size = folio_size(folio);
> +	void *mem = vmap_alloc(size, NUMA_NO_NODE);

Needs an error check here.

> +	mem = kasan_unpoison_vmalloc(mem, size, KASAN_VMALLOC_PROT_NORMAL);
> +
> +	return mem;

Why not:

	return kasan_unpoison_vmalloc(mem, size, KASAN_VMALLOC_PROT_NORMAL);

> +EXPORT_SYMBOL(vm_map_folio);

All new vmalloc/vmap functionality should be EXPORT_SYMBOL_GPL.
