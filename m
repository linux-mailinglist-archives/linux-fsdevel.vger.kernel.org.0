Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2546C615F19
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 10:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiKBJM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 05:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiKBJLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:11:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D184286F6
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 02:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/89QMp6WjlwuYcBf8tvrD9DBEoepLSCyiJfq47hf0fU=; b=lRKhOcDHq1EWvuQCrx/g/CfZuM
        OwDe5lOPfYjNI6eSlcOq3zg8vGqkvn4ZIM/Dwi9yKWWqp/6frGkfiy1MGh1P3gF138eLifyKq11M9
        fXPi0ejr+ZlHUeKaS9SNfYKP2A0y9olm6uhZvbIdNDUj4Fbp3robjU0D0HwJ8MsOQznO4Gpcvp20I
        Ut7DgigE2VAfJva9fWQa0HShwmbVr/heVOx7/ode0yEWGgSTyEZn98p9uag0ISldeNeeIin7BXizP
        j4mQgfOQ9mQFJg76j3C3GVfl1xe/VjxFhO4S9V0HJLp5gAYq7IvTxiWr87AyEuzHmrzXFowu+VAVd
        x9qzHunA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oq9lj-009vF7-U3; Wed, 02 Nov 2022 09:10:43 +0000
Date:   Wed, 2 Nov 2022 02:10:43 -0700
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
Subject: Re: [PATCH v2 1/2] vmalloc: Factor vmap_alloc() out of vm_map_ram()
Message-ID: <Y2I0E/cpHQK9iuCS@infradead.org>
References: <20221101201828.1170455-1-willy@infradead.org>
 <20221101201828.1170455-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101201828.1170455-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 08:18:27PM +0000, Matthew Wilcox (Oracle) wrote:
> Introduce vmap_alloc() to simply get the address space.  This allows
> for code sharing in the next patch.
> 
> Suggested-by: Uladzislau Rezki <urezki@gmail.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/vmalloc.c | 41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ccaa461998f3..dcab1d3cf185 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2230,6 +2230,27 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  }
>  EXPORT_SYMBOL(vm_unmap_ram);
>  
> +static void *vmap_alloc(size_t size, int node)
> +{
> +	void *mem;
> +
> +	if (likely(size <= (VMAP_MAX_ALLOC * PAGE_SIZE))) {
> +		mem = vb_alloc(size, GFP_KERNEL);
> +		if (IS_ERR(mem))
> +			mem = NULL;
> +	} else {
> +		struct vmap_area *va;
> +		va = alloc_vmap_area(size, PAGE_SIZE,
> +				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
> +		if (IS_ERR(va))
> +			mem = NULL;
> +		else
> +			mem = (void *)va->va_start;
> +	}
> +
> +	return mem;

This reads really strange, why not return the ERR_PTR and do:

static void *vmap_alloc(size_t size, int node)
{
	if (unlikely(size > VMAP_MAX_ALLOC * PAGE_SIZE)) {
		struct vmap_area *va;

		va = alloc_vmap_area(size, PAGE_SIZE, VMALLOC_START,
				     VMALLOC_END, node, GFP_KERNEL);
		if (IS_ERR(va))
			return ERR_CAST(va);
		return (void *)va->va_start;
	}

	return vb_alloc(size, GFP_KERNEL);
}

> @@ -2247,24 +2268,8 @@ EXPORT_SYMBOL(vm_unmap_ram);
>  void *vm_map_ram(struct page **pages, unsigned int count, int node)
>  {
>  	unsigned long size = (unsigned long)count << PAGE_SHIFT;
> +	void *mem = vmap_alloc(size, node);
> +	unsigned long addr = (unsigned long)mem;

And here we still need the error check anyway, no matter if it is for
NULL or an ERR_PTR.
