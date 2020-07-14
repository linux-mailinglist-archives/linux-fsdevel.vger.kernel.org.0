Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F5221EBAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 10:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgGNIpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 04:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgGNIpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:45:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268A0C061755;
        Tue, 14 Jul 2020 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yz4S4Ytxc1CzMw+qlvTi368donhX7MGtt2Akp1rQQ7Q=; b=nhtQVEUsKRiyabz5JvvGecobru
        nP8xGVVLoy5AyzJ5zGQu3dh5+dS9t2Uh/loFIeYYusdcKOAEa644zegzH+PnASDEKp9NN/liFG8aw
        xw8XCHC0tEZRdg6F9ZAsVzrQdOlikd/HuO5qANFw9yvqljFf9qcf673svzla/SooTOzwJDbWy6AX7
        xbqGsKjQXdO956rc/SN1lldHbmIbje0c8OsnyqyFVEpsSFt7jfBNV6zhErXOXcKAUsl4N9Q4/cojz
        xANcGXBQHG0L+CD2pGC0z8pCkxwhImKF68ZTUcoh/hVzduX4xqA4tlQxQnv5RpbX0Zq6FapUFQnSA
        oUFXN5Fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvGYW-0000Ii-T5; Tue, 14 Jul 2020 08:44:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E529C300130;
        Tue, 14 Jul 2020 10:44:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D175128B91073; Tue, 14 Jul 2020 10:44:51 +0200 (CEST)
Date:   Tue, 14 Jul 2020 10:44:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     ira.weiny@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 12/15] kmap: Add stray write protection for device
 pages
Message-ID: <20200714084451.GQ10769@hirez.programming.kicks-ass.net>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-13-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714070220.3500839-13-ira.weiny@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:02:17AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Device managed pages may have additional protections.  These protections
> need to be removed prior to valid use by kernel users.
> 
> Check for special treatment of device managed pages in kmap and take
> action if needed.  We use kmap as an interface for generic kernel code
> because under normal circumstances it would be a bug for general kernel
> code to not use kmap prior to accessing kernel memory.  Therefore, this
> should allow any valid kernel users to seamlessly use these pages
> without issues.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  include/linux/highmem.h | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index d6e82e3de027..7f809d8d5a94 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -8,6 +8,7 @@
>  #include <linux/mm.h>
>  #include <linux/uaccess.h>
>  #include <linux/hardirq.h>
> +#include <linux/memremap.h>
>  
>  #include <asm/cacheflush.h>
>  
> @@ -31,6 +32,20 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
>  
>  #include <asm/kmap_types.h>
>  
> +static inline void enable_access(struct page *page)
> +{
> +	if (!page_is_access_protected(page))
> +		return;
> +	dev_access_enable();
> +}
> +
> +static inline void disable_access(struct page *page)
> +{
> +	if (!page_is_access_protected(page))
> +		return;
> +	dev_access_disable();
> +}

So, if I followed along correctly, you're proposing to do a WRMSR per
k{,un}map{_atomic}(), sounds like excellent performance all-round :-(
