Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6C73746FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 19:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbhEERgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:36:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:45348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237508AbhEERek (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:34:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09265AD8A;
        Wed,  5 May 2021 17:33:36 +0000 (UTC)
Subject: Re: [PATCH v9 08/96] mm: Fix struct page layout on 32-bit systems
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <20210505150628.111735-1-willy@infradead.org>
 <20210505150628.111735-9-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e676d72e-b09d-d9d8-81e5-57a7a35aa310@suse.cz>
Date:   Wed, 5 May 2021 19:33:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210505150628.111735-9-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/5/21 5:05 PM, Matthew Wilcox (Oracle) wrote:
> 32-bit architectures which expect 8-byte alignment for 8-byte integers
> and need 64-bit DMA addresses (arm, mips, ppc) had their struct page
> inadvertently expanded in 2019.  When the dma_addr_t was added, it forced
> the alignment of the union to 8 bytes, which inserted a 4 byte gap between
> 'flags' and the union.
> 
> Fix this by storing the dma_addr_t in one or two adjacent unsigned longs.
> This restores the alignment to that of an unsigned long.  We always
> store the low bits in the first word to prevent the PageTail bit from
> being inadvertently set on a big endian platform.  If that happened,
> get_user_pages_fast() racing against a page which was freed and
> reallocated to the page_pool could dereference a bogus compound_head(),
> which would be hard to trace back to this cause.
> 
> Fixes: c25fff7171be ("mm: add dma_addr_t to struct page")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

